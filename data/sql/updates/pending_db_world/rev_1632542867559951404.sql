INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632542867559951404');

-- Add 2 day time delay to Gubber Blump's letter
UPDATE `quest_template_addon` SET `RewardMailDelay` = 172800 WHERE `ID` = 1141;

