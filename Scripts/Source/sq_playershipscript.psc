ScriptName SQ_PlayerShipScript Extends Quest

;-- Variables ---------------------------------------
Bool bShowNormalTrace = True
Int iDialogueEventTimerID = 1 Const
inputenablelayer myTestLayer

;-- Guards ------------------------------------------
;*** WARNING: Guard declaration syntax is EXPERIMENTAL, subject to change
Guard CrewAssignmentLock
Guard playerShipsChangeLock

;-- Properties --------------------------------------
Group DismissedCrewData
  RefCollectionAlias Property DismissedCrew Auto Const mandatory
  { collection of dismissed crew who are on board - crew is removed from this alias when they manage to leave the ship }
  RefCollectionAlias Property DisembarkingCrew Auto Const mandatory
  { collection of crew trying to disembark - gives a package to a landing exit marker }
  LocationAlias Property LandingLocation Auto Const mandatory
  { filled by script to test for a valid exit marker (for dismissed crew) }
  ReferenceAlias Property LandingLocationExitMarker Auto Const mandatory
  { used for dismissed crew to exit }
  Keyword Property SQ_LinkCompanionEliteCrewHomeMarker Auto Const mandatory
  { used for dismissed elite crew to go home if it's somewhere other than their editor location }
EndGroup

Group PlayerShipAliases
  ReferenceAlias Property PlayerShip Auto mandatory
  { alias holding current player ship - for other quests to access }
  LocationAlias Property playerShipExteriorLocation Auto Const mandatory
  LocationAlias Property playerShipInteriorLocation Auto Const mandatory
  ReferenceAlias Property PlayerShipCockpitModule Auto mandatory
  ReferenceAlias Property InteriorRobotBay Auto Const mandatory
  ReferenceAlias Property LandingDeckNearRampMarker Auto Const mandatory
  ReferenceAlias Property LandingDeckNearRobotBay Auto Const mandatory
  ReferenceAlias Property PlayerShipPilotSeat Auto Const mandatory
  ReferenceAlias Property HomeShipCrewMarker Auto mandatory
  ReferenceAlias Property HomeShipPassengerMarker Auto mandatory
  ReferenceAlias Property PlayerShipSpaceshipInventory Auto Const mandatory
  ReferenceAlias Property PlayerShipWorkshop Auto Const mandatory
  ReferenceAlias Property PlayerShipLandingMarker Auto mandatory
EndGroup

Group keywords
  Keyword Property LandingMarkerKeyword Auto Const mandatory
  { used to find landing marker }
  Keyword Property LandingZoneTriggerKeyword Auto Const mandatory
  { used to find landing zone trigger }
  Keyword Property SQ_LinkPlayerShipGoHome Auto Const mandatory
  { link player ships so they know where to go when sent "home" }
  Keyword Property SpaceshipStoredLink Auto Const mandatory
  { link non-home ships to landing marker }
  Keyword Property BEEncounterTypeDocking Auto Const mandatory
  { Keyword used to start Boarding Encounters when the player's ship docks with any other ship. }
  Keyword Property SQ_PlayerShipDialogueEvent Auto Const mandatory
  { keyword used to start random conversations on the player's ship }
  Keyword Property SQ_PlayerShipTakeoffEvent Auto Const mandatory
  { keyword sent to story manager when player's ship takes off }
  Keyword Property CannotBeHomeShip Auto Const mandatory
  { keyword to check before making home ship }
  Keyword Property LinkShipLandingOverlayMapMarker Auto Const mandatory
  { used to find map marker in ship landing overlay }
  Keyword Property SpaceshipLinkedInterior Auto Const mandatory
  { used to get ship interior cell }
  Keyword Property SpaceshipPreventRampOpenOnLanding Auto Const mandatory
  { keyword that prevents landing ramp from opening on landing - need to remove in case ship was previously tagged with this }
  Keyword Property IsStarstation Auto Const mandatory
  { keyword to check before making home ship }
  Keyword Property SpaceshipImmobile Auto Const mandatory
  { keyword to check before making home ship }
EndGroup

Group DebugUseOnly
  ActorValue Property SpaceshipLandedValue Auto Const mandatory
  { DO NOT SET THIS IN NON DEBUG SITUATIONS...
Used by UI to know that a ship has landed. This needs to be set before you can assign crew to ship. BUt currently the player has to be in the laoded area of the ship to get that set. }
  Keyword Property CurrentInteractionLinkedRefKeyword Auto Const mandatory
  { keyword used to move player's ship when debugging a forced move }
  ObjectReference Property Frontier_ModularREF Auto Const mandatory
  { autofill }
  ObjectReference Property NewGameShipMarkerREF Auto Const mandatory
  { autofill }
  ObjectReference Property NewAtlantisShipLandingMarker Auto Const mandatory
  { autofill }
  ActorBase Property MissionBoardPassenger_Type06 Auto Const mandatory
  { autofill }
EndGroup

Group PassengerData
  ActorValue Property SpaceshipPassengerSlots Auto Const mandatory
  { tracks how mamy passengers allowed on player ship }
  RefCollectionAlias Property Passengers Auto Const mandatory
  { collection holding passengers }
EndGroup

Group SerpentsEmbraceProperties
  Perk Property TRAIT_SerpentsEmbrace Auto Const mandatory
  { autofill }
  Spell Property Trait_SerpentsEmbrace_Buff Auto Const mandatory
  { autofill }
EndGroup

Group AchivementsData
  Int Property ModifyShipAchievement = 26 Auto Const
  { achievement for collecting ships }
  Int Property CollectShipsAchievement = 41 Auto Const
  { achievement for collecting ships }
  Int Property CollectShipsAchievementCount = 10 Auto Const
  { number of ships to own to get achievement }
EndGroup

ReferenceAlias Property Vasco Auto Const mandatory
LocationAlias Property VascoWaitLocation Auto Const mandatory
{ autofill; used to get Vasco to wait for player outside hatch at space stations, etc. }
ReferenceAlias Property VascoWaitMarker Auto Const mandatory
{ autofill; used to get Vasco to wait for player outside hatch at space stations, etc. }
LocationRefType Property Crew_VascoWaitRefType Auto Const mandatory
{ autofill; used to get Vasco to wait for player outside hatch at space stations, etc. }
Faction Property CurrentFollowerFaction Auto Const mandatory
{ autofill }
Faction Property CurrentCrewFaction Auto Const mandatory
{ autofill }
Faction Property PlayerFaction Auto Const mandatory
sq_parentscript Property SQ_Parent Auto Const mandatory
sq_followersscript Property SQ_Followers Auto Const mandatory
ReferenceAlias Property HomeShip Auto Const mandatory
{ alias holding player home ship - usually this is the same as PlayerShip but not always }
LocationAlias Property HomeShipExteriorLocation Auto Const mandatory
{ locAlias holding the player home ship exterior }
LocationAlias Property HomeShipInteriorLocation Auto Const mandatory
{ locAlias holding the player home ship interior }
ReferenceAlias Property HomeShipArmillary Auto Const mandatory
{ alias holding potential armillary object on the player's home ship exterior }
ReferenceAlias Property HomeShipArmillaryScreen Auto Const mandatory
{ alias holding armillary screen activator on the player's home ship interior }
ReferenceAlias Property HomeShipArmillaryScreenTrigger Auto Const mandatory
{ alias holding armillary screen activator trigger that the player will actually activate }
GlobalVariable Property MQAlllowArmillaryGravDrive Auto Const mandatory
ReferenceAlias Property PreviousHomeShip Auto Const mandatory
{ alias holding previous home ship - used for text replacement in home ship message }
RefCollectionAlias Property PlayerShips Auto Const mandatory
{ collection of all player ships }
ReferenceAlias Property HomeShipMarker Auto Const mandatory
{ TEMP - for now, link all home ships to this marker so they know how to "go home"
  this needs to move into UI at some point and/or we need a way to "stack" ships in a single location
  `TTP-29740: Ships: figure out how multiple player ships can exist at a single location` }
RefCollectionAlias Property BoardingCrew Auto Const mandatory
{ put crew in this collection to pick up "defensive" packages }
RefCollectionAlias Property PlayerShipDockingPortDoors Auto Const mandatory
{ put docking port doors in this collection }
Int Property Tutorial_NewHomeShip_Stage = 10 Auto Const
{ tutorial stage for when you get a new home ship }
Message Property SQ_PlayerShip_NewHomeShipMessage Auto Const mandatory
{ message when player switches home ship }
Message Property SQ_PlayerShip_NewHomeShipMessageNoReturn Auto Const mandatory
{ message when player switches home ship, but previous home ship is still player ship }
LocationRefType Property Ship_PilotSeat_RefType Auto Const mandatory
{ used to check if player sits in a pilot seat }
ActorValue Property SpaceshipDockingPermission Auto Const mandatory
{ used to check the ship docking with me }
sq_crewscript Property SQ_Crew Auto Const mandatory
reparentscript Property RE_Parent Auto Const mandatory
{ send RE cleanup events }
GlobalVariable Property MQ101VascoQuestFollower Auto Const mandatory
{ Special MQ101 handling for Vasco }
ReferenceAlias Property MQ00_Armillary Auto Const mandatory
{ Special MQ Alias to hold the Armillary }
GlobalVariable Property MQArmillaryLocation Auto Const mandatory
{ special Global to check where the Armillary is. 1 = on HomeShip, 0 = on player, 2 = at Outpost }
ActorValue Property FOL_ActiveFollower Auto Const mandatory
{ track if crew member has been dismissed }
ActorValue Property COM_PQ_LockedIn Auto Const mandatory
{ track if crew member is Locked In }
Float Property fDialogueEventTimeSecondsMin = 120.0 Auto Const
{ how often is the scripted "dialogue event" sent while the player is on the ship }
Float Property fDialogueEventTimeSecondsMax = 240.0 Auto Const
{ how often is the scripted "dialogue event" sent while the player is on the ship }

;-- Functions ---------------------------------------

Event ReferenceAlias.OnShipFarTravel(ReferenceAlias akSender, Location aDepartureLocation, Location aArrivalLocation, Int aState)
  ; Empty function
EndEvent

Function TestGetCurrentPlanet(ObjectReference testRef)
  ; Empty function
EndFunction

Function SendPlayerShipChangedEvent(spaceshipreference newPlayerShip)
  Var[] kargs = new Var[1]
  kargs[0] = newPlayerShip as Var
  Self.SendCustomEvent("sq_playershipscript_SQ_PlayerShipChanged", kargs)
EndFunction

Function SendPlayerSellShipEvent(spaceshipreference akShip)
  Var[] kargs = new Var[1]
  kargs[0] = akShip as Var
  Self.SendCustomEvent("sq_playershipscript_SQ_PlayerSellShip", kargs)
EndFunction

Function LoadCrewInterior()
  spaceshipreference homeShipRef = HomeShip.GetShipRef()
  ObjectReference crewMarker = HomeShipCrewMarker.GetRef()
  ObjectReference passengerMarker = HomeShipPassengerMarker.GetRef()
  Actor VascoREF = Vasco.GetActorRef()
  Self.LoadVascoInterior()
  If homeShipRef
    If crewMarker
      Actor[] crewList = homeShipRef.GetAllCrewMembers()
      If crewList == None
        crewList = new Actor[0]
      EndIf
      Actor[] dismissedCrewList = DismissedCrew.GetActorArray()
      Int I = 0
      While I < dismissedCrewList.Length
        Actor currentDismissedActor = dismissedCrewList[I]
        Bool notDisembarking = DisembarkingCrew.Find(currentDismissedActor as ObjectReference) < 0
        If notDisembarking
          crewList.add(currentDismissedActor, 1)
        EndIf
        I += 1
      EndWhile
      I = 0
      While I < crewList.Length
        Actor crew = crewList[I]
        If crew != VascoREF
          If crew.GetValue(COM_PQ_LockedIn) == 1.0 && crew.GetValue(FOL_ActiveFollower) == 0.0
            
          ElseIf crew.IsInLocation(playerShipInteriorLocation.GetLocation()) == False
            If crew.GetValue(FOL_ActiveFollower)
              
            Else
              crew.MoveTo(crewMarker, 0.0, 0.0, 0.0, True, False)
            EndIf
          EndIf
        EndIf
        I += 1
      EndWhile
    EndIf
    If passengerMarker
      Int i = 0
      While i < Passengers.GetCount()
        ObjectReference theRef = Passengers.GetAt(i)
        If theRef.GetValue(FOL_ActiveFollower)
          
        ElseIf theRef.IsDisabled() || theRef.IsInLocation(playerShipInteriorLocation.GetLocation())
          
        Else
          theRef.MoveTo(passengerMarker, 0.0, 0.0, 0.0, True, False)
        EndIf
        i += 1
      EndWhile
    EndIf
  EndIf
EndFunction

Function LoadVascoExterior()
  Actor VascoREF = Vasco.GetActorRef()
  If VascoREF.IsInFaction(CurrentFollowerFaction) || VascoREF.IsInFaction(CurrentCrewFaction) || MQ101VascoQuestFollower.GetValueInt() == 1
    ObjectReference movetoRef = None
    Location currentLoc = Game.GetPlayer().GetCurrentLocation()
    If currentLoc.HasRefType(Crew_VascoWaitRefType)
      VascoWaitLocation.ForceLocationTo(currentLoc)
      VascoWaitMarker.RefillAlias()
      movetoRef = VascoWaitMarker.GetReference()
    Else
      movetoRef = LandingDeckNearRobotBay.GetRef()
      If movetoRef.IsInSpace()
        movetoRef = None
      EndIf
    EndIf
    If movetoRef
      VascoREF.MoveTo(movetoRef, 0.0, 0.0, 0.0, True, False)
      VascoREF.EvaluatePackage(False)
    EndIf
  EndIf
EndFunction

Function LoadVascoInterior()
  Actor VascoREF = Vasco.GetActorRef()
  spaceshipreference playerShipRef = PlayerShip.GetShipRef()
  If playerShipRef.IsCrew(VascoREF) || SQ_Crew.IsActiveEliteCrew(VascoREF) || MQ101VascoQuestFollower.GetValueInt() == 1
    ObjectReference RobotBayREF = InteriorRobotBay.GetRef()
    If RobotBayREF as Bool && playerShipInteriorLocation != None
      If VascoREF.IsInLocation(playerShipInteriorLocation.GetLocation()) == False
        VascoREF.MoveToFurniture(RobotBayREF)
        VascoREF.EvaluatePackage(False)
      EndIf
    EndIf
  EndIf
EndFunction

Function ResetPlayerShip(spaceshipreference newPlayerShip)
  Guard playerShipsChangeLock ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    PlayerShip.ForceRefTo(newPlayerShip as ObjectReference)
    newPlayerShip.SetExteriorLoadDoorInaccessible(False)
    playerShipExteriorLocation.ClearAndRefillAlias()
    playerShipInteriorLocation.ClearAndRefillAlias()
    playerShipExteriorLocation.RefillDependentAliases()
    playerShipInteriorLocation.RefillDependentAliases()
    PlayerShipSpaceshipInventory.GetRef().Unlock(False)
    If newPlayerShip == HomeShip.GetShipRef()
      Self.RefillHomeShipAliases()
    EndIf
    Self.SendPlayerShipChangedEvent(newPlayerShip)
    If PlayerShipLandingMarker.GetRef() as Bool && newPlayerShip.IsInSpace()
      Self.HandleShipTakeOff(False, False)
    EndIf
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndFunction

Function RefillHomeShipAliases()
  HomeShipPassengerMarker.Clear()
  HomeShipExteriorLocation.ClearAndRefillAlias()
  HomeShipInteriorLocation.ClearAndRefillAlias()
  HomeShipExteriorLocation.RefillDependentAliases()
  HomeShipInteriorLocation.RefillDependentAliases()
  Self.ResetHomeShipArmillary()
EndFunction

Function ResetHomeShip(spaceshipreference newHomeShip)
  If PlayerShip.GetRef() == None
    Self.ResetPlayerShip(newHomeShip)
  EndIf
  spaceshipreference oldHomeShip = HomeShip.GetShipRef()
  If newHomeShip != oldHomeShip && newHomeShip.HasKeyword(CannotBeHomeShip) == False && newHomeShip.HasKeyword(IsStarstation) == False && newHomeShip.HasKeyword(SpaceshipImmobile) == False
    Game.TrySetPlayerHomeSpaceShip(newHomeShip as ObjectReference)
  EndIf
  Self.EnableHomeShipArmillaryScreen()
EndFunction

Function EnableHomeShipArmillaryScreen()
  ObjectReference ArmillaryScreenTriggerREF = HomeShipArmillaryScreenTrigger.GetRef()
  If MQAlllowArmillaryGravDrive.GetValueInt() >= 1 && ArmillaryScreenTriggerREF.IsDisabled()
    ArmillaryScreenTriggerREF.Enable(False)
  EndIf
  If MQArmillaryLocation.GetValueInt() == 1
    HomeShipArmillaryScreen.GetRef().PlayAnimation("Play01")
  EndIf
EndFunction

Function ResetHomeShipArmillary()
  ObjectReference ArmillaryREF = MQ00_Armillary.GetRef()
  ObjectReference HomeShipArmillaryREF = HomeShipArmillary.GetRef()
  Actor PlayerREF = Game.GetPlayer()
  Bool bArmillaryOnHomeShip = False
  If MQArmillaryLocation.GetValueInt() == 1 && HomeShipArmillaryREF != ArmillaryREF
    (ArmillaryREF as armillaryscript).PackupArmillary(PlayerREF)
    (HomeShipArmillaryREF as armillaryscript).BuildArmillary(PlayerREF, HomeShipArmillaryScreenTrigger.GetRef())
  EndIf
EndFunction

Event OnQuestInit()
  Actor PlayerREF = Game.GetPlayer()
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnHomeShipSet")
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerModifiedShip")
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnExitShipInterior")
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnEnterShipInterior")
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnSit")
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerBuyShip")
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerSellShip")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipLanding")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipTakeOff")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipDock")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipUndock")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipGravJump")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipFarTravel")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipScan")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnLocationChange")
  Self.RegisterForRemoteEvent(PlayerShips as ScriptObject, "OnCrewDismissed")
  Self.RegisterForRemoteEvent(PlayerShips as ScriptObject, "OnCrewAssigned")
  Self.RegisterForRemoteEvent(PlayerShips as ScriptObject, "OnDeath")
  Self.RegisterForRemoteEvent(PlayerShips as ScriptObject, "OnLocationChange")
  ObjectReference playerShipInventoryRef = PlayerShipSpaceshipInventory.GetRef()
  If playerShipInventoryRef != None
    playerShipInventoryRef.Unlock(False)
  EndIf
EndEvent

Event Actor.OnPlayerBuyShip(Actor akSender, spaceshipreference akShip)
  Guard playerShipsChangeLock ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    PlayerShips.AddRef(akShip as ObjectReference)
    Self.CheckForShipAchievements()
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndEvent

Event Actor.OnPlayerSellShip(Actor akSenderRef, spaceshipreference akShip)
  Self.RemovePlayerShip(akShip)
  Self.SendPlayerSellShipEvent(akShip)
EndEvent

Event RefCollectionAlias.OnDeath(RefCollectionAlias akSender, ObjectReference akSenderRef, ObjectReference akKiller)
  spaceshipreference akShip = akSenderRef as spaceshipreference
  If akShip
    Self.RemovePlayerShip(akShip)
  EndIf
EndEvent

Function RemovePlayerShip(spaceshipreference akShip)
  Guard playerShipsChangeLock ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    If PlayerShips.Find(akShip as ObjectReference) > -1
      If HomeShip.GetRef() != akShip as ObjectReference
        PlayerShips.RemoveRef(akShip as ObjectReference)
        Game.RemovePlayerOwnedShip(akShip)
      EndIf
    EndIf
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndFunction

Function AddPlayerOwnedShip(spaceshipreference akShip)
  Guard playerShipsChangeLock ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    Game.AddPlayerOwnedShip(akShip)
    PlayerShips.AddRef(akShip as ObjectReference)
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndFunction

Event Actor.OnSit(Actor akSender, ObjectReference akFurniture)
  If akFurniture.HasRefType(Ship_PilotSeat_RefType)
    spaceshipreference newShip = Game.GetPlayer().GetCurrentShipRef()
    If HomeShip.GetRef() == None
      Self.ResetHomeShip(newShip)
    Else
      Self.ResetPlayerShip(newShip)
    EndIf
  EndIf
EndEvent

Event Actor.OnEnterShipInterior(Actor akSender, ObjectReference akShip)
  If akShip == Game.GetPlayerHomeSpaceShip() as ObjectReference
    Self.ResetPlayerShip(Game.GetPlayer().GetCurrentShipRef())
    Self.LoadCrewInterior()
    Self.StartDialogueTimer()
    Self.EnableHomeShipArmillaryScreen()
  EndIf
EndEvent

Event Actor.OnExitShipInterior(Actor akSender, ObjectReference akShip)
  Self.LoadVascoExterior()
EndEvent

Event ReferenceAlias.OnShipLanding(ReferenceAlias akSender, Bool abComplete)
  spaceshipreference playerShipRef = PlayerShip.GetShipRef()
  If !abComplete
    If playerShipRef != None
      Self.ClearLandingZone(playerShipRef)
    EndIf
  Else
    ObjectReference landingMarker = playerShipRef.GetLinkedRef(LandingMarkerKeyword)
    ObjectReference oldLandingMarker = PlayerShipLandingMarker.GetRef()
    If oldLandingMarker as Bool && oldLandingMarker != landingMarker
      SQ_Followers.TeleportWaitingFollowersToShip(None)
      Self.HandleShipTakeOff(True, True)
    EndIf
    PlayerShipLandingMarker.ForceRefTo(landingMarker)
    Self.ResetHomeShip(playerShipRef)
    Self.CheckForDismissedCrew()
    SQ_Parent.CheckCompletePlanetSurvey(playerShipRef.GetCurrentPlanet(), False)
  EndIf
EndEvent

Event ReferenceAlias.OnShipTakeoff(ReferenceAlias akSender, Bool abComplete)
  If !abComplete
    Self.HandleShipTakeOff(True, False)
  EndIf
EndEvent

Event ReferenceAlias.OnShipDock(ReferenceAlias akSource, Bool abComplete, spaceshipreference akDocking, spaceshipreference akParent)
  If abComplete == False
    spaceshipreference playerShipRef = PlayerShip.GetShipRef()
    spaceshipreference otherShipRef = None
    If playerShipRef == akDocking
      otherShipRef = akParent
    Else
      otherShipRef = akDocking
    EndIf
    BEEncounterTypeDocking.SendStoryEvent(None, akSource.GetRef(), otherShipRef as ObjectReference, 100, 0)
    Actor player = Game.GetPlayer()
    If otherShipRef as Bool && otherShipRef.GetActorFactionReaction(player) == 1
      Actor[] myCrew = playerShipRef.GetAllCrewMembers()
      BoardingCrew.AddArray(myCrew as ObjectReference[])
    EndIf
  EndIf
EndEvent

Event ReferenceAlias.OnShipUndock(ReferenceAlias akSource, Bool abComplete, spaceshipreference akUndocking, spaceshipreference akParent)
  If abComplete
    BoardingCrew.RemoveAll()
  EndIf
EndEvent

Event ReferenceAlias.OnShipGravJump(ReferenceAlias akSender, Location aDestination, Int aState)
  If aState == 1
    spaceshipreference currentPlayerShip = Game.GetPlayer().GetCurrentShipRef()
    If currentPlayerShip == akSender.GetShipRef()
      Self.ResetHomeShip(currentPlayerShip)
    EndIf
  EndIf
  Actor PlayerREF = Game.GetPlayer()
  If aState == 2 && PlayerREF.HasPerk(TRAIT_SerpentsEmbrace)
    PlayerREF.DispelSpell(Trait_SerpentsEmbrace_Buff)
    Trait_SerpentsEmbrace_Buff.Cast(PlayerREF as ObjectReference, PlayerREF as ObjectReference)
  EndIf
  RE_Parent.SendCleanupEvent()
EndEvent

Event ReferenceAlias.OnShipScan(ReferenceAlias akSender, Location aPlanet, ObjectReference[] aMarkersArray)
  planet planetToCheck = aPlanet.GetCurrentPlanet()
  SQ_Parent.OnPlayerScanPlanet(planetToCheck)
EndEvent

Event ReferenceAlias.OnLocationChange(ReferenceAlias akSender, Location akOldLoc, Location akNewLoc)
  Self.UpdateDismissedCrew()
  Self.LoadCrewInterior()
  RE_Parent.SendCleanupEvent()
EndEvent

Event RefCollectionAlias.OnLocationChange(RefCollectionAlias akSource, ObjectReference akSenderRef, Location akOldLoc, Location akNewLoc)
  If akSource == PlayerShips && akSenderRef != HomeShip.GetRef()
    ObjectReference homeMarkerRef = akSenderRef.GetLinkedRef(SpaceshipStoredLink)
    If homeMarkerRef as Bool && homeMarkerRef.GetCurrentLocation() == akNewLoc
      akSenderRef.DisableNoWait(False)
    EndIf
  EndIf
EndEvent

Event RefCollectionAlias.OnCrewDismissed(RefCollectionAlias akSource, ObjectReference akSenderRef, Actor akCrew, ObjectReference akPreviousAssignmentRef)
  Guard CrewAssignmentLock ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    If SQ_Crew.HandleOnCrewDismissed(akCrew, akPreviousAssignmentRef)
      DismissedCrew.AddRef(akCrew as ObjectReference)
      Self.CheckForDismissedCrew()
    EndIf
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndEvent

Event RefCollectionAlias.OnCrewAssigned(RefCollectionAlias akSource, ObjectReference akSenderRef, Actor akCrew, ObjectReference akAssignmentRef, ObjectReference akPreviousAssignmentRef)
  Guard CrewAssignmentLock ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    SQ_Crew.HandleOnCrewAssigned(akCrew, akSenderRef)
    DismissedCrew.RemoveRef(akCrew as ObjectReference)
    DisembarkingCrew.RemoveRef(akCrew as ObjectReference)
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndEvent

Event Actor.OnHomeShipSet(Actor akSource, spaceshipreference akShip, spaceshipreference akPrevious)
  Guard playerShipsChangeLock ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    If akShip != akPrevious
      HomeShip.ForceRefTo(akShip as ObjectReference)
      Self.RefillHomeShipAliases()
      akShip.SetLinkedRef(None, SpaceshipStoredLink, True)
      PlayerShips.AddRef(akShip as ObjectReference)
      Self.CheckForShipAchievements()
      Self.LoadCrewInterior()
      akShip.RemoveKeyword(SpaceshipPreventRampOpenOnLanding)
      If akPrevious
        Cell shipInterior = akShip.GetLinkedCell(SpaceshipLinkedInterior)
        shipInterior.SetFactionOwner(PlayerFaction)
        shipInterior.SetPublic(True)
        ObjectReference homeShipMarkerRef = HomeShipMarker.GetRef()
        akPrevious.SetLinkedRef(homeShipMarkerRef, SQ_LinkPlayerShipGoHome, True)
        ObjectReference previousStoredLinkedRef = akPrevious.GetLinkedRef(SpaceshipStoredLink)
        If previousStoredLinkedRef == None
          akPrevious.SetLinkedRef(homeShipMarkerRef, SpaceshipStoredLink, True)
        EndIf
        PreviousHomeShip.ForceRefTo(akPrevious as ObjectReference)
        If (akPrevious as ObjectReference == PlayerShip.GetRef()) && Game.GetPlayer().GetCurrentShipRef() != akPrevious
          Self.ResetPlayerShip(akShip)
        EndIf
        If akPrevious.IsDisabled() == False
          If akPrevious as ObjectReference == PlayerShip.GetRef()
            SQ_PlayerShip_NewHomeShipMessageNoReturn.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
          ElseIf akPrevious.IsInSpace() == False
            SQ_PlayerShip_NewHomeShipMessageNoReturn.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
          Else
            SQ_PlayerShip_NewHomeShipMessage.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
          EndIf
        EndIf
        Int i = 0
        While i < Passengers.GetCount()
          ObjectReference theRef = Passengers.GetAt(i)
          If theRef.IsDisabled() == False
            theRef.MoveTo(akShip as ObjectReference, 0.0, 0.0, 0.0, True, False)
            akShip.DamageValue(SpaceshipPassengerSlots, 1.0)
            akPrevious.RestoreValue(SpaceshipPassengerSlots, 1.0)
          EndIf
          i += 1
        EndWhile
        If Self.GetStageDone(Tutorial_NewHomeShip_Stage) == False
          Self.SetStage(Tutorial_NewHomeShip_Stage)
        EndIf
      EndIf
      spaceshipreference[] playerOwnedShips = Game.GetPlayerOwnedShips()
      Int I = 0
      While I < playerOwnedShips.Length
        PlayerShips.AddRef(playerOwnedShips[I] as ObjectReference)
        I += 1
      EndWhile
      Self.CheckForShipAchievements()
    EndIf
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndEvent

Event Actor.OnPlayerModifiedShip(Actor akSource, spaceshipreference akShip)
  Game.AddAchievement(ModifyShipAchievement)
  spaceshipreference playerShipRef = PlayerShip.GetShipRef()
  If akShip == playerShipRef
    Self.ResetPlayerShip(akShip)
  Else
    akShip.SetExteriorLoadDoorInaccessible(False)
  EndIf
EndEvent

Event OnTimer(Int aiTimerID)
  If aiTimerID == iDialogueEventTimerID
    If Game.GetPlayer().GetCurrentShipRef() as ObjectReference == HomeShip.GetRef()
      SQ_PlayerShipDialogueEvent.SendStoryEvent(None, None, None, 0, 0)
      Self.StartDialogueTimer()
    EndIf
  EndIf
EndEvent

Function StartDialogueTimer()
  Float fTimerSeconds = Utility.RandomFloat(fDialogueEventTimeSecondsMin, fDialogueEventTimeSecondsMax)
  Self.StartTimer(fTimerSeconds, iDialogueEventTimerID)
EndFunction

Function ClearLandingZone(spaceshipreference landingShip)
  If landingShip
    ObjectReference landingMarker = landingShip.GetLinkedRef(LandingMarkerKeyword)
    If landingMarker
      landingzonetriggerscript landingZoneTrigger = landingMarker.GetLinkedRef(LandingZoneTriggerKeyword) as landingzonetriggerscript
      If landingZoneTrigger
        landingZoneTrigger.BeginLanding(landingShip, landingMarker)
      EndIf
    EndIf
  EndIf
EndFunction

Function HandleShipTakeOff(Bool bResetHomeShip, Bool bFastTraveledToSurface)
  spaceshipreference playerShipRef = PlayerShip.GetShipRef()
  ObjectReference landingMarker = PlayerShipLandingMarker.GetRef()
  spaceshipreference currentPlayerShipRef = Game.GetPlayer().GetCurrentShipRef()
  spaceshipreference playerHomeShip = HomeShip.GetShipRef()
  If currentPlayerShipRef == playerShipRef
    SQ_PlayerShipTakeoffEvent.SendStoryEvent(None, playerShipRef as ObjectReference, landingMarker, 0, 0)
    If bResetHomeShip
      Self.ResetHomeShip(playerShipRef)
    EndIf
    Self.EnableLandingMapMarker(landingMarker, True)
    PlayerShipLandingMarker.Clear()
  ElseIf playerHomeShip != playerShipRef
    Self.ResetPlayerShip(None)
  EndIf
EndFunction

Function EnableLandingMapMarker(ObjectReference landingMarkerRef, Bool bEnable)
  If landingMarkerRef
    ObjectReference landingMapMarkerRef = landingMarkerRef.GetLinkedRef(LinkShipLandingOverlayMapMarker)
    If landingMapMarkerRef
      If bEnable
        landingMapMarkerRef.Enable(False)
      Else
        landingMapMarkerRef.Disable(False)
      EndIf
    EndIf
  EndIf
EndFunction

Function AddPassenger(Actor newPassenger)
  Guard playerShipsChangeLock ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    Int found = Passengers.Find(newPassenger as ObjectReference)
    If found < 0 && newPassenger.IsDead() == False
      Passengers.AddRef(newPassenger as ObjectReference)
      ObjectReference homeShipRef = HomeShip.GetRef()
      homeShipRef.DamageValue(SpaceshipPassengerSlots, 1.0)
    EndIf
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndFunction

Function AddPassengers(RefCollectionAlias newPassengers)
  Int I = 0
  While I < newPassengers.GetCount()
    Self.AddPassenger(newPassengers.GetActorAt(I))
    I += 1
  EndWhile
EndFunction

Function RemovePassenger(Actor removedPassenger)
  Guard playerShipsChangeLock ;*** WARNING: Experimental syntax, may be incorrect: Guard 
    Int found = Passengers.Find(removedPassenger as ObjectReference)
    If found > -1
      ObjectReference homeShipRef = HomeShip.GetRef()
      homeShipRef.RestoreValue(SpaceshipPassengerSlots, 1.0)
      Passengers.RemoveRef(removedPassenger as ObjectReference)
    EndIf
  EndGuard ;*** WARNING: Experimental syntax, may be incorrect: EndGuard 
EndFunction

Function RemovePassengers(RefCollectionAlias removedPassengers)
  Int I = 0
  While I < removedPassengers.GetCount()
    Self.RemovePassenger(removedPassengers.GetActorAt(I))
    I += 1
  EndWhile
EndFunction

Int Function GetPassengerSlots(Bool returnBaseValue)
  Int slots = 0
  ObjectReference homeShipRef = HomeShip.GetRef()
  If homeShipRef
    If returnBaseValue
      slots = homeShipRef.GetBaseValue(SpaceshipPassengerSlots) as Int
    Else
      slots = homeShipRef.GetValue(SpaceshipPassengerSlots) as Int
    EndIf
  EndIf
  Return slots
EndFunction

Function CheckForDismissedCrew()
  Location currentShipLocation = PlayerShip.GetShipRef().GetCurrentLocation()
  If DismissedCrew.GetCount() > 0
    LandingLocation.ForceLocationTo(currentShipLocation)
    LandingLocationExitMarker.RefillAlias()
    If LandingLocationExitMarker.GetRef()
      DisembarkingCrew.AddRefCollection(DismissedCrew)
    EndIf
  EndIf
EndFunction

Function UpdateDismissedCrew()
  Int I = DismissedCrew.GetCount() - 1
  While I > -1
    Actor currentCrewMember = DismissedCrew.GetAt(I) as Actor
    If currentCrewMember
      If currentCrewMember.IsInLocation(playerShipInteriorLocation.GetLocation()) == False
        DismissedCrew.RemoveRef(currentCrewMember as ObjectReference)
        If currentCrewMember.HasKeyword(SQ_Crew.Crew_CrewTypeGeneric)
          SQ_Crew.SetRoleUnavailable(currentCrewMember, True)
        EndIf
        Self.MoveCrewToHome(currentCrewMember)
        SQ_Crew.TestAndHandleUnloadedUnassignedGenericCrew(currentCrewMember)
      EndIf
    EndIf
    I -= 1
  EndWhile
  DisembarkingCrew.RemoveAll()
  LandingLocationExitMarker.Clear()
EndFunction

Function MoveCrewToHome(Actor CrewActor)
  If CrewActor.IsInFaction(CurrentFollowerFaction)
    Return 
  EndIf
  ObjectReference homeMarkerRef = CrewActor.GetLinkedRef(SQ_LinkCompanionEliteCrewHomeMarker)
  If homeMarkerRef
    CrewActor.MoveTo(homeMarkerRef, 0.0, 0.0, 0.0, True, False)
  Else
    CrewActor.MoveToMyEditorLocation()
  EndIf
EndFunction

Function CheckForShipAchievements()
  Int playerShipCount = PlayerShips.GetCount()
  If playerShipCount >= CollectShipsAchievementCount
    Game.AddAchievement(CollectShipsAchievement)
  EndIf
EndFunction

Bool Function IsPlayerShip(spaceshipreference shipToCheck)
  Bool returnVal = False
  If shipToCheck
    spaceshipreference currentPlayerShip = PlayerShip.GetShipRef()
    If shipToCheck == currentPlayerShip
      returnVal = True
    Else
      Int findShip = PlayerShips.Find(shipToCheck as ObjectReference)
      returnVal = findShip > -1
    EndIf
  EndIf
  Return returnVal
EndFunction

Function TestDismissedCrew(Actor crew)
  DismissedCrew.AddRef(crew as ObjectReference)
EndFunction

Function TestDisableTakeoff(Bool bEnable)
  If myTestLayer == None
    myTestLayer = inputenablelayer.Create()
  EndIf
  myTestLayer.EnableTakeoff(bEnable)
EndFunction

Function debugMoveToPlayerShip()
  spaceshipreference playerShipRef = PlayerShip.GetShipRef()
  If playerShipRef
    Game.GetPlayer().MoveTo(playerShipRef as ObjectReference, 0.0, 0.0, 0.0, True, False)
  EndIf
EndFunction

spaceshipreference Function DebugGetHomeShip()
  spaceshipreference homeShipRef = HomeShip.GetShipRef()
  Int waitingFor = 0
  Int maxWait = 10
  While homeShipRef == None && waitingFor <= maxWait
    Utility.Wait(1.0)
    homeShipRef = HomeShip.GetShipRef()
    waitingFor += 1
  EndWhile
  If homeShipRef == None
    String warnstring = "HomeShip alias not filled. Make sure player home ship exists before calling this function. (try calling: BAT \"Crew\\Homeship\" first."
    Return None
  EndIf
  Return homeShipRef
EndFunction

Function debugMoveToPlayerShipPilotSeat(Bool CallHandleTakeOff)
  spaceshipreference ShipRef = Self.DebugGetHomeShip()
  If ShipRef == None
    Return 
  EndIf
  Actor player = Game.GetPlayer()
  inputenablelayer myEnableLayer = inputenablelayer.Create()
  myEnableLayer.DisablePlayerControls(True, True, True, False, False, True, True, False, True, True, False)
  player.MoveTo(ShipRef as ObjectReference, 0.0, 0.0, 0.0, True, False)
  If CallHandleTakeOff
    Self.HandleShipTakeOff(True, False)
  EndIf
  PlayerShipPilotSeat.GetRef().Activate(player as ObjectReference, False)
  myEnableLayer.Delete()
EndFunction

spaceshipreference Function DebugCreateHomeShipInSpace(ObjectReference ReferenceToPutShipAt)
  Self.ResetHomeShip(Frontier_ModularREF as spaceshipreference)
  If ReferenceToPutShipAt == None
    ReferenceToPutShipAt = NewGameShipMarkerREF
  EndIf
  spaceshipreference homeShipRef = Self.DebugGetHomeShip()
  homeShipRef.MoveTo(ReferenceToPutShipAt, 0.0, 0.0, 0.0, True, False)
  Return homeShipRef
EndFunction

spaceshipreference Function DebugCreateHomeShipLanded(ObjectReference ReferenceToPutShipAt)
  Self.ResetHomeShip(Frontier_ModularREF as spaceshipreference)
  If ReferenceToPutShipAt == None
    ReferenceToPutShipAt = NewAtlantisShipLandingMarker
  EndIf
  spaceshipreference homeShipRef = Self.DebugGetHomeShip()
  Self.debugMovePlayerShip(homeShipRef, ReferenceToPutShipAt)
  Return homeShipRef
EndFunction

Function debugInitializeHomeShip(spaceshipreference frontierRef)
  spaceshipreference homeShipRef = HomeShip.GetShipRef()
  If homeShipRef == None
    Self.ResetHomeShip(frontierRef)
  EndIf
EndFunction

Function debugUpdatePlayerShips()
  spaceshipreference[] ownedShips = Game.GetPlayerOwnedShips()
  Int I = 0
  While I < ownedShips.Length
    PlayerShips.AddRef(ownedShips[I] as ObjectReference)
    I += 1
  EndWhile
EndFunction

Function debugMovePlayerShip(spaceshipreference frontierRef, ObjectReference ShipLandingMarker)
  spaceshipreference ShipRef = frontierRef
  ShipRef.MoveTo(ShipLandingMarker, 0.0, 0.0, 0.0, True, False)
  ShipRef.SetLinkedRef(ShipLandingMarker, CurrentInteractionLinkedRefKeyword, True)
  ShipRef.Enable(False)
EndFunction

Function DebugAddPassengers(Int count)
  ObjectReference passengerMarker = HomeShipPassengerMarker.GetRef()
  Int I = 0
  While I < count
    Actor passengerRef = passengerMarker.PlaceActorAtMe(MissionBoardPassenger_Type06, 4, None, False, False, True, None, True)
    Self.AddPassenger(passengerRef)
    I += 1
  EndWhile
EndFunction

Bool Function Trace(ScriptObject CallingObject, String asTextToPrint, Int aiSeverity, String MainLogName, String SubLogName, Bool bShowWarning, Bool bPrefixTraceWithLogNames)
  Return Debug.TraceLog(CallingObject, asTextToPrint, MainLogName, SubLogName, aiSeverity, bShowNormalTrace, bShowWarning, bPrefixTraceWithLogNames, True)
EndFunction

; Fixup hacks for debug-only function: warning
Bool Function warning(ScriptObject CallingObject, String asTextToPrint, Int aiSeverity, String MainLogName, String SubLogName, Bool bShowWarning, Bool bPrefixTraceWithLogNames)
  Return false
EndFunction
