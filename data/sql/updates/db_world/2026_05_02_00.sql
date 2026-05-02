-- DB update 2026_05_01_04 -> 2026_05_02_00
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28006 AND `id` = 7);

UPDATE `vehicle_template_accessory` SET `summontype` = 1, `summontimer` = 30000
    WHERE `entry` = 28018 AND `accessory_entry` = 28006;
