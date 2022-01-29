-- DB update 2021_12_11_00 -> 2021_12_11_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_11_00 2021_12_11_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639172292353316400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639172292353316400');

DELETE FROM `spell_script_names` WHERE `spell_id` = 21108;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(21108, 'spell_ragnaros_summon_sons_of_flame');

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 1 WHERE `ID` IN (21110, 21111, 21112, 21113, 21114, 21115, 21116, 21117);

-- Positions are sniffed, but spell/pos relation can't be confirmed (serverside spells)
DELETE FROM `spell_target_position` WHERE `ID` IN (21110, 21111, 21112, 21113, 21114, 21115, 21116, 21117);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(21110, 0, 409, 811.448, -814.058, -233.17667, 0, 0),
(21111, 0, 409, 842.542, -797.822, -233.33968, 0, 0),
(21112, 0, 409, 870.668, -821.862, -232.93767, 2.460026741027832031, 0),
(21113, 0, 409, 874.851, -861.112, -232.33568, 2.460026741027832031, 0),
(21114, 0, 409, 891.442, -789.678, -232.80067, 3.549857854843139648, 0),
(21115, 0, 409, 824.827, -871.046, -232.42067, 1.242526054382324218, 0),
(21116, 0, 409, 868.206, -895.036, -233.09967, 2.010415554046630859, 0),
(21117, 0, 409, 818.517, -898.278, -232.90266, 1.282807230949401855, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_11_01' WHERE sql_rev = '1639172292353316400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
