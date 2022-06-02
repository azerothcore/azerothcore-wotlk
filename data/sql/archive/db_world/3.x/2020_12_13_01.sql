-- DB update 2020_12_13_00 -> 2020_12_13_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_13_00 2020_12_13_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606850384711949100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606850384711949100');

DELETE FROM `item_template_locale` WHERE `ID` IN (43949, 42535, 42529, 42523, 42474, 42147, 41756, 41753, 41750, 41749, 40484, 40232, 39153, 38654, 38644, 38643, 38383, 38204, 38140, 37878, 28107, 28046, 28044, 28043, 25750, 25749, 25748, 25747, 23754, 23684, 23683, 17363, 17362) AND `locale` = 'deDE';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(43949, 'deDE', 'zzzALTTägliche Quest Fraktions-Token', '', 15050),
(42535, 'deDE', 'Zauberfoliant des grausamen Gladiators', '', 15050),
(42529, 'deDE', 'Begnadigung des grausamen Gladiators', '', 15050),
(42523, 'deDE', 'Endspiel des grausamen Gladiators', '', 15050),
(42474, 'deDE', 'Glyphe ''Arkane Explosion''', '', 15050),
(42147, 'deDE', 'Zwangsreaktion Frostriesen', 'Nur intern', 15050),
(41756, 'deDE', 'Siegel des Herzblutes', '', 15050),
(41753, 'deDE', 'Brunnhildar Harpune', '', 15050),
(41750, 'deDE', 'Birmingham Test Item 3', '', 15050),
(41749, 'deDE', 'Birmingham Test Item 3', 'Für Brian, um Dinge zu testen', 15050),
(40484, 'deDE', 'Deprecated Glyphe ''Eisbär''', '', 15050),
(40232, 'deDE', 'Test Schillernder Talasit', 'Am besten für einen gelben oder blauen Sockel geeignet.', 15050),
(39153, 'deDE', 'Handbuch: Dichter Froststoffverband', 'Dieses durchnässte Buch sagt Euch nichts.', 15050),
(38654, 'deDE', 'Corvus Bericht', '', 15050),
(38644, 'deDE', 'Währungstoken Test-Token 3', 'Ein drittes Test-Token für das Währungstoken-System', 15050),
(38643, 'deDE', 'Dichter Froststoffverband', '', 15050),
(38383, 'deDE', 'Valonforth''s Torheit', '', 15050),
(38204, 'deDE', 'DB38 Zauberstab2', '', 15050),
(38140, 'deDE', 'DB50 Zauberstab4', '', 15050),
(37878, 'deDE', 'Worgblutelixier', '', 15050),
(28107, 'deDE', 'Schriftwechsel der Legion', 'Trägt das Siegel von Arazzius.', 15050),
(28046, 'deDE', 'Schriftwechsel der Legion', 'Trägt das Siegel von Arazzius.', 15050),
(28044, 'deDE', 'Band des Dämonenjägers', '', 15050),
(28043, 'deDE', 'Anhänger des Dämonenjägers', '', 15050),
(25750, 'deDE', '(Deprecated)Manabomben Bauplan - Seite 4', '', 15050),
(25749, 'deDE', '(Deprecated)Manabomben Bauplan - Seite 3', '', 15050),
(25748, 'deDE', '(Deprecated)Manabomben Bauplan - Seite 2', '', 15050),
(25747, 'deDE', '(Deprecated)Manabomben Bauplan - Seite 1', '', 15050),
(23754, 'deDE', 'Balg eines borstigen Grollhufs', '', 15050),
(23684, 'deDE', 'Kristalldurchdrungener Verband', '', 15050),
(23683, 'deDE', 'Kristallflockendrops', '', 15050),
(17363, 'deDE', 'Rysons Signal', '', 15050),
(17362, 'deDE', 'Rysons Signal', '', 15050);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
