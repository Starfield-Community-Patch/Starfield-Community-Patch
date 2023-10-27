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
ActorValue Property SamCoe_CommitmentForeknowledgeAV Auto Const mandatory ; #Added by SFCP #372

;-- Functions ---------------------------------------

Function Fragment_Stage_0000_Item_00()
  Alias_CoraCoe.GetActorRef().MoveTo(Commitment_SamCoe_Marker_RoundUp_Cora, 0.0, 0.0, 0.0, True, False)
  Alias_CoraCoe.GetActorRef().EvaluatePackage(False)
  Game.GetPLayer().MoveTo(Commitment_SamCoe_Player_Start_Marker, 0.0, 0.0, 0.0, True, False)
  Self.SetStage(100)
  Self.SetStage(150)
EndFunction

Function Fragment_Stage_0100_Item_00()
  SQ_Companions.LockInCompanion(Alias_SamCoe.GetActorReference() as companionactorscript, True, None, COM_CQ_TxtReplace_QuestName_SamCoe) 
  Self.SetObjectiveDisplayed(100, True, False)
EndFunction

Function Fragment_Stage_0150_Item_00()
  Self.SetObjectiveCompleted(100, True) 
  Self.SetObjectiveDisplayed(150, True, False) 
  Alias_JacobCoe.GetActorRef().MoveTo(CommitmentCeremonyMarker_Jacob, 0.0, 0.0, 0.0, True, False) 
  Alias_JacobCoe.GetActorRef().EvaluatePackage(False) 
  Alias_EliasCartwright.GetActorRef().MoveTo(CommitmentCeremonyMarker_Elias, 0.0, 0.0, 0.0, True, False) 
  Alias_EliasCartwright.GetActorRef().EvaluatePackage(False) 
  Alias_LillianHart.GetActorRef().Disable(False) 
  Alias_LillianHart.GetActorRef().MoveTo(Commitment_SamCoe_Marker_RoundUp_Lillian, 0.0, 0.0, 0.0, True, False) 
  Alias_LillianHart.GetActorRef().EvaluatePackage(False) 
  Alias_CoraCoe.GetActorRef().MoveTo(Commitment_SamCoe_Marker_RoundUp_Cora, 0.0, 0.0, 0.0, True, False) 
  Alias_CoraCoe.GetActorRef().EvaluatePackage(False) 
  CommitmentCeremonyEnableMarker.Enable(False) 
EndFunction

Function Fragment_Stage_0200_Item_00()
  Self.SetObjectiveCompleted(150, True) 
  Self.SetObjectiveDisplayed(300, True, False) 
  Self.SetObjectiveDisplayed(400, True, False) 
  Alias_LillianHart.GetActorRef().Enable(False) 
EndFunction

Function Fragment_Stage_0300_Item_00()
  Self.SetObjectiveCompleted(300, True) 
  Alias_CoraCoe.GetActorRef().EvaluatePackage(False) 
  If Self.GetStageDone(400) 
    Self.SetStage(500) 
  EndIf
EndFunction

Function Fragment_Stage_0325_Item_00()
  Commitment_SamCoe_0325_CoraSinclair_BarkScene.Start() 
EndFunction

Function Fragment_Stage_0400_Item_00()
  Self.SetObjectiveCompleted(400, True) 
  Alias_LillianHart.GetActorRef().EvaluatePackage(False) 
  If Self.GetStageDone(300) 
    Self.SetStage(500) 
  EndIf
EndFunction

Function Fragment_Stage_0500_Item_00()
  Self.SetObjectiveDisplayed(600, True, False) 
EndFunction

Function Fragment_Stage_0600_Item_00()
  Self.SetObjectiveCompleted(600, True) 
  Self.SetObjectiveDisplayed(700, True, False) 
  Actor SamCoeRef = Alias_SamCoe.GetActorRef() 
  SQ_Followers.SetRoleInactive(SamCoeRef, True, False, True) 
  SamCoeRef.EvaluatePackage(False) 
  Game.GetPLayer().MoveTo(CommitmentCeremonyMarker_Player, 0.0, 0.0, 0.0, True, False) 
  SamCoeRef.MoveTo(CommitmentCeremonyMarker_Sam, 0.0, 0.0, 0.0, True, False) 
  Alias_LillianHart.GetActorRef().MoveTo(Commitment_OverrideMarker, 0.0, 0.0, 0.0, True, False) 
  Alias_CoraCoe.GetActorRef().MoveTo(Commitment_OverrideMarker, 0.0, 0.0, 0.0, True, False) 
  (SQ_Crew as sq_crewscript).SetRoleInactive(SamCoeRef, False, True, False) 
  DismissedCrew.RemoveRef(SamCoeRef as ObjectReference) 
  DisembarkingCrew.RemoveRef(SamCoeRef as ObjectReference) 
  SamCoeRef.SetValue(CrewReassignDisabled, 1.0) 
EndFunction

Function Fragment_Stage_0700_Item_00()
  Self.SetObjectiveCompleted(700, True) 
  Self.SetObjectiveDisplayed(800, True, False) 
EndFunction

Function Fragment_Stage_0800_Item_00()
  Quest __temp = Self as Quest 
  com_commitmentquestscript kmyQuest = __temp as com_commitmentquestscript 
  Game.GetPlayer().SetValue(SamCoe_CommitmentForeknowledgeAV, 1.0) ; #Added by SFCP #372
  Self.CompleteAllObjectives() 
  kmyQuest.MakeCommitted() 
  Actor SamCoeRef = Alias_SamCoe.GetActorReference() 
  SQ_Followers.SetRoleActive(SamCoeRef, True, True, 0.0, 0.0) 
  SQ_Companions.LockInCompanion(SamCoeRef as companionactorscript, False, None, None) 
  (SQ_Crew as sq_crewscript).SetRoleAvailable(SamCoeRef, False) 
  SamCoeRef.SetValue(CrewReassignDisabled, 0.0)   
EndFunction

Function Fragment_Stage_9000_Item_00()
  Alias_LillianHart.GetActorRef().Disable(False) 
  CommitmentCeremonyEnableMarker.Disable(False) 
  Self.Stop() 
EndFunction
