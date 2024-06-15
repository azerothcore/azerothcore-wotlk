-- DB update 2022_12_06_02 -> 2022_12_06_03
-- Fix gossip for trainers
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry` IN (33631, 33636, 33676, 33679, 33680, 33682);

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (33608,33609,33610,33611,33612,33613,33614,33615,33616,33617,33618,33619,33621,33623);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(33608, 1, 0, 0, 1, 0, 0, 0),
(33609, 1, 0, 0, 1, 0, 0, 0),
(33610, 1, 0, 0, 1, 0, 0, 0),
(33611, 1, 0, 0, 1, 0, 0, 0),
(33612, 1, 0, 0, 1, 0, 0, 0),
(33613, 1, 0, 0, 1, 0, 0, 0),
(33614, 1, 0, 0, 1, 0, 0, 0),
(33615, 1, 0, 0, 1, 0, 0, 0),
(33616, 1, 0, 0, 1, 0, 0, 0),
(33617, 1, 0, 0, 1, 0, 0, 0),
(33618, 1, 0, 0, 1, 0, 0, 0),
(33619, 1, 0, 0, 1, 0, 0, 0),
(33621, 1, 0, 0, 1, 0, 0, 0),
(33623, 1, 0, 0, 1, 0, 0, 0);

-- Immune to PC/NPC & CANNOT_TURN - Prevent turning to face player
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|768, `unit_flags2`=`unit_flags2`|32768 WHERE `entry` IN (33608,33609,33610,33611,33612,33613,33614,33615,33616,33617,33618,33619,33621,33623);
