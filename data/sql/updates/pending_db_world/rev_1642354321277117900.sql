INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642354321277117900');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (19832,19873);
INSERT INTO `conditions` VALUES
(13,5,19832,0,0,31,0,3,12435,0,0,0,0,'','Possess targets Razorgore the Untamed'),
(13,1,19873,0,0,31,0,5,177807,0,0,0,0,'','Destroy Egg targets Razorgore\'s Egg');
