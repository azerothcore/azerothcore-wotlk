INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605661689213920900');

/* Copy FemaleText into missing MaleText for Computer NPC in Mimiron fight, Ulduar. */

UPDATE `broadcast_text` SET `MaleText`=`FemaleText` WHERE `ID` IN (34284,34283,34282,34281,34280,34279,34278,34277,34276,34275,34274,34273,34268);
UPDATE `broadcast_text_locale` SET `MaleText`=`FemaleText` WHERE `ID` IN (34284,34283,34282,34281,34280,34279,34278,34277,34276,34275,34274,34273,34268);
