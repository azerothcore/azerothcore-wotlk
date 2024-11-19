-- DB update 2021_01_14_01 -> 2021_01_14_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_14_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_14_01 2021_01_14_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1607329910475731400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607329910475731400');

DELETE FROM `item_template_locale` WHERE `ID` IN (34467, 33315, 33147, 33080, 33063, 32972, 32911, 32642, 32595, 32594, 32560, 32558, 32556, 32552, 32550, 32548, 32546, 32544, 31849, 31845, 31843, 31802, 31665, 30440, 30427, 30197, 30193, 29887, 29885, 29874, 29872, 29863, 29861, 29860, 29857, 29856, 29852, 29842, 29840, 29839, 29790, 29311, 28598, 28131, 28110, 25627, 25582, 25581, 25580, 23567, 22045, 22042, 22020, 21044, 20364, 19879, 18970, 16165, 16085, 13339, 13337, 9701, 9700, 8688, 5495, 5333, 3068, 3034, 1914, 1700, 1324, 1298, 964, 45280) AND `locale` = 'deDE';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34467, 'deDE', 'Test Eine Hand voll Teufelseisenbolzen', '', 15050),
(33315, 'deDE', 'QAFormel: Waffe - Scharfrichter', '', 15050),
(33147, 'deDE', 'Formel: Umhang - Feingefühl', '', 15050),
(33080, 'deDE', 'Elixier der Wasserelementare', 'Gerüchten zufolge soll dieses Elixier seinen Besitzer in einen kleinen Wasserelementar verwandeln. Nur für Mitglieder des Syndikats verwendbar.', 15050),
(33063, 'deDE', 'Wirklich hartes Braufestbrot', 'Nicht genießbar, aber ein praktisches Hilfsmittel zur Verteidigung Eures Getränks.', 15050),
(32972, 'deDE', 'Rosarote Brille', '', 15050),
(32911, 'deDE', 'Leerer Braufestkrug', '', 15050),
(32642, 'deDE', 'Rohe Rune der Dunkelheit', 'Die Teufelsenergie durchdringt den Raum um die Rune herum.', 15050),
(32595, 'deDE', 'Ogrela Reagenz Staub', '', 15050),
(32594, 'deDE', 'Ogrela Test Tunika', '', 15050),
(32560, 'deDE', 'Tier 5 Krieger Ausrüstungsbox 2', '', 15050),
(32558, 'deDE', 'Tier 5 Hexenmeister Ausrüstungsbox 2', '', 15050),
(32556, 'deDE', 'Tier 5 Schamane Ausrüstungsbox 2', '', 15050),
(32552, 'deDE', 'Tier 5 Priester Ausrüstungsbox 2', '', 15050),
(32550, 'deDE', 'Tier 5 Paladin Ausrüstungsbox 2', '', 15050),
(32548, 'deDE', 'Tier 5 Magier Ausrüstungsbox 2', '', 15050),
(32546, 'deDE', 'Tier 5 Jäger Ausrüstungsbox 2', '', 15050),
(32544, 'deDE', 'Tier 5 Druide Ausrüstungsbox 2', '', 15050),
(31849, 'deDE', 'QAArmschienen - Stärke +12', '', 15050),
(31845, 'deDE', 'QAArmschienen - Zaubermacht +15', '', 15050),
(31843, 'deDE', 'QAArmschienen - Angriffskraft +24', '', 15050),
(31802, 'deDE', 'Fleischlingssimulationsstab', '', 15050),
(31665, 'deDE', 'Ferngesteuerter Spielzeugmörserpanzer', 'Hinweis: Zur Sicherheit von Kleinkindern wird mit Kanonen nicht wirklich geschossen.', 15050),
(30440, 'deDE', 'Monster - Speer, Donnerlanze', '', 15050),
(30427, 'deDE', 'Naga Schatzkarte - Questgeber (PH)', 'X markiert die Ssstelle.', 15050),
(30197, 'deDE', 'QARing - Werte +4', '', 15050),
(30193, 'deDE', 'QARing - Zaubermacht +12', '', 15050),
(29887, 'deDE', 'Jäger 150 epische Munitionskiste', '', 15050),
(29885, 'deDE', 'Jäger 120 epische Testgeschosse', '', 15050),
(29874, 'deDE', 'QABrust - Gesundheit +150', '', 15050),
(29872, 'deDE', 'QABrust - Werte +6', '', 15050),
(29863, 'deDE', 'QAHandschuhe - Zauberschaden +20', '', 15050),
(29861, 'deDE', 'QAUmhang - Zauberdurchschlag +20', '', 15050),
(29860, 'deDE', 'QAUmhang - Beweglichkeit +12', '', 15050),
(29857, 'deDE', 'QAStiefel - Ausdauer +12', '', 15050),
(29856, 'deDE', 'QAStiefel - Beweglichkeit +12', '', 15050),
(29852, 'deDE', 'QAStiefel - Ausdauer +9 & Geschwindigkeit +8%', '', 15050),
(29842, 'deDE', 'QAWaffe - Zauberschaden +40', '', 15050),
(29840, 'deDE', 'QAWaffe - Seelenfrost', '', 15050),
(29839, 'deDE', 'QAWaffe - Mungo', '', 15050),
(29790, 'deDE', 'Sprengladungen', '', 15050),
(29311, 'deDE', 'Bauanleitung für Teufelshäscher', '', 15050),
(28598, 'deDE', 'Bauanleitung für Teufelshäscher', '', 15050),
(28131, 'deDE', 'Häscherbrecherwerfer', '', 15050),
(28110, 'deDE', 'Fetter Gnom und kleine Elfe', '', 15050),
(25627, 'deDE', 'QR 9922 Schild', '', 15050),
(25582, 'deDE', 'QR 9867 Druiden Mondkin Gürtel', '', 15050),
(25581, 'deDE', 'QR 9867 Jäger Handschuhe', '', 15050),
(25580, 'deDE', 'QR 9867 Krieger Beine', '', 15050),
(23567, 'deDE', '[PH] Silithus PvP-Staub [DEP]', '', 15050),
(22045, 'deDE', 'Test QARaid Super Munitionsschließkassette', '', 15050),
(22042, 'deDE', 'QAUmhang - Bedrohung -2%', '', 15050),
(22020, 'deDE', 'QAWaffe - Beweglichkeit +15', '', 15050),
(21044, 'deDE', 'Rentierzügel', '', 15050),
(20364, 'deDE', 'Test Munitionsschließkassette', '', 15050),
(19879, 'deDE', 'Alex'' Test Niederschlagsstab', '', 15050),
(18970, 'deDE', 'Ring Kritische Tests 2', '', 15050),
(16165, 'deDE', 'Test arkane Resistenz Beinpanzer', '', 15050),
(16085, 'deDE', 'Erste Hilfe für den Fachmann - Heilt Euch selbst', '', 15050),
(13339, 'deDE', 'Monster - Stab, gefiedertes Silber', '', 15050),
(13337, 'deDE', 'Monster - Stab, gefiedertes Gold', '', 15050),
(9701, 'deDE', 'Monster - Item, Roter Funkler', '', 15050),
(9700, 'deDE', 'Monster - Item, Blauer Funkler', '', 15050),
(8688, 'deDE', 'Bindung bei Erwerb Test Item', '', 15050),
(5495, 'deDE', 'Schwarzer Überzieher', '', 15050),
(5333, 'deDE', 'Mathystra-Relikte', '', 15050),
(3068, 'deDE', 'Silberfadengugel', '', 15050),
(3034, 'deDE', 'Glyphenverzierte Brustplatte', '', 15050),
(1914, 'deDE', 'Deprecated Silberner Miniaturhammer', '', 15050),
(1700, 'deDE', 'Das Claymore des Admin Warlord', 'Hergestellt von TBRC', 15050),
(1324, 'deDE', 'Deprecated Parkers Mittagessen', '', 15050),
(1298, 'deDE', 'Deprecated Handgelenksschutz des Nachtmagiers', '', 15050),
(964, 'deDE', 'Deprecated Rotes Leinenhemd', '', 15050),
(45280, 'deDE', 'Supershirt', 'Ich habe Ulduar in Hardmode getestet und alles was ich bekam war dieses blöde T-Shirt!', 15050);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
