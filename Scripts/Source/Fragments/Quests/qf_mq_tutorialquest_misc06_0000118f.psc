ScriptName Fragments:Quests:QF_MQ_TutorialQuest_Misc06_0000118F Extends Quest Const hidden

;-- Functions ---------------------------------------

Function Fragment_Stage_0010_Item_00()
  Self.SetObjectiveDisplayed(10, True, False)
EndFunction

Function Fragment_Stage_0100_Item_00()
  Self.CompleteAllObjectives()
  Self.Stop()
EndFunction
