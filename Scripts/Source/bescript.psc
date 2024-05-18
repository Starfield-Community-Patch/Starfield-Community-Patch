ScriptName BEScript Extends Quest
{ Standard script for Boarding Encounter quests. }

;-- Structs -----------------------------------------
Struct GenericCrewDatum
  ActorBase CrewActor
  { The Actor to spawn. }
  Float ActorLevelModChanceEasy = 0.5
  { Default=0.5. Chance the actor's aiLevelMod will be 0, Easy. }
  Float ActorLevelModChanceMedium = 0.400000006
  { Default=0.4. Chance the actor's aiLevelMod will be 1, Medium. If not Easy or Medium, the actor will be 2, Hard. }
  Int InstancesToSpawn = -1
  { Default=-1 (Unlimited). The maximum number of instances of this actor to spawn on this ship. }
EndStruct

Struct ModuleDatum
  ObjectReference moduleRef
  ObjectReference shipCrewSpawnMarkerRef01
  ObjectReference shipCrewSpawnMarkerRef02
  ObjectReference shipCrewSpawnMarkerRef03
  ObjectReference shipCrewSpawnMarkerRef04
  ObjectReference shipCrewSpawnMarkerRef05
  ObjectReference shipTurretSpawnMarkerRef01
  ObjectReference shipTurretSpawnMarkerRef02
  ObjectReference shipTurretSpawnMarkerRef03
  ObjectReference shipTurretSpawnMarkerRef04
  ObjectReference shipTurretSpawnMarkerRef05
  ObjectReference shipComputerRef
EndStruct


;-- Variables ---------------------------------------
Actor[] BEAliasCorpses
Int CONST_Aggression_VeryAggressive = 2 Const
Int CONST_BEObjective_KillEnemyCrewObj = 20 Const
Int CONST_BEObjective_LeaveShip = 255 Const
Int CONST_BEObjective_Startup = 10 Const
Int CONST_BEObjective_TakeOverEnemyShipObj = 30 Const
Float CONST_BoardingUpdateTimerDelay = 4.0 Const
Int CONST_BoardingUpdateTimerID = 1 Const
Int CONST_Confidence_Foolhardy = 4 Const
Int CONST_LockLevel_Inaccessible = 254 Const
Int CONST_Suspicious_DetectedActor = 2 Const
Float CONST_TakeoffUpdateTimerDelay = 2.0 Const
Int CONST_TakeoffUpdateTimerID = 2 Const
Int CONST_WaitUntilInitializedTimeoutDelay = 120 Const
Actor[] HeatLeeches
Bool ShouldLandingRampsBeOpenOnLoad
ObjectReference[] allCrewSpawnPoints
Float crewSizePercent
Int crewSuspiciousState
Bool disembarkersShouldHaveWeaponsUnequipped
Cell enemyShipCell
ObjectReference enemyShipCockpit
Faction enemyShipCrimeFaction
ObjectReference enemyShipHazard
Location enemyShipInteriorLoc
spaceshipreference enemyShipRef
Int genericCrewSize
Bool hasFinishedSetupDisembarking
Bool hasInitialized
Bool hasPlayerBoardedEnemyShip
Bool hasSetupDisembarking
Bool hasSpawnedCaptain
Bool hasStartedDisembarking
Bool isDropshipEncounter
Bool isReadyForTakeoff
Bool isSurfaceEncounter
Int maxSimultaneousBoarders
bescript:moduledatum[] moduleData
Actor player
ObjectReference playerShipCockpitRef
ObjectReference playerShipDockingDoorRef
Location playerShipInteriorLoc
ObjectReference[] playerShipModulesAllRefs
spaceshipreference playerShipRef
Actor[] potentialBoarders
Actor[] remainingBoarders
Actor[] robots
Bool shouldAbortBoarding
Bool shouldShutdownOnTakeoff
Actor[] turrets

;-- Guards ------------------------------------------
;*** WARNING: Guard declaration syntax is EXPERIMENTAL, subject to change
Guard BECrewGuard
Guard DisembarkingGuard
Guard SpaceshipCrewDecrementGuard

;-- Properties --------------------------------------
Group QuestProperties collapsedonbase
  Bool Property ShutDownOnUndock = False Auto
  { DEFAULT=False. Should this quest shut down when the target ship undocks?
	This should be FALSE for most Boarding Encounters-- you want the quest to continue to run until the target ship unloads. Otherwise, if you undock, then re-dock, a new and potentially different Boarding Encounter will start. }
  Bool Property ShutDownOnUnload = True Auto
  { DEFAULT=True. Should this quest shut down when the target ship unloads?
	This should be TRUE for most Boarding Encounters-- you want the quest to shut down when the target ship unloads so it and the target ship can be cleaned up. }
  Bool Property ShutDownOnTakeover = True Auto
  { DEFAULT=True. Should this quest shut down if the player takes over the enemy ship?
	This should be TRUE for most Boarding Encounters-- the encounter should not remain active once a player has taken over the ship. }
  Int Property StageToSetOnBoarding = -1 Auto Const
  { DEFAULT=-1. If >=0, stage to set when the player boards the enemy ship for the first time. }
  Int Property StageToSetWhenAllCrewDead = -1 Auto Const
  { Default=-1. If >=0, stage to set when all of the enemy ship's crew has been killed. }
EndGroup

Group CrewProperties
  Bool Property ShouldCrewStartInCombat = True Auto Const
  { DEFAULT=True. Is this a hostile boarding encounter?
	If True, the crew will start in the Suspicious state, and Companions will play a combat-oriented line when boarding the enemy ship. Does not apply to Surface Encounters. }
  Bool Property ShouldSpawnCrew = True Auto Const
  { DEFAULT=True. Should this BE spawn generic crew ? }
  Bool Property ShouldSpawnCaptain = True Auto Const
  { DEFAULT=True. Should this BE spawn a generic captain? }
  bescript:genericcrewdatum Property CaptainData Auto
  { When a BE spawns its generic crew, if at least one actor is alive (SpaceshipCrew actor value >= 1, adjusted by any mods below), and ShouldSpawnCaptain=True,
	the first actor to be spawned will be this Captain. One and only one Captain is spawned (InstancesToSpawn will be ignored).
	The Captain will be added to the AllCrew, GenericCrew, and Captain aliases. }
  bescript:genericcrewdatum[] Property CrewData Auto
  { When a BE spawns its generic crew, it determines how many slots it has to fill based on the SpaceshipCrew actor value (and any mods below), then cycles
	through CrewData until it's spawned the required number of actors, or until it runs out of actors it can spawn.
	Crew are added to the AllCrew and GenericCrew aliases. }
  Float Property CrewCountPercent = 1.0 Auto Const
  { DEFAULT=1.0. Multiply SpaceshipCrew by this value before spawning crew. Use 0.5 if you want half the normal crew, etc.
	NOTE: The SpaceshipCrew count is visible to players during space battles, so you should only modify this for surface encounters or very unusual space encounters,
	since players will be expecting a specific number of enemies. }
  Int Property CrewCountOverride = -1 Auto Const
  { OPTIONAL, DEFAULT=-1. If >=0, set the number of crew members to spawn to this value. If set, CrewCountMod and the SpaceshipCrew actor value are ignored.
	NOTE: The SpaceshipCrew count is visible to players during space battles, so you should only modify this for surface encounters or very unusual space encounters,
	since players will be expecting a specific number of enemies. }
  Int Property CrewSpawnPattern = 1 Auto Const
  { DEFAULT=1. When spawning generic crew, what pattern should we spawn them in?
	0=FILL. Select a module, fill all of its spawn points, move on to the next module, repeat.
	1=HALF FILL. Select a module, fill half of its spawn points, move on to the next module, repeat. Spawn excess crew randomly.
	2=SPREAD. Select a module, fill one spawn point in it, move on to the next module, repeat. Spawn excess crew randomly.
	3=RANDOM. Select spawn points completely at random. }
  Bool Property ShouldSpawnCorpses = True Auto Const
  { DEFAULT=True. Should this BE spawn generic corpses? }
  bescript:genericcrewdatum[] Property CorpseData Auto
  { OPTIONAL. When a BE spawns its generic crew corpses, it determines how many slots it has to fill based on the SpaceshipCrew actor value (Max-Current)(and any mods below),
	then cycles through CrewCorpseData (if any) until it's spawned the required number of actors, or runs out of actors it can spawn.
	If CrewCorpseData=None, it just continues using the remaining actors in CrewData. }
  Float Property CorpseCountPercent = 1.0 Auto Const
  { DEFAULT=1.0. Multiply the number of corpses to spawn CorpseCountPercent before spawning corpses.
	Use 0.5 if you want half the normal number of corpses, etc. }
  Int Property CorpseCountOverride = -1 Auto Const
  { OPTIONAL; DEFAULT=-1. If >=0, set the number of crew corpses to spawn to this value. If set, CorpseCountMod and the SpaceshipCrew actor value are ignored. }
  Int Property CorpseSpawnPattern = 0 Auto Const
  { DEFAULT=1. When spawning crew corpses, what pattern should we spawn them in?
	0=FILL. Select a module, fill all of its spawn points, move on to the next module, repeat.
	1=HALF FILL. Select a module, fill half of its spawn points, move on to the next module, repeat. Spawn excess crew randomly.
	2=SPREAD. Select a module, fill one spawn point in it, move on to the next module, repeat. Spawn excess crew randomly.
	3=RANDOM. Select spawn points completely at random. }
EndGroup

Group TurretProperties collapsedonbase
  Float Property TurretSpawnChance = 0.0 Auto Const
  { DEFAULT=0. Chance that this BE will spawn turrets at all; 0=Never, 1=Always, 0.5=Half the time. }
  Float Property TurretModulePercentChance = 0.5 Auto Const
  { Default=0.5. If this ship has turrets, what percentage of modules should have them?
	The actual number of turrets in each module will be randomly selected between the Min and Max values for that size of module. }
  bescript:genericcrewdatum Property TurretData Auto Const
  { If this ship has turrets, the data for the turrets to spawn. }
  Int Property TurretsToSpawnMin_Small = 1 Auto Const
  { DEFAULT=1. Min turrets to spawn in a Small module that we select to have turrets. }
  Int Property TurretsToSpawnMax_Small = 1 Auto Const
  { DEFAULT=1. Min turrets to spawn in a Small module that we select to have turrets. }
  Int Property TurretsToSpawnMin_Large = 2 Auto Const
  { DEFAULT=1. Min turrets to spawn in a Small module that we select to have turrets. }
  Int Property TurretsToSpawnMax_Large = 3 Auto Const
  { DEFAULT=1. Min turrets to spawn in a Small module that we select to have turrets. }
  Bool Property ShouldTurretsStartUnconscious = False Auto Const
  { DEFAULT=False. If True, spawned turrets will be set unconscious. }
  Bool Property ShouldTurretsStartFriendlyToPlayer = False Auto Const
  { DEFAULT=False. If True, spawned turrets will be set friendly to the player. }
EndGroup

Group ComputerProperties collapsedonbase
  Float Property GenericComputersEnableChance = 1.0 Auto Const
  { DEFAULT=0. Chance that this BE will enable generic computers if robots and/or turrets have spawned.
	0=Never, 1=Always, 0.5=Half the time. }
  Float Property GenericComputersModulePercentChance = 0.25 Auto Const
  { DEFAULT=0.5. If we're enabling generic computers, what percentage of modules should have them? }
  Int Property GenericComputersMax = -1 Auto Const
  { DEFAULT=-1. Maximum number of generic computers to enable. (-1 for no cap.) }
  Int Property GenericComputerRobotLinkStatus = 0 Auto Const
  { DEFAULT=0. Which Computers should get LinkTerminalRobot links to control their robots?
	0=All Computers
	1=Cockpit Computer Only
	2=No Computers }
  Int Property GenericComputerTurretLinkStatus = 0 Auto Const
  { DEFAULT=0. Which Computers should get LinkTerminalTurret links to control their robots?
	0=All Computers
	1=Cockpit Computer Only
	2=No Computers }
  Bool Property ForceEnableCockpitComputer = False Auto Const
  { DEFAULT=False. If True, absolutely always enable the computer in the cockpit. }
  Bool Property ForceEnableGenericComputers = False Auto Const
  { DEFAULT=False. If True, always enable generic computers, even if we don't have any robots or turrets
	to link them to. Any BE setting this to True is responsible for making sure they have content. }
  Bool Property ShouldEnableGenericComputerCockpit = True Auto Const
  { DEFAULT=True. If we're enabling Generic Computers, should we always enable the cockpit computer? }
  Bool Property ShouldPreferGenericComputerThematicModules = True Auto Const
  { DEFAULT=True. If we're enabling Generic Computers, should we always prefer computers in Computer Core
	and Engineering-themed modules, all other restrictions permitting? }
  Float Property GenericComputerLockPercentChance_Cockpit = 0.0 Auto Const
  { DEFAULT=0.0. Chance that the cockpit's generic computer is locked. }
  Float Property GenericComputerLockPercentChance_General = 0.5 Auto Const
  { DEFAULT=0.5. Chance that any other generic computer is locked. }
  Float Property GenericComputerLinkedContainerLockPercentChance = 1.0 Auto Const
  { DEFAULT=1.0. Additional chance that a generic computer's linked container will be locked.
	This is on top of the base chance of locking any given container, and uses the container min and max lock levels. }
  Int Property GenericComputerLockLevelMin = 1 Auto Const
  { DEFAULT=1. Minimum lock level for generic computers we decide to lock. (1=Novice, 2=Advanced, 3=Expert, 4=Master) }
  Int Property GenericComputerLockLevelMax = 2 Auto Const
  { DEFAULT=4. Maximum lock level for generic computers we decide to lock. (1=Novice, 2=Advanced, 3=Expert, 4=Master) }
EndGroup

Group ShipProperties collapsedonbase
  Bool Property ShouldSupportCrewCriticalHit Auto Const
  { DEFAULT=False. If True, if a Crew Critical Hit occurs, this ship will decompress and kill its crew. If False, nothing will happen. }
  Hazard Property ShipHazard Auto
  { DEFAULT=None. If set, this hazard will be active throughout the ship. SetShipHazard and ClearShipHazard can be used to change or remove it. }
  Hazard[] Property PotentialHazards Auto Const
  { Default=None. If set, if ShipHazard is None, a PotentialHazard will be selected at random to become the ShipHazard. }
  Float Property PotentialHazardChance = 1.0 Auto Const
  { Default=1.0. The chance that one of PotentialHazard's Hazards will be used. The default 1.0 means that if ShipHazard is None and PotentialHazards is filled, one will always be used. }
  Bool Property ShouldHaveOxygenAtmosphere = True Auto
  { DEFAULT=True. If True, this ship will have a normal atmosphere. If False, the ship will have no oxygen if it is in space or on a planet with no oxygen. }
  Float Property ShipGravity = -1.0 Auto
  { DEFAULT=-1. If >= 0, Overrides the ship's default gravity. SetShipGravity can be used to change it. }
  Float Property ShipGravityModPercentChance = 1.0 Auto
  { DEFAULT=1. The chance that ShipGravity's Gravity Override will be used. The default 1.0 means that ShipGravity will always be used, 0.5 would apply it half the time, etc. }
  Bool Property ShouldOverrideGravityOnlyInSpace = True Auto Const
  { DEFAULT=True. If True, ShipGravity's override will be used for docking encounters, and ignored for landing encounters, which is usually what you want.
	If False, it will be used for both. Use with caution. }
  Faction Property OwnerFaction Auto
  { DEFAULT=None. If set, this faction will be set as the owner faction of the ship's interior. Items in the cell will be owned, and taking them will be theft.
	Note that this faction must have the 'Can be owner' flag set on the Faction in order for ownership to work. If set, UseAutomaticOwnershipSystem is ignored.
	If this is initially none, but the automatic ownership system sets a faction as this ship's owner, that faction is forced into OwnerFaction. }
  Bool Property UseAutomaticOwnershipSystem = True Auto Const
  { DEFAULT=True. If True, if the ship is in one of the factions in BEAutomaticOwnershipFactionList, the ship's interior will be set owned by that faction. }
  Bool Property ShouldAutoOpenLandingRamp = True Auto Const
  { DEFAULT=True. If True, this ship will automatically open its landing ramp once it has finished landing and spawned disembarking actors (if any). }
  Bool Property PlayHostileAlarmUponBoarding = True Auto Const
  { DEFAULT=True. If True, this ship will play a hostile alarm sound on boarding. }
EndGroup

Group ShipLootAndLockProperties collapsedonbase
  Bool Property ShouldSpawnLoot = True Auto Const
  { DEFAULT=True. Should this BE spawn standard boarding encounter loot in the Captain's Locker on the cockpit/bridge? }
  Float Property ContainersEnabledPercent = 0.5 Auto Const
  { DEFAULT=True. Percent of generic containers on the ship to enable. }
  Bool Property ShouldLockDoors = True Auto Const
  { DEFAULT=True. If this ship has doors in its LockableDoors collection, should we lock some of them?
	LockableDoors should contain only optional internal doors on the ship-- doors to loot closets and side rooms that,
	if locked, won't obstruct the critical path to the cockpit-- so locking them should always be safe from that perspective. }
  Float Property LockPercentChance = 0.5 Auto Const
  { DEFAULT=0.5. If ShouldLockDoors, the percent chance any given door in LockableDoors will be locked (0-1.0). }
  Int Property LockLevelMin = 1 Auto Const
  { DEFAULT=1. Minimum lock level for doors we decide to lock. (1=Novice, 2=Advanced, 3=Expert, 4=Master) }
  Int Property LockLevelMax = 2 Auto Const
  { DEFAULT=4. Maximum lock level for doors we decide to lock. (1=Novice, 2=Advanced, 3=Expert, 4=Master) }
  Bool Property ShouldSpawnContraband = True Auto Const
  { DEFAULT=True. If the ship is part of a qualifying faction, should this BE spawn contraband at small item markers? }
  Float Property ContrabandChancePercent = 0.5 Auto Const
  { DEFAULT=0.5. Chance that the ship will have any contraband at all, if it's in a qualifying faction. }
  Int Property ContrabandMin = 1 Auto Const
  { DEFAULT=1. Minimum amount of contraband to be found on the boarded ship. Contraband will not exceed the number of spawn markers or ContrabandMax. }
  Int Property ContrabandMax = 3 Auto Const
  { DEFAULT=3. Maximum amount of contraband to be found on boarded ship }
EndGroup

Group DisembarkingProperties collapsedonbase
  Bool Property ShouldSetupDisembarkingOnLanding = True Auto Const
  { Default=True. If we have disembarking actors, spawned or placed, should they disembark as soon as the ship lands? If False, you will need to manually trigger disembarking by calling SetupDisembarking. }
  Bool Property ShouldAddDisembarkersToAllCrew = False Auto Const
  { Default=False. Should we add our disembarking actors, spawned or placed, to the AllCrew RefCollectionAlias? }
  Bool Property ShouldSpawnDisembarkers = False Auto Const
  { Default=False. Should this BE spawn generic disembarking actors? Only works for Surface BEs; will be ignored for Docking BEs. }
  Bool Property ShouldForceDisembarkersWeaponsEquipped = False Auto Const
  { Default=False. Should we force disembarkers to wait with weapons equipped?
	 By default, actors in non-civilian factions will have their weapons equipped.
	 This property overrides all other properties and keywords and will be respected. }
  Bool Property ShouldForceDisembarkersWeaponsUnequipped = False Auto Const
  { Default=False. Should we force disembarkers to wait with weapons unequipped?
	 By default, actors in civilian factions will have their weapons unequipped.
	 This property overrides all other properties and keywords (except Equipped). }
  Int Property DisembarkersToSpawn = 0 Auto Const
  { If we do want to spawn generic disembarking actors, how many? }
  bescript:genericcrewdatum[] Property DisembarkerData Auto
  { OPTIONAL. When a BE spawns its disembarkers, it cycles through DisembarkerData (if any) until it's spawned the required number of actors, or runs out of actors it can spawn.
	If DisembarkerData=None, it just continues using the remaining actors in CrewData. }
EndGroup

Group BoardingProperties collapsedonbase
  Bool Property ShouldBoardPlayersShip = False Auto Const
  { DEFAULT=False. If true, the enemy ship's crew will attempt to board the player's ship. }
  RefCollectionAlias Property GenericBoarders Auto Const
  { Mandatory if ShouldBoardPlayersShip; Optional otherwise.
	RefCollectionAlias to push boarders into. Responsible for packaging them to attack the player's ship. }
  ReferenceAlias Property PlayerShipDockingDoor Auto Const
  { Mandatory if ShouldBoardPlayerShip; Optional otherwise.
	The load door in the player's ship leading to the enemy ship. }
  ReferenceAlias Property PlayerShipCockpit Auto Const
  { Mandatory if ShouldBoardPlayersShip; Optional otherwise.
	The player's cockpit module. }
  RefCollectionAlias Property PlayerShipModulesAll Auto Const
  { Mandatory if ShouldBoardPlayersShip; Optional otherwise.
	RefCollection of all of the modules on the player's ship. }
  Float Property MaxPercentOfCrewToBoard = 0.5 Auto Const
  { DEFAULT=0.5. If ShouldBoardPlayersShip, the maximum percentage of the enemy ship's crew that will board the player's ship.
	After MaxPercentOfCrewToBoard have tried to board, the player will have to board the enemy ship to take out the rest-- we don't want
	to completely depopulate it. }
  Float Property MaxSimultaneousBoardersPercent = 0.5 Auto Const
  { DEFAULT=0.5. If ShouldBoardPlayersShip, a cap on the number of enemies that can board the player's ship simultaneously, expressed as a percentage
	of the player's ship's SpaceshipCrewRating value. This prevents, say 25 pirates from piling into the Frontier. }
  Int Property MinBoardingWaveSize = 2 Auto Const
  { DEFAULT=2. The minimum wave size for a wave of enemies boarding the player's ship. }
  Int Property MaxBoardingWaveSize = 6 Auto Const
  { DEFAULT=6. The maximum wave size for a wave of enemies boarding the player's ship. }
EndGroup

Group HeatLeachProperties collapsedonbase
  Float Property HeatLeechChance = 0.0 Auto Const
  { Default=0. Percent chance that random Heat Leeches will spawn on this ship, 0.0-1.0. }
  Int Property MinHeatLeaches = 1 Auto Const
  { Default=1. If HeatLeechChance > 0 and we do want to spawn Heat Leeches, the minimum number to spawn. }
  Int Property MaxHeatLeaches = 3 Auto Const
  { Default=3. If HeatLeechChance > 0 and we do want to spawn Heat Leeches, the maximum number to spawn. }
EndGroup

Group BEObjectiveProperties collapsedonbase
  Bool Property ShouldUseBEObjective = True Auto
  { Default=True. Should BE_Objective run for this ship, provided all of the aliases below are filled? }
  Quest Property BE_Objective Auto Const mandatory
  { Autofill: The BE_Objective quest. }
  GlobalVariable Property BEObjective_OnceOnly_Global Auto Const mandatory
  { Autofill: The BEObjective_OnceOnly_Global. }
  GlobalVariable Property BEObjective_OnceOnly_DoneGlobal Auto Const mandatory
  { Autofill: The BEObjective_OnceOnly_DoneGlobal. }
  ReferenceAlias Property BEObjective_EnemyShip Auto Const
  { BEObjective's EnemyShip alias. If not filled, BE_Objective will not start. }
  ReferenceAlias Property BEObjective_EnemyShipPilotSeat Auto Const
  { BEObjective's EnemyShipPilotSeat alias. If not filled, BE_Objective will not start. }
  ReferenceAlias Property BEObjective_EnemyShipLoadDoor Auto Const
  { BEObjective's EnemyShipLoadDoor alias. If not filled, BE_Objective will not start. }
  RefCollectionAlias Property BEObjective_AllCrew Auto Const
  { BEObjective's AllCrew alias. }
EndGroup

Group AutofillProperties collapsedonbase
  sq_parentscript Property SQ_Parent Auto Const mandatory
  reparentscript Property RE_Parent Auto Const mandatory
  ReferenceAlias Property PlayerShip Auto Const mandatory
  ReferenceAlias Property EnemyShip Auto Const mandatory
  ReferenceAlias Property ModuleCockpit Auto Const
  ReferenceAlias Property Captain Auto Const
  ReferenceAlias Property CaptainSpawnMarker Auto Const
  ReferenceAlias Property CaptainsLocker Auto Const mandatory
  ReferenceAlias Property LandingDeckControlMarker Auto Const mandatory
  ReferenceAlias Property PlayerShipLoadDoor Auto Const mandatory
  RefCollectionAlias Property AllCrew Auto Const mandatory
  RefCollectionAlias Property AllModules Auto Const mandatory
  RefCollectionAlias Property GenericCrew Auto Const mandatory
  RefCollectionAlias Property GenericCorpses Auto Const mandatory
  RefCollectionAlias Property GenericRobots Auto Const mandatory
  RefCollectionAlias Property GenericTurrets Auto Const mandatory
  RefCollectionAlias Property DisembarkingCrew Auto Const mandatory
  RefCollectionAlias Property EmbarkingCrew Auto Const mandatory
  RefCollectionAlias Property Computers Auto Const mandatory
  RefCollectionAlias Property Containers Auto Const mandatory
  RefCollectionAlias Property LockableDoors Auto Const mandatory
  RefCollectionAlias Property SmallItemSpawnMarkers Auto Const mandatory
  RefCollectionAlias Property Contraband Auto Const mandatory
  RefCollectionAlias Property CrewSpawnMarkers Auto Const mandatory
  RefCollectionAlias Property CombatTargets Auto Const
  LocationAlias Property PlayerShipInteriorLocation Auto Const mandatory
  LocationAlias Property EnemyShipInteriorLocation Auto Const mandatory
  LocationAlias Property EnemyShipExteriorLocation Auto Const mandatory
  GlobalVariable Property BE_ShipCrewSizeSmall Auto Const mandatory
  GlobalVariable Property BE_ShipCrewSizeMedium Auto Const mandatory
  GlobalVariable Property BE_ForceNextGravityOverride Auto Const mandatory
  Keyword Property LinkShipModule Auto Const mandatory
  Keyword Property LinkShipModuleCrewSpawn Auto Const mandatory
  Keyword Property LinkShipModuleTurretSpawn Auto Const mandatory
  Keyword Property LinkShipModuleComputer Auto Const mandatory
  Keyword Property LinkShipLoadDoor Auto Const mandatory
  Keyword Property LinkHazardVolume Auto Const mandatory
  Keyword Property LinkCombatTravelTarget Auto Const mandatory
  Keyword Property LinkTerminalRobot Auto Const mandatory
  Keyword Property LinkTerminalTurret Auto Const mandatory
  Keyword Property LinkTerminalContainer Auto Const mandatory
  Keyword Property BEEncounterTypeDocking Auto Const mandatory
  Keyword Property BEEncounterTypeSurface Auto Const mandatory
  Keyword Property BEMarkerInUseKeyword Auto Const mandatory
  Keyword Property BEBoarderPlayerShipCockpitLink Auto Const mandatory
  Keyword Property BEBoarderPlayerShipModuleLink Auto Const mandatory
  Keyword Property BEDropship Auto Const mandatory
  Keyword Property BEDisembarkerLink Auto Const mandatory
  Keyword Property BEDisembarkerForceWeaponsEquipped Auto Const mandatory
  Keyword Property BEDisembarkerForceWeaponsUnequipped Auto Const mandatory
  Keyword Property BECrewAttackerKeyword Auto Const mandatory
  Keyword Property BECrewDefenderKeyword Auto Const mandatory
  Keyword Property BENoCrewKeyword Auto Const mandatory
  Keyword Property BESurfaceCrewSize_NoCrew Auto Const mandatory
  Keyword Property BENoTakeoverObjectiveKeyword Auto Const mandatory
  Keyword Property BENoAutomaticOwnershipKeyword Auto Const mandatory
  Keyword Property BEHostileBoardingEncounterKeyword Auto Const mandatory
  Keyword Property ActorTypeTurret Auto Const mandatory
  Keyword Property ActorTypeRobot Auto Const mandatory
  Keyword Property ENV_Loc_NotSealedEnvironment Auto Const mandatory
  Keyword Property DynamicallyLinkedDoorTeleportMarkerKeyword Auto Const mandatory
  Keyword Property LootSafeKeyword Auto Const mandatory
  Keyword Property SpaceshipPreventRampOpenOnLanding Auto Const
  Faction Property REPlayerFriend Auto Const mandatory
  FormList Property BEAutomaticOwnershipFactionList Auto Const mandatory
  FormList Property BECivilianShipFactionList Auto Const mandatory
  FormList Property BEContrabandShipFactionList Auto Const mandatory
  FormList Property BEHazardKeywordList Auto Const
  FormList Property BEHazardFormList Auto Const
  ActorBase Property ParasiteA_HeatLeech Auto Const mandatory
  ActorValue Property Aggression Auto Const mandatory
  ActorValue Property Confidence Auto Const mandatory
  ActorValue Property Suspicious Auto Const mandatory
  ActorValue Property SpaceshipCrew Auto Const mandatory
  ActorValue Property SpaceshipCrewRating Auto Const mandatory
  ActorValue Property SpaceshipCriticalHitCrew Auto Const mandatory
  ActorValue Property BEBoarderCapturedModule Auto Const mandatory
  ActorValue Property BEWaitingForLandingRampValue Auto Const mandatory
  ActorValue Property BEDisembarkWithWeaponsDrawnValue Auto Const mandatory
  LocationRefType Property Ship_CrewSpawn_RefType Auto Const mandatory
  LocationRefType Property Ship_TurretSpawn_RefType Auto Const mandatory
  LocationRefType Property Ship_Computer_RefType Auto Const mandatory
  LocationRefType Property Ship_Module_Computer_RefType Auto Const mandatory
  LocationRefType Property Ship_Module_Engineering_RefType Auto Const mandatory
  LocationRefType Property Ship_Module_Small_RefType Auto Const mandatory
  LocationRefType Property Ship_Module_Large_RefType Auto Const mandatory
  LeveledItem Property LL_BE_ShipCaptainsLockerLoot_Small Auto Const mandatory
  LeveledItem Property LL_BE_ShipCaptainsLockerLoot_Medium Auto Const mandatory
  LeveledItem Property LL_BE_ShipCaptainsLockerLoot_Large Auto Const mandatory
  LeveledItem Property Loot_LPI_Contraband_Any Auto Const mandatory
  sq_playershipscript Property SQ_PlayerShip Auto Const
  wwiseevent Property OBJ_Alarm_BoardingAlert Auto Const
EndGroup

Group DebugProperties
  Bool Property UseSecondLinkedRefAsCombatTravelTarget = False Auto Const
  Bool Property ShowTraces = True Auto Const
EndGroup

Int Property CONST_SpawnPattern_Fill = 0 Auto Const hidden
Int Property CONST_SpawnPattern_Half = 1 Auto Const hidden
Int Property CONST_SpawnPattern_Spread = 2 Auto Const hidden
Int Property CONST_SpawnPattern_Random = 3 Auto Const hidden
Int Property CONST_SpawnPrioritization_None = 0 Auto Const hidden
Int Property CONST_SpawnPrioritization_CockpitLargeSmall = 1 Auto Const hidden
Int Property CONST_GenericComputerLinkStatus_All = 0 Auto Const hidden
Int Property CONST_GenericComputerLinkStatus_CockpitOnly = 1 Auto Const hidden
Int Property CONST_GenericComputerLinkStatus_None = 2 Auto Const hidden

;-- Functions ---------------------------------------

Event OnQuestStarted()
  player = Game.GetPlayer()
  playerShipInteriorLoc = PlayerShipInteriorLocation.GetLocation()
  enemyShipInteriorLoc = EnemyShipInteriorLocation.GetLocation()
  enemyShipRef = EnemyShip.GetRef() as spaceshipreference
  enemyShipCockpit = ModuleCockpit.GetRef()
  enemyShipCell = enemyShipCockpit.GetParentCell()
  enemyShipCrimeFaction = enemyShipRef.GetCrimeFaction()
  isSurfaceEncounter = enemyShipRef.GetWorldspace() == None
  isSurfaceEncounter = !isSurfaceEncounter
  isDropshipEncounter = enemyShipRef.HasKeyword(BEDropship)
  allCrewSpawnPoints = new ObjectReference[0]
  robots = new Actor[0]
  turrets = new Actor[0]
  BEAliasCorpses = new Actor[0]
  If isDropshipEncounter
    ShutDownOnUnload = False
  Else
    If isSurfaceEncounter
      If ShowTraces
        
      EndIf
      enemyShipRef.SetExteriorLoadDoorInaccessible(False)
    EndIf
    If ShouldCrewStartInCombat && !isSurfaceEncounter
      crewSuspiciousState = CONST_Suspicious_DetectedActor
      enemyShipRef.AddKeyword(BEHostileBoardingEncounterKeyword)
    EndIf
  EndIf
  Self.RegisterForRemoteEvent(player as ScriptObject, "OnLocationChange")
  Self.RegisterForRemoteEvent(enemyShipCockpit as ScriptObject, "OnCellLoad")
  Self.RegisterForRemoteEvent(enemyShipRef as ScriptObject, "OnLoad")
  Self.RegisterForCustomEvent(SQ_PlayerShip as ScriptObject, "sq_playershipscript_SQ_PlayerShipChanged")
  If ShouldSupportCrewCriticalHit && !isSurfaceEncounter && !Self.CheckForCrewCriticalHit()
    Self.RegisterForActorValueChangedEvent(enemyShipRef as ObjectReference, SpaceshipCriticalHitCrew)
  EndIf
  If ShutDownOnUndock
    Self.RegisterForRemoteEvent(enemyShipRef as ScriptObject, "OnShipUndock")
  EndIf
  If ShutDownOnUnload
    Self.RegisterForRemoteEvent(enemyShipRef as ScriptObject, "OnUnload")
  EndIf
  If isSurfaceEncounter
    SQ_PlayerShip.ClearLandingZone(enemyShipRef)
  EndIf
  If !isDropshipEncounter
    Self.BuildModuleData()
    If OwnerFaction != None
      enemyShipCell.SetFactionOwner(OwnerFaction)
    ElseIf UseAutomaticOwnershipSystem && !enemyShipRef.HasKeyword(BENoAutomaticOwnershipKeyword)
      Faction[] ownerFactions = BEAutomaticOwnershipFactionList.GetArray(False) as Faction[]
      Bool ownerFound = False
      Int i = 0
      While !ownerFound && i < ownerFactions.Length
        If enemyShipRef.IsInFaction(ownerFactions[i])
          enemyShipCell.SetFactionOwner(ownerFactions[i])
          OwnerFaction = ownerFactions[i]
          ownerFound = True
        EndIf
        i += 1
      EndWhile
    EndIf
    If OwnerFaction != None
      enemyShipCell.SetOffLimits(True)
    EndIf
    Float baseCrewSize = enemyShipRef.GetBaseValue(SpaceshipCrew)
    Float currentCrewSize = enemyShipRef.GetValue(SpaceshipCrew)
    crewSizePercent = currentCrewSize / baseCrewSize
    If ShouldSpawnCrew && CrewData != None
      genericCrewSize = Self.SetupGenericCrew(CrewData, CrewCountPercent, CrewCountOverride, CrewSpawnPattern, CONST_SpawnPrioritization_CockpitLargeSmall, False)
      Int spaceshipCrewValue = enemyShipRef.GetValue(SpaceshipCrew) as Int
      If genericCrewSize < spaceshipCrewValue
        If ShowTraces
          
        EndIf
        Float crewLost = Math.Max((spaceshipCrewValue - genericCrewSize) as Float, 0.0)
        enemyShipRef.ModValue(SpaceshipCrew, -crewLost)
      EndIf
    EndIf
    If ShouldSpawnCorpses
      If CorpseData == None
        CorpseData = CrewData
      EndIf
      If CorpseData != None
        Self.SetupGenericCrew(CorpseData, CorpseCountPercent, CorpseCountOverride, CorpseSpawnPattern, CONST_SpawnPrioritization_None, True)
      EndIf
    EndIf
    If TurretData != None && TurretSpawnChance > 0.0 && TurretModulePercentChance > 0.0 && Utility.RandomFloat(0.0, 1.0) < TurretSpawnChance
      Int turretsSpawned = Self.SetupTurrets()
      enemyShipRef.ModValue(SpaceshipCrew, turretsSpawned as Float)
    EndIf
    If HeatLeechChance > 0.0 && Utility.RandomFloat(0.0, 1.0) < HeatLeechChance
      Self.SetupHeatLeeches()
    EndIf
    Keyword[] hazardKeywords = BEHazardKeywordList.GetArray(False) as Keyword[]
    Hazard[] hazardType = BEHazardFormList.GetArray(False) as Hazard[]
    Int I = 0
    Bool hazardChosen = False
    While I < hazardKeywords.Length && hazardChosen == False
      If enemyShipRef.HasKeyword(hazardKeywords[I])
        ShipHazard = hazardType[I]
        hazardChosen = True
      EndIf
      I += 1
    EndWhile
    If ShipHazard == None && PotentialHazards != None && PotentialHazards.Length > 0 && Utility.RandomFloat(0.0, 1.0) < PotentialHazardChance
      ShipHazard = PotentialHazards[Utility.RandomInt(0, PotentialHazards.Length - 1)]
    EndIf
    If ShipHazard != None
      Self.SetShipHazard(ShipHazard)
    EndIf
    If !ShouldHaveOxygenAtmosphere
      enemyShipInteriorLoc.AddKeyword(ENV_Loc_NotSealedEnvironment)
    EndIf
    If ShipGravity >= 0.0 && ShipHazard == None
      If ShipGravityModPercentChance < 0.0 || ShipGravityModPercentChance >= 1.0 || Utility.RandomFloat(0.0, 1.0) < ShipGravityModPercentChance
        Self.SetShipGravity(ShipGravity)
      ElseIf BE_ForceNextGravityOverride != None && BE_ForceNextGravityOverride.GetValue() >= 0.0
        Self.SetShipGravity(BE_ForceNextGravityOverride.GetValue())
        BE_ForceNextGravityOverride.SetValue(-1.0)
      Else
        Self.SetShipGravity(1.0)
      EndIf
    EndIf
    If Self.CheckForCrewCriticalHit()
      Self.DecompressShipAndKillCrew()
    EndIf
    ObjectReference[] containerRefs = commonarrayfunctions.CopyAndRandomizeObjArray(Containers.GetArray())
    Int containerDisableCount = (containerRefs.Length as Float * (1.0 - ContainersEnabledPercent)) as Int
    I = 0
    While I < containerRefs.Length
      If I < containerDisableCount
        containerRefs[I].DisableNoWait(False)
      ElseIf containerRefs[I].HasKeyword(LootSafeKeyword)
        containerRefs[I].Lock(True, False, True)
        containerRefs[I].SetLockLevel(Utility.RandomInt(LockLevelMin, LockLevelMax) * 25)
      EndIf
      I += 1
    EndWhile
    If ShouldSpawnContraband
      Float RandomFloat = Utility.RandomFloat(0.0, 1.0)
      If RandomFloat <= ContrabandChancePercent
        Faction[] contrabandShipFactions = BEContrabandShipFactionList.GetArray(False) as Faction[]
        I = 0
        Bool contrabandFactionFound = False
        While I < contrabandShipFactions.Length && contrabandFactionFound == False
          If enemyShipRef.IsInFaction(contrabandShipFactions[I])
            Self.SpawnContraband()
            contrabandFactionFound = True
          EndIf
          I += 1
        EndWhile
      EndIf
    EndIf
    If ShouldLockDoors
      I = 0
      While I < LockableDoors.GetCount()
        If Utility.RandomFloat(0.0, 1.0) < LockPercentChance
          ObjectReference currentDoor = LockableDoors.GetAt(I)
          currentDoor.Lock(True, False, True)
          currentDoor.SetLockLevel(Utility.RandomInt(LockLevelMin, LockLevelMax) * 25)
        EndIf
        I += 1
      EndWhile
    EndIf
    Self.SetupComputers()
  EndIf
  If isSurfaceEncounter
    ObjectReference[] myDisembarkers = enemyShipRef.GetRefsLinkedToMe(BEDisembarkerLink, None)
    If ShowTraces
      
    EndIf
    DisembarkingCrew.AddArray(myDisembarkers)
    If ShouldSpawnDisembarkers
      If DisembarkerData == None
        DisembarkerData = CrewData
      EndIf
      Self.SpawnGenericActors(DisembarkerData, DisembarkersToSpawn, None, False, True)
    EndIf
    If ShouldForceDisembarkersWeaponsEquipped
      disembarkersShouldHaveWeaponsUnequipped = False
    ElseIf ShouldForceDisembarkersWeaponsUnequipped
      disembarkersShouldHaveWeaponsUnequipped = True
    ElseIf enemyShipRef.HasKeyword(BEDisembarkerForceWeaponsUnequipped)
      disembarkersShouldHaveWeaponsUnequipped = False
    ElseIf enemyShipRef.HasKeyword(BEDisembarkerForceWeaponsEquipped)
      disembarkersShouldHaveWeaponsUnequipped = True
    ElseIf OwnerFaction != None
      disembarkersShouldHaveWeaponsUnequipped = BECivilianShipFactionList.Find(OwnerFaction as Form) >= 0
    Else
      Faction[] civilianShipFactions = BECivilianShipFactionList.GetArray(False) as Faction[]
      Int i = 0
      While !disembarkersShouldHaveWeaponsUnequipped && i < civilianShipFactions.Length
        If enemyShipRef.IsInFaction(civilianShipFactions[i])
          disembarkersShouldHaveWeaponsUnequipped = True
        EndIf
        i += 1
      EndWhile
    EndIf
    If ShouldSetupDisembarkingOnLanding
      Self.RegisterForRemoteEvent(enemyShipRef as ScriptObject, "OnShipLanding")
      Self.RegisterForRemoteEvent(enemyShipRef as ScriptObject, "OnShipRampDown")
      Self.SetupDisembarking()
    Else
      Self.RegisterForRemoteEvent(enemyShipRef as ScriptObject, "OnShipLanding")
      If ShouldAutoOpenLandingRamp && enemyShipRef.IsLanded()
        Self.SetEnemyShipLandingRampsOpenState(ShouldAutoOpenLandingRamp)
      EndIf
    EndIf
  EndIf
  If ShouldBoardPlayersShip
    playerShipRef = PlayerShip.GetRef() as spaceshipreference
    playerShipDockingDoorRef = PlayerShipDockingDoor.GetRef()
    playerShipCockpitRef = PlayerShipCockpit.GetRef()
    playerShipModulesAllRefs = PlayerShipModulesAll.GetArray()
    maxSimultaneousBoarders = Math.Max(Math.Round(playerShipRef.GetValue(SpaceshipCrewRating) * MaxSimultaneousBoardersPercent) as Float, MinBoardingWaveSize as Float) as Int
    Int remainingBoardersCount = Math.Round(GenericCrew.GetCount() as Float * MaxPercentOfCrewToBoard)
    Int potentialBoardersCount = GenericCrew.GetCount() - remainingBoardersCount
    remainingBoarders = new Actor[remainingBoardersCount]
    potentialBoarders = new Actor[potentialBoardersCount]
    Int i = GenericCrew.GetCount() - 1
    While i >= 0 && remainingBoardersCount > 0
      remainingBoarders[remainingBoardersCount - 1] = GenericCrew.GetAt(i) as Actor
      remainingBoardersCount -= 1
      i -= 1
    EndWhile
    While i >= 0 && potentialBoardersCount > 0
      potentialBoarders[potentialBoardersCount - 1] = GenericCrew.GetAt(i) as Actor
      potentialBoardersCount -= 1
      i -= 1
    EndWhile
  EndIf
  hasInitialized = True
  If ShouldBoardPlayersShip
    Self.RegisterForRemoteEvent(enemyShipRef as ScriptObject, "OnShipDock")
    If enemyShipRef.IsDocked()
      Self.UnregisterForRemoteEvent(enemyShipRef as ScriptObject, "OnShipDock")
      Self.UpdateBoarding()
    EndIf
  EndIf
  Self.RegisterForCustomEvent(SQ_Parent as ScriptObject, "sq_parentscript_SQ_BEForceStop")
  SQ_Parent.SendBEStartedEvent(enemyShipRef as ObjectReference, Self)
  If ShowTraces
    
  EndIf
EndEvent

Function BuildModuleData()
  ObjectReference[] modulesWithCrew = AllModules.GetArray()
  Float startTime = Utility.GetCurrentRealTime()
  Int I = 0
  While I < modulesWithCrew.Length
    If modulesWithCrew[I].HasKeyword(BENoCrewKeyword) || !modulesWithCrew[I].HasLocRefType(Ship_Module_Small_RefType) && modulesWithCrew[I] != enemyShipCockpit
      modulesWithCrew.remove(I, 1)
      I -= 1
    EndIf
    I += 1
  EndWhile
  moduleData = new bescript:moduledatum[modulesWithCrew.Length]
  I = 0
  While I < moduleData.Length
    ObjectReference currentModuleRef = modulesWithCrew[I]
    ObjectReference[] crewSpawnRefs = currentModuleRef.GetRefsLinkedToMe(LinkShipModuleCrewSpawn, None)
    ObjectReference[] turretSpawnRefs = currentModuleRef.GetRefsLinkedToMe(LinkShipModuleTurretSpawn, None)
    ObjectReference[] computerRefs = currentModuleRef.GetRefsLinkedToMe(LinkShipModuleComputer, None)
    bescript:moduledatum currentModuleData = new bescript:moduledatum
    currentModuleData.moduleRef = currentModuleRef
    If crewSpawnRefs.Length >= 1
      currentModuleData.shipCrewSpawnMarkerRef01 = crewSpawnRefs[0]
      If crewSpawnRefs.Length >= 2
        currentModuleData.shipCrewSpawnMarkerRef02 = crewSpawnRefs[1]
        If crewSpawnRefs.Length >= 3
          currentModuleData.shipCrewSpawnMarkerRef03 = crewSpawnRefs[2]
          If crewSpawnRefs.Length >= 4
            currentModuleData.shipCrewSpawnMarkerRef04 = crewSpawnRefs[3]
            If crewSpawnRefs.Length >= 5
              currentModuleData.shipCrewSpawnMarkerRef05 = crewSpawnRefs[4]
            EndIf
          EndIf
        EndIf
      EndIf
    EndIf
    Int j = 0
    While j < crewSpawnRefs.Length
      allCrewSpawnPoints.add(crewSpawnRefs[j], 1)
      j += 1
    EndWhile
    If turretSpawnRefs.Length >= 1
      currentModuleData.shipTurretSpawnMarkerRef01 = turretSpawnRefs[0]
      If turretSpawnRefs.Length >= 2
        currentModuleData.shipTurretSpawnMarkerRef02 = turretSpawnRefs[1]
        If turretSpawnRefs.Length >= 3
          currentModuleData.shipTurretSpawnMarkerRef03 = turretSpawnRefs[2]
          If turretSpawnRefs.Length >= 4
            currentModuleData.shipTurretSpawnMarkerRef04 = turretSpawnRefs[3]
            If turretSpawnRefs.Length >= 5
              currentModuleData.shipTurretSpawnMarkerRef05 = turretSpawnRefs[4]
            EndIf
          EndIf
        EndIf
      EndIf
    EndIf
    If computerRefs.Length >= 1
      currentModuleData.shipComputerRef = computerRefs[0]
    EndIf
    moduleData[I] = currentModuleData
    I += 1
  EndWhile
  If allCrewSpawnPoints.Length == 0
    allCrewSpawnPoints = CrewSpawnMarkers.GetArray()
  EndIf
  modulesWithCrew = AllModules.GetArray()
EndFunction

Event Actor.OnLocationChange(Actor akSource, Location akOldLoc, Location akNewLoc)
  If akSource == Game.GetPlayer()
    If akNewLoc == enemyShipInteriorLoc
      If ShouldUseBEObjective
        If enemyShipRef.HasKeyword(BENoTakeoverObjectiveKeyword)
          ShouldUseBEObjective = False
        ElseIf enemyShipRef.HasKeyword(BESurfaceCrewSize_NoCrew)
          ShouldUseBEObjective = False
        ElseIf BEObjective_OnceOnly_Global.GetValue() == 1.0 && BEObjective_OnceOnly_DoneGlobal.GetValue() == 1.0
          ShouldUseBEObjective = False
        ElseIf BEObjective_EnemyShip == None || BEObjective_EnemyShipPilotSeat == None || BEObjective_EnemyShipLoadDoor == None || BEObjective_AllCrew == None
          ShouldUseBEObjective = False
        Else
          BE_Objective.SetStage(CONST_BEObjective_Startup)
          BEObjective_EnemyShip.ForceRefTo(enemyShipRef as ObjectReference)
          BEObjective_EnemyShip.RefillDependentAliases()
          If BEObjective_EnemyShipPilotSeat.GetRef() == None || BEObjective_EnemyShipLoadDoor.GetRef() == None
            ShouldUseBEObjective = False
          Else
            If enemyShipRef.GetValue(SpaceshipCrew) > 0.0
              Int I = 0
              While I < AllCrew.GetCount()
                Actor current = AllCrew.GetAt(I) as Actor
                If !current.IsDead()
                  BEObjective_AllCrew.AddRef(current as ObjectReference)
                EndIf
                I += 1
              EndWhile
              If BEObjective_AllCrew.GetCount() == 0
                
              EndIf
            EndIf
            If BEObjective_AllCrew.GetCount() > 0
              (BEObjective_EnemyShipPilotSeat as beobjectiveblockpilotseatscript).BlockTakeover(Self)
              BE_Objective.SetStage(CONST_BEObjective_KillEnemyCrewObj)
            Else
              If ShipGravity < 1.0
                (BEObjective_EnemyShipPilotSeat as beobjectiveblockpilotseatscript).BlockTakeover(Self)
              EndIf
              BE_Objective.SetStage(CONST_BEObjective_TakeOverEnemyShipObj)
            EndIf
          EndIf
        EndIf
      EndIf
    ElseIf akOldLoc == enemyShipInteriorLoc
      If ShouldUseBEObjective
        BE_Objective.SetStage(CONST_BEObjective_LeaveShip)
      EndIf
    EndIf
  EndIf
EndEvent

Function RegisterBEAliasActor(Actor BEAliasActor, Bool startsDead, Bool shouldIncludeInCrew, Bool shouldIncludeAtFrontOfBoardingParty, Bool shouldIncludeAtBackOfBoardingParty)
  Self.WaitUntilInitialized()
  Guard BECrewGuard ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    If startsDead
      BEAliasCorpses.add(BEAliasActor, 1)
      If BEAliasActor.Is3DLoaded()
        RE_Parent.KillWithForceNoWait(BEAliasActor, None, True)
      EndIf
    Else
      Self.RegisterForRemoteEvent(BEAliasActor as ScriptObject, "OnDying")
    EndIf
    If AllCrew.Find(BEAliasActor as ObjectReference) < 0
      If shouldIncludeInCrew
        If !startsDead && !BEAliasActor.IsDead()
          AllCrew.AddRef(BEAliasActor as ObjectReference)
          If ShouldUseBEObjective && (BEObjective_EnemyShip.GetRef() == enemyShipRef as ObjectReference)
            BEObjective_AllCrew.AddRef(BEAliasActor as ObjectReference)
          EndIf
          BEAliasActor.AddKeyword(BECrewDefenderKeyword)
        EndIf
        BEAliasActor.SetValue(Suspicious, crewSuspiciousState as Float)
        If BEAliasActor.HasKeyword(ActorTypeRobot)
          If robots.Length > 0
            robots[robots.Length - 1].SetLinkedRef(BEAliasActor as ObjectReference, LinkTerminalRobot, True)
          EndIf
          robots.add(BEAliasActor, 1)
        EndIf
        If AllCrew.GetCount() > genericCrewSize
          Actor crewToReplace = None
          If !ShouldBoardPlayersShip
            If GenericCrew.GetCount() > 0
              crewToReplace = GenericCrew.GetAt(GenericCrew.GetCount() - 1) as Actor
            EndIf
          ElseIf ShouldBoardPlayersShip && potentialBoarders.Length > 0
            crewToReplace = potentialBoarders[potentialBoarders.Length - 1]
            potentialBoarders.remove(potentialBoarders.Length - 1, 1)
          ElseIf ShouldBoardPlayersShip && remainingBoarders.Length > 0
            crewToReplace = remainingBoarders[remainingBoarders.Length - 1]
            remainingBoarders.remove(remainingBoarders.Length - 1, 1)
          EndIf
          If crewToReplace != None
            GenericCrew.RemoveRef(crewToReplace as ObjectReference)
            AllCrew.RemoveRef(crewToReplace as ObjectReference)
            If ShouldUseBEObjective && (BEObjective_EnemyShip.GetRef() == enemyShipRef as ObjectReference)
              BEObjective_AllCrew.RemoveRef(crewToReplace as ObjectReference)
            EndIf
            crewToReplace.DisableNoWait(False)
          EndIf
        EndIf
      EndIf
    EndIf
    If ShouldBoardPlayersShip && remainingBoarders != None
      If shouldIncludeAtFrontOfBoardingParty
        remainingBoarders.insert(BEAliasActor, 0)
      ElseIf shouldIncludeAtBackOfBoardingParty
        remainingBoarders.add(BEAliasActor, 1)
      EndIf
    EndIf
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndFunction

Event OnTimer(Int timerID)
  If timerID == CONST_BoardingUpdateTimerID
    Self.UpdateBoarding()
  ElseIf timerID == CONST_TakeoffUpdateTimerID
    Self.UpdateTakeoff()
  EndIf
EndEvent

Event Actor.OnDying(Actor akSender, ObjectReference akKiller)
  Self.TryToDecrementSpaceshipCrew(akSender, False)
  If GenericBoarders != None
    If GenericBoarders.Find(akSender as ObjectReference) >= 0
      GenericBoarders.RemoveRef(akSender as ObjectReference)
    EndIf
  EndIf
  If ShowTraces
    
  EndIf
EndEvent

Function RemoveHackedActors(Actor[] actorsToRemove)
  Int I = 0
  While I < actorsToRemove.Length
    Actor currentActor = actorsToRemove[I]
    Self.TryToDecrementSpaceshipCrew(currentActor, True)
    If ShowTraces
      
    EndIf
    I += 1
  EndWhile
EndFunction

Function TryToDecrementSpaceshipCrew(Actor actorToProcess, Bool omitIfDead)
  Guard SpaceshipCrewDecrementGuard ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    If AllCrew.Find(actorToProcess as ObjectReference) >= 0 && (!omitIfDead || !actorToProcess.IsDead())
      enemyShipRef.ModValue(SpaceshipCrew, -1.0)
      If enemyShipRef.GetValue(SpaceshipCrew) <= 0.0
        If StageToSetWhenAllCrewDead >= 0
          Self.SetStage(StageToSetWhenAllCrewDead)
        EndIf
        Self.SendCustomEvent("bescript_BEAllCrewDead", None)
      EndIf
    EndIf
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndFunction

Event SQ_ParentScript.SQ_NativeTerminalActor_Unconscious(sq_parentscript source, Var[] akArgs)
  Actor targetActor = akArgs[1] as Actor
  If robots.find(targetActor, 0) >= 0
    Self.RemoveHackedActors(robots)
  ElseIf turrets.find(targetActor, 0) >= 0
    Self.RemoveHackedActors(turrets)
  EndIf
EndEvent

Event SQ_ParentScript.SQ_NativeTerminalActor_Ally(sq_parentscript source, Var[] akArgs)
  Actor targetActor = akArgs[1] as Actor
  If robots.find(targetActor, 0) >= 0
    Self.RemoveHackedActors(robots)
  ElseIf turrets.find(targetActor, 0) >= 0
    Self.RemoveHackedActors(turrets)
  EndIf
EndEvent

Event SQ_ParentScript.SQ_NativeTerminalActor_Frenzy(sq_parentscript source, Var[] akArgs)
  Actor targetActor = akArgs[1] as Actor
  If robots.find(targetActor, 0) >= 0
    Self.RemoveHackedActors(robots)
  ElseIf turrets.find(targetActor, 0) >= 0
    Self.RemoveHackedActors(turrets)
  EndIf
EndEvent

Event OnActorValueChanged(ObjectReference source, ActorValue akActorValue)
  If (source == enemyShipRef as ObjectReference) && akActorValue == SpaceshipCriticalHitCrew && Self.CheckForCrewCriticalHit()
    Self.UnregisterForActorValueChangedEvent(enemyShipRef as ObjectReference, SpaceshipCriticalHitCrew)
    Self.DecompressShipAndKillCrew()
  EndIf
EndEvent

Event SpaceshipReference.OnShipDock(spaceshipreference source, Bool abComplete, spaceshipreference akDocking, spaceshipreference akParent)
  If abComplete && ShouldBoardPlayersShip
    Self.UnregisterForRemoteEvent(enemyShipRef as ScriptObject, "OnShipDock")
    Self.UpdateBoarding()
  EndIf
EndEvent

Event SpaceshipReference.OnShipLanding(spaceshipreference source, Bool abComplete)
  If abComplete
    If ShouldSetupDisembarkingOnLanding
      Self.SetupDisembarking()
    ElseIf ShouldAutoOpenLandingRamp
      Self.SetEnemyShipLandingRampsOpenState(True)
    EndIf
  EndIf
EndEvent

Event SpaceshipReference.OnShipRampDown(spaceshipreference source)
  Self.SetupDisembarking()
EndEvent

Event SpaceshipReference.OnShipUndock(spaceshipreference source, Bool abComplete, spaceshipreference akUndocking, spaceshipreference akParent)
  shouldAbortBoarding = True
  If abComplete && ShutDownOnUndock
    If ShowTraces
      
    EndIf
    Self.CleanupAndStop()
  EndIf
EndEvent

Event ObjectReference.OnUnload(ObjectReference source)
  If ShutDownOnUnload
    If ShowTraces
      
    EndIf
    Self.CleanupAndStop()
  EndIf
EndEvent

Event SQ_PlayerShipScript.SQ_PlayerShipChanged(sq_playershipscript source, Var[] akArgs)
  If akArgs[0] as spaceshipreference == enemyShipRef
    Self.SetShipGravity(1.0)
    Self.SetShipHasOxygen(True)
    enemyShipCell.SetFactionOwner(None)
    enemyShipCell.SetOffLimits(False)
    enemyShipRef.RemoveKeyword(BEHostileBoardingEncounterKeyword)
    If ShutDownOnTakeover
      If ShowTraces
        
      EndIf
      Self.CleanupAndStop()
    EndIf
  EndIf
EndEvent

Event SQ_ParentScript.SQ_BEForceStop(sq_parentscript akSource, Var[] akArgs)
  If ShowTraces
    
  EndIf
  Self.CleanupAndStop()
EndEvent

Function CleanupAndStop()
  playerShipInteriorLoc = None
  enemyShipInteriorLoc = None
  enemyShipRef = None
  enemyShipCockpit = None
  enemyShipCell = None
  enemyShipHazard = None
  moduleData = None
  robots = None
  turrets = None
  BEAliasCorpses = None
  HeatLeeches = None
  playerShipRef = None
  playerShipDockingDoorRef = None
  playerShipCockpitRef = None
  playerShipModulesAllRefs = None
  remainingBoarders = None
  potentialBoarders = None
  Self.Stop()
EndFunction

Int Function SetupGenericCrew(bescript:genericcrewdatum[] actorData, Float countPercent, Int countOverride, Int spawnPattern, Int spawnPrioritization, Bool isSpawningCorpses)
  Int actorsToSpawn = 0
  If countOverride >= 0
    actorsToSpawn = countOverride
  ElseIf !isSpawningCorpses
    actorsToSpawn = Math.Max(0.0, enemyShipRef.GetValue(SpaceshipCrew) * countPercent * crewSizePercent) as Int
    If actorsToSpawn == 0
      If enemyShipRef.GetValue(SpaceshipCrew) == 0.0
        If ShowTraces
          
        EndIf
      ElseIf countPercent == 0.0
        If ShowTraces
          
        EndIf
      ElseIf crewSizePercent == 0.0
        If ShowTraces
          
        EndIf
      Else
        actorsToSpawn = 1
        If ShowTraces
          
        EndIf
      EndIf
    EndIf
  Else
    actorsToSpawn = Math.Max(0.0, (enemyShipRef.GetBaseValue(SpaceshipCrew) - enemyShipRef.GetValue(SpaceshipCrew)) * countPercent) as Int
  EndIf
  ObjectReference[] spawnPoints = Self.SelectSpawnPoints(actorsToSpawn, spawnPattern, spawnPrioritization)
  If spawnPoints.Length < actorsToSpawn
    If ShowTraces
      
    EndIf
    actorsToSpawn = spawnPoints.Length
    If ShouldSpawnCaptain && !hasSpawnedCaptain && Captain.GetRef() == None
      actorsToSpawn += 1
    EndIf
  EndIf
  Int genericCrewSpawned = Self.SpawnGenericActors(actorData, actorsToSpawn, spawnPoints, isSpawningCorpses, False)
  Return genericCrewSpawned
EndFunction

Int Function SetupTurrets()
  Int turretsSpawned = 0
  Int modulesWithTurretsTarget = (moduleData.Length as Float * TurretModulePercentChance) as Int
  If modulesWithTurretsTarget > 0
    Int modulesWithTurrets = 0
    bescript:moduledatum[] randomizedModuleData = Self.CopyAndRandomizeModuleDataArray(moduleData)
    Int I = 0
    While modulesWithTurrets < modulesWithTurretsTarget && I < randomizedModuleData.Length
      bescript:moduledatum currentModule = randomizedModuleData[I]
      If currentModule.shipTurretSpawnMarkerRef01 != None
        modulesWithTurrets += 1
        Int turretsToSpawnInCurrentModule = 0
        If currentModule.moduleRef.HasLocRefType(Ship_Module_Large_RefType)
          turretsToSpawnInCurrentModule = Utility.RandomInt(TurretsToSpawnMin_Large, TurretsToSpawnMax_Large)
        Else
          turretsToSpawnInCurrentModule = Utility.RandomInt(TurretsToSpawnMin_Small, TurretsToSpawnMax_Small)
        EndIf
        ObjectReference[] turretSpawnMarkers = new ObjectReference[0]
        If turretsToSpawnInCurrentModule >= 1
          turretSpawnMarkers.add(currentModule.shipTurretSpawnMarkerRef01, 1)
        EndIf
        If turretsToSpawnInCurrentModule >= 2 && currentModule.shipTurretSpawnMarkerRef02 != None
          turretSpawnMarkers.add(currentModule.shipTurretSpawnMarkerRef02, 1)
        EndIf
        If turretsToSpawnInCurrentModule >= 3 && currentModule.shipTurretSpawnMarkerRef03 != None
          turretSpawnMarkers.add(currentModule.shipTurretSpawnMarkerRef03, 1)
        EndIf
        If turretsToSpawnInCurrentModule >= 4 && currentModule.shipTurretSpawnMarkerRef04 != None
          turretSpawnMarkers.add(currentModule.shipTurretSpawnMarkerRef04, 1)
        EndIf
        If turretsToSpawnInCurrentModule >= 5 && currentModule.shipTurretSpawnMarkerRef05 != None
          turretSpawnMarkers.add(currentModule.shipTurretSpawnMarkerRef05, 1)
        EndIf
        Int j = 0
        While j < turretSpawnMarkers.Length
          Actor newTurret = Self.SpawnGenericActor(turretSpawnMarkers[j], TurretData, False, False)
          If ShouldTurretsStartUnconscious
            newTurret.SetUnconscious(True)
          EndIf
          If ShouldTurretsStartFriendlyToPlayer
            newTurret.AddToFaction(REPlayerFriend)
          EndIf
          turretsSpawned += 1
          j += 1
        EndWhile
      EndIf
      I += 1
    EndWhile
  EndIf
  Return turretsSpawned
EndFunction

Int Function SetupHeatLeeches()
  Int leechesToSpawn = Utility.RandomInt(MinHeatLeaches, MaxHeatLeaches)
  If ShowTraces
    
  EndIf
  ObjectReference[] spawnPoints = Self.SelectSpawnPoints(leechesToSpawn, CONST_SpawnPattern_Fill, CONST_SpawnPrioritization_None)
  If spawnPoints.Length < leechesToSpawn
    If ShowTraces
      
    EndIf
    leechesToSpawn = spawnPoints.Length
  EndIf
  HeatLeeches = new Actor[leechesToSpawn]
  Int I = 0
  While I < leechesToSpawn
    HeatLeeches[I] = spawnPoints[I].PlaceActorAtMe(ParasiteA_HeatLeech, 4, None, False, False, True, None, True)
    HeatLeeches[I].SetLinkedRef(spawnPoints[I].GetLinkedRef(LinkShipModule), LinkShipModule, True)
    I += 1
  EndWhile
  Return leechesToSpawn
EndFunction

ObjectReference[] Function SelectSpawnPoints(Int actorsToSpawn, Int spawnPattern, Int spawnPrioritization)
  ObjectReference[] selectedSpawnPoints = new ObjectReference[0]
  bescript:moduledatum[] randomizedModuleData = Self.CopyAndRandomizeModuleDataArray(moduleData)
  bescript:moduledatum[] prioritizedModuleData = None
  If randomizedModuleData.Length == 0
    Return selectedSpawnPoints
  EndIf
  If ShowTraces
    
  EndIf
  If spawnPattern != CONST_SpawnPattern_Random
    If spawnPrioritization == CONST_SpawnPrioritization_None
      prioritizedModuleData = randomizedModuleData
    ElseIf spawnPrioritization == CONST_SpawnPrioritization_CockpitLargeSmall
      prioritizedModuleData = new bescript:moduledatum[randomizedModuleData.Length]
      Int pIndex = 0
      Int cockpitIndex = randomizedModuleData.findstruct("moduleRef", enemyShipCockpit, 0)
      If cockpitIndex >= 0
        prioritizedModuleData[pIndex] = randomizedModuleData[cockpitIndex]
        pIndex += 1
        randomizedModuleData.remove(cockpitIndex, 1)
      EndIf
      Int i = randomizedModuleData.Length - 1
      While i >= 0
        If i < randomizedModuleData.Length && randomizedModuleData[i].moduleRef.HasLocRefType(Ship_Module_Large_RefType)
          prioritizedModuleData[pIndex] = randomizedModuleData[i]
          pIndex += 1
          randomizedModuleData.remove(i, 1)
        EndIf
        i -= 1
      EndWhile
      i = 0
      While i < randomizedModuleData.Length
        prioritizedModuleData[pIndex] = randomizedModuleData[i]
        pIndex += 1
        i += 1
      EndWhile
    EndIf
    Int I = 0
    While selectedSpawnPoints.Length < actorsToSpawn && I < prioritizedModuleData.Length
      bescript:moduledatum currentModule = prioritizedModuleData[I]
      ObjectReference[] moduleSpawnPoints = Self.GetUnusedSpawnPointsInModule(currentModule)
      Int moduleSpawnPointsToAdd = 0
      If spawnPattern == CONST_SpawnPattern_Fill
        moduleSpawnPointsToAdd = moduleSpawnPoints.Length
      ElseIf spawnPattern == CONST_SpawnPattern_Half
        moduleSpawnPointsToAdd = Math.Round(moduleSpawnPoints.Length as Float / 2.0)
      Else
        moduleSpawnPointsToAdd = Math.Min(moduleSpawnPoints.Length as Float, 1.0) as Int
      EndIf
      Int j = 0
      While j < moduleSpawnPoints.Length && j < moduleSpawnPointsToAdd && selectedSpawnPoints.Length < actorsToSpawn
        selectedSpawnPoints.add(moduleSpawnPoints[j], 1)
        moduleSpawnPoints[j].AddKeyword(BEMarkerInUseKeyword)
        j += 1
      EndWhile
      I += 1
    EndWhile
    If ShowTraces
      
    EndIf
  EndIf
  If selectedSpawnPoints.Length < actorsToSpawn
    ObjectReference[] randomizedSpawnPoints = commonarrayfunctions.CopyAndRandomizeObjArray(allCrewSpawnPoints)
    Int i = 0
    While selectedSpawnPoints.Length < actorsToSpawn && i < randomizedSpawnPoints.Length
      ObjectReference nextSpawnPoint = randomizedSpawnPoints[i]
      If !nextSpawnPoint.HasKeyword(BEMarkerInUseKeyword)
        selectedSpawnPoints.add(nextSpawnPoint, 1)
        nextSpawnPoint.AddKeyword(BEMarkerInUseKeyword)
      EndIf
      i += 1
    EndWhile
    If ShowTraces
      
    EndIf
  EndIf
  If ShowTraces
    
  EndIf
  Return selectedSpawnPoints
EndFunction

ObjectReference[] Function GetUnusedSpawnPointsInModule(bescript:moduledatum moduleDataRef)
  ObjectReference[] unusedSpawnPoints = new ObjectReference[0]
  If moduleDataRef.shipCrewSpawnMarkerRef01 != None && !moduleDataRef.shipCrewSpawnMarkerRef01.HasKeyword(BEMarkerInUseKeyword)
    unusedSpawnPoints.add(moduleDataRef.shipCrewSpawnMarkerRef01, 1)
  EndIf
  If moduleDataRef.shipCrewSpawnMarkerRef02 != None && !moduleDataRef.shipCrewSpawnMarkerRef02.HasKeyword(BEMarkerInUseKeyword)
    unusedSpawnPoints.add(moduleDataRef.shipCrewSpawnMarkerRef02, 1)
  EndIf
  If moduleDataRef.shipCrewSpawnMarkerRef03 != None && !moduleDataRef.shipCrewSpawnMarkerRef03.HasKeyword(BEMarkerInUseKeyword)
    unusedSpawnPoints.add(moduleDataRef.shipCrewSpawnMarkerRef03, 1)
  EndIf
  If moduleDataRef.shipCrewSpawnMarkerRef04 != None && !moduleDataRef.shipCrewSpawnMarkerRef04.HasKeyword(BEMarkerInUseKeyword)
    unusedSpawnPoints.add(moduleDataRef.shipCrewSpawnMarkerRef04, 1)
  EndIf
  If moduleDataRef.shipCrewSpawnMarkerRef05 != None && !moduleDataRef.shipCrewSpawnMarkerRef05.HasKeyword(BEMarkerInUseKeyword)
    unusedSpawnPoints.add(moduleDataRef.shipCrewSpawnMarkerRef05, 1)
  EndIf
  Return unusedSpawnPoints
EndFunction

Int Function SpawnGenericActors(bescript:genericcrewdatum[] actorData, Int actorsToSpawn, ObjectReference[] spawnPoints, Bool isSpawningCorpses, Bool isSpawningDisembarkers)
  Int spawnedCount = 0
  Int currentActorDataIndex = 0
  While spawnedCount < actorsToSpawn && actorData.Length > 0
    If ShouldSpawnCaptain && !hasSpawnedCaptain && !isSpawningDisembarkers
      If Captain.GetRef() != None
        hasSpawnedCaptain = True
      Else
        hasSpawnedCaptain = True
        ObjectReference captainSpawnMarkerRef = CaptainSpawnMarker.GetRef()
        Actor newCaptain = Self.SpawnGenericActor(captainSpawnMarkerRef, CaptainData, isSpawningCorpses, False)
        Captain.ForceRefTo(newCaptain as ObjectReference)
        spawnedCount += 1
        spawnPoints.insert(captainSpawnMarkerRef, 0)
      EndIf
    ElseIf currentActorDataIndex >= actorData.Length
      currentActorDataIndex = 0
    ElseIf actorData[currentActorDataIndex].InstancesToSpawn == 0
      actorData.remove(currentActorDataIndex, 1)
    ElseIf actorData[currentActorDataIndex].CrewActor == None
      actorData.remove(currentActorDataIndex, 1)
    Else
      If !isSpawningDisembarkers
        Self.SpawnGenericActor(spawnPoints[spawnedCount], actorData[currentActorDataIndex], isSpawningCorpses, isSpawningDisembarkers)
      Else
        Self.SpawnGenericActor(enemyShipRef as ObjectReference, actorData[currentActorDataIndex], isSpawningCorpses, isSpawningDisembarkers)
      EndIf
      spawnedCount += 1
      currentActorDataIndex += 1
    EndIf
  EndWhile
  If ShowTraces
    If isSpawningDisembarkers
      
    ElseIf !isSpawningCorpses
      
    EndIf
  EndIf
  Return spawnedCount
EndFunction

Actor Function SpawnGenericActor(ObjectReference spawnPoint, bescript:genericcrewdatum spawnData, Bool isSpawningCorpses, Bool isSpawningDisembarkers)
  ActorBase actorBaseToSpawn = spawnData.CrewActor
  Int actorLevelMod = 0
  Float actorLevelModChance = Utility.RandomFloat(0.0, 1.0)
  If actorLevelModChance < spawnData.ActorLevelModChanceEasy
    actorLevelMod = 0
  ElseIf actorLevelModChance < spawnData.ActorLevelModChanceEasy + spawnData.ActorLevelModChanceMedium
    actorLevelMod = 1
  Else
    actorLevelMod = 2
  EndIf
  If ShowTraces
    
  EndIf
  Actor newActor = spawnPoint.PlaceActorAtMe(actorBaseToSpawn, actorLevelMod, enemyShipInteriorLoc, False, False, True, None, True)
  If ShowTraces
    
  EndIf
  If isSpawningDisembarkers
    DisembarkingCrew.AddRef(newActor as ObjectReference)
  ElseIf !isSpawningCorpses
    Self.RegisterForRemoteEvent(newActor as ScriptObject, "OnDying")
    AllCrew.AddRef(newActor as ObjectReference)
    If ShouldUseBEObjective && BEObjective_EnemyShip != None && (BEObjective_EnemyShip.GetRef() == enemyShipRef as ObjectReference)
      BEObjective_AllCrew.AddRef(newActor as ObjectReference)
    EndIf
    GenericCrew.AddRef(newActor as ObjectReference)
    newActor.AddKeyword(BECrewDefenderKeyword)
    newActor.SetValue(Suspicious, crewSuspiciousState as Float)
    If ShouldCrewStartInCombat && OwnerFaction == None && !isSurfaceEncounter
      newActor.SetValue(Aggression, CONST_Aggression_VeryAggressive as Float)
    EndIf
    ; --------------------------------------------------------------------------------------
    ; SFCP removed If statement
    ; Bug fix: remove any possibly erroneous crime faction the actor might be a part of.
    ; Only use the ship's crime faction.
    ; --------------------------------------------------------------------------------------
    ;If enemyShipCrimeFaction != None
      newActor.SetCrimeFaction(enemyShipCrimeFaction)
    ;EndIf
    ; --------------------------------------------------------------------------------------
    ; End SFCP Edit
    ; --------------------------------------------------------------------------------------
    ObjectReference spawnLink = spawnPoint.GetLinkedRef(None)
    If spawnLink != None
      newActor.SetLinkedRef(spawnLink, None, True)
    EndIf
    ObjectReference moduleTrigger = spawnPoint.GetLinkedRef(LinkShipModule)
    ObjectReference[] combatTargetRef = CombatTargets.GetArray()
    newActor.SetLinkedRef(moduleTrigger, LinkShipModule, True)
    Int I = 0
    Bool combatTargetFound = False
    While I < combatTargetRef.Length && combatTargetFound == False
      If moduleTrigger == combatTargetRef[I].GetLinkedRef(LinkShipModule)
        newActor.SetLinkedRef(combatTargetRef[I], LinkCombatTravelTarget, True)
        combatTargetFound = True
      EndIf
      I += 1
    EndWhile
    If newActor.HasKeyword(LinkTerminalTurret)
      If turrets.Length > 0
        turrets[turrets.Length - 1].SetLinkedRef(newActor as ObjectReference, LinkTerminalTurret, True)
      EndIf
      turrets.add(newActor, 1)
      GenericTurrets.AddRef(newActor as ObjectReference)
    ElseIf newActor.HasKeyword(ActorTypeRobot)
      If robots.Length > 0
        robots[robots.Length - 1].SetLinkedRef(newActor as ObjectReference, LinkTerminalRobot, True)
      EndIf
      robots.add(newActor, 1)
      GenericRobots.AddRef(newActor as ObjectReference)
    EndIf
  Else
    GenericCorpses.AddRef(newActor as ObjectReference)
  EndIf
  Return newActor
EndFunction

Function SetupComputers()
  ObjectReference[] computersToEnable = new ObjectReference[0]
  ObjectReference cockpitComputer = None
  If ForceEnableCockpitComputer
    cockpitComputer = moduleData[moduleData.findstruct("moduleRef", enemyShipCockpit, 0)].shipComputerRef
    computersToEnable.add(cockpitComputer, 1)
  EndIf
  Bool shouldEnableGenericComputers = False
  If ForceEnableGenericComputers
    shouldEnableGenericComputers = True
  ElseIf robots.Length > 0 || turrets.Length > 0
    If GenericComputersEnableChance > 0.0 && Utility.RandomFloat(0.0, 1.0) < GenericComputersEnableChance
      shouldEnableGenericComputers = True
    EndIf
  EndIf
  If shouldEnableGenericComputers
    If ShouldEnableGenericComputerCockpit && !ForceEnableCockpitComputer
      cockpitComputer = moduleData[moduleData.findstruct("moduleRef", enemyShipCockpit, 0)].shipComputerRef
      computersToEnable.add(cockpitComputer, 1)
    EndIf
    Int genericComputersToEnableCount = 0
    If GenericComputersMax >= 0
      genericComputersToEnableCount = Math.Min(moduleData.Length as Float * GenericComputersModulePercentChance, GenericComputersMax as Float) as Int
    Else
      genericComputersToEnableCount = moduleData.Length * GenericComputersModulePercentChance as Int
    EndIf
    If genericComputersToEnableCount > computersToEnable.Length
      bescript:moduledatum[] randomizedModuleData = Self.CopyAndRandomizeModuleDataArray(moduleData)
      If ShouldPreferGenericComputerThematicModules
        ObjectReference[] nonPreferredComputers = new ObjectReference[0]
        Int i = 0
        While i < moduleData.Length && computersToEnable.Length < genericComputersToEnableCount
          bescript:moduledatum currentModule = moduleData[i]
          ObjectReference currentModuleRef = currentModule.moduleRef
          If currentModule.shipComputerRef != None
            If currentModuleRef.HasLocRefType(Ship_Module_Computer_RefType) || currentModuleRef.HasLocRefType(Ship_Module_Engineering_RefType)
              computersToEnable.add(currentModule.shipComputerRef, 1)
            ElseIf currentModuleRef != enemyShipCockpit
              nonPreferredComputers.add(currentModule.shipComputerRef, 1)
            EndIf
          EndIf
          i += 1
        EndWhile
        If computersToEnable.Length < genericComputersToEnableCount
          i = 0
          While i < nonPreferredComputers.Length
            computersToEnable.add(nonPreferredComputers[i], 1)
            i += 1
          EndWhile
        EndIf
      Else
        Int i = 0
        While i < moduleData.Length && computersToEnable.Length < genericComputersToEnableCount
          bescript:moduledatum currentmodule = moduleData[i]
          If currentmodule.shipComputerRef != None && currentmodule.moduleRef != enemyShipCockpit
            computersToEnable.add(currentmodule.shipComputerRef, 1)
          EndIf
          i += 1
        EndWhile
      EndIf
    EndIf
  EndIf
  Bool enabledAnyComputers = False
  If cockpitComputer != None
    enabledAnyComputers = True
    Computers.AddRef(cockpitComputer)
    cockpitComputer.EnableNoWait(False)
    If GenericComputerRobotLinkStatus < CONST_GenericComputerLinkStatus_None && robots.Length > 0
      cockpitComputer.SetLinkedRef(robots[0] as ObjectReference, LinkTerminalRobot, True)
    EndIf
    If GenericComputerTurretLinkStatus < CONST_GenericComputerLinkStatus_None && turrets.Length > 0
      cockpitComputer.SetLinkedRef(turrets[0] as ObjectReference, LinkTerminalTurret, True)
    EndIf
    ObjectReference linkedContainer = cockpitComputer.GetLinkedRef(LinkTerminalContainer)
    If linkedContainer != None && Utility.RandomFloat(0.0, 1.0) < GenericComputerLinkedContainerLockPercentChance
      linkedContainer.Lock(True, False, True)
      linkedContainer.SetLockLevel(Utility.RandomInt(LockLevelMin, LockLevelMax) * 25)
    EndIf
    If GenericComputerLockPercentChance_Cockpit > 0.0 && Utility.RandomFloat(0.0, 1.0) < GenericComputerLockPercentChance_Cockpit
      cockpitComputer.Lock(True, False, True)
      cockpitComputer.SetLockLevel(Utility.RandomInt(GenericComputerLockLevelMin, GenericComputerLockLevelMax) * 25)
    EndIf
  EndIf
  Int I = 0
  While I < computersToEnable.Length
    enabledAnyComputers = True
    ObjectReference currentComputer = computersToEnable[I]
    If currentComputer != cockpitComputer
      currentComputer.EnableNoWait(False)
      Computers.AddRef(currentComputer)
      If GenericComputerRobotLinkStatus == CONST_GenericComputerLinkStatus_All && robots.Length > 0
        currentComputer.SetLinkedRef(robots[0] as ObjectReference, LinkTerminalRobot, True)
      EndIf
      If GenericComputerTurretLinkStatus == CONST_GenericComputerLinkStatus_All && turrets.Length > 0
        currentComputer.SetLinkedRef(turrets[0] as ObjectReference, LinkTerminalTurret, True)
      EndIf
      ObjectReference linkedcontainer = cockpitComputer.GetLinkedRef(LinkTerminalContainer)
      If linkedcontainer != None && Utility.RandomFloat(0.0, 1.0) < GenericComputerLinkedContainerLockPercentChance
        linkedcontainer.Lock(True, False, True)
        linkedcontainer.SetLockLevel(Utility.RandomInt(LockLevelMin, LockLevelMax) * 25)
      EndIf
      If GenericComputerLockPercentChance_General > 0.0 && Utility.RandomFloat(0.0, 1.0) < GenericComputerLockPercentChance_General
        currentComputer.Lock(True, False, True)
        currentComputer.SetLockLevel(Utility.RandomInt(GenericComputerLockLevelMin, GenericComputerLockLevelMax) * 25)
      EndIf
    EndIf
    I += 1
  EndWhile
  If enabledAnyComputers
    Self.RegisterForCustomEvent(SQ_Parent as ScriptObject, "sq_parentscript_SQ_NativeTerminalActor_Unconscious")
    Self.RegisterForCustomEvent(SQ_Parent as ScriptObject, "sq_parentscript_SQ_NativeTerminalActor_Frenzy")
    Self.RegisterForCustomEvent(SQ_Parent as ScriptObject, "sq_parentscript_SQ_NativeTerminalActor_Ally")
  EndIf
EndFunction

Event ObjectReference.OnCellLoad(ObjectReference akSource)
  Self.UnregisterForRemoteEvent(akSource as ScriptObject, "OnCellLoad")
  Guard BECrewGuard ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    Actor[] genericCorpseRefs = GenericCorpses.GetArray() as Actor[]
    Int I = 0
    While I < genericCorpseRefs.Length
      RE_Parent.KillWithForceNoWait(genericCorpseRefs[I], None, True)
      I += 1
    EndWhile
    I = 0
    While I < BEAliasCorpses.Length
      RE_Parent.KillWithForceNoWait(BEAliasCorpses[I], None, True)
      I += 1
    EndWhile
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
  If ShouldSpawnLoot
    ObjectReference captainsLockerRef = CaptainsLocker.GetRef()
    Int maxCrew = (enemyShipRef.GetBaseValue(SpaceshipCrew) * crewSizePercent) as Int
    If maxCrew == 0
      
    ElseIf maxCrew <= BE_ShipCrewSizeSmall.GetValueInt()
      captainsLockerRef.AddItem(LL_BE_ShipCaptainsLockerLoot_Small as Form, 1, False)
    ElseIf maxCrew <= BE_ShipCrewSizeMedium.GetValueInt()
      captainsLockerRef.AddItem(LL_BE_ShipCaptainsLockerLoot_Medium as Form, 1, False)
    Else
      captainsLockerRef.AddItem(LL_BE_ShipCaptainsLockerLoot_Large as Form, 1, False)
    EndIf
  EndIf
  If StageToSetOnBoarding >= 0
    Self.SetStage(StageToSetOnBoarding)
  EndIf
  If PlayHostileAlarmUponBoarding
    OBJ_Alarm_BoardingAlert.Play(player as ObjectReference, None, None)
  EndIf
  If ShouldCrewStartInCombat && !isSurfaceEncounter && OwnerFaction != None && AllCrew != None && AllCrew.GetCount() > 0
    Actor[] allCrewRefs = AllCrew.GetArray() as Actor[]
    Int i = 0
    While i < allCrewRefs.Length
      Actor current = allCrewRefs[i]
      If current != None
        current.SendAssaultAlarm()
      EndIf
      i += 1
    EndWhile
  EndIf
EndEvent

Function UpdateBoarding()
  If ShowTraces
    
  EndIf
  Int I = 0
  While I < GenericBoarders.GetCount()
    Actor currentBoarder = GenericBoarders.GetAt(I) as Actor
    If currentBoarder != None
      Location currentBoarderLocation = currentBoarder.GetCurrentLocation()
      Bool isAttacking = currentBoarder.HasKeyword(BECrewAttackerKeyword)
      If !isAttacking && currentBoarderLocation == playerShipInteriorLoc
        currentBoarder.RemoveKeyword(BECrewDefenderKeyword)
        currentBoarder.AddKeyword(BECrewAttackerKeyword)
      ElseIf isAttacking && currentBoarderLocation != playerShipInteriorLoc
        currentBoarder.RemoveKeyword(BECrewAttackerKeyword)
        currentBoarder.AddKeyword(BECrewDefenderKeyword)
      EndIf
      If playerShipCockpitRef.GetValue(BEBoarderCapturedModule) == 0.0 && playerShipCockpitRef.IsInTrigger(currentBoarder as ObjectReference)
        playerShipCockpitRef.SetValue(BEBoarderCapturedModule, 1.0)
      EndIf
    EndIf
    I += 1
  EndWhile
  If player.IsInLocation(enemyShipInteriorLoc)
    If ShowTraces
      
    EndIf
  Else
    Bool startedWave = False
    Int slotsForMoreBoarders = maxSimultaneousBoarders - GenericBoarders.GetCount()
    If remainingBoarders.Length > 0 && slotsForMoreBoarders >= MinBoardingWaveSize
      Guard BECrewGuard ;*** WARNING: Experimental syntax, may be incorrect: Guard 
        Int boardersToAdd = Math.Min(remainingBoarders.Length as Float, Math.Min(slotsForMoreBoarders as Float, MaxBoardingWaveSize as Float)) as Int
        If boardersToAdd > 0
          If ShowTraces
            
          EndIf
          startedWave = True
          I = 0
          While I < boardersToAdd
            Actor nextBoarder = remainingBoarders[0]
            ObjectReference randomModule = playerShipModulesAllRefs[Utility.RandomInt(0, playerShipModulesAllRefs.Length - 1)]
            nextBoarder.SetLinkedRef(playerShipCockpitRef, BEBoarderPlayerShipCockpitLink, True)
            nextBoarder.SetLinkedRef(randomModule, BEBoarderPlayerShipModuleLink, True)
            nextBoarder.SetValue(Confidence, CONST_Confidence_Foolhardy as Float)
            If ShouldCrewStartInCombat
              nextBoarder.SetValue(Aggression, CONST_Aggression_VeryAggressive as Float)
            EndIf
            GenericBoarders.AddRef(nextBoarder as ObjectReference)
            If !player.IsInLocation(enemyShipInteriorLoc)
              nextBoarder.Disable(False)
              nextBoarder.RemoveKeyword(BECrewDefenderKeyword)
              nextBoarder.AddKeyword(BECrewAttackerKeyword)
              nextBoarder.MoveTo(playerShipDockingDoorRef, 0.0, 0.0, 0.0, True, False)
              nextBoarder.Enable(True)
            EndIf
            nextBoarder.EvaluatePackage(False)
            If ShowTraces
              
            EndIf
            remainingBoarders.remove(0, 1)
            I += 1
          EndWhile
        EndIf
      EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
    EndIf
  EndIf
  If GenericBoarders.GetCount() > 0
    Self.StartTimer(CONST_BoardingUpdateTimerDelay, CONST_BoardingUpdateTimerID)
  ElseIf ShowTraces
    
  EndIf
EndFunction

Function SetupDisembarking()
  Guard DisembarkingGuard ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    If !hasSetupDisembarking && enemyShipRef.IsLanded()
      hasSetupDisembarking = True
      If DisembarkingCrew.GetCount() > 0
        If ShowTraces
          
        EndIf
        Actor[] disembarkingCrewRefs = DisembarkingCrew.GetArray() as Actor[]
        If ShouldAddDisembarkersToAllCrew
          AllCrew.AddArray(disembarkingCrewRefs as ObjectReference[])
          If ShouldUseBEObjective && (BEObjective_EnemyShip.GetRef() == enemyShipRef as ObjectReference)
            BEObjective_AllCrew.AddArray(disembarkingCrewRefs as ObjectReference[])
          EndIf
          enemyShipRef.ModValue(SpaceshipCrew, disembarkingCrewRefs.Length as Float)
          Int i = 0
          While i < disembarkingCrewRefs.Length
            Self.RegisterForRemoteEvent(disembarkingCrewRefs[i] as ScriptObject, "OnDying")
            i += 1
          EndWhile
        EndIf
        ObjectReference LandingDeckControlMarkerRef = LandingDeckControlMarker.GetRef()
        ObjectReference[] landingDeckMarkerRefs = LandingDeckControlMarkerRef.GetLinkedRefChain(None, 100)
        Int I = 0
        While I < disembarkingCrewRefs.Length && I < landingDeckMarkerRefs.Length
          If ShowTraces
            
          EndIf
          disembarkingCrewRefs[I].MoveTo(landingDeckMarkerRefs[I], 0.0, 0.0, 0.0, True, False)
          I += 1
        EndWhile
        While I < disembarkingCrewRefs.Length
          If ShowTraces
            
          EndIf
          disembarkingCrewRefs[I].MoveTo(LandingDeckControlMarkerRef, 0.0, 0.0, 0.0, True, False)
          I += 1
        EndWhile
        I = 0
        While I < disembarkingCrewRefs.Length
          disembarkingCrewRefs[I].SetValue(BEWaitingForLandingRampValue, 1.0)
          If disembarkersShouldHaveWeaponsUnequipped
            disembarkingCrewRefs[I].SetValue(BEDisembarkWithWeaponsDrawnValue, 1.0)
          EndIf
          disembarkingCrewRefs[I].SetLinkedRef(landingDeckMarkerRefs[landingDeckMarkerRefs.Length - 1], LinkCombatTravelTarget, True)
          disembarkingCrewRefs[I].EnableNoWait(False)
          disembarkingCrewRefs[I].EvaluatePackage(False)
          I += 1
        EndWhile
      EndIf
      Self.SetEnemyShipLandingRampsOpenState(True)
    EndIf
    If !hasStartedDisembarking && (!enemyShipRef.Is3DLoaded() || enemyShipRef.IsRampDown())
      hasStartedDisembarking = True
      Actor[] disembarkingcrewrefs = DisembarkingCrew.GetArray() as Actor[]
      Int i = 0
      While i < disembarkingcrewrefs.Length
        disembarkingcrewrefs[i].SetValue(BEWaitingForLandingRampValue, 0.0)
        disembarkingcrewrefs[i].EvaluatePackage(False)
        i += 1
      EndWhile
      If isDropshipEncounter
        Self.TakeOffWhenAble(True)
      EndIf
    EndIf
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndFunction

Event ObjectReference.OnLoad(ObjectReference akSource)
  Self.SetEnemyShipLandingRampsOpenState(ShouldLandingRampsBeOpenOnLoad)
EndEvent

Function EmbarkAllCrewAndTakeoffWhenAble(Bool shouldQuestShutDownOnTakeoff)
  Self.EmbarkAllCrew()
  Self.TakeOffWhenAble(True)
EndFunction

Function EmbarkAllCrew()
  Self.EmbarkActorsRefCol(AllCrew)
EndFunction

Function EmbarkActorsRefCol(RefCollectionAlias actorsToEmbark)
  Self.EmbarkActors(actorsToEmbark.GetArray() as Actor[])
EndFunction

Function EmbarkActors(Actor[] actorsToEmbark)
  Int I = 0
  While I < actorsToEmbark.Length
    Actor current = actorsToEmbark[I]
    If current != None
      Self.EmbarkActor(current)
    EndIf
    I += 1
  EndWhile
EndFunction

Function EmbarkActor(Actor actorToEmbark)
  If actorToEmbark.GetLinkedRef(LinkShipModule) == None
    actorToEmbark.SetLinkedRef(enemyShipCockpit, LinkShipModule, True)
  EndIf
  DisembarkingCrew.RemoveRef(actorToEmbark as ObjectReference)
  EmbarkingCrew.AddRef(actorToEmbark as ObjectReference)
  actorToEmbark.EvaluatePackage(False)
EndFunction

Function TakeOffWhenAble(Bool shouldQuestShutDownOnTakeoff)
  shouldShutdownOnTakeoff = shouldQuestShutDownOnTakeoff
  Self.StartTimer(CONST_TakeoffUpdateTimerDelay, CONST_TakeoffUpdateTimerID)
EndFunction

Function UpdateTakeoff()
  Bool hasFinishedEmbarking = True
  If EmbarkingCrew == None
    
  ElseIf EmbarkingCrew.GetCount() > 0
    Actor[] embarkingCrewActors = EmbarkingCrew.GetArray() as Actor[]
    Int I = 0
    While I < embarkingCrewActors.Length && hasFinishedEmbarking
      Actor current = embarkingCrewActors[I]
      If current == None || current.IsDead() || current.IsDisabled()
        EmbarkingCrew.RemoveRef(current as ObjectReference)
      ElseIf current.IsInLocation(enemyShipInteriorLoc)
        
      ElseIf !current.Is3DLoaded()
        current.MoveToPackageLocation()
      Else
        hasFinishedEmbarking = False
      EndIf
      I += 1
    EndWhile
  EndIf
  If hasFinishedEmbarking
    If !enemyShipRef.IsExteriorLoadDoorInaccessible()
      If !player.IsInLocation(enemyShipInteriorLoc)
        enemyShipRef.SetExteriorLoadDoorInaccessible(True)
        If enemyShipInteriorLoc != None && player.IsInLocation(enemyShipInteriorLoc)
          enemyShipRef.SetExteriorLoadDoorInaccessible(False)
        EndIf
      EndIf
    EndIf
    If enemyShipRef.IsLandingDeckClear()
      isReadyForTakeoff = True
      If shouldShutdownOnTakeoff
        ShutDownOnUnload = True
        Self.RegisterForRemoteEvent(enemyShipRef as ScriptObject, "OnUnload")
      EndIf
      ObjectReference[] landingRamps = enemyShipRef.GetLandingRamps()
      If landingRamps == None || landingRamps.Length == 0
        Self.FinishTakeoff()
      Else
        Int i = 0
        While i < landingRamps.Length
          Self.RegisterForRemoteEvent(landingRamps[i] as ScriptObject, "OnClose")
          landingRamps[i].SetOpen(False)
          i += 1
        EndWhile
      EndIf
      Return 
    EndIf
  EndIf
  Self.StartTimer(CONST_TakeoffUpdateTimerDelay, CONST_TakeoffUpdateTimerID)
EndFunction

Event ObjectReference.OnClose(ObjectReference akSource, ObjectReference akActionRef)
  If isReadyForTakeoff
    Self.FinishTakeoff()
  EndIf
EndEvent

Function FinishTakeoff()
  ObjectReference exteriorLandingDeckTrigger = enemyShipRef.GetExteriorLoadDoors()[0].GetLinkedRef(None)
  If exteriorLandingDeckTrigger != None
    Actor[] actorsOnLandingDeck = exteriorLandingDeckTrigger.GetAllRefsInTrigger() as Actor[]
    Int I = 0
    While I < actorsOnLandingDeck.Length
      Actor current = actorsOnLandingDeck[I]
      If current != None && current != Game.GetPlayer() && !current.IsEssential()
        actorsOnLandingDeck[I].Kill(None)
      EndIf
      I += 1
    EndWhile
  EndIf
  enemyShipRef.DisableWithTakeoffOrLanding()
  If ShutDownOnUnload
    Self.CleanupAndStop()
  EndIf
EndFunction

Function SetCrewPlayerFriend(Bool shouldBeFriends, Bool shouldStartOrStopCombat)
  Guard BECrewGuard ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    Int I = 0
    While I < AllCrew.GetCount()
      Self.SetPlayerFriend(AllCrew.GetAt(I), shouldBeFriends, shouldStartOrStopCombat)
      I += 1
    EndWhile
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
  Self.SetPlayerFriend(EnemyShip.GetRef(), shouldBeFriends, shouldStartOrStopCombat)
  If shouldBeFriends
    shouldAbortBoarding = True
  EndIf
EndFunction

Function SetPlayerFriend(ObjectReference target, Bool shouldBeFriends, Bool shouldStartOrStopCombat)
  If shouldBeFriends
    target.TryToAddToFaction(REPlayerFriend)
    If shouldStartOrStopCombat
      target.TryToStopCombat()
    EndIf
  Else
    target.TryToRemoveFromFaction(REPlayerFriend)
    If shouldStartOrStopCombat
      target.TryToStartCombat(player as ObjectReference, False)
      target.TryToStartCombat(PlayerShip.GetRef(), False)
    EndIf
  EndIf
  target.TryToEvaluatePackage()
EndFunction

Function RemoveCrewKeywords(Actor target)
  target.RemoveKeyword(BECrewAttackerKeyword)
  target.RemoveKeyword(BECrewDefenderKeyword)
EndFunction

Bool Function CheckForCrewCriticalHit()
  Return ShouldSupportCrewCriticalHit && !isSurfaceEncounter && enemyShipRef.GetValue(SpaceshipCriticalHitCrew) == 1.0
EndFunction

Function DecompressShipAndKillCrew()
  Bool isPlayerInEnemyShip = Game.GetPlayer().GetParentCell() == enemyShipCell
  Bool blockZeroG = GenericRobots != None && GenericRobots.GetCount() > 0
  Actor[] allCrewRefs = AllCrew.GetArray() as Actor[]
  Int I = 0
  While I < allCrewRefs.Length
    Actor current = allCrewRefs[I]
    If current != None
      If current.HasKeyword(ActorTypeRobot)
        blockZeroG = True
      ElseIf current.HasKeyword(ActorTypeTurret)
        
      Else
        current.Kill(None)
      EndIf
    EndIf
    I += 1
  EndWhile
  If HeatLeeches != None
    If !isPlayerInEnemyShip
      I = 0
      While I < HeatLeeches.Length
        HeatLeeches[I].DisableNoWait(False)
        I += 1
      EndWhile
    Else
      blockZeroG = True
    EndIf
  EndIf
  Self.SetShipHasOxygen(False)
  If blockZeroG
    
  Else
    Self.SetShipGravity(0.0)
  EndIf
EndFunction

Function SetShipGravity(Float newGravity)
  If newGravity < 0.0
    
  ElseIf ShouldOverrideGravityOnlyInSpace && isSurfaceEncounter
    
  Else
    ShipGravity = newGravity
    enemyShipCell.SetGravityScale(ShipGravity)
  EndIf
EndFunction

Function SetShipHasOxygen(Bool hasOxygen)
  If hasOxygen
    enemyShipRef.RemoveKeyword(ENV_Loc_NotSealedEnvironment)
  Else
    enemyShipRef.AddKeyword(ENV_Loc_NotSealedEnvironment)
  EndIf
EndFunction

Function SetShipHazard(Hazard newHazard)
  If enemyShipHazard != None
    enemyShipHazard.Disable(False)
    enemyShipHazard.Delete()
  EndIf
  If newHazard == None
    enemyShipHazard = None
  Else
    enemyShipHazard = enemyShipCockpit.PlaceAtMe(newHazard as Form, 1, False, False, True, None, None, True)
    ObjectReference[] allModuleRefs = AllModules.GetArray()
    Int I = 0
    While I < allModuleRefs.Length
      allModuleRefs[I].SetLinkedRef(enemyShipHazard, LinkHazardVolume, True)
      If allModuleRefs[I].IsInTrigger(player as ObjectReference)
        allModuleRefs[I].Disable(False)
        allModuleRefs[I].Enable(False)
      EndIf
      I += 1
    EndWhile
  EndIf
EndFunction

Function SetModuleHazard(ObjectReference module, Hazard newHazard)
  ObjectReference currentHazardRef = module.GetLinkedRef(LinkHazardVolume)
  If currentHazardRef != None && currentHazardRef != enemyShipHazard
    currentHazardRef.Disable(False)
    currentHazardRef.Delete()
  EndIf
  If newHazard == None
    module.SetLinkedRef(None, LinkHazardVolume, True)
  Else
    ObjectReference newHazardRef = module.PlaceAtMe(newHazard as Form, 1, False, False, True, None, None, True)
    module.SetLinkedRef(newHazardRef, LinkHazardVolume, True)
    If module.IsInTrigger(player as ObjectReference)
      module.Disable(False)
      module.Enable(False)
    EndIf
  EndIf
EndFunction

Function SpawnContraband()
  ObjectReference[] PotentialContrabandSpawnPoints = SmallItemSpawnMarkers.GetArray()
  Int contrabandToSpawn = Utility.RandomInt(ContrabandMin, Math.Min(ContrabandMax as Float, PotentialContrabandSpawnPoints.Length as Float) as Int)
  Int I = 0
  While I < contrabandToSpawn
    Contraband.AddRef(PotentialContrabandSpawnPoints[I].PlaceAtMe(Loot_LPI_Contraband_Any as Form, 1, False, False, True, None, None, True))
    PotentialContrabandSpawnPoints[I].AddKeyword(BEMarkerInUseKeyword)
    I += 1
  EndWhile
EndFunction

ObjectReference Function GetEnemyShipLoadDoorMarker()
  If isSurfaceEncounter
    
  Else
    ObjectReference playerShipDoorRef = PlayerShipLoadDoor.GetRef()
    If playerShipDoorRef != None
      ObjectReference enemyShipDoorRef = playerShipDoorRef.GetLinkedRef(LinkShipLoadDoor)
      ObjectReference enemyShipTeleportMarker = enemyShipDoorRef.GetLinkedRef(DynamicallyLinkedDoorTeleportMarkerKeyword)
      If enemyShipTeleportMarker != None
        Return enemyShipTeleportMarker
      ElseIf enemyShipDoorRef != None
        Return enemyShipDoorRef
      EndIf
    EndIf
  EndIf
  Return None
EndFunction

Bool Function hasInitialized()
  Return hasInitialized
EndFunction

Function WaitUntilInitialized()
  Int failsafe = 0
  While !hasInitialized && failsafe < CONST_WaitUntilInitializedTimeoutDelay
    failsafe += 1
    Utility.Wait(1.0)
  EndWhile
  If failsafe == CONST_WaitUntilInitializedTimeoutDelay
    
  EndIf
EndFunction

Int Function GetLandingRampsOpenState()
  ObjectReference[] landingRamps = enemyShipRef.GetLandingRamps()
  If landingRamps == None
    Return 0
  EndIf
  If landingRamps.Length == 0
    Return 0
  EndIf
  Return landingRamps[0].GetOpenState()
EndFunction

Function SetEnemyShipLandingRampsOpenState(Bool abOpen)
  ShouldLandingRampsBeOpenOnLoad = abOpen
  ObjectReference[] landingRamps = enemyShipRef.GetLandingRamps()
  Bool loaded = enemyShipRef.WaitFor3DLoad()
  If loaded && enemyShipRef.IsLanded() && landingRamps != None
    Int I = 0
    While I < landingRamps.Length
      landingRamps[I].SetOpen(abOpen)
      I += 1
    EndWhile
  EndIf
  If abOpen && SpaceshipPreventRampOpenOnLanding as Bool
    enemyShipRef.RemoveKeyword(SpaceshipPreventRampOpenOnLanding)
  EndIf
EndFunction

bescript:moduledatum[] Function CopyModuleDataArray(bescript:moduledatum[] input)
  bescript:moduledatum[] output = new bescript:moduledatum[input.Length]
  Int I = 0
  While I < input.Length
    output[I] = input[I]
    I += 1
  EndWhile
  Return output
EndFunction

bescript:moduledatum[] Function CopyAndRandomizeModuleDataArray(bescript:moduledatum[] input)
  bescript:moduledatum[] output = Self.CopyModuleDataArray(input)
  Float[] random = Utility.RandomFloatsFromSeed(Utility.RandomInt(0, 100000), output.Length, 0.0, 1.0)
  Int I = output.Length - 1
  While I >= 0
    Int currentRandomIndex = (random[I] * I as Float) as Int
    bescript:moduledatum temp = output[I]
    output[I] = output[currentRandomIndex]
    output[currentRandomIndex] = temp
    I -= 1
  EndWhile
  Return output
EndFunction

Function DEBUG_ForceUpdateAllCrew()
  Int I = 0
  Actor[] allCrewActors = AllCrew.GetArray() as Actor[]
  While I < allCrewActors.Length
    allCrewActors[I].MoveToPackageLocation()
    I += 1
  EndWhile
EndFunction

Function DEBUG_SetLandingRampOpen(Bool shouldBeOpen)
  Self.SetEnemyShipLandingRampsOpenState(shouldBeOpen)
EndFunction

Function DEBUG_SetDoorInaccessible(Bool shouldBeInaccessible)
  enemyShipRef.SetExteriorLoadDoorInaccessible(shouldBeInaccessible)
EndFunction

Function PATCH_RetryTakeoff()
  If Self.IsRunning()
    If isReadyForTakeoff
      Self.UpdateTakeoff()
    EndIf
  EndIf
EndFunction
