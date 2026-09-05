DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9500) OR (`source_type` = 9 AND `entryorguid` = 950000);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_mistress_nagmara' WHERE `entry` = 9500;
UPDATE `creature_text` SET `Type` = 16 WHERE `CreatureID` = 9503 AND `GroupID` = 5 AND `ID` = 0;

DELETE FROM `script_waypoint` WHERE `entry` = 9503;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES
    (9503, 0, 883.295, -188.926, -43.7037, 0, ''),
    (9503, 1, 872.764, -185.606, -43.7037, 5000, 'Dark Iron Ale - Keg 1'),
    (9503, 2, 867.923, -188.006, -43.7037, 5000, 'Dark Iron Ale - Keg 2'),
    (9503, 3, 863.296, -190.795, -43.7037, 5000, 'Dark Iron Ale - Keg 3'),
    (9503, 4, 856.140, -194.653, -43.7037, 5000, 'Dark Iron Ale - Keg 4'),
    (9503, 5, 851.879, -196.928, -43.7037, 15000, 'Dark Iron Ale - Break keg'),
    (9503, 6, 877.035, -187.048, -43.7037, 0, ''),
    (9503, 7, 891.198, -197.924, -43.6204, 0, 'Return home');
