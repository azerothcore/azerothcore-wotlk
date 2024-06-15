-- DB update 2020_04_11_00 -> 2020_04_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_04_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_04_11_00 2020_04_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1583347738773107900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1583347738773107900');

-- Quest texts changed to patch stand 3.3.5a from 4.0.3a
-- https://wowwiki.fandom.com/wiki/Ajeck_Rouack
-- https://wow.gamepedia.com/Sir_S._J._Erlgadin
-- https://wowwiki.fandom.com/wiki/Hemet_Nesingwary_Jr.

-- Quest chain 'Tiger Mastery' (185 - 188) Text in quest_template is already correct, cannot proof the correctness of other locales!
UPDATE `quest_template_locale` SET `Title`='Beherrschen der Tigerjagd' WHERE `ID` IN (185, 186, 187, 188) AND `locale`='deDE';
-- Quest 185
-- https://wowwiki.fandom.com/wiki/Quest:Tiger_Mastery_(old)
UPDATE `quest_template_locale` SET `Details`='Als ich noch ein kleines Mädchen war, brachte mein Vater mir die Kunst der Tigerjagd bei.$b$bIhr werdet feststellen, dass die jungen Katzen sich wesentlich leichter aufspüren und töten lassen. Deswegen fangen wir auch klein an. Man findet die jungen Tiger oftmals in der Nähe des Expeditionslagers.$b$bÜbt Euch im Fährtenlesen und seht zu, ob Ihr nicht einige der Wildtiere zur Strecke bringen könnt.' WHERE `ID`=185 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Ajeck Rouack von Nesingwarys Expedition möchte, dass Ihr 10 junge Schlingendorntiger tötet.' WHERE `ID`=185 AND `locale`='deDE';
-- Quest 186
-- https://wowwiki.fandom.com/wiki/Quest:Tiger_Mastery_(2)
UPDATE `quest_template_locale` SET `Details`='Ihr macht Fortschritte, $C. Jetzt lasst uns sehen, wie Ihr Euch gegen die ausgewachsenen Katzen anstellt. Tötet diesmal 10 Schlingendorntiger.' WHERE `ID`=186 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Ajeck Rouack von Nesingwarys Expedition möchte, dass Ihr 10 Schlingendorntiger tötet.' WHERE `ID`=186 AND `locale`='deDE';
-- Quest 187 
-- https://wowwiki.fandom.com/wiki/Quest:Tiger_Mastery_(3)
UPDATE `quest_template_locale` SET `Details`='Jetzt werde ich den Einsatz erhöhen und Eure Fähigkeiten wirklich prüfen. Beweist mir, dass Ihr 10 alte Schlingendorntiger töten könnt. Wenn Ihr das schafft, dann seid Ihr bereit für Eure letzte Herausforderung, ehe ich Euch in Meister Nesingwarys Gegenwart $Gzum Meisterjäger:zur Meisterjägerin; ernenne.$B$BNicht nur sind die alten Schlingendorntiger am schwierigsten zu finden, sie sind auch am schwierigsten zu besiegen.' WHERE `ID`=187 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Ajeck Rouack von Nesingwarys Expedition möchte, dass Ihr 10 alte Schlingendorntiger tötet.' WHERE `ID`=187 AND `locale`='deDE';
-- Quest 188 
-- https://wowwiki.fandom.com/wiki/Quest:Tiger_Mastery_(4)
UPDATE `quest_template_locale` SET `Details`='Hier ist die letzte Aufgabe, die ich Euch auferlegen werde. Wir sind schon seit Wochen einer schwer zu fassenden Tigerin auf der Spur. Wir nennen das Tier Sin''Dall. Vielleicht gelingt Euch ja, was noch $Gkein:keine; $R vor Euch geschafft hat: Spürt Sin''Dall auf und bringt sie zur Strecke. Bringt mir ihre Tatze zum Beweis für Eure Leistung.$B$BAber die Tigerin aufzuspüren, wird nicht leicht sein.' WHERE `ID`=188 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Ajeck Rouack von Nesingwarys Expedition möchte, dass Ihr Sin''Dall tötet und mit ihrer Tatze zurückkehrt.' WHERE `ID`=188 AND `locale`='deDE';

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Quest chain 'Panther Mastery' (190 - 193) Text in quest_template is already correct, cannot proof the correctness of other locales!
UPDATE `quest_template_locale` SET `Title`='Beherrschen der Pantherjagd' WHERE `ID`IN (190, 191, 192, 193) AND `locale`='deDE';
-- Quest 190
-- https://wow.gamepedia.com/Sir_S._J._Erlgadin (Old Quest missing) References taken from: https://db.rising-gods.de/?quest=190 
UPDATE `quest_template_locale` SET `Details`='Wenn Ihr zusammen mit dieser Elitegruppe, die Hemet Jr. zusammengestellt hat, an der Jagd teilnehmen wollt, dann müsst Ihr erst beweisen, dass Ihr $Gein fähiger Pantherjäger:eine fähige Pantherjägerin; seid. Aber wir fangen ganz einfach an, keine Sorge. Schauen wir mal, wie Ihr Euch beim Töten von 10 jungen Panthern anstellt.$B$BDie Tiere aufzuspüren ist nur die halbe Miete.' WHERE `ID`=190 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Sire S. J. Erlgadin von Nesingwarys Expedition möchte, dass Ihr 10 junge Panther tötet.' WHERE `ID`=190 AND `locale`='deDE';
-- Quest 191
-- https://wow.gamepedia.com/Panther_Mastery_(2)
UPDATE `quest_template_locale` SET `Details`='Jetzt seid Ihr bereit, Euch an einen Gegner zu wagen, der eine Nummer schwieriger ist. Wenn Ihr Euch wirklich als würdig erweisen wollt, mit solchen Leuten wie den Großwildjägern zu verkehren, dann müsst Ihr beweisen, dass Ihr 10 Panther töten könnt.$B$BDiese Bestien sind schon etwas zäher. Die lassen sich nicht so leicht erlegen wie die Jungtiere, mit denen Ihr Euch bis jetzt abgegeben habt.' WHERE `ID`=191 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Sire S. J. Erlgadin von Nesingwarys Expedition möchte, dass Ihr 10 Panther tötet.' WHERE `ID`=191 AND `locale`='deDE';
-- Quest 192
-- https://wow.gamepedia.com/Panther_Mastery_(3)
UPDATE `quest_template_locale` SET `Details`='Jetzt kommt der schwierige Teil. Ein echter Pantherjäger beweist seine Fähigkeiten damit, dass er Schattentatzenpanther erlegt, die tödlichsten Vertreter ihrer Art im ganzen Schlingendorntal. Beweist uns, dass Ihr 10 dieser Bestien zur Strecke bringen könnt.$B$BUnd wenn Ihr glaubt, die seien schwer aufzuspüren, dann wartet nur, bis Ihr versucht, eine von ihnen zu erlegen...' WHERE `ID`=192 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Sire S. J. Erlgadin von Nesingwarys Expedition möchte, dass Ihr 10 Schattentatzenpanther tötet.' WHERE `ID`=192 AND `locale`='deDE';
-- Quest 193
-- https://wow.gamepedia.com/Panther_Mastery_(4)
UPDATE `quest_template_locale` SET `Details`='Ihr habt schon fast bewiesen, dass Ihr die Kunst der Pantherjagd meisterlich versteht. Schon seit längerem pirscht ein Panther namens Bhag''thera durch den Dschungel. Bis jetzt ist er unserer Jagdgesellschaft immer ausgewichen. Seht zu, ob es Euch mit Euren Fähigkeiten gelingt, den großen Bhag''thera zu töten.$B$BBringt mir den Fangzahn von Bhag''thera, dann habt Ihr Euch meinen Respekt redlich verdient!' WHERE `ID`=193 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Sire S. J. Erlgadin von Nesingwarys Expedition möchte, dass Ihr ihm den Fangzahn von Bhag''thera bringt.' WHERE `ID`=193 AND `locale`='deDE';

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Quest chain 'Raptor Mastery' (194-197) Text in quest_template is already correct, cannot proof the correctness of other locales!
UPDATE `quest_template_locale` SET `Title`='Beherrschen der Raptorenjagd' WHERE `ID` IN (194, 195, 196, 197) AND `locale`='deDE';
-- Quest 194
-- https://wow.gamepedia.com/Hemet_Nesingwary_Jr. (Old Quest missing) References taken from: https://db.rising-gods.de/?quest=194
UPDATE `quest_template_locale` SET `Details`='Soso, Ihr glaubt also, Eure Jagdfertigkeiten sind erstklassig? Das lässt sich ganz leicht feststellen. Zieht hinaus in den Dschungel und tötet 10 Schlingendornraptoren. Dann werden wir ja sehen, wie gut Ihr als Großwildjäger wirklich seid.$B$BUnd nein, ich werde Euch nicht sagen, wo Ihr sie finden könnt! Die Viecher aufzuspüren ist Teil der Aufgabe.' WHERE `ID`=194 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Hemet Nesingwary Jr. möchte, dass Ihr 10 Schlingendornraptoren tötet.' WHERE `ID`=194 AND `locale`='deDE';
-- Quest 195
-- https://wow.gamepedia.com/Raptor_Mastery_(2)
UPDATE `quest_template_locale` SET `Details`='Jetzt machen wir die Herausforderung ein wenig schwieriger und schauen mal, ob Ihr dem gewachsen seid. Begebt Euch in den Dschungel und erlegt 10 dieser elenden Schmetterschwanzraptoren. Zeigt uns, was Ihr so drauf habt!' WHERE `ID`=195 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Hemet Nesingwary Jr. möchte, dass Ihr 10 Schmetterschwanzraptoren tötet.' WHERE `ID`=195 AND `locale`='deDE';
-- Quest 196
-- https://wow.gamepedia.com/Raptor_Mastery_(3)
UPDATE `quest_template_locale` SET `Details`='Mal sehen, wie Ihr mit der nächsten Herausforderung fertig werdet. Dort draußen treibt sich eine sehr scheue Art von Raptoren herum. Wir nennen sie Dschungelpirscher. Sie sind sehr viel schwieriger aufzuspüren und zu erlegen als die anderen Arten, an denen Ihr Euch bisher versucht habt. Tötet 10 Dschungelpirscher, dann verrate ich Euch, wie Ihr zu einem noch besseren Jagderlebnis kommt.' WHERE `ID`=196 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Hemet Nesingwary Jr. möchte, dass Ihr 10 Dschungelpirscher tötet.' WHERE `ID`=196 AND `locale`='deDE';
-- Quest 197
-- https://wow.gamepedia.com/Raptor_Mastery_(4)
UPDATE `quest_template_locale` SET `Details`='Da Ihr Euch im Dschungel als so tatkräftig erwiesen habt, lasst mich Euch von einem wilden Raptor erzählen, den sogar ich nicht erlegen konnte. Ajeck hier nennt diesen verschlagenen Raptor Tethis.$B$BWenn Ihr Euch als $Gwahrer Meister:wahre Meisterin; erweisen wollt, dann erlegt Tethis und bringt mir seine Kralle. Es wäre eine Leistung, die bisher noch keinem anderen Großwildjäger gelungen ist.' WHERE `ID`=197 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Hemet Nesingwary Jr. möchte, dass Ihr Tethis tötet, einen schwer fassbaren, gefährlichen Raptoren des Schlingendorntals.' WHERE `ID`=197 AND `locale`='deDE';

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Quest 208
-- https://wowwiki.fandom.com/wiki/Quest:Big_Game_Hunter_(old)
UPDATE `quest_template_locale` SET `Objectives`='Hemet Nesingwary möchte, dass Ihr ihm den Kopf von König Bangalash, dem großen weißen Tiger, bringt.' WHERE  `ID`=208 AND `locale`='deDE';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
