-- DB update 2026_04_10_00 -> 2026_04_10_01
--
UPDATE `creature_template_addon` SET `auras` = '70203' WHERE `entry` IN (37126, 38258);
