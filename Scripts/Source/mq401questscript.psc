ScriptName MQ401QuestScript Extends Quest

;-- Structs -----------------------------------------
Struct PlayerKnowledgeStruct
  GlobalVariable PlayerKnowledgeGlobal
  ActorValue PlayerKnowledgeAV
EndStruct


;-- Variables ---------------------------------------

;-- Properties --------------------------------------
Group QuestVariantsGroup
  Quest[] Property MQ401VariantsArray Auto Const
EndGroup

Int Property PostCharGenStage = 120 Auto Const
Message Property MQ401SkipCharGenMSG Auto Const
Scene Property MQ401_001_LodgeIntro Auto Const mandatory
inputenablelayer Property MQ401EnableLayer Auto hidden
ActorValue Property PlayerUnityTimesEntered Auto Const mandatory
GlobalVariable Property MQ401_VariantCurrent Auto Const mandatory
GlobalVariable Property MQ401_VariantChance Auto Const mandatory
GlobalVariable Property MQ401_ForceVariant Auto Const mandatory
Quest Property MQ101 Auto Const mandatory
ReferenceAlias Property Vasco Auto Const mandatory
ReferenceAlias Property Heller Auto Const mandatory
ReferenceAlias Property Lin Auto Const mandatory
ReferenceAlias Property OroraSabine Auto Const mandatory
ReferenceAlias Property SarahMorgan Auto Const mandatory
ReferenceAlias Property WalterStroud Auto Const mandatory
ReferenceAlias Property MatteoKhatri Auto Const mandatory
ReferenceAlias Property Noel Auto Const mandatory
ReferenceAlias Property VladimirSall Auto Const mandatory
ReferenceAlias Property SamCoe Auto Const mandatory
ReferenceAlias Property CoraCoe Auto Const mandatory
ReferenceAlias Property Andreja Auto Const mandatory
ReferenceAlias Property Barrett Auto Const mandatory
ReferenceAlias Property Armillary Auto Const mandatory
ObjectReference Property MQ101_VascoMarker01 Auto Const mandatory
ObjectReference Property VecteraExteriorNPCEnableMarker Auto Const mandatory
ObjectReference Property VecteraInteriorNPCEnableMarker Auto Const mandatory
Quest Property MQ401_AlwaysOn Auto Const mandatory
Quest Property MQ402 Auto Const mandatory
Quest Property SQ_GravitationalTraits Auto Const mandatory
mq401questscript:playerknowledgestruct[] Property PlayerKnowledgeArray Auto Const

;-- Functions ---------------------------------------

Function LoadPlayerKnowledge()
  Actor PlayerREF = Game.GetPlayer()
  Int currentElement = 0
  While currentElement < PlayerKnowledgeArray.Length
    Float CurrentPlayerKnowledgeAVFloat = PlayerREF.GetValue(PlayerKnowledgeArray[currentElement].PlayerKnowledgeAV)
    GlobalVariable CurrentPlayerKnowledgeGlobal = PlayerKnowledgeArray[currentElement].PlayerKnowledgeGlobal
    CurrentPlayerKnowledgeGlobal.SetValue(CurrentPlayerKnowledgeAVFloat)
    currentElement += 1
  EndWhile
EndFunction

Event OnQuestInit()
  MQ401_AlwaysOn.Start()
  Self.LoadPlayerKnowledge()
  SQ_GravitationalTraits.Stop()
  SQ_GravitationalTraits.Start()
  Int iVariantPercentChance = MQ401_VariantChance.GetValueInt()
  Int iVariantChanceRoll = Utility.RandomInt(0, 100)
  If Game.GetPlayer().GetValue(PlayerUnityTimesEntered) >= 2.0 && iVariantChanceRoll <= iVariantPercentChance
    Int iTotalVariants = MQ401VariantsArray.Length - 1
    Int iVariantNumberRoll = MQ401_ForceVariant.GetValueInt()
    If iVariantNumberRoll == -1
      iVariantNumberRoll = Utility.RandomInt(0, iTotalVariants)
    EndIf
    MQ401_VariantCurrent.SetValueInt(iVariantNumberRoll)
    MQ401VariantsArray[iVariantNumberRoll].Start()
  Else
    Self.NormalStart()
  EndIf
  ; SFCP - Fix for potential soflock on arriving in a variant universe https://www.starfieldpatch.dev/issues/314
  Game.SetInChargen(false, false, false) 
EndEvent

Function CleanUpNormalMainQuest()
  MQ101.Stop()
  VecteraExteriorNPCEnableMarker.DisableNoWait(False)
  VecteraInteriorNPCEnableMarker.DisableNoWait(False)
  Heller.GetActorRef().Disable(False)
  Lin.GetActorRef().Disable(False)
  OroraSabine.GetActorRef().Disable(False)
  Vasco.GetActorRef().Disable(False)
  SarahMorgan.GetActorRef().Disable(False)
  WalterStroud.GetActorRef().Disable(False)
  MatteoKhatri.GetActorRef().Disable(False)
  Noel.GetActorRef().Disable(False)
  VladimirSall.GetActorRef().Disable(False)
  SamCoe.GetActorRef().Disable(False)
  CoraCoe.GetActorRef().Disable(False)
  Andreja.GetActorRef().Disable(False)
  Barrett.GetActorRef().Disable(False)
  MQ402.Start()
  Self.Stop()
EndFunction

Function NormalStart()
  MQ101.SetStage(280)
  MQ101.SetStage(310)
  MQ101.SetStage(1310)
  MQ101.SetStage(1635)
  MQ402.Start()
  Actor VascoREF = Vasco.GetActorRef()
  VascoREF.EvaluatePackage(False)
  VascoREF.moveto(MQ101_VascoMarker01, 0.0, 0.0, 0.0, True, False)
  Armillary.GetRef().Enable(False)
EndFunction

Function MQ401DisablePlayerControls()
  MQ401EnableLayer = inputenablelayer.Create()
  MQ401EnableLayer.DisablePlayerControls(True, True, False, False, False, True, True, False, True, True, False)
EndFunction

Function MQ401EnablePlayerControls()
  MQ401EnableLayer = None
EndFunction
