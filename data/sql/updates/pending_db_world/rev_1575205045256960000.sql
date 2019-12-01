INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1575205045256960000');

/*deDE creature_template_locales*/
UPDATE `creature_template_locale` SET `Title` = 'Waffenmeister' WHERE `locale` = 'deDE' AND `entry` IN (17005,  2704, 11869, 16773, 11870, 11868, 11867, 11865);
UPDATE `creature_template_locale` SET `Title` = 'Waffenmeisterin' WHERE `locale` = 'deDE' AND `entry` IN (13084,  11866, 16621);
UPDATE `creature_template_locale` SET `Title` = 'Auktionator' WHERE `locale` = 'deDE' AND `entry` IN (16627, 16629, 17627, 17628, 16707, 18348);
UPDATE `creature_template_locale` SET `Title` = 'Auktionatorin' WHERE `locale` = 'deDE' AND `entry` IN (17629, 18761, 16628, 18349);

DELETE FROM `creature_template_locale` WHERE `entry`=13476 AND `locale`='deDE';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (13476, 'deDE', 'Balai Lok\'Wein', 'Tränke, Schriftrollen & Reagenzien', 18019);

/*deDE creature_template_locales*/
UPDATE `item_template_locale` SET Description = 'Zählt als Luft-, Erd-, Feuer- und Wassertotem.' WHERE ID = 23199 AND locale = 'deDE';
UPDATE `item_template_locale` SET Description = 'Die Inschrift des Totems zeichnet den Träger als Verbündeten des Wasserelementars Naias aus.' WHERE ID = 23680 AND locale = 'deDE';