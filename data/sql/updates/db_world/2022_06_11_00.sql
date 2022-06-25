-- DB update 2022_06_09_01 -> 2022_06_11_00
-- Add Chinese translation of road signs
DELETE FROM `gameobject_template_locale` WHERE `entry` IN (184084,176365,176364) AND `locale` = 'zhCN';
INSERT INTO `gameobject_template_locale` (`entry`, `locale`, `name`, `castBarCaption`, `VerifiedBuild`) VALUES 
(184084, 'zhCN', '开往秘蓝岛的船只', '', 18019),
(176365, 'zhCN', '开往泰达希尔的船只', '', 18019),
(176364, 'zhCN', '开往暴风城的船只', '', 18019); 
