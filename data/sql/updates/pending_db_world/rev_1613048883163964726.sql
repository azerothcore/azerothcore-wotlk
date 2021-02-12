INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613048883163964726');

-- Move Megelon the Draenei starting NPC

UPDATE `creature` SET `position_x`=-3962, `position_y`=-13926.32, `position_z`=101.13,`orientation`=4.1889 WHERE `guid`=57173;
