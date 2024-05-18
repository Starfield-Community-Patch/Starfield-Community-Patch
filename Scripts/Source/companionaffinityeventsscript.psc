ScriptName CompanionAffinityEventsScript Extends Quest

;-- Structs -----------------------------------------
Struct ImportantSceneDatum
  Scene ImportantScene
  { the scene to check if it's running to determine if we are near an "important" scene }
  ReferenceAlias AliasToCheck
  { almost always the primary alias, what are we checking for to mean "is near" this scene if it's running }
EndStruct


;-- Variables ---------------------------------------
Bool CoolingDown
Int NextPollEvent = 0
Actor PlayerRef
Float TimerDur_Poll = 60.0 Const
Int TimerID_CoolDown = 2 Const
Int TimerID_Poll = 1 Const
Int TimerID_RecentlyDisembarked = 3 Const
Float Timestamp_ShipMoved
Int iDroppingItemIntoWorld = 3 Const
Int iTemp_Cold = -1 Const
Int iTemp_Hot = 1 Const
Int iTemp_Normal = 0 Const
Float lastCompanionGravityScale = 1.0
Int lastCompanionTemperature = 0
Float timerDur_RecentlyDisembarked = 30.0 Const

;-- Properties --------------------------------------
Group Alias
  ReferenceAlias Property ActiveCompanion Auto Const mandatory
  { autofill }
  ReferenceAlias Property ActiveEliteCrew Auto Const mandatory
  { autofill }
  ReferenceAlias Property PlayerShip Auto Const mandatory
  { autofill }
EndGroup

Group AffinityEvents
  affinityevent Property COM_Event_Action_Arrival Auto Const mandatory
  affinityevent Property COM_Event_Action_BecomeOverEncumbered Auto Const mandatory
  affinityevent Property COM_Event_Action_ChemAddiction Auto Const mandatory
  affinityevent Property COM_Event_Action_Consume_Alcohol Auto Const mandatory
  affinityevent Property COM_Event_Action_Consume_Drugs Auto Const mandatory
  affinityevent Property COM_Event_Action_Crafting_CreateItem Auto Const mandatory
  affinityevent Property COM_Event_Action_Crafting_CreateOutpostModule Auto Const mandatory
  affinityevent Property COM_Event_Action_Crafting_CreateShipModule Auto Const mandatory
  affinityevent Property COM_Event_Action_Crafting_Mod_Armor Auto Const mandatory
  affinityevent Property COM_Event_Action_Crafting_Mod_Weapon Auto Const mandatory
  affinityevent Property COM_Event_Action_DischargeWeapon Auto Const mandatory
  affinityevent Property COM_Event_Action_DropUsefulItem Auto Const mandatory
  affinityevent Property COM_Event_Action_Enhance_PlayerChangeAppearance Auto Const mandatory
  affinityevent Property COM_Event_Action_EnvironmentalDamage_Airborne Auto Const mandatory
  affinityevent Property COM_Event_Action_EnvironmentalDamage_Corrosive Auto Const mandatory
  affinityevent Property COM_Event_Action_EnvironmentalDamage_Radiation Auto Const mandatory
  affinityevent Property COM_Event_Action_EnvironmentalDamage_Thermal Auto Const mandatory
  affinityevent Property COM_Event_Action_EnvironmentalHazardWarning Auto Const mandatory
  affinityevent Property COM_Event_Action_ShipBoardingOther Auto Const mandatory
  affinityevent Property COM_Event_Action_Harvest_Animal Auto Const mandatory
  affinityevent Property COM_Event_Action_Harvest_Mineral Auto Const mandatory
  affinityevent Property COM_Event_Action_Harvest_Plant Auto Const mandatory
  affinityevent Property COM_Event_Action_HealCompanion Auto Const mandatory
  affinityevent Property COM_Event_Action_JailComplete Auto Const mandatory
  affinityevent Property COM_Event_Action_JumpFromHeight Auto Const mandatory
  affinityevent Property COM_Event_Action_LootCorpse Auto Const mandatory
  affinityevent Property COM_Event_Action_PickLock Auto Const mandatory
  affinityevent Property COM_Event_Action_Hack Auto Const mandatory
  affinityevent Property COM_Event_Action_ShipEmbark Auto Const mandatory
  affinityevent Property COM_Event_Action_Steal Auto Const mandatory
  affinityevent Property COM_Event_Action_StealPickpocket Auto Const mandatory
  affinityevent Property COM_Event_Action_Swim Auto Const mandatory
  affinityevent Property COM_Event_Action_UseHandScanner Auto Const mandatory
  affinityevent Property COM_Event_Action_UseStarbornPower Auto Const mandatory
  affinityevent Property COM_Event_Action_UseWorkbench Auto Const mandatory
  affinityevent Property COM_Event_Action_WalkAroundNaked Auto Const mandatory
  affinityevent Property COM_Event_Action_GravityHigh Auto Const mandatory
  affinityevent Property COM_Event_Action_GravityLow Auto Const mandatory
  affinityevent Property COM_Event_Action_ZeroG Auto Const mandatory
  FormList Property COM_LocationKeywords_VeryCold Auto Const mandatory
  FormList Property COM_LocationKeywords_VeryHot Auto Const mandatory
  affinityevent Property COM_Event_Action_TempHigh Auto Const mandatory
  affinityevent Property COM_Event_Action_TempLow Auto Const mandatory
  conditionform Property COM_CREW_CND_Comment_TemperatureCommentsAllowed Auto Const mandatory
  GlobalVariable Property COM_ActionEventScriptFilter_CoolDownMinutes Auto Const mandatory
  FormList Property COM_IgnoreAffinityEventCooldownOnChangeLocation_Locations Auto Const mandatory
  GlobalVariable Property SQ_Companions_RecentlyDisembarked Auto Const mandatory
  Float Property COM_Event_Action_GravityHigh_Threshold = 1.5 Auto Const
  Float Property COM_Event_Action_GravityLow_Threshold = 0.5 Auto Const
EndGroup

Group ImportantSceneData
  companionaffinityeventsscript:importantscenedatum[] Property ImportantSceneData Auto Const mandatory
  Float Property SceneNearDistance = 20.0 Auto Const
EndGroup

ReferenceAlias Property Alias_CurrentCompanion Auto Const
{ autofill }
MagicEffect Property COM_AddictionEffect Auto Const
Keyword Property COM_ObjType_ChemBad Auto Const mandatory
Keyword Property COM_ObjType_Drink Auto Const mandatory
FormList Property COM_DropUsefulItemList Auto Const mandatory
FormList Property COM_DropUsefulItemList_Ignored Auto Const mandatory
Keyword[] Property DischargeWeapon_WeaponKeywordExceptions Auto Const mandatory
{ weapons with these keywords will not trigger this event (example melee weapons) }
Keyword[] Property DischargeWeapon_LocationKeywordRequirements Auto Const mandatory
{ only locations with these keywords will be considered for triggering this event (example settlements). }
Float Property DischargeWeapon_RadiusToLookForHostileActors = 40.0 Auto Const
Keyword Property ActorTypeNPC Auto Const mandatory
Keyword Property ENV_EnvDamageType_Airborne Auto Const mandatory
{ autofill }
Keyword Property ENV_EnvDamageType_Corrosive Auto Const mandatory
{ autofill }
Keyword Property ENV_EnvDamageType_Radiation Auto Const mandatory
{ autofill }
Keyword Property ENV_EnvDamageType_Thermal Auto Const mandatory
{ autofill }
Keyword Property ENV_EffectTypeEnvironmentalDamageSoak Auto Const mandatory
{ autofill }
Keyword Property FloraTypeInorganic Auto Const mandatory
{ autofill }
Keyword Property FloraTypeOrganic Auto Const mandatory
{ autofill }
Keyword Property ResourceTypeOrganic Auto Const mandatory
{ autofill }
Keyword Property Artifact_Power Auto Const mandatory
{ autofill }
Keyword Property BEHostileBoardingEncounterKeyword Auto Const mandatory
{ autofill }

;-- Functions ---------------------------------------

Event ObjectReference.OnItemAdded(ObjectReference akSender, Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, Int aiTransferReason)
  Self.GotoState("Processing")
  Actor containerActor = akSourceContainer as Actor
  If containerActor as Bool && containerActor.IsDead()
    If akBaseItem.HasKeyword(ResourceTypeOrganic)
      Self.SendAffinityEvent(COM_Event_Action_Harvest_Animal, None, False)
    Else
      Self.SendAffinityEvent(COM_Event_Action_LootCorpse, akSourceContainer, False)
    EndIf
  EndIf
  If akSourceContainer
    If akSourceContainer.HasKeyword(FloraTypeInorganic)
      Self.SendAffinityEvent(COM_Event_Action_Harvest_Mineral, None, False)
    ElseIf akSourceContainer.HasKeyword(FloraTypeOrganic)
      Self.SendAffinityEvent(COM_Event_Action_Harvest_Plant, None, False)
    EndIf
  EndIf
  If PlayerRef.IsOverEncumbered()
    Self.SendAffinityEvent(COM_Event_Action_BecomeOverEncumbered, None, False)
  EndIf
  Self.GotoState("None")
EndEvent

Event OnTimer(Int aiTimerID)
  If aiTimerID == TimerID_Poll
    If NextPollEvent == 0
      Self.CheckAndSendGravityEvents()
      NextPollEvent = 1
      Self.StartTimer(TimerDur_Poll, TimerID_Poll)
    ElseIf NextPollEvent == 1
      Self.CheckAndSendTemperatureEvents()
      NextPollEvent = 0
    EndIf
  ElseIf aiTimerID == TimerID_CoolDown
    CoolingDown = False
  ElseIf aiTimerID == TimerID_RecentlyDisembarked
    SQ_Companions_RecentlyDisembarked.SetValue(0.0)
  EndIf
EndEvent

Function StartCoolDownTimer()
  Float duration = COM_ActionEventScriptFilter_CoolDownMinutes.GetValue() * 60.0
  Self.StartTimer(duration, TimerID_CoolDown)
  CoolingDown = True
EndFunction

Event OnQuestStarted()
  PlayerRef = Game.GetPlayer()
  Self.RegisterForRemoteEvent(ActiveCompanion as ScriptObject, "OnLocationChange")
  Self.RegisterForRemoteEvent(ActiveCompanion as ScriptObject, "OnExitShipInterior")
  Self.RegisterForRemoteEvent(ActiveEliteCrew as ScriptObject, "OnLocationChange")
  Self.RegisterForRemoteEvent(ActiveEliteCrew as ScriptObject, "OnExitShipInterior")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipGravJump")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipFarTravel")
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, COM_AddictionEffect as Form, True)
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, ENV_EnvDamageType_Airborne as Form, True)
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, ENV_EnvDamageType_Corrosive as Form, True)
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, ENV_EnvDamageType_Radiation as Form, True)
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, ENV_EnvDamageType_Thermal as Form, True)
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerUseWorkBench")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerSwimming")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerCraftItem")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerModArmorWeapon")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerModifiedShip")
  ; LooksMenu was changed to ChargenMenu in Starfield
  Self.RegisterForMenuOpenCloseEvent("ChargenMenu")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerFireWeapon")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerScannedObject")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnSpellCast")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerFallLongDistance")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerHealTeammate")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerJail")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnItemEquipped")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnItemRemoved")
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnItemAdded")
  Self.AddInventoryEventFilter(None)
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerItemAdded")
  Self.AddInventoryEventFilter(None)
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPickLock")
EndEvent

Event Actor.OnPlayerJail(Actor akSender, ObjectReference akGuard, Form akFaction, Location akLocation, Int aeCrimeGold)
  Self.SendAffinityEvent(COM_Event_Action_JailComplete, akGuard, False)
EndEvent

Function SetShipMovedTimestamp()
  Timestamp_ShipMoved = Utility.GetCurrentRealTime()
EndFunction

Function SetRecentlyDisembarked(Bool CheckShipMoved)
  Float now = Utility.GetCurrentRealTime()
  Float timeSinceMoved = now - Timestamp_ShipMoved
  If CheckShipMoved == False || timeSinceMoved < 30.0
    Self.StartTimer(timerDur_RecentlyDisembarked, TimerID_RecentlyDisembarked)
    SQ_Companions_RecentlyDisembarked.SetValue(1.0)
  Else
    Self.CancelTimer(TimerID_RecentlyDisembarked)
    SQ_Companions_RecentlyDisembarked.SetValue(0.0)
  EndIf
EndFunction

Event ReferenceAlias.OnExitShipInterior(ReferenceAlias akSender, ObjectReference akShip)
  Self.SetRecentlyDisembarked(False)
  Self.SendAffinityEvent(COM_Event_Action_Arrival, None, False)
EndEvent

Event ReferenceAlias.OnShipGravJump(ReferenceAlias akSender, Location aDestination, Int aState)
  Self.SetShipMovedTimestamp()
EndEvent

Event ReferenceAlias.OnShipFarTravel(ReferenceAlias akSender, Location aDepartureLocation, Location aArrivalLocation, Int aState)
  Self.SetShipMovedTimestamp()
EndEvent

Event ReferenceAlias.OnLocationChange(ReferenceAlias akSender, Location akOldLoc, Location akNewLoc)
  Int iClothingSlot = 3
  Int iSpacesuitSlot = 35
  If PlayerRef.WornCoversBipedSlot(iClothingSlot) == False && PlayerRef.WornCoversBipedSlot(iSpacesuitSlot) == False
    Self.SendAffinityEvent(COM_Event_Action_WalkAroundNaked, None, False)
  EndIf
  If akNewLoc
    spaceshipreference shipRef = akSender.GetReference().GetCurrentShipRef()
    If shipRef as Bool && shipRef.HasKeyword(BEHostileBoardingEncounterKeyword)
      Self.SendAffinityEvent(COM_Event_Action_ShipBoardingOther, None, False)
    ElseIf shipRef
      Self.SendAffinityEvent(COM_Event_Action_ShipEmbark, None, False)
    ElseIf akNewLoc.IsChild(akOldLoc) == False
      Self.SetRecentlyDisembarked(True)
      Bool ignoreCooldown = COM_IgnoreAffinityEventCooldownOnChangeLocation_Locations.Find(akNewLoc as Form) > -1
      Self.SendAffinityEvent(COM_Event_Action_Arrival, None, ignoreCooldown)
    EndIf
  EndIf
  Self.StartTimer(TimerDur_Poll, TimerID_Poll)
EndEvent

Event OnMagicEffectApply(ObjectReference akTarget, ObjectReference akCaster, MagicEffect akEffect)
  If akTarget == PlayerRef as ObjectReference
    If akEffect == COM_AddictionEffect
      Self.SendAffinityEvent(COM_Event_Action_ChemAddiction, None, False)
    ElseIf akEffect.HasKeyword(ENV_EnvDamageType_Airborne)
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalDamage_Airborne, akCaster, False)
    ElseIf akEffect.HasKeyword(ENV_EnvDamageType_Corrosive)
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalDamage_Corrosive, akCaster, False)
    ElseIf akEffect.HasKeyword(ENV_EnvDamageType_Radiation)
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalDamage_Radiation, akCaster, False)
    ElseIf akEffect.HasKeyword(ENV_EnvDamageType_Thermal)
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalDamage_Thermal, akCaster, False)
    ElseIf akEffect.HasKeyword(ENV_EffectTypeEnvironmentalDamageSoak)
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalHazardWarning, akCaster, False)
    EndIf
  EndIf
EndEvent

Event Actor.OnPlayerSwimming(Actor akSender)
  Self.SendAffinityEvent(COM_Event_Action_Swim, None, False)
EndEvent

Event ObjectReference.OnSpellCast(ObjectReference akSender, Form akSpell)
  Self.GotoState("Processing")
  If akSpell.HasKeyword(Artifact_Power)
    Self.SendAffinityEvent(COM_Event_Action_UseStarbornPower, None, False)
  EndIf
  Self.GotoState("None")
EndEvent

Event actor.OnPlayerCraftItem(Actor akSender, ObjectReference akBench, Location akLocation, Form akCreatedItem)
  Self.SendAffinityEvent(COM_Event_Action_Crafting_CreateItem, None, False)
EndEvent

Event Actor.OnPlayerModArmorWeapon(Actor akSender, Form akBaseObject, objectmod akModBaseObject)
  If akBaseObject is Weapon
    Self.SendAffinityEvent(COM_Event_Action_Crafting_Mod_Weapon, None, False)
  ElseIf akBaseObject is Armor
    Self.SendAffinityEvent(COM_Event_Action_Crafting_Mod_Armor, None, False)
  EndIf
EndEvent

Event Actor.OnPlayerModifiedShip(Actor akSender, spaceshipreference akShip)
  Self.SendAffinityEvent(COM_Event_Action_Crafting_CreateShipModule, akShip as ObjectReference, False)
EndEvent

Event OnMenuOpenCloseEvent(String asMenuName, Bool abOpening)
  ; LooksMenu has been changed to ChargenMenu
  If asMenuName == "ChargenMenu" && abOpening == False
    Self.SendAffinityEvent(COM_Event_Action_Enhance_PlayerChangeAppearance, None, False)
  EndIf
EndEvent

Event Actor.OnPlayerFireWeapon(Actor akSender, Form akBaseObject)
  Location locToTest = akSender.GetCurrentLocation()
  If (locToTest as Bool && akBaseObject as Bool) && commonarrayfunctions.CheckFormAgainstKeywordArray(akBaseObject, DischargeWeapon_WeaponKeywordExceptions, False) == False
    If commonarrayfunctions.CheckFormAgainstKeywordArray(locToTest as Form, DischargeWeapon_LocationKeywordRequirements, False)
      ObjectReference[] NPCs = akSender.FindAllReferencesWithKeyword(ActorTypeNPC as Form, DischargeWeapon_RadiusToLookForHostileActors)
      Bool AnyHostiles = commonarrayfunctions.IsActorInArrayHostileToActor(akSender, NPCs)
      If AnyHostiles == False
        Self.SendAffinityEvent(COM_Event_Action_DischargeWeapon, None, False)
      EndIf
    EndIf
  EndIf
EndEvent

Event Actor.OnPlayerScannedObject(Actor akSender, ObjectReference akScannedRef)
  Self.SendAffinityEvent(COM_Event_Action_UseHandScanner, akScannedRef, False)
EndEvent

Event Actor.OnPlayerFallLongDistance(Actor akSender, Float afDamage)
  Self.SendAffinityEvent(COM_Event_Action_JumpFromHeight, None, False)
EndEvent

Event Actor.OnPlayerHealTeammate(Actor akSender, Actor akTeammate)
  If akTeammate == Alias_CurrentCompanion.GetActorReference()
    Self.SendAffinityEvent(COM_Event_Action_HealCompanion, akTeammate as ObjectReference, False)
  EndIf
EndEvent

Event Actor.OnItemEquipped(Actor akSender, Form akBaseObject, ObjectReference akReference)
  If akBaseObject.HasKeyword(COM_ObjType_ChemBad)
    Self.SendAffinityEvent(COM_Event_Action_Consume_Drugs, None, False)
  ElseIf akBaseObject.HasKeyword(COM_ObjType_Drink)
    Self.SendAffinityEvent(COM_Event_Action_Consume_Alcohol, None, False)
  EndIf
EndEvent

Event ObjectReference.OnItemRemoved(ObjectReference akSender, Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer, Int aiTransferReason)
  If aiTransferReason == iDroppingItemIntoWorld && akBaseItem.HasKeywordInFormList(COM_DropUsefulItemList_Ignored) == False && akBaseItem.HasKeywordInFormList(COM_DropUsefulItemList) && Game.GetPlayer().IsInCombat() == False
    Self.SendAffinityEvent(COM_Event_Action_DropUsefulItem, None, False)
  EndIf
EndEvent

Event Actor.OnPlayerItemAdded(Actor akSender, Form akBaseObject, ObjectReference akOwner, ObjectReference akSourceContainer, Int aeAcquireType)
  Actor CompanionRef = ActiveCompanion.GetActorRef()
  If aeAcquireType == 1 && CompanionRef.HasDetectionLOS(PlayerRef as ObjectReference)
    Self.SendAffinityEvent(COM_Event_Action_Steal, None, False)
  ElseIf aeAcquireType == 3 && CompanionRef.HasDetectionLOS(PlayerRef as ObjectReference)
    Self.SendAffinityEvent(COM_Event_Action_StealPickpocket, None, False)
  EndIf
EndEvent

Function OutpostObjectPlaced(ObjectReference placedRef)
  Self.SendAffinityEvent(COM_Event_Action_Crafting_CreateOutpostModule, placedRef, False)
EndFunction

Function CheckAndSendGravityEvents()
  Actor CompanionRef = ActiveCompanion.GetActorReference()
  If CompanionRef
    Float companionGravityScale = CompanionRef.GetGravityScale()
    If companionGravityScale != lastCompanionGravityScale
      lastCompanionGravityScale = companionGravityScale
      If companionGravityScale > COM_Event_Action_GravityHigh_Threshold
        Self.SendAffinityEvent(COM_Event_Action_GravityHigh, None, False)
      ElseIf companionGravityScale < COM_Event_Action_GravityLow_Threshold
        Self.SendAffinityEvent(COM_Event_Action_GravityLow, None, False)
      ElseIf companionGravityScale <= 0.0
        Self.SendAffinityEvent(COM_Event_Action_ZeroG, None, False)
      EndIf
    EndIf
  EndIf
EndFunction

Function CheckAndSendTemperatureEvents()
  Actor CompanionRef = ActiveCompanion.GetActorReference()
  If CompanionRef
    If COM_CREW_CND_Comment_TemperatureCommentsAllowed.IsTrue(CompanionRef as ObjectReference, None) == False
      
    Else
      Int temperature = iTemp_Normal
      If CompanionRef.GetCurrentPlanet().HasKeywordInFormList(COM_LocationKeywords_VeryHot)
        temperature = iTemp_Hot
      ElseIf CompanionRef.GetCurrentPlanet().HasKeywordInFormList(COM_LocationKeywords_VeryCold)
        temperature = iTemp_Cold
      EndIf
      If temperature != lastCompanionTemperature
        lastCompanionTemperature = temperature
        If temperature >= iTemp_Hot
          Self.SendAffinityEvent(COM_Event_Action_TempHigh, None, False)
        ElseIf temperature <= iTemp_Cold
          Self.SendAffinityEvent(COM_Event_Action_TempLow, None, False)
        EndIf
      EndIf
    EndIf
  EndIf
EndFunction

Event Actor.OnPickLock(Actor akSender, ObjectReference akLockedRef, Bool abCrime, Bool abSucceeded, terminalmenu akLockedTerminalMenu, Int aiTerminalMenuItem)
  If abSucceeded
    If akLockedRef.GetBaseObject() is terminal
      Self.SendAffinityEvent(COM_Event_Action_Hack, None, False)
    Else
      Self.SendAffinityEvent(COM_Event_Action_PickLock, None, False)
    EndIf
  EndIf
EndEvent

Function SendAffinityEvent(affinityevent EventToSend, ObjectReference targetRef, Bool ignoreCooldown)
  Bool PlayerInDialogue = Game.IsPlayerInDialogue()
  Bool CompanionInScene = False
  Actor CompanionRef = ActiveCompanion.GetActorReference()
  If CompanionRef
    CompanionInScene = CompanionRef.IsInScene()
  EndIf
  If ignoreCooldown
    CoolingDown = False
  EndIf
  If CoolingDown == False && PlayerInDialogue == False && CompanionInScene == False && Self.IsNearImportantScene(True, True) == False
    EventToSend.send(targetRef)
    Self.StartCoolDownTimer()
  EndIf
EndFunction

Bool Function IsNearImportantScene(Bool CheckPlayer, Bool CheckCompanion)
  Bool returnVal = False
  Int I = 0
  While returnVal == False && I < ImportantSceneData.Length
    companionaffinityeventsscript:importantscenedatum currentDatum = ImportantSceneData[I]
    Bool sceneIsPlaying = currentDatum.ImportantScene.IsPlaying()
    If sceneIsPlaying
      ObjectReference refToCheck = currentDatum.AliasToCheck.GetReference()
      If CheckPlayer && Game.GetPlayer().GetDistance(refToCheck) <= SceneNearDistance
        returnVal = True
      ElseIf CheckCompanion
        ObjectReference CompanionRef = ActiveCompanion.GetReference()
        If CompanionRef as Bool && CompanionRef.GetDistance(refToCheck) <= SceneNearDistance
          returnVal = True
        EndIf
      EndIf
    EndIf
    I += 1
  EndWhile
  Return returnVal
EndFunction

Function DebugResetActionFilterCooldown()
  CoolingDown = False
EndFunction

Bool Function Trace(ScriptObject CallingObject, String asTextToPrint, Int aiSeverity, String MainLogName, String SubLogName, Bool bShowNormalTrace, Bool bShowWarning, Bool bPrefixTraceWithLogNames)
  Return Debug.TraceLog(CallingObject, asTextToPrint, MainLogName, SubLogName, aiSeverity, bShowNormalTrace, bShowWarning, bPrefixTraceWithLogNames, True)
EndFunction

; Fixup hacks for debug-only function: warning
Bool Function warning(ScriptObject CallingObject, String asTextToPrint, Int aiSeverity, String MainLogName, String SubLogName, Bool bShowNormalTrace, Bool bShowWarning, Bool bPrefixTraceWithLogNames)
  Return false
EndFunction

;-- State -------------------------------------------
State Processing

  Event ObjectReference.OnItemAdded(ObjectReference akSender, Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, Int aiTransferReason)
    ; Empty function
  EndEvent

  Event ObjectReference.OnSpellCast(ObjectReference akSender, Form akSpell)
    ; Empty function
  EndEvent
EndState
