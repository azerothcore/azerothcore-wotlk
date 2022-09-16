-- DB update 2020_11_29_00 -> 2020_11_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_29_00 2020_11_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1605959888351409700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605959888351409700');

-- item_set_names_locale
DELETE FROM `item_set_names_locale` WHERE `ID` IN (15054, 22095, 22096, 22097, 22098, 22099, 22100, 22101, 22102) AND `locale` = 'deDE';
INSERT INTO `item_set_names_locale` (`ID`, `locale`, `Name`, `VerifiedBuild`) VALUES 
(15054, 'deDE', 'Vulkanische Gamaschen', 15050),
(22095, 'deDE', 'Bindungen der fünf Donner', 15050),
(22096, 'deDE', 'Stiefel der fünf Donner', 15050),
(22097, 'deDE', 'Helmkappe der fünf Donner', 15050),
(22098, 'deDE', 'Kordel der fünf Donner', 15050),
(22099, 'deDE', 'Stulpen der fünf Donner', 15050),
(22100, 'deDE', 'Kilt der fünf Donner', 15050),
(22101, 'deDE', 'Schulterstücke der fünf Donner', 15050),
(22102, 'deDE', 'Weste der fünf Donner', 15050);

-- quest_offer_reward_locale
DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (161, 217, 257, 258, 271, 526, 7791, 7814, 7817, 7822, 7826, 7827, 7831, 7834, 7835, 8697, 8698, 8699, 8700, 8701, 8704, 8748, 8749, 8750, 8753, 8754, 8755, 8758, 8759, 8760, 8811, 8812, 8813, 8814, 8815, 8816, 8817, 8818, 8905, 8906, 8907, 8908, 8909, 8910, 8911, 8912, 8931, 8932, 8933, 8934, 8935, 8936, 8937, 10359, 10360, 10361, 11103, 11104, 11105, 11106) AND `locale` = 'deDE';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(161, 'deDE', 'Ah ja, also da hat der Olle Hinderweir verdammt Recht, dass er sich Sorgen macht.', 18019),
(217, 'deDE', 'Ganz ausgezeichnet, $N! Ihr habt wieder Hoffnung an den Loch Modan gebracht. Jetzt, wo Grawmug tot ist, besteht eine größere Chance, dass die Troggs aus unserem Land vertrieben werden.', 18019),
(257, 'deDE', 'Wie jetzt, Ihr hattet Erfolg?$B$BGlaubt mir, Eisenberndama, das sollte Euch nicht zu Kopf steigen. Denn jeder milchgesichtige Junge mit einem Bogen hätte so... kleine Exemplare töten können. Und ich hoffe, es hat Euch nicht zu viel Spaß gemacht, die Bussarde zu erschießen. Wir wollen doch nicht, dass sie aussterben!$B$BAch so, ähhhm... Es soll keiner sagen, dass Daryl der Kühne sein Wort nicht hält.', 18019),
(258, 'deDE', 'Ihr seht etwas mitgenommen aus. Die Eber haben Euch wohl ein paar Schwierigkeiten gemacht, wie? Keine Sorge, ich verrate es auch keinem, dass Ihr versagt habt; ich kann mir vorstellen, wie schwer es für Euch sein muss, auch ohne dass sich die Leute über Euch das Maul zerreißen.$B$BOh! Ihr habt es geschafft? Ihr habt die Eber getötet? Ich... also... na ja, das überrascht mich nicht! Jedes Kind hätte das - Wette?$B$BWas für eine Wette?', 18019),
(271, 'deDE', 'Äh... was ist das da? Ein Bärenschädel, wie es aussieht.$B$B<Er fährt unbewusst mit einem Finger an seiner Narbe entlang>$B$BNun, das ist eine ziemlich interessante Beute, die Ihr da habt. Kann eigentlich nicht der Bär von damals sein...$B$B<Seine Stimme verliert sich, und er fängt sichtbar an zu zittern.>$B$BOh, nehmt das weg, nehmt es weg! Schafft dieses grausige Ding hier raus!', 18019),
(526, 'deDE', 'Ah, Ihr habt sie gefunden! Jetzt lasst uns dieses Lichtschmiedeeisen zu etwas Nützlichem hämmern, ja?', 18019),
(7791, 'deDE', 'Fabelhaft! Wir danken Euch für Eure großzügige Spende, $N!', 18019),
(7814, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(7817, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(7822, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(7826, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(7827, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(7831, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(7834, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(7835, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(8697, 'deDE', 'Ich werde den Edelstein auf dem Ring für Euch austauschen. Ihr werdet sehen, dass der Effekt viel... angenehmer ist.', 18019),
(8698, 'deDE', 'Ich werde den Edelstein auf dem Ring für Euch austauschen. Ihr werdet sehen, dass der Effekt viel... angenehmer ist.', 18019),
(8699, 'deDE', 'Ich werde den Edelstein auf dem Ring für Euch austauschen. Ihr werdet sehen, dass der Effekt viel... angenehmer ist.', 18019),
(8700, 'deDE', 'Ich werde den Edelstein auf dem Ring für Euch austauschen. Ihr werdet sehen, dass das fertige Stück viel... angenehmer ist.', 18019),
(8701, 'deDE', 'Ich werde den Edelstein auf dem Ring für Euch austauschen. Ihr werdet sehen, dass der Effekt viel... angenehmer ist.', 18019),
(8704, 'deDE', 'Ich werde den Edelstein auf dem Ring für Euch austauschen. Ihr werdet sehen, dass der Effekt viel... angenehmer ist.', 18019),
(8748, 'deDE', 'Euer Aufstieg innerhalb der Brut ist mehr als beachtlich, $N. Möget Ihr niemals vom Pfad des Beschützers abkommen!', 18019),
(8749, 'deDE', 'Euer Aufstieg innerhalb der Brut ist mehr als beachtlich, $N. Möget Ihr niemals vom Pfad des Beschützers abkommen!', 18019),
(8750, 'deDE', 'Euer Aufstieg innerhalb der Brut ist mehr als beachtlich, $N. Möget Ihr niemals vom Pfad des Beschützers abkommen!', 18019),
(8753, 'deDE', 'Euer Aufstieg innerhalb der Brut ist mehr als beachtlich, $N. Möget Ihr niemals vom Pfad des Eroberers abkommen!', 18019),
(8754, 'deDE', 'Euer Aufstieg innerhalb der Brut ist mehr als beachtlich, $N. Möget Ihr niemals vom Pfad des Eroberers abkommen!', 18019),
(8755, 'deDE', 'Euer Aufstieg innerhalb der Brut ist mehr als beachtlich, $N. Möget Ihr niemals vom Pfad des Eroberers abkommen!', 18019),
(8758, 'deDE', 'Euer Aufstieg innerhalb der Brut ist mehr als beachtlich, $N. Möget Ihr niemals vom Pfad des Herbeirufers abkommen!', 18019),
(8759, 'deDE', 'Euer Aufstieg innerhalb der Brut ist mehr als beachtlich, $N. Möget Ihr niemals vom Pfad des Herbeirufers abkommen!', 18019),
(8760, 'deDE', 'Euer Aufstieg innerhalb der Brut ist mehr als beachtlich, $N. Möget Ihr niemals vom Pfad des Herbeirufers abkommen!', 18019),
(8811, 'deDE', 'Sehr gut! Eure glorreichen Taten wurden verzeichnet und Ihr habt Eure verdiente Anerkennung erhalten. Macht so weiter, $C!$B$BIch stehe Euch auch in Zukunft zur Verfügung, falls Ihr weitere Abzeichen abgeben möchtet.', 18019),
(8812, 'deDE', 'Sehr gut! Eure glorreichen Taten wurden verzeichnet und Ihr habt Eure verdiente Anerkennung erhalten. Macht so weiter, $C!$B$BIch stehe Euch auch in Zukunft zur Verfügung, falls Ihr weitere Abzeichen abgeben möchtet.', 18019),
(8813, 'deDE', 'Sehr gut! Eure glorreichen Taten wurden verzeichnet und Ihr habt Eure verdiente Anerkennung erhalten. Macht so weiter, $C!$B$BIch stehe Euch auch in Zukunft zur Verfügung, falls Ihr weitere Abzeichen abgeben möchtet.', 18019),
(8814, 'deDE', 'Sehr gut! Eure glorreichen Taten wurden verzeichnet und Ihr habt Eure verdiente Anerkennung erhalten. Macht so weiter, $C!$B$BIch stehe Euch auch in Zukunft zur Verfügung, falls Ihr weitere Abzeichen abgeben möchtet.', 18019),
(8815, 'deDE', 'Sehr gut! Eure glorreichen Taten wurden verzeichnet und Ihr habt Eure verdiente Anerkennung erhalten. Macht so weiter, $C!$B$BIch stehe Euch auch in Zukunft zur Verfügung, falls Ihr weitere Abzeichen abgeben möchtet.', 18019),
(8816, 'deDE', 'Sehr gut! Eure glorreichen Taten wurden verzeichnet und Ihr habt Eure verdiente Anerkennung erhalten. Macht so weiter, $C!$B$BIch stehe Euch auch in Zukunft zur Verfügung, falls Ihr weitere Abzeichen abgeben möchtet.', 18019),
(8817, 'deDE', 'Sehr gut! Eure glorreichen Taten wurden verzeichnet und Ihr habt Eure verdiente Anerkennung erhalten. Macht so weiter, $C!$B$BIch stehe Euch auch in Zukunft zur Verfügung, falls Ihr weitere Abzeichen abgeben möchtet.', 18019),
(8818, 'deDE', 'Sehr gut! Eure glorreichen Taten wurden verzeichnet und Ihr habt Eure verdiente Anerkennung erhalten. Macht so weiter, $C!$B$BIch stehe Euch auch in Zukunft zur Verfügung, falls Ihr weitere Abzeichen abgeben möchtet.', 18019),
(8905, 'deDE', 'Exzellent! Dann lasst uns den Austausch vornehmen. Es fällt mir nicht leicht, mich von dieser ausgezeichneten Rüstung zu trennen, aber ich fürchte, ich werde sie in nächster Zeit nicht brauchen.$B$BWenn Ihr daran interessiert sein solltet, mehr Arbeit für mich zu erledigen, wäre ich gewillt auch die anderen Teile aufzugeben.', 18019),
(8906, 'deDE', 'Exzellent! Dann lasst uns den Austausch vornehmen. Es fällt mir nicht leicht, mich von dieser ausgezeichneten Rüstung zu trennen, aber ich fürchte, ich werde sie in nächster Zeit nicht brauchen.$B$BWenn Ihr daran interessiert sein solltet, mehr Arbeit für mich zu erledigen, wäre ich gewillt auch die anderen Teile aufzugeben.', 18019),
(8907, 'deDE', 'Exzellent! Dann lasst uns den Austausch vornehmen. Es fällt mir nicht leicht, mich von dieser ausgezeichneten Rüstung zu trennen, aber ich fürchte, ich werde sie in nächster Zeit nicht brauchen.$B$BWenn Ihr daran interessiert sein solltet, mehr Arbeit für mich zu erledigen, wäre ich gewillt auch die anderen Teile aufzugeben.', 18019),
(8908, 'deDE', 'Exzellent! Dann lasst uns den Austausch vornehmen. Es fällt mir nicht leicht, mich von dieser ausgezeichneten Rüstung zu trennen, aber ich fürchte, ich werde sie in nächster Zeit nicht brauchen.$B$BWenn Ihr daran interessiert sein solltet, mehr Arbeit für mich zu erledigen, wäre ich gewillt auch die anderen Teile aufzugeben.', 18019),
(8909, 'deDE', 'Exzellent! Dann lasst uns den Austausch vornehmen. Es fällt mir nicht leicht, mich von dieser ausgezeichneten Rüstung zu trennen, aber ich fürchte, ich werde sie in nächster Zeit nicht brauchen.$B$BWenn Ihr daran interessiert sein solltet, mehr Arbeit für mich zu erledigen, wäre ich gewillt auch die anderen Teile aufzugeben.', 18019),
(8910, 'deDE', 'Exzellent! Dann lasst uns den Austausch vornehmen. Es fällt mir nicht leicht, mich von dieser ausgezeichneten Rüstung zu trennen, aber ich fürchte, ich werde sie in nächster Zeit nicht brauchen.$B$BWenn Ihr daran interessiert sein solltet, mehr Arbeit für mich zu erledigen, wäre ich gewillt auch die anderen Teile aufzugeben.', 18019),
(8911, 'deDE', 'Exzellent! Dann lasst uns den Austausch vornehmen. Es fällt mir nicht leicht, mich von dieser ausgezeichneten Rüstung zu trennen, aber ich fürchte, ich werde sie in nächster Zeit nicht brauchen.$B$BWenn Ihr daran interessiert sein solltet, mehr Arbeit für mich zu erledigen, wäre ich gewillt auch die anderen Teile aufzugeben.', 18019),
(8912, 'deDE', 'Exzellent! Dann lasst uns den Austausch vornehmen. Es fällt mir nicht leicht, mich von dieser ausgezeichneten Rüstung zu trennen, aber ich fürchte, ich werde sie in nächster Zeit nicht brauchen.$B$BWenn Ihr daran interessiert sein solltet, mehr Arbeit für mich zu erledigen, wäre ich gewillt auch die anderen Teile aufzugeben.', 18019),
(8931, 'deDE', 'Ihr habt Euren Teil der Abmachung eingehalten, also werde ich auch meinen einhalten.$B$BDenkt nur daran, dass ich Euch die besten Teile erst dann gebe, wenn Eure Arbeit vollbracht ist.', 18019),
(8932, 'deDE', 'Ihr habt Euren Teil der Abmachung eingehalten, also werde ich auch meinen einhalten.$B$BDenkt nur daran, dass ich Euch die besten Teile erst dann gebe, wenn Eure Arbeit vollbracht ist.', 18019),
(8933, 'deDE', 'Ihr habt Euren Teil der Abmachung eingehalten, also werde ich auch meinen einhalten.$B$BDenkt nur daran, dass ich Euch die besten Teile erst dann gebe, wenn Eure Arbeit vollbracht ist.', 18019),
(8934, 'deDE', 'Ihr habt Euren Teil der Abmachung eingehalten, also werde ich auch meinen einhalten.$B$BDenkt nur daran, dass ich Euch die besten Teile erst dann gebe, wenn Eure Arbeit vollbracht ist.', 18019),
(8935, 'deDE', 'Ihr habt Euren Teil der Abmachung eingehalten, also werde ich auch meinen einhalten.$B$BDenkt nur daran, dass ich Euch die besten Teile erst dann gebe, wenn Eure Arbeit vollbracht ist.', 18019),
(8936, 'deDE', 'Ihr habt Euren Teil der Abmachung eingehalten, also werde ich auch meinen einhalten.$B$BDenkt nur daran, dass ich Euch die besten Teile erst dann gebe, wenn Eure Arbeit vollbracht ist.', 18019),
(8937, 'deDE', 'Ihr habt Euren Teil der Abmachung eingehalten, also werde ich auch meinen einhalten.$B$BDenkt nur daran, dass ich Euch die besten Teile erst dann gebe, wenn Eure Arbeit vollbracht ist.', 18019),
(10359, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(10360, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(10361, 'deDE', 'Wunderbar! Lasst Euch für Eure großzügige Spende gedankt sein, $N!', 18019),
(11103, 'deDE', 'Es ist ein Leichtes, die Sande der Zeit vorwärts fließen zu lassen. Man kann den Fluss auch umkehren, doch ist dies mit großen Mühen verbunden.', 18019),
(11104, 'deDE', 'Es ist ein Leichtes, die Sande der Zeit vorwärts fließen zu lassen. Man kann den Fluss auch umkehren, doch ist dies mit großen Mühen verbunden.', 18019),
(11105, 'deDE', 'Es ist ein Leichtes, die Sande der Zeit vorwärts fließen zu lassen. Man kann den Fluss auch umkehren, doch ist dies mit großen Mühen verbunden.', 18019),
(11106, 'deDE', 'Es ist ein Leichtes, die Sande der Zeit vorwärts fließen zu lassen. Man kann den Fluss auch umkehren, doch ist dies mit großen Mühen verbunden.', 18019);

-- quest_request_items_locale
DELETE FROM `quest_request_items_locale` WHERE `ID` IN (995, 996, 998, 1265, 1373, 1374, 1514, 3644, 3645, 3646, 3647, 4115, 4119, 4221, 4222, 4343, 4403, 4447, 4448, 4462, 4466, 4467, 7930, 7931, 7932, 7933, 7934, 7936, 8184, 8185, 8187, 8188, 8189, 8190, 8191, 8192, 8535, 8536, 8537, 8538, 8559, 8621, 8622, 8623, 8624, 8626, 8631, 8634, 8655, 8658, 8660, 8665, 8689, 8690, 8691, 8692, 8693, 8694, 8695, 8696, 8697, 8698, 8699, 8700, 8701, 8702, 8703, 8704, 8705, 8706, 8707, 8708, 8709, 8710, 8711, 8712, 8770, 8771, 8772, 8774, 8775, 8776, 8777, 8778, 8781, 8786, 8787, 8815, 8905, 8906, 8907, 8908, 8909, 8910, 8911, 8912, 10887, 10957, 10959, 11085, 12327, 12671) AND `locale` = 'deDE';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(995, 'deDE', 'Ja, $N?', 18019),
(996, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(998, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(1265, 'deDE', 'Ja, $N?', 18019),
(1373, 'deDE', 'Zeigt mir, dass Ihr ein Freund der Gelkis seid, $N.', 18019),
(1374, 'deDE', 'Zeigt mir, dass Ihr ein Freund der Gelkis seid, $N.', 18019),
(1514, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(3644, 'deDE', 'Um Eure Mitgliedskarte zu erneuern, müsst Ihr die Erneuerungsgebühr in Höhe von zwei Goldstücken zahlen.', 18019),
(3645, 'deDE', 'Um Eure Mitgliedskarte zu erneuern, müsst Ihr die Erneuerungsgebühr in Höhe von zwei Goldstücken zahlen.', 18019),
(3646, 'deDE', 'Um Eure Mitgliedskarte zu erneuern, müsst Ihr die Erneuerungsgebühr in Höhe von zwei Goldstücken zahlen.', 18019),
(3647, 'deDE', 'Um Eure Mitgliedskarte zu erneuern, müsst Ihr die Erneuerungsgebühr in Höhe von zwei Goldstücken zahlen.', 18019),
(4115, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4119, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Nachtdrachenpflanze aussieht. Die Früchte, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4221, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4222, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4343, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4403, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4447, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Nachtdrachenpflanze aussieht. Die Früchte, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4448, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Nachtdrachenpflanze aussieht. Die Früchte, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4462, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Nachtdrachenpflanze aussieht. Die Früchte, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4466, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(4467, 'deDE', 'Ihr habt eine kränkliche, verderbte Ausgabe von etwas gefunden, das wie eine Windblütenpflanze aussieht. Die Beeren, die von der Pflanze herabhängen, sehen verfault und giftig aus. Es muss sich dringend jemand um die Pflanze kümmern, wenn sie wieder zu ihrem Normalzustand zurückkehren soll.', 18019),
(7930, 'deDE', 'Kommt näher, kommt näher! Wenn ihr Lose vom Dunkelmond-Jahrmarkt habt, die ihr einlösen möchtet, dann sagt nur Bescheid! Ihr könnt Lose gegen zahlreiche, wundersame und fantastische Preise einlösen. Scheut euch nicht, probiert es aus!', 18019),
(7931, 'deDE', 'Kommt näher, kommt näher! Wenn ihr Lose vom Dunkelmond-Jahrmarkt habt, die ihr einlösen möchtet, dann sagt nur Bescheid! Ihr könnt Lose gegen zahlreiche, wundersame und fantastische Preise einlösen. Scheut euch nicht, probiert es aus!', 18019),
(7932, 'deDE', 'Kommt näher, kommt näher! Wenn ihr Lose vom Dunkelmond-Jahrmarkt habt, die ihr einlösen möchtet, dann sagt nur Bescheid! Ihr könnt Lose gegen zahlreiche, wundersame und fantastische Preise einlösen. Scheut euch nicht, probiert es aus!', 18019),
(7933, 'deDE', 'Kommt näher, kommt näher! Wenn ihr Lose vom Dunkelmond-Jahrmarkt habt, die ihr einlösen möchtet, dann sagt nur Bescheid! Ihr könnt Lose gegen zahlreiche, wundersame und fantastische Preise einlösen. Scheut euch nicht, probiert es aus!', 18019),
(7934, 'deDE', 'Kommt näher, kommt näher! Wenn ihr Lose vom Dunkelmond-Jahrmarkt habt, die ihr einlösen möchtet, dann sagt nur Bescheid! Ihr könnt Lose gegen zahlreiche, wundersame und fantastische Preise einlösen. Scheut euch nicht, probiert es aus!', 18019),
(7936, 'deDE', 'Kommt näher, kommt näher! Wenn ihr Lose vom Dunkelmond-Jahrmarkt habt, die ihr einlösen möchtet, dann sagt nur Bescheid! Ihr könnt Lose gegen zahlreiche, wundersame und fantastische Preise einlösen. Scheut euch nicht, probiert es aus!', 18019),
(8184, 'deDE', 'Bringt mir diese Dinge und ich erschaffe eine mächtige Verzauberung für Euch!', 18019),
(8185, 'deDE', 'Bringt mir diese Dinge und ich erschaffe eine mächtige Verzauberung für Euch!', 18019),
(8187, 'deDE', 'Bringt mir diese Dinge und ich erschaffe eine mächtige Verzauberung für Euch!', 18019),
(8188, 'deDE', 'Bringt mir diese Dinge und ich erschaffe eine mächtige Verzauberung für Euch!', 18019),
(8189, 'deDE', 'Bringt mir diese Dinge und ich erschaffe eine mächtige Verzauberung für Euch!', 18019),
(8190, 'deDE', 'Bringt mir diese Dinge und ich erschaffe eine mächtige Verzauberung für Euch!', 18019),
(8191, 'deDE', 'Bringt mir diese Dinge und ich erschaffe eine mächtige Verzauberung für Euch!', 18019),
(8192, 'deDE', 'Bringt mir diese Dinge und ich erschaffe eine mächtige Verzauberung für Euch!', 18019),
(8535, 'deDE', 'Habt Ihr Eure Aufgabe bereits erfüllt, $N?', 18019),
(8536, 'deDE', 'Habt Ihr Eure Aufgabe bereits erfüllt, $N?', 18019),
(8537, 'deDE', 'Habt Ihr Eure Aufgabe bereits erfüllt, $N?', 18019),
(8538, 'deDE', 'Habt Ihr Eure Aufgabe bereits erfüllt, $N?', 18019),
(8559, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8621, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8622, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8623, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8624, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8626, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8631, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8634, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8655, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8658, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8660, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8665, 'deDE', 'Habt Ihr die von mir benötigten Gegenstände erlangt, $N?', 18019),
(8689, 'deDE', 'Habt Ihr mir die Materialien für den Umhang gebracht, $N?', 18019),
(8690, 'deDE', 'Habt Ihr mir die Materialien für den Umhang gebracht, $N?', 18019),
(8691, 'deDE', 'Habt Ihr mir die Materialien für den Umhang gebracht, $N?', 18019),
(8692, 'deDE', 'Habt Ihr mir die Materialien für den Umhang gebracht, $N?', 18019),
(8693, 'deDE', 'Habt Ihr mir die Materialien für den Umhang gebracht, $N?', 18019),
(8694, 'deDE', 'Habt Ihr mir die Materialien für den Umhang gebracht, $N?', 18019),
(8695, 'deDE', 'Habt Ihr mir die Materialien für den Umhang gebracht, $N?', 18019),
(8696, 'deDE', 'Habt Ihr mir die Materialien für den Umhang gebracht, $N?', 18019),
(8697, 'deDE', 'Habt Ihr mir den Ring und die Gegenstände besorgt, $N?', 18019),
(8698, 'deDE', 'Habt Ihr mir den Ring und die Gegenstände besorgt, $N?', 18019),
(8699, 'deDE', 'Habt Ihr mir den Ring und die Gegenstände besorgt, $N?', 18019),
(8700, 'deDE', 'Habt Ihr mir den Ring und die Gegenstände besorgt, $N?', 18019),
(8701, 'deDE', 'Habt Ihr mir den Ring und die Gegenstände besorgt, $N?', 18019),
(8702, 'deDE', 'Habt Ihr mir den Ring und die Gegenstände besorgt, $N?', 18019),
(8703, 'deDE', 'Habt Ihr mir den Ring und die Gegenstände besorgt, $N?', 18019),
(8704, 'deDE', 'Habt Ihr mir den Ring und die Gegenstände besorgt, $N?', 18019),
(8705, 'deDE', 'Habt Ihr mir die benötigten Bestandteile gebracht, $N?', 18019),
(8706, 'deDE', 'Habt Ihr mir die benötigten Bestandteile gebracht, $N?', 18019),
(8707, 'deDE', 'Habt Ihr mir die benötigten Bestandteile gebracht, $N?', 18019),
(8708, 'deDE', 'Habt Ihr mir die benötigten Bestandteile gebracht, $N?', 18019),
(8709, 'deDE', 'Habt Ihr mir die benötigten Bestandteile gebracht, $N?', 18019),
(8710, 'deDE', 'Habt Ihr mir die benötigten Bestandteile gebracht, $N?', 18019),
(8711, 'deDE', 'Habt Ihr mir die benötigten Bestandteile gebracht, $N?', 18019),
(8712, 'deDE', 'Habt Ihr mir die benötigten Bestandteile gebracht, $N?', 18019),
(8770, 'deDE', 'Ihr habt etwas, das Ihr mir erzählen wollt, $C?', 18019),
(8771, 'deDE', 'Ihr habt etwas, das Ihr mir erzählen wollt, $C?', 18019),
(8772, 'deDE', 'Ihr habt etwas, das Ihr mir erzählen wollt, $C?', 18019),
(8774, 'deDE', 'Ihr wollt mir etwas mitteilen, $N?', 18019),
(8775, 'deDE', 'Ihr wollt mir etwas mitteilen, $N?', 18019),
(8776, 'deDE', 'Ihr wollt mir etwas mitteilen, $N?', 18019),
(8777, 'deDE', 'Ihr wollt mir etwas mitteilen, $N?', 18019),
(8778, 'deDE', 'Habt Ihr die Materialien, $N?', 18019),
(8781, 'deDE', 'Habt Ihr die Materialien, $N?', 18019),
(8786, 'deDE', 'Habt Ihr die Materialien, $N?', 18019),
(8787, 'deDE', 'Habt Ihr die Materialien, $N?', 18019),
(8815, 'deDE', 'Alle Abenteurer, die Belobigungsabzeichen besitzen, können diese bei mir abgeben, um Ihren Ruf in Orgrimmar ein wenig zu verbessern.$B$BDoch überlegt es Euch gut! Wenn Ihr mir stattdessen zehn Abzeichen auf einmal übergebt, würdet Ihr dadurch wesentlich mehr Anerkennung erhalten und Euer Ruf in Orgrimmar würde sich stark verbessern.$B$BGenug geredet! Wollt Ihr nun Abzeichen eintauschen oder nicht?', 18019),
(8905, 'deDE', 'Habt Ihr mitgebracht, worum ich Euch gebeten habe, $N?', 18019),
(8906, 'deDE', 'Habt Ihr mitgebracht, worum ich Euch gebeten habe, $N?', 18019),
(8907, 'deDE', 'Habt Ihr mitgebracht, worum ich Euch gebeten habe, $N?', 18019),
(8908, 'deDE', 'Habt Ihr mitgebracht, worum ich Euch gebeten habe, $N?', 18019),
(8909, 'deDE', 'Habt Ihr mitgebracht, worum ich Euch gebeten habe, $N?', 18019),
(8910, 'deDE', 'Habt Ihr mitgebracht, worum ich Euch gebeten habe, $N?', 18019),
(8911, 'deDE', 'Habt Ihr mitgebracht, worum ich Euch gebeten habe, $N?', 18019),
(8912, 'deDE', 'Habt Ihr mitgebracht, worum ich Euch gebeten habe, $N?', 18019),
(10887, 'deDE', 'Ja, $N?', 18019),
(10957, 'deDE', 'Ja, $N?', 18019),
(10959, 'deDE', 'Ja, $N?', 18019),
(11085, 'deDE', 'Ja, $N?', 18019),
(12327, 'deDE', 'Ja, $N?', 18019),
(12671, 'deDE', 'Ja, $N?', 18019);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
