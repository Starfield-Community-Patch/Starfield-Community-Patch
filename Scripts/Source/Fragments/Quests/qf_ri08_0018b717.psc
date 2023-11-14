ScriptName Fragments:Quests:QF_RI08_0018B717 Extends Quest Const hidden

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
GlobalVariable Property RI08_BoardMemberCount Auto Const mandatory
ReferenceAlias Property Alias_MasakoOfficeQS Auto Const mandatory
Quest Property LC044 Auto Const mandatory
Faction Property RyujinIndustriesFaction Auto Const mandatory
Perk Property FactionRyujinIndustriesPerk Auto Const mandatory
Perk Property Manipulation Auto Const mandatory
Scene Property RI08_0910_Meeting_MasakoWinsScene Auto Const mandatory
GlobalVariable Property RI08_BoardMemberTotal Auto Const mandatory
ReferenceAlias Property Alias_ConferenceRoomQS Auto Const mandatory
GlobalVariable Property RI08_InfinityYayCount Auto Const mandatory
GlobalVariable Property RI08_InfinityNayCount Auto Const mandatory
GlobalVariable Property RI08_NeuroampNayCount Auto Const mandatory
GlobalVariable Property RI08_NeuroampYayCount Auto Const mandatory
GlobalVariable Property RI08_MasakoYayCount Auto Const mandatory
GlobalVariable Property RI08_MasakoNayCount Auto Const mandatory
ReferenceAlias Property Alias_Ularu Auto Const mandatory
ReferenceAlias Property Alias_RyujinIndustriesSecurity Auto Const mandatory
ReferenceAlias Property Alias_UlaruOfficeChair Auto Const mandatory
ReferenceAlias Property Alias_SecurityPostFurniture Auto Const mandatory
GlobalVariable Property RI05_Track_PlayerSidedWithMasako Auto Const mandatory
GlobalVariable Property RI05_Track_PlayerSidedWithUlaru Auto Const mandatory
GlobalVariable Property RI08_AcquiredInfinity Auto Const mandatory
GlobalVariable Property RI08_ContinuedNeuroampResearch Auto Const mandatory
GlobalVariable Property RI08_MasakoRemainedCEO Auto Const mandatory
ReferenceAlias Property Alias_UlaruOfficeQS Auto Const mandatory
Scene Property RI08_0910_Meeting_UlaruWinsScene Auto Const mandatory
ReferenceAlias Property Alias_MasakoOfficeChair Auto Const mandatory
ReferenceAlias Property Alias_SecurityGuardMasakoFurniture Auto Const mandatory
ReferenceAlias Property Alias_Alexis Auto Const mandatory
ReferenceAlias Property Alias_Dalton Auto Const mandatory
ReferenceAlias Property Alias_Genevieve Auto Const mandatory
ReferenceAlias Property Alias_Linden Auto Const mandatory
ReferenceAlias Property Alias_Veena Auto Const mandatory
ReferenceAlias Property Alias_UlaruConferenceChair Auto Const mandatory
ReferenceAlias Property Alias_VeenaConferenceChair Auto Const mandatory
ReferenceAlias Property Alias_AlexisConferenceChair Auto Const mandatory
ReferenceAlias Property Alias_DaltonConferenceChair Auto Const mandatory
ReferenceAlias Property Alias_LindenConferenceChair Auto Const mandatory
ReferenceAlias Property Alias_GenevieveConferenceChair Auto Const mandatory
Quest Property RI08_PostQuest Auto Const mandatory
GlobalVariable Property RI05_ImogeneDead Auto Const mandatory
GlobalVariable Property MissionBoardAccessAllowed_RI Auto Const mandatory
GlobalVariable Property RI_RadiantQuestGiver Auto Const mandatory
ActorValue Property RI08_Foreknowledge_QuestLineCompletedAV Auto Const mandatory
GlobalVariable Property MQ305_RI_NeuroampPromoted Auto Const mandatory
GlobalVariable Property MQ305_RI_NeuroampNotPromoted Auto Const mandatory
ReferenceAlias Property Alias_ExecutiveGenericNPCs Auto Const mandatory
Perk Property Skill_Manipulation_InternalNeuroampBonus Auto Const mandatory
GlobalVariable Property RI07_PlayerHasInternalNeuroamp Auto Const mandatory
Quest Property RI07 Auto Const mandatory
ReferenceAlias Property Alias_Masako Auto Const mandatory
Quest Property RI_Support Auto Const mandatory
ReferenceAlias Property Alias_UlaruChairSwapMarker Auto Const mandatory
GlobalVariable Property RI05_UlaruDead Auto Const mandatory
GlobalVariable Property RI08_UlaruRemainedCFO Auto Const mandatory
Keyword Property RI08_PlayerFurnitureKeyword Auto Const mandatory
ReferenceAlias Property Alias_ConferenceRoomChairsEnableMarker Auto Const mandatory
ReferenceAlias Property Alias_UlaruConferencePlayerChair Auto Const mandatory
ReferenceAlias Property Alias_VeenaConferencePlayerChair Auto Const mandatory
ReferenceAlias Property Alias_DaltonConferencePlayerChair Auto Const mandatory
ReferenceAlias Property Alias_MasakoUlaruMoveToMarker Auto Const mandatory
ReferenceAlias Property Alias_PlayerEnteredConferenceRoomTrigger Auto Const mandatory
ReferenceAlias Property Alias_PlayerOfficeDoor Auto Const mandatory
affinityevent Property COM_WantsToTalkEvent_RyujinFaction Auto Const mandatory

;-- Functions ---------------------------------------

Function Fragment_Stage_0000_Item_00()
  Quest __temp = Self as Quest
  ri08_questscript kmyQuest = __temp as ri08_questscript
  RI_Support.SetStage(2)
  Alias_ExecutiveGenericNPCs.GetRef().Disable(False)
EndFunction

Function Fragment_Stage_0001_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Game.GetPlayer().MoveTo(Alias_UlaruOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0002_Item_00()
  Self.SetStage(0)
  Self.SetStage(200)
  Game.GetPlayer().MoveTo(Alias_MasakoOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0003_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(670)
  Self.SetStage(680)
  Self.SetStage(695)
  Self.SetStage(200)
  Game.GetPlayer().MoveTo(Alias_UlaruOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0004_Item_00()
  Self.SetStage(0)
  Self.SetStage(200)
  Self.SetStage(275)
  Self.SetStage(280)
  Self.SetStage(300)
  Self.SetStage(375)
  Self.SetStage(380)
  Self.SetStage(400)
  Self.SetStage(475)
  Self.SetStage(480)
  Self.SetStage(500)
  Self.SetStage(575)
  Self.SetStage(580)
  Self.SetStage(600)
  Self.SetStage(675)
  Self.SetStage(680)
  Self.SetStage(700)
  Self.SetStage(775)
  Self.SetStage(780)
  Self.SetStage(800)
  Game.GetPlayer().MoveTo(Alias_ConferenceRoomQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0005_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(200)
  Self.SetStage(275)
  Self.SetStage(285)
  Self.SetStage(295)
  Self.SetStage(300)
  Self.SetStage(375)
  Self.SetStage(385)
  Self.SetStage(395)
  Self.SetStage(400)
  Self.SetStage(475)
  Self.SetStage(485)
  Self.SetStage(495)
  Self.SetStage(500)
  Self.SetStage(575)
  Self.SetStage(585)
  Self.SetStage(595)
  Self.SetStage(600)
  Self.SetStage(675)
  Self.SetStage(685)
  Self.SetStage(695)
  Self.SetStage(700)
  Self.SetStage(775)
  Self.SetStage(785)
  Self.SetStage(795)
  Self.SetStage(800)
  Game.GetPlayer().MoveTo(Alias_ConferenceRoomQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0006_Item_00()
  Self.SetStage(0)
  Self.SetStage(200)
  Self.SetStage(300)
  Self.SetStage(400)
  Self.SetStage(500)
  Self.SetStage(600)
  Self.SetStage(700)
  Self.SetStage(800)
  If RI08_InfinityYayCount.GetValue() == 0.0 && RI08_InfinityNayCount.GetValue() == 0.0
    RI08_InfinityYayCount.SetValue(7.0)
  EndIf
  If RI08_NeuroampYayCount.GetValue() == 0.0 && RI08_NeuroampNayCount.GetValue() == 0.0
    RI08_NeuroampNayCount.SetValue(7.0)
  EndIf
  If RI08_MasakoYayCount.GetValue() == 0.0 && RI08_MasakoNayCount.GetValue() == 0.0
    RI08_MasakoYayCount.SetValue(7.0)
  EndIf
  Self.SetStage(900)
  Self.SetStage(1000)
  Game.GetPlayer().MoveTo(Alias_ConferenceRoomQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0007_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(200)
  Self.SetStage(300)
  Self.SetStage(400)
  Self.SetStage(500)
  Self.SetStage(600)
  Self.SetStage(700)
  Self.SetStage(800)
  If RI08_InfinityYayCount.GetValue() == 0.0 && RI08_InfinityNayCount.GetValue() == 0.0
    RI08_InfinityNayCount.SetValue(7.0)
  EndIf
  If RI08_NeuroampYayCount.GetValue() == 0.0 && RI08_NeuroampNayCount.GetValue() == 0.0
    RI08_NeuroampNayCount.SetValue(7.0)
  EndIf
  If RI08_MasakoYayCount.GetValue() == 0.0 && RI08_MasakoNayCount.GetValue() == 0.0
    RI08_MasakoNayCount.SetValue(7.0)
  EndIf
  Self.SetStage(900)
  Self.SetStage(1100)
  Game.GetPlayer().MoveTo(Alias_ConferenceRoomQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0100_Item_00()
  Self.SetActive(True)
  Self.SetObjectiveDisplayed(100, True, False)
  Alias_UlaruChairSwapMarker.GetRef().Disable(False)
EndFunction

Function Fragment_Stage_0200_Item_00()
  Self.SetActive(True)
  If RI05_UlaruDead.GetValue() == 0.0
    Alias_UlaruChairSwapMarker.GetRef().Disable(False)
  Else
    Self.ModObjectiveGlobal(-1.0, RI08_BoardMemberTotal, -1, -1.0, True, True, True, False)
  EndIf
  Self.SetObjectiveDisplayedAtTop(200)
  Self.SetObjectiveDisplayed(201, True, False)
  Self.SetObjectiveDisplayed(202, True, False)
  If Self.GetStageDone(100)
    Self.SetObjectiveCompleted(100, True)
    Self.SetObjectiveDisplayed(203, True, False)
    Self.ModObjectiveGlobal(1.0, RI08_MasakoYayCount, 203, -1.0, True, True, True, False)
    Self.ModObjectiveGlobal(1.0, RI08_BoardMemberCount, 200, -1.0, True, True, True, False)
  EndIf
  If Self.GetStageDone(670)
    Self.ModObjectiveGlobal(1.0, RI08_NeuroampYayCount, 202, -1.0, True, True, True, False)
  EndIf
  If Self.GetStageDone(675)
    Self.ModObjectiveGlobal(1.0, RI08_NeuroampNayCount, 202, -1.0, True, True, True, False)
  EndIf
  If Self.GetStageDone(680)
    Self.ModObjectiveGlobal(1.0, RI08_InfinityYayCount, 201, -1.0, True, True, True, False)
  EndIf
  If Self.GetStageDone(685)
    Self.ModObjectiveGlobal(1.0, RI08_InfinityNayCount, 202, -1.0, True, True, True, False)
  EndIf
  If Self.GetStageDone(695)
    Self.ModObjectiveGlobal(1.0, RI08_MasakoNayCount, 203, -1.0, True, True, True, False)
  EndIf
  Self.ModObjectiveGlobal(1.0, RI08_BoardMemberCount, 200, -1.0, True, True, True, False)
  Self.ModObjectiveGlobal(1.0, RI08_InfinityYayCount, 201, -1.0, True, True, True, False)
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampYayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0270_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampYayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0275_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampNayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0280_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityYayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0285_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityNayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0290_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_MasakoYayCount, 203, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0295_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_MasakoNayCount, 203, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0300_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_BoardMemberCount, 200, -1.0, True, True, True, False)
  If RI08_BoardMemberCount.GetValue() == RI08_BoardMemberTotal.GetValue()
    Self.SetStage(900)
    Alias_Alexis.GetActorRef().EvaluatePackage(False)
  EndIf
EndFunction

Function Fragment_Stage_0370_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampYayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0375_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampNayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0380_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityYayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0385_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityNayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0390_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_MasakoYayCount, 203, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0395_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_MasakoNayCount, 203, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0400_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_BoardMemberCount, 200, -1.0, True, True, True, False)
  If RI08_BoardMemberCount.GetValue() == RI08_BoardMemberTotal.GetValue()
    Self.SetStage(900)
    Alias_Dalton.GetActorRef().EvaluatePackage(False)
  EndIf
EndFunction

Function Fragment_Stage_0470_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampYayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0475_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampNayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0480_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityYayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0485_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityNayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0490_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_MasakoYayCount, 203, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0495_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_MasakoNayCount, 203, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0500_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_BoardMemberCount, 200, -1.0, True, True, True, False)
  If RI08_BoardMemberCount.GetValue() == RI08_BoardMemberTotal.GetValue()
    Self.SetStage(900)
    Alias_Genevieve.GetActorRef().EvaluatePackage(False)
  EndIf
EndFunction

Function Fragment_Stage_0570_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampYayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0575_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampNayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0580_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityYayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0585_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityNayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0590_Item_00()
  If RI05_Track_PlayerSidedWithUlaru.GetValue() == 1.0
    Self.ModObjectiveGlobal(1.0, RI08_MasakoYayCount, 203, -1.0, True, True, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0595_Item_00()
  If RI05_Track_PlayerSidedWithUlaru.GetValue() == 1.0
    Self.ModObjectiveGlobal(1.0, RI08_MasakoNayCount, 203, -1.0, True, True, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0600_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_BoardMemberCount, 200, -1.0, True, True, True, False)
  If RI08_BoardMemberCount.GetValue() == RI08_BoardMemberTotal.GetValue()
    Self.SetStage(900)
    Alias_Linden.GetActorRef().EvaluatePackage(False)
  EndIf
EndFunction

Function Fragment_Stage_0670_Item_00()
  If !Self.GetStageDone(100)
    Self.ModObjectiveGlobal(1.0, RI08_NeuroampYayCount, 202, -1.0, True, True, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0675_Item_00()
  If !Self.GetStageDone(100)
    Self.ModObjectiveGlobal(1.0, RI08_NeuroampNayCount, 202, -1.0, True, True, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0680_Item_00()
  If !Self.GetStageDone(100)
    Self.ModObjectiveGlobal(1.0, RI08_InfinityYayCount, 201, -1.0, True, True, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0685_Item_00()
  If !Self.GetStageDone(100)
    Self.ModObjectiveGlobal(1.0, RI08_InfinityNayCount, 201, -1.0, True, True, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0690_Item_00()
  If !Self.GetStageDone(100)
    Self.ModObjectiveGlobal(1.0, RI08_MasakoYayCount, 203, -1.0, True, True, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0695_Item_00()
  If !Self.GetStageDone(100)
    Self.ModObjectiveGlobal(1.0, RI08_MasakoNayCount, 203, -1.0, True, True, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0700_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_BoardMemberCount, 200, -1.0, True, True, True, False)
  If RI08_BoardMemberCount.GetValue() == RI08_BoardMemberTotal.GetValue()
    Self.SetStage(900)
    Alias_Ularu.GetActorRef().EvaluatePackage(False)
  EndIf
EndFunction

Function Fragment_Stage_0770_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampYayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0775_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_NeuroampNayCount, 202, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0780_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityYayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0785_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_InfinityNayCount, 201, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0790_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_MasakoYayCount, 203, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0795_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_MasakoNayCount, 203, -1.0, True, True, True, False)
EndFunction

Function Fragment_Stage_0800_Item_00()
  Self.ModObjectiveGlobal(1.0, RI08_BoardMemberCount, 200, -1.0, True, True, True, False)
  If RI08_BoardMemberCount.GetValue() == RI08_BoardMemberTotal.GetValue()
    Self.SetStage(900)
    Alias_Veena.GetActorRef().EvaluatePackage(False)
  EndIf
EndFunction

Function Fragment_Stage_0900_Item_00()
  Quest __temp = Self as Quest
  ri08_questscript kmyQuest = __temp as ri08_questscript
  Self.SetObjectiveCompleted(200, True)
  Self.SetObjectiveDisplayed(201, False, False)
  Self.SetObjectiveDisplayed(202, False, False)
  Self.SetObjectiveDisplayed(203, False, False)
  Self.SetObjectiveDisplayedAtTop(900)
  Alias_ConferenceRoomChairsEnableMarker.GetRef().Disable(False)
  If RI05_UlaruDead.GetValue() == 0.0
    Alias_UlaruConferenceChair.GetRef().Enable(False)
    Alias_UlaruConferencePlayerChair.GetRef().Disable(False)
  EndIf
  Alias_DaltonConferenceChair.GetRef().Enable(False)
  Alias_DaltonConferencePlayerChair.GetRef().Disable(False)
  Alias_VeenaConferenceChair.GetRef().Enable(False)
  Alias_VeenaConferencePlayerChair.GetRef().Disable(False)
  Alias_Alexis.GetActorRef().EvaluatePackage(False)
  Alias_Dalton.GetActorRef().EvaluatePackage(False)
  Alias_Genevieve.GetActorRef().EvaluatePackage(False)
  Alias_Linden.GetActorRef().EvaluatePackage(False)
  Alias_Ularu.GetActorRef().EvaluatePackage(False)
  Alias_Veena.GetActorRef().EvaluatePackage(False)
  Alias_Masako.GetActorRef().EvaluatePackage(False)
  kmyQuest.CalculateVotes()
EndFunction

Function Fragment_Stage_0901_Item_00()
  Actor PlayerRef = Game.GetPlayer()
  Actor MasakoRef = Alias_Masako.GetActorRef()
  Actor UlaruRef = Alias_Ularu.GetActorRef()
  ObjectReference MoveMarkerRef = Alias_MasakoUlaruMoveToMarker.GetRef()
  ObjectReference TriggerRef = Alias_PlayerEnteredConferenceRoomTrigger.GetRef()
  If !PlayerRef.HasDetectionLOS(MasakoRef as ObjectReference) && !TriggerRef.IsInTrigger(MasakoRef as ObjectReference)
    MasakoRef.MoveTo(MoveMarkerRef, 0.0, 0.0, 0.0, True, False)
  EndIf
  If !PlayerRef.HasDetectionLOS(UlaruRef as ObjectReference) && !TriggerRef.IsInTrigger(UlaruRef as ObjectReference) && RI05_UlaruDead.GetValue() == 0.0
    UlaruRef.MoveTo(MoveMarkerRef, 0.0, 0.0, 0.0, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0905_Item_00()
  Quest __temp = Self as Quest
  ri08_questscript kmyQuest = __temp as ri08_questscript
  kmyQuest.FreezeControlsMeeting()
EndFunction

Function Fragment_Stage_0909_Item_00()
  Self.SetStage(925)
EndFunction

Function Fragment_Stage_0910_Item_00()
  Quest __temp = Self as Quest
  ri08_questscript kmyQuest = __temp as ri08_questscript
  If Self.IsObjectiveDisplayed(927)
    Self.SetObjectiveCompleted(927, True)
  EndIf
  If Self.IsObjectiveDisplayed(925)
    Self.SetObjectiveCompleted(925, True)
  EndIf
  If Self.GetStageDone(918)
    If !Self.IsObjectiveDisplayed(900)
      Self.SetObjectiveDisplayed(900, True, False)
    EndIf
    If RI05_Track_PlayerSidedWithMasako.GetValue() == 1.0
      RI08_0910_Meeting_MasakoWinsScene.Start()
    Else
      RI08_0910_Meeting_UlaruWinsScene.Start()
    EndIf
  Else
    Self.SetObjectiveDisplayed(925, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0911_Item_00()
  If RI05_UlaruDead.GetValue() == 0.0
    If Self.GetStageDone(912) && Self.GetStageDone(913) && Self.GetStageDone(914) && Self.GetStageDone(915) && Self.GetStageDone(916) && Self.GetStageDone(917)
      Self.SetStage(918)
    EndIf
  ElseIf Self.GetStageDone(912) && Self.GetStageDone(913) && Self.GetStageDone(914) && Self.GetStageDone(916) && Self.GetStageDone(917)
    Self.SetStage(918)
  EndIf
EndFunction

Function Fragment_Stage_0912_Item_00()
  If RI05_UlaruDead.GetValue() == 0.0
    If Self.GetStageDone(911) && Self.GetStageDone(913) && Self.GetStageDone(914) && Self.GetStageDone(915) && Self.GetStageDone(916) && Self.GetStageDone(917)
      Self.SetStage(918)
    EndIf
  ElseIf Self.GetStageDone(911) && Self.GetStageDone(913) && Self.GetStageDone(914) && Self.GetStageDone(916) && Self.GetStageDone(917)
    Self.SetStage(918)
  EndIf
EndFunction

Function Fragment_Stage_0913_Item_00()
  If RI05_UlaruDead.GetValue() == 0.0
    If Self.GetStageDone(911) && Self.GetStageDone(912) && Self.GetStageDone(914) && Self.GetStageDone(915) && Self.GetStageDone(916) && Self.GetStageDone(917)
      Self.SetStage(918)
    EndIf
  ElseIf Self.GetStageDone(911) && Self.GetStageDone(912) && Self.GetStageDone(914) && Self.GetStageDone(916) && Self.GetStageDone(917)
    Self.SetStage(918)
  EndIf
EndFunction

Function Fragment_Stage_0914_Item_00()
  If RI05_UlaruDead.GetValue() == 0.0
    If Self.GetStageDone(911) && Self.GetStageDone(912) && Self.GetStageDone(913) && Self.GetStageDone(915) && Self.GetStageDone(916) && Self.GetStageDone(917)
      Self.SetStage(918)
    EndIf
  ElseIf Self.GetStageDone(911) && Self.GetStageDone(912) && Self.GetStageDone(913) && Self.GetStageDone(916) && Self.GetStageDone(917)
    Self.SetStage(918)
  EndIf
EndFunction

Function Fragment_Stage_0915_Item_00()
  If Self.GetStageDone(911) && Self.GetStageDone(912) && Self.GetStageDone(913) && Self.GetStageDone(914) && Self.GetStageDone(916) && Self.GetStageDone(917)
    Self.SetStage(918)
  EndIf
EndFunction

Function Fragment_Stage_0916_Item_00()
  If RI05_UlaruDead.GetValue() == 0.0
    If Self.GetStageDone(911) && Self.GetStageDone(912) && Self.GetStageDone(913) && Self.GetStageDone(914) && Self.GetStageDone(915) && Self.GetStageDone(917)
      Self.SetStage(918)
    EndIf
  ElseIf Self.GetStageDone(911) && Self.GetStageDone(912) && Self.GetStageDone(913) && Self.GetStageDone(916) && Self.GetStageDone(917)
    Self.SetStage(918)
  EndIf
EndFunction

Function Fragment_Stage_0917_Item_00()
  If RI05_UlaruDead.GetValue() == 0.0
    If Self.GetStageDone(911) && Self.GetStageDone(912) && Self.GetStageDone(913) && Self.GetStageDone(914) && Self.GetStageDone(915) && Self.GetStageDone(916)
      Self.SetStage(918)
    EndIf
  ElseIf Self.GetStageDone(911) && Self.GetStageDone(912) && Self.GetStageDone(913) && Self.GetStageDone(914) && Self.GetStageDone(916)
    Self.SetStage(918)
  EndIf
EndFunction

Function Fragment_Stage_0918_Item_00()
  If Self.IsObjectiveDisplayed(925)
    Self.SetObjectiveCompleted(925, True)
  EndIf
  Actor PlayerRef = Game.GetPlayer()
  ObjectReference PlayerFurniture = PlayerRef.GetFurnitureUsing()
  If PlayerRef.GetSitState() == 3 && PlayerFurniture.HasKeyword(RI08_PlayerFurnitureKeyword) == True
    Utility.Wait(5.0)
    Self.SetStage(910)
  Else
    Self.SetStage(927)
  EndIf
EndFunction

Function Fragment_Stage_0920_Item_00()
  If !Self.GetStageDone(915) && RI05_UlaruDead.GetValue() == 0.0
    Alias_Ularu.GetActorRef().SnapIntoInteraction(Alias_UlaruConferenceChair.GetRef())
  EndIf
  If !Self.GetStageDone(916)
    Alias_Veena.GetActorRef().SnapIntoInteraction(Alias_VeenaConferenceChair.GetRef())
  EndIf
  If !Self.GetStageDone(911)
    Alias_Alexis.GetActorRef().SnapIntoInteraction(Alias_AlexisConferenceChair.GetRef())
  EndIf
  If !Self.GetStageDone(914)
    Alias_Linden.GetActorRef().SnapIntoInteraction(Alias_LindenConferenceChair.GetRef())
  EndIf
  If !Self.GetStageDone(913)
    Alias_Genevieve.GetActorRef().SnapIntoInteraction(Alias_GenevieveConferenceChair.GetRef())
  EndIf
  If !Self.GetStageDone(912)
    Alias_Dalton.GetActorRef().SnapIntoInteraction(Alias_DaltonConferenceChair.GetRef())
  EndIf
EndFunction

Function Fragment_Stage_0925_Item_00()
  Self.SetObjectiveDisplayed(925, True, False)
EndFunction

Function Fragment_Stage_0927_Item_00()
  Self.SetObjectiveDisplayed(927, True, False)
EndFunction

Function Fragment_Stage_0980_Item_00()
  Quest __temp = Self as Quest
  ri08_questscript kmyQuest = __temp as ri08_questscript
  RI08_UlaruRemainedCFO.SetValue(0.0)
  kmyQuest.ModifyVotes()
EndFunction

Function Fragment_Stage_0985_Item_00()
  RI08_UlaruRemainedCFO.SetValue(1.0)
EndFunction

Function Fragment_Stage_0990_Item_00()
  Quest __temp = Self as Quest
  ri08_questscript kmyQuest = __temp as ri08_questscript
  kmyQuest.ModifyVotes()
EndFunction

Function Fragment_Stage_10000_Item_00()
  Quest __temp = Self as Quest
  ri08_questscript kmyQuest = __temp as ri08_questscript
  Alias_Masako.GetActorRef().EvaluatePackage(False)
  Alias_Ularu.GetActorRef().EvaluatePackage(False)
  If Self.IsObjectiveDisplayed(1000)
    Self.SetObjectiveCompleted(1000, True)
  ElseIf Self.IsObjectiveDisplayed(1100)
    Self.SetObjectiveCompleted(1100, True)
  EndIf
  If RI05_ImogeneDead.GetValue() == 0.0 && RI05_Track_PlayerSidedWithMasako.GetValue() == 1.0
    RI08_PostQuest.SetStage(100)
  Else
    MissionBoardAccessAllowed_RI.SetValue(1.0)
    RI08_PostQuest.SetStage(200)
  EndIf
  Alias_PlayerOfficeDoor.GetRef().Lock(False, False, True)
  Game.GetPlayer().SetValue(RI08_Foreknowledge_QuestLineCompletedAV, 1.0)
  If RI08_ContinuedNeuroampResearch.GetValue() == 1.0
    MQ305_RI_NeuroampPromoted.SetValue(1.0)
  Else
    MQ305_RI_NeuroampNotPromoted.SetValue(1.0)
  EndIf
  COM_WantsToTalkEvent_RyujinFaction.Send(None)
  Game.AddAchievement(19)
  Self.Stop()
EndFunction

Function Fragment_Stage_1000_Item_00()
  Quest __temp = Self as Quest
  ri08_questscript kmyQuest = __temp as ri08_questscript
  Self.SetObjectiveCompleted(900, True)
  Self.SetObjectiveDisplayed(1000, True, False)
  kmyQuest.UnfreezeControlsMeeting()
  Actor UlaruRef = Alias_Ularu.GetActorRef()
  UlaruRef.MoveTo(Alias_UlaruOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
  UlaruRef.EvaluatePackage(False)
  Alias_RyujinIndustriesSecurity.GetRef().MoveTo(Alias_SecurityPostFurniture.GetRef(), 0.0, 0.0, 0.0, True, False)
  Game.GetPlayer().GetFurnitureUsing().Activate(Game.GetPlayer() as ObjectReference, False)
  Alias_Masako.GetActorRef().EvaluatePackage(False)
  Alias_Alexis.GetActorRef().EvaluatePackage(False)
  Alias_Dalton.GetActorRef().EvaluatePackage(False)
  Alias_Genevieve.GetActorRef().EvaluatePackage(False)
  Alias_Linden.GetActorRef().EvaluatePackage(False)
  Alias_Veena.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_1100_Item_00()
  Quest __temp = Self as Quest
  ri08_questscript kmyQuest = __temp as ri08_questscript
  Self.SetObjectiveCompleted(900, True)
  Self.SetObjectiveDisplayed(1100, True, False)
  kmyQuest.UnfreezeControlsMeeting()
  Actor MasakoRef = Alias_Masako.GetActorRef()
  MasakoRef.MoveTo(Alias_MasakoOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
  MasakoRef.EvaluatePackage(False)
  Alias_RyujinIndustriesSecurity.GetRef().MoveTo(Alias_SecurityGuardMasakoFurniture.GetRef(), 0.0, 0.0, 0.0, True, False)
  Game.GetPlayer().GetFurnitureUsing().Activate(Game.GetPlayer() as ObjectReference, False)
  Alias_Alexis.GetActorRef().EvaluatePackage(False)
  Alias_Dalton.GetActorRef().EvaluatePackage(False)
  Alias_Genevieve.GetActorRef().EvaluatePackage(False)
  Alias_Linden.GetActorRef().EvaluatePackage(False)
  Alias_Ularu.GetActorRef().EvaluatePackage(False)
  Alias_Veena.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_1200_Item_00()
  Alias_ConferenceRoomChairsEnableMarker.GetRef().Enable(False)
  If RI05_UlaruDead.GetValue() == 0.0
    Alias_UlaruConferenceChair.GetRef().Disable(False)
    Alias_UlaruConferencePlayerChair.GetRef().Enable(False)
  EndIf
  Alias_DaltonConferenceChair.GetRef().Disable(False)
  Alias_DaltonConferencePlayerChair.GetRef().Enable(False)
  Alias_VeenaConferenceChair.GetRef().Disable(False)
  Alias_VeenaConferencePlayerChair.GetRef().Enable(False)
EndFunction
