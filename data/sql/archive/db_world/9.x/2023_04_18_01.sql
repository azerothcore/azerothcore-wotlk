-- DB update 2023_04_18_00 -> 2023_04_18_01
--
UPDATE `smart_scripts` SET `action_type`=134 WHERE `action_type` = 85;
DELETE FROM `smart_scripts` WHERE `entryorguid`=25418 AND `source_type`=0 AND `id`=4 AND `link`=5;
DELETE FROM `smart_scripts` WHERE `entryorguid`=25416 AND `source_type`=0 AND `id`=4 AND `link`=5;
DELETE FROM `smart_scripts` WHERE `entryorguid`=33518 AND `source_type`=0 AND `id`=3 AND `link`=0;
