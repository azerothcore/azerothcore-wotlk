-- DB update 2020_12_11_01 -> 2020_12_11_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_11_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_11_01 2020_12_11_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606648337329550400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606648337329550400');

DELETE FROM `item_template_locale` WHERE `ID` IN (45759, 45754, 45752, 45751, 45750, 45749, 45748, 45730, 45729, 45728, 45280, 45049, 44945, 44432, 44392, 44391, 36970, 36968, 36967, 36966, 36965, 36964, 36960, 36959, 36955, 36900, 36897, 36896, 35626, 27007, 27002, 26779, 26765, 26569, 26541, 26527, 26513, 26135, 26134, 26133, 26132, 26131, 26130, 26129, 26128, 1255) AND `locale` = 'deDE';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(45759, 'deDE', 'Kavallerie Lanze [PH]', '', 15050),
(45754, 'deDE', 'Darnassische Lanze [PH]', '', 15050),
(45752, 'deDE', 'Lanze der Bergsteiger [PH]', '', 15050),
(45751, 'deDE', 'Federbelastete Mecha-Lanze [PH]', '', 15050),
(45750, 'deDE', 'Elekk Lanze [PH]', '', 15050),
(45749, 'deDE', 'Lanze der Tapferen [PH]', '', 15050),
(45748, 'deDE', 'Lanze der Dunkelspeere [PH]', '', 15050),
(45730, 'deDE', 'Lanze der Verlassenen [PH]', '', 15050),
(45729, 'deDE', 'Lanze des Plünderers [PH]', '', 15050),
(45728, 'deDE', 'Thalassische Lanze [PH]', '', 15050),
(45280, 'deDE', 'Oberhemd', 'Ich habe Ulduar in Hard Mode getestet und alles was ich bekam war dieses blöde T-Shirt!', 15050),
(45049, 'deDE', 'Ritterlanze [PH]', '', 15050),
(44945, 'deDE', 'Formel: Waffe - Titanwache', '', 15050),
(44432, 'deDE', 'Glyphe ''Totenerweckung''', '', 15050),
(44392, 'deDE', 'Halskette der Durchdringung', '', 15050),
(44391, 'deDE', 'Stahlgusshalsreif', '', 15050),
(36970, 'deDE', 'Zauberfoliant des Leidens (Rang 8)', '', 15050),
(36968, 'deDE', 'Zauberfoliant des Leidens (Rang 7)', '', 15050),
(36967, 'deDE', 'Zauberfoliant des Schattenverzehrens (Rang 9)', '', 15050),
(36966, 'deDE', 'Zauberfoliant des Schattenverzehrens (Rang 8)', '', 15050),
(36965, 'deDE', 'Zauberfoliant der Opferung (Rang 9)', '', 15050),
(36964, 'deDE', 'Zauberfoliant der Opferung (Rang 8)', '', 15050),
(36960, 'deDE', 'Zauberfoliant des Feuerschilds (Rang 7)', '', 15050),
(36959, 'deDE', 'Zauberfoliant des Blutpakts (Rang 7)', '', 15050),
(36955, 'deDE', 'Zauberfoliant des Feuerblitzes (Rang 9)', '', 15050),
(36900, 'deDE', 'Außergewöhnliches Zauberöl', '', 15050),
(36897, 'deDE', 'Teuflischer Zauberstein', '', 15050),
(36896, 'deDE', 'Dämonischer Zauberstein', '', 15050),
(35626, 'deDE', 'Ewiges Mana [PH]', '', 15050),
(27007, 'deDE', 'Spojka''s reiches lila Hemd', 'Spojka 4ever', 15050),
(27002, 'deDE', 'Spojka''s schwarzes Hemd', 'Spojka 4ever', 15050),
(26779, 'deDE', '68 TEST Grüner Zauberdolch', '', 15050),
(26765, 'deDE', '68 TEST Grüner Zauberstab', '', 15050),
(26569, 'deDE', '68 TEST Grüne Schildhand', '', 15050),
(26541, 'deDE', '68 TEST Grüne Stoffhalskette', '', 15050),
(26527, 'deDE', '68 TEST Grüner Stoffring', '', 15050),
(26513, 'deDE', '68 TEST Grüner Stoffumhang', '', 15050),
(26135, 'deDE', '68 TEST Grüner Stoff-Handgelenkschutz', '', 15050),
(26134, 'deDE', '68 TEST Grüne Stoffschultern', '', 15050),
(26133, 'deDE', '68 TEST Grüner Stoff-Beinschutz', '', 15050),
(26132, 'deDE', '68 TEST Grüne Stoff-Kopfbedeckung', '', 15050),
(26131, 'deDE', '68 TEST Grüner Stoff-Handschutz', '', 15050),
(26130, 'deDE', '68 TEST Grüne Stoff-Brustrüstung', '', 15050),
(26129, 'deDE', '68 TEST Grüne Stoffstiefel', '', 15050),
(26128, 'deDE', '68 TEST Grüner Stoffgürtel', '', 15050),
(1255, 'deDE', 'Brackwasserarmschienen', '', 15050);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
