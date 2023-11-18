ScriptName Fragments:Quests:QF_City_NA_Botany01_00270718 Extends Quest Const hidden

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
ReferenceAlias Property Alias_Sensor_Suburbs Auto Const mandatory
ReferenceAlias Property Alias_Sensor_Bridge Auto Const mandatory
ReferenceAlias Property Alias_Sensor_Commercial Auto Const mandatory
ReferenceAlias Property Alias_Sensor_Residential Auto Const mandatory
Quest Property City_NA_Botany02 Auto Const mandatory
ReferenceAlias Property Alias_StartMarker Auto Const mandatory
Scene Property City_NA_Botany01_006_KeltonScene Auto Const mandatory
GlobalVariable Property City_NA_Botany01_WenPayment Auto Const mandatory
MiscObject Property Credits Auto Const mandatory
ReferenceAlias Property Alias_Kid Auto Const mandatory
Quest Property PointerQuest Auto Const
GlobalVariable Property Botany2Timer Auto Const
GlobalVariable Property DaysPassed Auto Const
Quest Property Botany02Pointer Auto Const
ReferenceAlias Property Alias_KeltonFrush Auto Const mandatory
Quest Property City_NA_GuardPointer_Botany Auto Const mandatory

;-- Functions ---------------------------------------

Function Fragment_Stage_0000_Item_00()
  Game.GetPlayer().MoveTo(Alias_StartMarker.GetReference(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0010_Item_00()
  Self.SetObjectiveDisplayed(10, True, False)
  PointerQuest.SetStage(1000)
  Self.SetActive(True)
EndFunction

Function Fragment_Stage_0020_Item_00()
  If Self.IsObjectiveDisplayed(10)
    Self.SetObjectiveCompleted(10, True)
  EndIf
  Self.SetObjectiveDisplayed(20, True, False)
  Alias_Sensor_Bridge.GetReference().Enable(False)
  Alias_Sensor_Commercial.GetReference().Enable(False)
  Alias_Sensor_Residential.GetReference().Enable(False)
  Alias_Sensor_Suburbs.GetReference().Enable(False)
  PointerQuest.SetStage(1000)
  City_NA_GuardPointer_Botany.SetStage(200)
  Self.SetActive(True)
EndFunction

Function Fragment_Stage_0030_Item_00()
  If Self.GetStageDone(40) == True && Self.GetStageDone(50) == True && Self.GetStageDone(70) == True
    Self.SetStage(100)
  EndIf
EndFunction

Function Fragment_Stage_0040_Item_00()
  If Self.GetStageDone(30) == True && Self.GetStageDone(50) == True && Self.GetStageDone(70) == True
    Self.SetStage(100)
  EndIf
EndFunction

Function Fragment_Stage_0050_Item_00()
  If Self.GetStageDone(40) == True && Self.GetStageDone(30) == True && Self.GetStageDone(70) == True
    Self.SetStage(100)
  EndIf
EndFunction

Function Fragment_Stage_0056_Item_00()
  If Self.GetStageDone(58) == False
    Self.SetObjectiveDisplayed(58, True, False)
  EndIf
  Alias_Kid.GetActorReference().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0058_Item_00()
  If Self.GetStageDone(56) == False
    Self.SetStage(56)
  EndIf
  If Self.IsObjectiveDisplayed(58)
    Self.SetObjectiveCompleted(58, True)
  EndIf
  Self.SetObjectiveDisplayed(60, True, False)
  Alias_Kid.GetActorReference().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0061_Item_00()
  Self.SetStage(60)
EndFunction

Function Fragment_Stage_0062_Item_00()
  Self.SetStage(60)
EndFunction

Function Fragment_Stage_0063_Item_00()
  Self.SetStage(60)
EndFunction

Function Fragment_Stage_0065_Item_00()
  Game.GetPlayer().Additem(Alias_Sensor_Commercial.GetReference() as Form, 1, False)
  Game.GetPlayer().RemoveItem(Credits as Form, City_NA_Botany01_WenPayment.GetValue() as Int, False, None)
  Self.SetStage(70)
  If Self.IsObjectiveDisplayed(69)
    Self.SetObjectiveDisplayed(69, False, False)
  EndIf
EndFunction

Function Fragment_Stage_0066_Item_00()
  Game.GetPlayer().Additem(Alias_Sensor_Commercial.GetReference() as Form, 1, False)
  Self.SetStage(70)
  If Self.IsObjectiveDisplayed(69)
    Self.SetObjectiveDisplayed(69, False, False)
  EndIf
EndFunction

Function Fragment_Stage_0068_Item_00()
  Self.SetObjectiveDisplayed(69, True, False)
EndFunction

Function Fragment_Stage_0069_Item_00()
  Self.SetObjectiveCompleted(69, True)
  Self.SetObjectiveDisplayed(60, False, False)
  Self.SetStage(70)
EndFunction

Function Fragment_Stage_0070_Item_00()
  If Self.GetStageDone(40) == True && Self.GetStageDone(50) == True && Self.GetStageDone(30) == True
    Self.SetStage(100)
  EndIf
  If Self.IsObjectiveDisplayed(60)
    Self.SetObjectiveCompleted(60, True)
  EndIf
EndFunction

Function Fragment_Stage_0100_Item_00()
  Self.SetObjectiveCompleted(20, True)
  Self.SetObjectiveDisplayed(100, True, False)
EndFunction

Function Fragment_Stage_0110_Item_00()
  Self.SetObjectiveCompleted(100, True)
  Self.SetObjectiveDisplayed(110, True, False)
  Game.GetPlayer().RemoveItem(Alias_Sensor_Suburbs.GetReference() as Form, 1, False, None)
  Game.GetPlayer().RemoveItem(Alias_Sensor_Bridge.GetReference() as Form, 1, False, None)
  Game.GetPlayer().RemoveItem(Alias_Sensor_Residential.GetReference() as Form, 1, False, None)
  Game.GetPlayer().RemoveItem(Alias_Sensor_Commercial.GetReference() as Form, 1, False, None)
  City_NA_Botany01_006_KeltonScene.Start()
EndFunction

Function Fragment_Stage_0120_Item_00()
  Self.SetObjectiveCompleted(110, True)
  Self.SetObjectiveDisplayed(120, True, False)
EndFunction

Function Fragment_Stage_0200_Item_00()
  Self.CompleteAllObjectives()
  City_NA_Botany02.Start()
  Self.Stop()
  Botany2Timer.SetValue(DaysPassed.GetValue() + 1.0)
  Botany02Pointer.SetStage(10)
EndFunction
