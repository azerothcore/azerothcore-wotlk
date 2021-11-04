-- DB update 2021_07_02_04 -> 2021_07_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_02_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_02_04 2021_07_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624668958042794600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624668958042794600');

DELETE FROM `gossip_menu_option_locale` WHERE `MenuID` = 10189 AND OptionID = 0 AND `Locale` IN ('esES','esMX');
INSERT INTO `gossip_menu_option_locale` (`MenuID`, `OptionID`, `Locale`, `OptionText`, `BoxText`) VALUES
(10189,0,'esES','Lady Valiente, estoy listo para ir a Orgrimmar. Abre el portal.',''),
(10189,0,'esMX','Lady Valiente, estoy listo para ir a Orgrimmar. Abre el portal.','');

DELETE FROM `creature_text_locale` WHERE `CreatureID` = 32364 AND `GroupID` IN (0, 1, 2, 3 ,4) AND `Locale` IN ('esES','esMX');
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(32364,0,0,'esES','Thrall, ¿qué ha ocurrido? El Rey se prepara para la guerra...'),
(32364,1,0,'esES','Haré llegar esta información al Rey Wrynn, Thrall, pero...'),
(32364,2,0,'esES','Bolvar era como un hermano para él. En ausencia del Rey, Bolvar mantenía unida a la Alianza. Proporcionó fuerza a nuestro pueblo en los momentos más oscuros. Cuidó de Anduin, como si fuera su propio hijo.'),
(32364,3,0,'esES','Temo que la ira lo consuma, Thrall. Espero que la razón prevalezca, pero debemos prepararnos para lo peor... para la guerra.'),
(32364,4,0,'esES','Adiós, Jefe de Guerra. Rezo para que la próxima vez que nos encontremos sea como aliados.'),
(32364,0,0,'esMX','Thrall, ¿qué ha ocurrido? El Rey se prepara para la guerra...'),
(32364,1,0,'esMX','Haré llegar esta información al Rey Wrynn, Thrall, pero...'),
(32364,2,0,'esMX','Bolvar era como un hermano para él. En ausencia del Rey, Bolvar mantenía unida a la Alianza. Proporcionó fuerza a nuestro pueblo en los momentos más oscuros. Cuidó de Anduin, como si fuera su propio hijo.'),
(32364,3,0,'esMX','Temo que la ira lo consuma, Thrall. Espero que la razón prevalezca, pero debemos prepararnos para lo peor... para la guerra.'),
(32364,4,0,'esMX','Adiós, Jefe de Guerra. Rezo para que la próxima vez que nos encontremos sea como aliados.');

DELETE FROM `creature_text_locale` WHERE `CreatureID` = 32346 AND GroupID IN (0, 1) AND `Locale` IN ('esES','esMX');
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(32346,0,0,'esES','No hagas nada que pueda provocar a la horda. $N. El Jefe de Guerra confía en nuestra buena fe.'),
(32346,1,0,'esES','Vamos.'),
(32346,0,0,'esMX','No hagas nada que pueda provocar a la horda. $N. El Jefe de Guerra confía en nuestra buena fe.'),
(32346,1,0,'esMX','Vamos.');

DELETE FROM `quest_request_items_locale` WHERE `ID` IN (13347, 13242) AND `locale` IN ('esES','esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(13242,'esES','<La cara de Colmillosaurio se desfigura.>$B$BMi corazón... mi fuerza...',18019),
(13242,'esMX','<La cara de Colmillosaurio se desfigura.>$B$BMi corazón... mi fuerza...',18019),
(13347,'esES','<El rey Wrynn se seca una lágrima>.$B$B<El Rey asiente.>$B$BEsto es culpa mía.',18019),
(13347,'esMX','<El rey Wrynn se seca una lágrima>.$B$B<El Rey asiente.>$B$BEsto es culpa mía.',18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (13347, 13369, 13370, 13371, 13377, 13242, 13257, 13266, 13267) AND `locale` IN ('esES','esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(13347,'esES','La Reina de Dragones tiene razón $N. No todo está perdido. Habrá una fuerza que renazca de las cenizas y yo purgaré el mal de la Horda de este mundo. Las muertes de nuestros hermanos y hermanas no habrán sido en vano.',18019),
(13369,'esES','La Horda no quiere guerra $R. Escúchame bien...',18019),
(13370,'esES','¿Han perdido Entrañas? Entonces el momento de golpearles es ahora. Nos encargaremos de Putress nosotros mismos y retomaremos las Ruinas de Lordaeron para la Alianza!',18019),
(13371,'esES','¿Y tú quién se supone que eres? Varian dijo que mandaría héroes.',18019),
(13377,'esES','Durante mucho tiempo la horda ha sido libre. Hemos permitido que sus territorios prosperaran y, en pago por nuestra generosidad, han planeado y tramado nuestra caída.$B$B¿Paz? No tiene sentido... No nos ha llevado a ninguna parte. Hemos perdido a algunos de nuestros mejores héroes por la "paz". Veamos qué nos trae la batalla...$B$BVuelve a Rasganorte, $N. Conquístalo para tu rey: ¡POR LA ALIANZA!',18019),
(13242,'esES','<Colmillosaurio mira al cielo>.$B$BAl igual que Brox, mi hijo murió siendo un héroe. No guardes luto por él $N. ¡No existe mejor final para un orco! ¡No existe mayor honor! Ahora mismo, mi corazón está henchido de orgullo.$B$BGracias por devolvernos la armadura de batalla. La pondremos sobre su pira en las Tierras Ancestrales de Nagrand.$B$BTenemos que concentrarnos en los temas más urgentes.',18019),
(13257,'esES','El señor demoníaco, Varimathras, y el boticario jefe renegado, Putress, son los responsables de esta traición.$B$B<Thrall asiente.>$B$BSí, el mismo Putress que ha descubierto la cura para el reciente brote de Plaga.$B$BAquellos que no se aliaron con su régimen han sido ejecutados o desterrados. Sylvanas casi murió en el golpe.$B$BLa horda ha perdido entrañas. Orgrimmar acogerá a los refugiados Renegados hasta que se resuelva la crisis. Por ahora, estamos bajo ley marcial.',18019),
(13266,'esES','Te pondré al día rápidamente, $N.$B$BEntrañas está en guerra. Los boticarios de Putress y los demonios de Varimathras han asediado la ciudad. Han tomado una posición defensiva en el interior y usan el maldito añublo contra nuestras tropas.',18019),
(13267,'esES','El mañana está lleno de incertidumbre. Los días en los que la Alianza y Horda luchaban juntos contra un enemigo común se han ido. Una nueva batalla amanece, $N, una batalla en la que no habrá ganador.$B$BPero debemos seguir avanzando hacia Corona de Hielo. No tenemos elección. Nuestra salvación está en manos de héroes como tú, $N. El futuro de la Horda, y del mundo, depende de tí.$B$BVolvamos a Orgrimmar, Debes volver a Rasganorte de inmediato.',18019),
(13347,'esMX','La Reina de Dragones tiene razón $N. No todo está perdido. Habrá una fuerza que renazca de las cenizas y yo purgaré el mal de la Horda de este mundo. Las muertes de nuestros hermanos y hermanas no habrán sido en vano.',18019),
(13369,'esMX','La Horda no quiere guerra $R. Escúchame bien...',18019),
(13370,'esMX','¿Han perdido Entrañas? Entonces el momento de golpearles es ahora. Nos encargaremos de Putress nosotros mismos y retomaremos las Ruinas de Lordaeron para la Alianza!',18019),
(13371,'esMX','¿Y tú quién se supone que eres? Varian dijo que mandaría héroes.',18019),
(13377,'esMX','Durante mucho tiempo la horda ha sido libre. Hemos permitido que sus territorios prosperaran y, en pago por nuestra generosidad, han planeado y tramado nuestra caída.$B$B¿Paz? No tiene sentido... No nos ha llevado a ninguna parte. Hemos perdido a algunos de nuestros mejores héroes por la "paz". Veamos qué nos trae la batalla...$B$BVuelve a Rasganorte, $N. Conquístalo para tu rey: ¡POR LA ALIANZA!',18019),
(13242,'esMX','<Colmillosaurio mira al cielo>.$B$BAl igual que Brox, mi hijo murió siendo un héroe. No guardes luto por él $N. ¡No existe mejor final para un orco! ¡No existe mayor honor! Ahora mismo, mi corazón está henchido de orgullo.$B$BGracias por devolvernos la armadura de batalla. La pondremos sobre su pira en las Tierras Ancestrales de Nagrand.$B$BTenemos que concentrarnos en los temas más urgentes.',18019),
(13257,'esMX','El señor demoníaco, Varimathras, y el boticario jefe renegado, Putress, son los responsables de esta traición.$B$B<Thrall asiente.>$B$BSí, el mismo Putress que ha descubierto la cura para el reciente brote de Plaga.$B$BAquellos que no se aliaron con su régimen han sido ejecutados o desterrados. Sylvanas casi murió en el golpe.$B$BLa horda ha perdido entrañas. Orgrimmar acogerá a los refugiados Renegados hasta que se resuelva la crisis. Por ahora, estamos bajo ley marcial.',18019),
(13266,'esMX','Te pondré al día rápidamente, $N.$B$BEntrañas está en guerra. Los boticarios de Putress y los demonios de Varimathras han asediado la ciudad. Han tomado una posición defensiva en el interior y usan el maldito añublo contra nuestras tropas.',18019),
(13267,'esMX','El mañana está lleno de incertidumbre. Los días en los que la Alianza y Horda luchaban juntos contra un enemigo común se han ido. Una nueva batalla amanece, $N, una batalla en la que no habrá ganador.$B$BPero debemos seguir avanzando hacia Corona de Hielo. No tenemos elección. Nuestra salvación está en manos de héroes como tú, $N. El futuro de la Horda, y del mundo, depende de tí.$B$BVolvamos a Orgrimmar, Debes volver a Rasganorte de inmediato.',18019);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_03_00' WHERE sql_rev = '1624668958042794600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
