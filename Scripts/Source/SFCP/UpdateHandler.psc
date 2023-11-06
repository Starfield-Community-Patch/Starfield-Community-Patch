ScriptName SFCP:UpdateHandler extends Quest

;-- Properties --------------------------------------
GlobalVariable Property SFCP_Version_Major Auto Const
{ Major SFCP Version }
GlobalVariable Property SFCP_Version_Minor Auto Const
{ Minor SFCP Version }
GlobalVariable Property SFCP_Version_Patch Auto Const
{ Patch SFCP Version }

;-- Variables  --------------------------------------
string sCurrentVersion = ""
; What is the last saved version we have seen? 
bool b001UndiscoveredTemplesFix = false
; https://www.starfieldpatch.dev/issues/231 [00214707]

;-- Functions ---------------------------------------

Event OnInit()
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

    ; Fix for https://www.starfieldpatch.dev/issues/231
    if (!b001UndiscoveredTemplesFix || (CurrentVersionGTE(0,0,1) ))
        SFCPUtil.WriteLog("Recounting undiscovered temples")
        StarbornTempleQuestScript templeManager = Game.GetForm(0x00214707) as StarbornTempleQuestScript
        int iDifference = templeManager.RecountUndiscoveredLocations()
        if (iDifference != 0) 
            SFCPUtil.WriteLog("Fixed undiscovered temples. Count adjusted by "+iDifference)
        else
            SFCPUtil.WriteLog("Undiscovered temples are correct. Fix skipped.")
        endif
        b001UndiscoveredTemplesFix = true
    endif
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