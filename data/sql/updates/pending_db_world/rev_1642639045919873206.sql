INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642639045919873206');

#closes #10227
UPDATE creature_template SET `unit_flags`=0, `AIName`='SmartAI', `lootid`=4109, `flags_extra`=0, `MovementType`=0, `movementId`=144 WHERE `entry`=6139;
UPDATE creature SET `position_x`=-4984.9, `position_y`=-937.388, `position_z`=-5.29753, `orientation`=4.69668 WHERE `guid`=21706;
UPDATE creature SET `position_x`=-5162.59, `position_y`=-1230.09, `position_z`=49.3377, `orientation`=2.13627 WHERE `guid`=21708;
