-- DB update 2022_05_08_02 -> 2022_05_08_03
--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_vem_knockback', 'spell_vem_vengeance');
DELETE FROM `spell_script_names` WHERE `spell_id` = 18670; -- Delete the current script to prevent stacking.
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(18670, 'spell_vem_knockback'),
(25790, 'spell_vem_vengeance');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|33554432, `flags_extra` = `flags_extra`|128 WHERE `entry` = 15933;

DELETE FROM `creature_template_addon` WHERE `entry` = 15933;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(15933, '25786 26575');

DELETE FROM `creature_text` WHERE `CreatureID` IN (15511, 15543, 15544);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(15511, 0, 0, '%s is devoured!', 16, 0, 100, 0, 0, 0, 11115, 0, 'Lord Kri - EMOTE_DEVOURED'),
(15543, 0, 0, '%s is devoured!', 16, 0, 100, 0, 0, 0, 11115, 0, 'Princess Yauj - EMOTE_DEVOURED'),
(15544, 0, 0, '%s is devoured!', 16, 0, 100, 0, 0, 0, 11115, 0, 'Vem - EMOTE_DEVOURED');
