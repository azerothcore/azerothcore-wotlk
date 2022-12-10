-- DB update 2022_05_25_02 -> 2022_05_25_03
-- update `Slaves of the Stormforged` quest Chinese translation
UPDATE `quest_template_locale` SET `ObjectiveText1` = '解救机械侏儒俘虏' WHERE `ID` = 12957 AND `locale` = 'zhCN'; 

-- update `Waterlogged Recipe` quest Chinese translation
UPDATE `quest_template_locale` SET `CompletedText` = '去达拉然找再来一杯的克莉丝蒂·斯多克顿。' WHERE `ID` = 14203 AND `locale` = 'zhCN'; 
