-- DB update 2022_09_19_06 -> 2022_09_19_07
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-44543,74396);
INSERT INTO `spell_script_names` VALUES
(-44543, 'spell_mage_fingers_of_frost_proc_aura'),
(74396, 'spell_mage_fingers_of_frost_proc');

UPDATE `spell_proc_event` SET `procPhase`=7 WHERE `entry` IN (44543,44545);
