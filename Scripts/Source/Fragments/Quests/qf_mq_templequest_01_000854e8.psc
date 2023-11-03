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
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(0)
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(1)
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(2)
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(3)
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(4)
  (StarbornTempleQuest as starborntemplequestscript).SetPlayerAcquiredArtifact(5)
  Self.SetStage(10)
EndFunction

Function Fragment_Stage_0005_Item_00()
  Self.SetObjectiveDisplayed(3, True, False)
  MQ_TurnOnTemples.SetValueInt(1)
EndFunction

Function Fragment_Stage_0005_Item_01()
  Alias_EyeScanner.GetRef().Enable(False)
  Self.SetObjectiveDisplayed(5, True, False)
  MQ_TurnOnTemples.SetValueInt(1)
EndFunction

Function Fragment_Stage_0007_Item_00()
  MQ401EyeScanMSG.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  Utility.Wait(0.100000001)
  Self.SetObjectiveCompleted(5, True)
  Self.SetObjectiveDisplayed(10, True, False)
  MQ_TurnOnTemples.SetValueInt(1)
  Alias_EyeScanner.GetRef().Disable(False)
  If Alias_PlanetUnexploredTraitClose.GetLocation() == None && Alias_PlanetExploredTrait.GetLocation() == None
    If Alias_PlayerShip.GetShipReference().GetGravJumpRange() < 28.0
      Self.SetStage(12)
    EndIf
  EndIf
EndFunction

Function Fragment_Stage_0010_Item_00()
  Self.SetObjectiveCompleted(3, True)
  Self.SetObjectiveDisplayed(10, True, False)
  MQ_TurnOnTemples.SetValueInt(1)
  If Alias_PlanetUnexploredTraitClose.GetLocation() == None && Alias_PlanetExploredTrait.GetLocation() == None
    If Alias_PlayerShip.GetShipReference().GetGravJumpRange() < 28.0
      Self.SetStage(12)
    EndIf
  EndIf
EndFunction

Function Fragment_Stage_0012_Item_00()
  Quest __temp = Self as Quest
  mqcheckgravjumpquestscript kmyQuest = __temp as mqcheckgravjumpquestscript
  Self.SetObjectiveDisplayed(7, True, False)
  kmyQuest.CheckSkillsMenu()
  MQ_TutorialQuest.SetStage(200)
EndFunction

Function Fragment_Stage_0013_Item_00()
  Self.SetObjectiveCompleted(7, True)
EndFunction

Function Fragment_Stage_0020_Item_00()
  Self.SetObjectiveDisplayed(10, True, False)
EndFunction

Function Fragment_Stage_0030_Item_00()
  If Alias_PlanetExploredTrait.GetLocation() == None
    Self.SetObjectiveDisplayed(15, True, False)
  EndIf
EndFunction

Function Fragment_Stage_0050_Item_00()
  Quest __temp = Self as Quest
  mq_temple_subscript kmyQuest = __temp as mq_temple_subscript
  Self.SetObjectiveCompleted(15, True)
  kmyQuest.TempleDiscovered()
EndFunction

Function Fragment_Stage_0060_Item_00()
  Quest __temp = Self as Quest
  mq_temple_subscript kmyQuest = __temp as mq_temple_subscript
  kmyQuest.PowerReceived()
  kmyQuest.SpawnStarborn()
  Self.CompleteAllObjectives()
  Self.Stop()
  Self.Start()
EndFunction

Function Fragment_Stage_0060_Item_01()
  Quest __temp = Self as Quest
  mq_temple_subscript kmyQuest = __temp as mq_temple_subscript
  kmyQuest.PowerReceived()
  Self.CompleteAllObjectives()
  Self.Stop()
  Self.Start()
EndFunction
