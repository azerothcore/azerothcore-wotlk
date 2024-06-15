-- DB update 2022_03_08_02 -> 2022_03_08_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_08_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_08_02 2022_03_08_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646749877159440400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646749877159440400');

UPDATE `quest_template_locale` SET `ObjectiveText1`='Operaciones de los enanos férreos interrumpidas' WHERE `ID`=11982 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Trol de hielo capturado vivo' WHERE `ID`=11984 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Pacto de sangre con Drakuru' WHERE `ID`=11989 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Trols de la Plaga quemados' WHERE `ID`=12029 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Trols de la Plaga quemados' WHERE `ID`=12038 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Gigantes de las Colinas Pardas alentados', `ObjectiveText2`='Vengadores Runaférrea muertos' WHERE `ID`=12070 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Harrison te ha escoltado a lugar seguro.' WHERE `ID`=12082 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Conseguido el poder de la primera piedra antigua', `ObjectiveText2`='Conseguido el poder de la segunda piedra antigua', `ObjectiveText3`='Conseguido el poder de la tercera piedra antigua' WHERE `ID`=12094 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Gigantes con runas liberados' WHERE `ID`=12099 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`="Muerte a manos del señor de la guerra Jin'arrak" WHERE `ID`=12121 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`="Fin del señor de la guerra Jin'arrak" WHERE `ID`=12152 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Varlam', `ObjectiveText2`='Selas', `ObjectiveText3`='Buchegore', `ObjectiveText4`='Sombra de Arugal derrotada' WHERE `ID`=12164 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1`='Huesos momificados quemados' WHERE `ID`=12484 AND `locale` IN ('esES', 'esMX');

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (11981, 11982, 11984, 11985, 11989, 11990, 11991, 12007, 12029, 12038, 12042, 12068, 12070, 12081, 12082, 12093, 12094, 12099, 12113, 12114, 12116, 12120, 12121, 12134, 12137, 12152, 12164, 12190, 12279, 12327, 12328, 12329, 12330, 12411, 12483, 12484, 12802) AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11981, 'esES', '<Le hablas a Kurun del mensaje que te ha dado el terráneo caído.>$B$BLuchan con valentía, pero tiene razón. No superaremos a los enanos férreos de Thor Modan sin ayuda. Mis gigantes y los terráneos han luchado durante mucho tiempo contra el demonio de hierro, pero nuestros ejércitos no son suficientemente numerosos para ganar la batalla para Thor Modan. ¿Nos ayudarás?', 18019),
(11981, 'esMX', '<Le hablas a Kurun del mensaje que te ha dado el terráneo caído.>$B$BLuchan con valentía, pero tiene razón. No superaremos a los enanos férreos de Thor Modan sin ayuda. Mis gigantes y los terráneos han luchado durante mucho tiempo contra el demonio de hierro, pero nuestros ejércitos no son suficientemente numerosos para ganar la batalla para Thor Modan. ¿Nos ayudarás?', 18019),
(11982, 'esES', 'Con la misma rapidez con la que llenamos la trinchera, los enanos férreos la despejan. Con nuestro asalto desde arriba solo no conseguiremos tomar la ciudad. Tienes que ayudar a luchar en la plaza que hay abajo.', 18019),
(11982, 'esMX', 'Con la misma rapidez con la que llenamos la trinchera, los enanos férreos la despejan. Con nuestro asalto desde arriba solo no conseguiremos tomar la ciudad. Tienes que ayudar a luchar en la plaza que hay abajo.', 18019),
(11984, 'esES', 'Buen trabajo, $c. Parece que Budd seguirá con nosotros un poco más.$B$BRecogeremos tu jaula ahora mismo. Aquí está tu parte de la recompensa.$B$BOh, y bienvenido al campamento. Si te quedas por aquí, seguro que te encontramos algún trabajillo...', 18019),
(11984, 'esMX', 'Buen trabajo, $c. Parece que Budd seguirá con nosotros un poco más.$B$BRecogeremos tu jaula ahora mismo. Aquí está tu parte de la recompensa.$B$BOh, y bienvenido al campamento. Si te quedas por aquí, seguro que te encontramos algún trabajillo...', 18019),
(11985, 'esES', 'Bien hecho, $n. La pérdida del comandante de los enanos férreos bastará para acabar con los defensores que quedan. Los terráneos deberían ahora ser capaces de encargarse de los supervivientes.', 18019),
(11985, 'esMX', 'Bien hecho, $n. La pérdida del comandante de los enanos férreos bastará para acabar con los defensores que quedan. Los terráneos deberían ahora ser capaces de encargarse de los supervivientes.', 18019),
(11989, 'esES', 'Síi...$B$BAhora ehtamoh unidoh por la sangre, colega. Un lazo verdadero.$B$BEhcucha con atención a Drakuru, $r. Hay mucho que hacer.', 18019),
(11989, 'esMX', 'Síi...$B$BAhora ehtamoh unidoh por la sangre, colega. Un lazo verdadero.$B$BEhcucha con atención a Drakuru, $r. Hay mucho que hacer.', 18019),
(11990, 'esES', '<Drakuru toma los ingredientes y los mezcla con gran habilidad en el vial.>$B$BEhto servirá, colega. Ahora eh hora de trabajar.', 18019),
(11990, 'esMX', '<Drakuru toma los ingredientes y los mezcla con gran habilidad en el vial.>$B$BEhto servirá, colega. Ahora eh hora de trabajar.', 18019),
(11991, 'esES', 'Aah, sí. Tú lo haceh bien, colega.$B$BLeeré loh muroh, se ven bien dehde aquí...', 18019),
(11991, 'esMX', 'Aah, sí. Tú lo haceh bien, colega.$B$BLeeré loh muroh, se ven bien dehde aquí...', 18019),
(12007, 'esES', "¡Ehto eh, colega!$B$BEh máh precioso de lo que m'ehperaba. Seguro que dará suerte a mi gente en ehtoh tiempoh ohcuroh.$B$BNo hay tiempo que perder, veamoh dónde s'ehconde el próximo artefacto.", 18019),
(12007, 'esMX', "¡Ehto eh, colega!$B$BEh máh precioso de lo que m'ehperaba. Seguro que dará suerte a mi gente en ehtoh tiempoh ohcuroh.$B$BNo hay tiempo que perder, veamoh dónde s'ehconde el próximo artefacto.", 18019),
(12029, 'esES', '¡Bien hesho!$B$B<Mack suelta una risa histérica.>$B$BAy, aay. Qué divertido... hip.', 18019),
(12029, 'esMX', '¡Bien hesho!$B$B<Mack suelta una risa histérica.>$B$BAy, aay. Qué divertido... hip.', 18019),
(12038, 'esES', '¡Bien hesho!$B$B<Mack suelta una risa histérica.>$B$BAy, aay. Qué divertido... hip.', 18019),
(12038, 'esMX', '¡Bien hesho!$B$B<Mack suelta una risa histérica.>$B$BAy, aay. Qué divertido... hip.', 18019),
(12042, 'esES', 'Este desafortunado goblin tiene que haber desenterrado el corazón de los ancestros durante sus excavaciones en esta zona.$B$BSeguramente no tenía ni idea de su naturaleza.$B$BDecides que debe haberse pasado por alto en el caos que ha barrido la zona.', 18019),
(12042, 'esMX', 'Este desafortunado goblin tiene que haber desenterrado el corazón de los ancestros durante sus excavaciones en esta zona.$B$BSeguramente no tenía ni idea de su naturaleza.$B$BDecides que debe haberse pasado por alto en el caos que ha barrido la zona.', 18019),
(12068, 'esES', "Lo conseguimos, $n.$B$BTenemos to's los componentes que necesitamos p'a ejecutar el ritual de limpieza.", 18019),
(12068, 'esMX', "Lo conseguimos, $n.$B$BTenemos to's los componentes que necesitamos p'a ejecutar el ritual de limpieza.", 18019),
(12070, 'esES', 'Has dado a nuestros aliados la fuerza para continuar luchando y por ello te doy las gracias. Sin embargo, debemos comenzar a idear una manera de poner fin a esta batalla antes de que nos ganen ventaja.', 18019),
(12070, 'esMX', 'Has dado a nuestros aliados la fuerza para continuar luchando y por ello te doy las gracias. Sin embargo, debemos comenzar a idear una manera de poner fin a esta batalla antes de que nos ganen ventaja.', 18019),
(12081, 'esES', 'Sé que Kurun te agradece tu ayuda. La derrota de Thor Modan será un gran logro para nosotros, pero no liberará a nuestros hermanos.', 18019),
(12081, 'esMX', 'Sé que Kurun te agradece tu ayuda. La derrota de Thor Modan será un gran logro para nosotros, pero no liberará a nuestros hermanos.', 18019),
(12082, 'esES', 'Así que has sobrevivido a una aventurilla con nuestro buen amigo, ¿verdad?$B$BSolo con eso debería ser recompensa suficiente, pero me siento generoso.', 18019),
(12082, 'esMX', 'Así que has sobrevivido a una aventurilla con nuestro buen amigo, ¿verdad?$B$BSolo con eso debería ser recompensa suficiente, pero me siento generoso.', 18019),
(12093, 'esES', 'Bien. Ahora, debemos actuar sin dilación antes de que los hijos de hierro se den cuenta de que hemos anulado el poder dañino de sus runas.', 18019),
(12093, 'esMX', 'Bien. Ahora, debemos actuar sin dilación antes de que los hijos de hierro se den cuenta de que hemos anulado el poder dañino de sus runas.', 18019),
(12094, 'esES', 'Puedo detectar el poder con el que has imbuido al fragmento y espero que sea suficiente para romper la magia rúnica.', 18019),
(12094, 'esMX', 'Puedo detectar el poder con el que has imbuido al fragmento y espero que sea suficiente para romper la magia rúnica.', 18019),
(12099, 'esES', 'Así que no es algo seguro. Desearía que la suerte no tuviera nada que ver, pero al menos estamos en el buen camino. Sin tu ayuda esto nunca habría sido posible. Si descubres algo más sobre las maquinaciones de los enanos férreos y sus planes hacia los hijos de la piedra, búscanos, $n, y te escucharemos.', 18019),
(12099, 'esMX', 'Así que no es algo seguro. Desearía que la suerte no tuviera nada que ver, pero al menos estamos en el buen camino. Sin tu ayuda esto nunca habría sido posible. Si descubres algo más sobre las maquinaciones de los enanos férreos y sus planes hacia los hijos de la piedra, búscanos, $n, y te escucharemos.', 18019),
(12113, 'esES', '¡Alucinante!$B$BNá mejor para una pinta que un buen bocao de carne.', 18019),
(12113, 'esMX', '¡Alucinante!$B$BNá mejor para una pinta que un buen bocao de carne.', 18019),
(12114, 'esES', 'Gracias, $c.$B$BCuando tenga tiempo me daré un paseo y echaré un vistazo.', 18019),
(12114, 'esMX', 'Gracias, $c.$B$BCuando tenga tiempo me daré un paseo y echaré un vistazo.', 18019),
(12116, 'esES', '¿Tripas? Una elección interesante, $r.$B$BKraz verá lo que puede adivinar de ellas. Gracias por aventurarte en las profundidades de ese lugar.', 18019),
(12116, 'esMX', '¿Tripas? Una elección interesante, $r.$B$BKraz verá lo que puede adivinar de ellas. Gracias por aventurarte en las profundidades de ese lugar.', 18019),
(12120, 'esES', 'Hasta ahora lo has hecho bien, $n, pero ahora viene la verdadera prueba.', 18019),
(12120, 'esMX', 'Hasta ahora lo has hecho bien, $n, pero ahora viene la verdadera prueba.', 18019),
(12121, 'esES', 'Presagiábamos tu venida, amigo. Has hecho bien en venir.', 18019),
(12121, 'esMX', 'Presagiábamos tu venida, amigo. Has hecho bien en venir.', 18019),
(12134, 'esES', 'La muerte de esos monstruos no me devolverá a mi padre... pero eso ahora no importa, ¿verdad?', 18019),
(12134, 'esMX', 'La muerte de esos monstruos no me devolverá a mi padre... pero eso ahora no importa, ¿verdad?', 18019),
(12137, 'esES', 'Has hecho lo correcto.$B$BPor favor, siéntate y escucha. Hay muchas cosas de las que tenemos que hablar.', 18019),
(12137, 'esMX', 'Has hecho lo correcto.$B$BPor favor, siéntate y escucha. Hay muchas cosas de las que tenemos que hablar.', 18019),
(12152, 'esES', 'Ya está.$B$BTu ayuda desinteresada ha otorgado la paz eterna a muchas almas y ha acabado con miles de años de miseria.$B$BQue este acto ilumine tu alma y te libere de tus cargas, pues presiento que aún debes enfrentarte a muchos peligros.$B$BAdiós, $n.', 18019),
(12152, 'esMX', 'Ya está.$B$BTu ayuda desinteresada ha otorgado la paz eterna a muchas almas y ha acabado con miles de años de miseria.$B$BQue este acto ilumine tu alma y te libere de tus cargas, pues presiento que aún debes enfrentarte a muchos peligros.$B$BAdiós, $n.', 18019),
(12164, 'esES', 'Le hemos dado una buena, $n. Pero podría haber sido mejor.$B$BAlgo es seguro... no lo veremos por aquí nunca más.', 18019),
(12164, 'esMX', 'Le hemos dado una buena, $n. Pero podría haber sido mejor.$B$BAlgo es seguro... no lo veremos por aquí nunca más.', 18019),
(12190, 'esES', '¡Vaya! ¿El bueno de Prigmon te ha mandado hasta aquí? Con esto se debería poder hacer una gran comida. Solo necesito un par de cosas...', 18019),
(12190, 'esMX', '¡Vaya! ¿El bueno de Prigmon te ha mandado hasta aquí? Con esto se debería poder hacer una gran comida. Solo necesito un par de cosas...', 18019),
(12279, 'esES', '¡Tú! ¡Tú no eres Joe el cojo!', 18019),
(12279, 'esMX', '¡Tú! ¡Tú no eres Joe el cojo!', 18019),
(12327, 'esES', '¿Aprendiste algo de tu visión? Mencionaste el Poblado Solsticio mientras estabas en trance... Es la segunda vez que alguien menciona el nombre de ese lugar hoy.', 18019),
(12327, 'esMX', '¿Aprendiste algo de tu visión? Mencionaste el Poblado Solsticio mientras estabas en trance... Es la segunda vez que alguien menciona el nombre de ese lugar hoy.', 18019),
(12328, 'esES', 'Bien. Esto servirá.$B$BLa poción estará preparada enseguida.', 18019),
(12328, 'esMX', 'Bien. Esto servirá.$B$BLa poción estará preparada enseguida.', 18019),
(12329, 'esES', 'Me preguntaba cuándo aparecerías. ¿Crees que podrías echarme una mano?', 18019),
(12329, 'esMX', 'Me preguntaba cuándo aparecerías. ¿Crees que podrías echarme una mano?', 18019),
(12330, 'esES', 'Por los pelos.$B$BTenemos que salvar a Anya. ¡Ya!', 18019),
(12330, 'esMX', 'Por los pelos.$B$BTenemos que salvar a Anya. ¡Ya!', 18019),
(12411, 'esES', 'No quiero estar aquí más tiempo. Los hombres huargen son malvados.', 18019),
(12411, 'esMX', 'No quiero estar aquí más tiempo. Los hombres huargen son malvados.', 18019),
(12483, 'esES', 'Oh, tron, ¡estofado de champiñones brillantes! Ya casi puedo saborearlo...', 18019),
(12483, 'esMX', 'Oh, tron, ¡estofado de champiñones brillantes! Ya casi puedo saborearlo...', 18019),
(12484, 'esES', 'No hay ná mejó que ver arder a la Plaga... <hic>.$B$BHe esscrito una cansionsilla sobre esho. ¿La quieress eshcushar? Aquí va...', 18019),
(12484, 'esMX', 'No hay ná mejó que ver arder a la Plaga... <hic>.$B$BHe esscrito una cansionsilla sobre esho. ¿La quieress eshcushar? Aquí va...', 18019),
(12802, 'esES', "¡Impresionante, colega! El destino ha sido generoso al unirnos.$B$BMuy pronto vengaré a mis hermanos limpiando Drak'Tharon, y tú recibirás el mayor tesoro de Drak'Tharon.", 18019),
(12802, 'esMX', "¡Impresionante, colega! El destino ha sido generoso al unirnos.$B$BMuy pronto vengaré a mis hermanos limpiando Drak'Tharon, y tú recibirás el mayor tesoro de Drak'Tharon.", 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID` IN (11982, 11984, 11985, 11989, 11990, 12007, 12029, 12038, 12068, 12070, 12093, 12094, 12099, 12113, 12114, 12116, 12120, 12134, 12137, 12152, 12164, 12190, 12279, 12327, 12328, 12330, 12483, 12484) AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11982, 'esES', '¿Qué tienes que informar?', 18019),
(11982, 'esMX', '¿Qué tienes que informar?', 18019),
(11984, 'esES', '¿Has conseguido enjaular a un troll de hielo?', 18019),
(11984, 'esMX', '¿Has conseguido enjaular a un troll de hielo?', 18019),
(11985, 'esES', '¿Pudiste matar al Señor feudal?', 18019),
(11985, 'esMX', '¿Pudiste matar al Señor feudal?', 18019),
(11989, 'esES', "Buena elección, colega. No vah a vivir p'arrepentirte...", 18019),
(11989, 'esMX', "Buena elección, colega. No vah a vivir p'arrepentirte...", 18019),
(11990, 'esES', '¿Tieneh el material, colega?', 18019),
(11990, 'esMX', '¿Tieneh el material, colega?', 18019),
(12007, 'esES', '¿Hah cogío el ojo de los profetah, colega?', 18019),
(12007, 'esMX', '¿Hah cogío el ojo de los profetah, colega?', 18019),
(12029, 'esES', '¿Ya lo tienes hecho, $N?', 18019),
(12029, 'esMX', '¿Ya lo tienes hecho, $N?', 18019),
(12038, 'esES', '¿Ya lo tienes hecho, $N?', 18019),
(12038, 'esMX', '¿Ya lo tienes hecho, $N?', 18019),
(12068, 'esES', "Qué bueno volver a ve'hte, $n.$B$B¿Has encontra'o las tablillas?", 18019),
(12068, 'esMX', "Qué bueno volver a ve'hte, $n.$B$B¿Has encontra'o las tablillas?", 18019),
(12070, 'esES', '¿Has transmitido mi bendición a los gigantes?', 18019),
(12070, 'esMX', '¿Has transmitido mi bendición a los gigantes?', 18019),
(12093, 'esES', '¿Has neutralizado las runas de la costa?', 18019),
(12093, 'esMX', '¿Has neutralizado las runas de la costa?', 18019),
(12094, 'esES', '¿Has encontrado las antiguas piedras?', 18019),
(12094, 'esMX', '¿Has encontrado las antiguas piedras?', 18019),
(12099, 'esES', '¿Pudiste liberar a alguno de mis hermanos?', 18019),
(12099, 'esMX', '¿Pudiste liberar a alguno de mis hermanos?', 18019),
(12113, 'esES', 'Me rugen las tripas, $r. ¿Pudiste juntar algo de comida?', 18019),
(12113, 'esMX', 'Me rugen las tripas, $r. ¿Pudiste juntar algo de comida?', 18019),
(12114, 'esES', '¿Cómo va la caza de trolls?', 18019),
(12114, 'esMX', '¿Cómo va la caza de trolls?', 18019),
(12116, 'esES', '¿Qué has encontrado para Kraz en esa cripta, $c?', 18019),
(12116, 'esMX', '¿Qué has encontrado para Kraz en esa cripta, $c?', 18019),
(12120, 'esES', '¿Encuentras la marra, $n?', 18019),
(12120, 'esMX', '¿Encuentras la marra, $n?', 18019),
(12134, 'esES', '¿Ya te has ocupado de los cazadores del pueblo, $n?', 18019),
(12134, 'esMX', '¿Ya te has ocupado de los cazadores del pueblo, $n?', 18019),
(12137, 'esES', '¿Has terminado tu deber en la cripta, $c?', 18019),
(12137, 'esMX', '¿Has terminado tu deber en la cripta, $c?', 18019),
(12152, 'esES', "¿Ha sido derrotado Jin'arrak, $N?", 18019),
(12152, 'esMX', "¿Ha sido derrotado Jin'arrak, $N?", 18019),
(12164, 'esES', 'Es bueno verte, $N.', 18019),
(12164, 'esMX', 'Es bueno verte, $N.', 18019),
(12190, 'esES', '¿Qué puedo hacer por ti?', 18019),
(12190, 'esMX', '¿Qué puedo hacer por ti?', 18019),
(12279, 'esES', 'Si no te das prisa, va a rugirle algo más que el estómago...', 18019),
(12279, 'esMX', 'Si no te das prisa, va a rugirle algo más que el estómago...', 18019),
(12327, 'esES', '¿Sí, $n?', 18019),
(12327, 'esMX', '¿Sí, $n?', 18019),
(12328, 'esES', '¿Conseguiste el polvo, $n?', 18019),
(12328, 'esMX', '¿Conseguiste el polvo, $n?', 18019),
(12330, 'esES', 'Me alegro de verte de una pieza.', 18019),
(12330, 'esMX', 'Me alegro de verte de una pieza.', 18019),
(12483, 'esES', '¿Le has conseguido esos ingredientes al viejo Prigmon, $n?', 18019),
(12483, 'esMX', '¿Le has conseguido esos ingredientes al viejo Prigmon, $n?', 18019),
(12484, 'esES', '¿Qué tienes ahí, $r?', 18019),
(12484, 'esMX', '¿Qué tienes ahí, $r?', 18019);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_08_03' WHERE sql_rev = '1646749877159440400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
