ScriptName StarbornTempleQuestScript Extends Quest

;-- Structs -----------------------------------------
Struct ArtifactPower
  MiscObject Artifacts
  Spell ArtifactPower
  Bool HasAcquiredArtifact
  Bool HasAcquiredPower
  Bool HasTemplePowerSpawned
  Bool NoTempleSpawn
  LocationAlias TempleName
  Activator EmbeddedArtifact
  Message TempleStarbornName
  String PowerVisionBink = "artifactvision.bk2"
  wwiseevent VisionAudio
EndStruct


;-- Variables ---------------------------------------
starborntemplequestscript:artifactpower[] ArtifactArrayCopy

;-- Properties --------------------------------------
starborntemplequestscript:artifactpower[] Property Playthrough1ArtifactPowers Auto
starborntemplequestscript:artifactpower[] Property currentPlaythroughArtifacts Auto
LocationAlias Property StarbornTempleLocation Auto Const mandatory
ReferenceAlias Property StarbornTemplePowerTrigger Auto Const mandatory
ActorValue Property PlayerUnityTimesEntered Auto Const mandatory
Spell Property ArtifactPower_GrantSpell_Inner_Demon Auto Const mandatory
MiscObject Property Artifact_SIGMA Auto Const mandatory
RefCollectionAlias Property MQ00_ArtifactsHolder Auto Const mandatory
GlobalVariable Property MQUndiscoveredTemples Auto Const mandatory
GlobalVariable Property MQ401_SkipMQ Auto Const mandatory

;-- Functions ---------------------------------------

Event OnQuestInit()
  currentPlaythroughArtifacts = new starborntemplequestscript:artifactpower[0] 
  If Game.GetPlayer().GetValue(PlayerUnityTimesEntered) == 0.0 
    currentPlaythroughArtifacts = Playthrough1ArtifactPowers 
  ElseIf Game.GetPlayer().GetValue(PlayerUnityTimesEntered) > 0.0 
    Self.RandomizeArtifactArray() 
  EndIf 
EndEvent

ObjectReference Function PlaceArtifact(Int ArtifactNumber, ObjectReference ArtifactMarker)
  ObjectReference ArtifactItemPlaced = None 
  If ArtifactNumber >= 0 && ArtifactNumber < currentPlaythroughArtifacts.Length 
    ArtifactItemPlaced = ArtifactMarker.PlaceAtMe(currentPlaythroughArtifacts[ArtifactNumber].Artifacts as Form, 1, False, True, False, None, None, True) 
    MQ00_ArtifactsHolder.AddRef(ArtifactItemPlaced) 
    Return ArtifactItemPlaced 
  EndIf 
EndFunction

ObjectReference Function PlaceEmbeddedArtifact(Int ArtifactNumber, ObjectReference ActivatorREF)
  ObjectReference ArtifactEmbeddedPlaced = None 
  If ArtifactNumber >= 0 && ArtifactNumber < currentPlaythroughArtifacts.Length 
    ArtifactEmbeddedPlaced = ActivatorREF.PlaceAtMe(currentPlaythroughArtifacts[ArtifactNumber].EmbeddedArtifact as Form, 1, False, False, False, None, None, True) 
    ActivatorREF.DisableNoWait(False) 
    Return ArtifactEmbeddedPlaced 
  EndIf 
EndFunction

ObjectReference Function PlaceArtifactAndAttach(Int ArtifactNumber, ObjectReference ArtifactMarker, ObjectReference akAttachRef)
  ObjectReference ArtifactItemPlaced = None 
  If ArtifactNumber >= 0 && ArtifactNumber < currentPlaythroughArtifacts.Length 
    ArtifactItemPlaced = ArtifactMarker.PlaceAtMe(currentPlaythroughArtifacts[ArtifactNumber].Artifacts as Form, 1, False, True, False, None, None, True) 
    ArtifactItemPlaced.AttachTo(akAttachRef) 
    Return ArtifactItemPlaced 
  EndIf 
EndFunction

Int Function CheckPlayerArtifactForPower()
  Int currentElement = 0 
  Int ArtifactNumberFound = -1 
  While currentElement < currentPlaythroughArtifacts.Length 
    Bool currentHasAcquiredArtifact = currentPlaythroughArtifacts[currentElement].HasAcquiredArtifact 
    Bool currentHasAcquiredPower = currentPlaythroughArtifacts[currentElement].HasAcquiredPower 
    Bool currentHasTemplePowerSpawned = currentPlaythroughArtifacts[currentElement].HasTemplePowerSpawned 
    Bool currentNoTempleSpawn = currentPlaythroughArtifacts[currentElement].NoTempleSpawn 
    If currentHasAcquiredArtifact == True && currentHasAcquiredPower == False && currentHasTemplePowerSpawned == False 
      If currentNoTempleSpawn == False || MQ401_SkipMQ.GetValueInt() >= 1 
        ArtifactNumberFound = currentElement 
        Return ArtifactNumberFound 
      EndIf 
    EndIf 
    currentElement += 1 
  EndWhile 
  Return ArtifactNumberFound 
EndFunction

Function SetPlayerAcquiredPower(Int ArtifactNumber)
  currentPlaythroughArtifacts[ArtifactNumber].HasAcquiredPower = True 
  Int iTemples = MQUndiscoveredTemples.GetValueInt() 
  MQUndiscoveredTemples.SetValue((iTemples - 1) as Float) 
  If MQUndiscoveredTemples.GetValueInt() < 0 
    MQUndiscoveredTemples.SetValueInt(0) 
  EndIf 
EndFunction

Function SetPlayerFoundTemple(Int ArtifactNumber)
  currentPlaythroughArtifacts[ArtifactNumber].HasTemplePowerSpawned = True 
EndFunction

Int Function FindSigmaArtifactBarrett()
  Int currentElement = 0 
  Int ArtifactNumberFound = -1 
  While currentElement < currentPlaythroughArtifacts.Length 
    MiscObject currentArtifact = currentPlaythroughArtifacts[currentElement].Artifacts 
    If currentArtifact == Artifact_SIGMA 
      ArtifactNumberFound = currentElement 
      Return ArtifactNumberFound 
    EndIf 
    currentElement += 1 
  EndWhile 
  Return ArtifactNumberFound 
EndFunction

Function SetPlayerAcquiredArtifact(Int ArtifactNumber)
  If ArtifactNumber >= 0 && ArtifactNumber < currentPlaythroughArtifacts.Length 
    ; SFCP Fix - we only want to do an update here is HasAcquiredArtifact is false, otherwise the undiscovered temples count will be wrong.
    If currentPlaythroughArtifacts[ArtifactNumber].HasAcquiredArtifact == False 
		currentPlaythroughArtifacts[ArtifactNumber].HasAcquiredArtifact = True
		Int iTemples = MQUndiscoveredTemples.GetValueInt() 
		MQUndiscoveredTemples.SetValue((iTemples + 1) as Float) 
	EndIf
  EndIf 
EndFunction

Function RandomizeArtifactArray()
  ArtifactArrayCopy = Playthrough1ArtifactPowers 
  currentPlaythroughArtifacts.add(ArtifactArrayCopy[0], 1) 
  currentPlaythroughArtifacts.add(ArtifactArrayCopy[1], 1) 
  currentPlaythroughArtifacts.add(ArtifactArrayCopy[2], 1) 
  ArtifactArrayCopy.remove(2, 1) 
  ArtifactArrayCopy.remove(1, 1) 
  ArtifactArrayCopy.remove(0, 1) 
  Int randomArrayIndex = 0 
  starborntemplequestscript:artifactpower currentArtifactPower = None 
  While ArtifactArrayCopy.Length > 0 
    randomArrayIndex = Utility.RandomInt(0, ArtifactArrayCopy.Length - 1) 
    currentArtifactPower = ArtifactArrayCopy[randomArrayIndex] 
    currentPlaythroughArtifacts.add(currentArtifactPower, 1) 
    ArtifactArrayCopy.remove(randomArrayIndex, 1) 
  EndWhile 
EndFunction

Debug Function DebugSetArtifactPowers()
  Self.SetArtifactAndPower(4, Game.GetPlayer().GetCurrentLocation()) 
EndFunction

Function SetArtifactAndPower(Int iArtifact, Location TempleLocation)
  currentPlaythroughArtifacts[iArtifact].TempleName.ForceLocationTo(TempleLocation) 
  currentPlaythroughArtifacts[iArtifact].HasTemplePowerSpawned = True 
  StarbornTempleLocation.ForceLocationTo(TempleLocation) 
  StarbornTemplePowerTrigger.RefillAlias() 
  Spell myPower = currentPlaythroughArtifacts[iArtifact].ArtifactPower 
  sbpowercollectionactivatorscript PowerTriggerREF = StarbornTemplePowerTrigger.GetRef() as sbpowercollectionactivatorscript 
  String myPowerVisionBink = currentPlaythroughArtifacts[iArtifact].PowerVisionBink 
  wwiseevent myVisionAudio = currentPlaythroughArtifacts[iArtifact].VisionAudio 
  PowerTriggerREF.UpdatePowerProperties(myPower, myPowerVisionBink, myVisionAudio) 
EndFunction

Function RenameTempleStarborn(Int iArtifact, Actor akStarborn)
  akStarborn.SetOverrideName(currentPlaythroughArtifacts[iArtifact].TempleStarbornName) 
EndFunction

; SFCP Fix - this is called by the SFCP Migration script to fix the temples count without requiring the player to enter NG+
Int Function RecountUndiscoveredLocations()
  Int iUndiscoveredTemplesCurrent = MQUndiscoveredTemples.GetValue() as Int
  Debug.Trace("SFCP - Recounting undiscovered temples on StarbornTempleQuestScript. Current total: "+ iUndiscoveredTemplesCurrent, 0)
  Int iUndiscoveredTemplesResult = 0
  Int iTotalTemples = currentPlaythroughArtifacts.Length
  Int iIterator = 0
  while iIterator < iTotalTemples
    if (currentPlaythroughArtifacts[iIterator].HasAcquiredArtifact == TRUE && currentPlaythroughArtifacts[iIterator].HasAcquiredPower == FALSE)
      iUndiscoveredTemplesResult += 1
    endif
    iIterator += 1
  endWhile
  if (iUndiscoveredTemplesCurrent != iUndiscoveredTemplesResult)
    Debug.Trace("SFCP - Updating undiscovered temple count. New total: "+ iUndiscoveredTemplesCurrent, 0)
    MQUndiscoveredTemples.SetValue((iUndiscoveredTemplesResult) as Float)
  endif
  return (iUndiscoveredTemplesResult - iUndiscoveredTemplesCurrent)
EndFunction