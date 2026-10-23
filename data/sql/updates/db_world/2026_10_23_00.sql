-- DB update 2026_10_22_01 -> 2026_10_23_00
--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3414600, 3415000, 3415100) AND `source_type` = 9;
