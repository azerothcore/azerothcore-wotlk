INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619681545150953400');

SET @STORMWIND_GUARD_SHAMAN_TRAINER_TEXT:='I don''t know what''s possessed you to look for a shaman... but I have seen someone who matches the profile. There''s a woman who calls herself a Farseer on the shore in the Valley of Heroes.';
UPDATE `broadcast_text` SET `MaleText` = @STORMWIND_GUARD_SHAMAN_TRAINER_TEXT, `FemaleText` = @STORMWIND_GUARD_SHAMAN_TRAINER_TEXT WHERE `ID` = 18360;
