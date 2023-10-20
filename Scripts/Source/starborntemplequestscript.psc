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
  currentPlaythroughArtifacts = new starborntemplequestscript:artifactpower[0] ; #DEBUG_LINE_NO:35
  If Game.GetPlayer().GetValue(PlayerUnityTimesEntered) == 0.0 ; #DEBUG_LINE_NO:37
    currentPlaythroughArtifacts = Playthrough1ArtifactPowers ; #DEBUG_LINE_NO:38
  ElseIf Game.GetPlayer().GetValue(PlayerUnityTimesEntered) > 0.0 ; #DEBUG_LINE_NO:40
    Self.RandomizeArtifactArray() ; #DEBUG_LINE_NO:42
  EndIf ; #DEBUG_LINE_NO:
EndEvent

ObjectReference Function PlaceArtifact(Int ArtifactNumber, ObjectReference ArtifactMarker)
  ObjectReference ArtifactItemPlaced = None ; #DEBUG_LINE_NO:50
  If ArtifactNumber >= 0 && ArtifactNumber < currentPlaythroughArtifacts.Length ; #DEBUG_LINE_NO:51
    ArtifactItemPlaced = ArtifactMarker.PlaceAtMe(currentPlaythroughArtifacts[ArtifactNumber].Artifacts as Form, 1, False, True, False, None, None, True) ; #DEBUG_LINE_NO:52
    MQ00_ArtifactsHolder.AddRef(ArtifactItemPlaced) ; #DEBUG_LINE_NO:53
    Return ArtifactItemPlaced ; #DEBUG_LINE_NO:54
  EndIf ; #DEBUG_LINE_NO:
EndFunction

ObjectReference Function PlaceEmbeddedArtifact(Int ArtifactNumber, ObjectReference ActivatorREF)
  ObjectReference ArtifactEmbeddedPlaced = None ; #DEBUG_LINE_NO:62
  If ArtifactNumber >= 0 && ArtifactNumber < currentPlaythroughArtifacts.Length ; #DEBUG_LINE_NO:63
    ArtifactEmbeddedPlaced = ActivatorREF.PlaceAtMe(currentPlaythroughArtifacts[ArtifactNumber].EmbeddedArtifact as Form, 1, False, False, False, None, None, True) ; #DEBUG_LINE_NO:64
    ActivatorREF.DisableNoWait(False) ; #DEBUG_LINE_NO:65
    Return ArtifactEmbeddedPlaced ; #DEBUG_LINE_NO:66
  EndIf ; #DEBUG_LINE_NO:
EndFunction

ObjectReference Function PlaceArtifactAndAttach(Int ArtifactNumber, ObjectReference ArtifactMarker, ObjectReference akAttachRef)
  ObjectReference ArtifactItemPlaced = None ; #DEBUG_LINE_NO:76
  If ArtifactNumber >= 0 && ArtifactNumber < currentPlaythroughArtifacts.Length ; #DEBUG_LINE_NO:77
    ArtifactItemPlaced = ArtifactMarker.PlaceAtMe(currentPlaythroughArtifacts[ArtifactNumber].Artifacts as Form, 1, False, True, False, None, None, True) ; #DEBUG_LINE_NO:78
    ArtifactItemPlaced.AttachTo(akAttachRef) ; #DEBUG_LINE_NO:79
    Return ArtifactItemPlaced ; #DEBUG_LINE_NO:80
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Int Function CheckPlayerArtifactForPower()
  Int currentElement = 0 ; #DEBUG_LINE_NO:89
  Int ArtifactNumberFound = -1 ; #DEBUG_LINE_NO:90
  While currentElement < currentPlaythroughArtifacts.Length ; #DEBUG_LINE_NO:91
    Bool currentHasAcquiredArtifact = currentPlaythroughArtifacts[currentElement].HasAcquiredArtifact ; #DEBUG_LINE_NO:92
    Bool currentHasAcquiredPower = currentPlaythroughArtifacts[currentElement].HasAcquiredPower ; #DEBUG_LINE_NO:93
    Bool currentHasTemplePowerSpawned = currentPlaythroughArtifacts[currentElement].HasTemplePowerSpawned ; #DEBUG_LINE_NO:94
    Bool currentNoTempleSpawn = currentPlaythroughArtifacts[currentElement].NoTempleSpawn ; #DEBUG_LINE_NO:95
    If currentHasAcquiredArtifact == True && currentHasAcquiredPower == False && currentHasTemplePowerSpawned == False ; #DEBUG_LINE_NO:97
      If currentNoTempleSpawn == False || MQ401_SkipMQ.GetValueInt() >= 1 ; #DEBUG_LINE_NO:98
        ArtifactNumberFound = currentElement ; #DEBUG_LINE_NO:99
        Return ArtifactNumberFound ; #DEBUG_LINE_NO:100
      EndIf ; #DEBUG_LINE_NO:
    EndIf ; #DEBUG_LINE_NO:
    currentElement += 1 ; #DEBUG_LINE_NO:103
  EndWhile ; #DEBUG_LINE_NO:
  Return ArtifactNumberFound ; #DEBUG_LINE_NO:105
EndFunction

Function SetPlayerAcquiredPower(Int ArtifactNumber)
  currentPlaythroughArtifacts[ArtifactNumber].HasAcquiredPower = True ; #DEBUG_LINE_NO:109
  Int iTemples = MQUndiscoveredTemples.GetValueInt() ; #DEBUG_LINE_NO:110
  MQUndiscoveredTemples.SetValue((iTemples - 1) as Float) ; #DEBUG_LINE_NO:111
  If MQUndiscoveredTemples.GetValueInt() < 0 ; #DEBUG_LINE_NO:112
    MQUndiscoveredTemples.SetValueInt(0) ; #DEBUG_LINE_NO:113
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Function SetPlayerFoundTemple(Int ArtifactNumber)
  currentPlaythroughArtifacts[ArtifactNumber].HasTemplePowerSpawned = True ; #DEBUG_LINE_NO:118
EndFunction

Int Function FindSigmaArtifactBarrett()
  Int currentElement = 0 ; #DEBUG_LINE_NO:123
  Int ArtifactNumberFound = -1 ; #DEBUG_LINE_NO:124
  While currentElement < currentPlaythroughArtifacts.Length ; #DEBUG_LINE_NO:125
    MiscObject currentArtifact = currentPlaythroughArtifacts[currentElement].Artifacts ; #DEBUG_LINE_NO:126
    If currentArtifact == Artifact_SIGMA ; #DEBUG_LINE_NO:128
      ArtifactNumberFound = currentElement ; #DEBUG_LINE_NO:129
      Return ArtifactNumberFound ; #DEBUG_LINE_NO:130
    EndIf ; #DEBUG_LINE_NO:
    currentElement += 1 ; #DEBUG_LINE_NO:132
  EndWhile ; #DEBUG_LINE_NO:
  Return ArtifactNumberFound ; #DEBUG_LINE_NO:134
EndFunction

Function SetPlayerAcquiredArtifact(Int ArtifactNumber)
  If ArtifactNumber >= 0 && ArtifactNumber < currentPlaythroughArtifacts.Length ; #DEBUG_LINE_NO:139
    If currentPlaythroughArtifacts[ArtifactNumber].HasAcquiredArtifact == False ; #DEBUG_LINE_NO:140
		currentPlaythroughArtifacts[ArtifactNumber].HasAcquiredArtifact = True
		Int iTemples = MQUndiscoveredTemples.GetValueInt() ; #DEBUG_LINE_NO:141
		MQUndiscoveredTemples.SetValue((iTemples + 1) as Float) ; #DEBUG_LINE_NO:142
	EndIf
  EndIf ; #DEBUG_LINE_NO:
EndFunction

Function RandomizeArtifactArray()
  ArtifactArrayCopy = Playthrough1ArtifactPowers ; #DEBUG_LINE_NO:151
  currentPlaythroughArtifacts.add(ArtifactArrayCopy[0], 1) ; #DEBUG_LINE_NO:155
  currentPlaythroughArtifacts.add(ArtifactArrayCopy[1], 1) ; #DEBUG_LINE_NO:156
  currentPlaythroughArtifacts.add(ArtifactArrayCopy[2], 1) ; #DEBUG_LINE_NO:157
  ArtifactArrayCopy.remove(2, 1) ; #DEBUG_LINE_NO:158
  ArtifactArrayCopy.remove(1, 1) ; #DEBUG_LINE_NO:159
  ArtifactArrayCopy.remove(0, 1) ; #DEBUG_LINE_NO:160
  Int randomArrayIndex = 0 ; #DEBUG_LINE_NO:162
  starborntemplequestscript:artifactpower currentArtifactPower = None ; #DEBUG_LINE_NO:163
  While ArtifactArrayCopy.Length > 0 ; #DEBUG_LINE_NO:164
    randomArrayIndex = Utility.RandomInt(0, ArtifactArrayCopy.Length - 1) ; #DEBUG_LINE_NO:165
    currentArtifactPower = ArtifactArrayCopy[randomArrayIndex] ; #DEBUG_LINE_NO:166
    currentPlaythroughArtifacts.add(currentArtifactPower, 1) ; #DEBUG_LINE_NO:167
    ArtifactArrayCopy.remove(randomArrayIndex, 1) ; #DEBUG_LINE_NO:168
  EndWhile ; #DEBUG_LINE_NO:
EndFunction

Debug Function DebugSetArtifactPowers()
  Self.SetArtifactAndPower(4, Game.GetPlayer().GetCurrentLocation()) ; #DEBUG_LINE_NO:176
EndFunction

Function SetArtifactAndPower(Int iArtifact, Location TempleLocation)
  currentPlaythroughArtifacts[iArtifact].TempleName.ForceLocationTo(TempleLocation) ; #DEBUG_LINE_NO:182
  currentPlaythroughArtifacts[iArtifact].HasTemplePowerSpawned = True ; #DEBUG_LINE_NO:185
  StarbornTempleLocation.ForceLocationTo(TempleLocation) ; #DEBUG_LINE_NO:188
  StarbornTemplePowerTrigger.RefillAlias() ; #DEBUG_LINE_NO:189
  Spell myPower = currentPlaythroughArtifacts[iArtifact].ArtifactPower ; #DEBUG_LINE_NO:190
  sbpowercollectionactivatorscript PowerTriggerREF = StarbornTemplePowerTrigger.GetRef() as sbpowercollectionactivatorscript ; #DEBUG_LINE_NO:191
  String myPowerVisionBink = currentPlaythroughArtifacts[iArtifact].PowerVisionBink ; #DEBUG_LINE_NO:192
  wwiseevent myVisionAudio = currentPlaythroughArtifacts[iArtifact].VisionAudio ; #DEBUG_LINE_NO:193
  PowerTriggerREF.UpdatePowerProperties(myPower, myPowerVisionBink, myVisionAudio) ; #DEBUG_LINE_NO:195
EndFunction

Function RenameTempleStarborn(Int iArtifact, Actor akStarborn)
  akStarborn.SetOverrideName(currentPlaythroughArtifacts[iArtifact].TempleStarbornName) ; #DEBUG_LINE_NO:200
EndFunction
