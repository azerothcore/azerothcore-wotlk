INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629787955866471200');

-- Fix location for spell: 'Halls of Invention Teleport'
UPDATE `spell_target_position`
    SET `PositionX` = 2518.22, `PositionY` = 2569.11, `PositionZ` = 412.69, `Orientation` = 3.10668
    WHERE `ID` = 64025;

-- Fix location for 'Prison of Yogg-Saron Teleport'
UPDATE `spell_target_position`
    SET `PositionX` = 1854.8, `PositionY` = -11.46, `PositionZ` = 334.57, `Orientation` = 4.79266
    WHERE `ID` = 65042;
