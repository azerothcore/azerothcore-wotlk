-- DB update 2020_11_30_03 -> 2020_12_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_30_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_30_03 2020_12_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606151779375687700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606151779375687700');

DELETE FROM `item_template_locale` WHERE `ID` IN (45924, 43563, 43562, 43561, 43560, 43559, 43558, 43557, 43517, 43002, 39904, 39903, 39303, 37100, 37089, 36915, 25706, 24288, 23051, 21786, 21785, 21773, 21772, 20965, 20962, 20953, 20952, 20880, 20829, 20825, 20822, 20819, 20596, 20591, 20221, 18964, 17967, 16339, 16057, 14062, 12947, 9572, 9443, 9417, 8840, 8633, 8628, 8590, 8589, 8583, 8546, 7994, 7988, 7987, 7986, 7681, 7550, 5563, 5562, 5106, 3148) AND `locale` = 'deDE';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(45924, 'deDE', 'Dankeszertifikat', 'Vielen Dank für Eure Unterstützung. Leider befinden sich Eure epischen Gegenstände in einem anderen Dungeon. Bitte versucht es noch einmal.', 15050),
(43563, 'deDE', 'Gefrorene Käferhülse', 'Wird selten beim Mahlen von Pflanzen Nordends gefunden.', 15050),
(43562, 'deDE', 'Alptraumbeeren', 'Wird selten beim Mahlen von Pflanzen der Scherbenwelt gefunden.', 15050),
(43561, 'deDE', 'Irisierende Pollen', 'Wird selten beim Mahlen von Goldener Sansam, Traumblatt, Bergsilberweisling, Pestblüte und Eiskappe gefunden.', 15050),
(43560, 'deDE', 'Glühwürmchenstaub', 'Wird selten beim Mahlen von Feuerblüte, Lila Lotus, Arthas'' Tränen, Sonnengras, Blindkraut, Geisterpilz, und Gromsblut gefunden.', 15050),
(43559, 'deDE', 'Heuschreckenflügel', 'Wird selten beim Mahlen von Blassblatt, Golddorn, Khadgars Schnurrbart und Winterbiss gefunden.', 15050),
(43558, 'deDE', 'Nachtblütenflieder', 'Wird selten beim Mahlen von Wildstahlblume, Grabmoos, Königsblut und Lebenswurz gefunden.', 15050),
(43557, 'deDE', 'Giftige Efeubeeren', 'Wird selten beim Mahlen von Wilddornrose, Flitzdistel, Beulengras und Würgetang gefunden.', 15050),
(43517, 'deDE', 'Pinguin-Ei', 'Lehrt Euch, wie man dieses Haustier beschwört.', 15050),
(43002, 'deDE', 'Aufblasbare Landminen', 'Nur für militärischen Gebrauch', 15050),
(39904, 'deDE', 'Trinkgeld des Argentumkreuzzugs', 'Es klimpert.', 15050),
(39903, 'deDE', 'Trinkgeld des Argentumkreuzzugs', 'Es klimpert.', 15050),
(39303, 'deDE', 'Schneller fliegender Teppich', '', 15050),
(37100, 'deDE', 'Silberne Tinte', '', 15050),
(37089, 'deDE', 'Honigzapfen', '', 15050),
(36915, 'deDE', 'Froststahlbarren', '', 15050),
(25706, 'deDE', 'Luangas Befehle', 'Ein Dokument, das mit einer Reihe von scharfen, eckigen Zeichen bedruckt ist. Die Schrift selbst scheint vor Wut zu brodeln.', 15050),
(24288, 'deDE', 'Runenfaden', '', 15050),
(23051, 'deDE', 'Gleve des Verteidigers', '', 15050),
(21786, 'deDE', 'Geschliffener azerothischer Diamant', '', 15050),
(21785, 'deDE', 'Geschliffener Smaragd', '', 15050),
(21773, 'deDE', 'Geschnittener Opal', '', 15050),
(21772, 'deDE', 'Geschliffener Saphir', '', 15050),
(20965, 'deDE', 'Geschliffener Rubin', '', 15050),
(20962, 'deDE', 'Geschliffener Aquamarin', '', 15050),
(20953, 'deDE', 'Geschliffener Jade', '', 15050),
(20952, 'deDE', 'Geschliffener Achat', '', 15050),
(20880, 'deDE', 'Goldene Marke', 'Eine mächtige Marke, geschaffen aus der göttlichen Kombination des reinen Bösen der Nekropole und des Geldes.', 15050),
(20829, 'deDE', 'Geschliffener Mondstein', '', 15050),
(20825, 'deDE', 'Geschliffener Schattenedelstein', '', 15050),
(20822, 'deDE', 'Geschliffenes Tigerauge', '', 15050),
(20819, 'deDE', 'Geschliffener Malachit', '', 15050),
(20596, 'deDE', 'Schwere männliche Taurenmaske', '', 15050),
(20591, 'deDE', 'Schwere männliche Zwergenmaske', '', 15050),
(20221, 'deDE', 'Forors erdichtetes Ross', 'Beschwört einen reitbaren chromatischen Drachen oder gibt ihn frei. Das ist ein sehr schnelles Reittier. Hättest du wohl gerne!', 15050),
(18964, 'deDE', 'Schildkrötenei (Flachkopf)', 'Rechtklicken um Euren Schnappkiefer zu beschwören und/oder zu entlassen.', 15050),
(17967, 'deDE', 'Aufbereitete Schuppe von Onyxia', '', 15050),
(16339, 'deDE', 'Ross des Kommandanten', '', 15050),
(16057, 'deDE', 'Forscher-Knappsack', '', 15050),
(14062, 'deDE', 'Kodoreittier', '', 15050),
(12947, 'deDE', 'Alex'' Ring der Kühnheit', '', 15050),
(9572, 'deDE', 'Glyphische Rune', '', 15050),
(9443, 'deDE', 'Benutzte Monsterprobe', '', 15050),
(9417, 'deDE', 'Archaedischer Splitter', '', 15050),
(8840, 'deDE', 'Abtrünnige Stiefel', '', 15050),
(8633, 'deDE', 'Zügel des Leoparden', '', 15050),
(8628, 'deDE', 'Zügel des gefleckten Nachtsäblers', '', 15050),
(8590, 'deDE', 'Alte Pfeife des obsidianschwarzen Raptors', '', 15050),
(8589, 'deDE', 'Alte Pfeife des elfenbeinfarbenen Raptors', '', 15050),
(8583, 'deDE', 'Horn des Skelettreittiers', '', 15050),
(8546, 'deDE', 'Mächtiges Riechsalz', '', 15050),
(7994, 'deDE', 'Pläne: Orc-Kriegsgamaschen', '', 15050),
(7988, 'deDE', 'Pläne: Verschnörkelte Mithrilstiefel', '', 15050),
(7987, 'deDE', 'Pläne: Verschnörkelter Mithrilhelm', '', 15050),
(7986, 'deDE', 'Pläne: Verschnörkelte Mithrilbrustplatte', '', 15050),
(7681, 'deDE', 'Obsidiangolemsplitter', '', 15050),
(7550, 'deDE', 'Kriegerehre', '', 15050),
(5563, 'deDE', 'Der Fall von Ameth''Aran', '', 15050),
(5562, 'deDE', 'Die Lage von Ameth''Aran', '', 15050),
(5106, 'deDE', 'Rote Maske der Defias', '', 15050),
(3148, 'deDE', 'Arbeitshemd', '', 15050);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
