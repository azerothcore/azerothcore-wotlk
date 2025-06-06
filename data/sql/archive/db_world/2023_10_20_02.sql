-- DB update 2023_10_20_01 -> 2023_10_20_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_calling_korkron_or_wildhammer';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38249, 'spell_calling_korkron_or_wildhammer'),
(38119, 'spell_calling_korkron_or_wildhammer');

UPDATE `creature_template` SET `ScriptName`='npc_korkron_or_wildhammer' WHERE `entry` IN (22059, 21998);

UPDATE `creature_template` SET `speed_run` = 2.28571 WHERE `entry` IN (22059, 21998);

SET @NPC_WILDHAMMER_GRYPHON_RIDER := 22059;
DELETE FROM `creature_text` WHERE `CreatureID`=@NPC_WILDHAMMER_GRYPHON_RIDER;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NPC_WILDHAMMER_GRYPHON_RIDER, 0, 0, 'What is it, $r? Have you gathered some new information?', 12, 0, 100, 0, 0, 0, 19742, 0, 'SAY_LAND');

SET @NPC_KORKRON_WIND_RIDER := 21998;
DELETE FROM `creature_text` WHERE `CreatureID`=@NPC_KORKRON_WIND_RIDER;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NPC_KORKRON_WIND_RIDER, 0, 0, 'Speak quickly, $n. We haven\'t much time!', 12, 0, 100, 0, 0, 0, 19675, 0, 'SAY_LAND');
