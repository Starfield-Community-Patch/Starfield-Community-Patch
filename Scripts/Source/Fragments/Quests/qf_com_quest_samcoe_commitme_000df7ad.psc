ScriptName Fragments:Quests:QF_COM_Quest_SamCoe_Commitme_000DF7AD Extends Quest Const hidden

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
ReferenceAlias Property Alias_SamCoe Auto Const mandatory
ReferenceAlias Property Alias_CoraCoe Auto Const mandatory
ReferenceAlias Property Alias_JacobCoe Auto Const mandatory
ReferenceAlias Property Alias_LillianHart Auto Const mandatory
ReferenceAlias Property Alias_AhnjongSinclair Auto Const mandatory
ReferenceAlias Property Alias_EliasCartwright Auto Const mandatory
Keyword Property Commitment_SamCoe_PreCeremony Auto Const mandatory
Keyword Property Commitment_SamCoe_RoundUp Auto Const mandatory
ActorValue Property Commitment_SamCoe_State Auto Const mandatory
ObjectReference Property CommitmentCeremonyMarker_Player Auto Const mandatory
Scene Property Commitment_SamCoe_0325_CoraSinclair_BarkScene Auto Const mandatory
sq_companionsscript Property SQ_Companions Auto Const mandatory
ObjectReference Property CommitmentCeremonyMarker_Jacob Auto Const mandatory
ObjectReference Property CommitmentCeremonyMarker_Elias Auto Const mandatory
ObjectReference Property Commitment_SamCoe_Marker_RoundUp_Lillian Auto Const mandatory
ObjectReference Property Commitment_OverrideMarker Auto Const mandatory
ObjectReference Property Commitment_SamCoe_Cora_Start_Marker Auto Const mandatory
ObjectReference Property Commitment_SamCoe_Player_Start_Marker Auto Const mandatory
ObjectReference Property CommitmentCeremonyMarker_Sam Auto Const mandatory
sq_followersscript Property SQ_Followers Auto Const mandatory
ObjectReference Property CommitmentCeremonyEnableMarker Auto Const mandatory
ActorValue Property CrewReassignDisabled Auto Const mandatory
RefCollectionAlias Property DismissedCrew Auto Const mandatory
RefCollectionAlias Property DisembarkingCrew Auto Const mandatory
Quest Property SQ_Crew Auto Const mandatory
Activator Property COM_CQ_TxtReplace_QuestName_SamCoe Auto Const mandatory
ObjectReference Property Commitment_SamCoe_Marker_RoundUp_Cora Auto Const mandatory

;-- Functions ---------------------------------------

Function Fragment_Stage_0000_Item_00()
  Alias_CoraCoe.GetActorRef().MoveTo(Commitment_SamCoe_Marker_RoundUp_Cora, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:8
  Alias_CoraCoe.GetActorRef().EvaluatePackage(False) ; #DEBUG_LINE_NO:9
  Game.GetPLayer().MoveTo(Commitment_SamCoe_Player_Start_Marker, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:11
  Self.SetStage(100) ; #DEBUG_LINE_NO:12
  Self.SetStage(150) ; #DEBUG_LINE_NO:13
EndFunction

Function Fragment_Stage_0100_Item_00()
  SQ_Companions.LockInCompanion(Alias_SamCoe.GetActorReference() as companionactorscript, True, None, COM_CQ_TxtReplace_QuestName_SamCoe) ; #DEBUG_LINE_NO:22
  Self.SetObjectiveDisplayed(100, True, False) ; #DEBUG_LINE_NO:24
EndFunction

Function Fragment_Stage_0150_Item_00()
  Self.SetObjectiveCompleted(100, True) ; #DEBUG_LINE_NO:32
  Self.SetObjectiveDisplayed(150, True, False) ; #DEBUG_LINE_NO:33
  Alias_JacobCoe.GetActorRef().MoveTo(CommitmentCeremonyMarker_Jacob, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:36
  Alias_JacobCoe.GetActorRef().EvaluatePackage(False) ; #DEBUG_LINE_NO:37
  Alias_EliasCartwright.GetActorRef().MoveTo(CommitmentCeremonyMarker_Elias, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:38
  Alias_EliasCartwright.GetActorRef().EvaluatePackage(False) ; #DEBUG_LINE_NO:39
  Alias_LillianHart.GetActorRef().Disable(False) ; #DEBUG_LINE_NO:40
  Alias_LillianHart.GetActorRef().MoveTo(Commitment_SamCoe_Marker_RoundUp_Lillian, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:41
  Alias_LillianHart.GetActorRef().EvaluatePackage(False) ; #DEBUG_LINE_NO:42
  Alias_CoraCoe.GetActorRef().MoveTo(Commitment_SamCoe_Marker_RoundUp_Cora, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:43
  Alias_CoraCoe.GetActorRef().EvaluatePackage(False) ; #DEBUG_LINE_NO:44
  CommitmentCeremonyEnableMarker.Enable(False) ; #DEBUG_LINE_NO:47
EndFunction

Function Fragment_Stage_0200_Item_00()
  Self.SetObjectiveCompleted(150, True) ; #DEBUG_LINE_NO:55
  Self.SetObjectiveDisplayed(300, True, False) ; #DEBUG_LINE_NO:56
  Self.SetObjectiveDisplayed(400, True, False) ; #DEBUG_LINE_NO:57
  Alias_LillianHart.GetActorRef().Enable(False) ; #DEBUG_LINE_NO:59
EndFunction

Function Fragment_Stage_0300_Item_00()
  Self.SetObjectiveCompleted(300, True) ; #DEBUG_LINE_NO:67
  Alias_CoraCoe.GetActorRef().EvaluatePackage(False) ; #DEBUG_LINE_NO:69
  If Self.GetStageDone(400) ; #DEBUG_LINE_NO:72
    Self.SetStage(500) ; #DEBUG_LINE_NO:73
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Function Fragment_Stage_0325_Item_00()
  Commitment_SamCoe_0325_CoraSinclair_BarkScene.Start() ; #DEBUG_LINE_NO:82
EndFunction

Function Fragment_Stage_0400_Item_00()
  Self.SetObjectiveCompleted(400, True) ; #DEBUG_LINE_NO:90
  Alias_LillianHart.GetActorRef().EvaluatePackage(False) ; #DEBUG_LINE_NO:92
  If Self.GetStageDone(300) ; #DEBUG_LINE_NO:95
    Self.SetStage(500) ; #DEBUG_LINE_NO:96
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Function Fragment_Stage_0500_Item_00()
  Self.SetObjectiveDisplayed(600, True, False) ; #DEBUG_LINE_NO:105
EndFunction

Function Fragment_Stage_0600_Item_00()
  Self.SetObjectiveCompleted(600, True) ; #DEBUG_LINE_NO:113
  Self.SetObjectiveDisplayed(700, True, False) ; #DEBUG_LINE_NO:114
  Actor SamCoeRef = Alias_SamCoe.GetActorRef() ; #DEBUG_LINE_NO:115
  SQ_Followers.SetRoleInactive(SamCoeRef, True, False, True) ; #DEBUG_LINE_NO:118
  SamCoeRef.EvaluatePackage(False) ; #DEBUG_LINE_NO:119
  Game.GetPLayer().MoveTo(CommitmentCeremonyMarker_Player, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:122
  SamCoeRef.MoveTo(CommitmentCeremonyMarker_Sam, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:123
  Alias_LillianHart.GetActorRef().MoveTo(Commitment_OverrideMarker, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:126
  Alias_CoraCoe.GetActorRef().MoveTo(Commitment_OverrideMarker, 0.0, 0.0, 0.0, True, False) ; #DEBUG_LINE_NO:127
  (SQ_Crew as sq_crewscript).SetRoleInactive(SamCoeRef, False, True, False) ; #DEBUG_LINE_NO:129
  DismissedCrew.RemoveRef(SamCoeRef as ObjectReference) ; #DEBUG_LINE_NO:131
  DisembarkingCrew.RemoveRef(SamCoeRef as ObjectReference) ; #DEBUG_LINE_NO:132
  SamCoeRef.SetValue(CrewReassignDisabled, 1.0) ; #DEBUG_LINE_NO:135
EndFunction

Function Fragment_Stage_0700_Item_00()
  Self.SetObjectiveCompleted(700, True) ; #DEBUG_LINE_NO:143
  Self.SetObjectiveDisplayed(800, True, False) ; #DEBUG_LINE_NO:144
EndFunction

Function Fragment_Stage_0800_Item_00()
  Quest __temp = Self as Quest ; #DEBUG_LINE_NO:152
  com_commitmentquestscript kmyQuest = __temp as com_commitmentquestscript ; #DEBUG_LINE_NO:153
  Self.CompleteAllObjectives() ; #DEBUG_LINE_NO:156
  kmyQuest.MakeCommitted() ; #DEBUG_LINE_NO:157
  Actor SamCoeRef = Alias_SamCoe.GetActorReference() ; #DEBUG_LINE_NO:160
  SQ_Followers.SetRoleActive(SamCoeRef, True, True, 0.0, 0.0) ; #DEBUG_LINE_NO:162
  SQ_Companions.LockInCompanion(SamCoeRef as companionactorscript, False, None, None) ; #DEBUG_LINE_NO:165
  (SQ_Crew as sq_crewscript).SetRoleAvailable(SamCoeRef, False) ; #DEBUG_LINE_NO:167
  SamCoeRef.SetValue(CrewReassignDisabled, 0.0) ; #DEBUG_LINE_NO:169
EndFunction

Function Fragment_Stage_9000_Item_00()
  Alias_LillianHart.GetActorRef().Disable(False) ; #DEBUG_LINE_NO:178
  CommitmentCeremonyEnableMarker.Disable(False) ; #DEBUG_LINE_NO:181
  Self.Stop() ; #DEBUG_LINE_NO:183
EndFunction
