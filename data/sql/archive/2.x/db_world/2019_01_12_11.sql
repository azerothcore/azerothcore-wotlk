-- DB update 2019_01_12_10 -> 2019_01_12_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_12_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_12_10 2019_01_12_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1546089286503990311'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1546089286503990311');

-- ----------------------------
-- Insert data quest_request_items_locale
-- ----------------------------

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (6, 'deDE', 'Habt Ihr Garricks Schuppen gefunden? Sind wir diesen Schurken endlich los?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11, 'deDE', 'Seid gegrüßt, $N. Wart Ihr Gnolle töten?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (18, 'deDE', 'Habt Ihr schon diese Kopftücher für mich zusammenbekommen?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (19, 'deDE', 'Die Schwarzfelsorcs setzen uns noch immer stark unter Druck. Aber habt Ihr uns wenigstens von Tharil\'zun befreit?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (20, 'deDE', 'Na, habt Ihr Orcs erschlagen, $N? Dann zeigt es mir.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (22, 'deDE', 'Ich brauche für meine berühmte Fleischpastete nichts weiter als 8 Geiferzahnlebern!', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (33, 'deDE', 'He, $N, wie läuft die Jagd nach den erkrankten jungen Wölfen?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (34, 'deDE', 'Treibt Stopfwanst noch immer sein Unwesen, oder ist es Euch gelungen, Seenhain ein für alle Mal von dieser Plage zu befreien?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (36, 'deDE', 'Ich werde die Verna Brauenwirbel sehr vermissen! Ich nehme nicht an, dass Ihr ihr auf dem Weg hierher begegnet seid?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (38, 'deDE', 'Dann bringt mir die folgenden Zutaten:$B$B3 Stücke sehniges Geierfleisch$B3 Geiferzahnschnauzen$B3 Murlocaugen$B3 Okraschoten', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (47, 'deDE', 'Psst! Habt Ihr den Goldstaub für mich... für mich?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (54, 'deDE', 'Ihr bringt Nachricht von McBride? Im Vergleich zum Wald von Elwynn ist Nordhain das reinste Paradies. Wir wollen doch mal sehen, was Marschall McBride so zu berichten hat...$B$BGebt mir doch bitte seine Papiere.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (60, 'deDE', 'Habt Ihr schon die Kerzen gesammelt?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (61, 'deDE', 'Ah, eine Lieferung von meinem Bruder? Ausgezeichnet! Heute ist mir das Glück wirklich gewogen!', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (64, 'deDE', 'Ich nehm nicht an, dass Ihr meine Uhr gekriegt habt, oder?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (71, 'deDE', 'Hallo, $N. Habt Ihr herausgefunden, was aus Rolf und Malakai geworden ist?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (83, 'deDE', 'Ich habe fast kein Leinen mehr, $N. Bringt Ihr mir welches?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (84, 'deDE', 'Aaah... Ich bin am Verhungern! Habt Ihr die Pastete für mich, $N?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (86, 'deDE', 'Ich halte es nicht für richtig, den frechen Jungen, der meine Kette überhaupt erst gestohlen hat, dafür auch noch zu füttern, aber wenn es sein muss, damit ich mein Eigentum wiederbekomme, dann soll es eben so sein.$B$BHabt Ihr das Eberfleisch?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (87, 'deDE', 'Hallo, $N. Habt Ihr meine Halskette gefunden?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (88, 'deDE', 'Habt Ihr sie schon gesehen? Habt Ihr sie erwischt?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (89, 'deDE', 'Diese Brücke wird sich nicht selber bauen! Also wo sind diese Eisenspitzen und Eisennieten?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (91, 'deDE', 'Gebt 10 Schattenfellanhänger bei mir ab, dann erhaltet Ihr eine Belohnung.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (92, 'deDE', 'Ich brauche immer noch 5 Stücke zähes Kondorfleisch, 5 große Geiferzahnschnauzen und 5 Portionen knuspriges Spinnenfleisch.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (102, 'deDE', 'Habt Ihr bereits 8 Tatzen dieser verräterischen Gnolle erlangt?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (106, 'deDE', 'Was habt Ihr? Maybell ist der einzige Lichtstrahl in meinem trüben Leben. Schnell, lasst mich ihren Brief sehen!', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (107, 'deDE', 'Ihr habt da eine Nachricht von \"Oma\" Steinfeld, hm? Ich habe Mildred schon seit Jahren nicht mehr gesehen! Ich frage mich, was so wichtig ist, dass sie mir schreibt...', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (112, 'deDE', 'Habt Ihr den Kristalltang? Ich bin mir sicher, Maybell kann es kaum erwarten, zu ihrem Verehrer zu kommen.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (114, 'deDE', 'Habt Ihr Tommy Joe meinen Brief überbracht? Was hat er gesagt?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (115, 'deDE', 'Wie verläuft Euer Kampf gegen die Schattenzauberer? Habt Ihr die Mitternachtskugeln gefunden?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (120, 'deDE', 'Was bringt Ihr mir da?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (121, 'deDE', 'Sendet der General Nachricht? Ist Verstärkung unterwegs?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (125, 'deDE', 'Habt ihr meine Werkzeuge finden können?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (127, 'deDE', 'Ihr habt wohl\'n paar Sonnenfische für mich, hm?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (129, 'deDE', 'So, Darcy hat mir ein Mittagessen geschickt, wie? Sie hat wirklich ein gutes Herz. Na, dann mal her damit!', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (131, 'deDE', 'Da seid Ihr ja wieder, $N. Hat Parker das Mittagessen geschmeckt, das ich ihm geschickt habe?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (150, 'deDE', 'Habt Ihr die Flossen? Sputet Euch - diese Murlocs müssen vom See vertrieben werden!', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (151, 'deDE', 'Graumähne kann sich kaum noch auf den Beinen halten. Habt Ihr zufällig etwas Hafer für sie finden können?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (153, 'deDE', 'Bringt mir 15 rote Lederkopftücher, ich werde Euch gut dafür bezahlen.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (169, 'deDE', 'Was bringt Ihr mir da, $R?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (176, 'deDE', 'Ja, Hogger stellt für mich und meine Männer schon seit längerem ein echtes Problem dar. Habt Ihr mir etwas über die Bestie zu berichten?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (180, 'deDE', 'Welche Neuigkeiten bringt Ihr vor dieses Gericht?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (184, 'deDE', 'Ihr habt die Besitzurkunde meines Hofes? Wie schön! Einige Grobiane haben sie vor etlichen Tagen gestohlen... Ich dachte schon, ich würde sie nie wieder sehen!$B$BBitte, gebt sie mir. Wir sind auf dem Weg, Westfall zu verlassen, und so schnell werden wir nicht wiederkommen, aber wenn, dann werden wir diese Dokumente brauchen.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (218, 'deDE', '$N! Glück gehabt?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (373, 'deDE', 'Ja? Kann ich Euch irgendwie helfen?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (386, 'deDE', 'Wart Ihr bereits in Sturmwind, im Verlies? Ich fürchte, dass das falsche Spiel, das Targorr den Schrecklichen so lange am Leben erhalten hat, ihm irgendwann seine Freiheit wiederbringen wird. Er wurde zum Tode verurteilt, $N, nicht dazu, als Schachfigur in den politischen Plänen irgendeines Adeligen missbraucht zu werden.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (388, 'deDE', 'Wie ich sehe, seid Ihr wieder zurück, $C. Habt Ihr bereits 10 rote Wollkopftücher der Defias von diesem Abschaum im Verlies gesammelt?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (391, 'deDE', 'Entweder bringt Ihr mir Thredds Kopf oder ich nehme mir den Euren, kapiert, $N?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (1861, 'deDE', 'Habt Ihr die Probe, $N? Der Fluss der Magie in Sturmwind und Elwynn wurde verändert; ich muss wissen, ob sie in das Wasser sickert.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (3741, 'deDE', 'Hallo! Ich vermisse meine Halskette. Mein Papa hat sie mir geschenkt. Papa sagt, dass es Monster im See gibt. Habt Ihr irgendwelche Monster verhauen?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (3904, 'deDE', 'Habt ihr meine Ernte, $N?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (3905, 'deDE', 'Ihr seht so frohgemut aus! Kommt! Setzt Euch und trinkt etwas!', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (5545, 'deDE', 'Der Termin kommt immer näher, $C. Beeilt Euch bitte und holt diese Holzbündel.', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (5929, 'deDE', 'Kehrt erst zurück, wenn der große Bärengeist Euch wieder zu mir zurückschickt. Eure Ausbildung kann ohne seinen Segen nicht weitergehen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (6001, 'deDE', 'Wenn Ihr der Herausforderung getrotzt habt, die vor Euch liegt, wird Euch das ganze Wissen über die Kraft des Körpers und des Herzens zuteil werden. Bis dahin kann ich Euch nicht weiter behilflich sein.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (6181, 'deDE', 'Ihr seht aus, als hättet Ihr es eilig. Tja, dann seid Ihr hier genau richtig!', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (6261, 'deDE', 'Ist das Schweiß auf Eurer Stirn, $Gder Herr:gnädige Frau;? Ihr habt Euch beim Laufen zu sehr verausgabt. Nehmt nächstes Mal einen Greifen!', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (6281, 'deDE', 'Ihr seid gereist, ja? Seid Ihr an irgendwelchen interessanten Orten gewesen?', 18019);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8311, 'deDE', 'Die Erde scheint erst vor Kurzem aufgewühlt worden zu sein. Auf der obersten Schicht liegen Regenwürmer, die sich winden, um der finsteren Tiefe zu entkommen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8312, 'deDE', 'Die Erde scheint erst vor Kurzem aufgewühlt worden zu sein. Auf der obersten Schicht liegen Regenwürmer, die sich winden, um der finsteren Tiefe zu entkommen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8326, 'deDE', 'Es bereitet mir keine Freude, Euch um die Vernichtung dieser Kreaturen zu bitten. Wir haben in der Vergangenheit stets in Harmonie mit den Geschöpfen des Waldes gelebt, aber heute ist es anders. Der Grundsatz der Sin\'dorei lautet Überleben; vergesst das nie.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8330, 'deDE', 'Habt Ihr meine Sachen finden können? Sobald wir unsere Herrschaft über die Insel der Sonnenwanderer wiedererlangt haben, werde ich sie für meine Arbeit benötigen. Vorerst muss ich noch über den Sonnenbrunnen wachen... oder was davon übrig ist.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8335, 'deDE', 'Lasst Euch gewarnt sein - Felendren der Verbannte ist nur das Anzeichen eines viel größeren Problems. Sein Untergang wird lediglich unsere momentanen Schwierigkeiten lösen. Allen Blutelfen könnte das gleiche Schicksal wie ihn ereilen, sollten wir unserem Verlangen gänzlich erliegen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8336, 'deDE', 'Einst waren uns viele der Lebewesen auf dieser Insel friedlich gesinnt, unsere Magie hielt sie in einem permanenten Zustand der Kontrolle. Doch mit der Zerstörung des Sonnenbrunnens durch die Geißel verloren wir auch unsere Kontrolle über sie. Die Arkanspäne sind das letzte Überbleibsel unserer damaligen Beherrschungsmagie, und als solche können sie uns vielleicht bei der Erschaffung eines neuen Artefakts helfen, mit dessen Macht wir die Kontrolle zurückerlangen werden.$B$BNoch wichtiger, mithilfe der Fragmente könnten wir herausfinden, unter welchem Fluch diese Insel wirklich leidet...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8338, 'deDE', 'Ich entnehme Eurer Haltung, dass es um etwas Dringliches geht. Kann ich Euch irgendwie behilflich sein?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8350, 'deDE', 'Willkommen in meinem bescheidenen Gasthaus, $C. Ich nehme an, Ihr habt etwas für mich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8463, 'deDE', 'Habt Ihr die gestohlenen Kristalle gefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8468, 'deDE', 'Ihr habt etwas, das Ihr mir zeigen wollt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8472, 'deDE', 'War Eure Suche nach Arkankernen erfolgreich, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8474, 'deDE', 'Wollt Ihr mir etwas zeigen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8477, 'deDE', 'Habt Ihr mir Otembes Hammer gebracht, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8479, 'deDE', 'Habt Ihr mir Zul\'Maroshs Kopf gebracht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8480, 'deDE', 'Habt Ihr die zurückgelassenen Waffen an Euch bringen können?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8482, 'deDE', 'Ihr habt etwas für mich? Lasst mich einen Blick darauf werfen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8483, 'deDE', 'Habt Ihr Euch um den Eindringling gekümmert?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8487, 'deDE', 'Habt Ihr die von mir benötigten Erdproben eingesammelt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8490, 'deDE', 'Konntet Ihr den Runenstein mit Energie versorgen, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8491, 'deDE', 'Ihr seid schon zurück? Habt Ihr die Pelze?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8884, 'deDE', 'Wir Waldläufer von der Zuflucht der Weltenwanderer haben uns der Wiedergutmachung aller Schäden gewidmet, die unser schönes Land so schrecklich verheert haben. Egal, wie lange es auch dauern mag.$B$BIch kann mich doch darauf verlassen, dass Ihr mit den Murlocköpfen zurückgekehrt seid, die ich von Euch verlangt habe?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8885, 'deDE', 'Ihr verhelft mir zu Erfolg und Rache, $C. Habt Ihr den Ring?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8886, 'deDE', 'Ich bin dankbar für die Unterstützung von jemandem wie Euch, $N. Es stimmt mich fast schon wieder fröhlich. Allerdings erinnert es mich auch daran, was diese Monster meinem Schiff angetan haben und was mit Quel\'Thalas geschieht.$B$BHabt Ihr es geschafft, Teile meiner Fracht wiederzuerlangen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8887, 'deDE', 'Hallo, $C, Euer Anblick ist ein gutes Zeichen. Ich weiß, es ist verrückt, dass ich überhaupt hier bin, wo der Ankerplatz doch von den Getriebenen überfallen wurde. Velendris und seine Waldläufer haben geschworen mich zu beschützen, unter der Bedingung, dass ich von hier verschwinde, sobald ich meine Fracht wiedererlangt habe.$B$BWas habt Ihr da... das kommt mir so bekannt vor?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8889, 'deDE', 'Ich kann es aus dieser Entfernung nicht mit Sicherheit sagen... habt Ihr den Nachtschimmerturm bereits deaktiviert?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8891, 'deDE', 'Was ist das? Es kommt mir bekannt vor. Oh nein, dieses Tagebuch... meine Untersuchungen... dies hat all die schrecklichen Ereignisse verursacht.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (8895, 'deDE', 'Ja, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9062, 'deDE', 'Kein Glück? Na dann, sucht weiter. Das Buch ist überaus wichtig, $C.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9064, 'deDE', 'Warum unterbrecht Ihr meine Vorlesung, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9066, 'deDE', 'Habt Ihr meine Anweisungen befolgt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9067, 'deDE', 'Habe ich Euch nicht gerade losgeschickt, um mehr Festvorräte zu beschaffen? Oh, also man kann wirklich nicht von mir erwarten, dass ich mich an jedes Gesicht erinnere, nicht wahr? Ich treffe so viele... interessante Leute.$B$BWas ist Euer Anliegen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9076, 'deDE', 'Nun, habt Ihr seinen Kopf? Verschwendet nicht meine Zeit, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9130, 'deDE', 'Ja, was gibt\'s?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9133, 'deDE', 'Das ist eine ganz schön lange Liste, die Ihr da habt, meine Freundin. Lasst mich mal sehen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9134, 'deDE', 'Wow, dieses Warenpaket sieht aber mächtig schwer aus! Möchtet Ihr all das auf eins meiner Prachtstücke laden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9135, 'deDE', '$C, schon zurück? Das kann aber unmöglich alles sein, was auf der Liste stand!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9140, 'deDE', '$C, wurde das Windläuferdorf befreit? Diese verdammten Magister des Sanktums der Sonne fordern ständig von mir, dass ich ihnen endlich Überreste der Geißel gebe, die Ihr gerade für mich sammeln sollt.$B$BMacht Euch deshalb aber keine Sorgen! Nehmt Euch alle Zeit, die Ihr braucht, um diesen Auftrag sicher zu Ende zu führen. Ich kümmere mich derweil um die Magister.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9143, 'deDE', 'Habt Ihr die Trollohren?$B$BWisst Ihr, wenn wir ab und an mal etwas Unterstützung aus Tristessa erhalten würden, wäre die ganze Misere hier so nie passiert. Ich bin wirklich froh über Euer Kommen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9147, 'deDE', 'Und? Habt Ihr, was ich benötige? Beeilt Euch oder mit dem hübschen $R ist es gleich aus!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9148, 'deDE', 'Ihr habt den Brief?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9149, 'deDE', 'Habt Ihr die Exemplare, um die ich Euch gebeten habe, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9150, 'deDE', 'Habt Ihr die Essenzen, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9152, 'deDE', 'Sobald ich den Rest meiner Vorräte habe, kann ich mein Geschäft aufnehmen. Die Streitkräfte werden nicht weit kommen, wenn sie nicht das erhalten, womit sie regelmäßig ihren Handel treiben.$B$BKriegsgebiete können so florierend für das Geschäft sein, findet Ihr nicht auch, $C? So, habt Ihr Euch einen Weg durch all die Ghule zu meinem Karren bahnen können?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9156, 'deDE', 'Ihr habt etwas, das Ihr mir zeigen wollt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9157, 'deDE', 'Konntet Ihr die Medaillons beschaffen, $N? Die Ertrunkenen suchen immer noch diesen See heim!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9162, 'deDE', 'Sagt mir, $N, was habt Ihr herausgefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9163, 'deDE', 'Was machen unsere Bemühungen, die Nachtelfenverschwörung auf der Insel Shalandis aufzudecken, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9164, 'deDE', 'Hervorragende Arbeit, $N. Ohne Eure Hilfe hätten diese Gefangenen Ihren Verstand und Ihre Seele an die Geißel verloren.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9166, 'deDE', 'Gut, dass Ihr hier seid!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9167, 'deDE', 'Ist es getan? Wurde Dar\'Khan vernichtet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9171, 'deDE', 'Ich glaube ich kann den Magen der Dame sogar von hier aus knurren hören! Da Ihr hier seid und mich sprechen wollt, gehe ich davon aus, dass Ihr mir meine Zutaten bringt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9172, 'deDE', 'Ihr wünscht mit mir zu sprechen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9174, 'deDE', 'Wurde Aquantion schon zerstört?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9175, 'deDE', 'Was habt Ihr da, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9176, 'deDE', 'Habt Ihr die Kristalle schon geborgen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9193, 'deDE', 'Das ist eine äußerst makabre und würdelose Angelegenheit, $C. Ich kann Euch doch vertrauen, dass Ihr diesen Auftrag erfüllt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9199, 'deDE', 'Ich muss Euch wohl nicht erst sagen, dass wir uns diesen Ärger mit den von den Toten auferstandenen Trollen hier bei uns kaum leisten können! Wir haben schon genug Probleme mit der Todesfestung im Süden!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9207, 'deDE', 'Wie kann ich Euch helfen, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9214, 'deDE', 'Habt Ihr die Waffen beschafft? Sobald wir die Reihen der Waldschattentrolle dezimiert haben, können wir uns wieder dem Kampf gegen die Geißel widmen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9215, 'deDE', 'Was ist das für ein widerlicher Gestank?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9216, 'deDE', 'Habt Ihr die Zombieherzen, nach denen ich verlangt habe, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9217, 'deDE', 'Ihr habt mehr faulende Herzen gebracht? Ich kann alle gebrauchen die Ihr sammeln könnt, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9218, 'deDE', 'Habt Ihr die Proben, nach denen ich verlangt habe, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9219, 'deDE', 'Ihr habt mehr Wirbelknochenstaub beschafft? Ich kann alles gebrauchen was Ihr mir bringt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9255, 'deDE', 'Habt Ihr etwas für mich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9280, 'deDE', '$N, habt Ihr schon das benötigte Mottenblut für die Heilkristalle? Überlebende sind über das gesamte Tal verstreut und die Zeit drängt!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9293, 'deDE', 'Der Zustand aller Proben muss einwandfrei sein, damit wir eine Chance haben, den See zu entseuchen.$B$BUns bleibt nicht viel Zeit, $C!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9303, 'deDE', 'Je mehr wir tun können, um den Nistelwald aufzuräumen, desto schneller kann Zhanaa zurück an die Arbeit.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9305, 'deDE', 'Ich bin mir sicher, dass wir den Emitter mit den Ersatzteilen reparieren können! Mit etwas Glück, werden wir da draußen noch andere finden, mit denen wir uns in Verbindung setzen können.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9328, 'deDE', 'Ihr wünscht eine Audienz bei mir, $C? Ich kann mich nicht an eine Verabredung erinnern.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9345, 'deDE', 'Habt Ihr die Pflanzen gefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9349, 'deDE', 'Habt Ihr die Eier schon?$B$B<Legassis Magen knurrt vor Vorfreude.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9351, 'deDE', 'Konntet Ihr die Essenzen besorgen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9356, 'deDE', 'Ich kann es kaum erwarten, seinen Gesichtsausdruck zu sehen, wenn er reinhaut! Seit dem Absturz beschwert er sich, dass ich nur ans Essen denke. Nun, jemand muss uns schließlich ernähren, während er am Zeppelin herumschraubt!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9360, 'deDE', 'Was wollt Ihr mir zeigen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9361, 'deDE', 'Habt Ihr das Hölleneberfleisch erfolgreich geläutert?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9366, 'deDE', 'Das Teufelsblut... habt Ihr es bekommen, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9369, 'deDE', '$N, habt Ihr schon das benötigte Mottenblut für die Heilkristalle? Überlebende sind über das gesamte Tal verstreut und die Zeit drängt!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9370, 'deDE', 'Ihr seid zurückgekehrt, $N. Habt Ihr dem Aberwitz der Draenei ein Ende gesetzt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9372, 'deDE', 'Habt Ihr die Blutproben bekommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9373, 'deDE', 'Guten Tag, $C. Was bringt Euch in mein Lager?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9374, 'deDE', 'Hattet Ihr Glück, $N? Die Teiche von Aggonar liegen nördlich der Höllenfeuerzitadelle.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9376, 'deDE', 'Die Sache sieht nicht gut aus. So schafft sie es nie wieder auf die Straße. Habt Ihr den Beutel gefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9381, 'deDE', 'Habt Ihr alle Federn beisammen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9383, 'deDE', 'Habt Ihr die Magie des Kristalls gegen einen unkontrollierten Leerwandler eingesetzt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9387, 'deDE', 'Habt Ihr die Proben bekommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9391, 'deDE', 'Habt ihr getan, worum ich Euch gebeten habe, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9396, 'deDE', 'Habt Ihr die Schriftrollen, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9397, 'deDE', 'Ihr seid zurück. Habt Ihr mir ein Kaliriweibchen mitgebracht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9401, 'deDE', 'Sagt mir, ist der Assassine tot?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9402, 'deDE', 'Wie ist das Wasser?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9403, 'deDE', 'Nur das Wasser von den Elrendarfällen hat die erforderliche Reinheit für den Gebrauch von Magie. Habt Ihr es?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9404, 'deDE', 'Habt Ihr den lebendigen Zweig? Schnell, gebt ihn mir!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9405, 'deDE', 'Sagt mir, wonach Ihr sucht, damit ich Euch bei der Suche unterstützen kann.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9406, 'deDE', 'Was habt Ihr für uns, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9409, 'deDE', 'Hallo, $C. Was habt Ihr da? Ist das für mich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9410, 'deDE', 'Ihr könnt froh sein, dass Ihr noch lebt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9418, 'deDE', 'Endlich habe ich meine Freiheit wieder!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9420, 'deDE', 'Habt Ihr die Kalirifedern, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9424, 'deDE', 'Habt Ihr Sedai in Makurus Namen gerächt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9427, 'deDE', 'Ihr seid zurück, $N. Ist das Wasser gereinigt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9430, 'deDE', 'Habt Ihr die Relikte aus Sha\'naar bei Euch, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9438, 'deDE', 'Ihr bringt Kunde aus der Scherbenwelt, $C? Sodann, sprecht!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9442, 'deDE', 'Habt Ihr den Pilz schon besorgt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9447, 'deDE', 'Ihr seid zurück, $N. Habt Ihr Eure Aufgabe erledigt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9450, 'deDE', 'Das Gleichgewicht der Elemente scheint noch immer gestört, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9451, 'deDE', 'Zusammen werden die Zerschlagenen und die Draenei ein tieferes Verständniss für die Mysterien der Elemente wiedererlangen.$B$BSeid Ihr mit der für die Herstellung Eures Erdtotems notwendigen Komponenten zurückgekehrt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9452, 'deDE', 'Nehmt Euch vor den Murlocs in Acht: seltsame und extrem lästige kleine Kreaturen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9453, 'deDE', 'Was haltet Ihr von meiner Rüstung? Habe sie selbst hergestellt! Sie unterscheidet sich zwar etwas von den traditionellen Rüstungen, die wir normalerweise tragen, ist aber sehr bequem.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9454, 'deDE', 'Die Bälge der Hirsche taugen nichts, dafür ist ihr Fleisch köstlich zart.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9455, 'deDE', 'Was habt Ihr gefunden? Wo?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9463, 'deDE', 'Ich fürchte, ihr Zustand verschlimmert sich zusehends.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9465, 'deDE', 'Habt Ihr die Fackel?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9466, 'deDE', 'Gibt es Neuigkeiten über Schwarzkralle?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9467, 'deDE', 'Sprecht erst wieder mit mir, wenn Ihr Hauteurs Asche habt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9468, 'deDE', 'Ihr scheint Euch an ein paar Ecken versengt zu haben. Wie erging es Euch bei der Zusammenkunft mit der Flamme, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9473, 'deDE', 'Verschwendet keine Zeit, Junge.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9487, 'deDE', 'Ihr seid den Rohlingen nicht zu Nahe gekommen, hoffe ich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9488, 'deDE', 'Die Robe kann ohne die notwendigen Materialien nicht fertiggestellt werden, aber das ist Euch sicherlich bekannt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9490, 'deDE', 'Habt Ihr schon einen Beweis für Schwarzkralles Tod, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9492, 'deDE', 'Seid Ihr mit den Überresten von Kriegshäuptling Messerfaust zurück?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9493, 'deDE', 'Ich bin nicht so blauäugig zu denken, dass ein Sieg über die Legionäre der Zerschmetterten Hand unseren Sieg über die gesamte Höllenhorde bedeutet, aber es ist ein guter Anfang.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9494, 'deDE', 'Habt Ihr die, ehm, Glut?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9495, 'deDE', 'Habt Ihr einen Beweis für den Sieg über Kargath Messerfaust?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9501, 'deDE', 'Ja?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9504, 'deDE', 'Habt Ihr die Probe Reinsten Wassers aus den Ruinen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9506, 'deDE', 'Hattet Ihr Erfolg, Fremder?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9508, 'deDE', 'Wart Ihr Erfolgreich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9512, 'deDE', 'Arrr... Jarr... beim Klabautermann... Eh, \'tschuldigung Junge, ich muss mal wieder \'n bisschen Pirat spielen, bevor ich\'s ganz vergesse...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9514, 'deDE', 'Ihr habt etwas entdeckt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9523, 'deDE', 'Kommt nicht ohne uralte Relikte zurück.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9527, 'deDE', 'Meine Frau hieß Thalrisa und meine Tochter Magwin.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9530, 'deDE', 'Ich liebe es, wenn ein Plan aufgeht...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9531, 'deDE', 'Der Verräter wird noch bereuen, dass er sich mit dem Marinekommando der Allianz angelegt hat!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9537, 'deDE', 'Habt Ihr den elenden Lügner gefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9545, 'deDE', 'Habt Ihr eine Vision gehabt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9548, 'deDE', 'Konntet Ihr meine Ausrüstung finden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9549, 'deDE', 'Habt Ihr die Gegenstände, die ich nach Eisenschmiede bringen möchte?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9550, 'deDE', 'Vielleicht bezieht sich die Karte ja auf dieses alte Tagebuch.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9557, 'deDE', 'Möge das Licht bei all Euren Bemühungen mit Euch sein, $C. Was habt Ihr da?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9560, 'deDE', 'Es sind hässliche kleine Kreaturen. Sogar der blinde Behüter könnte sie sehen... und er ist blind.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9562, 'deDE', 'Ein Murloc hat mir in den Hintern getreten und mich angespuckt... und das am helllichten Tag!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9563, 'deDE', 'Probleme, das Bitter zu finden? Der gute alte Bernie in der Burg Nethergarde sollte Fässer davon auf Lager haben.$B$BEs sei denn, seine Vorräte sind ausgegangen... das wäre fatal!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9564, 'deDE', 'Ist das etwa das, was ich vermute?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9567, 'deDE', 'Habt Ihr schon etwas Wissenswertes von den Satyn der Nazzivus erlangt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9569, 'deDE', '<Verteidigerin Aalesia scheint eher durch Euch hindurch, als Euch anzusehen, sie ist voll und ganz mit den Satyrn beschäftigt.>$B$BSeid Ihr schon gegen den Anführer der Satyrn vorgegangen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9570, 'deDE', '<Kurz schnaubt Euch an.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9571, 'deDE', 'Hallo, Held!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9572, 'deDE', '$N, richtig? Stok\'ton hat mir gesagt, dass ich auf Euren Bericht warten soll.$B$BBringt Ihr gute Nachrichten?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9574, 'deDE', 'Konntet Ihr die Proben bekommen, die ich benötige?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9575, 'deDE', '$N, richtig? Chadwick hat mir gesagt, dass ich auf Euren Bericht warten soll.$B$BWAS macht Ihr hier?! Habt Ihr Eure Aufgabe erledigt? Seid Ihr denn ein kompletter Vollidiot? Ich könnte mich übergeben!$B$BJetzt schwingt Euren nutzlosen Hintern zu diesem Bollwerk und tut, was Euch aufgetragen wurde! Habt Ihr mich gehört?!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9578, 'deDE', 'Ja?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9579, 'deDE', '<Morae sieht Euch voller Hoffnung an.>$B$BSeid Ihr bei Eurer Suche auf Spuren von Galaen gestoßen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9580, 'deDE', 'Wie verläuft Eure Jagd, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9581, 'deDE', 'Konntet Ihr die erste Kristallprobe bekommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9584, 'deDE', 'Habt Ihr die zweite Kristallprobe?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9585, 'deDE', 'Habt Ihr die letzte Probe für mein Set?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9602, 'deDE', 'Ihr seid zurück!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9603, 'deDE', 'Guten Tag, $N. Interessiert Ihr Euch für einen Hippogryphenflug?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9604, 'deDE', 'Seid gegrüßt, Freund. Ihr seht aus, als hättet Ihr einen langen Weg hinter Euch. Wie kann ich Euch helfen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9605, 'deDE', 'Wohin wollt Ihr, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9606, 'deDE', 'Willkommen zurück, $N. Konnte Nurguni Euch alle Vorräte mitgeben, die auf der Liste standen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9607, 'deDE', 'Gefreiter, berichtet! Habt Ihr den Blutkessel schon erkundet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9608, 'deDE', 'Habt Ihr den Blutkessel schon erkundet? Was habt Ihr mir zu Berichten?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9616, 'deDE', 'Ja? Ich bin wirklich sehr beschäftigt, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9621, 'deDE', 'Ah, ein Besucher aus Quel\'Thalas! Welche Neuigkeiten bringt Ihr?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9623, 'deDE', '<Torallius rückt seine Augenklappe zurecht und sieht Euch an.>$B$BHaben wir der Hand von Argus nichts Besseres anzubieten?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9624, 'deDE', 'Man findet die Sandbirnen immer seltener, was natürlich weniger Kuchen und somit weniger Leckerli für die Elekk hier bedeutet. Konntet Ihr die benötigten Früchte auftreiben?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9626, 'deDE', 'Ihr seid weit gereist, um mich zu treffen. Was bringt Euch nach Orgrimmar?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9628, 'deDE', 'Konntet Ihr herausfinden, was das Vermessungsteam von seiner Rückkehr abgehalten hat?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9629, 'deDE', 'Hat der Apparat funktioniert? Habt Ihr die Murlocs für meine Untersuchungen makiert?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9632, 'deDE', 'Seid gegrüßt, $C. Was habt Ihr da?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9633, 'deDE', 'Willkommen in Auberdine. Was bringt Euch zur Dunkelküste?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9634, 'deDE', 'Wir müssen handeln, bevor die Felshetzer die einheimischen Raubtiere der Blutmythosinsel verdrängen. Konntet Ihr den Felshetzerbestand bereits etwas dezimieren?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9641, 'deDE', 'Konntet Ihr Kristallsplitter von den Kreaturen der Blutmythosinsel einsammeln?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9642, 'deDE', 'Solltet Ihr noch über mehr bestrahlte Kristallsplitter verfügen, tausche ich sie gerne gegen einen weiteren meiner Kristalle ein.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9643, 'deDE', 'Habt Ihr die Würgeranken bekommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9646, 'deDE', 'Wie kann ich Euch helfen, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9648, 'deDE', 'Vergesst nicht, die von mir benötigten Pilze sind einzigartig in unterschiedlichen Gebieten der Blutmythosinsel.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9649, 'deDE', 'Schon wieder zurück?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9663, 'deDE', 'Ihr habt jetzt keine Zeit zum Ausruhen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9669, 'deDE', 'Es war einfach grauenhaft...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9670, 'deDE', 'Und, hattet Ihr Glück?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9675, 'deDE', 'Oh, da wäre noch etwas! Ihr solltet mit Ganaar bei der Exodar sprechen. Er wird Euch das letzte bisschen Wissen bezüglich der Pflege und Ausbildung Eures Begleiters lehren.$B$BIhr findet ihn in der südwestlichen Ecke der Händlertreppe.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9682, 'deDE', 'Trauert ihrem Niedergang nicht nach, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9687, 'deDE', 'Die Kriege der Drachen sind seit langem vorüber. Was noch bleibt, sind die Knochen und die aufgewühlten Überbleibsel von Yseras Brut.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9688, 'deDE', 'Das Zusehen allein schmerzt mich. Bitte, lasst uns nicht noch weiter darüber sprechen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9689, 'deDE', 'Ich rate Euch, Verbündete mit Euch zu bringen, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9694, 'deDE', 'Es gibt so viele von ihnen... ich komme einfach nicht von dem Gefühl los, dass sie sich irgendwie vermehren.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9696, 'deDE', 'Ich habe hier etwas viel zu tun, $GAgent:Agentin; $N. Ich hoffe Euer Anliegen ist wichtig.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9698, 'deDE', '<Velen lächelt.>$B$BSeid gegrüßt, $N. Ich habe Euch erwartet.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9699, 'deDE', 'Ja?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9702, 'deDE', 'Stellt sicher, dass Ihr alle Beweise sorgfältig zusammentragt, $C! Wir fügen hier die Teile eines riesigen Puzzles zusammen. Ein Fehler von Euch könnte zu falschen Schlussfolgerungen führen.$B$BWo stünden wir dann mit unserem Verständnis für die Zangarmarschen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9703, 'deDE', 'Waren die Informationen korrekt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9705, 'deDE', 'Was habt Ihr gefunden, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9706, 'deDE', 'Was habt Ihr da, $N? Ist das ein Tagebuch?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9708, 'deDE', 'Habt Ihr die Proben schon?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9709, 'deDE', 'Habt Ihr schon alle Pilze, um einen neuen Garten für die Sumpflords anzulegen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9711, 'deDE', 'Ein Soldat von Matis\' Stand wird nicht alleine unterwegs sein. Gebt da draußen auf Euch Acht.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9714, 'deDE', 'Wir können immer noch mehr Bluthibiskus von den Schlurfern, Sumpfriesen und Tiefenfledermäusen im Echsenkessel gebrauchen. Bringt sie mir in Bündeln zu je fünf, und ich werde Euch sehr dankbar sein.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9715, 'deDE', 'Habt Ihr den Hibiskus, um den ich Euch gebeten habe?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9717, 'deDE', 'Der Tiefensumpf ist ein sehr gefährlicher Ort. Wenn Ihr euch scheut, dorthin zu gehen, würde ich Euch nicht als Feigling bezeichnen. Ich wäre allerdings auch alles andere als zufrieden, wenn Ihr mir nicht das brächtet, worum ich gebeten habe.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9718, 'deDE', 'Seid gegrüßt, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9719, 'deDE', 'Ihr seid zurück. Heißt das die Schattenmutter ist nicht mehr?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9720, 'deDE', 'Schon fertig, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9728, 'deDE', 'Schön, Euch wiederzusehen, $N. Wie läuft die Jagd nach den Naga?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9731, 'deDE', 'Welche Neuigkeiten bringt Ihr, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9738, 'deDE', 'Habt Ihr schon herausgefunden, was mit meinen Freunden passiert ist?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9739, 'deDE', 'Die Sporenbeutel! Habt Ihr sie?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9742, 'deDE', 'Habt Ihr noch mehr Sporensäcke gerettet, $R?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9743, 'deDE', 'Wie geht es mit dem Töten der Sumpflords voran? Zeigt diesen Wüstlingen, dass sie besser nicht in Sporlingsgebiet kommen sollen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9744, 'deDE', 'Ihr habt viele Riesen getötet, aber es sind immer noch viele übrig. Und sie greifen immer noch unsere Sporenbeutel an!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9748, 'deDE', 'Trinkt nicht das Wasser, $N!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9753, 'deDE', 'Ja?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9756, 'deDE', 'Kehrt erst wieder zurück, wenn Ihr erfolgreich gewesen seid!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9760, 'deDE', 'Ja?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9761, 'deDE', 'Seht Ihr hier irgendwo einen ungewöhnlich mutigen und starken Draenei?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9763, 'deDE', 'Wo ist Kalithresh? Ist er schon tot, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9769, 'deDE', 'Was ist los? Hat Euch jemand die Flügel gestutzt?$B$B<Magasha kichert über ihren Witz.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9772, 'deDE', 'Ihr seid zurück, aber Jyoba ist nicht bei Euch. Was ist mit ihm passiert?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9773, 'deDE', 'Bitte sagt mir nicht, dass Ihr mit leeren Händen zurückgekommen seid, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9774, 'deDE', 'Ich sehe, dass Ihr grinst. Ja, meine Rüstung wird etwas merkwürdig aussehen, bis ich das ganze alte Metall ersetzt habe, aber besser so als ungeschützt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9775, 'deDE', 'Ihr seht nicht aus wie einer meiner Männer. Was wollt Ihr, $R?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9777, 'deDE', 'So wie es aussieht brauchen wir sehr bald neue Sporen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9779, 'deDE', 'Schon zurück? Konntet Ihr das Schreiben finden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9780, 'deDE', 'Habt Ihr schon Fische für unsere Vorräte besorgt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9782, 'deDE', 'Konntet Ihr eine Probe der Erde des Todesmoors bekommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9784, 'deDE', 'Ich könnte noch mehr Pflanzenteile brauchen. Jetzt, da die Seen ihr Wasser verlieren, befürchte ich, dass die fremden Arten zunehmen werden. Ich brauche aber mehr Beweise, um meine Theorie zu untermauern.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9787, 'deDE', 'Habt Ihr die Götzen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9788, 'deDE', 'Habt Ihr meine Habseligkeiten gefunden, $N? Die Höhle ist nicht weit von Umbrafenn entfernt, nahe an der Grenze zu Nagrand.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9790, 'deDE', 'Habt Ihr schon ein paar lichtdurchlässige Flügel sammeln können?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9793, 'deDE', 'Wie kann ich Euch helfen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9794, 'deDE', '<Kialon schaut Euch misstrauisch an.>$B$BIch kenne Euch nicht, $R. Was wollt Ihr von mir?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9798, 'deDE', 'Was habt Ihr denn da?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9799, 'deDE', 'Hallo, $C. Habt Ihr die Blumen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9800, 'deDE', '<Elementarist Lo\'ap ballt seine Hände zu Fäusten und schüttelt den Kopf.>$B$BOgerfäuste...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9801, 'deDE', 'Habt Ihr die Reagenzien schon?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9802, 'deDE', 'Habt Ihr ein paar Pflanzenteile gefunden, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9803, 'deDE', 'Habt Ihr schon mit dem Ältesten von Wildfenn gesprochen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9805, 'deDE', 'Es beschämt mich, dass mein eigenes Volk die Gewässer in Nagrand beeinflussen möchte, um ein Marschland zu erschaffen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9806, 'deDE', 'Ihr seid zurück, $N. Habt Ihr die fruchtbaren Sporen bekommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9807, 'deDE', 'Wir können immer noch mehr fruchtbare Sporen gebrauchen, $R. Langstielpilze sind unglaublich nützlich. Wir können sehr viel mit ihnen anstellen, wenn wir sie anbauen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9808, 'deDE', 'Habt Ihr ein paar Glühkappen gefunden, $N? Sie wachsen fast überall in den Marschen.$B$BIhr könnt sie schon von weitem leuchten sehen, wenn Ihr genau hinschaut.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9811, 'deDE', 'Ihr wünscht eine Audienz bei mir, $C? Ich kann mich nicht an eine Verabredung erinnern.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9814, 'deDE', 'Habt Ihr die Pilze, Mann?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9815, 'deDE', 'Lasst keinen verseuchten Schlamm zurück!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9820, 'deDE', 'Was habt Ihr da, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9821, 'deDE', 'Gordawg isst den Stein. Gordawg findet den Thronräuber. Bringt Stein!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9822, 'deDE', 'Habt Ihr einen Beweis für die Pläne der Oger gefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9827, 'deDE', 'Was habt Ihr da, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9828, 'deDE', 'Was habt Ihr da, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9830, 'deDE', 'Ich hoffe, ich kann die Vorzüge des Fennblutergifts Anachoret Ahuurn und den anderen in Telredor zeigen. Aber dafür werde ich meine Vorräte verdoppeln müssen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9834, 'deDE', 'Hat $N die Bälge für Maktu?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9842, 'deDE', 'Habt Ihr ein paar Marschenfangklingen auftreiben können?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9846, 'deDE', 'Habt Ihr die Totems schon gesammelt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9847, 'deDE', 'Konntet Ihr den Geist von Wildfenn rufen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9848, 'deDE', 'War Eure Suche in Dolchfenn nach den Informationen, die ich zur Lösung des Gifträtsels benötige, erfolgreich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9849, 'deDE', 'Gordawg will den Stein zurück.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9851, 'deDE', 'Ein warmes Feuer und eine Frau an Eurer Seite könnt Ihr daheim finden. Hier jagen wir ernsthaft oder sterben bei dem Versuch.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9852, 'deDE', 'Es ist keine Schande zuzugeben, dass Ihr nicht den Mumm habt, eines der mächtigsten Tiere die dieses Land zu bieten hat, zu erlegen, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9853, 'deDE', 'Gordawg isst Gurokpulver.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9856, 'deDE', 'Habt Ihr Euch Aaskralle schon gestellt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9859, 'deDE', '<Harold schaut geschwächt zu Euch hoch und ringt sich ein Lächeln ab.>$B$BHabt Ihr...<hust>... den Huf?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9861, 'deDE', 'Gebt es her, schnell!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9863, 'deDE', 'Tut es für uns, weil wir es nicht für uns selbst tun können.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9867, 'deDE', 'Bringt mir den Kopf ihres Anführers, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9871, 'deDE', 'Was gibt\'s?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9872, 'deDE', 'Was gibt es?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9874, 'deDE', 'Die Orcs werden nicht verstehen, warum wir das tun, aber es muss getan werden. Für das Wohl der Orcs sowie der Zerschlagenen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9875, 'deDE', 'Habt Ihr etwas, das Ihr mir zeigen möchtet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9882, 'deDE', 'Habt Ihr die Kristallfragmente bekommen, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9883, 'deDE', 'Ihr habt noch mehr Kristallfragmente? Nehmt aber bitte keine, die noch mit dem Berg verbunden sind. Wir wollen keinen Ärger mit den Naaru.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9892, 'deDE', 'Habt Ihr noch mehr Kriegsperlen? Ihr findet genügend Oger weit im Norden, an der Grenze zu den Zangarmarschen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9893, 'deDE', 'Wie führen die Oger sich auf, $N? Harte Nuss, was?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9896, 'deDE', 'Habt Ihr den Stachel bekommen können? Denkt daran, wenn er beschädigt ist, ist er wertlos für mich!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9897, 'deDE', 'Es ist sehr...<hust>...nett von Kristen, dass sie ihre Tierhäute teilt, meint Ihr nicht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9898, 'deDE', 'Ich werde Glück haben - ich fühle es.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9910, 'deDE', 'Ehrfurcht aus Angst! Das ist so gut wie jeder andere Grund.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9911, 'deDE', '<Die Behüterin blinzelt ein paar Mal überrascht.>$B$BWoher habt Ihr dieses... Ding?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9914, 'deDE', 'Ich brauche Elfenbein, keine Entschuldigungen. Wir können natürlich Euren Anteil am Gewinn neu verhandeln. Ich glaube aber kaum, dass Ihr mit dem Ergebnis zufrieden sein werdet.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9915, 'deDE', 'Ich habe immer noch Bedarf an Elfenbeinstoßzähnen von den wilden Elekk in Nagrand. Unglücklicherweise kann ich es mir nicht mehr leisten, Euch dafür zu bezahlen.$BWenn Ihr mir aber trotzdem weiter Stoßzähne bringt, werdet Ihr Euch beim Konsortium sehr beliebt machen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9916, 'deDE', 'Vielleicht können unserer Kinder eines Tages ohne Hunger leben.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9917, 'deDE', 'Habt Ihr Neuigkeiten erfahren?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9919, 'deDE', 'Habt Ihr etwas, das Ihr mir zeigen möchtet, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9927, 'deDE', '<Lantresor schaut Euch entgeistert an.>$B$BSchon fertig?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9928, 'deDE', 'Wir werden einen nie dagewesenen Hass zwischen den beiden Klans säen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9931, 'deDE', 'Könnt Ihr vorhersehen, was als Nächstes geschieht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9932, 'deDE', 'Wisst Ihr nun, warum Ihr nie einen Krieg gegen mich gewinnen würdet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9933, 'deDE', 'Frieden sagt Ihr?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9934, 'deDE', '<Garrosh scheint von dem Angebot unbeeindruckt zu sein.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9946, 'deDE', 'Er ist sicher sehr schwer bewacht.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9956, 'deDE', 'Ich komme mir so dumm vor. Archerons Sohn, Corki, hat mich gefragt, was los ist, und ich habe es ihm gesagt. Jetzt ist er schon wieder verschwunden!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9962, 'deDE', 'Der Kampf ist vorüber, wenn Ihr oder Euer Gegner tot zu Boden geht.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9968, 'deDE', 'Habt Ihr meine Proben?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9990, 'deDE', 'Welche Neuigkeiten bringt Ihr, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9992, 'deDE', 'Ich habe eine Samenkornsammlung angefangen, aber ich werde Hilfe brauchen, bis ich genügend zusammen habe, um sie nach Sturmwind zu schicken.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9993, 'deDE', 'Habt Ihr ein paar Samenkörner für mich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9994, 'deDE', 'Ihr seht besorgt aus. Was ist los, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (9995, 'deDE', 'Ihr seht besorgt aus. Was ist los, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10001, 'deDE', 'Bleibt auf jeden Fall von den Vorarbeitern fern. Sie dürfen nichts von Eurer Anwesenheit mitbekommen. Die Folgen könnten verheerend sein!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10004, 'deDE', '<Sal\'salabim kratzt sich am Kopf.>$B$B[Dämonisch] Ik il romath sardon.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10009, 'deDE', 'Ihr ja nicht kommen zurück ohne Sal\'salabims Gold!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10012, 'deDE', 'Was habt Ihr da, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10013, 'deDE', 'Was habt Ihr da, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10016, 'deDE', 'Wie ich sehe habt Ihr die Gefahren des Waldes überlebt. Habt Ihr ein paar Schwänze für meinen Umhang?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10018, 'deDE', 'Konntet Ihr alle Pelze, die ich benötige, finden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10020, 'deDE', 'Habt Ihr das Blut bekommen, $N? Ohne das Blut wird Zahlia ihrem Sohn nie wieder in die Augen schauen können.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10022, 'deDE', 'Hat der alte Eisenkiefer Euch übers Ohr gehauen? Oder konntet Ihr den alten Gesellen überlisten?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10023, 'deDE', 'Der Geist wartet, $N. Habt Ihr den Pelz des Patriarchen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10024, 'deDE', 'Habt Ihr die Basiliskenaugen für Voren\'thals Elixier?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10028, 'deDE', 'Konntet Ihr ein paar unbeschädigte Gefäße finden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10030, 'deDE', 'Was ist das? Wer seid Ihr?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10035, 'deDE', 'Habt Ihr die Feder? Muss ich Euch für Eure waghalsige Kühnheit belohnen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10036, 'deDE', 'Habt Ihr ihn getötet? Ist Torgos tot?$B$BHabt Ihr den Beweis?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10037, 'deDE', '<Seth zieht Euch am Mantel.>$B$BHabt Ihr die Aale? Hä? Hä?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10045, 'deDE', 'Hallo, Kind.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10047, 'deDE', 'Die Schreie scheinen irgendwie... schwächer geworden zu sein. Möge das Licht dafür sorgen, dass es nicht nur Wunschdenken ist.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10055, 'deDE', 'Habt Ihr ein wenig wiederverwertbares Material unter all dem Staub, der Asche und der Kohle finden können?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10058, 'deDE', 'Ich dachte, ich hätte Euch gesagt, dass Ihr mich nicht stören sollt. Was gibt\'s?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10064, 'deDE', 'Ja?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10066, 'deDE', 'Konntet Ihr ein paar mutierte Greifer ausmerzen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10074, 'deDE', 'Der Erdkern dieser Gegend ist vom Kristallpulver des Bergs durchdrungen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10075, 'deDE', 'Dieser Stützpunkt war die erste Forschungseinrichtung für die Untersuchung von Naarukristallen.$B$BWir haben hier eine wahre Goldgrube an Forschungsunterlagen über die Kristalle des \"diamantenen\" Bergs, Oshu\'gun, gefunden. Wie es scheint, ist überall in diesem Gebiet etwas von der übrig gebliebenen Macht der Kristalle von Oshu\'gun enthalten. Wenn Ihr während Euren Abenteuern in diesem Gebiet Kristallpulver finden solltet, bringt es zu mir, und ich werde Euch ein Zeichen meiner Wertschätzung geben, dass Ihr bei den Rüstmeistern eintauschen könnt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10076, 'deDE', 'Das Kristallpulver des Bergs ist vom Erdenkern dieser Gegend durchdrungen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10077, 'deDE', 'Dieser Stützpunkt war die erste Forschungseinrichtung für die Untersuchung von Naarukristallen.$B$BWir haben hier eine wahre Goldgrube an Forschungsunterlagen über die Kristalle des \"diamantenen\" Bergs, Oshu\'gun, gefunden. Wie es scheint, ist überall in diesem Gebiet etwas von der übrig gebliebenen Macht der Kristalle von Oshu\'gun enthalten. Wenn Ihr während Euren Abenteuern in diesem Gebiet Kristallpulver finden solltet, bringt es zu mir, und ich werde Euch ein Zeichen meiner Wertschätzung geben, dass Ihr bei den Rüstmeistern eintauschen könnt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10078, 'deDE', 'Ihr scheint guter Laune zu sein. Haben die brennenden Belagerungsmaschinen der Horde Euch erheitert?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10086, 'deDE', 'Wie geht es mit der Sammelaktion voran? Habt Ihr etwas Wiederverwertbares finden können?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10087, 'deDE', 'Ich habe nach Zeichen von brennenden Kanonen Ausschau gehalten - Rauchschwaden oder den Schreien brennender Höllenorcs...$B$BHattet Ihr Erfolg mit Eurem Auftrag?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10091, 'deDE', 'Ja? Was kann ich für Euch tun, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10097, 'deDE', 'Habt Ihr sie gefunden, $N? War sie immer noch in den Hallen gefangen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10098, 'deDE', 'Die Relikte von Terokk sind schon viel zu lange aus Skettis fort. Konntet Ihr sie von den Sethekk zurückholen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10109, 'deDE', 'Habt Ihr das Gas?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10111, 'deDE', 'Habe ich meine Vorliebe für Eier erwähnt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10112, 'deDE', 'Hmm, wird mein Gedächtnis schon besser?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10116, 'deDE', 'Ihr wollt also das Kopfgeld für Häuptling Mummaki einfordern?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10117, 'deDE', 'Ihr wollt also das Kopfgeld für Häuptling Mummaki einfordern?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10120, 'deDE', 'Ich habe gesehen, wie Ihr mit Orion gesprochen habt - es muss eine wichtige Angelegenheit sein...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10129, 'deDE', 'Wenn Ihr beim ersten Versuch verfehlt, startet einen neuen...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10134, 'deDE', 'Das ist ein ganz schön großer Kristall, den Ihr da habt. Habt Ihr ihn von den Kolossen im Grat?$B$BLasst mich ihn anschauen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10140, 'deDE', 'Dem Licht sei Dank, dass Ihr heil hier angekommen seid. Die Ehrenfeste benötigt alle erfahrenen Krieger, die sie bekommen kann.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10144, 'deDE', 'Ich wünschte, ich hätte die Feuer sehen können. Dieser Sprengstoff hat mächtig Dampf!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10146, 'deDE', 'Dies ist ein wichtiger Auftrag, $N. Ich würde ihn nicht an irgendjemanden vergeben.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10159, 'deDE', 'Wie läuft es mit der Bereinigung des Dornnebelhügels?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10161, 'deDE', 'Habt Ihr genügend Teile gefunden? Wenn nicht muss ich die Bratpfanne verwenden, mit der Legassi die ganze Zeit herumwedelt. Dann muss ich den Zeppelin in die `Fliegende Bratpfanne` umbenennen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10162, 'deDE', 'Zeigt ihnen, dass nicht einmal die Himmel sicher sind!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10163, 'deDE', 'Zeigt ihnen, dass nicht einmal die Himmel sicher sind!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10165, 'deDE', 'Ich teile nicht gerne.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10166, 'deDE', 'Ihr seid zurück, $N. Habt Ihr denn noch nicht genug getan?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10168, 'deDE', '<Mutter Kashur ist sichtlich aufgebracht.>$B$BDiese Naaru sind weiser als alle Lebewesen in dieser Welt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10173, 'deDE', 'Ich werde nicht ruhen, bis Erzmagier Vargoth seinen Stab zurück hat. Konntet Ihr ihn den Klauen des Dämons entreißen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10183, 'deDE', 'Stress, Stress. Keine Zeit verschwenden! Es gibt ein Raketenschiff, das gebaut werden will!$B$BWas wollt Ihr?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10186, 'deDE', 'Sieht es etwa aus, als wäre die X-52 Netherrakete bereit zum Abflug? Durchquere ich den Wirbelnden Nether in meinem bequemen Kommandostuhl? Entdecke ich fremde neue Welten? Suche nach neuen Technologien und Geschäftsgelegenheiten? Dringe in Galaxien vor, die nie ein Goblin zuvor gesehen hat?$B$BNein!$B$BAlso hoffe ich, dass Ihr die Kristalle habt, nach denen ich Euch geschickt habe.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10188, 'deDE', 'Wenn ich vom Fluch des Turmes frei sein will, muss ich das Siegel haben.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10189, 'deDE', 'Habt Ihr bekommen, worum ich Euch gebeten habe, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10190, 'deDE', 'Habt Ihr die Batterie schon aufgeladen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10192, 'deDE', 'Habt Ihr das Buch besorgt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10197, 'deDE', 'Habt Ihr die Kleidungsstücke, um die ich Euch gebeten habe?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10198, 'deDE', 'Wie geht es mit der Bespitzelung voran, $N? Ihr solltet Euch lieber beeilen. Ich werde hier schon ganz kribbelig.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10199, 'deDE', 'Wenn ich das Gift von genügend vielen Netherrochenstacheln extrahieren kann, bekommen wir vielleicht den explosivsten Kraftstoff, der gemischt wurde!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10206, 'deDE', 'So schnell schon zurück? Nehmt mich besser nicht auf den Arm, $C.$B$BDer Erfolg des X-52-Projekts hängt davon ab, dass wir das Zeug so schnell wie möglich bekommen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10208, 'deDE', 'Die Legion ist bestimmt nicht auf unsere Überraschung gefasst, was, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10209, 'deDE', 'Habt Ihr den Stein von Gletscharius bekommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10211, 'deDE', 'Die Geschichten der Lebewesen sind kurz, $N. Die Geschichten der Städte dauern Jahre.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10221, 'deDE', 'Habt Ihr uns vor den Verwüstungen durch Dr. Bumm gerettet? Ich verspreche Euch, dass es diesmal keine explodierenden Wagen gibt, auch wenn das wirklich spaßig war!$B$BWir sollten das wirklich öfter tun!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10224, 'deDE', 'Habt Ihr schon alle Essenzen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10225, 'deDE', 'Äh, hallo. Ich bin hier ein wenig beschäftigt. Was habt Ihr da?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10226, 'deDE', 'Habt Ihr die Energie von diesen Elementaren schon? Oh, keine Hektik oder so. Hängt ja nur mein Leben und meine Karriere davon ab.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10229, 'deDE', 'Was ist das? Ein Buch von einem unerschütterlichen Geist? Wie merkwürdig. Lasst es mich anschauen, vielleicht kann ich mehr über die Geschichte der Unerschütterlichen erfahren.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10230, 'deDE', 'Wir müssen den Unerschütterlichen bald helfen. Wenn wir sie davon überzeugen können, sich uns anzuschließen, hat die Horde einen starken Verbündeten.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10234, 'deDE', 'Habt Ihr die Teile schon? Wir haben nur wenig Zeit, da die Legion überall gleichzeitig in unser Gebiet vorrückt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10235, 'deDE', 'Schon mit Verdammnisklaue abgerechnet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10236, 'deDE', 'Habt Ihr schon ein paar Ersatzteile für meinen Schredder gefunden? Ich möchte ihn wirklich gerne reparieren, damit ich mich weiter dem Bergbau in der Mine widmen kann. Irgendwie muss ich ja ein wenig Geld verdienen. Und wenn ich davon nur eine Fahrkarte nach Beutebucht kaufe. Ohne Rückfahrt!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10239, 'deDE', 'Konntet Ihr ein paar ihrer Energiequellen sammeln?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10240, 'deDE', 'Habt Ihr alle Runen aktiviert? Ich bin so gespannt, ob wir die Methode der Blutelfen hier verbessern können. Was einer von Kael\'thas\' Leuten tun kann, kann ein Kirin Tor noch besser!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10242, 'deDE', 'Willkommen im Rückenbrechergrat. Wie kann ich Euch dienen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10243, 'deDE', 'Die Symbole sehen fremdartig und unlesbar aus.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10245, 'deDE', 'Wollen wir mal schauen, was Ihr da habt, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10248, 'deDE', 'Was meint Ihr? Muss noch ein wenig optimiert werden, was?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10250, 'deDE', 'Habt Ihr schon in das Horn gestoßen? Wir müssen es bald tun. Wer weiß, wann Thrallmar die Unterstützung der Unerschütterlichen braucht.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10252, 'deDE', 'Levixus\' Armee wächst mit jeder weiteren Sekunde in ihrer Größe und Stärke. Ihr müsst Euch beeilen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10253, 'deDE', 'Wer seid Ihr und was wolt Ihr? Oh... IHR seid es.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10255, 'deDE', 'Habt Ihr die Ergebnisse des Experiments, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10257, 'deDE', 'Habt Ihr den Schlüsselstein?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10261, 'deDE', 'Ich hoffe, Ihr kommt wegen meiner Suchanzeige!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10262, 'deDE', 'Ist es vollbracht? Habt Ihr den Abschaum der Zaxxis vom Angesicht der Scherbenwelt ausgerottet und mir ihre Insignien gebracht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10265, 'deDE', 'Ich habe den Eindruck, dass der Prinz nach einem ganz bestimmten Kristall sucht, aber ich bin mir nicht sicher, welcher das ist.$B$BHabt ihr dem Schreckenslord schon seinen abgenommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10267, 'deDE', 'Habt Ihr die Vermessungsausrüstung, um die uns die Blutelfen betrogen haben?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10268, 'deDE', 'Tretet näher.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10269, 'deDE', 'Hallo, Reisender. Seid Ihr zu Hazzin gekommen, weil Ihr meine Waren begehrt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10270, 'deDE', 'Seid Ihr bereit über das Geschäft zu reden, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10272, 'deDE', 'Konntet Ihr die Eier sammeln?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10274, 'deDE', 'Habt Ihr Veraku schon herausgefordert und getötet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10275, 'deDE', 'Wollt Ihr kaufen oder verkaufen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10276, 'deDE', 'Willkommen zurück, Freund. Wie geht es mit der Suche nach dem Kristall voran?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10278, 'deDE', 'Habt Ihr meinen Apparat schon ausprobiert? Ich glaube, dass mein instabiler Sphärenrissgenerator so nahe am Abgrund funktionieren sollte.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10280, 'deDE', '<Das musikalische Klingen der Naarusprache erfüllt Euren Geist.>$B$BIch spüre, dass Ihr einen Gegenstand von großer Macht bei Euch tragt, $R. Was bringt Ihr mir?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10288, 'deDE', 'Ich habe gehört, wie Ihr mit Duron gesprochen habt. Ihr müsst einen wichtigen Auftrag haben!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10289, 'deDE', 'Ein Bericht von Orion? Gebt ihn mir, schnell!$B$B<Stirnrunzelnd überfliegt General Krakork den zerknitterten Brief.>$B$BVerdammt, es ist genau so, wie wir es befürchtet haben. Orion und seine Krieger können jeden Moment überrannt werden!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10290, 'deDE', 'Ich bin mir bewusst, dass das Sammeln von Farahlit sehr gefährlich ist, aber die Möglichkeiten sind gewaltig. Ein Händler, der nicht bereit ist, Risiken auf sich zu nehmen, kann seine Türen gleich schließen und sich den Ärger ersparen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10293, 'deDE', 'Ihr seid immer noch am Leben, was bedeutet, dass Ihr entweder den Kern besorgt oder Eure Meinung geändert habt. Was davon stimmt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10294, 'deDE', 'Habt Ihr es schon getan? Habt Ihr die Splitter?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10295, 'deDE', 'Habt Ihr den Baron der Leere Galaxis schon vernichtet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10299, 'deDE', 'Wart Ihr bei Eurer Aufgabe erfolgreich, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10300, 'deDE', 'Habt Ihr schon ein paar geeignete Kristalle für ein neues Kopfstück des Stabs gefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10301, 'deDE', 'Habt Ihr das Oculus besorgt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10308, 'deDE', 'Das Konsortium ist sehr daran interessiert, alle Rebellen der Zaxxis beim Hügel im Süden auszulöschen.$B$B$C, wenn Ihr Euch bei uns noch beliebter machen wollt, dann geht zurück und besorgt noch mehr ihrer Insignien.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10309, 'deDE', 'Meine Augen müssen von der ganzen Netherstrahlung hier schlechter werden. Habt Ihr schon das Herz des Teufelshäschers?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10312, 'deDE', 'Konntet Ihr das Stadtregister finden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10314, 'deDE', 'Was habt Ihr herausgefunden, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10319, 'deDE', 'Wir müssen erst Naberius\' Phylakterium beschaffen, bevor wir ihn angreifen können. Er ist sonst unverwundbar!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10321, 'deDE', 'Habt Ihr Eure Aufgabe schon erledigt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10322, 'deDE', 'Habt Ihr Eure Aufgabe schon erledigt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10323, 'deDE', 'Habt Ihr die Aufgabe, die ich Euch gegeben habe, schon erledigt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10324, 'deDE', 'Die Bälge der Böcke sind grob und stark und halten das Fleisch zäh. Es ist kaum essbar, aber wir können es für andere Zwecke einsetzen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10328, 'deDE', 'Hattet Ihr Glück mit den Anweisungen der Manaschmiede Duro?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10329, 'deDE', 'Hat der Plan funktioniert? Ehrlich gesagt habe ich fast befürchtet, dass Ihr in die Luft gejagt werdet.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10330, 'deDE', 'Habt Ihr Eure Aufgabe schon erledigt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10331, 'deDE', 'Hattet Ihr Glück bei der Suche nach meinem Hammer?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10334, 'deDE', '<Die Kuh schaut Euch misstrauisch an, bleibt aber stehen.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10335, 'deDE', 'Das ging aber schnell. Ihr müsst sehr effektiv arbeiten, wenn Ihr alle drei Markierungen schon aufgestellt habt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10338, 'deDE', 'Habt Ihr die Konsole abgeschaltet? Ihr solltet Euch beeilen, bevor ich meine Meinung dazu ändere.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10342, 'deDE', 'Habt Ihr schon genug Schiefer? Ich brauche eine ganze Menge, wenn ich genug Öl für den Raketentreibstoff der X-52 herstellen will.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10343, 'deDE', 'Habt Ihr die Überreste der Waffe, die Kael\'thas gegen das Dorf eingesetzt habt, gefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10345, 'deDE', 'Konntet Ihr Sechs-Uhr finden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10346, 'deDE', 'In der Abyssischen Untiefe sind immer noch genügend Ziele, $N. Schnappt Euch einen Greifen, wenn Ihr für eine weitere Runde bereit seid.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10347, 'deDE', 'Die Legion darf sich auf der Abyssischen Untiefe nicht in Sicherheit wiegen! Wir müssen immer und immer wieder zuschlagen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10348, 'deDE', 'Konntet Ihr die Pflanzen sammeln?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10349, 'deDE', 'Ist das ein Stück des riesigen Kristallsplitters oben auf dem Himmelssturzgrat?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10351, 'deDE', 'Hat es funktioniert? Was habt Ihr beobachtet? Habt Ihr herausgefunden, was im Himmelssturzgrat passiert ist?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10355, 'deDE', 'Konntet Ihr die Proben sammeln?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10365, 'deDE', 'Habt Ihr die Aufgabe, die ich Euch gegeben habe, schon erledigt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10367, 'deDE', 'Habt Ihr den Schlüssel schon, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10368, 'deDE', 'Sagt mir, $N. Sind die Ältesten des Lumpenpacks schon frei?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10369, 'deDE', 'Ist es vollbracht, $N? Ist Arzeth tot?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10384, 'deDE', 'Habt Ihr die Datenzelle sichergestellt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10385, 'deDE', 'Habt Ihr die Melderdaten schon besorgt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10390, 'deDE', 'Beeilt Euch, $C. Wir müssen das Konstruktionslager: Mageddon vernichten, bevor die Dämonen mit dem Bau fertig sind!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10392, 'deDE', 'Beeilt Euch, $N. Mit jeder Sekunde, in der das Warpportal offen steht, betritt ein weiterer Dämon diese Welt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10393, 'deDE', 'Ich habe nicht viel Zeit, $C. Womit wollt Ihr mich belästigen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10395, 'deDE', 'Was ist los, $C? Ich spüre, dass Ihr etwas gefunden habt, das von Verdammnis kündet.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10397, 'deDE', 'Habt Ihr das Warpportal schon geschlossen, $N? Während Ihr hier herumtrödelt kommen immer mehr Dämonen in die Scherbenwelt!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10405, 'deDE', 'Habt Ihr die Bandage besorgt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10407, 'deDE', 'Habt Ihr Socrethars Teleportationsstein schon besorgt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10408, 'deDE', 'Ist... Ist er wirklich tot? Vernichtet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10409, 'deDE', 'Das Licht sei mit Euch, $C.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10410, 'deDE', 'Was bereitet Euch Kummer, Kind?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10411, 'deDE', 'Sowohl der Schlick als auch der Abschaum sind extrem giftig. Wenn wir uns nicht um sie kümmern, verwandeln sie sich in erstarrte Leerenschrecken!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10413, 'deDE', 'Hm, Ihr seht dreckig aus... Was ist geschehen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10416, 'deDE', 'Habt Ihr schon einen arkanen Folianten besorgt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10417, 'deDE', 'Habt Ihr die Diagnoseergebnisse?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10419, 'deDE', 'Habt Ihr noch mehr arkane Folianten besorgt, $N? ', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10420, 'deDE', 'Habt Ihr schon ein paar teuflische Waffen besorgt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10421, 'deDE', 'Habt Ihr in letzter Zeit ein paar teuflische Waffen gefunden? Lasst das Licht seine Wirkung tun, $N. Erlaubt diesen verderbten Dingen nicht, in dieser Welt zu verweilen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10424, 'deDE', 'Habt Ihr die Diagnoseergebnisse?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10426, 'deDE', 'Habt Ihr schon versucht, die Energie der Kuppel zu fokussieren?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10427, 'deDE', 'Konntet Ihr ausreichend viele Talbuks markieren?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10429, 'deDE', 'Habt Ihr eine Probe von der monströsen Hydra?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10430, 'deDE', 'Sieht aus, als hättet Ihr den Prototyp. Hat Ghabar Euch geschickt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10432, 'deDE', 'Nun? Was hatte Theledorn zu sagen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10433, 'deDE', '<Shauly hebt die Stimme, um die Aufmerksamkeit der Astralen in der Nähe zu erregen.>$B$BHabt Ihr ein paar Pelze für mich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10435, 'deDE', 'Habt Ihr alles gesammelt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10437, 'deDE', 'Habt Ihr genügend Fragmente gesammelt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10449, 'deDE', 'Es ist mir eine Ehre, der Horde dienen zu können. Wie kann ich Euch helfen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10450, 'deDE', 'Habt Ihr Euch den Knochenmalmern gestellt, $N? Ich hoffe, dass Ihr ihr Blut in rauen Mengen vergossen habt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10456, 'deDE', 'Ich kann nicht deutlich genug sagen, dass diese Terrorwölfe der Donnerfürsten erledigt werden müssen. Ihre bloße Anwesenheit stört das Gleichgewicht des Lebenden Hains und all unsere Arbeit hier.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10457, 'deDE', 'Wie geht es mit der Verstärkung der Verteidigung des Lebenden Hains voran?$B$BSolange wir nicht wissen, was die Arakkoa im Lashhversteck vorhaben und die Horde sich auf der anderen Seite der Klamm befindet, habe ich Angst, dass wir unser neues Heim und unsere Arbeit nicht mehr verteidigen können, wenn wir nicht bald handeln.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10458, 'deDE', 'Ich fürchte, dass es keine Hoffnung für dieses Land gibt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10476, 'deDE', 'Nun, $N? Könnt Ihr nur Reden schwingen, oder habt Ihr mir etwas vorzuweisen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10477, 'deDE', 'Habt Ihr noch mehr Obsidiankriegsperlen dabei, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10478, 'deDE', 'Habt Ihr noch mehr Obsidiankriegsperlen besorgt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10479, 'deDE', 'Habt Ihr etwas, das Ihr mir zeigen möchtet, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10480, 'deDE', 'Wo auch immer Ihr die Naga findet, könnt Ihr sicher auch die gequälten Wassergeister finden.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10481, 'deDE', 'Bald werden wir mit den Geistern sprechen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10483, 'deDE', 'Bringt Ihr Neues von der Ehrenfeste, $N? Das ist gut. Unseren Vorgehen gegen die Dämonen und Höllenorcs gehen so langsam die fähigen Kämpfer aus!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10484, 'deDE', 'Habt Ihr die Talismane, $N? Es schmerzt mich zu wissen, dass diese verdammten Orcs die Insignien unserer Soldaten besitzen...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10485, 'deDE', 'Habt Ihr Morkhs zerschmetterte Rüstung? Habt Ihr Euch wieder todesmutig nach Zeth\'Gor begeben?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10487, 'deDE', 'Es sieht aus, als hätte die Allianz vor, uns überallhin zu folgen. Wir wollen ihnen beweisen, dass ihre Anwesenheit uns keineswegs einschüchtert.$B$BHabt Ihr besorgt, worum ich Euch gebeten habe?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10488, 'deDE', 'Wie geht es mit der Verstärkung unserer Terrorwolfverteidigung voran?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10489, 'deDE', 'Was habt Ihr da? Ihr seid aber stark!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10506, 'deDE', 'Hattet Ihr Glück da draußen? Ich weiß, dass es wegen der Oger der Blutschläger sehr gefährlich ist, aber wenn wir es vermeiden können, die Tiere zu töten, bin ich sehr froh.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10507, 'deDE', 'Ist es Erledigt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10508, 'deDE', 'Habt Ihr Socrethars Teleportationsstein schon besorgt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10510, 'deDE', 'Ist das nicht aufregend? Nach dem ganzen Dreck und den Insekten in Silithus ist dieser Ort hier ein wahres Paradies!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10511, 'deDE', 'Ziemlich trocken hier. Wie soll ich denn meinen Urlaub ohne etwas zu Trinken genießen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10512, 'deDE', 'Wie sieht es aus? Sind die Speerspießer so anspruchslos wie die Blutschläger oder sind sie auch fast dabei umgekommen wie ich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10514, 'deDE', 'Holt mir diese Knollen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10516, 'deDE', '$C, habt Ihr mein Schwert und meinen Schild?$B$BIch kann zwar jederzeit hier raus, aber es wäre mir sehr peinlich, wenn ich ohne meine Ausrüstung nach Sylvanaar zurückkehren müsste.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10518, 'deDE', 'Was führt Euch zu mir? Es gibt doch nicht etwa Ärger mit den Blutschlägern?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10522, 'deDE', 'Hattet Ihr Glück?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10523, 'deDE', 'Hattet Ihr Erfolg?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10524, 'deDE', 'Kenne ich Euch?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10525, 'deDE', 'Was habt Ihr gesehen? Sagt es mir! Ich muss wissen, wo es ist!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10526, 'deDE', 'Ihr könnt sicher nicht verstehen, wie wichtig diese Artefakte sind.$B$BWenn ich alle fünf beisammen habe, werde ich ein Ritual durchführen, das unser Besitzrecht an der Donnerfeste durch die Besänftigung der toten Geister festigen wird.$B$BVersteht Ihr nun, was daran so wichtig ist? Versteht Ihr nun, warum ich keine Zeit für Geplänkel habe?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10528, 'deDE', 'Ar\'tor schwebt leblos vor Euch.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10537, 'deDE', 'Fürchtet Euch nicht, Held. Wenn die Zeit gekommen ist, werde ich Euch helfen...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10538, 'deDE', 'Habt Ihr das gekochte Blut, $N? Ich würde es furchtbar gerne ohne Unterbrechungen untersuchen können...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10540, 'deDE', 'Die Litanei muss gefunden werden!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10541, 'deDE', '<Eine einzelne Träne läuft über Oronoks Wange.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10542, 'deDE', 'He, habt Ihr meine Wasserpfeife und das Gebräu schon?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10544, 'deDE', 'T\'chali will nicht mehr sprechen, bis $N den Fetisch benutzt hat, um die Häuser der Speerspießer und der Blutschläger zu verfluchen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10545, 'deDE', 'Sagt es T\'chali... hat das Gebräu funktioniert? Haben die Speerspießer es gemocht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10547, 'deDE', '<Tobias hebt eine Augenbraue.>$B$BBlutdistel? Nie davon gehört... Seid Ihr ein Friedensbewahrer? Ihr wisst, dass Ihr mir sagen müsst, wenn Ihr einer seid... Ich habe schließlich Rechte!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10550, 'deDE', 'Habt Ihr die Blutdisteln?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10555, 'deDE', 'Die groben Piktogramme in dem uralten Folianten weisen darauf hin, dass eine große Menge von Federn der Lashh\'an benötigt wird, um die Sprüche in dem Buch zu wirken.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10556, 'deDE', 'Das ist so aufregend! Ich kann es kaum abwarten, die Wirkung des Zaubers zu untersuchen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10563, 'deDE', 'Was habt Ihr herausgefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10564, 'deDE', 'Habt Ihr einen Weg gefunden, um den Vorrat an Höllenbestien der Legion zu zerstören?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10565, 'deDE', 'Die Arakkoa der Vekh\'nir waren viele Jahre lang gütige Wesen., doch nun hat sie etwas aufgehetzt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10567, 'deDE', 'Sobald der Herold bemerkt, dass Ihr seine Brut angreift, wird er sicher schnell reagieren.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10568, 'deDE', 'Habt Ihr die Schrifttafeln schon gefunden, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10569, 'deDE', 'Was habt Ihr entdeckt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10570, 'deDE', 'Beeilt Euch, Junge!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10571, 'deDE', 'Gibt es schon Neuigkeiten, $N? Wir haben nicht viel Zeit.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10572, 'deDE', '<Ihr reicht dem Schwadronskommandanten die Materialien.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10574, 'deDE', 'Habt Ihr die vier Fragmente des Medaillons, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10576, 'deDE', 'Das ist viel zu kompliziert, $R. Ihr würdet es nicht verstehen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10578, 'deDE', 'Ihr müsst schnell handeln!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10579, 'deDE', '$N!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10583, 'deDE', 'Habt Ihr ein Zeichen von Flanis in der Todesschmiede finden können?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10584, 'deDE', 'Diese Forschungsreihe mit den Elektromentaren ist faszinierend! Stellt Euch nur vor... Eine intelligente Kreatur, die wir nach Belieben erschaffen können und die all unseren Anweisungen folgt!$B$BWas kann da schon schiefgehen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10585, 'deDE', 'Wir können nicht zulassen, dass sie weiter produzieren. Habt Ihr dem Beschwörungsritual ein Ende gesetzt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10586, 'deDE', 'Bringt Ihr Neuigkeiten aus der Todesschmiede?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10587, 'deDE', 'Habt Ihr die Aufgabe, die ich Euch gegeben habe, schon erledigt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10588, 'deDE', 'Ist es vollbracht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10589, 'deDE', 'Wir müssen einen Weg finden, um diese Höllenbestien zu vernichten, $N. Wir sind schon weit gekommen, aber ein Fehlschlag würde uns alles kosten.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10594, 'deDE', 'Nun, habt Ihr die Messungen der singenden Kristalle, um die ich Euch gebeten habe?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10596, 'deDE', 'Was habt Ihr herausgefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10597, 'deDE', '<Ihr reicht Gulmok die Materialien.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10598, 'deDE', 'Habt Ihr einen Weg gefunden, um den Vorrat an Höllenbestien der Legion zu zerstören?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10601, 'deDE', 'Habt Ihr ein Zeichen von Kagrosh in der Todesschmiede finden können?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10602, 'deDE', 'Wir können nicht zulassen, dass sie weiter produzieren. Habt Ihr dem Beschwörungsritual ein Ende gesetzt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10603, 'deDE', 'Bringt Ihr Neuigkeiten aus der Todesschmiede?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10604, 'deDE', 'Die Anwesenheit der Legion in unserer Mitte ist nicht akzeptabel! Wir müssen einen Weg finden, damit fertigzuwerden, bevor sie ihre Angriffe erneuern können.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10606, 'deDE', 'Habt Ihr das Handbuch?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10609, 'deDE', 'Habt Ihr sie? Habt Ihr die Drachenessenzen, die ich so dringend brauche, um meine Experimente weiter zu führen?$B$BWusstet Ihr, dass diese Nethergroßdracheneier einmal Schwarzdracheneier waren? Es ist wahr! Aber als Draenor in tausend Stücke gesprengt wurde, waren die Eier dem Wirbelnden Nether ausgesetzt und sind mutiert.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10611, 'deDE', 'Habt Ihr das Handbuch?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10617, 'deDE', 'Für die Ernte braucht man eine schnelle und ruhige Hand. Ich hoffe, Ihr habt Erfolg.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10618, 'deDE', 'Die Flügel sind sehr zerbrechlich, können aber in vielen unserer Kunstgegenstände als Dekoration dienen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10621, 'deDE', 'Was habt Ihr da?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10623, 'deDE', 'Was habt Ihr da?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10624, 'deDE', 'Was meint Ihr? Ich werde natürlich etwas aus der Asche herstellen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10625, 'deDE', 'Wenn Ihr Eure Brille verliert, kann ich Euch eine neue herstellen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10626, 'deDE', 'Habt Ihr die Prototypen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10627, 'deDE', 'Habt Ihr die Prototypen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10629, 'deDE', 'Konntet Ihr meine Schlüssel finden? Ich bin mir sicher, dass einer der Hunde ihn gefressen hat. Wahrscheinlich ist es der, den ich Euch mitgegeben habe. Wahrscheinlich.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10632, 'deDE', 'Wie geht es mit dem Sammeln der Zähne voran?$B$BIch bin davon überzeugt, dass Ihr Eure Arbeit für uns gut machen werdet. Und während Ihr das tut, werden wir diesen Außenposten hier sichern.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10634, 'deDE', 'Fliegt zur Netherschwingenscherbe und beschafft die Rüstung.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10635, 'deDE', 'Ihr müsst die Geisterbrille benutzen, um die Geister von Schattenmond sehen zu können.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10636, 'deDE', 'Ihr müsst die Geisterbrille benutzen, um die Geister von Schattenmond sehen zu können.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10642, 'deDE', 'Ja, es besteht eine Dualität... Ich kann es fühlen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10643, 'deDE', 'Wenn Ihr Eure Brille verliert, kann ich Euch eine neue herstellen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10647, 'deDE', 'Willst du die Belohnung kassieren, Mann?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10648, 'deDE', 'Ich hoffe, Ihr habt etwas Großartiges getan, Mädel. Ansonsten macht Euch vom Acker!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10649, 'deDE', 'Habt Ihr das Buch besorgt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10651, 'deDE', 'Habt Ihr erledigt, worum ich Euch gebeten hatte, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10653, 'deDE', 'Tragt Ihr irgendwelche Insignien des Feindes bei Euch, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10656, 'deDE', 'Los, $N. Sprecht.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10657, 'deDE', 'Der Trick dabei ist, die repolarisierte Magnetsphäre rechtzeitig abzuschalten, bevor Ihr gegrillt werdet.$B$BNatürlich müsst Ihr Euch dabei gut überlegen, wie vielen Schlangen Ihr gleichzeitig gegenübersteht.$B$BWo wir gerade davon sprechen, habt Ihr die Sphäre schon aufgeladen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10658, 'deDE', 'Was habt Ihr in letzter Zeit für uns getan, $N? Der Krieg gegen Kael\'thas kämpft sich nicht von alleine, verstanden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10659, 'deDE', 'Sogar der kleinste Beitrag zu unserer Sache wird bemerkt, $N. Unsere Feinde sind stark, aber wir werden siegen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10660, 'deDE', 'Milzen! Ich brauche Milzen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10661, 'deDE', 'Milzen! Ich brauche Milzen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10662, 'deDE', 'Was führt Euch hierher, $C? Ich bekomme nicht viel Besuch.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10663, 'deDE', 'Was führt Euch hierher, $C? Ich bekomme nicht viel Besuch.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10664, 'deDE', 'Habt Ihr die Materialien?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10665, 'deDE', 'Konntet Ihr eine Manazelle aus der Mechanar schmuggeln?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10666, 'deDE', 'Habt Ihr das Buch besorgt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10667, 'deDE', 'Habt Ihr den Unterweltlehm bekommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10669, 'deDE', 'Ihr seid zurück. Ist Xeleth tot?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10670, 'deDE', 'Konntet Ihr den Edelstein O\'mroggs Klauen entreißen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10671, 'deDE', 'Habt Ihr mein Geschnetzeltes schon? Wie, das findet Ihr nicht lustig?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10673, 'deDE', 'Kommt in die Gänge! Der Appetit dieses Gnoms kennt keine Grenzen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10674, 'deDE', 'Ich nehme an, dass Ihr die Lichtkugeln bei Razaans Landung schon besorgt habt, wenn Ihr Zeit habt, hier mit mir zu plaudern. Ich würde sie wirklich gerne untersuchen und herausfinden, was die Astralen damit vorhaben.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10675, 'deDE', 'Habt Ihr diesen Dreckskerl Razaan schon erledigt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10677, 'deDE', 'Tagesmenü: Muskelmagen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10678, 'deDE', 'Tagesmenü: Teufelsflosses Balg', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10679, 'deDE', 'Habt Ihr das Schwert in der Lava der Hand von Gul\'dan gehärtet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10683, 'deDE', 'Habt Ihr die Schrifttafeln schon gefunden, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10684, 'deDE', 'Gibt es schon Neuigkeiten, $N? Wir haben nicht viel Zeit.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10685, 'deDE', 'Habt Ihr die vier Fragmente des Medaillons, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10687, 'deDE', 'Habt Ihr die Aufgabe, mit der ich Euch betraut habe, erfüllt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10692, 'deDE', 'Habt Ihr erledigt, worum ich Euch gebeten hatte, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10704, 'deDE', '<A\'dals Stimme summt melodisch in Eurem Geist.>$B$BIhr seid zurück. Habt Ihr die beiden Fragmente des Schlüssels zur Arkatraz bei Euch?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10707, 'deDE', 'Ihr seid zurück, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10712, 'deDE', 'Hallo hallo! Mein Klo... äh... mein Vetter Tally hat mir gesagt, dass Ihr vorbeikommen würdet. Habt Ihr etwas für mich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10714, 'deDE', 'Was habt Ihr erfahren, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10715, 'deDE', 'Habt Ihr die Giftdrüsen? Wenn nicht, dann hinfort mit Euch und wagt nicht, meine Zeit zu verschwenden, bevor Ihr sie habt!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10717, 'deDE', 'Wie geht es mit der Beschaffung der Netze voran? Meiner Einschätzung nach sind diese Netze der Wilderer stark genug, um unserer Sache dienlich zu sein.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10719, 'deDE', 'Was habt Ihr da? Ist da ein Blutfleck auf der Einladung?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10720, 'deDE', 'Ist es vollbracht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10721, 'deDE', 'So schnell schon zurück? Seid Ihr hier, um Rexxars Schulden zurückzuzahlen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10723, 'deDE', 'Die Oger der Blutschläger werden uns nie mehr belästigen, wenn Ihr Eure Aufgabe erfüllt habt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10742, 'deDE', 'Nur wenn Goc und Gorgrom der Drachenfresser tot sind, werden die Mok\'Nathal frei sein.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10747, 'deDE', 'Hattet Ihr viel Ärger beim Versuch, die Welpen zu fangen? Ich hoffe, Ihr habt Euch nicht verbrannt!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10749, 'deDE', '$C, so schnell schon zurück? Habt Ihr das Gift?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10754, 'deDE', 'Habt Ihr mir etwas zu zeigen, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10760, 'deDE', 'Was habt Ihr herausgefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10762, 'deDE', 'Was ist das?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10763, 'deDE', 'Habt Ihr die Materialien, um die ich Euch gebeten habe?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10764, 'deDE', 'Habt Ihr getan worum ich Euch gebeten habe, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10765, 'deDE', 'Was habt Ihr zu berichten, Soldat?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10768, 'deDE', 'Was habt Ihr zu berichten, Soldat?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10769, 'deDE', 'Ihr seid zurück!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10771, 'deDE', 'Ist es vollbracht? Habt Ihr etwas Leben in mein altes Zuhause zurückgebracht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10773, 'deDE', 'Was habt Ihr zu berichten, Soldat?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10774, 'deDE', 'Was habt Ihr zu berichten, Soldat?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10775, 'deDE', 'Was habt Ihr zu berichten, Soldat?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10776, 'deDE', 'Ihr seid zurück!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10777, 'deDE', 'Habt Ihr das Totem von Asghar beschafft?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10778, 'deDE', 'Konntet Ihr die Rute beschaffen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10780, 'deDE', 'Habt Ihr die Federn für den Stab schon gesammelt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10782, 'deDE', 'Seid Ihr mit dem magieerfüllten Kopfstück zurück?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10785, 'deDE', 'Habt Ihr bekommen, was auch immer in diesem Sack des Gronns war? Habt Ihr es Zobelmähne gebracht? Hat er Euch etwas für mich mitgegeben?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10791, 'deDE', 'Die Verbindung mit dem Wolfgeist wiederherzustellen ist nur der Anfang meiner Reise, nicht das Ende.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10793, 'deDE', '<General Auralion schwebt in der Mitte des Kristalls.>$B$BWa... Was tut Ihr hier?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10797, 'deDE', 'Hallo, Junge! Was gibt es Neues?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10799, 'deDE', 'Habt Ihr die Giftdrüsen? Wenn nicht, dann hinfort mit Euch und wagt nicht, meine Zeit zu verschwenden, bevor Ihr sie habt!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10800, 'deDE', 'Ihr steht mir wieder gegenüber, $C. Das muss bedeuten, dass Ihr den Sack unter Grullocs Nase weggeschnappt habt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10801, 'deDE', 'Hat der Baron uns eine Falle gebaut? Eine, die stark genug ist, um einen Gronn zu töten?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10802, 'deDE', 'Wurde die Nachricht schon überbracht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10806, 'deDE', 'Bald werden alle Söhne des Gruul vernichtet sein.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10808, 'deDE', 'Ist es vollbracht, $N? Habt Ihr den Dunklen Rat davon abgehalten, das Ritual zu vollenden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10809, 'deDE', 'Berichtet, $N. Ist das Blut des Blutenden Auges da auf Eurem Ärmel? Ich hoffe doch!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10810, 'deDE', 'Geht mir nicht auf die Nerven! Könnt Ihr nicht sehen, dass ich dabei bin, mysteriöse Kräfte zu entfesseln?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10812, 'deDE', 'Ich traue meinen Augen nicht.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10813, 'deDE', 'Die Orcs des Blutenden Auges waren einst starke Verbündete... und nun sind sie noch stärkere Feinde.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10822, 'deDE', 'Sogar der kleinste Beitrag zu unserer Sache wird bemerkt, $N. Unsere Feinde sind stark, aber wir werden siegen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10823, 'deDE', 'Wie verläuft der Kampf gegen Keals Streitmacht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10824, 'deDE', 'Los, $N. Sprecht.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10825, 'deDE', '$C, könnt Ihr das spüren? Ich fühle, dass etwas Unnatürliches und Böses in der Nähe ist.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10826, 'deDE', 'Tragt Ihr irgendwelche Insignien des Feindes bei Euch, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10834, 'deDE', 'Die Bösartigkeit der Orcs des Blutenden Auges kennt keine Grenzen und wird nur noch von der ihrer Vettern der Zerschmetterten Hand übertroffen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10835, 'deDE', 'Guten Tag, $N. Wie gefällt Euch Euer Aufenthalt auf der Höllenfeuerhalbinsel? Ich bin mir sicher, dass er sehr ergiebig ist...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10837, 'deDE', 'Ich brauche Netherrankenkristalle.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10838, 'deDE', 'Habt Ihr die Messung? War Euer Auftrag mit dem dämonischen Seher erfolgreich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10839, 'deDE', 'Die Dunkelheit umgibt uns. Was habt Ihr mir aus dem Skithversteck zu berichten?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10847, 'deDE', 'Ihr seid zurück, $C. Welche Neuigkeiten bringt Ihr?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10849, 'deDE', 'Ihr seid weit gereist und bringt mir Nachrichten.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10851, 'deDE', 'Wart Ihr im Außenposten der Speerspießer und habt ihnen die Totems abgenommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10853, 'deDE', 'Die Drachen des Singenden Bergrückens sind vielleicht eine Bedrohung für uns, doch sie sind majestätische Wesen.$B$BOder sie waren es zumindest. Ich hoffe, dass Ihr ihre Geister retten könnt.$B$BUnd falls Ihr noch mehr Totems brauchen solltet, habe ich noch ein paar über.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10854, 'deDE', 'Verschwendet keine Zeit, wir haben viel zu tun!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10857, 'deDE', 'Ist es vollbracht? Sind die Teleporter außer Gefecht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10859, 'deDE', 'Habt Ihr alle Lichtkugeln der Razaani, die ich brauche, gesammelt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10860, 'deDE', 'Habt Ihr alle Zutaten schon? Darüber zu reden hat mir das Wasser im Munde zusammenlaufen lassen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10867, 'deDE', 'Habt Ihr es getan? Sind die Seelen unserer Vorfahren sicher vom Bösen der Astralen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10876, 'deDE', 'Habt Ihr Euch der Hand von Kargath gestellt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10877, 'deDE', 'Habt Ihr das Schreckensrelikt? Wir müssen es bekommen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10880, 'deDE', 'Wollt Ihr mir etwas zeigen, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10881, 'deDE', 'Habt Ihr die Relikte, $N? Wir können nicht zulassen, dass der Schattenrat sie für seine dunklen Zwecke einsetzt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10884, 'deDE', '<A\'dal grüßt Euch.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10885, 'deDE', '<A\'dal grüßt Euch.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10894, 'deDE', 'Wie kann ich Euch helfen? Bringt Ihr Nachrichten aus dem Ewigen Hain?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10904, 'deDE', 'Habt Ihr die Kanonenkugeln schon?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10909, 'deDE', 'Die Höllengeister der Orcs der Zerschmetterten Hand sind für Jules\' arme Seele eine Schmach. Sagt mir, $N... habt Ihr ihn gerächt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10911, 'deDE', 'Habt Ihr beide Warpportale schon zerstört?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10912, 'deDE', 'Ist es vorbei? Ist die Gefahr an der Schwelle des Todes abgewendet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10913, 'deDE', 'Ich weiß, es ist eine grausame Aufgabe...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10916, 'deDE', 'Habt ihr die Gebetsperlen schon gefunden, $N? Ihre Macht ist für viele heilige Rituale unerlässlich... darunter auch für einen Exorzismus...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10917, 'deDE', 'Seid Ihr mit den Federn zurück, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10923, 'deDE', 'Habt Ihr Teribus den Verfluchten aus den Himmeln Terokkars vertrieben?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10924, 'deDE', 'War Zeppit freundlich genug, das Blut für Euch zusammeln?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10929, 'deDE', 'Wir glauben, dass das, was wir bei den Ausgrabungen gefunden haben, tatsächlich nur ein Wurmkind war!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10930, 'deDE', 'Habt Ihr den großen Wurm gefunden?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10935, 'deDE', 'Geht zu Anachoret Barada, $N. Er muss mit seinem Ritual Erfolg haben, wenn der Oberst gerettet werden soll.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10970, 'deDE', 'Hattet Ihr Glück?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10971, 'deDE', 'Habt Ihr ein paar Identifizierungsmarken finden können?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10972, 'deDE', 'Ich brauche mehr Identifikationsmarken, $N. Ich konnte bisher herausfinden, dass sie nicht nur die Gefangenen katalogisieren, sondern auch Aussagen über ihre Aufenthaltsorte machen!$B$BSobald wir diesen Code entschlüsselt haben, können wir genau feststellen, wo unsere Verbündeten festgehalten werden und sie mit minimalem Gewalteinsatz befreien.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10974, 'deDE', 'Ihr habt es geschafft! Hattet Ihr Glück?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10975, 'deDE', 'Wir sitzen in der Sackgasse, $N. Die Daten, die Ihr gesammelt habt, haben uns genügend Informationen geliefert, um unsere Verbündeten aus den kleineren Gefängnissen des Nethersturms retten zu können. Wir müssen uns jedoch dringend um die Bedrohung kümmern, die von den Kammern hier im Ladeplatz von Bash\'ir ausgeht.$B$BSchließt Euch dem Kampf gegen das Astraleum an! Bringt mir die Gefängnisschlüssel des Astraleums, damit ich Stasiskammerschlüssel für die Stasiskammern von Bash\'ir für Euch herstellen kann. ', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10976, 'deDE', 'Dies wird Eure furchteinflößendste Aufgabe sein, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10977, 'deDE', 'Ich könnte verstehen, wenn Ihr lieber nicht weitermachen wollt, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10995, 'deDE', 'Ist Grulloc schon Geschichte?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10996, 'deDE', 'Habt Ihr die Truhe?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10997, 'deDE', 'Haltet Ihr Slaags Standarte schon in Euren Händen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (10998, 'deDE', 'Habt Ihr Vim\'gol den Üblen beschworen und seinen toten Klauen den Zauberfolianten entrissen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11000, 'deDE', 'Habt Ihr Skullocs Seele schon geraubt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11004, 'deDE', 'Habt Ihr den Staub, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11006, 'deDE', 'Der Kommandant scheint doch nicht aus einem Fieberwahn heraus gesprochen zu haben. Bringt mir mehr Staub und ich werde ein weiteres Elixier für Euch herstellen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11008, 'deDE', 'Habt Ihr Euren Auftrag schon erledigt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11010, 'deDE', 'Habt Ihr schon ihre Stapel mit Teufelskanonenkugeln vernichtet?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11013, 'deDE', '<Mor\'ghor grunzt.>$B$BIhr seid spät...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11015, 'deDE', 'Kristalle der Netherschwingen werden für vielerlei Dinge verwendet. Hauptsächlich zur Herstellung von Waffen und Rüstungen...', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11016, 'deDE', 'Wir verwenden die Bälge von Schindern zum Ausfüttern von Rüstungen und die Herstellung von Planen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11017, 'deDE', 'Wie ich schon sagte, Netherstaubpollen werden von unseren Zauberern verwendet.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11018, 'deDE', 'Gug dort drüben verwendet das Erz zum Verstärken unserer Waffen und Rüstungen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11020, 'deDE', 'Es ist eine schmutzige Arbeit, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11021, 'deDE', 'Ihr wollt mir etwas zeigen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11023, 'deDE', 'Wie steht es mit dem Bombenangriff?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11024, 'deDE', 'Ihr seid mit dem Geruch Skettis\' behaftet! Was hat das zu bedeuten?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11025, 'deDE', 'Wenn Ihr mehr über die Splitter und Kristalle lernt, werdet Ihr uns und unsere Ogerbrüder dort unten besser beschützen können.$B$BDie Splitter selbst wurden nach einer uralten und mittlerweile ausgelöschten Arakkoazivilisation benannt, die einst auf den Spitzen dieser Berge lebte.$B$BNun, habt Ihr die Splitter bei Euch?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11027, 'deDE', 'Die Dämonen von dem Camp da machen die Transporter immer wieder ganz. Gahk sagt $N muss die Dämonen besser plattmachen diesmal!$B$BAber Gahk braucht noch \'ne Dunkelrune um zu machen eine kristallgeschmiedete Rune.$B$BWenn klein $R nicht haben Dunkelrune, Du sprechen mit Kronk! Er versuchen Dunkelrunen zu machen jeden Tag! Vielleicht Du bekommen eins aus Kronks Grabbelsack?!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11029, 'deDE', 'Das Buch, $N. Habt Ihr es?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11030, 'deDE', 'Habt Ihr das magische Fläschchen schon bekommen? Es würde Torkus Junior alles bedeuten.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11035, 'deDE', 'Tote Orcs singen nicht, $N. Stellt sicher, dass keiner der Transporter des Drachenmals entkommt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11036, 'deDE', 'Ist das die Lieferung vom alten Orok?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11040, 'deDE', 'Diese Kiste sieht aus, als stamme sie von einem Goblinmeisteringenieur. Hat Bossi Euch geschickt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11041, 'deDE', 'Wer wagt es, an Mor\'ghor heranzutreten? Ich hoffe für Euch, dass es von Wichtigkeit ist.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11049, 'deDE', 'Was macht die Eierjagd?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11050, 'deDE', 'Diese Eier dürfen auf keinen Fall in die falschen Hände geraten, $N. Wenn Ihr noch mehr Eier findet, bringt sie mir.$B$BVerhaltet Euch auf jeden Fall unauffällig und erregt bloß keinen Verdacht!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11051, 'deDE', 'Jemand mit Eurer Erfahrung dürfte keine Probleme damit haben, ein paar Dämonen zu bannen. Ihr habt doch keine Schwierigkeiten damit, oder, $R?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11054, 'deDE', 'Es gilt Peons zur Ordnung zu rufen, $N! Beeilt Euch!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11055, 'deDE', 'Der Trick liegt im Handgelenk, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11056, 'deDE', '$N, Ihr seid zurück! Ich dachte schon, Ihr hättet mich im Stich gelassen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11059, 'deDE', 'Wir verabscheuen Gewalt, aber wenigstens ist das Konstrukt, das Ihr vernichten sollt, kein lebendiges Wesen.$B$BWo wir schon davon sprechen, habt Ihr den Kopf?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11061, 'deDE', 'Dieses Fläschchen des Zauberers wird meine Jungs sicherlich noch intelligenter machen, als sie es ohnehin schon sind. Damit sollten ihnen die täglichen Pflichten in der Himmelswache der Sha\'tari etwas leichter fallen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11065, 'deDE', 'Habt Ihr schon ein paar Ätherrochen gebändigt? Ihr seht so aus, als könntet Ihr mit einem Lasso umgehen. Sicher habt Ihr Euren Auftrag schnell abgeschlossen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11066, 'deDE', 'Ihr leistet hervorragende Arbeit für uns, $N! Ich möchte Euch nur wissen lassen, dass wir Eure Bemühungen, uns mit frischen Reittieren zu versorgen, sehr zu schätzen wissen!', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11072, 'deDE', 'Habt Ihr Eure Mission erfüllt, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11074, 'deDE', 'Ich benötige einen Gegenstand von jedem der Nachfahren von Terokks ärgsten Feinden. Nur dann können wir Terokk beschwören.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11076, 'deDE', 'Habt Ihr die Fracht eingesammelt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11078, 'deDE', 'Wie geht es voran, $N? Ich brauche Euch sicherlich nicht extra zu sagen, wie wichtig die ganze Angelegenheit für unsere Luftüberlegenheit ist.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11079, 'deDE', 'Ihr haben Peitsche?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11081, 'deDE', 'Was ist das?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11082, 'deDE', 'Nun? Warum dauert das so lange?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11089, 'deDE', 'Habt Ihr die benötigten Bauelemente für die Anfertigung der Seelenkanone?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11090, 'deDE', 'Ist es vollbracht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11093, 'deDE', 'Ihr seid also zurück! Hat sich der Rochen auch gut benommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11094, 'deDE', 'Beruhigt Euch, Kind.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11095, 'deDE', '<Hobb nickt.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11097, 'deDE', 'Habt Ihr sie mit Euren Fäusten zerschmettert, Kommandant?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11098, 'deDE', 'Ihr habt etwas für mich?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11099, 'deDE', 'Beruhigt Euch, Kind.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11100, 'deDE', '<Arcus nickt.>', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11101, 'deDE', 'Habt Ihr sie mit Euren Fäusten zerschmettert, Kommandant?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11130, 'deDE', '<Budd beäugt die Notiz misstrauisch.>$B$BWas habt Ihr da, $C?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11242, 'deDE', 'Schön, Euch wiederzusehen, $N. Ich bin sicher, die Kinder freuen sich schon auf die Geschichten über Eure Heldentaten.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11372, 'deDE', 'Die Häuptlingszeremonie findet bald statt, beeilt Euch.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11392, 'deDE', 'Die Erde scheint erst vor Kurzem aufgewühlt worden zu sein. Auf der obersten Schicht liegen Regenwürmer, die sich winden, um der finsteren Tiefe zu entkommen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11401, 'deDE', 'Die Erde scheint erst vor Kurzem aufgewühlt worden zu sein. Auf der obersten Schicht liegen Regenwürmer, die sich winden, um der finsteren Tiefe zu entkommen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11403, 'deDE', 'Schön, Euch wiederzusehen, $N. Ich bin sicher, die Kinder freuen sich schon auf die Geschichten über Eure Heldentaten.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11404, 'deDE', 'Die Erde scheint erst vor Kurzem aufgewühlt worden zu sein. Auf der obersten Schicht liegen Regenwürmer, die sich winden, um der finsteren Tiefe zu entkommen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11405, 'deDE', 'Die Erde scheint erst vor Kurzem aufgewühlt worden zu sein. Auf der obersten Schicht liegen Regenwürmer, die sich winden, um der finsteren Tiefe zu entkommen.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11505, 'deDE', 'Die Geister sind ruhelos, $N. Habt Ihr Eure Aufgabe vollbracht?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11506, 'deDE', 'Die Geister von Auchindoun sind um uns. Werden sie uns eine Wohltat zuteilwerden lassen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11515, 'deDE', 'Diese Monster sind eine Schande für unser Volk. Wir müssen sie vernichten, $N.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11516, 'deDE', 'Ist es vollbracht, $N? Kael\'thas darf keine weitere Verstärkung durch die Legion erhalten.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11665, 'deDE', 'Schon Krokis in den Abwasserkanälen gefangen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11666, 'deDE', 'Wie fischt sich\'s denn heute, mein Junge?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11667, 'deDE', 'Sagt mir, dass Ihr ihn gefangen habt. Bitte sagt mir, dass Ihr den Mistkarpfen gefangen habt.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11668, 'deDE', 'Was haben wir denn heute gefangen, mein Junge?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11669, 'deDE', 'Der Teufelsblut ist ein Wunder der Evolution. Er kann in allen Gewässern und sogar Lava überleben. Fischer sind seine einzigen natürlichen Feinde.$B$BGlück beim Beutefang gehabt?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11877, 'deDE', 'Seid Ihr mit den Plänen zurückgekommen?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (11880, 'deDE', 'Konntet Ihr die Messungen durchführen? Der Gnom wird mich wieder anbrüllen, wenn ich die kostbaren Daten nicht herbekomme.', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (12133, 'deDE', 'Ja, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (12155, 'deDE', 'Ja, $N?', 26972);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14023, 'deDE', 'Wir können immer etwas von der köstlichen Gewürzbrotfüllung gebrauchen, sie ist ausgesprochen beliebt.', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14024, 'deDE', 'Mehr Kürbiskuchen? Genau rechtzeitig.', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14028, 'deDE', 'Rieche ich da etwa Moosbeerenchutney?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14030, 'deDE', 'Seid Ihr gekommen, um am Pilgerfreudenfestmahl teilzunehmen?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14033, 'deDE', '$N, wie schön, Euch zu sehen.', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14035, 'deDE', 'Was hat Euch denn wieder nach Darnassus verschlagen, $N?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14037, 'deDE', 'Die Tafel könnte wirklich noch etwas mehr Gewürzbrotfüllung vertragen.', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14040, 'deDE', 'Wir können immer frischen Kürbiskuchen gebrauchen.', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14041, 'deDE', 'Wie gefallen Euch die Pilgerfreuden, $C?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14043, 'deDE', 'Willkommen zurück, $N.', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14044, 'deDE', 'Wie gut, Euch wiederzusehen, $N.', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14047, 'deDE', 'Was hat Euch denn wieder nach Orgrimmar verschlagen, $N?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14048, 'deDE', 'Habt Ihr ein paar Truthähne aufgespürt?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14051, 'deDE', 'Wie sieht es mit der Füllung aus?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14053, 'deDE', 'Konntet Ihr etwas Moosbeerenchutney auftreiben?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14054, 'deDE', 'Wie geht es mit dem Kuchen voran?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14055, 'deDE', 'Habt ihr die kandierten Süßkartoffeln dabei?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14058, 'deDE', 'Habt Ihr die kandierten Süßkartoffeln?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14059, 'deDE', 'Konntet Ihr etwas Moosbeerenchutney auftreiben?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14060, 'deDE', 'Wie steht es mit dem Kuchen?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14061, 'deDE', 'Wie steht\'s mit der Truthahnjagd?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14062, 'deDE', 'Wie sieht es mit der Füllung aus?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14064, 'deDE', 'Habt Ihr ausreichend an einem reich gedeckten Tisch gespeist?', 28153);

INSERT INTO `quest_request_items_locale`(`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (14065, 'deDE', 'Habt Ihr ausreichend an einem reich gedeckten Tisch gespeist?', 28153);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
