ScriptName Fragments:Quests:QF_RI05_001EE0C8 Extends Quest Const hidden

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
GlobalVariable Property RI05_Track_BayuBypassed Auto Const mandatory
ReferenceAlias Property Alias_Imogene Auto Const mandatory
ReferenceAlias Property Alias_ImogeneMarker Auto Const mandatory
ReferenceAlias Property Alias_Yuko Auto Const mandatory
ReferenceAlias Property Alias_ImogeneOfficeDoor Auto Const mandatory
ReferenceAlias Property Alias_YukoTravelMarker Auto Const mandatory
Scene Property RI05_0100_Yuko_PlayerAddressScene Auto Const mandatory
ReferenceAlias Property Alias_Kumiho Auto Const mandatory
Book Property RI05_KumihoSlate Auto Const mandatory
Scene Property RI05_0800_Imogene_PlayerAddressScene Auto Const mandatory
ReferenceAlias Property Alias_ImogeneOfficeQS Auto Const mandatory
ReferenceAlias Property Alias_TradeTowerQS Auto Const mandatory
MiscObject Property Credits Auto Const mandatory
ReferenceAlias Property Alias_SeokguhQS Auto Const mandatory
ReferenceAlias Property Alias_KumihoSlate Auto Const mandatory
ReferenceAlias Property Alias_DaltonOfficeQS Auto Const mandatory
ReferenceAlias Property Alias_ImogeneSeokguhQS Auto Const mandatory
Quest Property LC115 Auto Const mandatory
Faction Property LC115SeokguhFaction Auto Const mandatory
Faction Property RyujinIndustriesFaction Auto Const mandatory
Faction Property PlayerEnemyFaction Auto Const mandatory
Book Property RI05_ImogeneEvidenceSlate Auto Const mandatory
ReferenceAlias Property Alias_ImogeneEvidenceSlate Auto Const mandatory
GlobalVariable Property RI05_Track_BayuFavorRefused Auto Const mandatory
GlobalVariable Property RI05_ImogeneDead Auto Const mandatory
GlobalVariable Property RI05_Track_ImogeneSpared Auto Const mandatory
Scene Property RI05_0550_Companion_ReactToRejectingBayuScene Auto Const mandatory
Scene Property RI05_0550_Compantion_ReactToDoingBayuFavorScene Auto Const mandatory
Scene Property RI05_0915_Companion_PlayerKilledImogeneScene Auto Const mandatory
Scene Property RI05_930_Companion_PlayerLetImogeneLiveScene Auto Const mandatory
Scene Property RI05_1150_Companion_RespondToBayuDecisionScene Auto Const mandatory
Quest Property RI06 Auto Const mandatory
Quest Property DialogueFCSeokguhSyndicateHideout_RI05 Auto Const mandatory
GlobalVariable Property RI05_Imogene_Credits Auto Const mandatory
GlobalVariable Property RI05_Bayu_Credits Auto Const mandatory
Faction Property LC044RyujinGuardCrimeFaction Auto Const mandatory
ReferenceAlias Property Alias_Ularu Auto Const mandatory
GlobalVariable Property RI05_Frankie_LargeCredits Auto Const mandatory
ReferenceAlias Property Alias_FrankiesDoor Auto Const mandatory
ReferenceAlias Property Alias_UlaruDoor Auto Const mandatory
Quest Property LC044 Auto Const mandatory
Perk Property FactionRyujinIndustriesPerk Auto Const mandatory
ReferenceAlias Property Alias_FrankiesQS Auto Const mandatory
ReferenceAlias Property Alias_UlaruOfficeQS Auto Const mandatory
Key Property RI05_UlaruKeycard Auto Const mandatory
GlobalVariable Property RI05_UlaruDead Auto Const mandatory
ReferenceAlias Property Alias_Maeve Auto Const mandatory
ReferenceAlias Property Alias_MaeveSceneMarker Auto Const mandatory
GlobalVariable Property RI05_Track_BayuDispleased Auto Const mandatory
GlobalVariable Property RI05_Track_BayuPlayerKeptSlate Auto Const mandatory
Quest Property RI_Support Auto Const mandatory
ReferenceAlias Property Alias_Frankie Auto Const mandatory
Scene Property RI05_0600_Frankie_ForceGreetScene Auto Const mandatory
ReferenceAlias Property Alias_SyndicateGuard01 Auto Const mandatory
ReferenceAlias Property Alias_SyndicateGuard02 Auto Const mandatory
ActorValue Property Aggression Auto Const mandatory
Faction Property LC115SeokguhTrespassFaction Auto Const mandatory
Faction Property PlayerFaction Auto Const mandatory
ReferenceAlias Property Alias_YukoReturnStartMarker Auto Const mandatory
Location Property LC115Location Auto Const mandatory
GlobalVariable Property RI05_LC115PreviouslyExplored Auto Const mandatory
Cell Property LC115SeokguhHideout Auto Const mandatory
ReferenceAlias Property Alias_MaeveGuardFurniture Auto Const mandatory
ReferenceAlias Property Alias_MaeveGuard Auto Const mandatory
ReferenceAlias Property Alias_YukoReturnQS Auto Const mandatory
ActorValue Property RI07_Foreknowledge_ImogeneInnocentAV Auto Const mandatory
ReferenceAlias Property Alias_YukoDoor Auto Const mandatory
ReferenceAlias Property Alias_YukoStartMarker Auto Const mandatory
Quest Property RI04 Auto Const mandatory
GlobalVariable Property RI05_Track_PlayerSidedWithMasako Auto Const mandatory
GlobalVariable Property RI05_Track_PlayerSidedWithUlaru Auto Const mandatory
ReferenceAlias Property Alias_EnableFriendlyAddsMarker Auto Const mandatory
Key Property RI05_SeokguhSyndicateHideoutKey Auto Const mandatory
ReferenceAlias Property Alias_UlaruChairSwapEnableMarker Auto Const mandatory
Scene Property RI05_1000_Ularu_ConfrontationPartIIScene Auto Const mandatory
Quest Property DialogueFCNeon Auto Const mandatory
Faction Property CrimeFactionNeon Auto Const mandatory
Keyword Property Artifact_GravImmune Auto Const mandatory

;-- Functions ---------------------------------------

Function Fragment_Stage_0000_Item_00()
  RI_Support.SetStage(1)
  Alias_YukoDoor.GetRef().Lock(False, False, True)
EndFunction

Function Fragment_Stage_0001_Item_00()
  RI04.SetStage(9)
EndFunction

Function Fragment_Stage_0002_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Game.GetPlayer().MoveTo(Alias_ImogeneOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0003_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_ImogeneOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0004_Item_00()
  Self.SetStage(0)
  Self.SetStage(400)
  Self.SetStage(600)
  Alias_YukoDoor.GetRef().Lock(False, False, True)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_DaltonOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0005_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(600)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_TradeTowerQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0006_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(520)
  Self.SetStage(550)
  Self.SetStage(600)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_FrankiesQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0007_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_FrankiesQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0008_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(503)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_ImogeneSeokguhQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0009_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(503)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_ImogeneSeokguhQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0010_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(503)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(911)
  Self.SetStage(960)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_ImogeneSeokguhQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0011_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(540)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_SeokguhQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0012_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(700)
  Self.SetStage(799)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(930)
  Self.SetStage(950)
  Self.SetStage(990)
  Self.SetStage(1100)
  Game.GetPlayer().MoveTo(Alias_TradeTowerQS.GetRef(), 0.0, 0.0, 0.0, True, False)
  Game.GetPlayer().AddItem(Alias_KumihoSlate.GetRef() as Form, 1, False)
EndFunction

Function Fragment_Stage_0013_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(930)
  Self.SetStage(950)
  Self.SetStage(1000)
  Self.SetStage(1100)
  Self.SetStage(1110)
  Self.SetStage(1150)
  Self.SetStage(1200)
  Self.SetStage(1300)
  Self.SetStage(1301)
  Game.GetPlayer().MoveTo(Alias_UlaruOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0014_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(930)
  Self.SetStage(950)
  Self.SetStage(1000)
  Self.SetStage(1070)
  Self.SetStage(1100)
  Self.SetStage(1110)
  Self.SetStage(1150)
  Self.SetStage(1200)
  Alias_Ularu.GetRef().Disable(False)
  Game.GetPlayer().AddItem(RI05_UlaruKeycard as Form, 1, False)
  Game.GetPlayer().MoveTo(Alias_UlaruOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0015_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(930)
  Self.SetStage(950)
  Self.SetStage(1000)
  Self.SetStage(1060)
  Self.SetStage(1090)
  Self.SetStage(1100)
  Self.SetStage(1110)
  Self.SetStage(1150)
  Self.SetStage(1200)
  Game.GetPlayer().MoveTo(Alias_DaltonOfficeQS.GetRef(), 0.0, 0.0, 0.0, True, False)
  Game.GetPlayer().AddItem(RI05_ImogeneEvidenceSlate as Form, 1, False)
EndFunction

Function Fragment_Stage_0016_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(930)
  Self.SetStage(950)
  Self.SetStage(1000)
  Self.SetStage(1100)
  Self.SetStage(1110)
  Self.SetStage(1150)
  Self.SetStage(1200)
  Game.GetPlayer().AddItem(RI05_ImogeneEvidenceSlate as Form, 1, False)
  Game.GetPlayer().MoveTo(Alias_YukoReturnQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0017_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(915)
  Self.SetStage(950)
  Self.SetStage(1000)
  Self.SetStage(1100)
  Self.SetStage(1110)
  Self.SetStage(1150)
  Self.SetStage(1200)
  Game.GetPlayer().AddItem(RI05_ImogeneEvidenceSlate as Form, 1, False)
  Game.GetPlayer().MoveTo(Alias_YukoReturnQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0018_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(915)
  Self.SetStage(950)
  Self.SetStage(1000)
  Self.SetStage(1060)
  Self.SetStage(1090)
  Self.SetStage(1100)
  Self.SetStage(1110)
  Self.SetStage(1150)
  Self.SetStage(1200)
  Game.GetPlayer().AddItem(RI05_ImogeneEvidenceSlate as Form, 1, False)
  Game.GetPlayer().MoveTo(Alias_YukoReturnQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0019_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(915)
  Self.SetStage(950)
  Self.SetStage(1000)
  Self.SetStage(1050)
  Self.SetStage(1090)
  Self.SetStage(1100)
  Self.SetStage(1110)
  Self.SetStage(1150)
  Self.SetStage(1200)
  Game.GetPlayer().AddItem(RI05_ImogeneEvidenceSlate as Form, 1, False)
  Game.GetPlayer().MoveTo(Alias_YukoReturnQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0020_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(510)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Self.SetStage(660)
  Self.SetStage(800)
  Self.SetStage(900)
  Self.SetStage(915)
  Self.SetStage(950)
  Self.SetStage(1000)
  Self.SetStage(1060)
  Self.SetStage(1070)
  Self.SetStage(1090)
  Self.SetStage(1100)
  Self.SetStage(1110)
  Self.SetStage(1150)
  Self.SetStage(1200)
  Game.GetPlayer().AddItem(RI05_ImogeneEvidenceSlate as Form, 1, False)
  Game.GetPlayer().MoveTo(Alias_YukoReturnQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0070_Item_00()
  Self.SetStage(0)
  Self.SetStage(400)
  Self.SetStage(600)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_FrankiesQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0072_Item_00()
  Self.SetStage(0)
  Self.SetStage(100)
  Self.SetStage(105)
  Self.SetStage(300)
  Self.SetStage(399)
  Self.SetStage(400)
  Self.SetStage(450)
  Self.SetStage(500)
  Self.SetStage(503)
  Self.SetStage(550)
  Self.SetStage(600)
  Self.SetStage(610)
  Self.SetStage(620)
  Self.SetStage(622)
  Self.SetStage(635)
  Alias_Imogene.GetRef().MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Imogene.GetActorRef().SetEssential(False)
  Game.GetPlayer().MoveTo(Alias_SeokguhQS.GetRef(), 0.0, 0.0, 0.0, True, False)
EndFunction

Function Fragment_Stage_0100_Item_00()
  Self.SetActive(True)
  Actor ImogeneRef = Alias_Imogene.GetActorRef()
  ImogeneRef.RemoveFromFaction(RyujinIndustriesFaction)
  ImogeneRef.RemoveFromFaction(CrimeFactionNeon)
  ImogeneRef.MoveTo(Alias_ImogeneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  ImogeneRef.SetEssential(False)
  Alias_Yuko.GetRef().Enable(False)
  Alias_YukoDoor.GetRef().Lock(False, False, True)
  Alias_YukoDoor.GetRef().SetOpen(True)
  Alias_Yuko.GetRef().MoveTo(Alias_YukoStartMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_Yuko.GetActorRef().EvaluatePackage(False)
  Alias_ImogeneOfficeDoor.GetRef().SetOpen(False)
  Alias_Frankie.GetActorRef().SetEssential(False)
  Self.SetObjectiveDisplayed(100, True, False)
EndFunction

Function Fragment_Stage_0101_Item_00()
  Alias_YukoDoor.GetRef().Lock(False, False, True)
  Alias_Yuko.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0105_Item_00()
  If !Self.GetStageDone(300)
    Alias_Yuko.GetActorRef().EvaluatePackage(False)
    RI05_0100_Yuko_PlayerAddressScene.Start()
  EndIf
EndFunction

Function Fragment_Stage_0110_Item_00()
  If !Self.GetStageDone(105) && !Self.GetStageDone(300)
    Alias_Yuko.GetActorRef().EvaluatePackage(False)
    RI05_0100_Yuko_PlayerAddressScene.Start()
  EndIf
EndFunction

Function Fragment_Stage_0300_Item_00()
  Self.SetObjectiveDisplayed(100, False, False)
  Self.SetObjectiveDisplayed(300, True, False)
EndFunction

Function Fragment_Stage_0399_Item_00()
  Self.SetObjectiveCompleted(300, True)
  If !Self.GetStageDone(350)
    Self.SetStage(400)
  Else
    Self.SetStage(500)
  EndIf
  Self.SetStage(600)
EndFunction

Function Fragment_Stage_0400_Item_00()
  Self.SetObjectiveDisplayed(400, True, False)
EndFunction

Function Fragment_Stage_0450_Item_00()
  Self.SetStage(500)
  Self.SetObjectiveCompleted(400, True)
EndFunction

Function Fragment_Stage_0500_Item_00()
  Self.SetObjectiveCompleted(300, True)
  Self.SetObjectiveDisplayed(500, True, False)
  If Self.IsObjectiveDisplayed(400)
    Self.SetObjectiveDisplayed(400, False, False)
  EndIf
EndFunction

Function Fragment_Stage_0500_Item_01()
  Self.SetObjectiveCompleted(300, True)
  Self.SetObjectiveDisplayed(500, True, False)
EndFunction

Function Fragment_Stage_0503_Item_00()
  Self.SetStage(540)
  RI05_Track_BayuDispleased.SetValue(0.0)
EndFunction

Function Fragment_Stage_0504_Item_00()
  Self.SetStage(540)
  RI05_Track_BayuDispleased.SetValue(0.0)
EndFunction

Function Fragment_Stage_0505_Item_00()
  Self.SetStage(540)
  RI05_Track_BayuDispleased.SetValue(0.0)
EndFunction

Function Fragment_Stage_0510_Item_00()
  Self.SetStage(540)
EndFunction

Function Fragment_Stage_0520_Item_00()
  RI05_Track_BayuFavorRefused.SetValue(1.0)
  RI05_Track_BayuDispleased.SetValue(1.0)
EndFunction

Function Fragment_Stage_0525_Item_00()
  RI05_Track_BayuDispleased.SetValue(1.0)
  Self.SetStage(550)
EndFunction

Function Fragment_Stage_0530_Item_00()
  RI05_Track_BayuBypassed.SetValue(1.0)
  RI05_Track_BayuDispleased.SetValue(1.0)
EndFunction

Function Fragment_Stage_0540_Item_00()
  LC115.SetStage(20)
  Alias_EnableFriendlyAddsMarker.GetRef().Enable(False)
  DialogueFCSeokguhSyndicateHideout_RI05.Start()
  Alias_SyndicateGuard01.GetActorRef().SetValue(Aggression, 0.0)
  Alias_SyndicateGuard02.GetActorRef().SetValue(Aggression, 0.0)
  Self.SetStage(550)
  Self.SetStage(980)
EndFunction

Function Fragment_Stage_0550_Item_00()
  If Self.GetStageDone(510)
    Self.SetStage(610)
    RI05_0550_Compantion_ReactToDoingBayuFavorScene.Start()
  ElseIf Self.GetStageDone(520)
    RI05_0550_Companion_ReactToRejectingBayuScene.Start()
  EndIf
  Self.SetObjectiveCompleted(500, True)
  If Self.IsObjectiveDisplayed(400)
    Self.SetObjectiveDisplayed(400, False, False)
  EndIf
  If Self.GetStageDone(505) || Self.GetStageDone(504) || Self.GetStageDone(503)
    Self.SetStage(610)
  EndIf
EndFunction

Function Fragment_Stage_0600_Item_00()
  Self.SetObjectiveDisplayedAtTop(600)
  LC115SeokguhHideout.Reset()
  LC115Location.Reset()
  LC115.SetStage(0)
EndFunction

Function Fragment_Stage_0610_Item_00()
  Self.SetObjectiveCompleted(500, True)
  Self.SetObjectiveDisplayed(610, True, False)
EndFunction

Function Fragment_Stage_0620_Item_00()
  Self.SetObjectiveCompleted(610, True)
  Self.SetObjectiveDisplayed(620, True, False)
  Alias_Frankie.GetActorRef().SetEssential(False)
EndFunction

Function Fragment_Stage_0622_Item_00()
  Self.SetStage(635)
  Self.SetObjectiveCompleted(620, True)
EndFunction

Function Fragment_Stage_0625_Item_00()
  If Game.GetPlayer().GetItemCount(RI05_SeokguhSyndicateHideoutKey as Form) == 0
    RI05_0600_Frankie_ForceGreetScene.Start()
  EndIf
EndFunction

Function Fragment_Stage_0630_Item_00()
  Self.SetStage(650)
  Self.SetObjectiveCompleted(610, True)
  Self.SetObjectiveCompleted(620, True)
EndFunction

Function Fragment_Stage_0635_Item_00()
  Alias_FrankiesDoor.GetRef().Lock(False, False, True)
  Self.SetObjectiveCompleted(610, True)
  Self.SetObjectiveCompleted(620, True)
  Alias_Frankie.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0645_Item_00()
  Game.GetPlayer().RemoveItem(Credits as Form, RI05_Frankie_LargeCredits.GetValueInt(), False, None)
EndFunction

Function Fragment_Stage_0650_Item_00()
  Self.SetObjectiveDisplayed(650, True, False)
EndFunction

Function Fragment_Stage_0651_Item_00()
  If Self.IsObjectiveDisplayed(620)
    Self.SetObjectiveDisplayed(620, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(650)
    Self.SetObjectiveCompleted(650, True)
  EndIf
EndFunction

Function Fragment_Stage_0655_Item_00()
  Self.SetObjectiveDisplayed(620, False, False)
  Alias_Frankie.Clear()
  DialogueFCNeon.SetStage(700)
EndFunction

Function Fragment_Stage_0660_Item_00()
  If !Self.GetStageDone(550)
    RI05_Track_BayuBypassed.SetValue(1.0)
  EndIf
  If Self.GetStageDone(300)
    Self.SetObjectiveDisplayedAtTop(660)
  EndIf
  If Self.GetStageDone(510)
    Self.SetStage(700)
  EndIf
  If Self.IsObjectiveDisplayed(400)
    Self.SetObjectiveDisplayed(400, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(500)
    Self.SetObjectiveDisplayed(500, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(650)
    Self.SetObjectiveCompleted(650, True)
  EndIf
  Self.SetObjectiveDisplayed(600, False, False)
  Self.SetObjectiveDisplayed(660, True, False)
  Self.SetStage(980)
EndFunction

Function Fragment_Stage_0670_Item_00()
  RI05_0800_Imogene_PlayerAddressScene.Start()
EndFunction

Function Fragment_Stage_0680_Item_00()
  Alias_SyndicateGuard01.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0686_Item_00()
  Alias_SyndicateGuard01.GetActorRef().SetValue(Aggression, 1.0)
  LC115SeokguhTrespassFaction.SetEnemy(PlayerFaction, False, False)
EndFunction

Function Fragment_Stage_0690_Item_00()
  Alias_SyndicateGuard02.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0696_Item_00()
  Alias_SyndicateGuard02.GetActorRef().SetValue(Aggression, 1.0)
  LC115SeokguhTrespassFaction.SetEnemy(PlayerFaction, False, False)
EndFunction

Function Fragment_Stage_0699_Item_00()
  LC115.SetStage(10)
  Alias_SyndicateGuard01.GetActorRef().SetValue(Aggression, 1.0)
  Alias_SyndicateGuard02.GetActorRef().SetValue(Aggression, 1.0)
  LC115SeokguhTrespassFaction.SetEnemy(PlayerFaction, False, False)
EndFunction

Function Fragment_Stage_0700_Item_00()
  Self.SetObjectiveDisplayed(700, True, False)
  Alias_Kumiho.GetRef().Enable(False)
  Alias_KumihoSlate.GetRef().Enable(False)
EndFunction

Function Fragment_Stage_0750_Item_00()
  Alias_Kumiho.Clear()
EndFunction

Function Fragment_Stage_0799_Item_00()
  If Self.GetStageDone(925) || Self.GetStageDone(950)
    Self.SetStage(1100)
  EndIf
  Self.SetObjectiveCompleted(700, True)
EndFunction

Function Fragment_Stage_0800_Item_00()
  If Self.IsObjectiveDisplayed(100)
    Self.SetObjectiveDisplayed(100, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(300)
    Self.SetObjectiveDisplayed(300, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(400)
    Self.SetObjectiveDisplayed(400, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(500)
    Self.SetObjectiveDisplayed(500, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(660)
    Self.SetObjectiveCompleted(660, True)
  EndIf
  Self.SetObjectiveDisplayedAtTop(800)
EndFunction

Function Fragment_Stage_0800_Item_01()
  If Self.IsObjectiveDisplayed(100)
    Self.SetObjectiveDisplayed(100, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(300)
    Self.SetObjectiveDisplayed(300, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(400)
    Self.SetObjectiveDisplayed(400, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(500)
    Self.SetObjectiveDisplayed(500, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(660)
    Self.SetObjectiveCompleted(660, True)
  EndIf
  Self.SetObjectiveDisplayedAtTop(800)
EndFunction

Function Fragment_Stage_0900_Item_00()
  Self.SetObjectiveCompleted(800, True)
  Self.SetObjectiveDisplayedAtTop(900)
EndFunction

Function Fragment_Stage_0900_Item_01()
  Self.SetObjectiveCompleted(800, True)
  Self.SetObjectiveDisplayedAtTop(900)
EndFunction

Function Fragment_Stage_0910_Item_00()
  If !Self.GetStageDone(805)
    Self.SetStage(810)
  EndIf
  Self.SetStage(911)
  Self.SetStage(960)
EndFunction

Function Fragment_Stage_0911_Item_00()
  Actor ImogeneRef = Alias_Imogene.GetActorRef()
  ImogeneRef.RemoveFromFaction(RyujinIndustriesFaction)
  ImogeneRef.RemoveFromFaction(CrimeFactionNeon)
  ImogeneRef.AddToFaction(PlayerEnemyFaction)
  ImogeneRef.SetValue(Aggression, 2.0)
  ImogeneRef.StartCombat(Game.GetPlayer() as ObjectReference, False)
  If !Self.GetStageDone(950)
    Self.SetStage(960)
  EndIf
EndFunction

Function Fragment_Stage_0915_Item_00()
  If Self.IsObjectiveDisplayed(660)
    Self.SetObjectiveCompleted(660, True)
  EndIf
  If Self.IsObjectiveDisplayed(960)
    Self.SetObjectiveCompleted(960, True)
  EndIf
  If Self.IsObjectiveDisplayed(900)
    Self.SetObjectiveCompleted(900, True)
  EndIf
  If Self.IsObjectiveDisplayed(800)
    Self.SetObjectiveCompleted(800, True)
  EndIf
  RI05_ImogeneDead.SetValue(1.0)
  If Self.GetStageDone(930)
    Self.SetStage(970)
  Else
    Self.SetStage(965)
  EndIf
  Utility.Wait(3.0)
  RI05_0915_Companion_PlayerKilledImogeneScene.Start()
  Alias_Imogene.Clear()
EndFunction

Function Fragment_Stage_0920_Item_00()
  RI05_Track_ImogeneSpared.SetValue(1.0)
  Game.GetPlayer().AddItem(Credits as Form, RI05_Imogene_Credits.GetValueInt(), False)
  Self.SetStage(950)
  Utility.Wait(3.0)
  RI05_930_Companion_PlayerLetImogeneLiveScene.Start()
EndFunction

Function Fragment_Stage_0925_Item_00()
  If Self.IsObjectiveDisplayed(965)
    Self.SetObjectiveCompleted(965, True)
  EndIf
  If !Self.GetStageDone(700)
    Self.SetStage(1200)
  EndIf
  If Self.GetStageDone(799)
    Self.SetStage(1100)
  Else
    Self.SetStage(990)
  EndIf
EndFunction

Function Fragment_Stage_0930_Item_00()
  RI05_Track_ImogeneSpared.SetValue(1.0)
  Self.SetStage(950)
  RI05_930_Companion_PlayerLetImogeneLiveScene.Start()
EndFunction

Function Fragment_Stage_0950_Item_00()
  Game.GetPlayer().AddItem(Alias_ImogeneEvidenceSlate.GetRef() as Form, 1, False)
  Self.SetObjectiveCompleted(800, True)
  Self.SetObjectiveCompleted(900, True)
  If !Self.GetStageDone(700)
    Self.SetStage(1200)
  EndIf
  If Self.GetStageDone(799)
    Self.SetStage(1100)
  Else
    Self.SetStage(990)
  EndIf
EndFunction

Function Fragment_Stage_0960_Item_00()
  If Self.IsObjectiveDisplayed(900)
    Self.SetObjectiveCompleted(900, True)
  EndIf
  Self.SetObjectiveDisplayedAtTop(960)
EndFunction

Function Fragment_Stage_0960_Item_01()
  If Self.IsObjectiveDisplayed(900)
    Self.SetObjectiveCompleted(900, True)
  EndIf
  Self.SetObjectiveDisplayedAtTop(960)
EndFunction

Function Fragment_Stage_0965_Item_00()
  Self.SetObjectiveDisplayedAtTop(965)
EndFunction

Function Fragment_Stage_10000_Item_00()
  Self.SetObjectiveCompleted(1200, True)
  If Self.IsObjectiveDisplayed(1000)
    Self.SetObjectiveDisplayed(1000, False, False)
  EndIf
  If Self.IsObjectiveDisplayed(1300)
    Self.SetObjectiveDisplayed(1300, False, False)
  EndIf
  LC115.SetStage(10)
  Alias_EnableFriendlyAddsMarker.GetRef().Disable(False)
  Game.GetPlayer().RemoveFromFaction(LC115SeokguhFaction)
  RI06.SetStage(100)
  Game.AddAchievement(18)
  If RI05_Track_PlayerSidedWithUlaru.GetValue() == 0.0 && RI05_Track_PlayerSidedWithMasako.GetValue() == 0.0
    RI05_Track_PlayerSidedWithMasako.SetValue(1.0)
  EndIf
  Alias_Imogene.GetRef().Disable(False)
  Alias_UlaruChairSwapEnableMarker.GetRef().Disable(False)
  Self.Stop()
EndFunction

Function Fragment_Stage_1000_Item_00()
  Alias_UlaruChairSwapEnableMarker.GetRef().Enable(False)
  Alias_Ularu.GetActorRef().EvaluatePackage(False)
  Alias_Ularu.GetRef().AddKeyword(Artifact_GravImmune)
  Self.SetObjectiveDisplayed(1000, True, False)
  Alias_UlaruDoor.GetRef().Lock(False, False, True)
  Alias_UlaruDoor.GetRef().BlockActivation(False, False)
EndFunction

Function Fragment_Stage_1001_Item_00()
  ObjectReference UlaruDoorRef = Alias_UlaruDoor.GetRef()
  UlaruDoorRef.SetOpen(False)
  Utility.Wait(2.0)
  UlaruDoorRef.Lock(True, False, True)
  UlaruDoorRef.SetLockLevel(255)
  UlaruDoorRef.BlockActivation(True, True)
EndFunction

Function Fragment_Stage_1006_Item_00()
  Game.StopDialogueCamera(False, False)
EndFunction

Function Fragment_Stage_1040_Item_00()
  Game.GetPlayer().SetValue(RI07_Foreknowledge_ImogeneInnocentAV, 1.0)
EndFunction

Function Fragment_Stage_1050_Item_00()
  RI05_Track_PlayerSidedWithUlaru.SetValue(1.0)
  Self.SetStage(1090)
EndFunction

Function Fragment_Stage_1055_Item_00()
  Game.GetPlayer().RemoveItem(RI05_ImogeneEvidenceSlate as Form, 1, False, None)
EndFunction

Function Fragment_Stage_1060_Item_00()
  RI05_Track_PlayerSidedWithMasako.SetValue(1.0)
  Self.SetStage(1090)
EndFunction

Function Fragment_Stage_1065_Item_00()
  Actor UlaruRef = Alias_Ularu.GetActorRef()
  UlaruRef.RemoveFromFaction(CrimeFactionNeon)
  UlaruRef.RemoveFromFaction(RyujinIndustriesFaction)
  UlaruRef.RemoveFromFaction(LC044RyujinGuardCrimeFaction)
  UlaruRef.AddToFaction(PlayerEnemyFaction)
  UlaruRef.SetEssential(False)
  UlaruRef.SetValue(Aggression, 2.0)
  UlaruRef.StartCombat(Game.GetPlayer() as ObjectReference, False)
  UlaruRef.RemoveKeyword(Artifact_GravImmune)
EndFunction

Function Fragment_Stage_1070_Item_00()
  RI05_UlaruDead.SetValue(1.0)
  Alias_Maeve.GetRef().MoveTo(Alias_MaeveSceneMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  Alias_MaeveGuard.GetRef().MoveTo(Alias_MaeveGuardFurniture.GetRef(), 0.0, 0.0, 0.0, True, False)
  Self.SetObjectiveCompleted(1000, True)
  Alias_Ularu.Clear()
  Alias_UlaruDoor.GetRef().BlockActivation(False, False)
EndFunction

Function Fragment_Stage_1081_Item_00()
  Alias_Maeve.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_1090_Item_00()
  If !Self.GetStageDone(1065)
    Alias_UlaruDoor.GetRef().Lock(False, False, True)
    Alias_UlaruDoor.GetRef().BlockActivation(False, False)
    Self.SetObjectiveCompleted(1000, True)
  EndIf
  Alias_Ularu.GetActorRef().EvaluatePackage(False)
  Alias_Ularu.GetRef().RemoveKeyword(Artifact_GravImmune)
EndFunction

Function Fragment_Stage_1100_Item_00()
  Self.SetObjectiveCompleted(700, True)
  Self.SetObjectiveDisplayedAtTop(1100)
EndFunction

Function Fragment_Stage_1110_Item_00()
  Game.GetPlayer().RemoveItem(RI05_KumihoSlate as Form, 1, False, None)
  Self.SetStage(1150)
  RI05_Track_BayuDispleased.SetValue(0.0)
EndFunction

Function Fragment_Stage_1120_Item_00()
  Self.SetStage(1150)
  RI05_Track_BayuPlayerKeptSlate.SetValue(1.0)
  RI05_Track_BayuDispleased.SetValue(1.0)
EndFunction

Function Fragment_Stage_1130_Item_00()
  Actor PlayerActor = Game.GetPlayer()
  PlayerActor.RemoveItem(RI05_KumihoSlate as Form, 1, False, None)
  PlayerActor.AddItem(Credits as Form, RI05_Bayu_Credits.GetValueInt(), False)
  RI05_Track_BayuDispleased.SetValue(0.0)
  Self.SetStage(1150)
EndFunction

Function Fragment_Stage_1150_Item_00()
  Self.SetObjectiveCompleted(1100, True)
  Self.SetStage(1200)
  RI05_1150_Companion_RespondToBayuDecisionScene.Start()
  If RI05_Track_BayuDispleased.GetValue() == -1.0
    RI05_Track_BayuDispleased.SetValue(0.0)
  EndIf
EndFunction

Function Fragment_Stage_1200_Item_00()
  Self.SetObjectiveDisplayedAtTop(1200)
  Self.SetStage(1000)
  Actor YukoRef = Alias_Yuko.GetActorRef()
  YukoRef.MoveTo(Alias_YukoReturnStartMarker.GetRef(), 0.0, 0.0, 0.0, True, False)
  YukoRef.EvaluatePackage(False)
EndFunction

Function Fragment_Stage_1230_Item_00()
  Game.GetPlayer().RemoveItem(RI05_ImogeneEvidenceSlate as Form, 1, False, None)
EndFunction

Function Fragment_Stage_1300_Item_00()
  Self.SetObjectiveDisplayed(1300, True, False)
EndFunction

Function Fragment_Stage_1305_Item_00()
  Self.SetStage(1300)
  Alias_Yuko.GetActorRef().EvaluatePackage(False)
EndFunction

Function Fragment_Stage_1350_Item_00()
  Self.SetStage(1390)
EndFunction

Function Fragment_Stage_1390_Item_00()
  Self.SetObjectiveCompleted(1300, True)
  Alias_Yuko.GetActorRef().EvaluatePackage(False)
EndFunction
