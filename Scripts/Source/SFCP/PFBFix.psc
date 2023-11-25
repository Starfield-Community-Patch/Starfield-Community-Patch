Scriptname SFCP:PFBFix extends Quest

Struct PowerFromBeyondQuestData
    LocationAlias AnomalyLocation
    ReferenceAlias AnomalyMapMarker
    Quest Mission
    LocationAlias PlanetFallback
    LocationAlias PlanetUnexploredTrait
    LocationAlias PlanetUnexploredTraitClose
    LocationAlias PlanetWithTrait
    LocationAlias TargetSystemLocation
    LocationAlias TempleLocation
    ReferenceAlias TempleMapMarker
EndStruct

Group FixData
    Quest Property SFCP_MQ_TempleQuest_Fix Auto
    LocationAlias Property New_PlanetWithTrait Auto
    LocationAlias Property New_AnomalyLocation Auto
    ReferenceAlias Property New_AnomalyMapMarker Auto
    LocationAlias Property New_TargetSystemLocation Auto
    LocationAlias Property New_TempleLocation Auto
    ReferenceAlias Property New_TempleMapMarker Auto
    LocationAlias Property BackupPlanet Auto
EndGroup

Keyword Property SFCPowerFromBeyondFix Auto
Keyword Property MQTempleQuestActive Auto
FormList Property SFCP_PowerFromBeyondInvalidPlanets Auto
SFCP:PFBFix:PowerFromBeyondQuestData[] Property QuestsToFix Auto
{An array of Power From Beyond quests to look at fixing}
MQ_Temple_Subscript Property MQ_TempleSubscript Auto
Quest Property StarbornTempleQuest Auto

; int iStartAlias = 6
; int iEndAlias = 28

Event OnQuestStarted()
    Debug.Messagebox("OnInit for PFBFix "+QuestsToFix.Length)
    ; Check existing planets
    starborntemplequestscript sbt = (StarbornTempleQuest as starborntemplequestscript)
    starborntemplequestscript:artifactpower[] currentPlaythroughArtifacts = sbt.currentPlaythroughArtifacts
    int i = 0
    while (i < currentPlaythroughArtifacts.length)
        starborntemplequestscript:artifactpower artifactData = currentPlaythroughArtifacts[i]
        Location loc = artifactData.TempleName.GetLocation()
        if (loc != NONE)
            Location planetLoc = loc.GetCurrentPlanet().GetLocation()
            SFCPUtil.WriteLog("Excluding planet from artifact ID "+i+": "+planetLoc)
            SFCP_PowerFromBeyondInvalidPlanets.AddForm(planetLoc)
        else
            SFCPUtil.WriteLog("No planet for artifact ID "+i)
        endif
        i += 1
    endwhile

    ; Apply fixes
    int idx = 0
    while (idx < QuestsToFix.length)
        ResetFixQuest()
        SFCP:PFBFix:PowerFromBeyondQuestData entry = QuestsToFix[idx]
        Debug.MessageBox("Attempting fix "+entry.Mission)
        if (CheckAndFixQuest(entry))
            Debug.MessageBox("Fix complete "+entry.Mission)
        else
            ; Failed, we should probably shut down the broken quest?
            Debug.MessageBox("Fix failed! "+entry.Mission)
        endif
        idx += 1
    endwhile
    SFCP_PowerFromBeyondInvalidPlanets.Revert()
EndEvent

Function ResetFixQuest()
    SFCP_MQ_TempleQuest_Fix.Reset()
    SFCP_MQ_TempleQuest_Fix.Stop()
    Utility.WaitMenuPause(0.1)
    SFCPUtil.WriteLog("Reset fixer quest", 0)
EndFunction

Bool Function CheckAndFixQuest(SFCP:PFBFix:PowerFromBeyondQuestData data)
    if (!data.Mission.isRunning())
        SFCPUtil.WriteLog("Quest not running. No fix needed "+data.Mission, 0)
        return true
    EndIf

    ; The Quest is running so we should check if the fix is needed.
    ReferenceAlias Alias_MapMarker = data.AnomalyMapMarker
    ReferenceAlias TempleMapMarker = data.TempleMapMarker
    if (Alias_MapMarker.GetReference() != NONE && TempleMapMarker.GetReference() != NONE) 
        SFCPUtil.WriteLog("Anomaly/Temple Markers are present. No fix needed "+Alias_MapMarker.GetReference(), 0)
        return true
    endif

    SFCPUtil.WriteLog("Applying fix for Power From Beyond "+data.Mission+" "+data.PlanetWithTrait, 1)

    ; Decide which planet(s) to check
    LocationAlias Selected = data.PlanetWithTrait
    LocationAlias Option1 = data.PlanetUnexploredTraitClose
    LocationAlias Option2 = data.PlanetUnexploredTrait
    LocationAlias Option3 = data.PlanetFallback
    ; Try the Option 2
    SFCPUtil.WriteLog("(Attempt 1) "+Option2.GetLocation(), 1)
    if (Option2.GetLocation() != NONE && !SFCP_PowerFromBeyondInvalidPlanets.HasForm(Option2.GetLocation()) && SendEventAndCheck(Option2.GetLocation(), data))
        SFCPUtil.WriteLog("Fix applied successfully to Power From Beyond (Attempt 1) "+data.Mission, 1)
        return true
    endif
    ; Try Option 3
    SFCPUtil.WriteLog("(Attempt 2) "+Option3.GetLocation(), 1)
    ResetFixQuest()
    if (Option3.GetLocation() != NONE && !SFCP_PowerFromBeyondInvalidPlanets.HasForm(Option3.GetLocation()) &&  SendEventAndCheck(Option3.GetLocation(), data))
        SFCPUtil.WriteLog("Fix applied successfully to Power From Beyond (Attempt 2) "+data.Mission, 1)
        return true
    endif
    
    ; Try with the backup planet from the newly started quest
    SFCPUtil.WriteLog("(Attempt 3 (Fallback)) - Checking multiple planets", 1)
    if (!SFCP_MQ_TempleQuest_Fix.IsRunning())
        if (!SFCPowerFromBeyondFix.SendStoryEventAndWait(NONE, NONE, NONE, 0, 0))
            SFCPUtil.WriteLog("Failed to boot the fixer quest for the final attempt", 2)
        endif
    endif
    if (CheckAndInvalidatePlanets(data))
        SFCPUtil.WriteLog("Fix applied successfully to Power From Beyond "+data.Mission, 1) 
        return true
    else
        SFCPUtil.WriteLog("Fix for Power From Beyond failed. Fallback aliases are also invalid planets. "+data.Mission, 1) 
        return false
    endif
EndFunction

; A final fallback for Planet check, keep trying to find a valid planet and add it to the invalid list each time it fails
Bool Function CheckAndInvalidatePlanets(SFCP:PFBFix:PowerFromBeyondQuestData data)  
    int iAttempts = 3
    Location validLocation = NONE
    bool bKeepTrying = true
    while (validLocation == NONE && bKeepTrying)
        Location backup = BackupPlanet.GetLocation()
        SFCPUtil.WriteLog("Checking planet: "+backup+". Attempt "+iAttempts, 1)
        ResetFixQuest()
        if (backup != NONE && !SFCP_PowerFromBeyondInvalidPlanets.HasForm(backup) && SendEventAndCheck(backup, data))
            SFCPUtil.WriteLog("Found a valid planet! "+backup+". Attempt "+iAttempts, 1)
            validLocation = backup
        elseif (backup == NONE)
            SFCPUtil.WriteLog("Run out of planets to check. Total checked: "+SFCP_PowerFromBeyondInvalidPlanets.GetSize()+". Attempt "+iAttempts, 1)
            bKeepTrying = false
        else 
            SFCPUtil.WriteLog("Invalid location marked invalid: "+backup+". Attempt "+iAttempts, 1)
            iAttempts += 1 
            SFCP_PowerFromBeyondInvalidPlanets.AddForm(backup)
        endif    
    endwhile

    if (validLocation != NONE)
        return true
    else
        return false
    endif
EndFunction

Bool Function SendEventAndCheck(Location newPlanet, SFCP:PFBFix:PowerFromBeyondQuestData data)
    if (SFCPowerFromBeyondFix.SendStoryEventAndWait(newPlanet, NONE, NONE, 0, 0))
        if (SFCP_MQ_TempleQuest_Fix.IsRunning())
            if (\
                New_AnomalyLocation.GetLocation() != NONE \
                && New_AnomalyMapMarker.GetReference() != NONE \
                && New_PlanetWithTrait.GetLocation() != NONE \
                && New_TargetSystemLocation.GetLocation() != NONE )
                ; && New_TempleLocation.GetLocation() != NONE \
                ; && New_TempleMapMarker.GetReference() != NONE\
                ; )
                data.PlanetWithTrait.ForceLocationTo(newPlanet)
                data.AnomalyLocation.ForceLocationTo(New_AnomalyLocation.GetLocation())
                data.AnomalyMapMarker.ForceRefTo(New_AnomalyMapMarker.GetReference())
                MQ_TempleSubscript.SetMapMarkerFlags(New_AnomalyMapMarker.GetReference())
                data.TargetSystemLocation.ForceLocationTo(New_TargetSystemLocation.GetLocation())
                data.TempleLocation.ForceLocationTo(New_TempleLocation.GetLocation())
                data.TempleMapMarker.ForceRefTo(New_TempleMapMarker.GetReference())
                if (data.Mission.IsObjectiveDisplayed(10))
                    ; Hide the objective in the UI
                    data.Mission.SetObjectiveDisplayed(10, false, true)
                    ; Show the objective again to update to text
                    data.Mission.SetObjectiveDisplayed(10, true, true)
                endif
                return true
            else
                SFCPUtil.WriteLog("Failed to fill. New Location: "+newPlanet, 1)
                SFCPUtil.WriteLog("Failed to fill. New Anomaly Location: "+New_AnomalyLocation.GetLocation(), 1)
                SFCPUtil.WriteLog("Failed to fill. New Anomaly Map Marker: "+New_AnomalyMapMarker.GetReference(), 1)
                SFCPUtil.WriteLog("Failed to fill. New Target System Location: "+New_TargetSystemLocation.GetLocation(), 1)
                SFCPUtil.WriteLog("Failed to fill. New Temple Location: "+New_TempleLocation.GetLocation(), 1)
                SFCPUtil.WriteLog("Failed to fill. New Temple Map Marker: "+New_TempleMapMarker.GetReference(), 1)
                return false
            endif

        else 
            SFCPUtil.WriteLog("SFCPPowerFromBeyondFix did not start", 1)
            return false
        endif
    else
        SFCPUtil.WriteLog("No quest started from script event", 1)
        return false
    endif
EndFunction
