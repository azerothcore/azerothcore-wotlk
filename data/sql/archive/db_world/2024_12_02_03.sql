-- DB update 2024_12_02_02 -> 2024_12_02_03
--
-- Corrected Z-axis of Eydis Darkbane (to match Fjola Lightbane's Z-axis).
UPDATE `creature` SET  `position_z` = 558.16 WHERE `guid` = 85120 AND `id1` = 36066;
