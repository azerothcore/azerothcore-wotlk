INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635442402182198240');

-- Fix location of Darcy
UPDATE `creature` SET `position_x`=-9218.02, `position_y`=-2148.62, `position_z`=64.3548, `orientation`=4.47915 WHERE `id`=379;
