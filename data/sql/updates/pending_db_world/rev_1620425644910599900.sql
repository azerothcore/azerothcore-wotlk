INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620425644910599900');

-- Delete WP path info for minions
DELETE FROM `creature_addon` WHERE `guid` IN (6973, 6975, 6974 ,6989 ,7210);

-- Create group
SET @leader:=7209;
DELETE FROM `creature_formations` WHERE `leaderGUID`=@leader;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(@leader, @leader, 5, 0, 2, 0, 0), -- core
(@leader, 6973, 8, 90, 2, 0, 0),
(@leader, 6975, 14, 140, 2, 0, 0),
(@leader, 6974, 16, 210, 2, 0, 0),
(@leader, 6989, 12, 260, 2, 0, 0),
(@leader, 7210, 10, 320, 2, 0, 0);

