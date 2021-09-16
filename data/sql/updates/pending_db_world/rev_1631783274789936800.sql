INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631783274789936800');

-- Warning fixes
UPDATE creature_formations SET groupAI=groupAI|512 WHERE (angle > 0 OR dist > 0) AND leaderGUID != memberGUID and NOT (groupAI & 512);
update creature_formations set angle=0, dist=0 where leaderGUID=7209 and memberGUID=7209;
update creature_formations set angle=0, dist=0 where leaderGUID=37523 and memberGUID=37523;
update creature_formations set angle=0, dist=0 where leaderGUID=47613 and memberGUID=47613;
update creature_formations set angle=0, dist=0 where leaderGUID=79524 and memberGUID=79524;
update creature_formations set angle=0, dist=0 where leaderGUID=79720 and memberGUID=79720;
update creature_formations set angle=0, dist=0 where leaderGUID=80219 and memberGUID=80219;
update creature_formations set angle=0, dist=0 where leaderGUID=80235 and memberGUID=80235;
update creature_formations set angle=0, dist=0 where leaderGUID=134935 and memberGUID=134935;
update creature_formations set angle=0, dist=0 where leaderGUID=134944 and memberGUID=134944;
update creature_formations set angle=0, dist=0 where leaderGUID=134952 and memberGUID=134952;
update creature_formations set groupAI = 1 | 2 where leaderGUID=85221 and memberGUID=85221;
update creature_formations set groupAI = 1 | 2 where leaderGUID=114937 and memberGUID=114937;
update creature_formations set groupAI = 1 | 2 where leaderGUID=248035 and memberGUID != 248035;
