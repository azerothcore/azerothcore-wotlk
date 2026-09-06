-- DB update 2025_01_23_03 -> 2025_01_23_04
--
UPDATE `creature_template_movement` SET `Rooted`= 1, `Flight` = 1 WHERE `CreatureId` = 24666;
