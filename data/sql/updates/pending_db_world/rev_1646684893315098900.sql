INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646684893315098900');

UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags` &~1 WHERE ID IN (8166, 8167, 8168, 8169, 8170, 8171, 8105, 8120);
