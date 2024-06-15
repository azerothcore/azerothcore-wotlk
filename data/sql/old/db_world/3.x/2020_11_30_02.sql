-- DB update 2020_11_30_01 -> 2020_11_30_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_30_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_30_01 2020_11_30_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606037218841997800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606037218841997800');

DELETE FROM `item_template_locale` WHERE `ID` IN (45942, 10595, 8964, 7548, 7547, 7497, 7467, 7466, 7427, 6988, 6754, 6649, 6648, 6623, 6619, 6589, 6544, 6497, 6496, 6495, 6492, 6491, 6490, 6376, 6374, 6279, 6278, 6277, 6276, 6216, 6183, 6182, 6130, 5874, 5660, 5657, 5603, 5518, 5330, 5150, 5105, 5013, 5008, 5005, 5004, 4988, 4981, 4959, 4930, 4273, 4143, 3762, 3144, 3005, 3003, 2932, 2929, 2921, 2556, 2415, 2413, 2410, 1977, 1623, 1146, 1134, 1133, 1057, 1029, 997) AND `locale` = 'deDE';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(45942, 'deDE', 'XS-001 Konstruktionsbot', 'Lehrt Euch, wie man dieses Haustier beschwört.', 15050),
(10595, 'deDE', 'Kum''ishas Plunder', 'Eine Truhe voll mit Plunder', 15050),
(8964, 'deDE', 'Kodex der Blitzheilung', '', 15050),
(7548, 'deDE', 'Onyxhalsschmuck', '', 15050),
(7547, 'deDE', 'Onyxring', '', 15050),
(7497, 'deDE', 'Elfenbeinband', '', 15050),
(7467, 'deDE', 'Zinnoberhalskette', '', 15050),
(7466, 'deDE', 'Zinnoberband', '', 15050),
(7427, 'deDE', 'Himmelblauer Talisman', '', 15050),
(6988, 'deDE', 'Teufelsjägerbeschwörungsrolle', '', 15050),
(6754, 'deDE', 'Große Geldtasche', '', 15050),
(6649, 'deDE', 'Rolle des Totems der Verbrennung', '', 15050),
(6648, 'deDE', 'Steinhaut-Totem-Rolle', '', 15050),
(6623, 'deDE', 'Sukkubusbeschwörungsrolle', '', 15050),
(6619, 'deDE', 'Handbuch: Der Weg der Verteidigung', '', 15050),
(6589, 'deDE', 'Viridium-Band', '', 15050),
(6544, 'deDE', 'Leerwandler-Beschwörungs-Rolle', '', 15050),
(6497, 'deDE', 'Einfaches Pergament', '', 15050),
(6496, 'deDE', 'Detailliertes Pergament', '', 15050),
(6495, 'deDE', 'Verwittertes Pergament', '', 15050),
(6492, 'deDE', 'Rußiges Pergament', '', 15050),
(6491, 'deDE', 'Schweres Pergament', '', 15050),
(6490, 'deDE', 'Dunkles Pergament', '', 15050),
(6376, 'deDE', 'Formel: Stiefel - Schwache Ausdauer', 'Lehrt Euch, wie man ein Paar Stiefel dauerhaft verzaubert, um die Ausdauer um 1 zu erhöhen.', 15050),
(6374, 'deDE', 'Verzaubertes Pulver', 'Wird von Verzauberern zur Verzauberung von Gegenständen verwendet.', 15050),
(6279, 'deDE', 'Modriger Brief', '', 15050),
(6278, 'deDE', 'Modrige Rolle', '', 15050),
(6277, 'deDE', 'Modriges Pergament', '', 15050),
(6276, 'deDE', 'Modrige Notiz', '', 15050),
(6216, 'deDE', 'Mystisches Pulver', 'Wird von Verzauberern zur Verzauberung von Gegenständen verwendet.', 15050),
(6183, 'deDE', 'Nicht angezündete schlechte Fackel', '', 15050),
(6182, 'deDE', 'Trübe Fackel', '', 15050),
(6130, 'deDE', 'Fallenstellerhemd', '', 15050),
(5874, 'deDE', 'Harnisch: Schwarzer Widder', '', 15050),
(5660, 'deDE', 'Buchband: Siegel der Rechtschaffenheit', '', 15050),
(5657, 'deDE', 'Rezept: Sofort wirkendes Toxin', '', 15050),
(5603, 'deDE', 'Wizbangs Rupfensack', '', 15050),
(5518, 'deDE', 'Winziger Eisenschlüssel', 'Ein Reagenz für Magierzauber.', 15050),
(5330, 'deDE', 'Elfen-Kelchrelikt', '', 15050),
(5150, 'deDE', 'Buch der heilenden Berührung III', '', 15050),
(5105, 'deDE', 'Explosive Schale', '', 15050),
(5013, 'deDE', 'Fruchtbare Knolle', '', 15050),
(5008, 'deDE', 'Quecksilberring', '', 15050),
(5005, 'deDE', 'Glutfunken-Anhänger', '', 15050),
(5004, 'deDE', 'Mal der Kirin Tor', '', 15050),
(4988, 'deDE', 'Brennendes Obsidianband', '', 15050),
(4981, 'deDE', 'Agmonds Gürtelbeutel', '', 15050),
(4959, 'deDE', 'Wurftomahawk', '', 15050),
(4930, 'deDE', 'Handgefertigte Ledertasche', '', 15050),
(4273, 'deDE', 'Kodex der Heilung', '', 15050),
(4143, 'deDE', 'Foliant des Essen-Herbeizauberns II', '', 15050),
(3762, 'deDE', 'Bibliothekarsranzen', '', 15050),
(3144, 'deDE', 'Zauberfoliant des brennenden Geistes II', '', 15050),
(3005, 'deDE', 'Relikt der Wahrheit', '', 15050),
(3003, 'deDE', 'Relikt des Auges', '', 15050),
(2932, 'deDE', 'Qualranke', 'Wird von Schurken beim Brauen von Gift verwendet.', 15050),
(2929, 'deDE', 'Grabmalfäulnis', 'Wird von Schurken beim Brauen von Gift verwendet.', 15050),
(2921, 'deDE', 'Gesegnetes Relikt', '', 15050),
(2556, 'deDE', 'Rezept: Elixier der Sprachen', '', 15050),
(2415, 'deDE', 'Schimmel', '', 15050),
(2413, 'deDE', 'Palomino', '', 15050),
(2410, 'deDE', 'Rauchende Fackel', '', 15050),
(1977, 'deDE', '20-Platz-Tasche', '', 15050),
(1623, 'deDE', 'Raptorenhautbeutel', '', 15050),
(1146, 'deDE', 'Buchband: Auferstehung', '', 15050),
(1134, 'deDE', 'Horn des grauen Wolfs', '', 15050),
(1133, 'deDE', 'Horn des Winterwolfs', '', 15050),
(1057, 'deDE', 'Schrifttafel der Wiederherstellung III', '', 15050),
(1029, 'deDE', 'Schrifttafel des Schlangentotems', '', 15050),
(997, 'deDE', 'Feuerschwert des Verkrüppelns', '', 15050);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
