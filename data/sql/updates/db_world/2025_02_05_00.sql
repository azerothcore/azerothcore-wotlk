-- DB update 2025_02_04_00 -> 2025_02_05_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (45370, 45367);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45370, 'spell_gen_translocate_down'),
(45367, 'spell_gen_translocate_up');

UPDATE `conditions` SET `ConditionValue2` = 187428, `Comment` = 'Translocation (Up)' WHERE `SourceEntry` = 45368 AND `SourceTypeOrReferenceId` = 13;
UPDATE `conditions` SET `ConditionValue2` = 187431, `Comment` = 'Translocation (Down)' WHERE `SourceEntry` = 45371 AND `SourceTypeOrReferenceId` = 13;
