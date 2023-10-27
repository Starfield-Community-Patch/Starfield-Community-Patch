ScriptName Fragments:Quests:QF_MQ401_001DC45E Extends Quest Const hidden

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
Scene Property MQ401_002_AfterFaceGen Auto Const mandatory
Scene Property MQ401_001_LodgeIntro Auto Const mandatory
Quest Property MQ101 Auto Const mandatory
Quest Property MQ402 Auto Const mandatory
GlobalVariable Property MQ401_VariantCurrent Auto Const mandatory
ActorValue Property PlayerUnityTimesEntered Auto Const mandatory
Faction Property ConstellationFaction Auto Const mandatory
Key Property LodgeKey Auto Const mandatory
GlobalVariable Property MQ401_SkipMQ Auto Const mandatory
ReferenceAlias Property Alias_LodgeArmillary Auto Const mandatory
Faction Property EyeBoardingFaction Auto Const mandatory
ReferenceAlias Property Alias_SarahMorgan Auto Const mandatory
ActorValue Property COM_NoRelationshipPostUnity Auto Const mandatory
ReferenceAlias Property Alias_Andreja Auto Const mandatory
ReferenceAlias Property Alias_Barrett Auto Const mandatory
ReferenceAlias Property Alias_SamCoe Auto Const mandatory
Quest Property CREW_EliteCrew_Vasco Auto Const mandatory
Quest Property SQ_Companions Auto Const mandatory

;-- Functions ---------------------------------------

Function Fragment_Stage_0000_Item_00()
  MQ402.Start() ; #DEBUG_LINE_NO:8
EndFunction

Function Fragment_Stage_0020_Item_00()
  ObjectReference ArmillaryREF = Alias_LodgeArmillary.GetRef() ; #DEBUG_LINE_NO:16
  (ArmillaryREF as armillaryscript).MQ101ArmillaryComesTogether() ; #DEBUG_LINE_NO:17
EndFunction

Function Fragment_Stage_0100_Item_00()
  If MQ401_VariantCurrent.GetValueInt() == 0 ; #DEBUG_LINE_NO:26
    MQ401_001_LodgeIntro.Start() ; #DEBUG_LINE_NO:27
  EndIf ; #DEBUG_LINE_NO:
  MQ101.SetObjectiveCompleted(180, True) ; #DEBUG_LINE_NO:30
  MQ101.SetObjectiveDisplayed(185, True, False) ; #DEBUG_LINE_NO:31
EndFunction

Function Fragment_Stage_0110_Item_00()
  Quest __temp = Self as Quest ; #DEBUG_LINE_NO:39
  mq401questscript kmyQuest = __temp as mq401questscript ; #DEBUG_LINE_NO:40
EndFunction

Function Fragment_Stage_0120_Item_00()
  MQ401_002_AfterFaceGen.Start() ; #DEBUG_LINE_NO:51
EndFunction

Function Fragment_Stage_0200_Item_00()
  MQ101.SetStage(1800) ; #DEBUG_LINE_NO:59
EndFunction

Function Fragment_Stage_0300_Item_00()
  Actor PlayerREF = Game.GetPlayer() ; #DEBUG_LINE_NO:67
  MQ101.CompleteAllObjectives() ; #DEBUG_LINE_NO:68
  PlayerREF.AddtoFaction(ConstellationFaction) ; #DEBUG_LINE_NO:70
  PlayerREF.additem(LodgeKey as Form, 1, False) ; #DEBUG_LINE_NO:71
  PlayerREF.AddtoFaction(EyeBoardingFaction) ; #DEBUG_LINE_NO:73
  MQ401_SkipMQ.SetValueInt(1) ; #DEBUG_LINE_NO:75
  MQ101.SetStage(2100) ; #DEBUG_LINE_NO:77
  MQ402.SetStage(10) ; #DEBUG_LINE_NO:79
  CREW_EliteCrew_Vasco.SetStage(1) ; #DEBUG_LINE_NO:81
EndFunction

Function Fragment_Stage_0410_Item_00()
  Actor SarahMorganREF = Alias_SarahMorgan.GetActorRef() ; #DEBUG_LINE_NO:89
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(SarahMorganREF, True) ; #DEBUG_LINE_NO:90
  (SarahMorganREF as companionactorscript).AllowStoryGatesAndRestartTimer() ; #DEBUG_LINE_NO:91
EndFunction

Function Fragment_Stage_0415_Item_00()
  Actor SarahMorganREF = Alias_SarahMorgan.GetActorRef() ; #DEBUG_LINE_NO:99
  SarahMorganREF.SetValue(COM_NoRelationshipPostUnity, 1.0) ; #DEBUG_LINE_NO:101
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(SarahMorganREF, True) ; #DEBUG_LINE_NO:102
EndFunction

Function Fragment_Stage_0420_Item_00()
  Actor AndrejaREF = Alias_Andreja.GetActorRef() ; #DEBUG_LINE_NO:110
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(AndrejaREF, True) ; #DEBUG_LINE_NO:112
  (AndrejaREF as companionactorscript).AllowStoryGatesAndRestartTimer() ; #DEBUG_LINE_NO:113
EndFunction

Function Fragment_Stage_0425_Item_00()
  Actor AndrejaREF = Alias_Andreja.GetActorRef() ; #DEBUG_LINE_NO:121
  AndrejaREF.SetValue(COM_NoRelationshipPostUnity, 1.0) ; #DEBUG_LINE_NO:123
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(AndrejaREF, True) ; #DEBUG_LINE_NO:124
EndFunction

Function Fragment_Stage_0440_Item_00()
  Actor BarrettREF = Alias_Barrett.GetActorRef() ; #DEBUG_LINE_NO:132
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(BarrettREF, True) ; #DEBUG_LINE_NO:134
  (BarrettREF as companionactorscript).AllowStoryGatesAndRestartTimer() ; #DEBUG_LINE_NO:135
EndFunction

Function Fragment_Stage_0445_Item_00()
  Actor BarrettREF = Alias_Barrett.GetActorRef() ; #DEBUG_LINE_NO:143
  BarrettREF.SetValue(COM_NoRelationshipPostUnity, 1.0) ; #DEBUG_LINE_NO:145
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(BarrettREF, True) ; #DEBUG_LINE_NO:146
EndFunction

Function Fragment_Stage_0450_Item_00()
  Actor SamCoeREF = Alias_SamCoe.GetActorRef() ; #DEBUG_LINE_NO:154
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(SamCoeREF, True) ; #DEBUG_LINE_NO:156
  (SamCoeREF as companionactorscript).AllowStoryGatesAndRestartTimer() ; #DEBUG_LINE_NO:157
EndFunction

Function Fragment_Stage_0455_Item_00()
  Actor SamCoeREF = Alias_SamCoe.GetActorRef() ; #DEBUG_LINE_NO:165
  SamCoeREF.SetValue(COM_NoRelationshipPostUnity, 1.0) ; #DEBUG_LINE_NO:167
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(SamCoeREF, True) ; #DEBUG_LINE_NO:168
EndFunction
