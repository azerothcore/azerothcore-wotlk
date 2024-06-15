-- DB update 2023_03_16_04 -> 2023_03_16_05
--
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60 WHERE `entry` IN (18703,20700);
UPDATE `smart_scripts` SET `action_type`=49, `action_param1`=0, `target_type`=21, `target_param1`=30, `comment`='Sethekk Spirit - On Summon - Attack nearest player' WHERE `entryorguid`=18703 AND `source_type`=0 AND `id`=0;
DELETE FROM `creature_template_addon` WHERE `entry`=18703;
INSERT INTO `creature_template_addon` VALUES
(18703,0,0,0,1,0,0,'24051');
