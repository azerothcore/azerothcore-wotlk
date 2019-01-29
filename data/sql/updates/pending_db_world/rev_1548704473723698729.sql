INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548704473723698729');

-- CONDITION_QUEST_SATISFY_EXCLUSIVE
UPDATE `conditions` SET ConditionTypeOrReference = 101 WHERE ConditionTypeOrReference = 50;

-- CONDITION_HAS_AURA_TYPE
UPDATE `conditions` SET ConditionTypeOrReference = 102 WHERE ConditionTypeOrReference = 51;
