-- DB update 2021_01_12_00 -> 2021_01_12_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_12_00 2021_01_12_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1607250027116831100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607250027116831100');

DELETE FROM `item_template_locale` WHERE `ID` IN (42083, 42019, 42013, 42007, 42000, 41995, 41911, 41900, 38996, 38970, 38957, 37976, 37967, 37955, 37837, 37742, 37711, 37706, 37544, 37090, 35553, 35551, 35550, 35549, 35548, 35546, 35545, 35544, 35541, 35539, 35538, 35537, 35535, 35533, 35531, 35529, 35527, 35526, 35525, 35524, 35523, 35521, 35520, 35519, 35518, 35517, 34835, 34663, 34647, 34645) AND `locale` = 'deDE';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(42083, 'deDE', 'LK Ehre 5 Caster DPS Kritisch Umhang', '', 15050),
(42019, 'deDE', 'LK Arena 6 Hexenmeister Handschuhe', '', 15050),
(42013, 'deDE', 'LK Arena 6 Hexenmeister Schultern', '', 15050),
(42007, 'deDE', 'LK Arena 6 Hexenmeister Beine', '', 15050),
(42000, 'deDE', 'LK Arena 6 Hexenmeister Brust', '', 15050),
(41995, 'deDE', 'LK Arena 6 Hexenmeister Helm', '', 15050),
(41911, 'deDE', 'LK Ehre 5 Caster DPS Armschienen', '', 15050),
(41900, 'deDE', 'LK Ehre 5 Caster DPS Gürtel', '', 15050),
(38996, 'deDE', 'Schriftrolle der Verzauberung: Armschiene - Erhebliche Heilung', '', 15050),
(38970, 'deDE', 'Schriftrolle der Verzauberung: Handschuhe - Außergewöhnliche Heilung', '', 15050),
(38957, 'deDE', 'Schriftrolle der Verzauberung: Waffe - Außergewöhnliches Schlagen', '', 15050),
(37976, 'deDE', 'DB54 Heiler Hals2', '', 15050),
(37967, 'deDE', 'DB42 Zauber Ring4', '', 15050),
(37955, 'deDE', 'DB26 Heiler Umhang', '', 15050),
(37837, 'deDE', 'Fette Laute', 'TEMP Test Verkäufer Item', 15050),
(37742, 'deDE', 'Währung Token Test-Token 2', 'Ein zweites Test-Token für das Währungstoken-System', 15050),
(37711, 'deDE', 'Währung Token Test-Token 1', 'Ein Test-Token für das Währungstoken-System', 15050),
(37706, 'deDE', 'Gehärteter Saronitbarren', '', 15050),
(37544, 'deDE', 'Drachenknochenhalskette', '', 15050),
(37090, 'deDE', 'Flinkmohn', '', 15050),
(35553, 'deDE', 'Pläne: Kampffäuste aus Hartkhorium', '', 15050),
(35551, 'deDE', 'Muster: Sonnenfeuerhandlappen', '', 15050),
(35550, 'deDE', 'Muster: Sonnengetränkte Schuppenhandschuhe', '', 15050),
(35549, 'deDE', 'Muster: Sonnengetränkter Schuppenbrustschutz', '', 15050),
(35548, 'deDE', 'Muster: Robe des ewigen Lichts', '', 15050),
(35546, 'deDE', 'Muster: Lederstulpen der Sonne', '', 15050),
(35545, 'deDE', 'Muster: Lederbrustschutz der Sonne', '', 15050),
(35544, 'deDE', 'Muster: Hände des ewigen Lichts', '', 15050),
(35541, 'deDE', 'Muster: Pfeilmacherhandschuhe des Phönix', '', 15050),
(35539, 'deDE', 'Muster: Knochenpanzer von Sonne und Schatten', '', 15050),
(35538, 'deDE', 'Vorlage: Ring des fließenden Lebens', '', 15050),
(35537, 'deDE', 'Vorlage: Anhänger aus Sonnenfeuer', '', 15050),
(35535, 'deDE', 'Vorlage: Halsreif aus Hartkhorium', '', 15050),
(35533, 'deDE', 'Vorlage: Amulett des fließenden Lebens', 'Lehrt Euch die Herstellung eines Amuletts des fließenden Lebens.', 15050),
(35531, 'deDE', 'Pläne: Flinkstahlarmschienen', '', 15050),
(35529, 'deDE', 'Pläne: Morgenstahlarmschienen', '', 15050),
(35527, 'deDE', 'Muster: Flinkschlagarmschienen', '', 15050),
(35526, 'deDE', 'Muster: Flinkheiltücher', '', 15050),
(35525, 'deDE', 'Muster: Flinkheilmantelung', '', 15050),
(35524, 'deDE', 'Muster: Schultern der blitzartigen Reflexe', '', 15050),
(35523, 'deDE', 'Muster: Schulterpolster des erneuerten Lebens', '', 15050),
(35521, 'deDE', 'Muster: Lebendige Erdschultern', '', 15050),
(35520, 'deDE', 'Muster: Lebendige Erdbindungen', '', 15050),
(35519, 'deDE', 'Muster: Armschienen des erneuerten Lebens', '', 15050),
(35518, 'deDE', 'Muster: Armschienen des flinken Gedankens', '', 15050),
(35517, 'deDE', 'Muster: Bindungen der blitzartigen Reflexe', '', 15050),
(34835, 'deDE', 'Omars Juwel von POWAH', '', 15050),
(34663, 'deDE', 'Silberner Federkiel', '', 15050),
(34647, 'deDE', 'Rauhes Pergament', '', 15050),
(34645, 'deDE', 'Irdische Tinte', '', 15050);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
