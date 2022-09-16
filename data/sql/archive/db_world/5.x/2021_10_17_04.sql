-- DB update 2021_10_17_03 -> 2021_10_17_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_17_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_17_03 2021_10_17_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634256857773109500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634256857773109500');

-- Quest: You Survived! - ID: 9279
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9279 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9279, 'esES', '¡Por mi alma, $n, cuánto me alegro de verte! No sé por qué se estrelló El Exodar. Solo sobrevivimos los que estábamos en esta parte de la nave.$B$B¡Tenemos que darnos prisa para salvar a todos los que podamos!', 18019),
(9279, 'esMX', '¡Por mi alma, $n, cuánto me alegro de verte! No sé por qué se estrelló El Exodar. Solo sobrevivimos los que estábamos en esta parte de la nave.$B$B¡Tenemos que darnos prisa para salvar a todos los que podamos!', 18019);

-- Quest: Replenishing the Healing Crystals - ID: 9280
DELETE FROM `quest_request_items_locale` WHERE `ID`=9280 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9280, 'esES', '$n, ¿traes la sangre de polilla del valle para los cristales de sanación? ¡Debemos apresurarnos, hay muchos supervivientes en el valle!', 18019),
(9280, 'esMX', '$n, ¿traes la sangre de polilla del valle para los cristales de sanación? ¡Debemos apresurarnos, hay muchos supervivientes en el valle!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9280 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9280, 'esES', 'Es lamentable que esas criaturas tuvieran que morir para que nosotros vivamos; los $r no matamos indiscriminadamente. Pero la sangre que traes recargará nuestros cristales de sanación. La muerte de esas criaturas no ha sido en vano.', 18019),
(9280, 'esMX', 'Es lamentable que esas criaturas tuvieran que morir para que nosotros vivamos; los $r no matamos indiscriminadamente. Pero la sangre que traes recargará nuestros cristales de sanación. La muerte de esas criaturas no ha sido en vano.', 18019);

-- Quest: Urgent Delivery! - ID: 9409
DELETE FROM `quest_request_items_locale` WHERE `ID`=9409 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9409, 'esES', 'Hola, $c. ¿Traes algo para mí?', 18019),
(9409, 'esMX', 'Hola, $c. ¿Traes algo para mí?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9409 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9409, 'esES', '¡Buen trabajo! Con esto podremos reponer los cristales de sanación.$B$BYa que estás aquí, tengo otra tarea para ti. ¿Quieres encargarte?', 18019),
(9409, 'esMX', '¡Buen trabajo! Con esto podremos reponer los cristales de sanación.$B$BYa que estás aquí, tengo otra tarea para ti. ¿Quieres encargarte?', 18019);

-- Quest: Rescue the Survivors! - ID: 9283
UPDATE `quest_template_locale` SET `ObjectiveText1`='Supervivientes draenei salvados' WHERE `id`=9283 AND `locale` IN ('esES', 'esMX');

DELETE FROM `quest_request_items_locale` WHERE `ID`=9283 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9283, 'esES', 'Sobreviviremos a esto con tu ayuda.', 18019),
(9283, 'esMX', 'Sobreviviremos a esto con tu ayuda.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9283 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9283, 'esES', '¡Alabada sea la Luz! Has hecho lo que solo un héroe podría haber hecho, $n. Los $r que has salvado te deben la vida.$B$BPor favor, acepta estos suministros. Parece que los necesitas más que yo.', 18019),
(9283, 'esMX', '¡Alabada sea la Luz! Has hecho lo que solo un héroe podría haber hecho, $n. Los $r que has salvado te deben la vida.$B$BPor favor, acepta estos suministros. Parece que los necesitas más que yo.', 18019);

-- Quest: Shaman Training - ID: 9421
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9421 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9421, 'esES', 'Soy Firmanvaar y haces bien en buscarme. Es mi tarea instruir a los chamanes, especialmente los que están empezando.$B$BSolo ahora se está volviendo a aprender el chamanismos entre los $r, $n. Eres valiente al seguir un camino que no es tan popular entre los de tu clase.$B$BEstaré aquí cuando creas estar lista para más instrucción.', 18019),
(9421, 'esMX', 'Soy Firmanvaar y haces bien en buscarme. Es mi tarea instruir a los chamanes, especialmente los que están empezando.$B$BSolo ahora se está volviendo a aprender el chamanismos entre los $r, $n. Eres valiente al seguir un camino que no es tan popular entre los de tu clase.$B$BEstaré aquí cuando creas estar lista para más instrucción.', 18019);

-- Quest: Botanist Taerix - ID: 9371
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9371 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9371, 'esES', 'Menos mal que has venido. Tenemos muchísimo que hacer.', 18019),
(9371, 'esMX', 'Menos mal que has venido. Tenemos muchísimo que hacer.', 18019);

-- Quest: Volatile Mutations - ID: 10302
DELETE FROM `quest_request_items_locale` WHERE `ID`=10302 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(10302, 'esES', 'Estoy trabajando en una solución que creo que puede ser eficaz con las criaturas extrañas. Sólo necesito más tiempo.', 18019),
(10302, 'esMX', 'Estoy trabajando en una solución que creo que puede ser eficaz con las criaturas extrañas. Sólo necesito más tiempo.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=10302 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(10302, 'esES', '¿Has acabado? Es una buena noticia. Con un poco de suerte encontraremos una forma de evitar la matanza de estas bestias mutantes en el futuro.$B$BTengo un plan que quizás nos dé una solución alternativa para este problema pero voy a necesitar tu ayuda.', 18019),
(10302, 'esMX', '¿Has acabado? Es una buena noticia. Con un poco de suerte encontraremos una forma de evitar la matanza de estas bestias mutantes en el futuro.$B$BTengo un plan que quizás nos dé una solución alternativa para este problema pero voy a necesitar tu ayuda.', 18019);

-- Quest: What Must Be Done... - ID: 9293
DELETE FROM `quest_request_items_locale` WHERE `ID`=9293 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9293, 'esES', 'Necesitaré todas las muestras en buen estado si queremos tener una posibilidad de limpiar el lago.$B$B¡No nos queda mucho tiempo, $c!', 18019),
(9293, 'esMX', 'Necesitaré todas las muestras en buen estado si queremos tener una posibilidad de limpiar el lago.$B$B¡No nos queda mucho tiempo, $c!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9293 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9293, 'esES', 'Servirán. ¡Gracias, $c!$B$BMientras estabas fuera, conseguí reunir algo de equipamiento para analizar las muestras. Solo debería ser un segundo.', 18019),
(9293, 'esMX', 'Servirán. ¡Gracias, $c!$B$BMientras estabas fuera, conseguí reunir algo de equipamiento para analizar las muestras. Solo debería ser un segundo.', 18019);

-- Quest: Healing the Lake - ID: 9294
DELETE FROM `quest_request_items_locale` WHERE `ID`=9294 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9294, 'esES', 'Cuanto antes se disperse el agente en el lago, menos criaturas nativas mutarán al beber el agua, ¡incluidos nosotros mismos! $B$BSiento que no podamos hacer nada para ayudar a las pobres criaturas que ya han sido infectadas. Si tan sólo mi equipo de laboratorio estuviera intacto.', 18019),
(9294, 'esMX', 'Cuanto antes se disperse el agente en el lago, menos criaturas nativas mutarán al beber el agua, ¡incluidos nosotros mismos! $B$BSiento que no podamos hacer nada para ayudar a las pobres criaturas que ya han sido infectadas. Si tan sólo mi equipo de laboratorio estuviera intacto.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Dispersa el agente neutralizador' WHERE `id`=9294 AND `locale` IN ('esES', 'esMX');

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9294 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9294, 'esES', 'Por lo que describes, ¡el agente neutralizador ha funcionado! Ojalá supiera cuánto va a durar; necesitamos realmente eliminar por completo ese cristal de poder del lago.$B$B¡Gracias, $n! Le diré a Tedon que pruebe el agente neutralizador sobre una de las bestias cautivas enseguida.', 18019),
(9294, 'esMX', 'Por lo que describes, ¡el agente neutralizador ha funcionado! Ojalá supiera cuánto va a durar; necesitamos realmente eliminar por completo ese cristal de poder del lago.$B$B¡Gracias, $n! Le diré a Tedon que pruebe el agente neutralizador sobre una de las bestias cautivas enseguida.', 18019);

-- Quest: Vindicator Aldar - ID: 10304
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=10304 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(10304, 'esES', 'Eres $n, ¿verdad? He oído hablar muy bien de ti y de las cosas que has hecho en el poco tiempo que llevas aquí.$B$BNecesitaremos tu ayuda para que todo vuelva a la normalidad. Y seguro que Zhanaa, que está allí, también agradecería una mano.', 18019),
(10304, 'esMX', 'Eres $n, ¿verdad? He oído hablar muy bien de ti y de las cosas que has hecho en el poco tiempo que llevas aquí.$B$BNecesitaremos tu ayuda para que todo vuelva a la normalidad. Y seguro que Zhanaa, que está allí, también agradecería una mano.', 18019);

-- Quest: Inoculation - ID: 9303
DELETE FROM `quest_request_items_locale` WHERE `ID`=9303 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9303, 'esES', 'Cuanto más hagamos por despejar Cubrebosque, antes podrá Zhanaa volver al trabajo.', 18019),
(9303, 'esMX', 'Cuanto más hagamos por despejar Cubrebosque, antes podrá Zhanaa volver al trabajo.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9303 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9303, 'esES', 'Con muchos de los buhícos inoculados, podemos centrarnos en salir de aquí y no tener que preocuparnos de erradicar la población de buhícos de la zona.$B$BAquí tienes, elige lo que quieras. Has hecho un buen trabajo ¡y mereces una recompensa!', 18019),
(9303, 'esMX', 'Con muchos de los buhícos inoculados, podemos centrarnos en salir de aquí y no tener que preocuparnos de erradicar la población de buhícos de la zona.$B$BAquí tienes, elige lo que quieras. Has hecho un buen trabajo ¡y mereces una recompensa!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Buhcos Cubrebosque inoculados' WHERE `id`=9303 AND `locale` IN ('esES', 'esMX');

-- Quest: Spare Parts - ID: 9305
DELETE FROM `quest_request_items_locale` WHERE `ID`=9305 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9305, 'esES', 'Cuando tengamos esas piezas de repuesto, sé que conseguiremos reparar este emisor. Con un poco de suerte quedará alguien más por ahí fuera con quien hablar.', 18019),
(9305, 'esMX', 'Cuando tengamos esas piezas de repuesto, sé que conseguiremos reparar este emisor. Con un poco de suerte quedará alguien más por ahí fuera con quien hablar.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9305 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9305, 'esES', 'Deja que les eche un vistazo.$B$BSí, creo que servirán, buen trabajo, $n. El emisor es bastante complejo, así que puede que me lleve algún tiempo acabar de repararlo. Te lo diré cuando esté listo.$B$BMientras tanto, podrías ir a ver si el vindicador Aldar te necesita para alguna cosa.', 18019),
(9305, 'esMX', 'Deja que les eche un vistazo.$B$BSí, creo que servirán, buen trabajo, $n. El emisor es bastante complejo, así que puede que me lleve algún tiempo acabar de repararlo. Te lo diré cuando esté listo.$B$BMientras tanto, podrías ir a ver si el vindicador Aldar te necesita para alguna cosa.', 18019);

-- Quest: Botanical Legwork - ID: 9799
DELETE FROM `quest_request_items_locale` WHERE `ID`=9799 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9799, 'esES', 'Hola, $c. ¿Traes las flores?', 18019),
(9799, 'esMX', 'Hola, $c. ¿Traes las flores?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9799 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9799, 'esES', 'Estos especímenes tienen buen aspecto. Gracias por ocuparte del trabajo de campo. Cuando los haya analizado, podré determinar qué hay que hacer para restaurar los campos.', 18019),
(9799, 'esMX', 'Estos especímenes tienen buen aspecto. Gracias por ocuparte del trabajo de campo. Cuando los haya analizado, podré determinar qué hay que hacer para restaurar los campos.', 18019);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_17_04' WHERE sql_rev = '1634256857773109500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
