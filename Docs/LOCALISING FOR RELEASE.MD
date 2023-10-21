# Supported Languages

The Starfield Community Patch aims to fix issues with the game across all locales supported by the base game. These are listed below.

- English (EN)
- German (DE)
- French (FR)
- Italian (IT)
- Spanish (ES)
- Polish (PL)
- Japanese (JA)
- Brazilian Portuguese (PTBR)
- Chinese - Simplified (ZHHANS)

This is acheived by a localisation step that **must** be performed as a required final step before the mod is released to the community.

The Starfield Community Patch project should be an unlocalised plugin using English text during development. Fixes for localisations other than English should be applied last and can be saved for future releases using the Dictionary feature of xTranslator by McGuffin. This article will cover the process to apply these translations and create the required localisation files for a release. 

# Including non-English typo fixes
For each release, any non-English typo fixes should be prepared as a batch and processed at the end of the update process.

## Check the required FormIDs have been forwarded to StarfieldCommunityPatch.esm
Each typo fix should include the Form ID from the base game plugin it references. You should find this and add it to the issue if it's not provided by the submitter. 

In the development plugin, use xEdit to ensure that all records that need to be fixed are included. If they are not present, you can add them without making any edits by right-clicking on the form and selecting "Copy as Override". Make sure it appears as a green row once copied over so no changes to the English text have been made.

These records will be considered ITMs so we should never clean the patch of ITMs automatically. 

## Localise the English version of the plugin
Once all records have been copied over it is time to start localising. **Make a backup of your development plugin before doing this!**

Right click the plugin name in xEdit, go to "Other" in the menu then "Localise" -> "Localise Plugin". This will generate the English `.strings` files. Once this step completes, save the plugin and new strings files then exit xEdit.

## Set up dictionaries
We'll now use [xTranslator by McGuffin](https://www.nexusmods.com/starfield/mods/313) to both retain the original text in non-English languages and apply any corrections to the various locales. 

Before you start editing, make sure you've got the latest version of the dictionaries for StarfieldCommunityPatch.esm. If you're not sure how to get these, please check with another member of the team. 

The dictionaries should be named as below:

- starfieldcommunitypatch_en_de.sst
- starfieldcommunitypatch_en_es.sst
- starfieldcommunitypatch_en_fr.sst
- starfieldcommunitypatch_en_it.sst
- starfieldcommunitypatch_en_ja.sst
- starfieldcommunitypatch_en_pl.sst
- starfieldcommunitypatch_en_ptbr.sst
- starfieldcommunitypatch_en_zhhans.sst


Dictionaries can be placed in the `UserDictionaries\Starfield` folder next to xTranslator.exe or can be imported from the menu under "Import Translation" -> "SST Dictionary". 

## Create translations

Luckily, xTranslator is a very powerful tool that can import the correct localisation from the Starfield.esm files if it hasn't been changed. This will allow for English typo fixes and unedited strings to line up with the non-English counterparts again.

Inside xTranslator open "Options" -> "Dictionaries and Languages" from the menu bar. Ensure the source language is `EN` and set the destination language to `DE`. The do the following:

1. In the lower pain of the UI select the "Vocabulary" tab. 
2. In the list of Dictionaries, click `starfield` then right-click on it and select "Apply SST".
3. In the pop-up select "Everything but already validated strings" under "Overwrite".
4. Select "Use FormID references" under "Mode". Ensure the checkboxes below are unchecked.
5. Press "Ok".
6. Review the translations that should now apply to all strings. 
7. Any rows that have an orange or yellow warning icon in the right column may need to be reviewed. If they look correct, select the row and press F1.
8. On the menu bar, click the drop-down arrow next to the search and select "Search in EDID/FormID".
9. Paste in the form ID for each correction required for the current language.
10. Double-click the row to open the editor and update the text in the bottom-right field. Click save to accept your changes.
11. Press Ctrl + S to update your dictionaries with these changes.
12. On the menu bar select "File" -> "Finalise STRINGS" to save out the file.

Repeat this process for every locale that is supported, applying the required corrections each time. 

Once all edits have been made, ensure you collect the new `.strings` files from `Starfield/Data/Strings`. These will need to be packed into the BA2 for release. 

## Share your updated dictionaries
Make sure to share your updated dictionaries after releasing so that the next person to release a build can use them. 