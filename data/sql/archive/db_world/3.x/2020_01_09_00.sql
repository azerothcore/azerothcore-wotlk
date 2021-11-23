-- DB update 2020_01_02_00 -> 2020_01_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_01_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_01_02_00 2020_01_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1576771426837915100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1576771426837915100');

/*quest_template_locale - removed [DEPRECATED] deDE quest titles (NOT included in disables table)*/
UPDATE `quest_template_locale` SET `Title` = 'Der Dunkle Rat' WHERE `ID` = 537 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Der schwarze Schild' WHERE `ID` = 1319 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Der schwarze Schild' WHERE `ID` = 1320 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Der schwarze Schild' WHERE `ID` = 1321 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Der schwarze Schild' WHERE `ID` = 1322 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Weitere Verderbnis' WHERE `ID` = 4906 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Der schwarze Schild' WHERE `ID` = 1323 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Die Verderbnis der Jadefeuer' WHERE `ID` = 4421 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Gebundene Urtume' WHERE `ID` = 4441 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Frostrachen' WHERE `ID` = 1136 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Die gequälten Seelen von Kel''Theril' WHERE `ID` = 5245 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Gefangene der Grimmtotem' WHERE `ID` = 11145 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Tränenteich' WHERE `ID` = 9610 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Waffen der Grimmtotem' WHERE `ID` = 11148 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Oberanführer Mok''Morokks Sorgen' WHERE `ID` = 1166 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Tränenteich' WHERE `ID` = 1424 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Endlich Frieden' WHERE `ID` = 11152 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Die Brut identifizieren' WHERE `ID` = 1169 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Die Brut von Onyxia' WHERE `ID` = 1172 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Räuber des Grollhornpostens' WHERE `ID` = 11156 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Fordert Oberanführer Mok''Morokk heraus' WHERE `ID` = 1173 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Der Reagenziendieb' WHERE `ID` = 11173 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Flöte des Xavaric' WHERE `ID` = 939 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Drescheröl' WHERE `ID` = 11192 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Bezwingt Tethyr!' WHERE `ID` = 11198 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Kein bloßer Zufall' WHERE `ID` = 11200 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Toxinschrecken' WHERE `ID` = 5086 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Der schwarze Schild' WHERE `ID` = 1251 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Der schwarze Schild' WHERE `ID` = 1253 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Trümmergratkopfgeld' WHERE `ID` = 500 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Gefahr auf acht Beinen' WHERE `ID` = 245 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Kriegstreiber der Trümmergratoger' WHERE `ID` = 504 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Auftragsmörder des Syndikats' WHERE `ID` = 505 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `Title` = 'Der schwarze Schild' WHERE `ID` = 1276 AND `locale` = 'deDE';

/*creature_template_locale - remove title 'PH MODEL WIP'*/
UPDATE `creature_template_locale` SET `Title` = '' WHERE `entry` = 2694;

/*creature_equip_template - fix weapon*/
UPDATE `creature_equip_template` SET `ItemID2` = 1899, `ItemID3` = 0 WHERE `CreatureID` = 2694;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
