INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1575205045256960000');

/*deDE creature_template_locale*/
UPDATE `creature_template_locale` SET `Title` = 'Waffenmeister' WHERE `locale` = 'deDE' AND `entry` IN (17005,  2704, 11869, 16773, 11870, 11868, 11867, 11865);
UPDATE `creature_template_locale` SET `Title` = 'Waffenmeisterin' WHERE `locale` = 'deDE' AND `entry` IN (13084,  11866, 16621);
UPDATE `creature_template_locale` SET `Title` = 'Auktionator' WHERE `locale` = 'deDE' AND `entry` IN (16627, 16629, 17627, 17628, 16707, 18348);
UPDATE `creature_template_locale` SET `Title` = 'Auktionatorin' WHERE `locale` = 'deDE' AND `entry` IN (17629, 18761, 16628, 18349);
DELETE FROM `creature_template_locale` WHERE `entry`=13476 AND `locale`='deDE';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (13476, 'deDE', 'Balai Lok''Wein', 'Tränke, Schriftrollen & Reagenzien', 18019);

/*deDE creature_item_locale*/
UPDATE `item_template_locale` SET Description = 'Zählt als Luft-, Erd-, Feuer- und Wassertotem.' WHERE ID = 23199 AND locale = 'deDE';
UPDATE `item_template_locale` SET Description = 'Die Inschrift des Totems zeichnet den Träger als Verbündeten des Wasserelementars Naias aus.' WHERE ID = 23680 AND locale = 'deDE';

/*esES creature_template_locales*/
UPDATE `creature_template_locale` SET `Title` = 'Maestro de armas' WHERE `locale` = 'esES' AND `entry` IN (17005, 2704, 11869, 16773, 11870, 11868, 11867, 11865);
UPDATE `creature_template_locale` SET `Title` = 'Maestra de Armas' WHERE `locale` = 'esES' AND `entry` IN (13084, 11866, 16621);
UPDATE `creature_template_locale` SET `Title` = 'Subastador' WHERE `locale` = 'esES' AND `entry` IN (16627, 16629, 17627, 17628, 16707, 18348);
UPDATE `creature_template_locale` SET `Title` = 'Subastadora' WHERE `locale` = 'esES' AND `entry` IN (17629, 18761, 16628, 18349);
DELETE FROM `creature_template_locale` WHERE `entry`=13476 AND `locale`='esES';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (13476, 'esES', 'Balai Lok''Wein', 'Pociones, pergaminos y componentes', 18019);

/*esES item_template_locale*/
UPDATE `item_template_locale` SET Description = 'Cuenta como un tótem de aire, tierra, fuego y agua.' WHERE ID = 23199 AND locale = 'esES';
UPDATE `item_template_locale` SET Description = 'La inscripción del tótem distingue al portador como un aliado del agua elemental Naias.' WHERE ID = 23680 AND locale = 'esES';

/*esMX creature_template_locale*/
UPDATE `creature_template_locale` SET `Title` = 'Maestro de armas' WHERE `locale` = 'esMX' AND `entry` IN (17005, 2704, 11869, 16773, 11870, 11868, 11867, 11865);
UPDATE `creature_template_locale` SET `Title` = 'Maestra de Armas' WHERE `locale` = 'esMX' AND `entry` IN (13084, 11866, 16621);
UPDATE `creature_template_locale` SET `Title` = 'Subastador' WHERE `locale` = 'esMX' AND `entry` IN (16627, 16629, 17627, 17628, 16707, 18348);
UPDATE `creature_template_locale` SET `Title` = 'Subastadora' WHERE `locale` = 'esMX' AND `entry` IN (17629, 18761, 16628, 18349);
DELETE FROM `creature_template_locale` WHERE `entry`=13476 AND `locale`='esMX';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (13476, 'esMX', 'Balai Lok''Wein', 'Pociones, pergaminos y componentes', 18019);

/*esMX item_template_locale*/
UPDATE `item_template_locale` SET Description = 'Cuenta como un tótem de aire, tierra, fuego y agua.' WHERE ID = 23199 AND locale = 'esMX';
UPDATE `item_template_locale` SET Description = 'La inscripción del tótem distingue alportador como un aliado del agua elemental Naias.' WHERE ID = 23680 AND locale = 'esMX';
