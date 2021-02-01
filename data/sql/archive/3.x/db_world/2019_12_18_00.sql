-- DB update 2019_12_16_00 -> 2019_12_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_12_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_12_16_00 2019_12_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1575205045256960000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1575205045256960000');

/*Delete duplicate auctioneer titles in the name for deDE, esES, esMX, frFR locale*/
UPDATE `creature_template_locale` SET `Name` = 'Ithillan' WHERE `entry` = 16627 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');
UPDATE `creature_template_locale` SET `Name` = 'Tandron' WHERE `entry` = 16629 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');
UPDATE `creature_template_locale` SET `Name` = 'Jenath' WHERE `entry` = 17627 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');
UPDATE `creature_template_locale` SET `Name` = 'Vynna' WHERE `entry` = 17628 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');
UPDATE `creature_template_locale` SET `Name` = 'Eoch' WHERE `entry` = 16707 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');
UPDATE `creature_template_locale` SET `Name` = 'Fanin' WHERE `entry` = 18348 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');
UPDATE `creature_template_locale` SET `Name` = 'Feynna' WHERE `entry` = 17629 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');
UPDATE `creature_template_locale` SET `Name` = 'Darise' WHERE `entry` = 18761 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');
UPDATE `creature_template_locale` SET `Name` = 'Caidori' WHERE `entry` = 16628 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');
UPDATE `creature_template_locale` SET `Name` = 'Iressa' WHERE `entry` = 18349 AND `locale` IN ('deDE', 'esES', 'esMX', 'frFR');

/*deDE creature_template_locale*/
UPDATE `creature_template_locale` SET `Title` = 'Waffenmeister' WHERE `locale` = 'deDE' AND `entry` IN (17005,  2704, 11869, 16773, 11870, 11868, 11867, 11865);
UPDATE `creature_template_locale` SET `Title` = 'Waffenmeisterin' WHERE `locale` = 'deDE' AND `entry` IN (13084,  11866, 16621);
UPDATE `creature_template_locale` SET `Title` = 'Auktionator' WHERE `locale` = 'deDE' AND `entry` IN (16627, 16629, 17627, 17628, 16707, 18348);
UPDATE `creature_template_locale` SET `Title` = 'Auktionatorin' WHERE `locale` = 'deDE' AND `entry` IN (17629, 18761, 16628, 18349);
UPDATE `creature_template_locale` SET `Name` = 'Balai Lok''Wein', `Title` = 'Tränke, Schriftrollen & Reagenzien' WHERE `entry` = 13476 AND `locale` = 'deDE';

/*deDE creature_item_locale*/
UPDATE `item_template_locale` SET `Description` = 'Zählt als Luft-, Erd-, Feuer- und Wassertotem.' WHERE `ID` = 23199 AND `locale` = 'deDE';
UPDATE `item_template_locale` SET `Description` = 'Die Inschrift des Totems zeichnet den Träger als Verbündeten des Wasserelementars Naias aus.' WHERE `ID` = 23680 AND `locale` = 'deDE';

/*esES creature_template_locale*/
UPDATE `creature_template_locale` SET `Title` = 'Maestro de armas' WHERE `locale` = 'esES' AND `entry` IN (17005, 2704, 11869, 16773, 11870, 11868, 11867, 11865);
UPDATE `creature_template_locale` SET `Title` = 'Maestra de Armas' WHERE `locale` = 'esES' AND `entry` IN (13084, 11866, 16621);
UPDATE `creature_template_locale` SET `Title` = 'Subastador' WHERE `locale` = 'esES' AND `entry` IN (16627, 16629, 17627, 17628, 16707, 18348);
UPDATE `creature_template_locale` SET `Title` = 'Subastadora' WHERE `locale` = 'esES' AND `entry` IN (17629, 18761, 16628, 18349);
UPDATE `creature_template_locale` SET `Name` = 'Balai Lok''Wein', `Title` = 'Pociones, pergaminos y componentes' WHERE `entry` = 13476 AND `locale` = 'esES';

/*esES item_template_locale*/
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de aire, tierra, fuego y agua.' WHERE `ID` = 23199 AND `locale` = 'esES';
UPDATE `item_template_locale` SET `Description` = 'La inscripción del tótem distingue al portador como un aliado del agua elemental Naias.' WHERE `ID` = 23680 AND `locale` = 'esES';

/*esMX creature_template_locale*/
UPDATE `creature_template_locale` SET `Title` = 'Maestro de armas' WHERE `locale` = 'esMX' AND `entry` IN (17005, 2704, 11869, 16773, 11870, 11868, 11867, 11865);
UPDATE `creature_template_locale` SET `Title` = 'Maestra de Armas' WHERE `locale` = 'esMX' AND `entry` IN (13084, 11866, 16621);
UPDATE `creature_template_locale` SET `Title` = 'Subastador' WHERE `locale` = 'esMX' AND `entry` IN (16627, 16629, 17627, 17628, 16707, 18348);
UPDATE `creature_template_locale` SET `Title` = 'Subastadora' WHERE `locale` = 'esMX' AND `entry` IN (17629, 18761, 16628, 18349);
UPDATE `creature_template_locale` SET `Name` = 'Balai Lok''Wein', `Title` = 'Pociones, pergaminos y componentes' WHERE `entry` = 13476 AND `locale` = 'esMX';

/*esMX item_template_locale*/
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de aire, tierra, fuego y agua.' WHERE `ID` = 23199 AND `locale` = 'esMX';
UPDATE `item_template_locale` SET `Description` = 'La inscripción del tótem distingue alportador como un aliado del agua elemental Naias.' WHERE `ID` = 23680 AND `locale` = 'esMX';

/*frFR creature_template_locale*/
UPDATE `creature_template_locale` SET `Title` = 'Maître d''armes' WHERE `locale` = 'frFR' AND `entry` IN (17005, 2704, 11869, 16773, 11870, 11868, 11867, 11865);
UPDATE `creature_template_locale` SET `Title` = 'Champion d''armes' WHERE `locale` = 'frFR' AND `entry` IN (13084, 11866, 16621);
UPDATE `creature_template_locale` SET `Title` = 'Commissaire-priseur' WHERE `locale` = 'frFR' AND `entry` IN (16627, 16629, 17627, 17628, 16707, 18348);
UPDATE `creature_template_locale` SET `Title` = 'Commissaire-priseur' WHERE `locale` = 'frFR' AND `entry` IN (17629, 18761, 16628, 18349);
UPDATE `creature_template_locale` SET `Name` = 'Balai Lok''Wein', `Title` = 'Potions, parchemins et réactifs' WHERE `entry` = 13476 AND `locale` = 'frFR';

/*frFR item_template_locale*/
UPDATE `item_template_locale` SET `Description` = 'Il compte comme un totem d''air, de terre, de feu et d''eau.' WHERE `ID` = 23199 AND `locale` = 'frFR';
UPDATE `item_template_locale` SET `Description` = 'L''inscription du totem distingue le porteur comme un allié des élémentaires d''eau Naias.' WHERE `ID` = 23680 AND `locale` = 'frFR';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
