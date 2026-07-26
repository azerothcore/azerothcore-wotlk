-- DB update 2026_06_28_00 -> 2026_06_28_01
--
-- 62375 Gathering Speed is not removed by Evade
-- SPELL_ATTR0_CU_IGNORE_EVADE = 0x00000800
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 62375;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (62375, 0x800);

-- Flame Leviathan
UPDATE `creature_template_addon` SET `visibilityDistanceType` = 4 WHERE (`entry` IN (33113, 33114, 33139, 34003, 34111, 33143));

-- Ulduar Colossus
UPDATE `creature_addon` SET `visibilityDistanceType`=4 WHERE `guid` IN (137476, 137477, 137478, 137479, 137480);
