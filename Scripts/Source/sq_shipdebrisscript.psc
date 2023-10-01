ScriptName SQ_ShipDebrisScript Extends Quest

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
Keyword Property SQ_ShipDebrisKeyword Auto Const mandatory
{ add keyword to orbit location when quest is running to block other quests from starting up here }
LocationAlias Property OrbitLocation Auto Const mandatory
{ add keyword to this location }

;-- Functions ---------------------------------------

Event OnQuestStarted()
  Self.AddKeywordToLocation(True) ; #DEBUG_LINE_NO:10
EndEvent

Event OnQuestShutdown()
  Self.AddKeywordToLocation(False) ; #DEBUG_LINE_NO:14
EndEvent

Function AddKeywordToLocation(Bool addKeyword)
  Location theOrbitLocation = OrbitLocation.GetLocation() ; #DEBUG_LINE_NO:18
  If addKeyword ; #DEBUG_LINE_NO:20
    theOrbitLocation.addKeyword(SQ_ShipDebrisKeyword) ; #DEBUG_LINE_NO:21
  Else ; #DEBUG_LINE_NO:
    theOrbitLocation.RemoveKeyword(SQ_ShipDebrisKeyword) ; #DEBUG_LINE_NO:23
  EndIf ; #DEBUG_LINE_NO:
EndFunction
