INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1608331608234968600');

-- Update inicial NPCs positions
UPDATE `creature` SET `position_x`=-6214.805, `position_y`=328.701, `position_z`=383.514, `orientation`=2.686 WHERE `guid`=351; -- Sten Stoutarm
UPDATE `creature` SET `position_x`=-3987.618, `position_y`=-13874.763, `position_z`=91.132, `orientation`=4.785 WHERE `guid`=57173; -- Megelon
UPDATE `creature` SET `position_x`=-606.627, `position_y`=-4251.340, `position_z`=38.957, `orientation`=3.175 WHERE `guid`=3442; -- Kaltunk
UPDATE `creature` SET `position_x`=1678.629, `position_y`=1667.528, `position_z`=135.827, `orientation`=3.534 WHERE `guid`=29803; -- Undertaker Mordo
UPDATE `creature` SET `position_x`=10357.584, `position_y`=-6369.816, `position_z`=36.141, `orientation`=2.321 WHERE `guid`=54984; -- Magistrix Erona

