-- DB update 2024_06_16_03 -> 2024_06_17_00
--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_hand_of_death', 'spell_finger_of_death');
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |128 WHERE `entry` IN (18104, 18095);
