-- DB update 2023_12_10_03 -> 2023_12_11_00
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `SourceEntry` IN (38017, 38140, 38241, 38248) AND `ConditionTypeOrReference` = 31 AND `ConditionValue2` = 22057;

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 22057;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22057 AND `source_type` = 0;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (38017, 38140, 38241, 38248) AND `ScriptName` IN ('spell_lady_vashj_summons', 'spell_gen_select_target_count_7_1');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38017, 'spell_lady_vashj_summons'),
(38140, 'spell_lady_vashj_summons'),
(38241, 'spell_lady_vashj_summons'),
(38248, 'spell_lady_vashj_summons');
