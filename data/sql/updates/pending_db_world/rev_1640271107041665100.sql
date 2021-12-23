INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640271107041665100');

-- Wind Stone Summons: Have talk event take target into consideration
UPDATE `smart_scripts`  SET `action_param3` = 1  WHERE `entryorguid` IN (15203, 15204, 15205, 15206, 15207, 15208, 15209, 15211, 15212, 15220, 15305, 15307) AND `source_type` = 0 AND `id` = 0;
