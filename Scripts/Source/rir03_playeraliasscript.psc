ScriptName RIR03_PlayerAliasScript Extends ReferenceAlias

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
Keyword Property RI_Outfit_BusinessAttireKeyword Auto Const mandatory
Keyword Property RI_Outfit_FCGuardAttireKeyword Auto Const mandatory
Keyword Property RI_Outfit_UCGuardAttireKeyword Auto Const mandatory
Keyword Property RI_Outfit_MiscGuardAttireKeyword Auto Const mandatory
Keyword Property RI_Outfit_NeonGuardAttireKeyword Auto Const mandatory
Int Property iStageToSet Auto Const mandatory
Int Property iPrereqStage Auto Const mandatory
Int Property iTurnOffStage Auto Const mandatory

;-- Functions ---------------------------------------

Event OnItemEquipped(Form akBaseObject, ObjectReference akReference)
  Quest OwningQuest = Self.GetOwningQuest()
  If OwningQuest.GetStageDone(iPrereqStage) && !OwningQuest.GetStageDone(iTurnOffStage)
    If akBaseObject.HasKeyword(RI_Outfit_BusinessAttireKeyword) || akBaseObject.HasKeyword(RI_Outfit_FCGuardAttireKeyword) || akBaseObject.HasKeyword(RI_Outfit_UCGuardAttireKeyword) || akBaseObject.HasKeyword(RI_Outfit_MiscGuardAttireKeyword) || akBaseObject.HasKeyword(RI_Outfit_NeonGuardAttireKeyword)
      OwningQuest.SetStage(iStageToSet)
    EndIf
  EndIf
EndEvent
