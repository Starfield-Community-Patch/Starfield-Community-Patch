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
ObjectReference Property CoeEstateFirstFloorDoorREF Auto Const mandatory ; #Added by SFCP #370
ObjectReference Property CoeEstateBalconyDoorREF Auto Const mandatory ; #Added by SFCP #370
ObjectReference Property CoeEstateFrontDoorREF Auto Const mandatory ; #Added by SFCP #370
ObjectReference Property CoeEstateFirstFloorDoorTwo Auto Const ; #Added by SFFixes
Faction Property CoeEstateDoorFaction Auto Const mandatory ; #Added by SFCP #370
Quest Property CREW_EliteCrew_CoraCoe Auto Const mandatory ; #Added by SFCP #369

;-- Functions ---------------------------------------

Function Fragment_Stage_0000_Item_00()
  MQ402.Start() 
EndFunction

Function Fragment_Stage_0020_Item_00()
  ObjectReference ArmillaryREF = Alias_LodgeArmillary.GetRef() 
  (ArmillaryREF as armillaryscript).MQ101ArmillaryComesTogether() 
EndFunction

Function Fragment_Stage_0100_Item_00()
  If MQ401_VariantCurrent.GetValueInt() == 0 
    MQ401_001_LodgeIntro.Start() 
  EndIf
  MQ101.SetObjectiveCompleted(180, True) 
  MQ101.SetObjectiveDisplayed(185, True, False) 
EndFunction

Function Fragment_Stage_0110_Item_00()
  Quest __temp = Self as Quest 
  mq401questscript kmyQuest = __temp as mq401questscript 
EndFunction

Function Fragment_Stage_0120_Item_00()
  MQ401_002_AfterFaceGen.Start() 
EndFunction

Function Fragment_Stage_0200_Item_00()
  MQ101.SetStage(1800) 
EndFunction

Function Fragment_Stage_0300_Item_00()
  Actor PlayerREF = Game.GetPlayer() 
  MQ101.CompleteAllObjectives() 
  PlayerREF.AddtoFaction(ConstellationFaction) 
  PlayerREF.additem(LodgeKey as Form, 1, False) 
  PlayerREF.AddtoFaction(EyeBoardingFaction) 
  MQ401_SkipMQ.SetValueInt(1) 
  MQ101.SetStage(2100) 
  MQ402.SetStage(10) 
  CREW_EliteCrew_Vasco.SetStage(1) 
  CoeEstateFirstFloorDoorREF.Lock(False, False, True) ; #Added by SFCP #370 - Fixes Coe Estate door being locked
  CoeEstateBalconyDoorREF.Lock(False, False, True) ; #Added by SFCP #370 - Fixes Coe Estate door being locked
  CoeEstateFrontDoorREF.Lock(False, False, True) ; #Added by SFCP #370 - Fixes Coe Estate door being locked
  CoeEstateFirstFloorDoorTwo.Lock(False, False, True) ; #Added by SFCP #370 - Fixes Coe Estate door being locked
  Game.GetPlayer().AddToFaction(CoeEstateDoorFaction) ; #Added by SFCP #370 - Fixes Coe Estate door being locked
  CREW_EliteCrew_CoraCoe.Start() ; #Added by SFCP #369 - Fixes Cora not being on ship with Sam as companion
EndFunction

Function Fragment_Stage_0410_Item_00()
  Actor SarahMorganREF = Alias_SarahMorgan.GetActorRef() 
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(SarahMorganREF, True) 
  (SarahMorganREF as companionactorscript).AllowStoryGatesAndRestartTimer() 
EndFunction

Function Fragment_Stage_0415_Item_00()
  Actor SarahMorganREF = Alias_SarahMorgan.GetActorRef() 
  SarahMorganREF.SetValue(COM_NoRelationshipPostUnity, 1.0) 
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(SarahMorganREF, True) 
EndFunction

Function Fragment_Stage_0420_Item_00()
  Actor AndrejaREF = Alias_Andreja.GetActorRef() 
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(AndrejaREF, True) 
  (AndrejaREF as companionactorscript).AllowStoryGatesAndRestartTimer() 
EndFunction

Function Fragment_Stage_0425_Item_00()
  Actor AndrejaREF = Alias_Andreja.GetActorRef() 
  AndrejaREF.SetValue(COM_NoRelationshipPostUnity, 1.0) 
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(AndrejaREF, True) 
EndFunction

Function Fragment_Stage_0440_Item_00()
  Actor BarrettREF = Alias_Barrett.GetActorRef() 
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(BarrettREF, True) 
  (BarrettREF as companionactorscript).AllowStoryGatesAndRestartTimer() 
EndFunction

Function Fragment_Stage_0445_Item_00()
  Actor BarrettREF = Alias_Barrett.GetActorRef() 
  BarrettREF.SetValue(COM_NoRelationshipPostUnity, 1.0) 
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(BarrettREF, True) 
EndFunction

Function Fragment_Stage_0450_Item_00()
  Actor SamCoeREF = Alias_SamCoe.GetActorRef() 
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(SamCoeREF, True) 
  (SamCoeREF as companionactorscript).AllowStoryGatesAndRestartTimer() 
EndFunction

Function Fragment_Stage_0455_Item_00()
  Actor SamCoeREF = Alias_SamCoe.GetActorRef() 
  SamCoeREF.SetValue(COM_NoRelationshipPostUnity, 1.0) 
  (SQ_Companions as sq_companionsscript).SetRoleAvailable(SamCoeREF, True) 
EndFunction
