ScriptName SFCP:UpdateHandler extends Quest

;-- Properties --------------------------------------
GlobalVariable Property SFCP_Version_Major Auto Const
{ Major SFCP Version }
GlobalVariable Property SFCP_Version_Minor Auto Const
{ Minor SFCP Version }
GlobalVariable Property SFCP_Version_Patch Auto Const
{ Patch SFCP Version }
ConditionForm Property SFCP_CND_AllResearchCompleted Auto Const
{ Has the player completed all current research projects }

;-- Variables  --------------------------------------
string sCurrentVersion = ""
; What is the last saved version we have seen? 
bool b001UndiscoveredTemplesFix = false
; https://www.starfieldpatch.dev/issues/231
bool b001CoraCoeFix = false
; https://www.starfieldpatch.dev/issues/369
bool b001CoeEstateFix = false
; https://www.starfieldpatch.dev/issues/370
bool b005HadrianFactionFix = false
; https://www.starfieldpatch.dev/issues/669
bool b005ResearchTutorialFix = false
; https://www.starfieldpatch.dev/issues/725

;-- Functions ---------------------------------------

Event OnQuestInit()
    ; When the quest starts up for the very first time, we need to check for updates.
    Self.CheckForUpdates()
EndEvent

Function CheckForUpdates()
    String runningVersion = SFCP_Version_Major.GetValue() as Int+"."+SFCP_Version_Minor.GetValue() as Int+"."+SFCP_Version_Patch.GetValue() as Int
    SFCPUtil.WriteLog("Patch initialised, version: "+runningVersion)
    if (sCurrentVersion == "" || sCurrentVersion != runningVersion)
        SFCPUtil.WriteLog("Updating Starfield Community Patch. Current version: "+runningVersion+". Last Version: "+sCurrentVersion)
        Self.ApplyMissingFixes(runningVersion)
    Else
        SFCPUtil.WriteLog("No updates required. Current version: "+runningVersion+". Last Version: "+sCurrentVersion)
    endIf
    ; Save the version string between game loads for comparison later.
    sCurrentVersion = runningVersion
EndFunction

Function ApplyMissingFixes(string sNewVersion)
    int major = SFCP_Version_Major.GetValue() as Int
    int minor = SFCP_Version_Minor.GetValue() as Int
    int patch = SFCP_Version_Patch.GetValue() as Int

    ; Get NG+ count as this will be reused. 
    int iTimesEnteredUnity = GetTimesEnteredUnity()

    ; Fix for https://www.starfieldpatch.dev/issues/231
    if (!b001UndiscoveredTemplesFix || (CurrentVersionGTE(0,0,1)))
        SFCPUtil.WriteLog("Recounting undiscovered temples")
        StarbornTempleQuestScript templeManager = Game.GetForm(0x00214707) as StarbornTempleQuestScript
        int iDifference = templeManager.RecountUndiscoveredLocations()
        if (iDifference != 0) 
            SFCPUtil.WriteLog("Fixed undiscovered temples. Count adjusted by "+iDifference)
        else
            SFCPUtil.WriteLog("Undiscovered temples are correct. Fix skipped.")
        endif
        b001UndiscoveredTemplesFix = True
    endif

    ; Fix for https://github.com/Starfield-Community-Patch/Starfield-Community-Patch/issues/369
    if (!b001CoraCoeFix || (CurrentVersionGTE(0,0,1)))
        Quest CREW_EliteCrewCoraCoe = Game.GetForm(0x00187BF1) as Quest
        if (iTimesEnteredUnity > 0 && !CREW_EliteCrewCoraCoe.IsRunning())
            SFCPUtil.WriteLog("Starting Cora Coe crew quest")
            CREW_EliteCrewCoraCoe.Start()
        else 
            SFCPUtil.WriteLog("Cora Coe crew quest does not need to be manually started. Skipping Fix.")
        endif
        b001CoraCoeFix = True
    endif

    ; Fix for https://github.com/Starfield-Community-Patch/Starfield-Community-Patch/issues/370
    if (!b001CoeEstateFix || (CurrentVersionGTE(0,0,1)))
        ObjectReference CoeEstateFrontDoorREF = Game.GetForm(0x002FC83E) as ObjectReference
        GlobalVariable MQ401_SkipMQ = Game.GetForm(0x0017E006) as GlobalVariable
        ; Check if the player has entered Unity and if the doors are locked after skipping the main quest
        if (iTimesEnteredUnity > 0 && CoeEstateFrontDoorREF.IsLocked() && MQ401_SkipMQ.GetValue() as Int == 1)
            SFCPUtil.WriteLog("Unlocking Coe Estate doors")
            ObjectReference CoeEstateBalconyDoorREF = Game.GetForm(0x002D044F) as ObjectReference
            ObjectReference CoeEstateFirstFloorDoorREF = Game.GetForm(0x002FC753) as ObjectReference
            ObjectReference CoeEstateFirstFloorDoorTwo = Game.GetForm(0x002D0418) as ObjectReference
            Faction CoeEstateDoorFaction = Game.GetForm(0x001260C3) as Faction
            ; Make the changes
            CoeEstateBalconyDoorREF.Lock(False, False, True)
            CoeEstateFrontDoorREF.Lock(False, False, True)
            CoeEstateFirstFloorDoorREF.Lock(False, False, True)
            CoeEstateFirstFloorDoorTwo.Lock(False, False, True)
            Game.GetPlayer().AddToFaction(CoeEstateDoorFaction)
        else
            SFCPUtil.WriteLog("Coe Estate doors do not require unlocking.")
        endif
        b001CoeEstateFix = True
    endif

    ; Fix for https://www.starfieldpatch.dev/issues/669
    if (!b005HadrianFactionFix || (CurrentVersionGTE(0,0,5)))
        SFCPUtil.WriteLog("Fixing Hadrian's faction assignments")
        Actor Crew_Elite_Hadrian = Game.GetFormFromFile(0x002B17C4, "Starfield.esm") as Actor
        Faction ConstellationFaction  = Game.GetFormFromFile(0x000191DC, "Starfield.esm") as Faction
        Faction CrimeFactionUC = Game.GetFormFromFile(0x0005BD93, "Starfield.esm") as Faction
        Crew_Elite_Hadrian.RemoveFromfaction(ConstellationFaction)
        Crew_Elite_Hadrian.AddToFaction(CrimeFactionUC)
        b005HadrianFactionFix = true
    endif

    ; Fix for https://www.starfieldpatch.dev/issues/725
    if (!b005ResearchTutorialFix || (CurrentVersionGTE(0,0,5)))
        Quest MQ_TutorialQuest_Misc06 = Game.GetForm(0x0000118F) as Quest
        if (MQ_TutorialQuest_Misc06.IsObjectiveDisplayed(10) && SFCP_CND_AllResearchCompleted.IsTrue(NONE, NONE))
            SFCPUtil.WriteLog("Shutting down research tutorial quest")
            MQ_TutorialQuest_Misc06.SetStage(100)
        endif
        b005ResearchTutorialFix = true
    endif

EndFunction

int Function GetTimesEnteredUnity()
    Actor player = Game.GetPlayer()
    ActorValue PlayerUnityTimesEntered = Game.GetForm(0x00219529) as ActorValue
    return player.GetValue(PlayerUnityTimesEntered) as Int
EndFunction

; The current version is greater than or equal to the fix version
bool Function CurrentVersionGTE(int newMajor, int newMinor, int newPatch)
    int major = SFCP_Version_Major.GetValue() as Int
    int minor = SFCP_Version_Minor.GetValue() as Int
    int patch = SFCP_Version_Patch.GetValue() as Int
    
    if (major >= newMajor) ;e.g. 2.0.0 > 1.0.0
        return true
    elseif (major == newMajor && minor >= newMinor) ; e.g. 1.1.0 > 1.0.1
        return true
    elseif (major == newMajor && minor == newMinor && patch >= newPatch) ; e.g. 0.0.2 > 0.0.1
        return true
    else
        return false
    endif

EndFunction
