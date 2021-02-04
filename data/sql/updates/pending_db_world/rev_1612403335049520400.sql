INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612403335049520400');

-- Fix #4402: Remove quest: "Mending Fences" from list of requirements for "A Spark of Hope" to be available
DELETE FROM conditions
WHERE
	SourceTypeOrReferenceId = 19 -- CONDITON_SOURCE_TYPE_QUEST_AVAILABLE
    AND SourceEntry = 12956 -- Quest: A Spark of Hope
    AND ConditionTypeOrReference = 8 -- REQUIRES_QUEST_REWARDED
    AND ConditionValue1 = 12915; -- Quest: Mending Fences