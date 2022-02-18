INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645202981799134977');

-- Fix equipment for PR #10453
UPDATE `creature` SET `equipment_id`=1 WHERE `guid` IN (45782,45783,45784,45785,45786,45787,45788);
-- Fix equipment for PR #9935
UPDATE `creature` SET `equipment_id`=1 WHERE `id1`=16333;
-- Fix equipment for PR #9818
UPDATE `creature` SET `equipment_id`=1 WHERE `id1`=16317;
-- Fix equipment for PR #9784
UPDATE `creature` SET `equipment_id`=1 WHERE `id1`=16315;
-- Fix equipment for PR #9751
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (16344,16469);
-- Fix equipment for PR #9750
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (16345,16346);
-- Fix equipment for PR #9696
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (16330,17210);
-- Fix equipment for PR #9693
UPDATE `creature` SET `equipment_id`=1 WHERE `id1` IN (16325,16326);
-- Fix equipment for PR #9678
UPDATE `creature` SET `equipment_id`=1 WHERE `id1`=16332;
