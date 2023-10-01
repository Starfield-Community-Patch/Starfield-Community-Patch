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
  Self.GotoState("Processing") ; #DEBUG_LINE_NO:
  Actor containerActor = akSourceContainer as Actor ; #DEBUG_LINE_NO:
  If containerActor as Bool && containerActor.IsDead() ; #DEBUG_LINE_NO:
    If akBaseItem.HasKeyword(ResourceTypeOrganic) ; #DEBUG_LINE_NO:
      Self.SendAffinityEvent(COM_Event_Action_Harvest_Animal, None, False) ; #DEBUG_LINE_NO:
    Else ; #DEBUG_LINE_NO:
      Self.SendAffinityEvent(COM_Event_Action_LootCorpse, akSourceContainer, False) ; #DEBUG_LINE_NO:
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
  If akSourceContainer ; #DEBUG_LINE_NO:
    If akSourceContainer.HasKeyword(FloraTypeInorganic) ; #DEBUG_LINE_NO:
      Self.SendAffinityEvent(COM_Event_Action_Harvest_Mineral, None, False) ; #DEBUG_LINE_NO:
    ElseIf akSourceContainer.HasKeyword(FloraTypeOrganic) ; #DEBUG_LINE_NO:
      Self.SendAffinityEvent(COM_Event_Action_Harvest_Plant, None, False) ; #DEBUG_LINE_NO:
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
  If PlayerRef.IsOverEncumbered() ; #DEBUG_LINE_NO:
    Self.SendAffinityEvent(COM_Event_Action_BecomeOverEncumbered, None, False) ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
  Self.GotoState("") ; #DEBUG_LINE_NO:
EndEvent

Event OnTimer(Int aiTimerID)
  If aiTimerID == TimerID_Poll ; #DEBUG_LINE_NO:168
    If NextPollEvent == 0 ; #DEBUG_LINE_NO:169
      Self.CheckAndSendGravityEvents() ; #DEBUG_LINE_NO:170
      NextPollEvent = 1 ; #DEBUG_LINE_NO:171
      Self.StartTimer(TimerDur_Poll, TimerID_Poll) ; #DEBUG_LINE_NO:172
    ElseIf NextPollEvent == 1 ; #DEBUG_LINE_NO:173
      Self.CheckAndSendTemperatureEvents() ; #DEBUG_LINE_NO:174
      NextPollEvent = 0 ; #DEBUG_LINE_NO:175
    EndIf ; #DEBUG_LINE_NO:
  ElseIf aiTimerID == TimerID_CoolDown ; #DEBUG_LINE_NO:178
    CoolingDown = False ; #DEBUG_LINE_NO:180
  ElseIf aiTimerID == TimerID_RecentlyDisembarked ; #DEBUG_LINE_NO:181
    SQ_Companions_RecentlyDisembarked.SetValue(0.0) ; #DEBUG_LINE_NO:183
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Function StartCoolDownTimer()
  Float duration = COM_ActionEventScriptFilter_CoolDownMinutes.GetValue() * 60.0 ; #DEBUG_LINE_NO:188
  Self.StartTimer(duration, TimerID_CoolDown) ; #DEBUG_LINE_NO:190
  CoolingDown = True ; #DEBUG_LINE_NO:191
EndFunction

Event OnQuestStarted()
  PlayerRef = Game.GetPlayer() ; #DEBUG_LINE_NO:200
  Self.RegisterForRemoteEvent(ActiveCompanion as ScriptObject, "OnLocationChange") ; #DEBUG_LINE_NO:209
  Self.RegisterForRemoteEvent(ActiveCompanion as ScriptObject, "OnExitShipInterior") ; #DEBUG_LINE_NO:210
  Self.RegisterForRemoteEvent(ActiveEliteCrew as ScriptObject, "OnLocationChange") ; #DEBUG_LINE_NO:212
  Self.RegisterForRemoteEvent(ActiveEliteCrew as ScriptObject, "OnExitShipInterior") ; #DEBUG_LINE_NO:213
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipGravJump") ; #DEBUG_LINE_NO:217
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnShipFarTravel") ; #DEBUG_LINE_NO:218
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, COM_AddictionEffect as Form, True) ; #DEBUG_LINE_NO:227
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, ENV_EnvDamageType_Airborne as Form, True) ; #DEBUG_LINE_NO:228
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, ENV_EnvDamageType_Corrosive as Form, True) ; #DEBUG_LINE_NO:229
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, ENV_EnvDamageType_Radiation as Form, True) ; #DEBUG_LINE_NO:230
  Self.RegisterForMagicEffectApplyEvent(PlayerRef as ScriptObject, None, ENV_EnvDamageType_Thermal as Form, True) ; #DEBUG_LINE_NO:231
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerUseWorkBench") ; #DEBUG_LINE_NO:236
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerSwimming") ; #DEBUG_LINE_NO:241
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerCraftItem") ; #DEBUG_LINE_NO:246
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerModArmorWeapon") ; #DEBUG_LINE_NO:253
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerModifiedShip") ; #DEBUG_LINE_NO:259
  Self.RegisterForMenuOpenCloseEvent("ChargenMenu") ; #DEBUG_LINE_NO:264 ; Formerly called for "LooksMenu", which is what ChargenMenu was called in Fallout 4 - Bobbyclue 9/21/23
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerFireWeapon") ; #DEBUG_LINE_NO:270
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerScannedObject") ; #DEBUG_LINE_NO:276
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnSpellCast") ; #DEBUG_LINE_NO:282
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerFallLongDistance") ; #DEBUG_LINE_NO:288
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerHealTeammate") ; #DEBUG_LINE_NO:293
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerJail") ; #DEBUG_LINE_NO:298
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnItemEquipped") ; #DEBUG_LINE_NO:307
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnItemRemoved") ; #DEBUG_LINE_NO:313
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnItemAdded") ; #DEBUG_LINE_NO:326
  Self.AddInventoryEventFilter(None) ; #DEBUG_LINE_NO:327
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPlayerItemAdded") ; #DEBUG_LINE_NO:334
  Self.AddInventoryEventFilter(None) ; #DEBUG_LINE_NO:335
  Self.RegisterForRemoteEvent(PlayerRef as ScriptObject, "OnPickLock") ; #DEBUG_LINE_NO:342
EndEvent

Event Actor.OnPlayerJail(Actor akSender, ObjectReference akGuard, Form akFaction, Location akLocation, Int aeCrimeGold)
  Self.SendAffinityEvent(COM_Event_Action_JailComplete, akGuard, False) ; #DEBUG_LINE_NO:350
EndEvent

Function SetShipMovedTimestamp()
  Timestamp_ShipMoved = Utility.GetCurrentRealTime() ; #DEBUG_LINE_NO:363
EndFunction

Function SetRecentlyDisembarked(Bool CheckShipMoved)
  Float now = Utility.GetCurrentRealTime() ; #DEBUG_LINE_NO:368
  Float timeSinceMoved = now - Timestamp_ShipMoved ; #DEBUG_LINE_NO:369
  If CheckShipMoved == False || timeSinceMoved < 30.0 ; #DEBUG_LINE_NO:372
    Self.StartTimer(timerDur_RecentlyDisembarked, TimerID_RecentlyDisembarked) ; #DEBUG_LINE_NO:373
    SQ_Companions_RecentlyDisembarked.SetValue(1.0) ; #DEBUG_LINE_NO:374
  Else ; #DEBUG_LINE_NO:
    Self.CancelTimer(TimerID_RecentlyDisembarked) ; #DEBUG_LINE_NO:376
    SQ_Companions_RecentlyDisembarked.SetValue(0.0) ; #DEBUG_LINE_NO:377
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Event ReferenceAlias.OnExitShipInterior(ReferenceAlias akSender, ObjectReference akShip)
  Self.SetRecentlyDisembarked(False) ; #DEBUG_LINE_NO:384
  Self.SendAffinityEvent(COM_Event_Action_Arrival, None, False) ; #DEBUG_LINE_NO:385
EndEvent

Event ReferenceAlias.OnShipGravJump(ReferenceAlias akSender, Location aDestination, Int aState)
  Self.SetShipMovedTimestamp() ; #DEBUG_LINE_NO:390
EndEvent

Event ReferenceAlias.OnShipFarTravel(ReferenceAlias akSender, Location aDepartureLocation, Location aArrivalLocation, Int aState)
  Self.SetShipMovedTimestamp() ; #DEBUG_LINE_NO:395
EndEvent

Event ReferenceAlias.OnLocationChange(ReferenceAlias akSender, Location akOldLoc, Location akNewLoc)
  Int iClothingSlot = 3 ; #DEBUG_LINE_NO:403
  Int iSpacesuitSlot = 35 ; #DEBUG_LINE_NO:404
  If PlayerRef.WornCoversBipedSlot(iClothingSlot) == False && PlayerRef.WornCoversBipedSlot(iSpacesuitSlot) == False ; #DEBUG_LINE_NO:405
    Self.SendAffinityEvent(COM_Event_Action_WalkAroundNaked, None, False) ; #DEBUG_LINE_NO:406
  EndIf ; #DEBUG_LINE_NO:
  If akNewLoc ; #DEBUG_LINE_NO:409
    spaceshipreference shipRef = akSender.GetReference().GetCurrentShipRef() ; #DEBUG_LINE_NO:411
    If shipRef as Bool && shipRef.HasKeyword(BEHostileBoardingEncounterKeyword) ; #DEBUG_LINE_NO:412
      Self.SendAffinityEvent(COM_Event_Action_ShipBoardingOther, None, False) ; #DEBUG_LINE_NO:413
    ElseIf shipRef ; #DEBUG_LINE_NO:
      Self.SendAffinityEvent(COM_Event_Action_ShipEmbark, None, False) ; #DEBUG_LINE_NO:415
    ElseIf akNewLoc.IsChild(akOldLoc) == False ; #DEBUG_LINE_NO:416
      Self.SetRecentlyDisembarked(True) ; #DEBUG_LINE_NO:418
      Bool ignoreCooldown = COM_IgnoreAffinityEventCooldownOnChangeLocation_Locations.Find(akNewLoc as Form) > -1 ; #DEBUG_LINE_NO:420
      Self.SendAffinityEvent(COM_Event_Action_Arrival, None, ignoreCooldown) ; #DEBUG_LINE_NO:423
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
  Self.StartTimer(TimerDur_Poll, TimerID_Poll) ; #DEBUG_LINE_NO:428
EndEvent

Event OnMagicEffectApply(ObjectReference akTarget, ObjectReference akCaster, MagicEffect akEffect)
  If akTarget == PlayerRef as ObjectReference ; #DEBUG_LINE_NO:443
    If akEffect == COM_AddictionEffect ; #DEBUG_LINE_NO:445
      Self.SendAffinityEvent(COM_Event_Action_ChemAddiction, None, False) ; #DEBUG_LINE_NO:446
    ElseIf akEffect.HasKeyword(ENV_EnvDamageType_Airborne) ; #DEBUG_LINE_NO:448
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalDamage_Airborne, akCaster, False) ; #DEBUG_LINE_NO:449
    ElseIf akEffect.HasKeyword(ENV_EnvDamageType_Corrosive) ; #DEBUG_LINE_NO:451
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalDamage_Corrosive, akCaster, False) ; #DEBUG_LINE_NO:452
    ElseIf akEffect.HasKeyword(ENV_EnvDamageType_Radiation) ; #DEBUG_LINE_NO:454
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalDamage_Radiation, akCaster, False) ; #DEBUG_LINE_NO:455
    ElseIf akEffect.HasKeyword(ENV_EnvDamageType_Thermal) ; #DEBUG_LINE_NO:457
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalDamage_Thermal, akCaster, False) ; #DEBUG_LINE_NO:458
    ElseIf akEffect.HasKeyword(ENV_EffectTypeEnvironmentalDamageSoak) ; #DEBUG_LINE_NO:460
      Self.SendAffinityEvent(COM_Event_Action_EnvironmentalHazardWarning, akCaster, False) ; #DEBUG_LINE_NO:461
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Event Actor.OnPlayerSwimming(Actor akSender)
  Self.SendAffinityEvent(COM_Event_Action_Swim, None, False) ; #DEBUG_LINE_NO:485
EndEvent

Event ObjectReference.OnSpellCast(ObjectReference akSender, Form akSpell)
  Self.GotoState("Processing") ; #DEBUG_LINE_NO:493
  If akSpell.HasKeyword(Artifact_Power) ; #DEBUG_LINE_NO:494
    Self.SendAffinityEvent(COM_Event_Action_UseStarbornPower, None, False) ; #DEBUG_LINE_NO:495
  EndIf ; #DEBUG_LINE_NO:
  Self.GotoState("") ; #DEBUG_LINE_NO:497
EndEvent

Event actor.OnPlayerCraftItem(Actor akSender, ObjectReference akBench, Location akLocation, Form akCreatedItem)
  Self.SendAffinityEvent(COM_Event_Action_Crafting_CreateItem, None, False) ; #DEBUG_LINE_NO:506
EndEvent

Event Actor.OnPlayerModArmorWeapon(Actor akSender, Form akBaseObject, objectmod akModBaseObject)
  If akBaseObject is Weapon ; #DEBUG_LINE_NO:515
    Self.SendAffinityEvent(COM_Event_Action_Crafting_Mod_Weapon, None, False) ; #DEBUG_LINE_NO:516
  ElseIf akBaseObject is Armor ; #DEBUG_LINE_NO:517
    Self.SendAffinityEvent(COM_Event_Action_Crafting_Mod_Armor, None, False) ; #DEBUG_LINE_NO:518
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Event Actor.OnPlayerModifiedShip(Actor akSender, spaceshipreference akShip)
  Self.SendAffinityEvent(COM_Event_Action_Crafting_CreateShipModule, akShip as ObjectReference, False) ; #DEBUG_LINE_NO:527
EndEvent

Event OnMenuOpenCloseEvent(String asMenuName, Bool abOpening)
  If asMenuName == "ChargenMenu" && abOpening == False ; #DEBUG_LINE_NO:534 ; Formerly called for "LooksMenu", which is what ChargenMenu was called in Fallout 4 - Bobbyclue 9/21/23
    Self.SendAffinityEvent(COM_Event_Action_Enhance_PlayerChangeAppearance, None, False, True) ; #DEBUG_LINE_NO:535
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Event Actor.OnPlayerFireWeapon(Actor akSender, Form akBaseObject)
  Location locToTest = akSender.GetCurrentLocation() ; #DEBUG_LINE_NO:555
  If (locToTest as Bool && akBaseObject as Bool) && commonarrayfunctions.CheckFormAgainstKeywordArray(akBaseObject, DischargeWeapon_WeaponKeywordExceptions, False) == False ; #DEBUG_LINE_NO:557
    If commonarrayfunctions.CheckFormAgainstKeywordArray(locToTest as Form, DischargeWeapon_LocationKeywordRequirements, False) ; #DEBUG_LINE_NO:559
      ObjectReference[] NPCs = akSender.FindAllReferencesWithKeyword(ActorTypeNPC as Form, DischargeWeapon_RadiusToLookForHostileActors) ; #DEBUG_LINE_NO:562
      Bool AnyHostiles = commonarrayfunctions.IsActorInArrayHostileToActor(akSender, NPCs) ; #DEBUG_LINE_NO:564
      If AnyHostiles == False ; #DEBUG_LINE_NO:566
        Self.SendAffinityEvent(COM_Event_Action_DischargeWeapon, None, False) ; #DEBUG_LINE_NO:569
      EndIf ; #DEBUG_LINE_NO:
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Event Actor.OnPlayerScannedObject(Actor akSender, ObjectReference akScannedRef)
  Self.SendAffinityEvent(COM_Event_Action_UseHandScanner, akScannedRef, False) ; #DEBUG_LINE_NO:582
EndEvent

Event Actor.OnPlayerFallLongDistance(Actor akSender, Float afDamage)
  Self.SendAffinityEvent(COM_Event_Action_JumpFromHeight, None, False) ; #DEBUG_LINE_NO:591
EndEvent

Event Actor.OnPlayerHealTeammate(Actor akSender, Actor akTeammate)
  If akTeammate == Alias_CurrentCompanion.GetActorReference() ; #DEBUG_LINE_NO:599
    Self.SendAffinityEvent(COM_Event_Action_HealCompanion, akTeammate as ObjectReference, False) ; #DEBUG_LINE_NO:600
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Event Actor.OnItemEquipped(Actor akSender, Form akBaseObject, ObjectReference akReference)
  If akBaseObject.HasKeyword(COM_ObjType_ChemBad) ; #DEBUG_LINE_NO:610
    Self.SendAffinityEvent(COM_Event_Action_Consume_Drugs, None, False) ; #DEBUG_LINE_NO:611
  ElseIf akBaseObject.HasKeyword(COM_ObjType_Drink) ; #DEBUG_LINE_NO:612
    Self.SendAffinityEvent(COM_Event_Action_Consume_Alcohol, None, False) ; #DEBUG_LINE_NO:613
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Event ObjectReference.OnItemRemoved(ObjectReference akSender, Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer, Int aiTransferReason)
  If aiTransferReason == iDroppingItemIntoWorld && akBaseItem.HasKeywordInFormList(COM_DropUsefulItemList_Ignored) == False && akBaseItem.HasKeywordInFormList(COM_DropUsefulItemList) && Game.GetPlayer().IsInCombat() == False ; #DEBUG_LINE_NO:624
    Self.SendAffinityEvent(COM_Event_Action_DropUsefulItem, None, False) ; #DEBUG_LINE_NO:625
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Event Actor.OnPlayerItemAdded(Actor akSender, Form akBaseObject, ObjectReference akOwner, ObjectReference akSourceContainer, Int aeAcquireType)
  Actor CompanionRef = ActiveCompanion.GetActorRef() ; #DEBUG_LINE_NO:681
  If aeAcquireType == 1 && CompanionRef.HasDetectionLOS(PlayerRef as ObjectReference) ; #DEBUG_LINE_NO:682
    Self.SendAffinityEvent(COM_Event_Action_Steal, None, False) ; #DEBUG_LINE_NO:683
  ElseIf aeAcquireType == 3 && CompanionRef.HasDetectionLOS(PlayerRef as ObjectReference) ; #DEBUG_LINE_NO:684
    Self.SendAffinityEvent(COM_Event_Action_StealPickpocket, None, False) ; #DEBUG_LINE_NO:685
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Function OutpostObjectPlaced(ObjectReference placedRef)
  Self.SendAffinityEvent(COM_Event_Action_Crafting_CreateOutpostModule, placedRef, False) ; #DEBUG_LINE_NO:697
EndFunction

Function CheckAndSendGravityEvents()
  Actor CompanionRef = ActiveCompanion.GetActorReference() ; #DEBUG_LINE_NO:710
  If CompanionRef ; #DEBUG_LINE_NO:711
    Float companionGravityScale = CompanionRef.GetGravityScale() ; #DEBUG_LINE_NO:712
    If companionGravityScale != lastCompanionGravityScale ; #DEBUG_LINE_NO:715
      lastCompanionGravityScale = companionGravityScale ; #DEBUG_LINE_NO:716
      If companionGravityScale > COM_Event_Action_GravityHigh_Threshold ; #DEBUG_LINE_NO:719
        Self.SendAffinityEvent(COM_Event_Action_GravityHigh, None, False) ; #DEBUG_LINE_NO:721
      ElseIf companionGravityScale < COM_Event_Action_GravityLow_Threshold ; #DEBUG_LINE_NO:722
        Self.SendAffinityEvent(COM_Event_Action_GravityLow, None, False) ; #DEBUG_LINE_NO:724
      ElseIf companionGravityScale <= 0.0 ; #DEBUG_LINE_NO:725
        Self.SendAffinityEvent(COM_Event_Action_ZeroG, None, False) ; #DEBUG_LINE_NO:727
      EndIf ; #DEBUG_LINE_NO:
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Function CheckAndSendTemperatureEvents()
  Actor CompanionRef = ActiveCompanion.GetActorReference() ; #DEBUG_LINE_NO:748
  If CompanionRef ; #DEBUG_LINE_NO:749
    If COM_CREW_CND_Comment_TemperatureCommentsAllowed.IsTrue(CompanionRef as ObjectReference, None) == False ; #DEBUG_LINE_NO:751
       ; #DEBUG_LINE_NO:
    Else ; #DEBUG_LINE_NO:
      Int temperature = iTemp_Normal ; #DEBUG_LINE_NO:754
      If CompanionRef.GetCurrentPlanet().HasKeywordInFormList(COM_LocationKeywords_VeryHot) ; #DEBUG_LINE_NO:756
        temperature = iTemp_Hot ; #DEBUG_LINE_NO:757
      ElseIf CompanionRef.GetCurrentPlanet().HasKeywordInFormList(COM_LocationKeywords_VeryCold) ; #DEBUG_LINE_NO:758
        temperature = iTemp_Cold ; #DEBUG_LINE_NO:759
      EndIf ; #DEBUG_LINE_NO:
      If temperature != lastCompanionTemperature ; #DEBUG_LINE_NO:763
        lastCompanionTemperature = temperature ; #DEBUG_LINE_NO:764
        If temperature >= iTemp_Hot ; #DEBUG_LINE_NO:767
          Self.SendAffinityEvent(COM_Event_Action_TempHigh, None, False) ; #DEBUG_LINE_NO:769
        ElseIf temperature <= iTemp_Cold ; #DEBUG_LINE_NO:770
          Self.SendAffinityEvent(COM_Event_Action_TempLow, None, False) ; #DEBUG_LINE_NO:772
        EndIf ; #DEBUG_LINE_NO:
      EndIf ; #DEBUG_LINE_NO:
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Event Actor.OnPickLock(Actor akSender, ObjectReference akLockedRef, Bool abCrime, Bool abSucceeded, terminalmenu akLockedTerminalMenu, Int aiTerminalMenuItem)
  If abSucceeded ; #DEBUG_LINE_NO:791
    If akLockedRef.GetBaseObject() is terminal ; #DEBUG_LINE_NO:792
      Self.SendAffinityEvent(COM_Event_Action_Hack, None, False) ; #DEBUG_LINE_NO:794
    Else ; #DEBUG_LINE_NO:
      Self.SendAffinityEvent(COM_Event_Action_PickLock, None, False) ; #DEBUG_LINE_NO:797
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
EndEvent

Function SendAffinityEvent(affinityevent EventToSend, ObjectReference targetRef, Bool ignoreCooldown, Bool ignorePlayerInDialogue = False)
  Bool PlayerInDialogue = False ; #DEBUG_LINE_NO:817
  Bool CompanionInScene = False ; #DEBUG_LINE_NO:819
  Actor CompanionRef = ActiveCompanion.GetActorReference() ; #DEBUG_LINE_NO:820
  If !ignorePlayerInDialogue ; Added optional bypass of dialogue check for the sake of appearance change dialogue. All appearance changes occur in dialogue, and Game.IsPlayerInDialogue() can return true even if the dialogue menu is closed - Bobbyclue 9/22/23
    PlayerInDialogue = Game.IsPlayerInDialogue()
  EndIf
  If CompanionRef ; #DEBUG_LINE_NO:821
    CompanionInScene = CompanionRef.IsInScene() ; #DEBUG_LINE_NO:822
  EndIf ; #DEBUG_LINE_NO:
  If ignoreCooldown ; #DEBUG_LINE_NO:825
    CoolingDown = False ; #DEBUG_LINE_NO:826
  EndIf ; #DEBUG_LINE_NO:
  If CoolingDown == False && PlayerInDialogue == False && CompanionInScene == False && Self.IsNearImportantScene(True, True) == False ; #DEBUG_LINE_NO:832
    EventToSend.send(targetRef) ; #DEBUG_LINE_NO:834
    Self.StartCoolDownTimer() ; #DEBUG_LINE_NO:835
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Bool Function IsNearImportantScene(Bool CheckPlayer, Bool CheckCompanion)
  Bool returnVal = False ; #DEBUG_LINE_NO:844
  Int I = 0 ; #DEBUG_LINE_NO:846
  While returnVal == False && I < ImportantSceneData.Length ; #DEBUG_LINE_NO:847
    companionaffinityeventsscript:importantscenedatum currentDatum = ImportantSceneData[I] ; #DEBUG_LINE_NO:848
    Bool sceneIsPlaying = currentDatum.ImportantScene.IsPlaying() ; #DEBUG_LINE_NO:850
    If sceneIsPlaying ; #DEBUG_LINE_NO:853
      ObjectReference refToCheck = currentDatum.AliasToCheck.GetReference() ; #DEBUG_LINE_NO:855
      If CheckPlayer && Game.GetPlayer().GetDistance(refToCheck) <= SceneNearDistance ; #DEBUG_LINE_NO:857
        returnVal = True ; #DEBUG_LINE_NO:859
      ElseIf CheckCompanion ; #DEBUG_LINE_NO:
        ObjectReference CompanionRef = ActiveCompanion.GetReference() ; #DEBUG_LINE_NO:862
        If CompanionRef as Bool && CompanionRef.GetDistance(refToCheck) <= SceneNearDistance ; #DEBUG_LINE_NO:864
          returnVal = True ; #DEBUG_LINE_NO:866
        EndIf ; #DEBUG_LINE_NO:
      EndIf ; #DEBUG_LINE_NO:
    EndIf ; #DEBUG_LINE_NO:
    I += 1 ; #DEBUG_LINE_NO:871
  EndWhile ; #DEBUG_LINE_NO:
  Return returnVal ; #DEBUG_LINE_NO:875
EndFunction

Function DebugResetActionFilterCooldown()
  CoolingDown = False ; #DEBUG_LINE_NO:882
EndFunction

Bool Function Trace(ScriptObject CallingObject, String asTextToPrint, Int aiSeverity, String MainLogName, String SubLogName, Bool bShowNormalTrace, Bool bShowWarning, Bool bPrefixTraceWithLogNames)
  Return Debug.TraceLog(CallingObject, asTextToPrint, MainLogName, SubLogName, aiSeverity, bShowNormalTrace, bShowWarning, bPrefixTraceWithLogNames, True) ; #DEBUG_LINE_NO:889
EndFunction

; Fixup hacks for debug-only function: warning
Bool Function warning(ScriptObject CallingObject, String asTextToPrint, Int aiSeverity, String MainLogName, String SubLogName, Bool bShowNormalTrace, Bool bShowWarning, Bool bPrefixTraceWithLogNames)
  Return false ; #DEBUG_LINE_NO:893
EndFunction

;-- State -------------------------------------------
State Processing

  Event ObjectReference.OnItemAdded(ObjectReference akSender, Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, Int aiTransferReason)
    ; Empty function ; #DEBUG_LINE_NO:
  EndEvent

  Event ObjectReference.OnSpellCast(ObjectReference akSender, Form akSpell)
    ; Empty function ; #DEBUG_LINE_NO:
  EndEvent
EndState
