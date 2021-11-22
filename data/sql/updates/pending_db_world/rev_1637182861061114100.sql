INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637182861061114100');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (20619,21075);
INSERT INTO `conditions` VALUES
(13,1,20619,0,0,31,0,3,11663,0,0,0,0,'','Magic Reflection targets Flamewaker Healer'),
(13,1,20619,0,1,31,0,3,11664,0,0,0,0,'','Magic Reflection targets Flamewaker Elite'),
(13,1,21075,0,0,31,0,3,11663,0,0,0,0,'','Damage Shield targets Flamewaker Healer'),
(13,1,21075,0,1,31,0,3,11664,0,0,0,0,'','Damage Shield  targets Flamewaker Elite');

UPDATE `creature_summon_groups` SET `summonType`=7 WHERE `summonerId`=12018 AND `groupid`=1;
