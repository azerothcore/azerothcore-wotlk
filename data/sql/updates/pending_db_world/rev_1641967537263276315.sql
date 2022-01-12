INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641967537263276315');

-- Fix DB Errors
UPDATE `smart_scripts` SET `action_param2`=0 WHERE `entryorguid`=18842200 AND `source_type`=9 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `action_param5`=0 WHERE `entryorguid` IN(17635300, 17635100, 17635000, 17634900, 17634600) AND `source_type`=9 AND `id`=2 AND `link`=0;
UPDATE `smart_scripts` SET `target_param3`=0 WHERE `entryorguid`=3849300 AND `source_type`=9 AND `id`IN(6,5,4,3,2,1) AND `link`=0;
UPDATE `smart_scripts` SET `target_param3`=0 WHERE `entryorguid`=3784600 AND `source_type`=9 AND `id` IN(7,6,3,2) AND `link`=0;
UPDATE `smart_scripts` SET `action_param5`=0 WHERE `entryorguid`=3122200 AND `source_type`=9 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `action_param5`=0 WHERE `entryorguid`=3113506 AND `source_type`=9 AND `id` IN(4,3,0) AND `link`=0;
UPDATE `smart_scripts` SET `action_param5`=0 WHERE `entryorguid`=3122200 AND `source_type`=9 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `action_param1`=0 WHERE `entryorguid`=2972400 AND `source_type`=9 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `action_param1`=0 WHERE `entryorguid`=2816101 AND `source_type`=9 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `target_param1`=0 WHERE `entryorguid`=2719901 AND `source_type`=9 AND `id`=7 AND `link`=0;
UPDATE `smart_scripts` SET `target_param2`=0 WHERE `entryorguid`=2483500 AND `source_type`=9 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `target_param1`=0 WHERE `entryorguid`=2471100 AND `source_type`=9 AND `id` IN(6,5,4,3,2,1,0)  AND `link`=0;
UPDATE `smart_scripts` SET `target_param2`=0 WHERE `entryorguid`=2361600 AND `source_type`=9 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `target_param1`=0 WHERE `entryorguid`=2361600 AND `source_type`=9 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param2`=0 WHERE `entryorguid`=2297900 AND `source_type`=9 AND `id`=3 AND `link`=0;
UPDATE `smart_scripts` SET `target_param3`=0 WHERE `entryorguid`=2245802 AND `source_type`=9 AND `id` IN(21,17,16,15,14,12,11,10,5,4,3,2) AND `link`=0;
UPDATE `smart_scripts` SET `target_param3`=0 WHERE `entryorguid`=2245801 AND `source_type`=9 AND `id` IN(7,6,5,4) AND `link`=0;
UPDATE `smart_scripts` SET `target_param3`=0 WHERE `entryorguid`=2245800 AND `source_type`=9 AND `id` IN(3,2,1,0) AND `link`=0;
UPDATE `smart_scripts` SET `action_param6`=0 WHERE `entryorguid`=2297900 AND `source_type`=9 AND `id`=6 AND `link`=0;
UPDATE `smart_scripts` SET `target_param3`=0 WHERE `entryorguid`=2163300 AND `source_type`=9 AND `id` IN(3,2) AND `link`=0;
UPDATE `smart_scripts` SET `action_param1`=0 WHERE `entryorguid`=1967105 AND `source_type`=9 AND `id`=5 AND `link`=0;
UPDATE `smart_scripts` SET `action_param1`=0 WHERE `entryorguid`=1641500 AND `source_type`=9 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `action_param1`=0 WHERE `entryorguid`=1640700 AND `source_type`=9 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `target_param2`=0 WHERE `entryorguid`=1235200 AND `source_type`=9 AND `id`=4 AND `link`=0;
UPDATE `smart_scripts` SET `target_param3`=0 WHERE `entryorguid`=1233900 AND `source_type`=9 AND `id` IN(14,13,12,11,10,9,8,7,6,5,4,3) AND `link`=0;
UPDATE `smart_scripts` SET `action_param6`=0 WHERE `entryorguid`=1233900 AND `source_type`=9 AND `id` IN(2,1) AND `link`=0;
