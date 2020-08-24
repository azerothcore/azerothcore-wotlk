INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598303195521812924');
DELETE FROM `smart_scripts`WHERE `entryorguid`= 28202;
INSERT INTO `smart_scripts` VALUES
(28202, 0, 0, 0, 8, 0, 100, 1, 50926, 0, 0, 0, 0, 11, 50927, 3, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Zul\'Drak Rat - On Spellhit \'Gluttonous Lurkers: Create Zul\'Drak Rat Cover\' - Cast `Create Zul\'Drak Rat`'),
(28202, 0, 1, 0, 31, 0, 100, 1, 50927, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zul\'Drak Rat - On Spellhit target \'Create Zul\'Drak Rat\' - Despawn Instant');