INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612360387230427830');

-- Fix DK quest: The Plaguebringer's Request

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid` IN
(
66377,  -- Empty Cauldron
66378   -- Iron Chain
);
