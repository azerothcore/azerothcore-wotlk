-- DB update 2022_11_21_08 -> 2022_11_21_09
-- 
DELETE FROM `creature` WHERE `guid` = 85566;
UPDATE `creature_template_addon` SET `emote` = 234 WHERE `entry` = 18595;
