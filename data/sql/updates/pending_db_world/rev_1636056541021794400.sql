INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636056541021794400');

UPDATE `quest_poi` SET `Flags`=3 WHERE `questId`=8312 AND `id`=1;
UPDATE `quest_poi` SET `Flags`=1 WHERE `questId`=8312 AND `id`=0;

UPDATE `quest_template_addon` SET `SpecialFlags`=1 WHERE `id` IN (8353,8355,8356,8357,8354,8358,8359,8360);
