ScriptName Fragments:Quests:QF_DialogueNeonConvo_Securit_0032C7C0 Extends Quest Const hidden

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
ReferenceAlias Property Alias_ScanSceneTrigger Auto Const mandatory
ReferenceAlias Property Alias_ScanSceneTriggerEnabler Auto Const mandatory
ReferenceAlias Property Alias_ScanSceneTriggerDisabler Auto Const mandatory
Scene Property DialogueNeonConvo_SecurityCheckpointScene Auto Const mandatory
Quest Property DialogueNeonConvo_SecurityCheckpoint_Controller Auto Const mandatory
ReferenceAlias Property Alias_CheckpointController Auto Const mandatory

;-- Functions ---------------------------------------

Function Fragment_Stage_0005_Item_00()
  SetBounty() ; Added by Starfield Community Patch v0.0.1 - Fixes Neon guards using the wrong dialogue.
  Alias_ScanSceneTrigger.GetRef().Enable(False) 
EndFunction

Function Fragment_Stage_0010_Item_00()
  DialogueNeonConvo_SecurityCheckpointScene.Start()
EndFunction

Function Fragment_Stage_0020_Item_00()
  Alias_ScanSceneTrigger.GetRef().Disable(False)
  Alias_ScanSceneTriggerEnabler.GetRef().Disable(False)
  Alias_CheckpointController.GetRef().Disable(False)
  DialogueNeonConvo_SecurityCheckpoint_Controller.SetStage(20)
  Self.Stop()
  Self.Reset()
EndFunction

; Starfield Community Patch fix - https://www.starfieldpatch.dev/issues/319
Function SetBounty()
  Faction CrimeFactionUC = Game.GetForm(0x5BD93) As Faction
  Faction CrimeFactionFreestar = Game.GetForm(0x638E5) As Faction
  Faction CrimeFactionNeon = Game.GetForm(0x26FDEA) As Faction
  Faction CrimeFactionCrimsonFleet = Game.GetForm(0x10B30) As Faction
  Faction CrimeFactionCrucible = Game.GetForm(0x299F72) As Faction
  Faction CrimeFactionECSConstant = Game.GetForm(0x28B3AE) As Faction
  Faction CrimeFactionParadiso = Game.GetForm(0x26310C) As Faction

  int TotalBounty = 0
  TotalBounty += CrimeFactionUC.GetCrimeGold()
  TotalBounty += CrimeFactionFreestar.GetCrimeGold()
  TotalBounty += CrimeFactionNeon.GetCrimeGold()
  TotalBounty += CrimeFactionCrimsonFleet.GetCrimeGold()
  TotalBounty += CrimeFactionCrucible.GetCrimeGold()
  TotalBounty += CrimeFactionECSConstant.GetCrimeGold()
  TotalBounty += CrimeFactionParadiso.GetCrimeGold()

  GlobalVariable CrimeBountyAmount = Game.GetForm(0x9108) As GlobalVariable
  CrimeBountyAmount.SetValueInt(TotalBounty)
EndFunction