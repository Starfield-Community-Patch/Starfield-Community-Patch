ScriptName Fragments:Quests:QF_MQ_TempleQuest_01_000854E8 Extends Quest Const hidden

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
ReferenceAlias Property Alias_AnomalyMapMarker Auto Const mandatory
Message Property MQ_TempleTutorialMSG Auto Const mandatory
Quest Property MQ104A Auto Const mandatory
LocationAlias Property Alias_PlanetExploredTrait Auto Const mandatory
ReferenceAlias Property Alias_TempleMapMarker Auto Const mandatory
GlobalVariable Property MQTempleQuest_HaveTempleObj Auto Const mandatory
GlobalVariable Property MQ_TurnOnTemples Auto Const mandatory
ReferenceAlias Property Alias_EyeScanner Auto Const mandatory
ReferenceAlias Property Alias_VladimirSall Auto Const mandatory
Message Property MQ401EyeScanMSG Auto Const mandatory
ReferenceAlias Property Alias_TempleStarborn Auto Const mandatory
ActorBase Property LvlStarborn_Boss_Aggro Auto Const mandatory
ReferenceAlias Property Alias_TemplePrayMarker Auto Const mandatory
LocationAlias Property Alias_TempleLocation Auto Const mandatory
ReferenceAlias Property Alias_PlayerShip Auto Const mandatory
LocationAlias Property Alias_PlanetUnexploredTrait Auto Const mandatory
LocationAlias Property Alias_PlanetUnexploredTraitClose Auto Const mandatory
Quest Property StarbornTempleQuest Auto Const mandatory
Quest Property MQ_TutorialQuest Auto Const mandatory

;-- Functions ---------------------------------------

Function Fragment_Stage_0000_Item_00()
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(0) ; #DEBUG_LINE_NO:8
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(1) ; #DEBUG_LINE_NO:9
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(2) ; #DEBUG_LINE_NO:10
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(3) ; #DEBUG_LINE_NO:11
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(4) ; #DEBUG_LINE_NO:12
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(5) ; #DEBUG_LINE_NO:13
  Self.SetStage(10) ; #DEBUG_LINE_NO:15
EndFunction

Function Fragment_Stage_0005_Item_00()
  Self.SetObjectiveDisplayed(3, True, False) ; #DEBUG_LINE_NO:23
  MQ_TurnOnTemples.SetValueInt(1) ; #DEBUG_LINE_NO:25
EndFunction

Function Fragment_Stage_0005_Item_01()
  Alias_EyeScanner.GetRef().Enable(False) ; #DEBUG_LINE_NO:34
  Self.SetObjectiveDisplayed(5, True, False) ; #DEBUG_LINE_NO:35
  MQ_TurnOnTemples.SetValueInt(1) ; #DEBUG_LINE_NO:37
EndFunction

Function Fragment_Stage_0007_Item_00()
  MQ401EyeScanMSG.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0) ; #DEBUG_LINE_NO:45
  Utility.Wait(0.100000001) ; #DEBUG_LINE_NO:46
  Self.SetObjectiveCompleted(5, True) ; #DEBUG_LINE_NO:47
  Self.SetObjectiveDisplayed(10, True, False) ; #DEBUG_LINE_NO:48
  MQ_TurnOnTemples.SetValueInt(1) ; #DEBUG_LINE_NO:49
  Alias_EyeScanner.GetRef().Disable(False) ; #DEBUG_LINE_NO:50
  If Alias_PlanetUnexploredTraitClose.GetLocation() == None && Alias_PlanetExploredTrait.GetLocation() == None ; #DEBUG_LINE_NO:53
    If Alias_PlayerShip.GetShipReference().GetGravJumpRange() < 28.0 ; #DEBUG_LINE_NO:55
      Self.SetStage(12) ; #DEBUG_LINE_NO:56
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Function Fragment_Stage_0010_Item_00()
  Self.SetObjectiveCompleted(3, True) ; #DEBUG_LINE_NO:66
  Self.SetObjectiveDisplayed(10, True, False) ; #DEBUG_LINE_NO:67
  MQ_TurnOnTemples.SetValueInt(1) ; #DEBUG_LINE_NO:69
  If Alias_PlanetUnexploredTraitClose.GetLocation() == None && Alias_PlanetExploredTrait.GetLocation() == None ; #DEBUG_LINE_NO:72
    If Alias_PlayerShip.GetShipReference().GetGravJumpRange() < 28.0 ; #DEBUG_LINE_NO:74
      Self.SetStage(12) ; #DEBUG_LINE_NO:75
    EndIf ; #DEBUG_LINE_NO:
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Function Fragment_Stage_0012_Item_00()
  Quest __temp = Self as Quest ; #DEBUG_LINE_NO:85
  mqcheckgravjumpquestscript kmyQuest = __temp as mqcheckgravjumpquestscript ; #DEBUG_LINE_NO:86
  Self.SetObjectiveDisplayed(7, True, False) ; #DEBUG_LINE_NO:89
  kmyQuest.CheckSkillsMenu() ; #DEBUG_LINE_NO:91
  MQ_TutorialQuest.SetStage(200) ; #DEBUG_LINE_NO:93
EndFunction

Function Fragment_Stage_0013_Item_00()
  Self.SetObjectiveCompleted(7, True) ; #DEBUG_LINE_NO:101
EndFunction

Function Fragment_Stage_0020_Item_00()
  Self.SetObjectiveDisplayed(10, True, False) ; #DEBUG_LINE_NO:109
EndFunction

Function Fragment_Stage_0030_Item_00()
  If Alias_PlanetExploredTrait.GetLocation() == None ; #DEBUG_LINE_NO:117
    Self.SetObjectiveDisplayed(15, True, False) ; #DEBUG_LINE_NO:118
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Function Fragment_Stage_0050_Item_00()
  Quest __temp = Self as Quest ; #DEBUG_LINE_NO:127
  mq_temple_subscript kmyQuest = __temp as mq_temple_subscript ; #DEBUG_LINE_NO:128
  Self.SetObjectiveCompleted(15, True) ; #DEBUG_LINE_NO:131
  kmyQuest.TempleDiscovered() ; #DEBUG_LINE_NO:132
EndFunction

Function Fragment_Stage_0060_Item_00()
  Quest __temp = Self as Quest ; #DEBUG_LINE_NO:140
  mq_temple_subscript kmyQuest = __temp as mq_temple_subscript ; #DEBUG_LINE_NO:141
  kmyQuest.PowerReceived() ; #DEBUG_LINE_NO:144
  kmyQuest.SpawnStarborn() ; #DEBUG_LINE_NO:145
  Self.CompleteAllObjectives() ; #DEBUG_LINE_NO:147
  Self.Stop() ; #DEBUG_LINE_NO:148
  Self.Start() ; #DEBUG_LINE_NO:149
EndFunction

Function Fragment_Stage_0060_Item_01()
  Quest __temp = Self as Quest ; #DEBUG_LINE_NO:157
  mq_temple_subscript kmyQuest = __temp as mq_temple_subscript ; #DEBUG_LINE_NO:158
  kmyQuest.PowerReceived() ; #DEBUG_LINE_NO:161
  Self.CompleteAllObjectives() ; #DEBUG_LINE_NO:163
  Self.Stop() ; #DEBUG_LINE_NO:164
  Self.Start() ; #DEBUG_LINE_NO:165
EndFunction
