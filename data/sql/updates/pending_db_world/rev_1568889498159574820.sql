INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1568889498159574820');

-- take over the translated texts from 16259, strip the "%s" at the beginning and create a new broadcast text ID 91243
DELETE FROM `broadcast_text_locale` WHERE `ID` = 91243;
INSERT INTO `broadcast_text_locale` (`ID`, `locale`, `MaleText`, `FemaleText`, `VerifiedBuild`)
  SELECT 91243 AS `ID`, `locale`, TRIM(TRIM('%s' FROM `FemaleText`)) AS `MaleText`, TRIM(TRIM('%s' FROM `FemaleText`)) AS `FemaleText`, 0
  FROM `broadcast_text_locale` WHERE `ID` = 16259;

DELETE FROM `broadcast_text` WHERE `ID` = 91243;
INSERT INTO `broadcast_text` (`ID`, `Language`, `MaleText`, `FemaleText`, `EmoteID0`, `EmoteID1`, `EmoteID2`, `EmoteDelay0`, `EmoteDelay1`, `EmoteDelay2`, `SoundId`, `Unk1`, `Unk2`, `VerifiedBuild`)
VALUES
(91243,0,'makes some strange gestures.','makes some strange gestures.',0,0,0,0,0,0,0,0,0,0);
