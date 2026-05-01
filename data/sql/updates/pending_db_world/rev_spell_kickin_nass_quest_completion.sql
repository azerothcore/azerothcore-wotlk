
UPDATE `quest_template_addon` SET `SourceSpellID` = 51889 WHERE (`ID` = 12630);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28518;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28518) AND (`source_type` = 0) AND (`id` IN (3));

UPDATE `spell_script_names` SET `ScriptName` = 'spell_kickin_nass_quest_completion' WHERE (`spell_id` = 51910);
