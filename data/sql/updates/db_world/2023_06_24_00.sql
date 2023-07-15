-- DB update 2023_06_23_01 -> 2023_06_24_00
--
UPDATE `smart_scripts` SET `action_param2`=0 WHERE `entryorguid`=1651800 AND `source_type`=9 AND `id` IN (2, 6);

UPDATE `creature_template` SET `faction`=7 WHERE `entry`=16534;
