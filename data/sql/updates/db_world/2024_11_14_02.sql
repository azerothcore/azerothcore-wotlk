-- DB update 2024_11_14_01 -> 2024_11_14_02
--
DELETE FROM `spell_script_names` WHERE `spell_id`=36450 AND `ScriptName`='spell_kaelthas_resurrection';
DELETE FROM `spell_script_names` WHERE `spell_id`=36709 AND `ScriptName`='spell_kaelthas_kael_phase_two';
-- fix entry from 19871 to Kael'thas for ID - 36709 Kael Phase Two
UPDATE `conditions` SET `ConditionValue2` = 19622 WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 36709) AND (`SourceId` = 0) AND (`ConditionTypeOrReference` = 31);
