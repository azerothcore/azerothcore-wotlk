INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633854420655916547');

-- Makes 3 Argent Dawn "Armaments of Battle" quests repeatable
UPDATE `quest_template_addon` SET `SpecialFlags`=`SpecialFlags`|1 WHERE `ID` IN (9223, 9227, 9228);

