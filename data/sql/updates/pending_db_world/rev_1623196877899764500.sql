INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623196877899764500');

-- Update unreachable copper vein
UPDATE `gameobject`
SET `position_x`=-9144, `position_y`=-2078, `position_z`=125, `orientation`=3.369
WHERE `guid`=5149 AND `id`=1731;
