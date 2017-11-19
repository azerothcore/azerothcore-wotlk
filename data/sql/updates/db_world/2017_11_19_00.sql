-- DB update 2017_11_17_00 -> 2017_11_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_11_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_11_17_00 2017_11_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1509375074619158078'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1509375074619158078');

-- lady deathwhisper and marrowgar 25 heroic (difficulty 3)
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '3' WHERE `criteria_id` = '13091' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '3' WHERE `criteria_id` = '13106' AND `type` = '0'; 

-- fix various stats for 25 normal (difficulty 1)
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13108' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12242' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13105' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12231' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12230' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12234' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12235' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13092' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12243' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12246' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12247' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '11903' AND `type` = '0'; 
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES (4989,12,1,0);

-- lady deathwhisper and marrowgar 10 heroic (difficulty 2)
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '2' WHERE `criteria_id` = '13090' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '2' WHERE `criteria_id` = '13104' AND `type` = '0'; 
-- gunship and deathbringer 10 heroic
UPDATE `achievement_criteria_data` SET `value1` = '2' WHERE `criteria_id` = '13110' AND `type` = '12'; 
UPDATE `achievement_criteria_data` SET `value1` = '2' WHERE `criteria_id` = '13113' AND `type` = '12'; 

-- fix various 10 normal stats (difficulty 0)
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13093' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12228' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12229' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12232' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12233' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13107' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12240' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12241' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12244' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12245' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '11902' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13089' AND `type` = '0'; 
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES (4988,12,0,0);

-- fix various heroic dungeons
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13179' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12798' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12799' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12800' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13182' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12802' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12808' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12803' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12804' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12805' AND `type` = '0';  
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12806' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12807' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13177' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '12809' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13167' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13168' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13173' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' , `value1` = '1' WHERE `criteria_id` = '13175' AND `type` = '0'; 
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES (5620,12,1,0);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES (12801,12,1,0);


-- fix all other normal criteria for dungeon and raids

UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12686' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12678' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12679' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '8803' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '8802' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '8801' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '8800' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '8799' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '8798' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12680' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5468' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5469' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5466' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5467' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5465' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5464' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5463' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5462' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5461' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5460' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5459' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5458' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5457' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5456' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5455' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5454' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5453' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5452' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5451' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5450' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5449' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5448' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5446' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5447' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5445' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5444' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5443' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5442' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5441' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5440' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5439' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5438' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5437' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5436' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5384' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5383' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5382' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5381' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5380' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5379' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5378' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5377' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3239' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12682' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3241' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12683' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12684' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12685' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3242' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12687' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12688' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '12689' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13166' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13169' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13170' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13172' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13174' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13176' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '13178' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3240' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5631' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5630' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5629' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5628' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5627' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5626' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5625' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5624' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5623' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5622' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '5621' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3275' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3274' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3273' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3272' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3271' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3270' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3266' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3268' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3265' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3264' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3263' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3261' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3260' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3259' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3258' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3257' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3262' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3256' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3255' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3254' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3253' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3252' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3251' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3250' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3249' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3248' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3247' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3246' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3245' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3244' AND `type` = '0'; 
UPDATE `achievement_criteria_data` SET `type` = '12' WHERE `criteria_id` = '3243' AND `type` = '0';
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES (5632,12,0,0);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES (5619,12,0,0);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES (12681,12,0,0);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES (4987,12,0,0);
--
-- END UPDATING QUERIES
--
COMMIT;
END;
//
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
