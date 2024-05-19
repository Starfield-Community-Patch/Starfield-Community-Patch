ScriptName CrewEliteOtherPlayerScript Extends Actor

;-- Variables ---------------------------------------
Int BodyType_Feminine = 1 Const
Int BodyType_Masculine = 0 Const
Int Pronoun_HeHim = 1 Const
Int Pronoun_SheHer = 2 Const
Int Pronoun_TheyThem = 3 Const
Int Pronoun_Unselected = 0 Const

;-- Properties --------------------------------------
Message Property PlayerNameMSG Auto Const mandatory
VoiceType Property NPCFOtherPlayer Auto Const mandatory
VoiceType Property NPCMOtherPlayer Auto Const mandatory
VoiceType Property NPCXOtherPlayer Auto Const mandatory
VoiceType Property NPCXOtherPlayer_2 Auto Const mandatory
ReferenceAlias Property MQ00_OtherPlayer Auto Const mandatory

;-- State -------------------------------------------
Auto State WaitingForPlayer

  Event OnUnload()
    ; Empty function
  EndEvent

  Event OnLoad()
    Self.gotostate("hasbeentriggered")
    Actor PlayerREF = Game.GetPlayer()
    ActorBase PlayerBase = PlayerREF.GetBaseObject() as ActorBase
    Self.WaitFor3dLoad()
    Self.CopyAppearance(PlayerREF)
    MQ00_OtherPlayer.ForceRefTo(Self as ObjectReference)
    If PlayerBase.GetPronoun() == Pronoun_TheyThem
      If PlayerBase.GetSex() == BodyType_Feminine
        Self.SetOverrideVoiceType(NPCXOtherPlayer_2)
      Else
        Self.SetOverrideVoiceType(NPCXOtherPlayer)
      EndIf
    ElseIf PlayerBase.GetSex() == BodyType_Feminine
      If PlayerBase.GetPronoun() == Pronoun_SheHer || PlayerBase.GetPronoun() == Pronoun_Unselected
        Self.SetOverrideVoiceType(NPCFOtherPlayer)
      Else
        Self.SetOverrideVoiceType(NPCXOtherPlayer_2)
      EndIf
    ElseIf PlayerBase.GetPronoun() == Pronoun_HeHim || PlayerBase.GetPronoun() == Pronoun_Unselected
      Self.SetOverrideVoiceType(NPCMOtherPlayer)
    Else
      Self.SetOverrideVoiceType(NPCXOtherPlayer)
    EndIf
  EndEvent
EndState

;-- State -------------------------------------------
State hasbeentriggered

  Event OnLoad()
    ; Empty function
  EndEvent

  Event OnUnload()
    Self.gotostate("WaitingForPlayer")
  EndEvent
EndState
