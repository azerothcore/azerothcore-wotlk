-- DB update 2022_05_01_01 -> 2022_05_03_00
-- Fix for the levitate issue
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 2.14286, `flags_extra` = `flags_extra`|512 WHERE `entry` = 14517;
UPDATE `creature_template_movement` SET `Flight` = 0 WHERE `CreatureId` = 14517;
-- Update Emotes
DELETE FROM `creature_text` WHERE `CreatureID` = 14517 AND `GroupID` IN (3,4);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(14517,3,0,'%s emits a deafening shriek!',16,0,100,0,0,0,10370,0,'High Priestess Jeklik - EMOTE_SUMMON_BATS'),
(14517,4,0,'%s begins to cast a Great Heal!',16,0,100,0,0,0,10494,0,'High Priestess Jeklik - EMOTE_GREAT_HEAL');
