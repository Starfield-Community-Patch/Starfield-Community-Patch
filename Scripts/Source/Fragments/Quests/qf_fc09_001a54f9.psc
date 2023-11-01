ScriptName Fragments:Quests:QF_FC09_001A54F9 Extends Quest Const hidden

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
ReferenceAlias Property Alias_RonHope Auto Const mandatory
Faction Property PlayerEnemyFaction Auto Const mandatory
RefCollectionAlias Property Alias_AllGuards Auto Const mandatory
Faction Property FC09_HopeTechEnemyFaction Auto Const mandatory
Faction Property CrimeFactionFreestar Auto Const mandatory
ReferenceAlias Property Alias_Player Auto Const mandatory
MiscObject Property Credits Auto Const mandatory
Scene Property FC09_RonHopeInitialScene Auto Const mandatory
Key Property FreestarRangerBadge_Ranger Auto Const mandatory
ObjectReference Property FC09_PT1 Auto Const mandatory
Faction Property GuardFaction Auto Const mandatory
ObjectReference Property FC09_IntroSceneMarker_Hope Auto Const mandatory
ObjectReference Property FC09_IntroSceneMarker_Cosette Auto Const mandatory
ObjectReference Property FC09_IntroSceneMarker_Birgit Auto Const mandatory
ReferenceAlias Property Alias_Cosette Auto Const mandatory
ReferenceAlias Property Alias_BirgitMacDougall Auto Const mandatory
ReferenceAlias Property Alias_GuardM01 Auto Const mandatory
ReferenceAlias Property Alias_GuardF01 Auto Const mandatory
ObjectReference Property FC09_IntroSceneMarker_GuardF01 Auto Const mandatory
ObjectReference Property FC09_IntroSceneMarker_GuardM01 Auto Const mandatory
Scene Property FC09_CompanionBribeReactScene Auto Const mandatory
Faction Property HT_GenericSecurityFaction Auto Const mandatory
Quest Property FC01 Auto Const mandatory
RefCollectionAlias Property Alias_WorkersToDisable Auto Const mandatory
Quest Property RAD02 Auto Const mandatory
ReferenceAlias Property Alias_EvidenceSlate Auto Const mandatory
Scene Property FC09_CheerForPlayerPromotionScene Auto Const mandatory
ActorValue Property FreestarRangerRank Auto Const mandatory
Quest Property FC_EvidenceSlateHolderQuest Auto Const mandatory
Quest Property AutumnEliteCrewQuest Auto Const
ActorValue Property FC09_Completed Auto Const mandatory
GlobalVariable Property MQ305_FSC_RonHopeKilled Auto Const mandatory
GlobalVariable Property MQ305_FSC_RonHopeBribeAccepted Auto Const mandatory
GlobalVariable Property MQ305_FSC_RonHopeJailed Auto Const mandatory
Armor Property Spacesuit_Ranger_01 Auto Const mandatory
Armor Property Spacesuit_Ranger_Helmet_01 Auto Const mandatory
Armor Property Spacesuit_Ranger_Backpack_01 Auto Const mandatory
GlobalVariable Property FC09_PayoffAmountBig Auto Const mandatory
GlobalVariable Property FC09_PayoffAmountSmall Auto Const mandatory
Armor Property Clothes_Ranger_Vested Auto Const mandatory
LeveledItem Property LL_Weapon_FreestarRangersRifle Auto Const mandatory
ReferenceAlias Property Alias_RewardShip Auto Const mandatory
ActorValue Property SpaceshipCrew Auto Const mandatory
affinityevent Property COM_WantsToTalkEvent_FreestarCollective Auto Const mandatory
ObjectReference Property FC09_GuardM01TravelMarker Auto Const mandatory
Message Property FC09_ShipRewardMessage Auto Const mandatory
ActorValue Property SpaceshipRegistration Auto Const mandatory
Float Property cooldownDays Auto Const
GlobalVariable Property SE_FAB23_Timestamp Auto Const mandatory
GlobalVariable Property SE_FAB22_Timestamp Auto Const mandatory
ReferenceAlias[] Property Alias_Companions Auto Const mandatory
GlobalVariable Property COM_WantsToTalk_CooldownDays Auto Const mandatory
ActorValue Property COM_WantsToTalk_FreestarCollective_Cooldown Auto Const mandatory
Keyword Property LocTypeSENotAllowed Auto Const mandatory
Location Property SArcturus_PArcturusII_Orbit Auto Const mandatory
Location Property scLC053Location Auto Const mandatory
Faction Property FC09_CombatMusicFaction Auto Const mandatory

;-- Functions ---------------------------------------

Function Fragment_Stage_0300_Item_00()
  ; Empty function
EndFunction

Function Fragment_Stage_0425_Item_00()
  ; Empty function
EndFunction

Function Fragment_Stage_0000_Item_00()
  Alias_RonHope.GetRef().MoveTo(FC09_IntroSceneMarker_Hope, 0.0, 0.0, 0.0, True, False)
  Alias_Cosette.GetRef().MoveTo(FC09_IntroSceneMarker_Cosette, 0.0, 0.0, 0.0, True, False)
  Alias_BirgitMacDougall.GetRef().MoveTo(FC09_IntroSceneMarker_Hope, 0.0, 0.0, 0.0, True, False)
  Alias_GuardF01.GetRef().MoveTo(FC09_IntroSceneMarker_GuardF01, 0.0, 0.0, 0.0, True, False)
  Alias_GuardM01.GetRef().MoveTo(FC09_IntroSceneMarker_GuardM01, 0.0, 0.0, 0.0, True, False)
  Actor[] workers = Alias_WorkersToDisable.GetArray() as Actor[]
  Int I = 0
  While I < workers.Length
    workers[I].DisableNoWait(False)
    I += 1
  EndWhile
  FC01.SetStage(2000)
EndFunction

Function Fragment_Stage_0050_Item_00()
  Self.SetActive(True)
  Self.SetObjectiveDisplayed(50, True, False)
EndFunction

Function Fragment_Stage_0100_Item_00()
  Self.SetobjectiveCompleted(50, True)
  Self.SetObjectiveDisplayed(100, True, False)
  Alias_AllGuards.ResetAll()
  Alias_RonHope.GetRef().Reset(None)
  Alias_Cosette.GetRef().Reset(None)
  Alias_Cosette.GetActorRef().AddToFaction(HT_GenericSecurityFaction)
  Actor[] workers = Alias_WorkersToDisable.GetArray() as Actor[]
  Int I = 0
  While I < workers.Length
    workers[I].DisableNoWait(False)
    I += 1
  EndWhile
  Alias_RonHope.GetRef().MoveTo(FC09_IntroSceneMarker_Hope, 0.0, 0.0, 0.0, True, False)
  Alias_Cosette.GetRef().MoveTo(FC09_IntroSceneMarker_Cosette, 0.0, 0.0, 0.0, True, False)
  Alias_BirgitMacDougall.GetRef().MoveTo(FC09_IntroSceneMarker_Birgit, 0.0, 0.0, 0.0, True, False)
  Alias_GuardM01.GetRef().MoveTo(FC09_GuardM01TravelMarker, 0.0, 0.0, 0.0, True, False)
  Alias_GuardF01.GetRef().MoveTo(FC09_IntroSceneMarker_GuardF01, 0.0, 0.0, 0.0, True, False)
  SArcturus_PArcturusII_Orbit.RemoveKeyword(LocTypeSENotAllowed)
  scLC053Location.RemoveKeyword(LocTypeSENotAllowed)
EndFunction

Function Fragment_Stage_0150_Item_00()
  FC09_RonHopeInitialScene.Start()
EndFunction

Function Fragment_Stage_0160_Item_00()
  Alias_RonHope.GetActorRef().EvaluatePackage(False)
  Alias_Cosette.GetActorRef().EvaluatePackage(False)
  Alias_BirgitMacDougall.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0200_Item_00()
  Alias_Player.GetActorRef().AddItem(Credits as Form, 10, False)
  Self.SetobjectiveCompleted(100, True)
  Self.SetStage(700)
EndFunction

Function Fragment_Stage_0310_Item_00()
  Int PayoffSmall = FC09_PayoffAmountSmall.GetValue() as Int
  Alias_Player.GetActorRef().AddItem(Credits as Form, PayoffSmall, False)
  Self.SetobjectiveCompleted(100, True)
  Self.SetStage(300)
  Self.SetStage(700)
  FC09_CompanionBribeReactScene.Start()
EndFunction

Function Fragment_Stage_0320_Item_00()
  Int PayoffBig = FC09_PayoffAmountBig.GetValue() as Int
  Alias_Player.GetActorRef().AddItem(Credits as Form, PayoffBig, False)
  Alias_Player.GetActorRef().RemoveItem(Alias_EvidenceSlate.GetRef() as Form, 1, False, None)
  Self.SetobjectiveCompleted(100, True)
  Self.SetStage(300)
  Self.SetStage(700)
  FC09_CompanionBribeReactScene.Start()
EndFunction

Function Fragment_Stage_0350_Item_00()
  Alias_Player.GetActorRef().RemoveItem(Alias_EvidenceSlate.GetRef() as Form, 1, False, None)
  Self.SetobjectiveCompleted(100, True)
  Self.SetStage(700)
EndFunction

Function Fragment_Stage_0500_Item_00()
  Self.SetobjectiveCompleted(100, True)
  Self.SetObjectiveDisplayed(200, True, False)
  Self.SetObjectiveDisplayed(220, True, False)
  Alias_RonHope.GetActorRef().SetEssential(False)
  Alias_Cosette.GetActorRef().SetEssential(False)
  Alias_RonHope.GetActorRef().AddToFaction(PlayerEnemyFaction)
  Alias_RonHope.GetActorRef().AddToFaction(FC09_CombatMusicFaction)
  Alias_AllGuards.AddToFaction(FC09_CombatMusicFaction)
  Alias_AllGuards.RemoveFromFaction(GuardFaction)
  Alias_AllGuards.RemoveFromFaction(HT_GenericSecurityFaction)
  Alias_AllGuards.RemoveFromFaction(CrimeFactionFreestar)
  Alias_RonHope.GetActorRef().RemoveFromFaction(CrimeFactionFreestar)
  Alias_Cosette.GetActorRef().RemoveFromFaction(CrimeFactionFreestar)
  Alias_Cosette.GetActorRef().RemoveFromFaction(HT_GenericSecurityFaction)
  Self.SetStage(525)
EndFunction

Function Fragment_Stage_0525_Item_00()
  Alias_Player.GetActorRef().AddToFaction(FC09_HopeTechEnemyFaction)
EndFunction

Function Fragment_Stage_0550_Item_00()
  Self.SetobjectiveCompleted(220, True)
  If Self.GetStageDone(600)
    Self.SetStage(610)
  EndIf
EndFunction

Function Fragment_Stage_0600_Item_00()
  Self.SetobjectiveCompleted(200, True)
  If Self.GetStageDone(550)
    Self.SetStage(610)
  EndIf
  RAD02.SetStage(500)
  Alias_BirgitMacDougall.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0610_Item_00()
  Self.SetObjectiveDisplayed(250, True, False)
  Alias_BirgitMacDougall.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0620_Item_00()
  Alias_BirgitMacDougall.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0700_Item_00()
  If Self.IsObjectiveDisplayed(250)
    Self.SetobjectiveCompleted(250, True)
  EndIf
  Alias_BirgitMacDougall.GetActorRef().SetEssential(False)
  Self.SetObjectiveDisplayed(300, True, False)
EndFunction

Function Fragment_Stage_0700_Item_01()
  Self.SetobjectiveCompleted(200, True)
  Self.SetObjectiveDisplayed(300, True, False)
EndFunction

Function Fragment_Stage_0800_Item_00()
  Alias_Player.GetActorRef().AddItem(FreestarRangerBadge_Ranger as Form, 1, False)
EndFunction

Function Fragment_Stage_0900_Item_00()
  FC09_CheerForPlayerPromotionScene.Start()
  AutumnEliteCrewQuest.SetStage(1)
EndFunction

Function Fragment_Stage_2000_Item_00()
  MQ305_FSC_RonHopeKilled.SetValue(1.0)
  Alias_Player.GetActorRef().SetValue(FC09_Completed, 1.0)
  RAD02.SetStage(505)
  Actor[] workers = Alias_WorkersToDisable.GetArray() as Actor[]
  Int I = 0
  While I < workers.Length
    workers[I].EnableNoWait(False)
    I += 1
  EndWhile
  Alias_Player.GetActorRef().SetValue(FreestarRangerRank, 2.0)
  Self.CompleteAllObjectives()
  Alias_Player.GetActorRef().AddItem(Spacesuit_Ranger_01 as Form, 1, False)
  Alias_Player.GetActorRef().AddItem(Spacesuit_Ranger_Helmet_01 as Form, 1, False)
  Alias_Player.GetActorRef().AddItem(Spacesuit_Ranger_Backpack_01 as Form, 1, False)
  Alias_Player.GetActorRef().AddItem(Clothes_Ranger_Vested as Form, 1, False)
  Alias_Player.GetActorRef().AddItem(LL_Weapon_FreestarRangersRifle as Form, 1, False)
  spaceshipreference myShip = Alias_RewardShip.GetShipRef()
  myShip.SetValue(SpaceshipCrew, 0.0)
  myShip.SetValue(SpaceshipRegistration, 1.0)
  sq_playershipscript SQ_PlayerShip = Game.GetForm(95394) as sq_playershipscript
  SQ_PlayerShip.AddPlayerOwnedShip(myShip)
  FC09_ShipRewardMessage.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  Game.AddAchievement(16)
  Float currentGameTime = Utility.GetCurrentGameTime()
  Float cooldownTime = currentGameTime + COM_WantsToTalk_CooldownDays.GetValue()
  Int z = 0
  While z < Alias_Companions.Length
    Alias_Companions[z].GetActorRef().SetValue(COM_WantsToTalk_FreestarCollective_Cooldown, cooldownTime)
    z += 1
  EndWhile
  COM_WantsToTalkEvent_FreestarCollective.Send(None)
  SE_FAB23_Timestamp.SetValue(currentGameTime + cooldownDays)
  FC_EvidenceSlateHolderQuest.Stop()
  Self.Stop()
EndFunction

Function Fragment_Stage_2000_Item_01()
  Actor[] workers = Alias_WorkersToDisable.GetArray() as Actor[]
  Int I = 0
  While I < workers.Length
    workers[I].EnableNoWait(False)
    I += 1
  EndWhile
  Alias_Player.GetActorRef().SetValue(FC09_Completed, 1.0)
  Self.SetStage(900)
  If Self.GetStageDone(300)
    MQ305_FSC_RonHopeBribeAccepted.SetValue(1.0)
  Else
    MQ305_FSC_RonHopeJailed.SetValue(1.0)
  EndIf
  RAD02.SetStage(505)
  Alias_Player.GetActorRef().SetValue(FreestarRangerRank, 2.0)
  Alias_Player.GetActorRef().AddItem(Spacesuit_Ranger_01 as Form, 1, False)
  Alias_Player.GetActorRef().AddItem(Spacesuit_Ranger_Helmet_01 as Form, 1, False)
  Alias_Player.GetActorRef().AddItem(Spacesuit_Ranger_Backpack_01 as Form, 1, False)
  Alias_Player.GetActorRef().AddItem(Clothes_Ranger_Vested as Form, 1, False)
  Alias_Player.GetActorRef().AddItem(LL_Weapon_FreestarRangersRifle as Form, 1, False)
  spaceshipreference myShip = Alias_RewardShip.GetShipRef()
  myShip.SetValue(SpaceshipCrew, 0.0)
  myShip.SetValue(SpaceshipRegistration, 1.0)
  sq_playershipscript SQ_PlayerShip = Game.GetForm(95394) as sq_playershipscript
  SQ_PlayerShip.AddPlayerOwnedShip(myShip)
  FC09_ShipRewardMessage.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  Self.CompleteAllObjectives()
  Game.AddAchievement(16)
  Float currentGameTime = Utility.GetCurrentGameTime()
  Float cooldownTime = currentGameTime + COM_WantsToTalk_CooldownDays.GetValue()
  Int z = 0
  While z < Alias_Companions.Length
    Alias_Companions[z].GetActorRef().SetValue(COM_WantsToTalk_FreestarCollective_Cooldown, cooldownTime)
    z += 1
  EndWhile
  COM_WantsToTalkEvent_FreestarCollective.Send(None)
  SE_FAB22_Timestamp.SetValue(currentGameTime + cooldownDays)
  FC_EvidenceSlateHolderQuest.Stop()
  Self.Stop()
EndFunction
