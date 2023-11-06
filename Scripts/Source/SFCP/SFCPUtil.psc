ScriptName SFCP:SFCPUtil Extends Form Hidden

;-- Global Functions --------------------------------

Function WriteLog(string sMessage, int iSeverity = 0) Global
    if Debug.OpenUserLog("StarfieldCommunityPatch")
        Debug.TraceUser("StarfieldCommunityPatch", "[[STARFIELD COMMUNITY PATCH TRACE LOG OPENED]]", 0)
    endif
    Debug.TraceUser("StarfieldCommunityPatch", sMessage, iSeverity)
EndFunction

Function ShowSFCPVersion() Global
    ; Get the version number from the globals
    GlobalVariable Major = Game.GetFormFromFile(0x000801, "StarfieldCommunityPatch.esm") as GlobalVariable
    GlobalVariable Minor = Game.GetFormFromFile(0x000802, "StarfieldCommunityPatch.esm") as GlobalVariable
    GlobalVariable Patch = Game.GetFormFromFile(0x000803, "StarfieldCommunityPatch.esm") as GlobalVariable

    if (!Major || !Minor || !Patch) 
        ; Probably using the unlocalised build during development, but we'll show an error anyway. 
        Debug.MessageBox("Starfield Community Patch is not loaded correctly on the required global variables are missing!")
        return
    endif

    String runningVersion = Major.GetValue() as Int+"."+Minor.GetValue() as Int+"."+Patch.GetValue() as Int
    
    ; Show a debug box containing the version
    Debug.MessageBox("Starfield Community Patch Loaded v"+runningVersion)
EndFunction