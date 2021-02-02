-- DB update 2020_12_03_03 -> 2020_12_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_03_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_03_03 2020_12_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606563608380973800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606563608380973800');

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (5659, 5660, 5661, 5662, 5663, 6066, 6067, 7805, 7806, 7811, 7812, 7818, 7819, 7823, 7824, 7825, 7832, 7836, 7837, 7922, 7923, 7924, 7925, 8293, 8368, 8386, 8389, 8426, 8427, 8428, 8429, 8430, 8431, 8432, 8433, 8434, 8435, 9234, 9235, 9236, 9237, 9239, 9240, 9241, 9242, 9243, 9244, 9245, 9246, 10357, 10358, 10362, 10363, 24823, 24828) AND `locale` = 'deDE';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(5659, 'deDE', 'Ah, gut, ein weiterer ist eingetroffen. Zeit mag für mich keine Rolle spielen aber für Euch ist sie von entscheidender Bedeutung. Es gibt viel für Euch zu lernen und ich möchte Euch viel beibringen. Ihr müsst Euch einfach beweisen. Tut dies und Ihr werdet reich belohnt werden.', 18019),
(5660, 'deDE', 'Ah, gut, ein weiterer ist eingetroffen. Zeit mag für mich keine Rolle spielen aber für Euch ist sie von entscheidender Bedeutung. Es gibt viel für Euch zu lernen und ich möchte Euch viel beibringen. Ihr müsst Euch einfach beweisen. Tut dies und Ihr werdet reich belohnt werden.', 18019),
(5661, 'deDE', 'Ah, gut, ein weiterer ist eingetroffen. Zeit mag für mich keine Rolle spielen aber für Euch ist sie von entscheidender Bedeutung. Es gibt viel für Euch zu lernen und ich möchte Euch viel beibringen. Ihr müsst Euch einfach beweisen. Tut dies und Ihr werdet reich belohnt werden.', 18019),
(5662, 'deDE', 'Ah, gut, ein weiterer ist eingetroffen. Zeit mag für mich keine Rolle spielen aber für Euch ist sie von entscheidender Bedeutung. Es gibt viel für Euch zu lernen und ich möchte Euch viel beibringen. Ihr müsst Euch einfach beweisen. Tut dies und Ihr werdet reich belohnt werden.', 18019),
(5663, 'deDE', 'Ah, gut, ein weiterer ist eingetroffen. Zeit mag für mich keine Rolle spielen aber für Euch ist sie von entscheidender Bedeutung. Es gibt viel für Euch zu lernen und ich möchte Euch viel beibringen. Ihr müsst Euch einfach beweisen. Tut dies und Ihr werdet reich belohnt werden.', 18019),
(6066, 'deDE', 'Ja, ich glaube Ihr seid bereit…', 18019),
(6067, 'deDE', 'Ja, ich glaube Ihr seid bereit…', 18019),
(7805, 'deDE', 'Fantastisch - Ich kann Euch versichern, dass wir sofort Gebrauch davon machen werden. Lasst Euch erneut für Eure Mithilfe gedankt sein! Ohne Euch wären wir mit Sicherheit verloren.$B$BDa ihr schon so viel gespendet habt, wäre ich natürlich bereit, mich auch um jede weitere Spende Runenstoff zu kümmern, die Ihr in Zukunft tätigen wollt. Kommt einfach zu mir, ich werde dann persönlich dafür sorgen, dass Eure guten Taten nicht unbeachtet bleiben!', 18019),
(7806, 'deDE', '$N - ohne Helden, die sich wie Ihr für Eisenschmiede einsetzen, müssten wir so einiges in Kauf nehmen. Danke für Eure redlichen Bemühungen!', 18019),
(7811, 'deDE', 'Fantastisch - Ich kann Euch versichern, dass wir sofort Gebrauch davon machen werden. Lasst Euch erneut für Eure Mithilfe gedankt sein! Ohne Euch wären wir mit Sicherheit verloren.$B$BDa ihr schon so viel gespendet habt, wäre ich natürlich bereit, mich auch um jede weitere Spende Runenstoff zu kümmern, die Ihr in Zukunft tätigen wollt. Kommt einfach zu mir, ich werde dann persönlich dafür sorgen, dass Eure guten Taten nicht unbeachtet bleiben!', 18019),
(7812, 'deDE', '$N - ohne Helden, die sich wie Ihr für uns Gnome einsetzen, müssten wir so einiges in Kauf nehmen. Danke für Eure redlichen Bemühungen!', 18019),
(7818, 'deDE', 'Fantastisch - Ich kann Euch versichern, dass wir sofort Gebrauch davon machen werden. Lasst Euch erneut für Eure Mithilfe gedankt sein! Ohne Euch wären wir mit Sicherheit verloren.$B$BDa ihr schon so viel gespendet habt, wäre ich natürlich bereit, mich auch um jede weitere Spende Runenstoff zu kümmern, die Ihr in Zukunft tätigen wollt. Kommt einfach zu mir, ich werde dann persönlich dafür sorgen, dass Eure guten Taten nicht unbeachtet bleiben!', 18019),
(7819, 'deDE', '$N - ohne Helden, die sich wie Ihr für die Verlassenen einsetzen, müssten wir so einiges in Kauf nehmen. Danke für Eure redlichen Bemühungen!', 18019),
(7823, 'deDE', 'Fantastisch - Ich kann Euch versichern, dass wir sofort Gebrauch davon machen werden. Lasst Euch erneut für Eure Mithilfe gedankt sein! Ohne Euch wären wir mit Sicherheit verloren.$B$BDa ihr schon so viel gespendet habt, wäre ich natürlich bereit, mich auch um jede weitere Spende Runenstoff zu kümmern, die Ihr in Zukunft tätigen wollt. Kommt einfach zu mir, ich werde dann persönlich dafür sorgen, dass Eure guten Taten nicht unbeachtet bleiben!', 18019),
(7824, 'deDE', 'Fantastisch - Ich kann Euch versichern, dass wir sofort Gebrauch davon machen werden. Lasst Euch erneut für Eure Mithilfe gedankt sein! Ohne Euch wären wir mit Sicherheit verloren.$B$BDa ihr schon so viel gespendet habt, wäre ich natürlich bereit, mich auch um jede weitere Spende Runenstoff zu kümmern, die Ihr in Zukunft tätigen wollt. Kommt einfach zu mir, ich werde dann persönlich dafür sorgen, dass Eure guten Taten nicht unbeachtet bleiben!', 18019),
(7825, 'deDE', '$N - ohne Helden, die sich wie Ihr für Donnerfels einsetzen, müssten wir so einiges in Kauf nehmen. Danke für Eure redlichen Bemühungen!', 18019),
(7832, 'deDE', '$N - ohne Helden, die sich wie Ihr für Orgrimmar einsetzen, müssten wir so einiges in Kauf nehmen. Danke für Eure redlichen Bemühungen!', 18019),
(7836, 'deDE', 'Fantastisch - Ich kann Euch versichern, dass wir sofort Gebrauch davon machen werden. Lasst Euch erneut für Eure Mithilfe gedankt sein! Ohne Euch wären wir mit Sicherheit verloren.$B$BDa ihr schon so viel gespendet habt, wäre ich natürlich bereit, mich auch um jede weitere Spende Runenstoff zu kümmern, die Ihr in Zukunft tätigen wollt. Kommt einfach zu mir, ich werde dann persönlich dafür sorgen, dass Eure guten Taten nicht unbeachtet bleiben!', 18019),
(7837, 'deDE', '$N - ohne Helden, die sich wie Ihr für die Trolle der Dunkelspeere einsetzen, müssten wir so einiges in Kauf nehmen. Danke für Eure redlichen Bemühungen!', 18019),
(7922, 'deDE', 'Die Nachtelfen und ihre Verbündeten müssen schon beim Flüstern Eures Namens erzittern! Für die Horde!', 18019),
(7923, 'deDE', 'Die Nachtelfen und ihre Verbündeten müssen schon beim Flüstern Eures Namens erzittern! Für die Horde!', 18019),
(7924, 'deDE', 'Die Nachtelfen und ihre Verbündeten müssen schon beim Flüstern Eures Namens erzittern! Für die Horde!', 18019),
(7925, 'deDE', 'Die Nachtelfen und ihre Verbündeten müssen schon beim Flüstern Eures Namens erzittern! Für die Horde!', 18019),
(8293, 'deDE', 'Die Nachtelfen und ihre Verbündeten müssen schon beim Flüstern Eures Namens erzittern! Für die Horde!', 18019),
(8368, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8386, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8389, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8426, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8427, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8428, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8429, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8430, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8431, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8432, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8433, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8434, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(8435, 'deDE', 'Ausgezeichnet! Ihr habt Euch als ehrvoll erwiesen, indem Ihr unsere Unternehmungen in der Kriegshymnenschlucht verteidigt habt! Möge sich die Kunde von Eurer Ehrenhaftigkeit weit in unserem Land verbreiten.', 18019),
(9234, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9235, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9236, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9237, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9239, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9240, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9241, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9242, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9243, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9244, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9245, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(9246, 'deDE', 'Hier ist Eure Bestellung, $N. Geliefert wie versprochen!', 18019),
(10357, 'deDE', 'Fantastisch - Ich kann Euch versichern, dass wir sofort Gebrauch davon machen werden. Lasst Euch erneut für Eure Mithilfe gedankt sein! Ohne Euch wären wir mit Sicherheit verloren.$B$BDa ihr schon so viel gespendet habt, wäre ich natürlich bereit, mich auch um jede weitere Spende Runenstoff zu kümmern, die Ihr in Zukunft tätigen wollt. Kommt einfach zu mir, ich werde dann persönlich dafür sorgen, dass Eure guten Taten nicht unbeachtet bleiben!', 18019),
(10358, 'deDE', 'Wir danken Euch für Eure redlichen Bemühungen, $N.', 18019),
(10362, 'deDE', 'Fantastisch - Ich kann Euch versichern, dass wir sofort Gebrauch davon machen werden. Lasst Euch erneut für Eure Mithilfe gedankt sein! Ohne Euch wären wir mit Sicherheit verloren.$B$BDa ihr schon so viel gespendet habt, wäre ich natürlich bereit, mich auch um jede weitere Spende Runenstoff zu kümmern, die Ihr in Zukunft tätigen wollt. Kommt einfach zu mir, ich werde dann persönlich dafür sorgen, dass Eure guten Taten nicht unbeachtet bleiben!', 18019),
(10363, 'deDE', 'Sieh mal einer an. Noch mehr Runenstoff.', 18019),
(24823, 'deDE', 'Ihr stellt Euren Wert wieder unter Beweis, $N. Nehmt dies, nicht als Geschenk, sondern als Werkzeug im Kampf gegen die Geißel.', 18019),
(24828, 'deDE', 'Ihr stellt Euren Wert wieder unter Beweis, $N. Nehmt dies, nicht als Geschenk, sondern als Werkzeug im Kampf gegen die Geißel.', 18019);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
