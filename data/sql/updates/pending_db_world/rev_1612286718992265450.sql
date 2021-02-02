INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612286718992265450');

-- Faster spawn rates for quest Secondhand Diving Gear

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid` IN
(
40774, -- Tool Kit
40775 -- Damaged Diving Gear
);
