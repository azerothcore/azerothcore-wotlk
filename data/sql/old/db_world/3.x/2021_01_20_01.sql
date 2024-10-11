-- DB update 2021_01_20_00 -> 2021_01_20_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_20_00 2021_01_20_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609073866409457800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609073866409457800');

DELETE FROM `quest_request_items_locale` WHERE `ID` IN (57, 109, 155, 156, 161, 163, 167, 199, 212, 217, 224, 237, 253, 255, 256, 257, 258, 263, 271, 274, 275, 276, 277, 278, 280, 1369, 1371, 1375, 4603, 4604, 5517, 5521, 5524, 7789, 7795, 7800, 7805, 7811, 7818, 7823, 7824, 7836, 7874, 7875, 7876, 8157, 8158, 8159, 8163, 8164, 8165, 8294, 8426, 8427, 8428, 8429, 8430, 8431, 8432, 8433, 8434, 8435, 10357, 10362) AND `locale` = 'deDE';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(57, 'deDE', 'Kehrt zu mir zurück sobald Ihr 15 Skelettsatanskreaturen und 15 Skelettschrecken getötet habt, $N.', 18019),
(109, 'deDE', 'Ha... Hattet Ihr Glück??', 18019),
(155, 'deDE', 'Was wollt Ihr von mir? Ich bin ein sehr beschäftigter Mann…', 18019),
(156, 'deDE', 'Hallo, $N. Habt Ihr die Faulblüten für mich?', 18019),
(161, 'deDE', 'Habt Ihr was gesagt, Jungchen? Ich kann nix hören außer dem verdammten Dröhnen in den Ohren. Sagt mal, was habt Ihr denn da?', 18019),
(163, 'deDE', 'Ah, $N! So schnell zurück? Ihr wart doch bestimmt wieder auf der Jagd? Macht Euch keine Sorgen wenn Ihr ein paar Rückschläge hattet, auf lange Sicht wird es Euch besser machen!$B$B...Viel schlechter kann es sowieso nicht werden…', 18019),
(167, 'deDE', 'Habt Ihr ein Lebenszeichen von meinem Bruder finden können? Besteht Hoffnung nach all dieser Zeit?', 18019),
(199, 'deDE', 'Habt Ihr irgendwelche Hinweise finden können, $N?', 18019),
(212, 'deDE', '$N! Habt Ihr den Schenkel? Ich muss bald anfangen, ihn zuzubereiten, sonst ist das ganze Bankett ruiniert!', 18019),
(217, 'deDE', 'Grawmug und seine beiden Wachen, Knirscher und Muskelprotz, sind noch immer am Leben. Eure Mission ist nicht beendet, solange noch einer der drei am Leben ist. Das Zwergenreich zählt auf Euch, $N!', 18019),
(224, 'deDE', 'Der Loch Modan wird belagert, $N! Wir sind auf jedes einsatzfähige Mitglied der Allianz angewiesen. Habt Ihr schon 10 Stonesplitter-Troggs und 10 Stonesplitter-Späher getötet?', 18019),
(237, 'deDE', 'Wir brauchen mehr Zeit, $R. Ihr habt den Befehl, 10 Stonesplitter-Schädelhauer und 10 Stonesplitter-Seher zu töten. Setzt den Feind unter Druck, bis wir Verstärkung erhalten. Jetzt ist nicht die Zeit für Müßiggang.', 18019),
(253, 'deDE', 'Habt Ihr Elizas Grab schon gefunden? Habt Ihr das Herz des Einbalsamierers?', 18019),
(255, 'deDE', 'Habt Ihr schon Glück gehabt?', 18019),
(256, 'deDE', 'Ja? Kann ich Euch behilflich sein?', 18019),
(257, 'deDE', 'Kein Glück gehabt? Macht Euch nix draus, $N…$B$BNicht jeder kann so gut sein wie ich.', 18019),
(258, 'deDE', 'Es ist ganz normal, dass man sich selbst bemitleidet, wenn man sich vor jemandem blamiert, der so viel jünger ist als man selbst. Macht Euch nichts draus, Rinovaah…$B$BWie? Hab ich mir Euren Namen falsch gemerkt?', 18019),
(263, 'deDE', 'Schon wieder zurück? Nur für den Fall, dass ich mich nicht klar ausgedrückt habe: Ihr müsst 10 Schamanen der Splittersteintroggs und 10 Knochenknacker der Splittersteintroggs töten, $N. Und jetzt schnappt sie Euch, Trogg-Töter!', 18019),
(271, 'deDE', 'Ah, $N! Schon wieder hier? Zweifelsohne wart Ihr wieder auf der Jagd! Keine Sorge, es ist nicht schlimm, wenn Ihr ein paar Rückschläge einstecken müsst, davon werdet Ihr auf lange Sicht nur besser.$B$B... viel schlechter könntet Ihr ja sowieso nicht mehr werden...', 18019),
(274, 'deDE', 'Was bringt Ihr da von Ashlan?', 18019),
(275, 'deDE', 'Die Sümpfe weinen und die Moorkrabbler wüten noch immer.  Kehrt zu mir zurück, wenn Eure Aufgabe erledigt ist.', 18019),
(276, 'deDE', 'Eure Aufgabe steht noch an, junger $C.', 18019),
(277, 'deDE', 'Habt Ihr die Feuermach-Werkzeuge der Gnolle?', 18019),
(278, 'deDE', 'Habt Ihr die benötigten Dinge? Die Zeit drängt!!', 18019),
(280, 'deDE', 'Der Deckel des Fässchens schraubt sich langsam ab.', 18019),
(1369, 'deDE', 'Wenn Ihr nicht unser Feind seid, dann tut Ihr, was ich verlange!', 18019),
(1371, 'deDE', 'Wenn Ihr nicht unser Feind seid, dann tut Ihr, was ich verlange!', 18019),
(1375, 'deDE', 'Erledigt diese Aufgabe für die Magram und ich helfe Euch.', 18019),
(4603, 'deDE', 'Der Funkelmat 5200 ist leer und wartet auf ein schmutzverkrustetes Objekt zum Säubern sowie auf drei Silbermünzen, um loszulegen!', 18019),
(4604, 'deDE', 'Der Funkelmat 5200 ist leer und wartet auf ein schmutzverkrustetes Objekt zum Säubern sowie auf drei Silbermünzen, um loszulegen!', 18019),
(5517, 'deDE', 'Seid gegrüßt, mächtiger $C!  Habt Ihr die Ehrenmarken, um die ich bat? Wenn ihr mir die Marken übergebt, werde ich Euch Euren eigenen Chromatischen Mantel der Dämmerung aushändigen.', 18019),
(5521, 'deDE', 'Seid gegrüßt, mächtiger $C!  Habt Ihr die Ehrenmarken, um die ich bat? Wenn ihr mir die Marken übergebt, werde ich Euch Euren eigenen Chromatischen Mantel der Dämmerung aushändigen.', 18019),
(5524, 'deDE', 'Seid gegrüßt, mächtiger $C!  Habt Ihr die Ehrenmarken, um die ich bat? Wenn ihr mir die Marken übergebt, werde ich Euch Euren eigenen Chromatischen Mantel der Dämmerung aushändigen.', 18019),
(7789, 'deDE', 'Das Blut unserer Feinde ist ein Zeichen der Ehre. Habt Ihr ein solches Zeichen?', 18019),
(7795, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019),
(7800, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019),
(7805, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019),
(7811, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019),
(7818, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019),
(7823, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019),
(7824, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019),
(7836, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019),
(7874, 'deDE', 'Das Blut unserer Feinde ist ein Zeichen der Ehre. Habt Ihr ein solches Zeichen?', 18019),
(7875, 'deDE', 'Das Blut unserer Feinde ist ein Zeichen der Ehre. Habt Ihr ein solches Zeichen?', 18019),
(7876, 'deDE', 'Das Blut unserer Feinde ist ein Zeichen der Ehre. Habt Ihr ein solches Zeichen?', 18019),
(8157, 'deDE', '$N, der Bund von Arathor hat den ständigen Auftrag für Euch das Arathibecken wieder zu betreten, weitere Ressourcenkisten zu beschaffen und sie mir zu bringen.', 18019),
(8158, 'deDE', '$N, der Bund von Arathor hat den ständigen Auftrag für Euch das Arathibecken wieder zu betreten, weitere Ressourcenkisten zu beschaffen und sie mir zu bringen.', 18019),
(8159, 'deDE', '$N, der Bund von Arathor hat den ständigen Auftrag für Euch das Arathibecken wieder zu betreten, weitere Ressourcenkisten zu beschaffen und sie mir zu bringen.', 18019),
(8163, 'deDE', '$N, die Entweihten haben den ständigen Auftrag für Euch das Arathibecken wieder zu betreten, weitere Ressourcenkisten zu beschaffen und sie mir zu bringen.', 18019),
(8164, 'deDE', '$N, die Entweihten haben den ständigen Auftrag für Euch das Arathibecken wieder zu betreten, weitere Ressourcenkisten zu beschaffen und sie mir zu bringen.', 18019),
(8165, 'deDE', '$N, die Entweihten haben den ständigen Auftrag für Euch das Arathibecken wieder zu betreten, weitere Ressourcenkisten zu beschaffen und sie mir zu bringen.', 18019),
(8294, 'deDE', 'Das Blut unserer Feinde ist ein Zeichen der Ehre. Habt Ihr ein solches Zeichen?', 18019),
(8426, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(8427, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(8428, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(8429, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(8430, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(8431, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(8432, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(8433, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(8434, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(8435, 'deDE', 'Der Kampf gegen die Schildwachen der Silberschwingen in der Kriegshymnenschlucht ist von großer Bedeutung. Unter dem Vorwand einen Wald zu beschützen, der ihnen nicht gehört, versucht die Allianz der Horde eines unserer größten Holzvorkommen streitig zu machen.$B$BLasst dies nicht zu, $N! Kommt zu mir mit einem Beweis für ehrvolle Taten im Namen der Horde zurück!', 18019),
(10357, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019),
(10362, 'deDE', '$N, Ihr wart eine enorme Unterstützung bei unserer Stoffsammelaktion. Da wir sehr hart am Aufstocken unserer Vorräte arbeiten, muss ich Euch wohl auch von unserem neusten und schwerwiegendsten Mangel berichten: Runenstoff. Wir brauchen ihn ganz dringend und hoffen, dass Ihr uns hierbei, wie schon zuvor, wieder unterstützen könnt.$B$BSolltet Ihr gewillt sein, so bringt mir bitte all den Runenstoff, den Ihr entbehren könnt. Für den Anfang wären wir mit 60 Stücken einverstanden, dann sehen wir weiter.', 18019);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
