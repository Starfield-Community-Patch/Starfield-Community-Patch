ScriptName Fragments:Scenes:SF_COM_SamCoe_Story_SG02_0026C506 Extends Scene Const hidden

ActorValue Property SamCoe_LillianForeknowledgeAV Auto Const mandatory ; #Added by SFCP #373

;-- Functions ---------------------------------------

Function Fragment_Phase_12_End()
  Game.GetPLayer().SetValue(SamCoe_LillianForeknowledgeAV, 1.0) ; #Added by SFCP #373
  com_companionquestscript kmyQuest = Self.GetOwningQuest() as com_companionquestscript 
  kmyQuest.StoryGateSceneCompleted(True) 
EndFunction
