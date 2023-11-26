Scriptname SFCP:PFBFix extends Quest

Struct PowerFromBeyondQuestData
    LocationAlias AnomalyLocation
    ReferenceAlias AnomalyMapMarker
    Quest Mission
    LocationAlias PlanetFallback ; Not always present
    LocationAlias PlanetUnexploredTrait
    LocationAlias PlanetUnexploredTraitClose ; Not always present
    LocationAlias PlanetWithTrait
    LocationAlias TargetSystemLocation
EndStruct

Group FixData
    Quest Property SFCP_MQ_TempleQuest_Fix Auto
    LocationAlias Property New_PlanetWithTrait Auto
    LocationAlias Property New_AnomalyLocation Auto
    ReferenceAlias Property New_AnomalyMapMarker Auto
    LocationAlias Property New_TargetSystemLocation Auto
    LocationAlias Property BackupPlanet Auto
EndGroup

Keyword Property SFCPowerFromBeyondFix Auto
Keyword Property MQTempleQuestActive Auto
FormList Property SFCP_PowerFromBeyondInvalidPlanets Auto
SFCP:PFBFix:PowerFromBeyondQuestData[] Property QuestsToFix Auto
{An array of Power From Beyond quests to look at fixing}
Quest Property StarbornTempleQuest Auto
Message Property SFCP_PowerFromBeyondFixPlanetReassigned Auto
Message Property SFCP_PowerFromBeyondFixDone Auto
LocationAlias Property FixedPlanet Auto
LocationAlias Property InvalidPlanet Auto

Event OnQuestStarted()
    SFCPUtil.WriteLog("----- Power from Beyond fix starting -----")
    ; Check existing planets
    starborntemplequestscript sbt = (StarbornTempleQuest as starborntemplequestscript)
    starborntemplequestscript:artifactpower[] currentPlaythroughArtifacts = sbt.currentPlaythroughArtifacts
    int i = 0
    while (i < currentPlaythroughArtifacts.length)
        ; Get the array of artifacts in the active playthrough
        starborntemplequestscript:artifactpower artifactData = currentPlaythroughArtifacts[i]
        ; Get the Temple Location (if it is filled)
        Location loc = artifactData.TempleName.GetLocation()
        if (loc != NONE)
            ; Resolve the planet that the temple is on. 
            Location planetLoc = loc.GetCurrentPlanet().GetLocation()
            ; SFCPUtil.WriteLog("Excluding planet from artifact ID "+i+": "+planetLoc)
            ; Add it to the exclusion list
            SFCP_PowerFromBeyondInvalidPlanets.AddForm(planetLoc)
        else
            ; No temple location yet (undiscovered)
            ; SFCPUtil.WriteLog("No planet for artifact ID "+i)
        endif
        i += 1
    endwhile

    SFCPUtil.WriteLog("Excluding locations of existing temples, total: "+SFCP_PowerFromBeyondInvalidPlanets.GetSize())

    ; Apply fixes
    int idx = 0
    SFCPUtil.WriteLog("Checking Power from Beyond Quests "+QuestsToFix.length)
    while (idx < QuestsToFix.length)
        ; Stop the fix quest if it's currently running.
        ResetFixQuest()
        SFCP:PFBFix:PowerFromBeyondQuestData entry = QuestsToFix[idx]
        ; SFCPUtil.WriteLog("Checking status "+entry.Mission)
        if (CheckAndFixQuest(entry))
            ; SFCPUtil.WriteLog("Fix complete "+entry.Mission)
        else
            ; Failed, we should probably shut down the broken quest?
            Debug.MessageBox("Fix failed for quest at index "+idx)
        endif
        InvalidPlanet.Clear()
        FixedPlanet.Clear()
        idx += 1
    endwhile
    SFCP_PowerFromBeyondInvalidPlanets.Revert()
    SFCPUtil.WriteLog("----- Power from Beyond fix completed -----")
    SFCP_PowerFromBeyondFixDone.Show(0,0,0,0,0,0,0,0,0)
    Self.Stop()
EndEvent

Function ResetFixQuest()
    SFCP_MQ_TempleQuest_Fix.Reset()
    SFCP_MQ_TempleQuest_Fix.Stop()
    Utility.WaitMenuPause(0.1)
    ; SFCPUtil.WriteLog("Reset fixer quest", 0)
EndFunction

Bool Function CheckAndFixQuest(SFCP:PFBFix:PowerFromBeyondQuestData data)
    if (!data.Mission.isRunning())
        SFCPUtil.WriteLog("Quest not running. No fix needed "+data.Mission, 0)
        return true
    EndIf

    ; The Quest is running so we should check if the fix is needed.
    ReferenceAlias Alias_MapMarker = data.AnomalyMapMarker
    if (Alias_MapMarker.GetReference() != NONE) 
        SFCPUtil.WriteLog("Anomaly Marker is present. No fix needed "+Alias_MapMarker.GetReference(), 0)
        return true
    endif

    SFCPUtil.WriteLog("Applying fix for Power From Beyond "+data.Mission+" "+data.PlanetWithTrait, 1)

    ; Decide which planet(s) to check
    LocationAlias Selected = data.PlanetWithTrait
    InvalidPlanet.ForceLocationTo(Selected.GetLocation())
    LocationAlias Option1 = data.PlanetFallback ; Not on all quests
    ; Try the Option 1
    ; SFCPUtil.WriteLog("(Attempt 1) "+Option2.GetLocation(), 1)
    if (Option1 != NONE && Option1.GetLocation() != NONE && !SFCP_PowerFromBeyondInvalidPlanets.HasForm(Option1.GetLocation()) && SendEventAndCheck(Option1.GetLocation(), data))
        SFCPUtil.WriteLog("Fix applied successfully to Power From Beyond (Attempt 1) "+data.Mission, 1)
        return true
    endif

    ResetFixQuest()
    ; Try with the backup planet from the newly started quest
    ; SFCPUtil.WriteLog("(Attempting Fallback) - Checking multiple planets", 1)
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
    int iAttempts = 1
    Location validLocation = NONE
    bool bKeepTrying = true
    while (validLocation == NONE && bKeepTrying)
        Location backup = BackupPlanet.GetLocation()
        ; SFCPUtil.WriteLog("Checking planet: "+backup+". Attempt "+iAttempts, 1)
        ResetFixQuest()
        if (backup != NONE && !SFCP_PowerFromBeyondInvalidPlanets.HasForm(backup) && SendEventAndCheck(backup, data))
            FixedPlanet.ForceLocationTo(backup)
            SFCPUtil.WriteLog("Found a valid planet! "+backup+". Attempt "+iAttempts, 1)
            SFCP_PowerFromBeyondFixPlanetReassigned.Show(0, 0, 0, 0, 0, 0, 0, 0, 0)
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
                && New_TargetSystemLocation.GetLocation() != NONE \
                )
                ; Update the planet location
                data.PlanetWithTrait.ForceLocationTo(newPlanet)
                ; Update the AnomalyLocation
                data.AnomalyLocation.ForceLocationTo(New_AnomalyLocation.GetLocation())
                ; Update the AnomalyMapMarker
                data.AnomalyMapMarker.ForceRefTo(New_AnomalyMapMarker.GetReference())
                ; Set the map marker as visible
                (data.mission as MQ_Temple_Subscript).SetMapMarkerFlags(New_AnomalyMapMarker.GetReference())
                ; Update the target system
                data.TargetSystemLocation.ForceLocationTo(New_TargetSystemLocation.GetLocation())

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
