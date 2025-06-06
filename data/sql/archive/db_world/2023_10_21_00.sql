-- DB update 2023_10_20_05 -> 2023_10_21_00
-- Yehkinya Bramble
DELETE FROM `spell_script_names` WHERE `spell_id`=12699 AND `ScriptName`='spell_gen_yehkinya_bramble';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (12699, 'spell_gen_yehkinya_bramble');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 12699) AND (`SourceId` = 0);
