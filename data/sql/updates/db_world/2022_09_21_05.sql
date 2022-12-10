-- DB update 2022_09_21_04 -> 2022_09_21_05
--
UPDATE `creature` SET `phaseMask`=16 WHERE `guid` IN (246011,246009);
UPDATE `creature` SET `phaseMask`=8 WHERE `guid` IN (246036,246098);

UPDATE `creature_template` SET `unit_flags`=`unit_flags`|770 WHERE `entry` IN (15072,15065,15066,15071);
