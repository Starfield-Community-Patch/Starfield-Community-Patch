<!-- When adding items to the changelog, please use H2 (##) and below only, otherwise this will render in a strange way on the Starfield Patch website -->
<!-- 
## Guidance

When adding items to the changelog try and use the template below:

[YYYY-MM-DD] Version 1.0.0
- *Fix Summary* <link to issue>  - [Contributor Name](Profile URL)
-->
## [2024-04-14] Version 0.1.4
This update is intended to update compatibility with 1.11.36 of the game. 
### Fowarded Changes
- Forwarded script updates to MQ204 [qf_mq204_002c6d74]
- Forwarded script updates to SQ_PlayerShipScript [SQ_PlayerShipScript]
- Forwarded script updates to CompanionAffinityEventsScript [companionaffinityeventsscript]
- Forwarded script updates to BEScript [bescript]
- Forwarded new flag and map component on "The Well" cell [000F4ED4]
- Forwarded new flag and Image Space change on "Jemison Mercantile Store Room" cell [001928C2]
- Added the new effects to all food and drink items [0001BBAA] [0001BBAB] [0001BBAC] [0003614B] [0003614C] [00139E43] [00139E44] [00139E45] [001DFCB4] [001EBE9E] [001FF69A] [001FF69C] [001FF69E] [001FF6A0] [0020675D] [0020675E] [00243FA5] [00249C0D] [00249C0E] [00249C0F] [00249C10] [00249C11] [00249C1A] [00249C1B] [00249C1E] [00249C25] [00249C26] [00249C27] [00249C28] [00249C2A] [00249C2B] [00249C2C] [00249C3A] [00249C49] [00249C51] [0029B00E] [0029B03F] [0029B041] [0029B042] [0029B04D] [0029B04E] [0029B04F] [002C7202] [002C7203] [002C7204] [002C7205] [002C7206] [002C7207] [002C7208] [002C7209] [002C720D] [002C7210] [002C7211] [002C7214] [002C7215] [002C7217] [002C7219] [003BF792] [003BF793]
- Forward various location data changes [0002E373] [0009C57D] [0009C6C6] [00179DEB] [0018A2E4] [001C7752] [001E427B] [001EB454] [00219521] [00263C75] [0027A9A1] [0027A9A3] [00293417] [002A0EF4] [002B0801] [002B20C5]
# Quest Fixes
- Fixes a dead companion being assigned to you after completing Missed Beyond Measure [] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/545)
# Item Fixes
- Added missing COM_ObjType_Drink [KYWD:0007956D] keyword to Red Harvest Single Malt Whiskey and Red Harvest Single Malt Whiskey [0003614B] [0003614C]


## [2024-04-14] Version 0.1.3
This update is intended to update compatibility with 1.10.32 of the game. A roundup of the changes is available [here](https://www.starfieldpatch.dev/issues/924).
## Reverted Fixes
- Removed fix to Landing Marker ownership as this has been fixed by Bethesda. [0022F4A2] - [Original Fix](https://www.starfieldpatch.dev/issues/885)
- Removed fix where Cora would refer to Barrett even if he was dead. [00187BF5] - [Original Fix](https://www.starfieldpatch.dev/issues/679)
- Removed fix to the blast shield at Nishina Research Station [0X00080C] [0023B8A7] [0023B8A9] [0023B8AB] [0023B8AD] [0023B8AF] [0023B8B0] - [Original Fix](https://www.starfieldpatch.dev/issues/631)
- Removed fix for the graffiti on Styx not appearing as this has been fixed by Bethesda. [000A91FE] [000A920E] - [Original Fix](https://www.starfieldpatch.dev/issues/32)
- Removed a faction fix for the Star Eagle is this seems to cause an unexplained crash when editing the ship. [001322D8] - [Original Fix](https://www.starfieldpatch.dev/issues/860)
- Removed the fix for the Coe Estate Door not opening when skipping the main story in NG+ as Bethesda tried to fix this (unsuccessfully!) [001DC45E] [Fragments:Quests:QF_MQ401_001DC45E]
- Removed the fix for Rejuvenation level 3 and 4 as this has been fixed by Bethesda. [0012601A] [0012601B] - [Original Fix](https://www.starfieldpatch.dev/issues/433)
## Fowarded Changes
- Forwarded script updates on CF02 [000192D2]
- Forwarded script updates on City_Akila_Jansen [001A8B64]
- Forwarded script updates on City_GG_Connections [0018E0F9]
- Forwarded script updates on MQ101 [00003448]
- Forwarded alias updates on MQ105 [002C1C9B]
- Forwarded script and objective updates on MQ305 [0024EF9C]
- Forwarded alias and objective updates on RJ04 [001FB85C]
- Forwarded script, objective and stage updates in the Power From Beyond quests [000854E8] [0001C179] [0001C078] [0001C077] [0001C076] [0001C075]
- Forwarded script updates while maintaining our fixes [bescript] [sq_playershipscript]
## Quest Fixes
- Improved the fix which ensures that Cora Coe's Crew quest starts up on NG+ by using a remote stage registration rather than directly editing MQ401 [Fragments:Quests:QF_MQ401_001DC45E] [0x000805] [SFCP:UpdateHandler]
- Improved the fix where Lillian's Foreknowledge variable was not being set correctly by repairing the original dialogue line properties and removing the script/scene edits previously used [0026C506] [Fragments:Scenes:SF_COM_SamCoe_Story_SG02_0026C506] [0026C5A1]
- Improved the fix where Sam's Commitment Foreknowledge variable was not being set correctly by repairing the original dialogue line properties and removing the script/quest edits previously used [000DF7AD] [Fragments:Quests:QF_COM_Quest_SamCoe_Commitme_000DF7AD] [0023E003]
- Fixed Bethesda's implementation of Coe Estate Door Fix by point the alias to the correct object and updating the script to use the correct function. [Fragments:Quests:QF_COM_Quest_SamCoe_Commitme_000DF7AD] [000DF7AD]
- Fixed the check for Cora Coe's CREW quest after entering which was starting it up too early. [SFCP:UpdateHandler]

## [2024-03-30] Version 0.1.2
### General Fixes
- Spriggit updated to 0.18 in order to solve the dialogue bug introduced in game versions 1.10.30 and above. 
### AI Fixes
- Fixed an issue where your NPC companion would start sandboxing if you remain still while sneaking for a short period of time. [0028BF2C] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/900)
### Dialogue Fixes
- Companions will now use the correct "romantic" dialogue lines when asking them to follow you after marrying them. [002AF54E] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/826)
- Fixed an incorrectly conditioned Starborn dialogue option during Breach of Contract that appeared even if you hadn't done the quest before. [002E2923] - [Fix contributed by Wartortle](https://www.starfieldpatch.dev/issues/649)
- When a companion is angry with the player and explains what the player did it to upset them it can be generic, murder, or jealousy. The player's follow-up question can now correctly be different based on the reason. [002C5A0C] [002C5A04] [0014317F] [00143173] [0014320F] [0023EDE6] [0023EE2D] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/804)
- Andreja will now only say she's upset enough to leave if the player fails to convince her to stay. [001E9F5A] [001E9F5A] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/804)
- Sam Coe's positive and negative wait dialogues are now correctly conditioned to play the correct dialogue [0026BDF2] [0026BDF2] - [Reported by VenpiTheGamer](https://www.starfieldpatch.dev/issues/772)
- Sam Coe will no longer reference Sarah in his follower pickup lines if she has been killed. [0026C55B] - [Reported by VenpiTheGamer](https://www.starfieldpatch.dev/issues/771)
### Location Fixes
- Fixed an issue where one of the blast shields on Nishina would disappear when lowering. [0X00080C] [0023B8A7] [0023B8A9] [0023B8AB] [0023B8AD] [0023B8AF] [0023B8B0] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/631)
### Quest Fixes
- Fixed an issue where the radiant Constellation quest to locate a "Primordial Network" was actually looking for a "Gaseous Font" [001953FB] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/782)
### Skill Fixes
- The Gymnastics Zero-G perk (Rank 2) will no longer give the player a speed boost while the Earthbound Starborn ability is active. [002A4861] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/818)

## [2024-03-11] Version 0.1.1
### AI Fixes
- Fixed a bug where companions would stop following the player after exiting dialogue until they performed an action such as sneaking. This was caused by an invalid condition checking if they were still in dialogue. [00054B37] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/870)
- Companions will no longer be forced to stand up if the player speaks to them while they are seated inside their ship [002A9765] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/870)
- Fixed a bug where companions would stop following the player when a hostile creature was nearby. This was caused by an invalid interrupt flag set on the AI package. [002A9765] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/870)
- Companions will now comment on alcohol or chems you consume (if they are addictive). - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/851)
### Animation Fixes
- Fixed an issue where the Starborn Guardian would play the incorrect animation when landing vertically on certain pads (e.g. Gargarin Landing). [0007BAE7] [0010A3C4] [00032200] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/892)
- Fixed an issue where NPCs can get stuck in a "walk/run to idle" animation state. This seems to happen because these animations lack a "rampout" value in ther `.afx` files. - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/875)
    - meshes\actors\human\animations\gun\gripheavy\relaxed_runforward_stop_leftfoot.afx
    - meshes\actors\human\animations\gun\gripheavy\relaxed_runforward_stop_rightfoot.afx
    - meshes\actors\human\animations\gun\grippistol\female\relaxed_runforward_stop_leftfoot.afx
    - meshes\actors\human\animations\gun\grippistol\female\relaxed_runforward_stop_rightfoot.afx
    - meshes\actors\human\animations\gun\grippistol\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\gun\grippistol\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\gun\grippistol\sneak_runforward_stop_leftfoot.afx
    - meshes\actors\human\animations\gun\grippistol\sneak_runforward_stop_rightfoot.afx
    - meshes\actors\human\animations\gun\grippistol\sneak_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\gun\grippistol\sneak_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\gun\griprifle\ready_runforward_stop_leftfoot.afx
    - meshes\actors\human\animations\gun\griprifle\ready_runforward_stop_rightfoot.afx
    - meshes\actors\human\animations\gun\griprifle\ready_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\gun\griprifle\ready_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\gun\griprifle\relaxed_runforward_stop_leftfoot.afx
    - meshes\actors\human\animations\gun\griprifle\relaxed_runforward_stop_rightfoot.afx
    - meshes\actors\human\animations\gun\griprifle\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\gun\griprifle\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\andreja\female\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\andreja\female\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\angry\female\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\angry\female\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\angry\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\angry\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\confident\female\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\confident\female\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\confident\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\confident\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\depressed\female\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\depressed\female\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\depressed\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\depressed\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\executive\female\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\executive\female\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\executive\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\executive\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\female\relaxed_runforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\female\relaxed_runforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\macho\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\macho\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\ready_runforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\ready_runforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\ready_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\ready_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\relaxed_runforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\relaxed_runforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\relaxed_walkforward_stop_rightfoot.afx
    - meshes\actors\human\animations\melee\unarmed\sam\relaxed_walkforward_stop_leftfoot.afx
    - meshes\actors\human\animations\melee\unarmed\sam\relaxed_walkforward_stop_rightfoot.afx
### Dialogue Fixes
- During a conversation with Breyson Bayu, your companion will now correctly contribute. The conditions were set up incorrectly for this dialogue to be valid. [00182384] [00182385] [00182386] [00182387] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/888)
- Guards will no longer comment on the player's smart suit when it is hidden beneath their spacesuit. [0015DA4C] - [Fix contributed by TERAB1T](https://www.starfieldpatch.dev/issues/898)
- Security guards will now correctly comment on the player's unholstered weapon. This dialogue was unused as it was condition to only play if the player had their fists up. [0006175C] [0006175D] [0006175E] [000447DA] [000447DB] [00217853] [00219AF1] [001569C9] [0015DA46] [0015DA47] - [Fix contributed by TERAB1T](https://www.starfieldpatch.dev/issues/866)
- Guards will no longer say "Evening" (and similar) when it's not actually the evening. [0015DA43] [0015DA44] [0015DA45] - [Fix contributed by TERAB1T](https://www.starfieldpatch.dev/issues/879)
- Guards will no longer say "I never get to go to space." when they are in space. [0000D59B] - [Fix contributed by TERAB1T](https://www.starfieldpatch.dev/issues/878)
- New Atlantis Guards will no longer say "By the way Captain, Sergeant Yumi was looking for you. Sounds like he's got more work." even if you haven't done any work for him yet. [00042C60] [00042C72] [0005AC0C] [00346E5F] [00346E60] [0X00080B] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/887)
### Item Fixes
- Added the COM_ObjType_Drink [0007956D] KYWD to all alcoholic drink items, and the COM_ObjType_ChemBad [000A7296] KYWD to all "bad" chems which you can get addicted to. [0001BBAA] [0001BBAB] [0001BBAC] [00122EAD] [00139E43] [00139E44] [00139E45] [00139E4B] [00143CB2] [001DFCB4] [001EBE9E] [001FF69A] [001FF69C] [001FF69E] [001FF6A0] [0020675D] [0020675E] [00243FA5] [00249C0D] [00249C0E] [00249C0F] [00249C10] [00249C11] [00249C1A] [00249C1B] [00249C1E] [00249C25] [00249C26] [00249C27] [00249C28] [00249C2A] [00249C2B] [00249C2C] [00249C3A] [00249C51] [0029959D] [002995A1] [0029B00E] [0029B03F] [0029B041] [0029B042] [0029B04D] [0029B04E] [0029B04F] [002A9DE7] [002C5884] [002C5885] [002C7202] [002C7203] [002C7204] [002C7205] [002C7206] [002C7207] [002C7208] [002C7209] [002C720D] [002C7211] [002C7214] [002C7215] [002C7217] [002C7219] [003BF792] [003BF793] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/851)
### Location Fixes
- Fixed an incorrect map marker type for "UC Listening Post". [002CA717] - [Fix contributed by Voodoo5150](https://www.starfieldpatch.dev/issues/845)
- During Matters of the Hart the player's ship would be able to land at the incorrect marker to force the player into combat prematurely. [0022F4A2] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/885)
### Perk Fixes
- Stabilizing Barrel Effect, Medic and Stabilizing Shock will no longer incorrectly show in the UI when applied to an item the player is wearing. [001462A3] [001CB592] [00374067] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/822)
### Quest Fixes
- Fixed [MQ305Script] - [Reported by X2357](https://www.starfieldpatch.dev/issues/639) - [Fix contributed by Aurelianis](https://github.com/Starfield-Community-Patch/Starfield-Community-Patch/pull/886/files)
### Ship Fixes
- The Star Eagle ship is now flagged as a Freestar Collective vessel. It was incorrectly to set to United Colonies. [001322D8] - [Fix contributed by Voodoo5150](https://www.starfieldpatch.dev/issues/860)
### Skill Fixes
- The Targeting Control Systems Perk did not correctly decrease target lock-on time at ranks 2, 3, and 4. [002CCF94] [002CCF95] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/867)
### Text Fixes (English)
- Reverted several typo fixes that did not match the dialogue spoken [0008DA85] [0011459D] [00146DCF] [00146DD8] [00146DD5] [00009645] [000F2ECE] [00115420] [0000498D] [0017C65C] [001E79E1] [001E79EB] [0000498E] [0004A4BE] [0004A544] [0004A47F] [0004A4B7] [0004A4ED] [0004A4FE] [001A0049] [001A0058] [001A1778] [0004A4CE] [0004A508] [0004A4DA] [001A6AA4] [0004A46C] [001A6A70] [001A6AC7] [001A69DB] [001A6A54] [0004A4A1] [0004A515] [001A6A85] [001A6A4D] [0004A4E9] [0004A4D4] [001A6A82] [0004A488] [0004A4F4] [0004A48A] [0004A517] [001A697E] [001A69E6] [0004A4A7] [001FC800]
- Fixed a misspelling of "obliterating" in Vae Victis' dialogue [001B00B3] - [Fix contributed by JaeDLmods](https://www.starfieldpatch.dev/issues/869)
- Removed an unnecessary ellipses from Hadrian's dialogue [001153FF]- [Fix contributed by JaeDLmods](https://www.starfieldpatch.dev/issues/869)
- Replaced comma with full stop in Adrian Brasillia's dialogue [00149A45]- [Fix contributed by JaeDLmods](https://www.starfieldpatch.dev/issues/869)
- Fixed misuse of "effectively" when "effective" was intended in Cabinet dialogue during A Legacy Forged [000E5513]- [Fix contributed by JaeDLmods](https://www.starfieldpatch.dev/issues/869)
- Fixed duplicate "yet" in Eyewitness dialogue [00226481]- [Fix contributed by JaeDLmods](https://www.starfieldpatch.dev/issues/869)
- Replaced "make due" with "make do" in President Abello's dialogue [0023FA74]- [Fix contributed by JaeDLmods](https://www.starfieldpatch.dev/issues/869)
- Added missing comma in A Legacy Forged [000E54A6] [002AAE27]- [Fix contributed by JaeDLmods](https://www.starfieldpatch.dev/issues/869)
- Fixed a mismatch between dialogue and speech [001F9BEB]- [Fix contributed by JaeDLmods](https://www.starfieldpatch.dev/issues/869)


## [2024-01-12] Version 0.1.0
This is the first version created entirely by Spriggit!
### Quest Fixes
- Fixed an issue where MQ101 would start MQ_TutorialQuest too early causing it to fail to register for certain events [Fragments:Quests:QF_MQ101_00003448] [00003448] - [Fix contributed by Wartortle](https://www.starfieldpatch.dev/issues/714)
- Changed "A Break at Dawn" and "Keeping the Peace" quests to an "Activity" mission type to be consistent with Sgt Yumi's other quests [00091C9A] [0024C4A3] - [Reported by CrEaToXx](https://www.starfieldpatch.dev/issues/793)
- Changed "Unusual SOS" quest to an "Activity" mission type so that it correctly disappears from the active list once completed. [0025A9E2] - [Fix contributed by Krevil](https://www.starfieldpatch.dev/issues/295)
- Picking up "Gennady Ayton (Evidence)" before starting "Doctor's Orders" will no longer cause that quest to fail to start. The slate is now an optional alias. [001B6246] - [Reported by frogs345](https://www.starfieldpatch.dev/issues/752) - [Fix contributed by Wartortle](https://www.nexusmods.com/users/42492840)
- The player can no longer use the Commerce dialogue option during Sowing Discord if they have not unlocked the relevant skill [001E4D79] - [Reported by Drake0713](https://www.starfieldpatch.dev/issues/747) - [Fix contributed by Wartortle](https://www.nexusmods.com/users/42492840)
- During "Access is Key" the Va'ruun Ambassador Suit will now correctly update the quest objective, [RIR03_QuestScript] [RIR03_PlayerAliasScript] [002BA8A8] [002BA8A8] [00227CA2] [001DBE3B] [0X000809] [0X00080A] - [Reported by twistedresistor](https://www.starfieldpatch.dev/issues/735) - [Fix contributed by Wartortle](https://www.nexusmods.com/users/42492840)
### Item Fixes
- Corrected the name of the level 3 Rothicite extractor from "Extractor - Rothicite - Commerical" to "Extractor - Rothicite - Industrial" [0020276D] - [Reported by Senturus1983](https://www.starfieldpatch.dev/issues/784) - [Fix contributed by Wartortle](https://www.nexusmods.com/users/42492840)
### Dialogue Fixes
- Fixed the IsRomantic condition being incorrectly reversed on Andreja's dialogue [000EBC65] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/811) - [Mod Page](https://www.nexusmods.com/starfield/mods/8044)
- Fixed the quest stage condition being incorrectly reversed on Andreja's dialogue [000FC974] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/811) - [Mod Page](https://www.nexusmods.com/starfield/mods/8044)
- Fixed multiple cases where Andreja's dialogue was incorrect setup as new INFOs rather than additional responses on one INFO [00230E1E] [00230DE8] [00230DFB] [00230DC1] [00230DFF] [001F3B65] [00237002] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/811) - [Mod Page](https://www.nexusmods.com/starfield/mods/8044)
- Added a condition to the redundant INFOs to ensure they're not accessible [00230E1D] [00230DE7] [00230DFC] [00230DC0] [00230DFE] [00230E06] [00230E07] [00237003] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/811) - [Mod Page](https://www.nexusmods.com/starfield/mods/8044)
- Fixed the conditions on multiple [Starborn] options missing from Sarah Morgan's dialogue. [00097755] [003233B7] [003233A3] [00323391] [003233AA] [003233AC] - [Fix contributed by Deebz96](https://www.starfieldpatch.dev/issues/803)
### Text Fixes (English)
- Fixed incorrect use of "it's" in the Nario War information terminal. [0003B6B5] - [Reported by CrystalSharrd](https://www.starfieldpatch.dev/issues/789)
- Fixed a misspelling of "something" in Jessamine Griffin's dialogue [001D8A03] -  [Reported by Senturus1983](https://www.starfieldpatch.dev/issues/783) - [Fix contributed by Wartortle](https://www.nexusmods.com/users/42492840)
- Fixed a mispelling of "Legrande's Liquors" in the name of the announcer voice in Neon [0030D630] - [Reported by Icyknightmare](https://www.starfieldpatch.dev/issues/661) - [Fix contributed by Wartortle](https://www.nexusmods.com/users/42492840)
### Text Fixes (German)
- Fixed a missing word in Emmet Goodman's dialogue. [00208E54] - [Reported by aurreth](https://www.starfieldpatch.dev/issues/693)
### Text Fixes (Polish)
- Fixed mistranslation of "grandpa" as "Babcia" rather than "Dziadek" [0022722D] - [Reported by mrkox12321](https://www.starfieldpatch.dev/issues/787)
- Fixed corrected translation from "Agentka Przymierza Tropicieli" to "Agent Przymierza Tropicieli" for male Tracker's Alliance Agents [00216D35] - [Reported by mrkox12321](https://www.starfieldpatch.dev/issues/780)

## [2023-12-21] Version 0.0.7
### Planet Fixes
- Swapped keyword LocTypeSettledPlanet [KYWD:00062F2F] for LocQuestUCR03World [KYWD:001E79B7] on Europa so that is can be correctly used during radiant quests. [0001B747] - [Reported by aurreth](https://www.starfieldpatch.dev/issues/693) 
### Item Fixes
- Fixed a component error on Red Harvest Double Malt Whiskey caused by a badly applied fix in a previous version of the patch [0003614B] - [Reported by pega3](https://www.starfieldpatch.dev/issues/657)
- Fixed facial hair not showing up while wearing the Hazmat Suit [0008AE0E] - [Fix contributed by Wartortle](https://www.nexusmods.com/users/42492840) - [Reported by IHaveCorn](https://www.starfieldpatch.dev/issues/390) 
### Placed Object Fixes
- Removed multiple instances of the unplayable item Clothes_Crowd_LayeredTee_01_NOTPLAYABLE "Layered Tee" [ARMO:0026DFBF] from the world. One instance can't be replaced due to reflection data. [0032169D] [000A89CA] [001A4630] [0032169D] [003690CF] [0037B6B5] - [Fix contributed by 
ArkangelCorvus](https://www.nexusmods.com/starfield/users/136181948) - [Reported by Dragten](https://www.starfieldpatch.dev/issues/275)
### NPC Fixes
- Fixed an issue where miners would "mine" ore with their weapons rather than a cutter after exiting combat. [00052E92] [0006A03F] [00203BF2] [00203BF4] - [Fix contributed by Korodic](https://www.starfieldpatch.dev/issues/751) - [Mod Page](https://www.nexusmods.com/starfield/mods/7459)
### Text Fixes (English)
- Fixed a misspelling of "incalculable" in Ambassador Bal'Mor's personal log - Log 03: A Visitor [0034BF18] - [Reported by Murvel3000](https://www.starfieldpatch.dev/issues/684) - [Contributed by Wartortle](https://www.nexusmods.com/users/42492840)
- Fixed a misspelling of "officers" in Chief Pretorius' dialogue [00155859] - [Reported by Drackore](https://www.starfieldpatch.dev/issues/730) - [Contributed by Wartortle](https://www.nexusmods.com/users/42492840)
- Fixed a misspelling of "do" in President Abello's dialogue [0023FA74] - [Reported by Drackore](https://www.starfieldpatch.dev/issues/722) - [Contributed by Wartortle](https://www.nexusmods.com/users/42492840)
- Fixed a misspelling of "doppelganger" in Sarah's dialogue [001801C3] - [Reported by Dadditude](https://www.starfieldpatch.dev/issues/533) - [Contributed by Wartortle](https://www.nexusmods.com/users/42492840)
### Misc Fixes
- Fixed missing ALFG record data on several aliases in Eyewitness [0023FA74] - [Contributed by Wartortle](https://www.nexusmods.com/users/42492840)
- Fixed several of Dani Garcia's follower lines that were intended to be available once the player has a Neuroamp installed but would not show due to a bad condition. [000049A8] [000049DB] [000049A3] [000049AF] - [Fix contributed by Aurelianis](https://www.starfieldpatch.dev/issues/760)


## [2023-12-15] Version 0.0.6
### Ship Fixes
- Added missing SpaceshipTurretWeapon [KYWD:0032792C] keyword to Disrupter 3340 alpha oscillator Turret [000C0A36] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Added missing SpaceshipTurretWeapon [KYWD:0032792C] keyword to Jishaku Nd RF railgun Turret [001504FD] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Added missing SpaceshipTurretWeapon [KYWD:0032792C] keyword to Blaze-P 2gw SX Pulse Laser Turret [00150500] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Added missing SpaceshipEnergyWeapon [KYWD:0002226A] keyword to Vaporizer 35MeV proton beam [0022EC51] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Added missing SpaceshipEnergyWeapon [KYWD:0002226A] keyword to Ravager 20MeV electron beam [0022EC52] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Added missing SpaceshipEnergyWeapon [KYWD:0002226A] keyword to Disrupter 3310 proton beam [0022EC57] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Added missing SpaceshipEnergyWeapon [KYWD:0002226A] keyword to Disrupter 3300 electron beam [0022EC58] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Added missing SpaceshipEnergyWeapon [KYWD:0002226A] keyword to PB-50 proton projector [0022EC5E] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Added missing SpaceshipEnergyWeapon [KYWD:0002226A] keyword to PB-30 Electron Beam [0022EC5F] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Fixed incorrect ammo capacity on KE-42 cannon turret [0014A8D5] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Fixed incorrect ammo type on EMP-1000 broadband suppressor [002184A6] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Fixed incorrect ammo type on EMP-500 stochastic suppressor [002184A7] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Fixed incorrect damage value on Tatsu 501EM inverting suppressor [0021849A] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Changes the max power of the Atlatl 290B to be '6' which seems to put the weapon into a more sensible balance with respect to the rest of the existing weapons. [00228D4A] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Fixed a missing 0 on the cost price of Fulminator 8000 Suppressor. [002233D8] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
- Changes the price of the Tatsu 501EM Suppressor to reflect the damage change. [002233C9] - [Reported by JaeDL](https://www.starfieldpatch.dev/issues/744) - [Contributed by GrizBane](https://www.nexusmods.com/users/6728261) - [Mod Page](https://www.nexusmods.com/starfield/mods/7614)
### Items Fixes
- Fixed facial hair disappearing while wearing a Graviplas helmet [000781F5] - [Fixed contributed by Wartortle](https://www.starfieldpatch.dev/issues/745)
### Text Fixes (English)
- Fixed grammatical errors in "Letter to the School Board" item. [0006A028] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed a grammatical error on the load screen text for "Ship Critical Fixes" [0003E1E4] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Added missing commas on the load screen about Auora production on Neon [0005B3D3] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Added a missing Oxford comma on the load screen about the Colony War [0005B3D5] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed grammar for the load screen about the Serpent's Crusade [0005B3D6] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Added a missing comma on the load screen about abandonned bases [000C8C9B] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed a misspelling of "reveals" on the load screen about Zoology [0018566B] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed the grammar on the load screen regarding He3 extending ship range [0018566D] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed a missing comma on the load screen about hailing guard ships [0018567B] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Improved the clarity of the load screen about the Security skill [00185696] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Improved the grammar in some of the dialogue in Search and Seizure [0008D103] [0008DA85] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Adjusted subtitles to better match the audio during "Spreading the News" [0011459D] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed minor typos and grammatical mistakes in a NewHomestead scene [00146DCF] [00146DD8] [00146DD5] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed an incorrect apostrophe in Hadrian's dialogue [0000962F] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Adjusted subtitles to better match Hadrian's dialogue [00009645] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed missing commas in Hadrian's dialogue [0000963B] [0000963C] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Various grammar fixes in Hadrian's follower dialogue [000F2ECB] [000F2ECE] [000F2EC5] [000F2ED0] [000F2EC8] [000F2EC7] [00115420] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed word order in a quest log entry for Apex Predator [00092C4C] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Added missing commas and adjusted subtitles in Apex Predator [0000498D] [00092C4C] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed missing captial letters in Red Devils Dialogue [0017C65C] [001E79E1] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Various grammatical fixes in Red Devils Dialogue [0000498E] [001E79D8] [001E79EA0] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Various spelling and grammer fixes in dialogue subtitles during A Legacy Forged [0004A4BE] [0004A544] [0004A47F] [0004A4B7] [0004A4ED] [0004A4FE] [0004A4FF] [001A0049] [001A0058] [001A1778] [0004A4CE] [0004A508] [0004A4DA] [001A6AA4] [0004A46C] [0004A46D] [001A6A70] [001A6AA7] [001A6AC7] [001A6A65] [001A69DB] [001A6A89] [001A6A54] [0004A4A1] [0004A515] [001A6A85] [001A6A4D] [0004A4E9] [0004A4D4] [001A6A82] [0004A488] [0004A4F4] [001FC819] [0004A48A] [0004A517] [001A697E] [001A69E6] [0004A4A7] [001FC800] - [Fix contributed by dodexahedron](https://www.starfieldpatch.dev/issues/726) - [Mod Page](https://www.nexusmods.com/starfield/mods/7293)
- Fixed a missing word in Denis' dialogue (Cydonia) [001E7139] - [Reported by Drackore](https://www.starfieldpatch.dev/issues/743)
- Fixed a missing word in Tuala's dialogue (Cydonia) [000E5443] - [Reported by Drackore](https://www.starfieldpatch.dev/issues/741)
- Adjusted subtitles to better match Sam Coe's dialogue [0026C508] - [Reported by Drackore](https://www.starfieldpatch.dev/issues/742)
- Fixed a misplaced comma from a previous fix of Barrett's dialogue [001A49B7] - [Reported by Jackrum](https://www.starfieldpatch.dev/issues/746)
### Misc Fixes
- Removed reference to missing script [TestElectrifiedWaterTriggerScript] [001E9B90]
- Removed reference to missing script on the player's base ID [ENV_Temp_SetPlayerGravityScaleScript] [00000007]
- Removed reference to missing script [SQ_ENV_OnHit_Burns] [00248D20]
- Removed reference to missing script [City_NA_Well01_QuestScript] [0027071C]
- Removed reference to missing script [OutpostShipbuilderTerminalScript] [00299418]
- Removed reference to missing script [SQ_GenericCrewAliasScript] [002A567D]
- Removed reference to missing script [MQ305PlayerShipPilotSeatScript] [0024EF9C]
- Removed reference to missing script [BQ01_BarrettSceneBackupScript] [00002FAE]
- Removed unused property CF03 on script CFSD01_QuestScript attached to CFSD01 [001E8E2A]
- Removed unused property VendorContainerKeyword01 on script sq_groups_questscript attached to SQ_Groups [001A9565]
- Removed unused properties CloseSoundMarker and OpenSoundMarker on script LandingPadBlastShields attached to MQ207CLandingMarkerRef [0023B8A5]
- Removed unused property iStageToSet on script RI07_OperatingTableAliasScript attached to alias InternalNeuroampCase on quest RI07 [0018B718]
- Removed unused property COM_CombatResponseCivilianList from Barrett, Sarah and Andreja [00005787] [00005983] [000059A7]



## [2023-12-08] Version 0.0.5
### Actor Fixes
- Hadrian is now correctly assigned to CrimFactionUC rather than ConstellationFaction. This fix will also apply mid-save. [0029C17F] - [Fix contributed by SKK50](https://nexusmods.com/users/46256407) - [Reported by SKK50](https://www.starfieldpatch.dev/issues/669)
- Gideon Aker will now have unlimited ammo when recruited as a follower. (Missing TeammateDontUseAmmoKeyword [KYWD:0023F1CA]) - [Reported by SamusKnight2K](https://www.starfieldpatch.dev/issues/588)
### Location Fixes
- Fixed missing LocTypeStarstationInterior [KYWD:0001674E] keyword for Starstation RE-939 [0002E373] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationInterior [KYWD:0001674E] keywords for Starstation UCN-48 [0009B0CA] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Nova Galactic Staryard [0009B0CB] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9] keywords for The Eye [0009C57D] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstationInterior [KYWD:0001674E] keyword for Starstation RE-939 [0009C6C6] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9]  keywords for Retrofitted Starstation [000F483C] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstationExterior [KYWD:0008A8F9] keyword for Starstation RE-939 [0016573C] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9] keywords for The Almagest [001671E6] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationInterior [KYWD:0001674E] keywords for The Almagest [00179DEB] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationInterior [KYWD:0001674E] keywords for Retrofitted Starstation [0018A2E4] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9] keywords for Defensive Battery Gamma [001C7750] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9] keywords for Defensive Battery Beta [001C7751] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9] keywords for Defensive Battery Alpha [001C7752] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for The Clinic [001D627D] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for The Clinic [001DE8C0] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for The Clinic [001E427B] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9] keywords for The Sonder [001EB453] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationInterior [KYWD:0001674E] keywords for The Sonder [001EB454] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Deimos Staryard [001EC462] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9] keywords for Starstation UCN-48 [0020382D] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Stroud-Eklund Staryard [002101AA] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Nova Galactic Staryard [00211B93] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9] keywords for The Den [00213CD7] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Autonomous Staryard [0021433C] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Nova Galactic Staryard [00219521] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Trident Luxury Lines Staryard [00223325] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationInterior [KYWD:0001674E] keywords for Starstation UCN-48 [00263C75] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Stroud-Eklund Staryard [0027A9A1] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Deimos Staryard [0027A9A3] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationInterior [KYWD:0001674E] keywords for Autonomous Staryard [00293417] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationInterior [KYWD:0001674E] keywords for The Den [002A0EF4] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationInterior [KYWD:0001674E] keywords for The Eye [002B0801] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] keyword for Trident Luxury Lines Staryard [002B20C5] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
- Fixed missing LocTypeStarstation [KYWD:0001674D] and LocTypeStarstationExterior [KYWD:0008A8F9] keywords for Polvo Station [00331890] - [Fix contributed by VarekRaith](https://www.starfieldpatch.dev/issues/640)
### Item Fixes
- Fixed an error with the Ecliptic Backpack that would cause the wrong mods to be applied to it. [00166407] - [Fix Contributed by Gambit77](https://www.starfieldpatch.dev/issues/664)
- Fixed an error in the levelled lists for SysDef armour which would lead to heavy armour spawning where the recon (light armour) variant should be used. [000042D9] [00228D12] - [Fix Contributed by Gambit77](https://www.starfieldpatch.dev/issues/671)
### Scene Fixes
- Cora and Sam will no longer have a conversation about telling Barrett a joke if he has been killed [00187BF5] - [Reported by X2357](https://www.starfieldpatch.dev/issues/638)
### Quest Fixes
- The "Complete a research project" tutorial objective will no longer display if the player has completed all available research. A new conditional form has been added to check if the player has completed the highest rank of all research projects SFCP_CND_AllResearchCompleted [CNDF:02000808][Fragments:Quests:QF_MQ_TutorialQuest_Misc06_0000118F] [0x000808] [SFCP:UpdateHandler] - [Reported by TheIrreverentReverend](https://www.starfieldpatch.dev/issues/725)
### Text Fixes (English)
- Fixed multiple places where "poring" (to study) was misspelt as "pouring" (to tip liquid). [001886D1] [0014612E] [001E3F53] [001E3F57] - [Reported by Jay33721](https://www.starfieldpatch.dev/issues/602)
- Fixed "any more" misspelt as "anymore" in Pascual Logan's dialogue [002D1C78] - [Reported by Drackore](https://www.starfieldpatch.dev/issues/729)
- Fixed a load screen about smuggling referring to the "Payloads" skill rather than the "Deception" skill for increased chance of evading contraband scans. [00185667] - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/706)
- Fixed a misplaced ellipsis in Vae Victis' dialogue [00248C66] - [Reported by Norseman048](https://www.starfieldpatch.dev/issues/680)
- Fixed missing "to" in Sarah's dialogue [00068926] - [Reported by dodexahedron](https://www.starfieldpatch.dev/issues/676)
- Fixed a misspelling of "Scalding Liquid" on the Spell entry for this effect. [001D5CF5] - [Reported by SpacePigeonTV](https://www.starfieldpatch.dev/issues/675)
### Text Fixes (French)
- Fixed a load screen about smuggling referring to the "Chargements" skill rather than the "Tromperie" skill for increased chance of evading contraband scans. [00185667] - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/706)
### Text Fixes (Spanish)
- Fixed a load screen about smuggling referring to the "Cargamento" skill rather than the "Engaño" skill for increased chance of evading contraband scans. [00185667] - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/706)
### Text Fixes (German)
- Fixed a load screen about smuggling referring to the "Logistik-Skill" skill rather than the "Täuschung-Skill" skill for increased chance of evading contraband scans. [00185667] - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/706)
- Fixes a mismatch between dialogue and subtitles in an audio log encountered in the NASA launch facility.  [000B11CF] - [Reported by SkyHorizon3](https://www.starfieldpatch.dev/issues/721)
### Text Fixes (Italian)
- Fixed a load screen about smuggling referring to the "Carico" skill rather than the "Raggiro" skill for increased chance of evading contraband scans. [00185667] - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/706)
### Text Fixes (Polish)
- Fixed a load screen about smuggling referring to the "Ładowność" skill rather than the "Podstęp" skill for increased chance of evading contraband scans. [00185667] - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/706)
### Text Fixes (Brazilian Portuguese)
- Fixed a load screen about smuggling referring to the "Carregamentos" skill rather than the "Clandestinidade" skill for increased chance of evading contraband scans. [00185667] - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/706)
### Text Fixes (Japanese)
- Fixed a load screen about smuggling referring to the "貨物積載" skill rather than the "狡猾" skill for increased chance of evading contraband scans. [00185667] - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/706)
### Text Fixes (Chinese -Simplified)
- Fixed a load screen about smuggling referring to the "有效载荷" skill rather than the "骗术" skill for increased chance of evading contraband scans. [00185667] - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/706)
### Misc Fixes
- Added a couple of missing dialogue conditions ommited from a previous fix [0032C7CA] [0032C7CB] [0032C7CC] [0032C7CD] - [Reported by TareliusKosmos](https://www.starfieldpatch.dev/issues/666)
- The update handler for the Starfield Community Patch will now only fire on first startup and each time the player loads the game. Now using OnQuestInit() as it was incorrectly using OnInit() which triggers every time the game starts up. [SFCP:UpdateHandler] 


## [2023-11-14] Version 0.0.4
### Quest Fixes
- During A Tree Grows in New Atlantis, the sensor acquired from Wen at UC Distribution will no longer be marked as stolen if the player manages to obtain it by purchasing it or by persuasion. [Fragments:Quests:QF_City_NA_Botany01_00270718] - [Fix contributed by Pickysaurus](https://www.nexusmods.com/users/31179975) - [Reported by TheTrueDovahki1n](https://www.starfieldpatch.dev/issues/601)
- Background Checks will no longer fail to start if the player has killed the elevator guard before starting the quest. The guard is now an optional component on the quest. [0033DC61] - [Fix contributed by Korodic](https://nexusmods.com/users/360983) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/6779) - [Reported by Korodic](https://www.starfieldpatch.dev/issues/615)
- Guilty Parties will no longer fail to start if the player has killed Ularu's door guard before starting the quest. The guard is now an optional component on the quest. [001EE0C8] [Fragments:Quests:QF_RI05_001EE0C8] - [Fix contributed by Korodic](https://nexusmods.com/users/360983) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/6782) - [Reported by Korodic](https://www.starfieldpatch.dev/issues/616)
- Executive Level will no longer fail to start if the player has killed Ularu's door guard before starting the quest. The guard is now an optional component on the quest. [0018B717] [Fragments:Quests:QF_RI08_0018B717] - [Fix contributed by Korodic](https://nexusmods.com/users/360983) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/6819) - [Reported by Korodic](https://www.starfieldpatch.dev/issues/618)
- Power from Beyond temple map markers will now show up as expected. This was caused by versions of the quest pointing to the wrong variant when evaluating if the "Acquire the Power on `<Alias=PlanetWithTrait>`" objective should be shown after reaching the temple. [0001C075] [0001C076] [0001C077] [0001C078] - [Fix contributed by Aurelianis](https://www.nexusmods.com/users/143884143) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/600)
- During My North Star Sivan will now correctly stop following you in certain instances. The StopFollowConditions property of the DefaultFollowerToggleQuestScript was pointing to an invalid Form. [000D2499] - [Reported by Bobbyclue](https://www.starfieldpatch.dev/issues/279)
### Item Fixes
- Added Emergency Kit to the list of healing items which trigger an animation if NPCs heal each other [0024DDC1] - [Reported by Wartortle](https://www.starfieldpatch.dev/issues/617)
- CAN-uck! Double Double is now considered a Coffee component in crafting [00249C49] - [Fix contributed by ArkangelCorvus](https://www.nexusmods.com/starfield/users/136181948) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/6532) - [Reported by ArkangelCorvus](https://www.starfieldpatch.dev/issues/318)
- Red Harvest Double Malt Whiskey is now considered a Liquor component in crafting [0003614B] - [Fix contributed by ArkangelCorvus](https://www.nexusmods.com/starfield/users/136181948) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/6532) - [Reported by ArkangelCorvus](https://www.starfieldpatch.dev/issues/318)
- Red Harvest Single Malt Whiskey is now considered a Liquor component in crafting [0003614C] - [Fix contributed by ArkangelCorvus](https://www.nexusmods.com/starfield/users/136181948) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/6532) - [Reported by ArkangelCorvus](https://www.starfieldpatch.dev/issues/318)
### Beta compatibility fixes
- Reverted Neon Security Dialogue fix by wSkeever [0032C7C0] [QF_DialogueNeonConvo_Securit_0032C7C0] as this fix is no longer required following the changes in 0.0.3 [Reported by wSkeever](https://www.starfieldpatch.dev/issues/563)
- Reverted the NG+ softlock fix as Bethesda have addressed this themselves in [1.8.83.0](https://bethesda.net/en/game/starfield/article/6BV2LYrp98qW4F15zfejEA/starfield-beta-update-1-8-83-notes-november-8-2023) [mq401questscript] [Reported by Connerria](https://www.starfieldpatch.dev/issues/314)
- Reverted the fixes applied to the Lasers skill rank 4 as this unintentionally caused EM weapons to deal burn damage to targets. [002C59DD] - [Reported by Argonil](https://www.starfieldpatch.dev/issues/592)
- Forwarded changes to One Small Step from [1.8.83.0](https://bethesda.net/en/game/starfield/article/6BV2LYrp98qW4F15zfejEA/starfield-beta-update-1-8-83-notes-november-8-2023) [00019287]
### Text Fixes (English)
- Fixed a duplicate "as" in a dialogue subtitle. [00260E66] - [Reported by grndkntrl](https://www.starfieldpatch.dev/issues/596)
- Fixed an incorrect reference to the "Akila System" where it should have been "Cheyenne System". [001A8B64] - [Reported by translucentfocus](https://www.starfieldpatch.dev/issues/637)
- Fixed two gramatical errors in player dialogue with Rayna Marquez during The Devils You Know. [00248C2F] [001D7CCF] - [Reported by thefirebirdman](https://www.starfieldpatch.dev/issues/627)
- Fixed a misspelling of "Crimson Fleet" in David Barron's SSNN dialogue [0033DD16] - [Reported by KingNewbs](https://www.starfieldpatch.dev/issues/626)
### Text Fixes (Italian)
- Fixed a mistranslation of "Canna pesante" [00094C5C] [001230EF] - [Reported by DEADFURY](https://www.starfieldpatch.dev/issues/607)


## [2023-11-07] Version 0.0.3
- Power from Beyond map markers will no longer disappear. This was caused by versions of the quest pointing to the wrong variant when evaluating if the "Acquire the Power on `<Alias=PlanetWithTrait>`" objective should be shown. [0001C075] [0001C076] [0001C077] [0001C078] - [Fix contributed by Pickysaurus](https://www.nexusmods.com/users/31179975) - [Reported by broekerisdabomb](https://www.starfieldpatch.dev/issues/214)
- Improved the fix for Coe Estate not unlocking in NG+. This will now unlock without visiting Unity first. [SFCP:UpdateHandler]
- Improved the fix for Cora Coe not joining the crew with Sam in NG+. This will now unlock without visiting Unity first. [SFCP:UpdateHandler]
- Improved the fix for Undiscovered Temples. This will now unlock without visiting Unity first. [SFCP:UpdateHandler] [starborntemplequestscript]
- Players can check the patch has been loaded correctly using the command `cgf "SFCP:SFCPUtil.ShowSFCPVersion"` in the console (PC only) [SFCP:SFCPUtil]
- Added a new update handler to apply select fixes to the current save without requiring the player to enter NG+. [SFCP:PlayerLoadGameAliasScript] [SFCP:UpdateHandler] [0x000805] - [Contributed by Pickysaurus](https://www.starfieldpatch.dev/issues/553)
- The Trackers Alliance Bounty Clearance Service Kiosk will allow you to clear bounties from the following minor factions: Paradiso, The Crucible, The Crimson Fleet, ECS Constant, House Va'ruun. [0017C02D] - [Fix contributed by wSkeever](https://www.nexusmods.com/starfield/users/7064860) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5724) - [Reported by wSkeever](https://www.starfieldpatch.dev/issues/318)
- The Ship Command Perk will now work correctly on ships you commandeer. [SQ_PlayerShipScript] - [Fix contributed by wSkeever](https://www.nexusmods.com/starfield/users/7064860) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/6185) - [Reported by Linnsanity](https://www.starfieldpatch.dev/issues/523)
- Radiation damage was using the incorrect resistance value (Corrosive instead of Radiation) [0021BBD4] [002218DF] - [Reported by Naith](https://www.starfieldpatch.dev/issues/368)
- The "Soak" environmental debuff was using the incorrect resistance value (Corrosive instead of Thermal) [003CBFE0] [001F7630] - [Reported by Naith](https://www.starfieldpatch.dev/issues/368)
- After finishing the quest "Bare Metal" Styx will no longer be covered in graffiti when displaying the dialogue option "How do you feel now that you're all cleaned up?" [000A91FE] [000A920E] - [Fix contributed by Krevil](https://www.nexusmods.com/starfield/users/1051880) - [Reported by WidgitLabs](https://www.starfieldpatch.dev/issues/32)
- HopeTech guards no longer remain hostile after completing "The Hammer Falls" and choosing to attack Ron Hope. [qf_fc09_001a54f9] - [Fix contributed by Aurelianis](https://github.com/Starfield-Community-Patch/Starfield-Community-Patch/pull/512) - [Reported by EgoBallistic](https://www.starfieldpatch.dev/issues/344)
- Mannequins will now spawn at the same level as the player rather than always being level 1. This will allow for proper levelled space suits to appear in their inventory. [001EE4D6] [Fix contributed by Livelynightmare](https://www.nexusmods.com/starfield/users/1872172) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/6237) - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/513)
- Davis Wilson will now correctly use his unique rifle [0x000806] [002161AE] - [Fix contributed by DankRafft](https://www.nexusmods.com/starfield/users/2547580) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/6202) - [Reported by DankRafft](https://www.starfieldpatch.dev/issues/500)
- Guards in New Atlantis and Neon will now correctly approach the player if they have a bounty and a weapon drawn. [0032C7CA] [0032C7CB] [0032C7CC] [0032C7CD] [0006B25B] [0021EAF7] [0021EAF8] [0021EAF9] - [Fix contributed by wSkeever](https://www.nexusmods.com/starfield/users/7064860) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5724) - [Reported by wSkeever](https://www.starfieldpatch.dev/issues/321)
- Replaced 4 books in The Clinic which were using a base form called `_BookHardback_Large01_DONOTUSE` these are now levelled large books instead. [00126335] [001275BA] [0012E038] [001316DC] - [Reported by Orvid](https://www.starfieldpatch.dev/issues/322)
- Fixed an invalid reference in the script properties of the Power From Beyond quests [0001C075] [0001C076] [0001C077] [0001C078] [0001C079] [000854E8] [00101043] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143)
- Walter will no longer refer to Sarah as the head of Constellation if she has been killed. [002953F6] - [Fix contributed by EgoBallistic](https://github.com/EgoBallistic) - [Reported by EgoBallistic](https://www.starfieldpatch.dev/issues/468)
- Fixed a typo in the "You can not eat quest items" messsage. [000D48DC] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/437)
- Fixed a misplaced question mark and missing capital letter in dialogue subtitles. [000117E7] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/438)
- Fixed a typo in the spelling of "et certera". [0008D107] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/439)
- Fixed a typo in the spelling of "soldier". [0020614D] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/440)
- Fixed a duplicate "is" in a dialogue subtitle. [0003C547] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/441)
- Fixed a missing punctuation in a player dialogue option. [000A69C3] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/442)
- Fixed a typo in the spelling of "misery". [0028FE4C] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/443)
- Fixed a discrepancy between the subtitle and spoken dialogue. [000B85D3] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/452)
- Fixed a missing comma in Sarah's dialogue subtitles. [002FAD44] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/453)
- Fixed a discrepancy between the subtitle and spoken dialogue. [00299D6C] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/454)
- Fixed a discrepancy between the subtitle and spoken dialogue. [00299D3A] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/455)
- Fixed a missing comma in dialogue subtitles. [0033EBEA] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/456)
- Fixed a missing comma in dialogue subtitles. [003B2230] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/457)
- Fixed a missing comma in dialogue subtitles. [001A49B7] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/458)
- Fixed a typo in the spelling of "collapsing". [002080E1] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/460)
- Fixed a typo in the spelling of "then". [0019B10C] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/463)
- Fixed a discrepancy between the subtitle and spoken dialogue. [0032C2F4] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/464)
- Fixed a discrepancy between the subtitle and spoken dialogue. [00330386] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/465)
- Fixed a extra comma in dialogue subtitles. [00087C74] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/466)
- Fixed a extra word in a dialogue line ("going"). [00021C749] - [Reported by Livelynightmare](https://www.starfieldpatch.dev/issues/467)
- Fixed a grammatical error in the description of the GRUNT magazine perks [0021D059] - [Reported by Murvel3000](https://www.starfieldpatch.dev/issues/510)
- Fixed a unused keyword with a missing editor ID `Neon_LightSwap_Keyword` [0014C02B] - [Reported by Fuzzlesz](https://www.starfieldpatch.dev/issues/514)
- Fixed a grammatical error in Sam Coe's dialogue while the player does not pick an option [0026C574] - [Reported by Drackore](https://www.starfieldpatch.dev/issues/549)
- Fixed a mispelling of "Ron Hope" as "Rob Hope" [0008CD36] - [Reported by TheDarkFurie](https://www.starfieldpatch.dev/issues/556)
- The chemical formula for Benzene has been corrected from C6Hn to C6H6 in all locales. - [Reported by Pickysaurus](https://www.starfieldpatch.dev/issues/508)


## [2023-10-28] Version 0.0.2
- The UC Sec ships orbiting Toliman II will no longer hail the player about the planet being a "Biological Exclusion Zone" after completing stage 155 of UC08 [001C54EB] - [Fix contributed by Connerria](https://www.nexusmods.com/starfield/users/40981350) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5607) - [Reported by Connerria](https://www.starfieldpatch.dev/issues/408)
- Fixed a potential softlock issue when arriving in a variant universe in NG+ [mq401questscript] - [Fix contributed by Connerria](https://www.nexusmods.com/starfield/users/40981350) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/4657) - [Reported by Connerria](https://www.starfieldpatch.dev/issues/314)
- Fixed two instances of "with" being misspelt as "wth". [0033A879] [0010F644] - [Reported by AUGSpeed](https://www.starfieldpatch.dev/issues/49)
- Gunslinger's Guide and Mining Monthly magazine perks no longer count toward the skill total for the Combat tree (this would allow skills further down the tree to be unlocked without the required prerequisities). [0020BB31] [0020B4B6] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Automated Weapon Systems skill rank 4 will no longer apply bonuses to non-turret weapons. [0027B9ED] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Decontamination skill rank 4 description now includes the further increase to recovery chance. [002CE2A0] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Cellular Regeneration skill rank 4 description now includes the further increase to recovery chance. [0028AE14] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Targetting Control Systems skill rank 4 now correctly provides +10% critical hit chance. [002C5559] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Targetting skill rank 3 will now correctly provide an increase to weapon range. [002C59DA] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Shield Systems skill will no longer increase shield health beyond the intended amount. [002C2C59] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- Rejuvenation skill ranks 3 and 4 new correctly allow the player to regain health while in combat. (Fix improved from v0.0.1) [0012601A] [0012601B] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Rapid Reloading skill now correctly provides bonuses while throwables are equipped. [002C555A] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Pistol Certification skill now correctly provides +25% critical hit chance instead of multiplying your base crit chance by 1.25. [002080FF] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Particle Beams skill now correctly provides +5% critical hit chance instead of multiplying your base crit chance by 1.05. [0027BAFD] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Martial Arts skill now correctly provides +15% critical hit chance instead of multiplying your base crit chance by 1.15. Ranks 3-4 will correctly have a 15% chance to disarm instead of 5%. [002C5554] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Leadership skill ranks 2-4 will now correctly provide +25% to affinity gain instead of +15%. [002C890D] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Concealment skill will no longer override the magazine perks from Va'ruun scriptures or interfere with Void Form. [002C555E] [002C5A53] [002C7788] [001336BF] [XX000804] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Armor Penetration skill will now apply bonuses to melee weapons. [0027DF94] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- Removed unnecessary check on the Lasers Skill level 4 that the current weapon is not Ballistic or EM based. [002C59DD] - [Fix contributed by Argonil](https://www.nexusmods.com/starfield/users/3424782) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5660) - [Reported by Argonil](https://www.starfieldpatch.dev/issues/433)
- The Lasers skill will no longer incorrectly apply bonuses to Particle weapons too. [002C59DD] - [Fix contributed by AmpHound](https://www.nexusmods.com/starfield/users/84381438) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5649) - [Reported by AmpHound](https://www.starfieldpatch.dev/issues/358)
- The chemical formula for Benzene has been corrected from C6Hn to C6H6 [00005585] [000057E7] - [Fix contributed by SarthesArai](https://www.nexusmods.com/starfield/users/3027236) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5874) - [Reported by SarthesArai](https://www.starfieldpatch.dev/issues/367)
- Scenes with Andreja and Sam Coe will no longer start if the player has not started "Foreknowledge". [0003BD74] [000D3AE9] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/423)
- Added a new conditional check to verify if the player is yet to start "Foreknowledge". [XX000800] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/423)
- Sarah Morgan will no longer have dialogue about saving Barrett, Andreja or Sam Coe when they have died. [001D56B1] [001D56B2] [001D56B3] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/375)
- Fixed an issue where certain dialogue would not fire if the Leadership skill was selected as it changes some AVs to 1.15 where the check is looking for exactly 1.0 [00127C2F] [001E8342] [001E8343] [001E8344] [001E8345] [001E8347] [001E8348] [001E8349] [001E834A] [001E999D] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/374)
- The correct scene will now play for Sam, Sarah and Andreja after breaking up with them and asking about your friendship. The prompt should have been "What if I said I wanted to get back together?" instead of "What if I said I wanted more?" [0023EB56] [002B4AB4] 
[001E9CC0] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/371)
- Adjusted the conditions controlling companion romance to be more robust [00333D8B] [00333D8D] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/371)
- Andreja should not longer have dialogue referring to Sarah or Sam dying if Barrett was killed during High Price to Pay [0003BDD9] [0003BDDA] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/423)
- Sarah, Andreja and Sam Coe will no longer comment as if they are boarding your ship when entering other ships or space stations [0023ED95] [000109AD] [001E9E43] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/422)
- Cora Coe will now correctly join the player's crew when Sam is recruited as a companion or crew member in NG+ [qf_mq401_001dc45e] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/369)
- The variable indicating that you had previously completed Sam Coe's commitment questline will now be properly set.  [qf_com_quest_samcoe_commitme_000df7ad] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/372)
- The variable indicating that you had previously met Lillian during Sam Coe's questline will now be properly set. [qf_mq401_001dc45e] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/373)
- The doors to Coe Estate will now properly unlock on entering NG+ [qf_mq401_001dc45e] - [Fix contributed by Aurelianis](https://www.nexusmods.com/starfield/users/143884143) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5823) - [Reported by Aurelianis](https://www.starfieldpatch.dev/issues/370)
- Trade Tower: Stroud-Eklund Corp [0023422C] , Trade Tower: CeltCorp [002344AC], Euphorika [002BF4E4], Trade Tower: Bayu's Penthouse [001FE65E], Trade Tower: Astral Lounge [00279D05], Warehouse 01 [002BF5F8], Warehouse 02 [002BF600], Warehouse 03 [002BF603], Warehouse 04 [00045647], Trade Tower: Kore Kinetics [002344AD], Freestar Rangers Outpost [002BF625], Trade Tower: Sky Suite [001FE65F], Neon Warehouse [0020BD9B], Madame Sauvage's Place [002BF5F4], Trade Tower: Xenofresh Fisheries [002344AE], Volii Hotel [002BF4E6], Stroud Eklund Showroom [00117814], Nyx's Apartment [002BF5F5], Neon Security [002BF5F6], Enhance! [0000115E], Legrande's Liquors [00051BB8], The Emporium [0000115F], Neon Mining League [00051BB9], Trade Tower: Generdyne Industries [002344AA], Sieghart's Outfitters [00051BBA], Neon: Apartment [000D0DFD], Reliant Medical [00051BBB] will now inherit the correct gravity multiplier from Volii Alpha (Neon) rather than using 1.0. - [Fix contributed by Krevil](https://nexusmods.com/users/7064860) - [Reported by Krevil](https://www.starfieldpatch.dev/issues/363)
- Cartwright Manor [000BFA18], Lance Estate [00006D42], CityAkilaCityCoeMuseum [0033B76A], Akila City Barracks [0032AA97], CityAkilaCityEntrance [0033B76B], Langston Manor [0000115A], Midtown Minerals [00098046], Akila City Consulate [00025E24], Stoneroot Inn [000F73DF], Laredo Firearms [00029DB3], Player House The Stretch [0011FC1D], Henry Filburn's House [000C5993], Coe Estate [002A07D2], Trade Authority [001A0B99], Galbank [002A07D3], Player House The Core [00117A0B], CityAkilaCityFilburnAgricultural [001A0B03], Sanctum Universum [001A0D71], House of the Englightened [001A0B23], Weston Filburn's House [0010C8A2], Starrett House [0010C8A3], Akila Prison [0033B769] will now inherit the correct gravity multiplier from Akila (Akila City) rather than using 1.0. - [Fix contributed by Krevil](https://nexusmods.com/users/7064860) - [Reported by Krevil](https://www.starfieldpatch.dev/issues/363)
- The Well [000F4ED4], UC Distribution [0025C678], Vanguard Exam Center [0028D868], Va'ruun Embassy Lobby [0002CBAB], House Va'ruun Embarassy [00017305], Outland [0025C679], Military Wing [0027DE73], Galbank Archives [002363C6], Armistice Archives [0027A1FC], Reliant Medical [000FE29D], Apollo Tower Floor 3 [0000CBCD], Sanctum Universum [00014CBF], Freestar Collective Embassy [00017307], Jemison Mercantile Store Room [001928C2], EIT Clothiers [0025C686], Scientific Wing [0027E165], Subsection Seven [002CAA01], UC Secutiy Office [0025C673], Centaurian Arsenal [0025C687], Argos Extractors Office [0020C619], MAST Administrative Division [002AAE8C], CJ's [0025C675], Kid Stuff Apartment [00045B25], Athena Tower Floor 7 [00139E24], Orion Tower Floor 9 [00261AF4], Vanguard Orientation Hall [002C5400], The Lodge [0006BB29], Player House Apartment [0021966F] will now inherit the correct gravity multiplier from Jemison (New Atlantis) rather than using 1.0. - [Fix contributed by Krevil](https://nexusmods.com/users/7064860) - [Reported by Krevil](https://www.starfieldpatch.dev/issues/363)
- Hotel Paradiso [00244CA8] will now inherit the correct gravity multiplier from Porrima II rather than using 1.0. - [Fix contributed by Krevil](https://nexusmods.com/users/7064860) - [Reported by Krevil](https://www.starfieldpatch.dev/issues/363)
- The Eleos Retreat [002A4393] will now inherit the correct gravity multiplier from Ixyll II rather than using 1.0. - [Fix contributed by Krevil](https://nexusmods.com/users/7064860) - [Reported by Krevil](https://www.starfieldpatch.dev/issues/363)
- Arches Overlook Apartments [00167935], Apartment Stack I [00169EC1] will now inherit the correct gravity multiplier from Gargarin rather than using 1.0. - [Fix contributed by Krevil](https://nexusmods.com/users/7064860) - [Reported by Krevil](https://www.starfieldpatch.dev/issues/363)
- The Pit Stop [00295334], HopeTech [00295336] will now inherit the correct gravity multiplier from Polvo (Hope Town) rather than using 1.0. - [Fix contributed by Krevil](https://nexusmods.com/users/7064860) - [Reported by Krevil](https://www.starfieldpatch.dev/issues/363)
- Fixed a typo in the player dialogue when talking to Barrett about Ryujin Industries [0035B249] - [Reported by TheTritch](https://www.starfieldpatch.dev/issues/383)
- Fixed an incorrect texture overlay on SysDef Ace Spacesuit [002AAF44] and SY-920 Pilot Spacesuit [00214769] - [Fix contributed by grandvil](https://nexusmods.com/users/1656105) - [Report by grandvil](https://www.starfieldpatch.dev/issues/381)


## [2023-10-25] Version 0.0.1
- EM Weapon Systems skill ranks 1-3 have been modified to multiply EM damage by 1.1x/1.2x/1.3x instead of all 3 ranks applying a 2.0x multiplier. This brings it in line with perk description. [002C53B2] - [Fix contributed by rux616](https://nexusmods.com/users/124191) - [Reported by rux616](https://www.starfieldpatch.dev/issues/357)
- EM Weapon Systems skill rank 4 has been corrected to apply a boost to EM damage rather than hull damage. [002C53B2] - [Fix contributed by rux616](https://nexusmods.com/users/124191) - [Reported by rux616](https://www.starfieldpatch.dev/issues/357)
- Missile Weapon Systems skill Rank 4 modified to add a recharge rate modifier of 1.2 and remove the reload speed modifier of 0.8 to correctly represent the increase from Rank 3. [002C5558] - [Fix contributed by rux616](https://nexusmods.com/users/124191) - [Reported by rux616](https://www.starfieldpatch.dev/issues/348)
- Rejuvenation skill ranks 3 and 4 new correctly allow the player to regain health while in combat. [0012601A] [0012601B] - [Fix contributed by rux616](https://nexusmods.com/users/124191) - [Reported by Qeric99](https://www.starfieldpatch.dev/issues/141)
- EMP-80 Suppressor ship weapon now has a "Magazine Size" of 0, allowing the weapon to smoothly recharge from 0-100 on the HUD. [002184C1] - [Fix contributed by rux616](https://nexusmods.com/users/124191) - [Reported by rux616](https://www.starfieldpatch.dev/issues/350)
- EMP-200 Suppressor ship weapon now has a "Magazine Size" of 0, allowing the weapon to smoothly recharge from 0-100 on the HUD. [002184B7] - [Fix contributed by rux616](https://nexusmods.com/users/124191) - [Reported by rux616](https://www.starfieldpatch.dev/issues/351)
- EMP-500 Suppressor ship weapon now has a "Magazine Size" of 0, allowing the weapon to smoothly recharge from 0-100 on the HUD. [002184A7] - [Fix contributed by rux616](https://nexusmods.com/users/124191) - [Reported by rux616](https://www.starfieldpatch.dev/issues/352)
- EMP-1000 Suppressor ship weapon now has a "Magazine Size" of 0, allowing the weapon to smoothly recharge from 0-100 on the HUD. [002184A6] - [Fix contributed by rux616](https://nexusmods.com/users/124191) - [Reported by rux616](https://www.starfieldpatch.dev/issues/353)
- Disruptor 3320 Neutron Turret ship weapon now has a "Magazine Size" of 0, preventing the weapon from firing at normal rate until its magazine was exhausted even if the player didn't set the power to max. [0014A8CD] - [Fix contributed by rux616](https://nexusmods.com/users/124191) [Reported by rux616](https://www.starfieldpatch.dev/issues/354)
- Disruptor 3320 Neutron Turret ship weapon now has a "Recharge Delay" of 0 as non-automatic weapons should not have a delay. [0014A8CD] - [Fix contributed by rux616](https://nexusmods.com/users/124191) [Reported by rux616](https://www.starfieldpatch.dev/issues/354)
- Marauder 115N Railgun Turret ship weapon now has a "Magazine Size" of 0, preventing the weapon from firing at normal rate until its magazine was exhausted even if the player didn't set the power to max. [00025FB6] - [Fix contributed by rux616](https://nexusmods.com/users/124191) [Reported by rux616](https://www.starfieldpatch.dev/issues/355)
- Obliterator 250MeV Alpha Turret ship weapon now has a "Magazine Size" of 0, preventing the weapon from firing at normal rate until its magazine was exhausted even if the player didn't set the power to max. [00025FB4] - [Fix contributed by rux616](https://nexusmods.com/users/124191) [Reported by rux616](https://www.starfieldpatch.dev/issues/356)
- The number of undiscovered temples shown in the UI will now match how many are actually undiscovered. [starborntemplequestscript] - [Fix contributed by Krevil](https://www.nexusmods.com/users/7064860) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5114) - [Reported by zarantha](https://www.starfieldpatch.dev/issues/231)
- Constellation companions no longer have the wrong dialogue in NG+ after completing "Foreknowledge". [qf_mq204_002c6d74] - [Fix contributed by Krevil](https://www.nexusmods.com/users/7064860) - [Nexus Mods Page](https://www.nexusmods.com/starfield/mods/5319) - [Reported by Krevil](https://www.starfieldpatch.dev/issues/164)
- Companions will no longer become angry at the player for boarding a hostile ship and attacking the crew. [bescript] - [Fix contributed by wSkeever](https://www.nexusmods.com/users/7064860) - [v0.0.1 from Nexus Mods Page](https://www.nexusmods.com/starfield/mods/4848) - [Reported by wSkeever](https://www.starfieldpatch.dev/issues/323)
- Neon Security will no longer say you have a bounty even if you've never been arrested. [qf_dialogueneonconvo_securit_0032c7c0] - [Fix contributed by wSkeever](https://www.nexusmods.com/users/7064860) - [v0.0.1 from Nexus Mods Page](https://www.nexusmods.com/starfield/mods/4763) - [Reported by wSkeever](https://www.starfieldpatch.dev/issues/319)
- Companions will now correctly comment on the player's appearance changing. (This was caused by 
companionaffinityeventsscript referencing "LooksMenu" instead of "ChargenMenu") [companionaffinityeventsscript] - [Fix contributed by Bobbyclue](https://github.com/Starfield-Community-Patch/Starfield-Community-Patch/pull/259)
- Player characters will no longer get stuck headtracking to the left while sprinting or jumping for a long time. [Fix contributed by Monitor144hz](https://www.nexusmods.com/starfield/users/118625818) - [Issue](https://www.starfieldpatch.dev/issues/247) - [v1.1.1 from Nexus Mods Page](https://www.nexusmods.com/starfield/mods/2370)
- Fixed a typo in the English translation of the 3 Scan Jammer components in the ship builder. co_SMS_ScanJammer01[001AD84D], co_SMS_ScanJammer02_DualFrequency[001AD84C], co_SMS_ScanJammer03_MultiFrequency[001AD84B] [Issue reported by Daymarr](https://www.starfieldpatch.dev/issues/22)
- Fixed a typo in the English translation of the perk description for Peak Performance 05. MagPerk_PeakPerformance[00202D9F] [Issue reported by Jiopaba](https://github.com/Starfield-Community-Patch/Starfield-Community-Patch/issues/26)
- Fixed a typo in a greeting line for Nikau Henderson in Deimos Staryard. [0027104E] - [Reported by sleepysugarlump](https://www.starfieldpatch.dev/issues/41)
- Fixed a typo in a dialogue line with The Hunter during MQ106 at Akila City. [0021B2A1] - [Reported by tcranor](https://www.starfieldpatch.dev/issues/101)
- Fixed a typo in the description of the Penetrator Rounds upgrade for several weapons co_gun_mod_HardTarget_Mag_Penetrator[000454B2], co_gun_mod_Lawgiver_Mag_Penetrator[00057561], co_gun_mod_MagSniper_Mag_Penetrator[00045BAF], co_gun_mod_Razorback_Mag_Penetrator[00044C30],co_gun_mod_Regulator_Mag_Penetrator[00057579], co_gun_mod_Tombstone_Mag_Penetrator[00044C4D],co_gun_mod_UrbanEagle_Mag_Penetrator[0007C747] - [Reported by Krevil](https://www.starfieldpatch.dev/issues/136)
- Fixed a misspelling of "pique" in Masako's Dialogue during "Sabotage". [0015E064] - [Reported by wSkeever](https://www.starfieldpatch.dev/issues/260)
- Fixed a typo in Andromeda Kepler's dialogue. [00146104] - [Reported by disasterchief](https://www.starfieldpatch.dev/issues/284)
- Fixed a typo in Helena Strickland's dialogue. [0018E0C1] - [Reported by Drackore](https://www.starfieldpatch.dev/issues/339)
- Fixed a typo in the German translation of Joseph Manning's dialogue [0022D907] - [Reported by SkyHorizon3](https://www.starfieldpatch.dev/issues/345)
- Fixed a typo in the German translation of Issa Ekland's dialogue [002C33C5] - [Reported by SkyHorizon3](https://www.starfieldpatch.dev/issues/345)
- Fixed typos in the German translation of Lin's dialogue during the opening sequence [000131BB] [00019287] - [Reported by SkyHorizon3](https://www.starfieldpatch.dev/issues/345)
- Fixed inconsistencies in the German translation between text and audio in Gideo Anker's dialogue [00051A7B] [00051A7B] [0027BC70] [0027BC6F] [00219542] - [Reported by SkyHorizon3](https://www.starfieldpatch.dev/issues/345)
- Fixed inconsistencies in the German translation between text and audio in Yannick Legrande's dialogue [0012C618] [0021B154] - [Reported by SkyHorizon3](https://www.starfieldpatch.dev/issues/345)

