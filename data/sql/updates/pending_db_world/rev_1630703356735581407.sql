INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630703356735581407');

-- Change to correct objective tracker and add correct translate objective

UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Count Remington Ridgewell at Stormwind Keep in Stormwind City' WHERE `ID` = 543;
-- zhCN
UPDATE `quest_template_locale` SET `CompletedText` = '将匹瑞诺德王冠带给暴风城的雷明顿·瑞治维尔。' WHERE `ID` = 543 AND `locale` = 'zhCN';
-- zhTW
UPDATE `quest_template_locale` SET `CompletedText` = '将匹瑞诺德王冠带给暴风城的雷明顿·瑞治维尔。' WHERE `ID` = 543 AND `locale` = 'zhTW';
