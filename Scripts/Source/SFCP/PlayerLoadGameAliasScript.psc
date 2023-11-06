ScriptName SFCP:PlayerLoadGameAliasScript extends ReferenceAlias

;-- Functions ---------------------------------------

Event OnPlayerLoadGame()
    ; When the player loads their saved game, we need to re-run the migration checks 
    ; in case they previously had SFCP installed and we've added new fixes
    UpdateHandler handlerQuest = Self.GetOwningQuest() as UpdateHandler
    if (handlerQuest) 
        handlerQuest.CheckForUpdates()
    endif
EndEvent