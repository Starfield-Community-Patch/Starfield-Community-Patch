ScriptName MQ305Script Extends Quest conditional

;-- Structs -----------------------------------------
Struct PlayerKnowledgeStruct
  GlobalVariable PlayerKnowledgeGlobal
  ActorValue PlayerKnowledgeAV
EndStruct


;-- Variables ---------------------------------------

;-- Properties --------------------------------------
inputenablelayer Property MQ305EnableLayer Auto hidden
ActorValue Property PlayerUnityTimesEntered Auto Const mandatory
ActorValue Property COM_IsRomantic Auto Const mandatory
ReferenceAlias Property Andreja Auto Const mandatory
ReferenceAlias Property Barrett Auto Const mandatory
ReferenceAlias Property SamCoe Auto Const mandatory
ReferenceAlias Property SarahMorgan Auto Const mandatory
ReferenceAlias Property CoraCoe Auto Const mandatory
ReferenceAlias Property Vasco Auto Const mandatory
Int Property MQ305_MultiRomance_var Auto conditional
Int Property MQ305_FriendTalkCount_var = 9 Auto conditional
Int Property MQ305_AllFriendsTalkedStage = 50 Auto Const
Int Property AllArtifactsObtainedStage = 20 Auto Const
Int Property ArmillaryPlacedStage = 30 Auto Const
Int Property ArmillaryCompleteStage = 40 Auto Const
Int Property WentToUnityOnceStage = 100 Auto Const
Int Property PlaceArmillaryObj = 30 Auto Const
Int Property PowerUpGravObj = 60 Auto Const
Int Property RemoveArmillaryObj = 70 Auto Const
ObjectReference Property UnityMovetoMarker Auto Const mandatory
ActorValue Property MQ305JumpedToUnity Auto Const mandatory
LocationAlias Property PlayerShipInteriorLocation Auto Const mandatory
Faction Property AvailableCompanionFaction Auto Const mandatory
mq305script:playerknowledgestruct[] Property PlayerKnowledgeArray Auto Const
ObjectReference Property MQ305EndingMarkerAndreja Auto Const mandatory
ObjectReference Property MQ305EndingMarkerBarrett Auto Const mandatory
ObjectReference Property MQ305EndingMarkerSamCoe Auto Const mandatory
ObjectReference Property MQ305EndingMarkerSarahMorgan Auto Const mandatory
Quest Property SQ_ENV Auto Const mandatory
GlobalVariable Property MQ302_SidedWithChoice Auto Const mandatory
GlobalVariable Property MQ305_CF_SysDefEnding Auto Const mandatory
GlobalVariable Property MQ305_CF_PirateEnding Auto Const mandatory
ObjectReference Property MQ305EndingMarkerEmissary Auto Const mandatory
ObjectReference Property Mq305EndingMarkerHunter Auto Const mandatory
ObjectReference Property MQ305EndingMarkerNeither Auto Const mandatory
ObjectReference Property MQ305EndingMarkerCF_SysDef Auto Const mandatory
ObjectReference Property MQ305EndingMarkerCF_Delgado Auto Const mandatory
GlobalVariable Property MQ305_FSC_RonHopeKilled Auto Const mandatory
GlobalVariable Property MQ305_FSC_RonHopeBribeAccepted Auto Const mandatory
GlobalVariable Property MQ305_FSC_RonHopeJailed Auto Const mandatory
ObjectReference Property MQ305EndingMarkerFSC_HopeDead Auto Const mandatory
ObjectReference Property MQ305EndingMarkerFSC_HopeNotDead Auto Const mandatory
ObjectReference Property MQ305EndingMarkerFSC_HopeLetGo Auto Const mandatory
GlobalVariable Property MQ305_RI_NeuroampPromoted Auto Const mandatory
GlobalVariable Property RI08_MasakoRemainedCEO Auto Const mandatory
GlobalVariable Property MQ305_RI_NeuroampNotPromoted Auto Const mandatory
ObjectReference Property MQ305EndingMarkerRI_NeuroAmp Auto Const mandatory
ObjectReference Property MQ305EndingMarkerRI_NeuroAmp_Masako Auto Const mandatory
ObjectReference Property MQ305EndingMarkerRI_NeuroAmp_Ularu Auto Const mandatory
ObjectReference Property MQ305EndingMarkerRI_NoNeuroAmp Auto Const mandatory
ObjectReference Property MQ305EndingMarkerRI_NoNeuroAmp_Masako Auto Const mandatory
ObjectReference Property MQ305EndingMarkerRI_NoNeuroAmp_Ularu Auto Const mandatory
ObjectReference Property MQ305EndingMarkerConstellation Auto Const mandatory
GlobalVariable Property MQ305_UC_PlagueEnding Auto Const mandatory
GlobalVariable Property MQ305_UC_AcelesEnding Auto Const mandatory
GlobalVariable Property MQ305_UC_SterilizationEnding Auto Const mandatory
ObjectReference Property MQ305EndingMarkerUC_Terrormorph Auto Const mandatory
ObjectReference Property MQ305EndingMarkerUC_Aceles Auto Const mandatory
wwiseevent Property WwiseEvent_QST_PlayerEntersUnityA Auto Const mandatory
Idle Property IdleArtifactTouch Auto Const mandatory
ObjectReference Property MQ305EndingMarkerCompanionAny Auto Const mandatory
Spell Property CureAddictions Auto Const mandatory
Scene Property MQ305_002_Unity_05 Auto Const mandatory
VisualEffect Property UnityActorEffect Auto Const mandatory
VisualEffect Property UnityCameraFadeIn_AO Auto Const mandatory

;-- Functions ---------------------------------------

Function EnableUnityEndScenes()
  Int HunterEmissaryChoice = MQ302_SidedWithChoice.GetValueInt()
  If HunterEmissaryChoice == 0
    MQ305EndingMarkerEmissary.EnableNoWait(False)
  ElseIf HunterEmissaryChoice == 1
    Mq305EndingMarkerHunter.EnableNoWait(False)
  ElseIf HunterEmissaryChoice == 2
    MQ305EndingMarkerNeither.EnableNoWait(False)
  EndIf
  Self.EnableRomanceCompanions()
  If MQ305_CF_SysDefEnding.GetValueInt() >= 1
    MQ305EndingMarkerCF_SysDef.EnableNoWait(False)
  ElseIf MQ305_CF_PirateEnding.GetValueInt() >= 1
    MQ305EndingMarkerCF_Delgado.EnableNoWait(False)
  EndIf
  If MQ305_FSC_RonHopeKilled.GetValueInt() >= 1
    MQ305EndingMarkerFSC_HopeDead.EnableNoWait(False)
  ElseIf MQ305_FSC_RonHopeBribeAccepted.GetValueInt() >= 1
    MQ305EndingMarkerFSC_HopeLetGo.EnableNoWait(False)
  ElseIf MQ305_FSC_RonHopeJailed.GetValueInt() >= 1
    MQ305EndingMarkerFSC_HopeNotDead.EnableNoWait(False)
  EndIf
  If MQ305_RI_NeuroampPromoted.GetValueInt() >= 1
    MQ305EndingMarkerRI_NeuroAmp.EnableNoWait(False)
    If RI08_MasakoRemainedCEO.GetValueInt() >= 1
      MQ305EndingMarkerRI_NeuroAmp_Masako.EnableNoWait(False)
    Else
      MQ305EndingMarkerRI_NeuroAmp_Ularu.EnableNoWait(False)
    EndIf
  ElseIf MQ305_RI_NeuroampNotPromoted.GetValueInt() >= 1
    MQ305EndingMarkerRI_NoNeuroAmp.EnableNoWait(False)
    If RI08_MasakoRemainedCEO.GetValueInt() >= 1
      MQ305EndingMarkerRI_NoNeuroAmp_Masako.EnableNoWait(False)
    Else
      MQ305EndingMarkerRI_NoNeuroAmp_Ularu.EnableNoWait(False)
    EndIf
  EndIf
  If MQ305_UC_PlagueEnding.GetValueInt() >= 1
    MQ305EndingMarkerUC_Terrormorph.EnableNoWait(False)
  ElseIf MQ305_UC_AcelesEnding.GetValueInt() >= 1
    MQ305EndingMarkerUC_Aceles.EnableNoWait(False)
  ElseIf MQ305_UC_SterilizationEnding.GetValueInt() >= 1
    MQ305EndingMarkerUC_Terrormorph.EnableNoWait(False)
  EndIf
  MQ305EndingMarkerConstellation.EnableNoWait(False)
EndFunction

Function SavePlayerKnowledge()
  Actor PlayerREF = Game.GetPlayer()
  Int currentElement = 0
  While currentElement < PlayerKnowledgeArray.Length
    Float CurrentPlayerKnowledgeGlobalValue = PlayerKnowledgeArray[currentElement].PlayerKnowledgeGlobal.GetValue()
    ActorValue CurrentPlayerKnowledgeAV = PlayerKnowledgeArray[currentElement].PlayerKnowledgeAV
    PlayerREF.SetValue(CurrentPlayerKnowledgeAV, CurrentPlayerKnowledgeGlobalValue)
    currentElement += 1
  EndWhile
EndFunction

Function EnterUnity()
  Actor PlayerREF = Game.GetPlayer()
  Game.FadeOutGame(True, False, 0.0, 1.0, True)
  Utility.Wait(1.0)
  While MQ305_002_Unity_05.IsPlaying()
    Utility.Wait(0.5)
  EndWhile
  Int myUnityTimesEntered = PlayerREF.GetValueInt(PlayerUnityTimesEntered) + 1
  PlayerREF.SetValue(PlayerUnityTimesEntered, myUnityTimesEntered as Float)
  Self.SavePlayerKnowledge()
  WwiseEvent_QST_PlayerEntersUnityA.Play(PlayerREF as ObjectReference, None, None)
  Game.PlayBinkNoWait("EndingVision.bk2", False, False, False, True, False, True)
  Utility.Wait(0.100000001)
  Game.CreateStarbornGame()
EndFunction

Function CheckMultipleRomance()
  Actor AndrejaREF = Andreja.GetActorRef()
  Actor BarrettREF = Barrett.GetActorRef()
  Actor SamREF = SamCoe.GetActorRef()
  Actor SarahREF = SarahMorgan.GetActorRef()
  MQ305_MultiRomance_var = 0
  If AndrejaREF.IsDead() == False && AndrejaREF.GetValue(COM_IsRomantic) == 1.0
    MQ305_MultiRomance_var += 1
  EndIf
  If BarrettREF.IsDead() == False && BarrettREF.GetValue(COM_IsRomantic) == 1.0
    MQ305_MultiRomance_var += 1
  EndIf
  If SamREF.IsDead() == False && SamREF.GetValue(COM_IsRomantic) == 1.0
    MQ305_MultiRomance_var += 1
  EndIf
  If SarahREF.IsDead() == False && SarahREF.GetValue(COM_IsRomantic) == 1.0
    MQ305_MultiRomance_var += 1
  EndIf
EndFunction

Function EnableRomanceCompanions()
  Actor AndrejaREF = Andreja.GetActorRef()
  Actor BarrettREF = Barrett.GetActorRef()
  Actor SamREF = SamCoe.GetActorRef()
  Actor SarahREF = SarahMorgan.GetActorRef()
  Bool bAnyCompanionEnabled = False
  If AndrejaREF.IsDead() == False && AndrejaREF.GetValue(COM_IsRomantic) == 1.0
    MQ305EndingMarkerAndreja.EnableNoWait(False)
    bAnyCompanionEnabled = True
  EndIf
  If BarrettREF.IsDead() == False && BarrettREF.GetValue(COM_IsRomantic) == 1.0
    MQ305EndingMarkerBarrett.EnableNoWait(False)
    bAnyCompanionEnabled = True
  EndIf
  If SamREF.IsDead() == False && SamREF.GetValue(COM_IsRomantic) == 1.0
    MQ305EndingMarkerSamCoe.EnableNoWait(False)
    bAnyCompanionEnabled = True
  EndIf
  If SarahREF.IsDead() == False && SarahREF.GetValue(COM_IsRomantic) == 1.0
    MQ305EndingMarkerSarahMorgan.EnableNoWait(False)
    bAnyCompanionEnabled = True
  EndIf
  If bAnyCompanionEnabled
    MQ305EndingMarkerCompanionAny.EnableNoWait(False)
  EndIf
EndFunction

Function UpdateFriendTalkCount()
  Actor SamREF = SamCoe.GetActorRef()
  If SamREF.IsDead()
    MQ305_FriendTalkCount_var = 8
  EndIf
EndFunction

Function CheckFriendUnityTalks()
  If Self.GetStageDone(MQ305_AllFriendsTalkedStage) == False
    MQ305_FriendTalkCount_var -= 1
    If MQ305_FriendTalkCount_var <= 0
      Self.SetStage(MQ305_AllFriendsTalkedStage)
    EndIf
  EndIf
EndFunction

Function ArmillaryPlaced(Int iAllArtifactsIn)
  If iAllArtifactsIn == 0
    Self.SetStage(ArmillaryPlacedStage)
  ElseIf Self.GetStageDone(ArmillaryCompleteStage) && !Self.GetStageDone(WentToUnityOnceStage)
    Self.SetObjectiveCompleted(PlaceArmillaryObj, True)
    Self.SetObjectiveDisplayed(PowerUpGravObj, True, True)
    Self.SetObjectiveDisplayed(RemoveArmillaryObj, True, True)
  Else
    Self.SetStage(ArmillaryPlacedStage)
    Self.SetStage(ArmillaryCompleteStage)
  EndIf
EndFunction

Function ArmillaryRemoved()
  If Self.GetStageDone(ArmillaryCompleteStage) && !Self.GetStageDone(WentToUnityOnceStage)
    Self.SetObjectiveCompleted(PlaceArmillaryObj, False)
    Self.SetObjectiveDisplayed(PowerUpGravObj, False, False)
    Self.SetObjectiveDisplayed(RemoveArmillaryObj, False, False)
  EndIf
EndFunction

Function GravJumpToUnity()
  Actor AndrejaREF = Andreja.GetActorRef()
  Actor BarrettREF = Barrett.GetActorRef()
  Actor SamREF = SamCoe.GetActorRef()
  Actor SarahREF = SarahMorgan.GetActorRef()
  Actor CoraREF = CoraCoe.GetActorRef()
  Actor VascoREF = Vasco.GetActorRef()
  Location PlayerShipLoc = PlayerShipInteriorLocation.GetLocation()
  Game.SetCharGenHUDMode(1)
  Game.FadeOutGame(True, False, 0.0, 1.0, True)
  Utility.Wait(1.0)
  Self.CheckInPlayerShip(AndrejaREF, PlayerShipLoc)
  Self.CheckInPlayerShip(BarrettREF, PlayerShipLoc)
  Self.CheckInPlayerShip(SamREF, PlayerShipLoc)
  Self.CheckInPlayerShip(SarahREF, PlayerShipLoc)
  Self.CheckInPlayerShip(CoraREF, PlayerShipLoc)
  Self.CheckInPlayerShip(VascoREF, PlayerShipLoc)
  Actor PlayerREF = Game.GetPlayer()
  PlayerREF.moveto(UnityMovetoMarker, 0.0, 0.0, 0.0, True, False)
  (SQ_ENV as sq_env_afflictionsscript).CureAllAfflictions()
  CureAddictions.Cast(PlayerREF as ObjectReference, PlayerREF as ObjectReference)
  PlayerREF.ResetHealthAndLimbs()
  Game.FadeOutGame(False, True, 0.0, 0.5, False)
EndFunction

Function CheckInPlayerShip(Actor myActor, Location myLoc)
  If myActor.IsInLocation(myLoc)
    myActor.SetValue(MQ305JumpedToUnity, 1.0)
  EndIf
EndFunction

Function LockPlayerControlsUnity()
  Actor PlayerREF = Game.GetPlayer()
  Game.ForceFirstPerson()
  Game.SetCharGenHUDMode(1)
  MQ305EnableLayer = inputenablelayer.Create()
  MQ305EnableLayer.DisablePlayerControls(False, True, True, False, True, True, True, False, True, True, True)
  MQ305EnableLayer.EnableJumping(False)
  UnityActorEffect.Play(PlayerREF as ObjectReference, -1.0, None)
  UnityCameraFadeIn_AO.Play(PlayerREF as ObjectReference, 20.0, None)
  Utility.Wait(20.0)
  MQ305EnableLayer.EnableCamSwitch(True)
EndFunction

Function UnlockPlayerControlUnity()
  Game.SetCharGenHUDMode(0)
  MQ305EnableLayer = None
  UnityActorEffect.Stop(Game.GetPlayer() as ObjectReference)
EndFunction
