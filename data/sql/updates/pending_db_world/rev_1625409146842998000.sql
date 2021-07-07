INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625409146842998000');

-- Fix https://github.com/azerothcore/azerothcore-wotlk/issues/6720
UPDATE `quest_template_addon` SET `PrevQuestID` = 1418 WHERE `ID` = 1420;
