-- DB update 2017_11_16_00 -> 2017_11_17_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_11_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_11_16_00 2017_11_17_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1509353420962391661'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1509353420962391661');

-- change script name to arena kills by type
UPDATE achievement_criteria_data SET ScriptName="achievement_arena_2v2_check" WHERE criteria_id = 5541 AND TYPE = 11;
UPDATE achievement_criteria_data SET ScriptName="achievement_arena_3v3_check" WHERE criteria_id = 5542 AND TYPE = 11;
UPDATE achievement_criteria_data SET ScriptName="achievement_arena_5v5_check" WHERE criteria_id = 5543 AND TYPE = 11;

-- arena matches by type 
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (5728,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8615,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8616,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8617,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8618,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (5725,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8611,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8612,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8613,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8614,11,'achievement_arena_2v2_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (5727,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8607,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8608,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8609,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8610,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (5724,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8603,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8604,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8605,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8606,11,'achievement_arena_3v3_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (5726,11,'achievement_arena_5v5_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8599,11,'achievement_arena_5v5_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8600,11,'achievement_arena_5v5_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8601,11,'achievement_arena_5v5_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8602,11,'achievement_arena_5v5_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (5723,11,'achievement_arena_5v5_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8595,11,'achievement_arena_5v5_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8596,11,'achievement_arena_5v5_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8597,11,'achievement_arena_5v5_check');                    
INSERT INTO achievement_criteria_data (criteria_id,TYPE,ScriptName) VALUES (8598,11,'achievement_arena_5v5_check');
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
