ScriptName RIR03_QuestScript Extends Quest

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
Keyword Property RI_Outfit_BusinessAttireKeyword Auto Const mandatory
Keyword Property RI_Outfit_FCGuardAttireKeyword Auto Const mandatory
Keyword Property RI_Outfit_UCGuardAttireKeyword Auto Const mandatory
Keyword Property RI_Outfit_MiscGuardAttireKeyword Auto Const mandatory
Keyword Property RI_Outfit_NeonGuardAttireKeyword Auto Const mandatory
Keyword Property RIR03_Suit_Keyword auto const mandatory
Int Property iStageToSet Auto Const mandatory

;-- Functions ---------------------------------------

Function CheckPlayer()
  Actor PlayerRef = Game.GetPlayer() 
  ; SFCP Fix #735 - Added an additional keyword to this check to trigger the stage update for any flagged item
  If PlayerRef.WornHasKeyword(RI_Outfit_BusinessAttireKeyword) || PlayerRef.WornHasKeyword(RI_Outfit_FCGuardAttireKeyword) || PlayerRef.WornHasKeyword(RI_Outfit_UCGuardAttireKeyword) || PlayerRef.WornHasKeyword(RI_Outfit_NeonGuardAttireKeyword) || PlayerRef.WornHasKeyword(RI_Outfit_MiscGuardAttireKeyword) || PlayerRef.WornHasKeyword(RIR03_Suit_Keyword)
    Self.SetStage(iStageToSet) 
  EndIf
EndFunction
