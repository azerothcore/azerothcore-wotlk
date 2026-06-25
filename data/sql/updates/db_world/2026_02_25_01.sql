-- DB update 2026_02_25_00 -> 2026_02_25_01
DELETE FROM `smart_scripts` WHERE `entryorguid` = 194569 AND `source_type` = 1 AND `id` IN (0, 1, 2);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 2 AND `SourceEntry` = 194569 AND `SourceId` = 1;
DELETE FROM `spell_script_names` WHERE `spell_id` IN (64014, 64024, 64025, 64028, 64029, 64030, 64031, 64032, 65042);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(64014, 'spell_ulduar_teleporter'),
(64024, 'spell_ulduar_teleporter'),
(64025, 'spell_ulduar_teleporter'),
(64028, 'spell_ulduar_teleporter'),
(64029, 'spell_ulduar_teleporter'),
(64030, 'spell_ulduar_teleporter'),
(64031, 'spell_ulduar_teleporter'),
(64032, 'spell_ulduar_teleporter'),
(65042, 'spell_ulduar_teleporter');
