INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631783274789936800');

-- Warning fixes
UPDATE creature_formations SET groupAI=groupAI|512 WHERE (angle > 0 OR dist > 0) AND leaderGUID != memberGUID and NOT (groupAI & 512);

-- creature_formations table leader guid 7209 cannot have follow distance or follow angle. Values are not gonna be used
update creature_formations set angle=0, dist=0 where leaderGUID=7209 and memberGUID=7209;
