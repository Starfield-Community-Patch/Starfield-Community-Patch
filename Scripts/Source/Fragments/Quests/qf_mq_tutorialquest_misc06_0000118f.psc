ScriptName Fragments:Quests:QF_MQ_TutorialQuest_Misc06_0000118F Extends Quest Const hidden

;-- Functions ---------------------------------------

Function Fragment_Stage_0010_Item_00()
  Self.SetObjectiveDisplayed(10, True, False)
EndFunction

Function Fragment_Stage_0010_Item_01()
  ; SFCP Fix - If all research projects are done, we just shut down the quest
  ; https://www.starfieldpatch.dev/issues/725
  Debug.Trace("SFCP Fix - All research projects are complete, removing tutorial objective and shutting down quest: "+Self, 0)
  Self.CompleteAllObjectives()
  Self.Stop()
EndFunction

Function Fragment_Stage_0100_Item_00()
  Self.CompleteAllObjectives()
  Self.Stop()
EndFunction
