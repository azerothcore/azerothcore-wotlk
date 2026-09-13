-- DB update 2026_09_11_00 -> 2026_09_11_01
--
UPDATE `creature_template_movement` SET `Flight` = 0 WHERE `CreatureId` IN (33186, 33724);
