-- DB update 2022_03_06_15 -> 2022_03_06_16
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_15';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_15 2022_03_06_16 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646155636640613000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646155636640613000');

-- La nueva peste - ID 11167
DELETE FROM `quest_request_items_locale` WHERE `ID`=11167 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11167, 'esES', '¿Has conseguido los contenedores, $n?', 18019),
(11167, 'esMX', '¿Has conseguido los contenedores, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11167 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11167, 'esES', 'Me alegro de que hayas vuelto entero. El riesgo de infectarse manipulando estos contenedores no es inexistente. Supongo que tendría que haberte avisado de esto antes.', 18019),
(11167, 'esMX', 'Me alegro de que hayas vuelto entero. El riesgo de infectarse manipulando estos contenedores no es inexistente. Supongo que tendría que haberte avisado de esto antes.', 18019);

-- Una mezcla más fuerte - ID 11168
DELETE FROM `quest_request_items_locale` WHERE `ID`=11168 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11168, 'esES', '¿Has conseguido las glándulas de toxinas que busco, $n?', 18019),
(11168, 'esMX', '¿Has conseguido las glándulas de toxinas que busco, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11168 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11168, 'esES', 'Sigues demostrando tus aptitudes con creces, $n. Con un poco de suerte esta toxina servirá para conseguir el nivel de potencia suficiente para nuestra peste.$B$BComo mínimo debería ayudar a debilitar a nuestras víctimas y volverlas más susceptibles al contagio.', 18019),
(11168, 'esMX', 'Sigues demostrando tus aptitudes con creces, $n. Con un poco de suerte esta toxina servirá para conseguir el nivel de potencia suficiente para nuestra peste.$B$BComo mínimo debería ayudar a debilitar a nuestras víctimas y volverlas más susceptibles al contagio.', 18019);

-- Prueba en el mar - ID 11170
DELETE FROM `quest_request_items_locale` WHERE `ID`=11170 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11170, 'esES', 'Has vuelto', 18019),
(11170, 'esMX', 'Has vuelto', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11170 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11170, 'esES', 'Huumm... Los informes del campo son... ¡nada esperanzadores!', 18019),
(11170, 'esMX', 'Huumm... Los informes del campo son... ¡nada esperanzadores!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Reservista de la Flota Norte infectado' WHERE `ID`=11170 AND `locale` IN ('esES', 'esMX');

-- Informes desde el campo - ID 11221
DELETE FROM `quest_request_items_locale` WHERE `ID`=11221 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11221, 'esES', '¿Has vuelto con tu informe, $n?', 18019),
(11221, 'esMX', '¿Has vuelto con tu informe, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11221 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11221, 'esES', '¿Qué los cañones nos impiden avanzar? Les enseñaré lo que son unos cañones.', 18019),
(11221, 'esMX', '¿Qué los cañones nos impiden avanzar? Les enseñaré lo que son unos cañones.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Escucha el informe de Razael', `ObjectiveText2`='Escucha el informe de Lyana' WHERE `ID`=11221 AND `locale` IN ('esES', 'esMX');

-- ¡Que coman grajos! - ID 11227
DELETE FROM `quest_request_items_locale` WHERE `ID`=11227 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11227, 'esES', '¿Ya le diste de comer a este pequeño bribón?', 18019),
(11227, 'esMX', '¿Ya le diste de comer a este pequeño bribón?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11227 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11227, 'esES', '¿Perseguiste a algunos de esos grajos, pequeño? ¡Buen chico, buen chico!$B$BAy... esos canes me recuerdan a los tiempos en los que criaba a esos pura sangre en Tirisfal... ¡Qué gran época!', 18019),
(11227, 'esMX', '¿Perseguiste a algunos de esos grajos, pequeño? ¡Buen chico, buen chico!$B$BAy... esos canes me recuerdan a los tiempos en los que criaba a esos pura sangre en Tirisfal... ¡Qué gran época!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Can de peste alimentado' WHERE `ID`=11227 AND `locale` IN ('esES', 'esMX');

-- La flota de El Brisaveloz - ID 11229
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11229 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11229, 'esES', 'Espero que estés preparado para luchar, $n. ¡La flota de la Reina te necesita!', 18019),
(11229, 'esMX', 'Espero que estés preparado para luchar, $n. ¡La flota de la Reina te necesita!', 18019);

-- ¡Una emboscada! - ID 11230
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11230 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11230, 'esES', 'Bien, te has ocupado de esos chuchos sarnosos... Mis hombres podrán ocuparse del resto.', 18019),
(11230, 'esMX', 'Bien, te has ocupado de esos chuchos sarnosos... Mis hombres podrán ocuparse del resto.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Marino de la Flota Norte' WHERE `ID`=11230 AND `locale` IN ('esES', 'esMX');

-- Sé nuestros ojos - ID 11232
DELETE FROM `quest_request_items_locale` WHERE `ID`=11232 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11232, 'esES', 'Los cañones, $n. ¿Alguien se va a encargar de ellos?', 18019),
(11232, 'esMX', 'Los cañones, $n. ¿Alguien se va a encargar de ellos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11232 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11232, 'esES', 'Perfecto, daré la señal a las tropas de tierra para que avancen.', 18019),
(11232, 'esMX', 'Perfecto, daré la señal a las tropas de tierra para que avancen.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Cañón del este marcado', `ObjectiveText2`='Cañón del oeste marcado' WHERE `ID`=11232 AND `locale` IN ('esES', 'esMX');

-- Asestar el golpe de gracia - ID 11233
DELETE FROM `quest_request_items_locale` WHERE `ID`=11233 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11233, 'esES', '¿Están muertos los líderes de la Alianza, $N? No vuelvas hasta que lo estén.', 18019),
(11233, 'esMX', '¿Están muertos los líderes de la Alianza, $N? No vuelvas hasta que lo estén.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11233 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11233, 'esES', 'Esto nos otorga la victoria indiscutible. Anselm se alegrará mucho cuando se entere.', 18019),
(11233, 'esMX', 'Esto nos otorga la victoria indiscutible. Anselm se alegrará mucho cuando se entere.', 18019);

-- Informa a Anselm - ID 11234
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11234 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11234, 'esES', 'Ya era hora. La Alianza ha sido una espina que teníamos clavada desde hace mucho.$B$BPero no hay tiempo para celebraciones. Mira al oeste, parece que tenemos visita.', 18019),
(11234, 'esMX', 'Ya era hora. La Alianza ha sido una espina que teníamos clavada desde hace mucho.$B$BPero no hay tiempo para celebraciones. Mira al oeste, parece que tenemos visita.', 18019);

-- Rastro de fuego - ID 11241
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11241 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11241, 'esES', '¿El boticario Hanes está vivo? ¿Has quemado los suministros de la Alianza? Tiene que haber disfrutado de verdad.$B$BLa Sociedad Real de Boticarios está en deuda contigo, $n. Te lo agradecemos desde lo más profundo de nuestros oscuros, oscuros corazones.', 18019),
(11241, 'esMX', '¿El boticario Hanes está vivo? ¿Has quemado los suministros de la Alianza? Tiene que haber disfrutado de verdad.$B$BLa Sociedad Real de Boticarios está en deuda contigo, $n. Te lo agradecemos desde lo más profundo de nuestros oscuros, oscuros corazones.', 18019);

-- Sigue la pista del enemigo - ID 11253
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11253 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11253, 'esES', 'Este pergamino de escamas está cubierto de escuetas imágenes pintadas. Te da la impresión de que es el tipo de cosas que el cuidador de perros quería que encontrases cuando te pidió que buscases pistas.', 18019),
(11253, 'esMX', 'Este pergamino de escamas está cubierto de escuetas imágenes pintadas. Te da la impresión de que es el tipo de cosas que el cuidador de perros quería que encontrases cuando te pidió que buscases pistas.', 18019);

-- El mapa de piel de dragón - ID 11254
DELETE FROM `quest_request_items_locale` WHERE `ID`=11254 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11254, 'esES', '¿Tienes algo que mostrarme, $c?', 18019),
(11254, 'esMX', '¿Tienes algo que mostrarme, $c?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11254 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11254, 'esES', '<El sumo ejecutor mira el mapa con atención, fijándose de vez en cuando en las marcas alrededor del Fiordo.>$B$BAquí está la costa este. Las ciudades Desuelladragones e Inbjerskorn están aquí y aquí... Y estos debemos de ser nosotros, marcados con la muerte.', 18019),
(11254, 'esMX', '<El sumo ejecutor mira el mapa con atención, fijándose de vez en cuando en las marcas alrededor del Fiordo.>$B$BAquí está la costa este. Las ciudades Desuelladragones e Inbjerskorn están aquí y aquí... Y estos debemos de ser nosotros, marcados con la muerte.', 18019);

-- ¡Skorn debe caer! - ID 11256
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11256 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11256, 'esES', 'Será interesante aprender más sobre tu gente mientras lucho a tu lado, $c.$B$B¿Comenzamos?', 18019),
(11256, 'esMX', 'Será interesante aprender más sobre tu gente mientras lucho a tu lado, $c.$B$B¿Comenzamos?', 18019);

-- Horripilante, pero necesario - ID 11257
DELETE FROM `quest_request_items_locale` WHERE `ID`=11257 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11257, 'esES', 'Estos vrykul tienen extrañas costumbres, ¿no estás de acuerdo, $n?', 18019),
(11257, 'esMX', 'Estos vrykul tienen extrañas costumbres, ¿no estás de acuerdo, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11257 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11257, 'esES', '¿Ya has hecho esto antes? Pareces experta en el uso del machete.$B$B<El valiente te mira con recelo.>$B$BDevuélvemelo ahora, $c.', 18019),
(11257, 'esMX', '¿Ya has hecho esto antes? Pareces experta en el uso del machete.$B$B<El valiente te mira con recelo.>$B$BDevuélvemelo ahora, $c.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Vrykul Inbjerskorn desmembrado' WHERE `ID`=11257 AND `locale` IN ('esES', 'esMX');

-- ¡Arde, Skorn, arde! - ID 11258
DELETE FROM `quest_request_items_locale` WHERE `ID`=11258 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11258, 'esES', 'Sugiero que cuando incendiemos los edificios, no nos quedemos dentro de ellos. El espíritu del fuego no nos perdonará en su sed de destrucción.', 18019),
(11258, 'esMX', 'Sugiero que cuando incendiemos los edificios, no nos quedemos dentro de ellos. El espíritu del fuego no nos perdonará en su sed de destrucción.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11258 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11258, 'esES', '<El valiente mueve afirmativamente la cabeza al ver que sujetas la antorcha>$B$BHaz que esos vrykuls sientan el calor de la tierra. ¡Haz que conozcan el miedo que ellos instigan a otros!', 18019),
(11258, 'esMX', '<El valiente mueve afirmativamente la cabeza al ver que sujetas la antorcha>$B$BHaz que esos vrykuls sientan el calor de la tierra. ¡Haz que conozcan el miedo que ellos instigan a otros!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Casa comunal noroeste en llamas', `ObjectiveText2`='Casa comunal noreste en llamas', `ObjectiveText3`='Barracones en llamas' WHERE `ID`=11258 AND `locale` IN ('esES', 'esMX');

-- Torres de muerte segura - ID 11259
DELETE FROM `quest_request_items_locale` WHERE `ID`=11259 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11259, 'esES', 'Acercarse demasiado a esas torres es una muerte segura mientras esos lanzadores estén ahí arriba.', 18019),
(11259, 'esMX', 'Acercarse demasiado a esas torres es una muerte segura mientras esos lanzadores estén ahí arriba.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11259 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11259, 'esES', 'Tienes buen brazo, $n.$B$BParece que esos jinetes del viento al fin han decidido ser de utilidad en vez de pasarse el día bebiendo.', 18019),
(11259, 'esMX', 'Tienes buen brazo, $n.$B$BParece que esos jinetes del viento al fin han decidido ser de utilidad en vez de pasarse el día bebiendo.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Torre del noroeste fijada como objetivo', `ObjectiveText2`='Torre del este fijada como objetivo', `ObjectiveText3`='Torre del suroeste fijada como objetivo', `ObjectiveText4`='Torre del sureste fijada como objetivo' WHERE `ID`=11259 AND `locale` IN ('esES', 'esMX');

-- ¡Detén la ascensión! - ID 11260
DELETE FROM `quest_request_items_locale` WHERE `ID`=11260 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11260, 'esES', '¿Sí? ¿Cómo puedo ayudarte?', 18019),
(11260, 'esMX', '¿Sí? ¿Cómo puedo ayudarte?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11260 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11260, 'esES', 'Sí, hija mía, parece inquietante.$B$BGracias por traerme este pergamino. Estoy muy interesada en estudiar sus implicaciones. Si tuviera que suponer algo, pensaría que estos vrykuls han encontrado el modo de transcender a la muerte, al menos aquellos que son dignos.$B$BAl vencer al señor feudal de Inbjerskorn, has demostrado que no es digno. Quién sabe en qué se habría convertido y qué terror habría causado sobre nosotros si no lo hubieras matado.', 18019),
(11260, 'esMX', 'Sí, hija mía, parece inquietante.$B$BGracias por traerme este pergamino. Estoy muy interesada en estudiar sus implicaciones. Si tuviera que suponer algo, pensaría que estos vrykuls han encontrado el modo de transcender a la muerte, al menos aquellos que son dignos.$B$BAl vencer al señor feudal de Inbjerskorn, has demostrado que no es digno. Quién sabe en qué se habría convertido y qué terror habría causado sobre nosotros si no lo hubieras matado.', 18019);

-- ¡El conquistador de Skorn! - ID 11261
DELETE FROM `quest_request_items_locale` WHERE `ID`=11261 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11261, 'esES', '¿Qué noticias traes de Skorn, $n?', 18019),
(11261, 'esMX', '¿Qué noticias traes de Skorn, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11261 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11261, 'esES', '¡Qué buenas noticias! Nos has dado un respiro para continuar con nuestros preparativos y marcharnos.$B$BTe ruego que tomes uno de estos en señal de nuestro aprecio.', 18019),
(11261, 'esMX', '¡Qué buenas noticias! Nos has dado un respiro para continuar con nuestros preparativos y marcharnos.$B$BTe ruego que tomes uno de estos en señal de nuestro aprecio.', 18019);

-- Encargarse de Gjalerbron - ID 11263
DELETE FROM `quest_request_items_locale` WHERE `ID`=11263 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11263, 'esES', '¿Cómo va la lucha en Gjalerbron?', 18019),
(11263, 'esMX', '¿Cómo va la lucha en Gjalerbron?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11263 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11263, 'esES', 'Te lo agradezco, $n. Sé que no me debes nada ni a mí ni a mi pueblo.$B$BLo que cuentas sobre ese lugar me sigue preocupando, y tengo el presentimiento de que nuestra matanza no ha terminado aún.', 18019),
(11263, 'esMX', 'Te lo agradezco, $n. Sé que no me debes nada ni a mí ni a mi pueblo.$B$BLo que cuentas sobre ese lugar me sigue preocupando, y tengo el presentimiento de que nuestra matanza no ha terminado aún.', 18019);

-- Necroseñor Supremo Mezhen - ID 11264
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11264 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11264, 'esES', '<El cabecilla Tótem de Ceniza suspira aliviado.>$B$BEso debería relajar el ambiente.$B$B$n, una vez más has demostrado con creces tu valía a los taunka de Campamento Pezuña Invernal. Elije lo que quieras como recompensa. Insisto.', 18019),
(11264, 'esMX', '<El cabecilla Tótem de Ceniza suspira aliviado.>$B$BEso debería relajar el ambiente.$B$B$n, una vez más has demostrado con creces tu valía a los taunka de Campamento Pezuña Invernal. Elije lo que quieras como recompensa. Insisto.', 18019);

-- De llaves y jaulas - ID 11265
DELETE FROM `quest_request_items_locale` WHERE `ID`=11265 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11265, 'esES', 'Con los prisioneros de Gjalerbron liberados, los vrykul no podrán continuar con sus rituales.', 18019),
(11265, 'esMX', 'Con los prisioneros de Gjalerbron liberados, los vrykul no podrán continuar con sus rituales.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11265 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11265, 'esES', 'Me acabas de quitar un gran peso de encima al saber que lo has logrado. Y sonrío al saber que algunos de los que liberaste eran taunka.$B$BPor favor, toma esto como regalo por lo que has hecho. Velaré por la salud de aquellos que has liberado.', 18019),
(11265, 'esMX', 'Me acabas de quitar un gran peso de encima al saber que lo has logrado. Y sonrío al saber que algunos de los que liberaste eran taunka.$B$BPor favor, toma esto como regalo por lo que has hecho. Velaré por la salud de aquellos que has liberado.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Prisionero de Gjalerbron liberado' WHERE `ID`=11265 AND `locale` IN ('esES', 'esMX');

-- Los planes de ataque de Gjalerbron - ID 11266
DELETE FROM `quest_request_items_locale` WHERE `ID`=11266 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11266, 'esES', '¡¿Qué?! ¿Planes de un ataque a nuestro campamento?$B$B¿DE UNA ENORME VERMIS DE ESCARCHA EN EL CIELO?', 18019),
(11266, 'esMX', '¡¿Qué?! ¿Planes de un ataque a nuestro campamento?$B$B¿DE UNA ENORME VERMIS DE ESCARCHA EN EL CIELO?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11266 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11266, 'esES', '$n, ¡no podemos permitirlo!', 18019),
(11266, 'esMX', '$n, ¡no podemos permitirlo!', 18019);

-- La vermis de escarcha y su maestro - ID 11267
DELETE FROM `quest_request_items_locale` WHERE `ID`=11267 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11267, 'esES', '¿Se ha desviado el ataque? ¿Han muerto la gran vermis de escarcha y su maestro?$B$B¿Has recuperado el cuerno?', 18019),
(11267, 'esMX', '¿Se ha desviado el ataque? ¿Han muerto la gran vermis de escarcha y su maestro?$B$B¿Has recuperado el cuerno?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11267 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11267, 'esES', 'Este cuerno está tan frío como estas tierras... ¡o incluso más!$B$BHas salvado el Campamento Pezuña Invernal de una condena segura, aunque no nos quedaremos aquí durante demasiado tiempo. Qué curioso eres, $n. Quizás los de tu raza no sois tan malos después de todo.$B$BEsto se merece una recompensa. ¿Cuál prefieres?', 18019),
(11267, 'esMX', 'Este cuerno está tan frío como estas tierras... ¡o incluso más!$B$BHas salvado el Campamento Pezuña Invernal de una condena segura, aunque no nos quedaremos aquí durante demasiado tiempo. Qué curioso eres, $n. Quizás los de tu raza no sois tan malos después de todo.$B$BEsto se merece una recompensa. ¿Cuál prefieres?', 18019);

-- Los muertos andantes - ID 11268
DELETE FROM `quest_request_items_locale` WHERE `ID`=11268 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11268, 'esES', '¿Has destruido a los muertos andantes en Gjalerbron?', 18019),
(11268, 'esMX', '¿Has destruido a los muertos andantes en Gjalerbron?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11268 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11268, 'esES', '<La abuela aprueba tus acciones, asintiendo con la cabeza.>$B$BGracias, $n, has hecho lo correcto y nos has conseguido algo más de tiempo para preparar nuestra partida. Pronto emprenderemos el viaje hacia el norte.$B$BPero soy demasiado vieja... Cuando nos vayamos, no seré capaz de llevármelo todo. ¿Quieres uno de estos?', 18019),
(11268, 'esMX', '<La abuela aprueba tus acciones, asintiendo con la cabeza.>$B$BGracias, $n, has hecho lo correcto y nos has conseguido algo más de tiempo para preparar nuestra partida. Pronto emprenderemos el viaje hacia el norte.$B$BPero soy demasiado vieja... Cuando nos vayamos, no seré capaz de llevármelo todo. ¿Quieres uno de estos?', 18019);

-- La guerra es un infierno - ID 11270
DELETE FROM `quest_request_items_locale` WHERE `ID`=11270 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11270, 'esES', 'No me importa cuántos gigantes, dragones o kobolds hayas matado antes. Haz este trabajo y vuelve cuando hayas terminado.', 18019),
(11270, 'esMX', 'No me importa cuántos gigantes, dragones o kobolds hayas matado antes. Haz este trabajo y vuelve cuando hayas terminado.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11270 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11270, 'esES', 'Me alegra que hayas demostrado que sabes cumplir órdenes. Si me dieran una moneda de cobre por cada loco con armadura brillante que pasa por aquí y se cree que está por encima de la cadena de mando... bueno, tendría bastante oro.$B$BAhora que has demostrado cierta disciplina, tengo otras tareas más apropiadas para alguien de tu valía.', 18019),
(11270, 'esMX', 'Me alegra que hayas demostrado que sabes cumplir órdenes. Si me dieran una moneda de cobre por cada loco con armadura brillante que pasa por aquí y se cree que está por encima de la cadena de mando... bueno, tendría bastante oro.$B$BAhora que has demostrado cierta disciplina, tengo otras tareas más apropiadas para alguien de tu valía.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Combatiente caído quemado' WHERE `ID`=11270 AND `locale` IN ('esES', 'esMX');

-- Preparativos precipitados - ID 11271
DELETE FROM `quest_request_items_locale` WHERE `ID`=11271 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11271, 'esES', '¿Has conseguido los plumones?', 18019),
(11271, 'esMX', '¿Has conseguido los plumones?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11271 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11271, 'esES', 'Con tu aportación estaremos bien preparados para el viaje. No puedo ofrecerte gran cosa, pero te daré a elegir entre los pertrechos de combate que me sobran.', 18019),
(11271, 'esMX', 'Con tu aportación estaremos bien preparados para el viaje. No puedo ofrecerte gran cosa, pero te daré a elegir entre los pertrechos de combate que me sobran.', 18019);

-- Haciendo el cuerno - ID 11275
DELETE FROM `quest_request_items_locale` WHERE `ID`=11275 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11275, 'esES', '¿Me has traído los cuernos apropiados?', 18019),
(11275, 'esMX', '¿Me has traído los cuernos apropiados?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11275 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11275, 'esES', 'Todos son buenos cuernos, $n. Déjame echarles un vistazo y escogeré uno, que utilizaré durante la caza.$B$BDaré el resto a los artesanos para que puedan grabarlos.', 18019),
(11275, 'esMX', 'Todos son buenos cuernos, $n. Déjame echarles un vistazo y escogeré uno, que utilizaré durante la caza.$B$BDaré el resto a los artesanos para que puedan grabarlos.', 18019);

-- Huevos verdes con crías - ID 11279
DELETE FROM `quest_request_items_locale` WHERE `ID`=11279 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11279, 'esES', 'Sin esas muestras, ¿cómo voy a saber si se puede extender el uso de la última cepa de peste a cualquier tipo de criaturas?', 18019),
(11279, 'esMX', 'Sin esas muestras, ¿cómo voy a saber si se puede extender el uso de la última cepa de peste a cualquier tipo de criaturas?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11279 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11279, 'esES', '¡¿Qué?! No, no puede ser.$B$B¡MALDICIÓN!$B$B¡Este lote de peste no ha tenido ningún efecto real sobre las protrocrías, solo les ha dado un brillo verde!$B$B¡Mi sueño de usar la peste contra todo con lo que entremos en contacto se ha evaporado!', 18019),
(11279, 'esMX', '¡¿Qué?! No, no puede ser.$B$B¡MALDICIÓN!$B$B¡Este lote de peste no ha tenido ningún efecto real sobre las protrocrías, solo les ha dado un brillo verde!$B$B¡Mi sueño de usar la peste contra todo con lo que entremos en contacto se ha evaporado!', 18019);

-- Draconis Gastritis - ID 11280
DELETE FROM `quest_request_items_locale` WHERE `ID`=11280 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11280, 'esES', 'Bueno, ¡fuera de aquí! ¿Funcionó nuestro pequeño experimento?$B$B¿Le gustó al proto-drake su bocadillo? ¿Se disolvió desde el interior?', 18019),
(11280, 'esMX', 'Bueno, ¡fuera de aquí! ¿Funcionó nuestro pequeño experimento?$B$B¿Le gustó al proto-drake su bocadillo? ¿Se disolvió desde el interior?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11280 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11280, 'esES', '¡¡¡NOOOOOOOOOOOOO!!!$B$B<El pesteador se pone a llorar.>$B$B¡Todas mis esperanzas, todos mis sueños arruinados!$B$BDéjame, $n. Déjame con mi desesperación. Soy un miserable.$B$BMira, también puedes llevarte todo lo que poseo. Cuando el resto de los boticarios se enteren de mi fracaso, todo se acabará y ya no lo necesitaré.', 18019),
(11280, 'esMX', '¡¡¡NOOOOOOOOOOOOO!!!$B$B<El pesteador se pone a llorar.>$B$B¡Todas mis esperanzas, todos mis sueños arruinados!$B$BDéjame, $n. Déjame con mi desesperación. Soy un miserable.$B$BMira, también puedes llevarte todo lo que poseo. Cuando el resto de los boticarios se enteren de mi fracaso, todo se acabará y ya no lo necesitaré.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Resultados de peste en protodracos observados' WHERE `ID`=11280 AND `locale` IN ('esES', 'esMX');

-- Imitando la llamada de la naturaleza - ID 11281
DELETE FROM `quest_request_items_locale` WHERE `ID`=11281 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11281, 'esES', '¿Tuviste la oportunidad de probar ese cuerno?', 18019),
(11281, 'esMX', '¿Tuviste la oportunidad de probar ese cuerno?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11281 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11281, 'esES', '<Nokoma escucha tu informe.>$B$BEs un alivio saber que el cuerno funcionase tan bien, quizás demasiado bien por lo que dices. ¿De verdad que la bestia habló? Si lo que cuentas es cierto, no sé si podremos continuar con la caza. Tendré que hablar con el cabecilla Tótem de Ceniza.$B$BEste cuerno puede acabar siendo un mero objeto de decoración, pero no por eso tendrá menos valor. Gracias por todo, $n.', 18019),
(11281, 'esMX', '<Nokoma escucha tu informe.>$B$BEs un alivio saber que el cuerno funcionase tan bien, quizás demasiado bien por lo que dices. ¿De verdad que la bestia habló? Si lo que cuentas es cierto, no sé si podremos continuar con la caza. Tendré que hablar con el cabecilla Tótem de Ceniza.$B$BEste cuerno puede acabar siendo un mero objeto de decoración, pero no por eso tendrá menos valor. Gracias por todo, $n.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Prueba el cuerno de Nokoma' WHERE `ID`=11281 AND `locale` IN ('esES', 'esMX');

-- Una lección de miedo - ID 11282
DELETE FROM `quest_request_items_locale` WHERE `ID`=11282 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11282, 'esES', '¿Mataste a los vrykuls? ¡Seguro que son duros!', 18019),
(11282, 'esMX', '¿Mataste a los vrykuls? ¡Seguro que son duros!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11282 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11282, 'esES', 'Tú hacer buenos asesinatos por allí. Veo hombres vrykuls caer y tener clavada la bandera de Sylvanas. ¡Los nuestros lo están haciendo bien!', 18019),
(11282, 'esMX', 'Tú hacer buenos asesinatos por allí. Veo hombres vrykuls caer y tener clavada la bandera de Sylvanas. ¡Los nuestros lo están haciendo bien!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Cadáver de Oric el Torvo atravesado', `ObjectiveText2`='Cadáver de Ulf el Flebotomista atravesado', `ObjectiveText3`='Cadáver de Gunnar Thorvardsson atravesado' WHERE `ID`=11282 AND `locale` IN ('esES', 'esMX');

-- Recuento de cuerpos de Baleheim - ID 11283
DELETE FROM `quest_request_items_locale` WHERE `ID`=11283 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11283, 'esES', '¿Ya has terminado con los asesinatos? ¡El pueblo de Winterskorn está justo enfrente!', 18019),
(11283, 'esMX', '¿Ya has terminado con los asesinatos? ¡El pueblo de Winterskorn está justo enfrente!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11283 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11283, 'esES', 'Debes de tener un montón de práctica con los asesinatos. ¡Tú casi tan bueno como Gorth!', 18019),
(11283, 'esMX', 'Debes de tener un montón de práctica con los asesinatos. ¡Tú casi tan bueno como Gorth!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Recuento de cuerpos de Baleheim' WHERE `ID`=11283 AND `locale` IN ('esES', 'esMX');

-- ¡Baleheim debe arder! - ID 11285
DELETE FROM `quest_request_items_locale` WHERE `ID`=11285 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11285, 'esES', '¿Has terminado de quemar todo? Asegúrate de no dejar nada sin quemar.', 18019),
(11285, 'esMX', '¿Has terminado de quemar todo? Asegúrate de no dejar nada sin quemar.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11285 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11285, 'esES', 'Supongo que lo quemaste todo. Veo un par de puntos que no arden... Pero Gorth está casi satisfecho.', 18019),
(11285, 'esMX', 'Supongo que lo quemaste todo. Veo un par de puntos que no arden... Pero Gorth está casi satisfecho.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Morada Inbjerskorn quemada', `ObjectiveText2`='Torre de observación Inbjerskorn quemada', `ObjectiveText3`='Puente Inbjerskorn quemado', `ObjectiveText4`='Barraca Inbjerskorn quemada' WHERE `ID`=11285 AND `locale` IN ('esES', 'esMX');

-- Los artefactos de Las Puertas de Acero - ID 11286
DELETE FROM `quest_request_items_locale` WHERE `ID`=11286 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11286, 'esES', '¿Cuántos artefactos has conseguido en Las Puertas de Acero?', 18019),
(11286, 'esMX', '¿Cuántos artefactos has conseguido en Las Puertas de Acero?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11286 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11286, 'esES', '<El sabio gruñe su aprobación ante los actos que has llevado a cabo de su parte.>$B$BPuede que pronto tenga tiempo de estudiar estos artefactos para comprender su importancia.$B$BPero ahora hay asuntos más urgentes que atender.', 18019),
(11286, 'esMX', '<El sabio gruñe su aprobación ante los actos que has llevado a cabo de su parte.>$B$BPuede que pronto tenga tiempo de estudiar estos artefactos para comprender su importancia.$B$BPero ahora hay asuntos más urgentes que atender.', 18019);

-- Encuentra al sabio Caminaniebla - ID 11287
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11287 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11287, 'esES', 'Mi madre no debería preocuparse tanto por mi seguridad, pero te agradezco que hayas venido, forastera.$B$BYa que estás aquí, quizás podrías ayudarme con unas cosillas.', 18019),
(11287, 'esMX', 'Mi madre no debería preocuparse tanto por mi seguridad, pero te agradezco que hayas venido, forastera.$B$BYa que estás aquí, quizás podrías ayudarme con unas cosillas.', 18019);

-- La ofensiva comienza - ID 11295
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11295 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11295, 'esES', '¿Vienes a ayudarnos? Bien, bien...$B$BGorth ya se estaba hartando de matar vrykuls todo el día. ¡Cualquier ayuda es bienvenida!', 18019),
(11295, 'esMX', '¿Vienes a ayudarnos? Bien, bien...$B$BGorth ya se estaba hartando de matar vrykuls todo el día. ¡Cualquier ayuda es bienvenida!', 18019);

-- Cautivos de El Bosque Hendido - ID 11296
DELETE FROM `quest_request_items_locale` WHERE `ID`=11296 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11296, 'esES', 'Mantengo la esperanza de que mi fuerza de caza siga viva.$B$BLa picadura de las viudas tarda en ser mortal. Les gusta mantener a sus víctimas con vida el tiempo suficiente para que sus crías puedan atiborrarse cuando salgan del cascarón.', 18019),
(11296, 'esMX', 'Mantengo la esperanza de que mi fuerza de caza siga viva.$B$BLa picadura de las viudas tarda en ser mortal. Les gusta mantener a sus víctimas con vida el tiempo suficiente para que sus crías puedan atiborrarse cuando salgan del cascarón.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11296 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11296, 'esES', 'Has sido muy valiente, $c. No sabía que tu pueblo fuera capaz de tal muestra de altruismo.$B$BLa próxima vez haré caso de las advertencias de mis mayores y me alejaré de El Bosque Hendido. Te aconsejo que hagas lo mismo.', 18019),
(11296, 'esMX', 'Has sido muy valiente, $c. No sabía que tu pueblo fuera capaz de tal muestra de altruismo.$B$BLa próxima vez haré caso de las advertencias de mis mayores y me alejaré de El Bosque Hendido. Te aconsejo que hagas lo mismo.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Enviado Pezuña Invernal liberado' WHERE `ID`=11296 AND `locale` IN ('esES', 'esMX');

-- Observando de cerca a los intrusos - ID 11297
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11297 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11297, 'esES', 'Ah, sí, los hombres bisonte del norte. Los he visto merodear, se creen que nadie los ve. Supongo que se imaginan que estas tierras son suyas. Bueno, pues esa es una de las muchas cosas que van a cambiar dentro de poco.$B$BNo esperaba tener compañía, pero ya que estás aquí por órdenes de ese sujeto, puedes sernos útil.', 18019),
(11297, 'esMX', 'Ah, sí, los hombres bisonte del norte. Los he visto merodear, se creen que nadie los ve. Supongo que se imaginan que estas tierras son suyas. Bueno, pues esa es una de las muchas cosas que van a cambiar dentro de poco.$B$BNo esperaba tener compañía, pero ya que estás aquí por órdenes de ese sujeto, puedes sernos útil.', 18019);

-- ¿Qué lleva esa bebida? - ID 11298
DELETE FROM `quest_request_items_locale` WHERE `ID`=11298 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11298, 'esES', '¿Has conseguido los barriles o no?', 18019),
(11298, 'esMX', '¿Has conseguido los barriles o no?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11298 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11298, 'esES', '<El boticario se sirve una jarra de la bebida.>$B$BBueno, ¡allá voy!', 18019),
(11298, 'esMX', '<El boticario se sirve una jarra de la bebida.>$B$BBueno, ¡allá voy!', 18019);

-- ¡Cerebros! ¡Cerebros! ¡Cerebros! - ID 11301
DELETE FROM `quest_request_items_locale` WHERE `ID`=11301 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11301, 'esES', '¿Has conseguido esos cerebros? Si no es así, devuélveme mi sierra. No deberías ir por ahí con ella.', 18019),
(11301, 'esMX', '¿Has conseguido esos cerebros? Si no es así, devuélveme mi sierra. No deberías ir por ahí con ella.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11301 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11301, 'esES', '¡Qué cerebros tan bonitos! Diría incluso que son preciosos. Son exactamente lo que quería.$B$BGracias por todo, $n. Ahora haré que Malthus vea la verdad que esas gafas de cerveza que tiene no son capaces de mostrarle.', 18019),
(11301, 'esMX', '¡Qué cerebros tan bonitos! Diría incluso que son preciosos. Son exactamente lo que quería.$B$BGracias por todo, $n. Ahora haré que Malthus vea la verdad que esas gafas de cerveza que tiene no son capaces de mostrarle.', 18019);

-- La emboscada - ID 11303
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11303 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11303, 'esES', 'Todos fuimos a la fiesta, pero el invitado de honor se quedó en casa.', 18019),
(11303, 'esMX', 'Todos fuimos a la fiesta, pero el invitado de honor se quedó en casa.', 18019);

-- Nuevo Agamand - ID 11304
DELETE FROM `quest_request_items_locale` WHERE `ID`=11304 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11304, 'esES', '¿Sí, $n?', 18019),
(11304, 'esMX', '¿Sí, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11304 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11304, 'esES', '¡Esta cepa no es inservible, ni mucho menos! ¡Esos insensatos de Campo Venganza tenían todas las respuestas delante de sus narices!', 18019),
(11304, 'esMX', '¡Esta cepa no es inservible, ni mucho menos! ¡Esos insensatos de Campo Venganza tenían todas las respuestas delante de sus narices!', 18019);

-- Una fórmula hecha a medida - ID 11305
DELETE FROM `quest_request_items_locale` WHERE `ID`=11305 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11305, 'esES', '¿Has conseguido la muestra que necesito, $n?', 18019),
(11305, 'esMX', '¿Has conseguido la muestra que necesito, $n?', 18019);

-- Una fórmula hecha a medida - ID 11305
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11305 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11305, 'esES', 'Esta servirá. ¡Ya es hora de ponerse con un verdadero trabajo de boticario, $n!', 18019),
(11305, 'esMX', 'Esta servirá. ¡Ya es hora de ponerse con un verdadero trabajo de boticario, $n!', 18019);

-- Calentar y remover - ID 11306
DELETE FROM `quest_request_items_locale` WHERE `ID`=11306 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11306, 'esES', '¿Qué tal va tu experimento, $n? ¡Si tienes alguna pregunta técnica sobre el tema, no dudes en consultarme!', 18019),
(11306, 'esMX', '¿Qué tal va tu experimento, $n? ¡Si tienes alguna pregunta técnica sobre el tema, no dudes en consultarme!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11306 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11306, 'esES', '¡Excelente! Eres un pupilo apto, $n.$B$BY ahora llega lo divertido. ¡Hay que usarlo!', 18019),
(11306, 'esMX', '¡Excelente! Eres un pupilo apto, $n.$B$BY ahora llega lo divertido. ¡Hay que usarlo!', 18019);

-- Ensayo de campo - ID 11307
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11307 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11307, 'esES', '¿La peste no desintegró a nuestros sujetos? ¿Es eso cierto, $n?$B$BTiene que haber algún factor externo que se nos haya pasado por alto... ¿quizás las bajas temperaturas de este clima? Quizá... ¡una mutación de la cepa!', 18019),
(11307, 'esMX', '¿La peste no desintegró a nuestros sujetos? ¿Es eso cierto, $n?$B$BTiene que haber algún factor externo que se nos haya pasado por alto... ¿quizás las bajas temperaturas de este clima? Quizá... ¡una mutación de la cepa!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Vrykuls apestados pulverizados' WHERE `ID`=11307 AND `locale` IN ('esES', 'esMX');

-- Es hora de limpiar - ID 11308
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11308 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11308, 'esES', '¿Qué quieres? ¿No ves que tengo cosas que hacer?', 18019),
(11308, 'esMX', '¿Qué quieres? ¿No ves que tengo cosas que hacer?', 18019);

-- Partes para el trabajo - ID 11309
DELETE FROM `quest_request_items_locale` WHERE `ID`=11309 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11309, 'esES', '¿Ya tienes mis componentes?', 18019),
(11309, 'esMX', '¿Ya tienes mis componentes?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11309 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11309, 'esES', '¡Excelente! ¡Sí, sí, estos servirán!', 18019),
(11309, 'esMX', '¡Excelente! ¡Sí, sí, estos servirán!', 18019);

-- Aviso: Requiere montaje - ID 11310
DELETE FROM `quest_request_items_locale` WHERE `ID`=11310 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11310, 'esES', '¿Has terminado con la limpieza en Halgrind?', 18019),
(11310, 'esMX', '¿Has terminado con la limpieza en Halgrind?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11310 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11310, 'esES', 'Buen trabajo, $n. Dime, ¿no estás buscando algo más... estable, verdad? ¡Me vendría muy bien algo de ayuda por aquí!', 18019),
(11310, 'esMX', 'Buen trabajo, $n. Dime, ¿no estás buscando algo más... estable, verdad? ¡Me vendría muy bien algo de ayuda por aquí!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Vrykul apestado exterminado' WHERE `ID`=11310 AND `locale` IN ('esES', 'esMX');

-- Dar muerte a los elementos - ID 11311
DELETE FROM `quest_request_items_locale` WHERE `ID`=11311 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11311, 'esES', '¿Has eliminado a los elementales?', 18019),
(11311, 'esMX', '¿Has eliminado a los elementales?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11311 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11311, 'esES', 'La influencia de los espíritus elementales se ha desvanecido, pero regresará. Hemos ganado el tiempo necesario para completar nuestras tareas aquí y marcharnos.', 18019),
(11311, 'esMX', 'La influencia de los espíritus elementales se ha desvanecido, pero regresará. Hemos ganado el tiempo necesario para completar nuestras tareas aquí y marcharnos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Elementales de montaña asesinados' WHERE `ID`=11311 AND `locale` IN ('esES', 'esMX');

-- El Claro Helado - ID 11312
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11312 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11312, 'esES', '<Lurielle te escucha mientras te presentas.>$B$BMe alegro de conocerte, $c. Mis hermanas han observado a menudo cómo los taunka nos buscaban por el bosque, pero nuestra reina nos ha prohibido que interactuemos con extraños. Tan solo puedes vernos porque la tierra ha sido alterada y muchas de mis hermanas están en peligro.', 18019),
(11312, 'esMX', '<Lurielle te escucha mientras te presentas.>$B$BMe alegro de conocerte, $c. Mis hermanas han observado a menudo cómo los taunka nos buscaban por el bosque, pero nuestra reina nos ha prohibido que interactuemos con extraños. Tan solo puedes vernos porque la tierra ha sido alterada y muchas de mis hermanas están en peligro.', 18019);

-- La limpieza - ID 11317
DELETE FROM `quest_request_items_locale` WHERE `ID`=11317 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11317, 'esES', '¿Has encontrado la paz interior en el santuario? ¿Ha desaparecido tu agitación?', 18019),
(11317, 'esMX', '¿Has encontrado la paz interior en el santuario? ¿Ha desaparecido tu agitación?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11317 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11317, 'esES', 'Ya puedo notar el cambio en ti.$B$B¿Estás preparado para continuar?', 18019),
(11317, 'esMX', 'Ya puedo notar el cambio en ti.$B$B¿Estás preparado para continuar?', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Limpiar tu conflicto interior' WHERE `ID`=11317 AND `locale` IN ('esES', 'esMX');

-- En el pellejo de un huargo - ID 11323
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11323 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11323, 'esES', 'Hueles y tienes un aspecto diferente... tú no eres de mi manada. Cuéntame tu historia, tiempo es lo único que me sobra mientras estoy aquí atrapado.', 18019),
(11323, 'esMX', 'Hueles y tienes un aspecto diferente... tú no eres de mi manada. Cuéntame tu historia, tiempo es lo único que me sobra mientras estoy aquí atrapado.', 18019);

-- Huargo alfa - ID 11324
DELETE FROM `quest_request_items_locale` WHERE `ID`=11324 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11324, 'esES', '$n, has vuelto. ¿Qué noticias me traes de Ulkang?', 18019),
(11324, 'esMX', '$n, has vuelto. ¿Qué noticias me traes de Ulkang?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11324 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11324, 'esES', '¡Garwal no era un huargo! Conozco a esas criaturas... Reciben el nombre de huargen.$B$BPero, ¿Ulkang dijo que provenía del sur de las Colinas Pardas? Qué raro, allí no hay huargen.$B$BGracias por ayudar a devolver a Ulkang el puesto que merece entre los suyos. Ahora los dos podremos dormir tranquilos.$B$BPor favor, acepta esto como muestra de mi gratitud.', 18019),
(11324, 'esMX', '¡Garwal no era un huargo! Conozco a esas criaturas... Reciben el nombre de huargen.$B$BPero, ¿Ulkang dijo que provenía del sur de las Colinas Pardas? Qué raro, allí no hay huargen.$B$BGracias por ayudar a devolver a Ulkang el puesto que merece entre los suyos. Ahora los dos podremos dormir tranquilos.$B$BPor favor, acepta esto como muestra de mi gratitud.', 18019);

-- El libro de las Runas - ID 11350
DELETE FROM `quest_request_items_locale` WHERE `ID`=11350 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11350, 'esES', '¿Has recuperado el libro?', 18019),
(11350, 'esMX', '¿Has recuperado el libro?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11350 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11350, 'esES', '<El enviado hojea el libro de las Runas.>$B$BNo es que sea un experto en letras, pero sí conozco un poco el lenguaje de los enanos férreos. Creo que las runas que están inscribiendo en los gigantes provienen de su habla pero hay algunas diferencias.', 18019),
(11350, 'esMX', '<El enviado hojea el libro de las Runas.>$B$BNo es que sea un experto en letras, pero sí conozco un poco el lenguaje de los enanos férreos. Creo que las runas que están inscribiendo en los gigantes provienen de su habla pero hay algunas diferencias.', 18019);

-- Dominar las runas - ID 11351
DELETE FROM `quest_request_items_locale` WHERE `ID`=11351 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11351, 'esES', '¿Has regresado con esas herramientas?', 18019),
(11351, 'esMX', '¿Has regresado con esas herramientas?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11351 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11351, 'esES', '<Pembe examina las herramientas.>$B$BSon más delicadas de lo que pensaba. Dame un momento para que las pruebe.', 18019),
(11351, 'esMX', '<Pembe examina las herramientas.>$B$BSon más delicadas de lo que pensaba. Dame un momento para que las pruebe.', 18019);

-- La runa de mando - ID 11352
DELETE FROM `quest_request_items_locale` WHERE `ID`=11352 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11352, 'esES', '¿Has probado la runa?', 18019),
(11352, 'esMX', '¿Has probado la runa?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11352 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11352, 'esES', 'Has estado genial al derrotar al vinculador Murdis, pero los enanos férreos no se rendirán fácilmente.$B$BA medida que mi gente avance hacia el Norte, seguro que volveremos a encontrar enanos férreos. La próxima vez estaremos preparados para acabar con ellos antes de que puedan atrincherarse.', 18019),
(11352, 'esMX', 'Has estado genial al derrotar al vinculador Murdis, pero los enanos férreos no se rendirán fácilmente.$B$BA medida que mi gente avance hacia el Norte, seguro que volveremos a encontrar enanos férreos. La próxima vez estaremos preparados para acabar con ellos antes de que puedan atrincherarse.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Probar runa de mando', `ObjectiveText2`='Vinculador Murdis' WHERE `ID`=11352 AND `locale` IN ('esES', 'esMX');

-- La marcha de los gigantes - ID 11365
DELETE FROM `quest_request_items_locale` WHERE `ID`=11365 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11365, 'esES', '¿Qué has encontrado?', 18019),
(11365, 'esMX', '¿Qué has encontrado?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11365 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11365, 'esES', '<El sabio te escucha.>$B$B¿Las runas que representan "norte" y "oeste" aparecían repetidas veces? No soy experto en estas runas, pero tanta repetición sugiere una orden estricta.$B$BEstos grabados son algo más que meras indicaciones. Parecen empujar a los gigantes a algo, ¿pero a qué?', 18019),
(11365, 'esMX', '<El sabio te escucha.>$B$B¿Las runas que representan "norte" y "oeste" aparecían repetidas veces? No soy experto en estas runas, pero tanta repetición sugiere una orden estricta.$B$BEstos grabados son algo más que meras indicaciones. Parecen empujar a los gigantes a algo, ¿pero a qué?', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Cuerpo de gigante de piedra con runas analizado' WHERE `ID`=11365 AND `locale` IN ('esES', 'esMX');

-- La magnetita - ID 11366
DELETE FROM `quest_request_items_locale` WHERE `ID`=11366 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11366, 'esES', '¿Has descubierto qué piedra de toque atrae a los gigantes?', 18019),
(11366, 'esMX', '¿Has descubierto qué piedra de toque atrae a los gigantes?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11366 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11366, 'esES', '<Edan te escucha mientras explicas lo que has descubierto.>$B$B¿Megalito? ¡Una trascripción literal de la tablilla! Ese Megalito tiene que ser la motriz de los misteriosos planes de esos férreos.', 18019),
(11366, 'esMX', '<Edan te escucha mientras explicas lo que has descubierto.>$B$B¿Megalito? ¡Una trascripción literal de la tablilla! Ese Megalito tiene que ser la motriz de los misteriosos planes de esos férreos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Comparar runas con la tablilla rota' WHERE `ID`=11366 AND `locale` IN ('esES', 'esMX');

-- Destruyendo a Megalito - ID 11367
DELETE FROM `quest_request_items_locale` WHERE `ID`=11367 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11367, 'esES', '¿Traes noticias de la caída de Megalito?', 18019),
(11367, 'esMX', '¿Traes noticias de la caída de Megalito?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11367 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11367, 'esES', 'Has hecho un gran trabajo matando a Megalito, pero me pregunto qué querrán decir sus últimas palabras.$B$B¿Estás segura de que dijo Forja de Piedra?$B$BNo es un nombre con el que estemos muy familiarizados, pero suena a creación de esos "titanes" de los que hablan los foráneos. Los enanos férreos han llegado a ser enemigos demasiado astutos y peligrosos, $n. Debemos vigilar de cerca a esos gigantes y encontrar la tal Forja de Piedra antes de que puedan llevar a cabo sus planes.', 18019),
(11367, 'esMX', 'Has hecho un gran trabajo matando a Megalito, pero me pregunto qué querrán decir sus últimas palabras.$B$B¿Estás segura de que dijo Forja de Piedra?$B$BNo es un nombre con el que estemos muy familiarizados, pero suena a creación de esos "titanes" de los que hablan los foráneos. Los enanos férreos han llegado a ser enemigos demasiado astutos y peligrosos, $n. Debemos vigilar de cerca a esos gigantes y encontrar la tal Forja de Piedra antes de que puedan llevar a cabo sus planes.', 18019);

-- ¡Y tú que pensabas que los múrlocs olían mal! - ID 11397
DELETE FROM `quest_request_items_locale` WHERE `ID`=11397 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11397, 'esES', 'Es interesante, la última vez que miré no parecía que hubieras destruido suficientes. ¿Tal vez podrías redoblar tus esfuerzos?', 18019),
(11397, 'esMX', 'Es interesante, la última vez que miré no parecía que hubieras destruido suficientes. ¿Tal vez podrías redoblar tus esfuerzos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11397 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11397, 'esES', '<Anastasia considera tu éxito durante un instante.>$B$BUn trabajo satisfactorio, para ser exactos, aunque tengo la sensación de que hay algo más que deberíamos hacer para frenar los esfuerzos de la Plaga en esa playa.', 18019),
(11397, 'esMX', '<Anastasia considera tu éxito durante un instante.>$B$BUn trabajo satisfactorio, para ser exactos, aunque tengo la sensación de que hay algo más que deberíamos hacer para frenar los esfuerzos de la Plaga en esa playa.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Miembro de la Plaga de Costafría muerto' WHERE `ID`=11397 AND `locale` IN ('esES', 'esMX');

-- Es un artefacto de la Plaga - ID 11398
DELETE FROM `quest_request_items_locale` WHERE `ID`=11398 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11398, 'esES', '¿Qué escondes ahí, $c? ¡Déjame verlo!', 18019),
(11398, 'esMX', '¿Qué escondes ahí, $c? ¡Déjame verlo!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11398 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11398, 'esES', 'Puedo decirte lo que es esto, $n. ¡Es un artefacto para controlar aquellos cristales apestadores!$B$BMe apuesto lo que sea a que puede usarse para cerrar sus campos de fuerza. Mmm...', 18019),
(11398, 'esMX', 'Puedo decirte lo que es esto, $n. ¡Es un artefacto para controlar aquellos cristales apestadores!$B$BMe apuesto lo que sea a que puede usarse para cerrar sus campos de fuerza. Mmm...', 18019);

-- Derriba esos escudos - ID 11399
DELETE FROM `quest_request_items_locale` WHERE `ID`=11399 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11399, 'esES', 'Todavía no has destruido suficientes cristales de flagelación. No hay recompensa hasta que lo hagas.', 18019),
(11399, 'esMX', 'Todavía no has destruido suficientes cristales de flagelación. No hay recompensa hasta que lo hagas.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11399 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11399, 'esES', '<Anastasia se gira y sonríe a su súcubo.>$B$BMuy bien, $n, debo admitir que mereces con creces uno de estos.', 18019),
(11399, 'esMX', '<Anastasia se gira y sonríe a su súcubo.>$B$BMuy bien, $n, debo admitir que mereces con creces uno de estos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Cristales apestadores destruidos' WHERE `ID`=11399 AND `locale` IN ('esES', 'esMX');

-- Campamento Pezuña Invernal - ID 11411
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11411 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11411, 'esES', '<El cacique escucha mientras te presentas.>$B$BSoy el cacique Ashtotem, y mi pueblo es el taunka, y hablaré con sinceridad, forastero. Entre mi gente, la confianza se gana, no se da. Tienes mi permiso para caminar entre ellos y ofrecer tu ayuda. El tiempo apremia y algunos de ellos agradecerán la ayuda de un forastero en sus preparativos.', 18019),
(11411, 'esMX', '<El cacique escucha mientras te presentas.>$B$BSoy el cacique Ashtotem, y mi pueblo es el taunka, y hablaré con sinceridad, forastero. Entre mi gente, la confianza se gana, no se da. Tienes mi permiso para caminar entre ellos y ofrecer tu ayuda. El tiempo apremia y algunos de ellos agradecerán la ayuda de un forastero en sus preparativos.', 18019);

-- Hermanos traicioneros - ID 11415
DELETE FROM `quest_request_items_locale` WHERE `ID`=11415 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11415, 'esES', '<Un gruñido grave surge de la garganta de Ulfang.>$B$B¡Bjomolf y Varg no están muertos!', 18019),
(11415, 'esMX', '<Un gruñido grave surge de la garganta de Ulfang.>$B$B¡Bjomolf y Varg no están muertos!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11415 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11415, 'esES', 'Me gusta el olor de su sangre sobre tu hocico. Los hermanos no deberían darse la espalda.', 18019),
(11415, 'esMX', 'Me gusta el olor de su sangre sobre tu hocico. Los hermanos no deberían darse la espalda.', 18019);

-- Los ojos del Águila - ID 11417
DELETE FROM `quest_request_items_locale` WHERE `ID`=11417 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11417, 'esES', '¿Tienes los ojos del Águila?', 18019),
(11417, 'esMX', '¿Tienes los ojos del Águila?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11417 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11417, 'esES', '<Ulkang aúlla con fuerza por la derrota de su gran enemiga.>$B$BEl honor de su muerte es tuyo. Me habría gustado que hubiesen sido mis fauces las que le apretaran la yugular.$B$BNo desperdiciemos el sacrificio que ha hecho por nosotros. Toma, ¡come!', 18019),
(11417, 'esMX', '<Ulkang aúlla con fuerza por la derrota de su gran enemiga.>$B$BEl honor de su muerte es tuyo. Me habría gustado que hubiesen sido mis fauces las que le apretaran la yugular.$B$BNo desperdiciemos el sacrificio que ha hecho por nosotros. Toma, ¡come!', 18019);

-- El legado del enemigo - ID 11423
DELETE FROM `quest_request_items_locale` WHERE `ID`=11423 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11423, 'esES', '¿Los pergaminos, $n? ¿Los has conseguido?', 18019),
(11423, 'esMX', '¿Los pergaminos, $n? ¿Los has conseguido?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11423 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11423, 'esES', 'Esto tiene un valor tremendo, $n, he de reanudar mis esfuerzos para recuperar y traducir textos vrykuls.$B$BNo me malinterpretes. Nuestros enemigos han de ser destruidos... su conocimiento ancestral no.', 18019),
(11423, 'esMX', 'Esto tiene un valor tremendo, $n, he de reanudar mis esfuerzos para recuperar y traducir textos vrykuls.$B$BNo me malinterpretes. Nuestros enemigos han de ser destruidos... su conocimiento ancestral no.', 18019);

-- Colina Escudo - ID 11424
DELETE FROM `quest_request_items_locale` WHERE `ID`=11424 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11424, 'esES', 'Entonces, ¿tienes mis huesos?', 18019),
(11424, 'esMX', 'Entonces, ¿tienes mis huesos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11424 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11424, 'esES', 'Huumm... Estos servirán por ahora. Pero los veo algo raros.$B$BTe diré algo: he tratado partes del cuerpo durante años y jamás había tenido una sensación tan rara en el estómago. Pero bueno, un trato es un trato. Aquí tienes tu recompensa.', 18019),
(11424, 'esMX', 'Huumm... Estos servirán por ahora. Pero los veo algo raros.$B$BTe diré algo: he tratado partes del cuerpo durante años y jamás había tenido una sensación tan rara en el estómago. Pero bueno, un trato es un trato. Aquí tienes tu recompensa.', 18019);

-- Gigantes durmientes - ID 11433
DELETE FROM `quest_request_items_locale` WHERE `ID`=11433 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11433, 'esES', 'Me parece que no has tratado lo suficiente con el vrykul inactivo. Vuelve cuando lo hayas hecho.', 18019),
(11433, 'esMX', 'Me parece que no has tratado lo suficiente con el vrykul inactivo. Vuelve cuando lo hayas hecho.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11433 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11433, 'esES', 'Has hecho lo que había que hacer. Algunos imprudentes consideran deshonroso matar a los indefensos recién despiertos, pero en este caso habrías estado loco si no lo hubieras hecho.$B$BY, por supuesto, no podríamos haberlos dejado allí para que despertaran mediante el ritual, ¿no es cierto?$B$BEs muy valiente lo que has hecho por todos nosotros en esas catacumbas, orco.', 18019),
(11433, 'esMX', 'Has hecho lo que había que hacer. Algunos imprudentes consideran deshonroso matar a los indefensos recién despiertos, pero en este caso habrías estado loco si no lo hubieras hecho.$B$BY, por supuesto, no podríamos haberlos dejado allí para que despertaran mediante el ritual, ¿no es cierto?$B$BEs muy valiente lo que has hecho por todos nosotros en esas catacumbas, orco.', 18019);

-- El rey durmiente - ID 11453
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11453 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11453, 'esES', 'No sé si me acaba de gustar cómo suena eso. El Rey Exánime dándose a la fuga con Ymiron solo puede traernos problemas. Qué pena que no pudieras matarlo igual que hiciste con su reina.$B$BSin embargo, has puesto trabas a sus planes y nos has dado un tiempo precioso que necesitábamos.$B$BY, quién sabe, con esa facilidad que tienes para moverte por aquí, seguro que te vuelves a topar con el rey Ymiron. Seguro que no le va tan bien cuando volváis a encontraros.', 18019),
(11453, 'esMX', 'No sé si me acaba de gustar cómo suena eso. El Rey Exánime dándose a la fuga con Ymiron solo puede traernos problemas. Qué pena que no pudieras matarlo igual que hiciste con su reina.$B$BSin embargo, has puesto trabas a sus planes y nos has dado un tiempo precioso que necesitábamos.$B$BY, quién sabe, con esa facilidad que tienes para moverte por aquí, seguro que te vuelves a topar con el rey Ymiron. Seguro que no le va tan bien cuando volváis a encontraros.', 18019);

-- Ponle un nombre - ID 12181
DELETE FROM `quest_request_items_locale` WHERE `ID`=12181 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12181, 'esES', '¿Una entrega de gas venenoso y letal hasta Rencor Venenoso? ¡Sube!', 18019),
(12181, 'esMX', '¿Una entrega de gas venenoso y letal hasta Rencor Venenoso? ¡Sube!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12181 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12181, 'esES', 'Claro, claro, adelante, y cuida bien ese vial, amigo. Confío en ti.', 18019),
(12181, 'esMX', 'Claro, claro, adelante, y cuida bien ese vial, amigo. Confío en ti.', 18019);

-- Eres un... Y un... Y además... - ID 12481
DELETE FROM `quest_request_items_locale` WHERE `ID`=12481 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12481, 'esES', 'El trabajo de asesinato no es tan glamuroso como lo pintan.', 18019),
(12481, 'esMX', 'El trabajo de asesinato no es tan glamuroso como lo pintan.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12481 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12481, 'esES', 'Buen trabajo. Ese pobre inocente nunca se lo vio venir.', 18019),
(12481, 'esMX', 'Buen trabajo. Ese pobre inocente nunca se lo vio venir.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Bjorn Halgurdsson insultado', `ObjectiveText2`='Bjorn Halgurdsson derrotado' WHERE `ID`=12481 AND `locale` IN ('esES', 'esMX');

-- Contra Nafsavar - ID 12482
DELETE FROM `quest_request_items_locale` WHERE `ID`=12482 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12482, 'esES', 'Salve, $n.', 18019),
(12482, 'esMX', 'Salve, $n.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12482 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12482, 'esES', 'Un trabajo excelente, $n. Cuando lleguen nuestras fuerzas de Campo Venganza, podré ocuparme de los vrykuls que queden.', 18019),
(12482, 'esMX', 'Un trabajo excelente, $n. Cuando lleguen nuestras fuerzas de Campo Venganza, podré ocuparme de los vrykuls que queden.', 18019);

-- Ayuda para el Campamento Pezuña Invernal - ID 12566
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12566 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12566, 'esES', '¿Entonces Nanik ha encontrado ayuda? Dime, $n, ¿cómo conseguiste llegar hasta aquí sin él? Nadie conoce mejor estas tierra que los taunka.', 18019),
(12566, 'esMX', '¿Entonces Nanik ha encontrado ayuda? Dime, $n, ¿cómo conseguiste llegar hasta aquí sin él? Nadie conoce mejor estas tierra que los taunka.', 18019);

-- Rompe el bloqueo - ID 11153
DELETE FROM `quest_request_items_locale` WHERE `ID`=11153 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11153, 'esES', 'Estamos hablando de nuevo, ¿verdad? ¡Eso debe significar que lo has hecho! ¡Les has enseñado a esos podridos piratas del bloqueo un par de cosas!$B$B¿No es así?', 18019),
(11153, 'esMX', 'Estamos hablando de nuevo, ¿verdad? ¡Eso debe significar que lo has hecho! ¡Les has enseñado a esos podridos piratas del bloqueo un par de cosas!$B$B¿No es así?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11153 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11153, 'esES', '¡Eso es lo que quería oír! Tienes lo que hace falta, $n, ¡sin duda!$B$B¿Crees que podrías volver mañana cuando hayamos fabricado más bombas de racimo? Te sacaría ahí ahora mismo, pero mi asistente, Feknut, aún no ha vuelto con más guano de murciélago.$B$B¿Por qué tardará tanto?', 18019),
(11153, 'esMX', '¡Eso es lo que quería oír! Tienes lo que hace falta, $n, ¡sin duda!$B$B¿Crees que podrías volver mañana cuando hayamos fabricado más bombas de racimo? Te sacaría ahí ahora mismo, pero mi asistente, Feknut, aún no ha vuelto con más guano de murciélago.$B$B¿Por qué tardará tanto?', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Pirata del bloqueo', `ObjectiveText2`='Cañones del bloqueo destruidos' WHERE `ID`=11153 AND `locale` IN ('esES', 'esMX');

-- ¡Dales un susto de guano! - ID 11154
DELETE FROM `quest_request_items_locale` WHERE `ID`=11154 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11154, 'esES', '¡¡Dime que has conseguido el guano de los Garranegra!!', 18019),
(11154, 'esMX', '¡¡Dime que has conseguido el guano de los Garranegra!!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11154 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11154, 'esES', 'Ugh, ¿y ese olor? Puaj, ¡eres tú! ¡Bueno, supongo que la tarea que te mandé apestaba!$B$BGracias, $c. No te preocupes, le entregaré esto a Petrov en cuanto salgamos de aquí.$B$B¿Han oído, amigos? ¡¡¡Salgamos de aquí ahora mismo!!!', 18019),
(11154, 'esMX', 'Ugh, ¿y ese olor? Puaj, ¡eres tú! ¡Bueno, supongo que la tarea que te mandé apestaba!$B$BGracias, $c. No te preocupes, le entregaré esto a Petrov en cuanto salgamos de aquí.$B$B¿Han oído, amigos? ¡¡¡Salgamos de aquí ahora mismo!!!', 18019);

-- ¿Sopa de colmipala otra vez? - ID 11155
DELETE FROM `quest_request_items_locale` WHERE `ID`=11155 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11155, 'esES', '¡No hay nada más suntuoso que la tierna carne sacada del costado de un colmipala!', 18019),
(11155, 'esMX', '¡No hay nada más suntuoso que la tierna carne sacada del costado de un colmipala!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11155 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11155, 'esES', 'Con esto conseguiré preparar un buen almuerzo para los muchachos.$B$B<La chef se acerca para susurrarte al oído.>$B$BEh, chico, coge algo para ti. ¡Me parece que no te vendría mal meter más carne en tus huesos!', 18019),
(11155, 'esMX', 'Con esto conseguiré preparar un buen almuerzo para los muchachos.$B$B<La chef se acerca para susurrarte al oído.>$B$BEh, chico, coge algo para ti. ¡Me parece que no te vendría mal meter más carne en tus huesos!', 18019);

-- Las garras del mal - ID 11157
DELETE FROM `quest_request_items_locale` WHERE `ID`=11157 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11157, 'esES', '¿Cómo van tus esfuerzos?', 18019),
(11157, 'esMX', '¿Cómo van tus esfuerzos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11157 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11157, 'esES', '¡Buen trabajo! Si tenemos suerte, la destrucción de sus huevos y de sus crías hará que esas ardientes bestias se marchen y evitará que ese fuego mágico se extienda.$B$BEspera... ¿Qué es ese ruido? Parece el batir de unas alas...', 18019),
(11157, 'esMX', '¡Buen trabajo! Si tenemos suerte, la destrucción de sus huevos y de sus crías hará que esas ardientes bestias se marchen y evitará que ese fuego mágico se extienda.$B$BEspera... ¿Qué es ese ruido? Parece el batir de unas alas...', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Huevo de protodraco destruido', `ObjectiveText2`='Protocría' WHERE `ID`=11157 AND `locale` IN ('esES', 'esMX');

-- Mi hija - ID 11175
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11175 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11175, 'esES', 'Grrr. ¡Lo sabía! ¡Es demasiado protector! Esto es muy embarazoso.$B$BNo es que no me alegre de verte... al contrario. Todos nos alegramos. ¡Tu ayuda nos vendría bien!', 18019),
(11175, 'esMX', 'Grrr. ¡Lo sabía! ¡Es demasiado protector! Esto es muy embarazoso.$B$BNo es que no me alegre de verte... al contrario. Todos nos alegramos. ¡Tu ayuda nos vendría bien!', 18019);

-- Supervisa el trabajo - ID 11176
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11176 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11176, 'esES', 'Irena te mandó aquí, ¿no es cierto? Bien, ¡entonces tenemos trabajo para ti!', 18019),
(11176, 'esMX', 'Irena te mandó aquí, ¿no es cierto? Bien, ¡entonces tenemos trabajo para ti!', 18019);

-- Teniente mago Malister - ID 11187
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11187 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11187, 'esES', '<Malister te hace una señal para que te acerques y habla susurrando.>$B$BMe preocupaba que ocurriese algo así. Intenté disuadir al capitán de tomar esta decisión, pero es un enano de acción y no es fácil hacerle cambiar su idea de cómo deben hacerse las cosas.$B$BHablemos de las opciones que nos quedan.', 18019),
(11187, 'esMX', '<Malister te hace una señal para que te acerques y habla susurrando.>$B$BMe preocupaba que ocurriese algo así. Intenté disuadir al capitán de tomar esta decisión, pero es un enano de acción y no es fácil hacerle cambiar su idea de cómo deben hacerse las cosas.$B$BHablemos de las opciones que nos quedan.', 18019);

-- Dos errores... - ID 11188
DELETE FROM `quest_request_items_locale` WHERE `ID`=11188 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11188, 'esES', 'Es una lástima que el capitán haya tenido que hacer que usted vaya a alborotar a los protodragones. Aunque parecen carecer de la inteligencia de algunos de los dragones que conocemos, siguen siendo criaturas nobles. Por no hablar de la situación en la que nos pone.$B$B¿Me atrevo a preguntar si se ha ocupado de la situación?', 18019),
(11188, 'esMX', 'Es una lástima que el capitán haya tenido que hacer que usted vaya a alborotar a los protodragones. Aunque parecen carecer de la inteligencia de algunos de los dragones que conocemos, siguen siendo criaturas nobles. Por no hablar de la situación en la que nos pone.$B$B¿Me atrevo a preguntar si se ha ocupado de la situación?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11188 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11188, 'esES', '<El teniente mago suspira.>$B$BUn asunto peliagudo para ser sinceros. Bueno, lo hecho, hecho está. Con un poco de suerte las nuevas crías de dracos de Encierro Ámbar no recordarán nuestras lamentables acciones.$B$BY con algo más de suerte, las fronteras de ese bosque mágico no seguirán extendiéndose.$B$BPor favor, $n, toma esta mísera recompensa del tesoro por todas las molestias. Es lo mínimo que podemos hacer.', 18019),
(11188, 'esMX', '<El teniente mago suspira.>$B$BUn asunto peliagudo para ser sinceros. Bueno, lo hecho, hecho está. Con un poco de suerte las nuevas crías de dracos de Encierro Ámbar no recordarán nuestras lamentables acciones.$B$BY con algo más de suerte, las fronteras de ese bosque mágico no seguirán extendiéndose.$B$BPor favor, $n, toma esta mísera recompensa del tesoro por todas las molestias. Es lo mínimo que podemos hacer.', 18019);

-- El tamaño sí importa - ID 11190
DELETE FROM `quest_request_items_locale` WHERE `ID`=11190 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11190, 'esES', 'Nos estamos quedando sin bolas aquí, $c. ¡Tenemos que machacar a nuestros enemigos, especialmente a Skorn!$B$B¿Tienes más bolas para nosotros?', 18019),
(11190, 'esMX', 'Nos estamos quedando sin bolas aquí, $c. ¡Tenemos que machacar a nuestros enemigos, especialmente a Skorn!$B$B¿Tienes más bolas para nosotros?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11190 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11190, 'esES', '¡Bendito seas, $n, bendito seas!$B$BDéjalas ahí mismo. Haré que uno de los chicos venga a cargarlas lo antes posible, así podremos dejar de preocuparnos por si nos vamos a quedar sin bolas que disparar a Skorn.', 18019),
(11190, 'esMX', '¡Bendito seas, $n, bendito seas!$B$BDéjalas ahí mismo. Haré que uno de los chicos venga a cargarlas lo antes posible, así podremos dejar de preocuparnos por si nos vamos a quedar sin bolas que disparar a Skorn.', 18019);

-- Informa al Explorador Knowles - ID 11199
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11199 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11199, 'esES', '¡Oh bien, ayuda y en el momento adecuado!', 18019),
(11199, 'esMX', '¡Oh bien, ayuda y en el momento adecuado!', 18019);

-- Misión: Llama eterna - ID 11202
DELETE FROM `quest_request_items_locale` WHERE `ID`=11202 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11202, 'esES', 'Es difícil saber desde aquí exactamente lo que está pasando allí abajo. ¿Te las arreglaste para poner esos tanques de peste a la antorcha?', 18019),
(11202, 'esMX', 'Es difícil saber desde aquí exactamente lo que está pasando allí abajo. ¿Te las arreglaste para poner esos tanques de peste a la antorcha?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11202 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11202, 'esES', '¡No está mal!$B$BPero ¿qué es eso que encontraste dentro de esos tanques? ¿Estás diciendo que los Renegados están extendiendo un tipo de peste sobre los vrykuls?', 18019),
(11202, 'esMX', '¡No está mal!$B$BPero ¿qué es eso que encontraste dentro de esos tanques? ¿Estás diciendo que los Renegados están extendiendo un tipo de peste sobre los vrykuls?', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Tanque de peste del suroeste destruido', `ObjectiveText2`='Tanque de peste del noroeste destruido', `ObjectiveText3`='Tanque de peste del noreste destruido', `ObjectiveText4`='Tanque de peste del sureste destruido' WHERE `ID`=11202 AND `locale` IN ('esES', 'esMX');

-- ¡Peligro! ¡Explosivos! - ID 11218
DELETE FROM `quest_request_items_locale` WHERE `ID`=11218 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11218, 'esES', 'La construcción en este lugar parece ser una tarea inacabable. Solo espero que seas capaz de conseguirnos lo que necesitamos.', 18019),
(11218, 'esMX', 'La construcción en este lugar parece ser una tarea inacabable. Solo espero que seas capaz de conseguirnos lo que necesitamos.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11218 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11218, 'esES', '¿La mena te ha provocado una sensación extraña? Quizás no usemos esa cosa después de todo.$B$B<Aro de Acero la observa y da un paso hacia atrás, cambiando de tema.>$B$B¡Esas gemas son preciosas! ¿Me pregunto cuánto podré sacar por ellas? Claro que siempre hay reparaciones y cosas nuevas que construir.$B$B¿Sabes? Trabajar contigo ha resultado ser muy beneficioso. Toma esto... ¡es lo menos que puedo hacer!', 18019),
(11218, 'esMX', '¿La mena te ha provocado una sensación extraña? Quizás no usemos esa cosa después de todo.$B$B<Aro de Acero la observa y da un paso hacia atrás, cambiando de tema.>$B$B¡Esas gemas son preciosas! ¿Me pregunto cuánto podré sacar por ellas? Claro que siempre hay reparaciones y cosas nuevas que construir.$B$B¿Sabes? Trabajar contigo ha resultado ser muy beneficioso. Toma esto... ¡es lo menos que puedo hacer!', 18019);

-- Envíalas de vuelta - ID 11224
DELETE FROM `quest_request_items_locale` WHERE `ID`=11224 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11224, 'esES', 'Esto es un gran golpe para nuestros esfuerzos. No quiero ni saber lo que han descubierto ahí abajo.$B$BEs suficiente para mantenerme despierto por la noche sólo tratando de imaginar lo que podría ser.', 18019),
(11224, 'esMX', 'Esto es un gran golpe para nuestros esfuerzos. No quiero ni saber lo que han descubierto ahí abajo.$B$BEs suficiente para mantenerme despierto por la noche sólo tratando de imaginar lo que podría ser.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11224 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11224, 'esES', 'Estoy en deuda contigo, $c. Al menos con todas las mulas y equipamiento que hemos recuperado podremos recuperarnos pronto.$B$BPor favor, toma esto.', 18019),
(11224, 'esMX', 'Estoy en deuda contigo, $c. Al menos con todas las mulas y equipamiento que hemos recuperado podremos recuperarnos pronto.$B$BPor favor, toma esto.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Mulas de carga abandonadas enviadas de vuelta' WHERE `ID`=11224 AND `locale` IN ('esES', 'esMX');

-- El infierno se ha congelado... - ID 11228
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11228 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11228, 'esES', 'El enano dice la verdad. No podemos permitirnos perder este puerto. Es uno de los dos únicos puertos seguros que la Alianza posee en este trozo de infierno helado. El otro está a cientos de kilómetros al oeste de aquí, en la costa de la Tundra Boreal.', 18019),
(11228, 'esMX', 'El enano dice la verdad. No podemos permitirnos perder este puerto. Es uno de los dos únicos puertos seguros que la Alianza posee en este trozo de infierno helado. El otro está a cientos de kilómetros al oeste de aquí, en la costa de la Tundra Boreal.', 18019);

-- De llaves y jaulas - ID 11231
DELETE FROM `quest_request_items_locale` WHERE `ID`=11231 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11231, 'esES', 'Con los prisioneros de Gjalerbron liberados, los vrykul no podrán continuar con sus ritos profanos.', 18019),
(11231, 'esMX', 'Con los prisioneros de Gjalerbron liberados, los vrykul no podrán continuar con sus ritos profanos.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11231 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11231, 'esES', '¡Bendito seas! Con tu ayuda, la Luz brilla incluso en el más oscuro de los lugares.$B$BPor favor, toma esto como recompensa por tus buenas obras. Velaré por la salvación de aquellos que liberaste, o al menos de los que sienten la Luz y aquellos de la Alianza que han regresado a la fortaleza.', 18019),
(11231, 'esMX', '¡Bendito seas! Con tu ayuda, la Luz brilla incluso en el más oscuro de los lugares.$B$BPor favor, toma esto como recompensa por tus buenas obras. Velaré por la salvación de aquellos que liberaste, o al menos de los que sienten la Luz y aquellos de la Alianza que han regresado a la fortaleza.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Prisionero de Gjalerbron liberado' WHERE `ID`=11231 AND `locale` IN ('esES', 'esMX');

-- Encargarse de Gjalerbron - ID 11235
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11235 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11235, 'esES', 'Bien hecho, $n, ¡por fin!$B$BSin embargo, lo que me cuentas sobre ese sitio me sigue preocupando, y creo que no hemos terminado de desinfectar...', 18019),
(11235, 'esMX', 'Bien hecho, $n, ¡por fin!$B$BSin embargo, lo que me cuentas sobre ese sitio me sigue preocupando, y creo que no hemos terminado de desinfectar...', 18019);

-- Necroseñor Supremo Mezhen - ID 11236
DELETE FROM `quest_request_items_locale` WHERE `ID`=11236 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11236, 'esES', '¿Estás seguro de que mataste a Mezhen y a sus necrolords, $c?', 18019),
(11236, 'esMX', '¿Estás seguro de que mataste a Mezhen y a sus necrolords, $c?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11236 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11236, 'esES', '<El capitán suspira aliviado.>$B$BBueno, creo que ya podemos estar más tranquilos.$B$B$n, una vez más has demostrado con creces tu valía a la Fortaleza de la Guardia Oeste y a la Alianza. ¡Coge algo de la tesorería, chico! Es lo mínimo que podemos hacer.', 18019),
(11236, 'esMX', '<El capitán suspira aliviado.>$B$BBueno, creo que ya podemos estar más tranquilos.$B$B$n, una vez más has demostrado con creces tu valía a la Fortaleza de la Guardia Oeste y a la Alianza. ¡Coge algo de la tesorería, chico! Es lo mínimo que podemos hacer.', 18019);

-- Los planes de ataque de Gjalerbron - ID 11237
DELETE FROM `quest_request_items_locale` WHERE `ID`=11237 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11237, 'esES', '¡¿Qué?! ¿Planes de un ataque a la Fortaleza?$B$B¿UNA VERMIS DE ESCARCHA?', 18019),
(11237, 'esMX', '¡¿Qué?! ¿Planes de un ataque a la Fortaleza?$B$B¿UNA VERMIS DE ESCARCHA?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11237 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11237, 'esES', '$n, ¡no podemos permitirlo!', 18019),
(11237, 'esMX', '$n, ¡no podemos permitirlo!', 18019);

-- La vermis de escarcha y su maestro - ID 11238
DELETE FROM `quest_request_items_locale` WHERE `ID`=11238 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11238, 'esES', '¿Hemos evitado el ataque? ¿Han sido destruidos la vermis de escarcha y su maestro?$B$B¿Has recuperado el cuerno?', 18019),
(11238, 'esMX', '¿Hemos evitado el ataque? ¿Han sido destruidos la vermis de escarcha y su maestro?$B$B¿Has recuperado el cuerno?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11238 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11238, 'esES', '¡Vaya, ese cuerno mola!$B$BUna vez más has salvado a la Fortaleza de la Guardia Oeste de un destino terrible. Eres increíble, $n. Ojalá hubiera más como tú.$B$BBueno, esto se merece una recompensa, sin lugar a dudas. ¿Cuál prefieres?', 18019),
(11238, 'esMX', '¡Vaya, ese cuerno mola!$B$BUna vez más has salvado a la Fortaleza de la Guardia Oeste de un destino terrible. Eres increíble, $n. Ojalá hubiera más como tú.$B$BBueno, esto se merece una recompensa, sin lugar a dudas. ¿Cuál prefieres?', 18019);

-- En servicio a la Luz - ID 11239
DELETE FROM `quest_request_items_locale` WHERE `ID`=11239 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11239, 'esES', 'La Santa Luz se mueve a través de sus acciones y en todas las cosas.$B$BNinguna criatura, ningún lugar, por muy malvado que sea, puede escapar a su ira.', 18019),
(11239, 'esMX', 'La Santa Luz se mueve a través de sus acciones y en todas las cosas.$B$BNinguna criatura, ningún lugar, por muy malvado que sea, puede escapar a su ira.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11239 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11239, 'esES', '<El sacerdote te bendice en silencio.>$B$BBendito seas por haber respondido a mis plegarias, $n. Sigue la Luz con orgullo, mantén la barbilla alta, sabiendo que has realizado acciones candorosas.$B$BSeguro que encontrarás algo útil de entre los fondos de la iglesia.', 18019),
(11239, 'esMX', '<El sacerdote te bendice en silencio.>$B$BBendito seas por haber respondido a mis plegarias, $n. Sigue la Luz con orgullo, mantén la barbilla alta, sabiendo que has realizado acciones candorosas.$B$BSeguro que encontrarás algo útil de entre los fondos de la iglesia.', 18019);

-- Líder de los trastornados - ID 11240
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11240 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11240, 'esES', '<El zapador refunfuña, como si no se alegrara de tu éxito.>$B$BEl capitán estará contento de saber que lo has conseguido.$B$B¿Sabes qué? Ya que has hecho una obra tan generosa para Garganta Susurro, ¿por qué no coges uno de estos?', 18019),
(11240, 'esMX', '<El zapador refunfuña, como si no se alegrara de tu éxito.>$B$BEl capitán estará contento de saber que lo has conseguido.$B$B¿Sabes qué? Ya que has hecho una obra tan generosa para Garganta Susurro, ¿por qué no coges uno de estos?', 18019);

-- Si Valgarde cae... - ID 11243
DELETE FROM `quest_request_items_locale` WHERE `ID`=11243 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11243, 'esES', 'El destino del mundo puede muy bien recaer en nosotros.', 18019),
(11243, 'esMX', 'El destino del mundo puede muy bien recaer en nosotros.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11243 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11243, 'esES', 'Has aportado a nuestros defensores el apoyo extra que necesitaban, $n. Tienen la moral más alta que nunca, gracias a ti. Creo que podrán encargarse del resto del ataque ellos solos. Tengo mejores planes para ti...', 18019),
(11243, 'esMX', 'Has aportado a nuestros defensores el apoyo extra que necesitaban, $n. Tienen la moral más alta que nunca, gracias a ti. Creo que podrán encargarse del resto del ataque ellos solos. Tengo mejores planes para ti...', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Invasor Desuelladragones matado' WHERE `ID`=11243 AND `locale` IN ('esES', 'esMX');

-- Rescatar a los rescatadores - ID 11244
DELETE FROM `quest_request_items_locale` WHERE `ID`=11244 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11244, 'esES', '¡Encuentren a esos exploradores!', 18019),
(11244, 'esMX', '¡Encuentren a esos exploradores!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11244 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11244, 'esES', 'Lo que los vrykuls hicieron a nuestros exploradores fue una muestra espantosa de salvajismo. Fue una estrategia basada en el miedo para debilitar nuestra determinación... para alejarnos corriendo por temor a nuestras vidas.$B$BNo ha funcionado.$B$B¡Vamos a enseñarles a esos monstruos lo que significa desafiar a la Alianza!', 18019),
(11244, 'esMX', 'Lo que los vrykuls hicieron a nuestros exploradores fue una muestra espantosa de salvajismo. Fue una estrategia basada en el miedo para debilitar nuestra determinación... para alejarnos corriendo por temor a nuestras vidas.$B$BNo ha funcionado.$B$B¡Vamos a enseñarles a esos monstruos lo que significa desafiar a la Alianza!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Explorador de Valgarde rescatado' WHERE `ID`=11244 AND `locale` IN ('esES', 'esMX');

-- Torres de muerte segura - ID 11245
DELETE FROM `quest_request_items_locale` WHERE `ID`=11245 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11245, 'esES', 'Acercarse demasiado a esas torres es una muerte segura mientras esos lanzadores estén ahí arriba.', 18019),
(11245, 'esMX', 'Acercarse demasiado a esas torres es una muerte segura mientras esos lanzadores estén ahí arriba.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11245 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11245, 'esES', '¡Una puntería excelente, señor! Tendré que invitar a los cañoneros a una ronda cuando volvamos a la fortaleza.', 18019),
(11245, 'esMX', '¡Una puntería excelente, señor! Tendré que invitar a los cañoneros a una ronda cuando volvamos a la fortaleza.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Torre del noroeste fijada como objetivo', `ObjectiveText2`='Torre del este fijada como objetivo', `ObjectiveText3`='Torre del suroeste fijada como objetivo', `ObjectiveText4`='Torre del sureste fijada como objetivo' WHERE `ID`=11245 AND `locale` IN ('esES', 'esMX');

-- Horripilante, pero necesario - ID 11246
DELETE FROM `quest_request_items_locale` WHERE `ID`=11246 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11246, 'esES', 'Una cosa que sé con certeza es que no quiero ver a ninguno de esos peces gordos de pie después de que los hayamos derribado.', 18019),
(11246, 'esMX', 'Una cosa que sé con certeza es que no quiero ver a ninguno de esos peces gordos de pie después de que los hayamos derribado.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11246 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11246, 'esES', 'Bien, señor he de reconocer que realizaste esa tarea en particular con cierto entusiasmo.$B$B<El Sargento te mira con recelo.>$B$BDe todos modos, si no te importa, devuélveme el machete. Parece desafilado y no nos gustaría que te resbalaras y me desembraras accidentalmente.', 18019),
(11246, 'esMX', 'Bien, señor he de reconocer que realizaste esa tarea en particular con cierto entusiasmo.$B$B<El Sargento te mira con recelo.>$B$BDe todos modos, si no te importa, devuélveme el machete. Parece desafilado y no nos gustaría que te resbalaras y me desembraras accidentalmente.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Vrykul Inbjerskorn desmembrado' WHERE `ID`=11246 AND `locale` IN ('esES', 'esMX');

-- ¡Arde, Skorn, arde! - ID 11247
DELETE FROM `quest_request_items_locale` WHERE `ID`=11247 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11247, 'esES', '¿Puedo sugerir que, cuando prendamos fuego a los edificios, no nos quedemos demasiado tiempo dentro de ellos?', 18019),
(11247, 'esMX', '¿Puedo sugerir que, cuando prendamos fuego a los edificios, no nos quedemos demasiado tiempo dentro de ellos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11247 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11247, 'esES', 'Muy bien, señor. No podríamos haber hecho esto sin tu ayuda.$B$BSeguro que el Capitán estará satisfecho con mi informe una vez que hayamos terminado aquí.', 18019),
(11247, 'esMX', 'Muy bien, señor. No podríamos haber hecho esto sin tu ayuda.$B$BSeguro que el Capitán estará satisfecho con mi informe una vez que hayamos terminado aquí.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Casa comunal noroeste en llamas', `ObjectiveText2`='Casa comunal noreste en llamas', `ObjectiveText3`='Barracones en llamas' WHERE `ID`=11247 AND `locale` IN ('esES', 'esMX');

-- Operación: cólera de Skorn - ID 11248
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11248 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11248, 'esES', '¡Encantado de conocerte, señor! Estoy deseando trabajar contigo.$B$BLo que me recuerda que tenemos mucho que hacer.', 18019),
(11248, 'esMX', '¡Encantado de conocerte, señor! Estoy deseando trabajar contigo.$B$BLo que me recuerda que tenemos mucho que hacer.', 18019);

-- ¡Detén la ascensión! - ID 11249
DELETE FROM `quest_request_items_locale` WHERE `ID`=11249 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11249, 'esES', '¿Sí? ¿Cómo puedo ayudarte?', 18019),
(11249, 'esMX', '¿Sí? ¿Cómo puedo ayudarte?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11249 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11249, 'esES', 'Sí, hijo mío, parece inquietante.$B$BGracias por traerme este pergamino. Estoy muy interesado en estudiar sus implicaciones. Si tuviera que suponer algo, pensaría que estos vrykuls han encontrado el modo de transcender a la muerte, al menos aquellos que son dignos.$B$BAl vencer al señor feudal de Inbjerskorn, has demostrado que no es digno. Solo la Luz sabe en qué se habría convertido y qué terror habría desembocado sobre nosotros si no lo hubieras matado.', 18019),
(11249, 'esMX', 'Sí, hijo mío, parece inquietante.$B$BGracias por traerme este pergamino. Estoy muy interesado en estudiar sus implicaciones. Si tuviera que suponer algo, pensaría que estos vrykuls han encontrado el modo de transcender a la muerte, al menos aquellos que son dignos.$B$BAl vencer al señor feudal de Inbjerskorn, has demostrado que no es digno. Solo la Luz sabe en qué se habría convertido y qué terror habría desembocado sobre nosotros si no lo hubieras matado.', 18019);

-- ¡Aclamad todos al conquistador de Skorn! - ID 11250
DELETE FROM `quest_request_items_locale` WHERE `ID`=11250 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11250, 'esES', 'Supongo que, ya que estás aquí, Skorn ya no existe.', 18019),
(11250, 'esMX', 'Supongo que, ya que estás aquí, Skorn ya no existe.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11250 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11250, 'esES', '¡Qué noticias! ¡Increíble! Sabía que lo conseguirías, $n.$B$B¡Al menos alguien aquí puede lograr resultados!$B$BBueno, esto se merece una recompensa. Adelante, toma tu premio: nuestros tesoros están a tu disposición.', 18019),
(11250, 'esMX', '¡Qué noticias! ¡Increíble! Sabía que lo conseguirías, $n.$B$B¡Al menos alguien aquí puede lograr resultados!$B$BBueno, esto se merece una recompensa. Adelante, toma tu premio: nuestros tesoros están a tu disposición.', 18019);

-- Piernas frescas - ID 11251
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11251 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11251, 'esES', 'Aunque llegues tarde, es bueno ver una cara amigable.$B$BAhora no te quedes ahí como un pasmarote. ¡Hay trabajo que hacer!', 18019),
(11251, 'esMX', 'Aunque llegues tarde, es bueno ver una cara amigable.$B$BAhora no te quedes ahí como un pasmarote. ¡Hay trabajo que hacer!', 18019);

-- Prisioneros de Calavermis - ID 11255
DELETE FROM `quest_request_items_locale` WHERE `ID`=11255 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11255, 'esES', '¡Pon un poco de valor en esto, $n! ¡Las vidas de las personas están en juego aquí!', 18019),
(11255, 'esMX', '¡Pon un poco de valor en esto, $n! ¡Las vidas de las personas están en juego aquí!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11255 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11255, 'esES', "Esos soldados que has rescatado nos han proporcionado un buen pellizco de información. Esos monstruos se hacen llamar 'vrykuls'. La tribu que se ha asentado en el Poblado Calavermis está liderada por un místico llamado Yanis, que es a su vez un subordinado de otro vrykul conocido como Ingvar el Desvalijador.", 18019),
(11255, 'esMX', "Esos soldados que has rescatado nos han proporcionado un buen pellizco de información. Esos monstruos se hacen llamar 'vrykuls'. La tribu que se ha asentado en el Poblado Calavermis está liderada por un místico llamado Yanis, que es a su vez un subordinado de otro vrykul conocido como Ingvar el Desvalijador.", 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Prisionero de Valgarde rescatado' WHERE `ID`=11255 AND `locale` IN ('esES', 'esMX');

-- Esfuerzo final - ID 11269
DELETE FROM `quest_request_items_locale` WHERE `ID`=11269 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11269, 'esES', '¿Me has traído ya algo de plumón? Me vendría bien...', 18019),
(11269, 'esMX', '¿Me has traído ya algo de plumón? Me vendría bien...', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11269 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11269, 'esES', '¡Gracias a los dioses! Con esto debería tener suficiente. Por supuesto, no dormiré hasta que lleguen las tropas, pero prefiero eso a ver al capitán Adams montar en cólera.$B$B¡He oído cada historia sobre él!', 18019),
(11269, 'esMX', '¡Gracias a los dioses! Con esto debería tener suficiente. Por supuesto, no dormiré hasta que lleguen las tropas, pero prefiero eso a ver al capitán Adams montar en cólera.$B$B¡He oído cada historia sobre él!', 18019);

-- La liga de los humanos - ID 11273
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11273 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11273, 'esES', 'Has encontrado a Pulroy. Demasiado tarde, al parecer.$B$BAl mirar el cuerpo ves un diario asido con fuerza entre las manos sin vida de Pulroy. Al examinar el diario puedes leer lo que parecen los garabatos de un enano moribundo.', 18019),
(11273, 'esMX', 'Has encontrado a Pulroy. Demasiado tarde, al parecer.$B$BAl mirar el cuerpo ves un diario asido con fuerza entre las manos sin vida de Pulroy. Al examinar el diario puedes leer lo que parecen los garabatos de un enano moribundo.', 18019);

-- Es probable que Zedd esté muerto - ID 11274
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11274 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11274, 'esES', 'Has encontrado a Zedd. No eres médico, pero es probable que el pronóstico de Zedd sea desfavorable.$B$BParece que lo estén preparando para echárselo de comida a los huargos. Espantoso...', 18019),
(11274, 'esMX', 'Has encontrado a Zedd. No eres médico, pero es probable que el pronóstico de Zedd sea desfavorable.$B$BParece que lo estén preparando para echárselo de comida a los huargos. Espantoso...', 18019);

-- Solo quedaban dos... - ID 11276
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11276 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11276, 'esES', '¡Ya era hora! Pulroy y Zedd han muerto.$B$BY Daegarn...$B$B<Glorenfeld agita la cabeza.>$B$BEl cabecilla de los Desuelladragones nos metió en las profundidades de estas catacumbas. Oí a ese perro callejero gigante decir algo sobre un sacrificio por el "Rey del Terror".$B$BLa clave está escondida en la mugrienta barba de Daegarn.$B$B¿Qué? ¡Los enanos esconden cosas en sus barbas siempre!', 18019),
(11276, 'esMX', '¡Ya era hora! Pulroy y Zedd han muerto.$B$BY Daegarn...$B$B<Glorenfeld agita la cabeza.>$B$BEl cabecilla de los Desuelladragones nos metió en las profundidades de estas catacumbas. Oí a ese perro callejero gigante decir algo sobre un sacrificio por el "Rey del Terror".$B$BLa clave está escondida en la mugrienta barba de Daegarn.$B$B¿Qué? ¡Los enanos esconden cosas en sus barbas siempre!', 18019);

-- Las profundidades de la depravación - ID 11277
DELETE FROM `quest_request_items_locale` WHERE `ID`=11277 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11277, 'esES', '¡Busca hasta en el último rincón!', 18019),
(11277, 'esMX', '¡Busca hasta en el último rincón!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11277 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11277, 'esES', 'Muy bien, colega. Ahora que las tablillas están a salvo podemos intentar salvar la vida de Daegarn y recuperar la clave que nos ayudará a descodificar el mensaje escondido en esas reliquias antiguas.$B$BYa guardo yo estas tablillas, tú ve a salvar a Daegarn.', 18019),
(11277, 'esMX', 'Muy bien, colega. Ahora que las tablillas están a salvo podemos intentar salvar la vida de Daegarn y recuperar la clave que nos ayudará a descodificar el mensaje escondido en esas reliquias antiguas.$B$BYa guardo yo estas tablillas, tú ve a salvar a Daegarn.', 18019);

-- Regresa a Valgarde - ID 11278
DELETE FROM `quest_request_items_locale` WHERE `ID`=11278 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11278, 'esES', '¡Has vuelto!', 18019),
(11278, 'esMX', '¡Has vuelto!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11278 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11278, 'esES', 'Sacar algo en claro de estas tablillas va a llevar algún tiempo. Todo lo que puedo deducir de un estudio anterior es que lo que hubiese aquí otrora era un ancestro de los humanos. Probablemente esas cosas vrykuls los mataron a todos. En cualquier caso, sabremos más cuando estudie estas reliquias.', 18019),
(11278, 'esMX', 'Sacar algo en claro de estas tablillas va a llevar algún tiempo. Todo lo que puedo deducir de un estudio anterior es que lo que hubiese aquí otrora era un ancestro de los humanos. Probablemente esas cosas vrykuls los mataron a todos. En cualquier caso, sabremos más cuando estudie estas reliquias.', 18019);

-- El yeti de al lado - ID 11284
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11284 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11284, 'esES', '¿Lo has logrado? Por la Luz, ¡eres un milagro andante! Empezaba a pensar que tendría que explicarle personalmente al capitán Adams por qué sus armas no estarían listas a tiempo.', 18019),
(11284, 'esMX', '¿Lo has logrado? Por la Luz, ¡eres un milagro andante! Empezaba a pensar que tendría que explicarle personalmente al capitán Adams por qué sus armas no estarían listas a tiempo.', 18019);

-- La luz brillante - ID 11288
DELETE FROM `quest_request_items_locale` WHERE `ID`=11288 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11288, 'esES', '<Ares está inconsciente.>', 18019),
(11288, 'esMX', '<Ares está inconsciente.>', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11288 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11288, 'esES', 'Sientes la obligación de colocar la hoja sagrada junto al cuerpo de Ares.$B$BAl hacer esto te vuelve a cegar la luz.', 18019),
(11288, 'esMX', 'Sientes la obligación de colocar la hoja sagrada junto al cuerpo de Ares.$B$BAl hacer esto te vuelve a cegar la luz.', 18019);

-- Guiado por el honor - ID 11289
DELETE FROM `quest_request_items_locale` WHERE `ID`=11289 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11289, 'esES', '¡Por la Luz!', 18019),
(11289, 'esMX', '¡Por la Luz!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11289 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11289, 'esES', 'Muchos hombres y mujeres han muerto para recuperar esta hoja. Por desgracia, me temo que el valiente Ares no será el último.$B$BPero tú ayudas a la causa de la Luz, héroe. Esta hoja sagrada será empuñada por el propio alto señor Tirion Vadín. Incluso ahora la Cruzada Argenta trabaja en Corona de Hielo. ¡El Señor Vadín ha jurado que echará abajo los muros del lugar maldito! Y con la hoja, quizás consiga enfrentarse al Rey Exánime.$B$BEl alto señor Vadín es nuestra última esperanza.', 18019),
(11289, 'esMX', 'Muchos hombres y mujeres han muerto para recuperar esta hoja. Por desgracia, me temo que el valiente Ares no será el último.$B$BPero tú ayudas a la causa de la Luz, héroe. Esta hoja sagrada será empuñada por el propio alto señor Tirion Vadín. Incluso ahora la Cruzada Argenta trabaja en Corona de Hielo. ¡El Señor Vadín ha jurado que echará abajo los muros del lugar maldito! Y con la hoja, quizás consiga enfrentarse al Rey Exánime.$B$BEl alto señor Vadín es nuestra última esperanza.', 18019);

-- Planes de batalla de los Desuelladragones - ID 11290
DELETE FROM `quest_request_items_locale` WHERE `ID`=11290 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11290, 'esES', '¿Has recuperado los planes de batalla de los Desuelladragones?', 18019),
(11290, 'esMX', '¿Has recuperado los planes de batalla de los Desuelladragones?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11290 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11290, 'esES', '<El vicealmirante Keller ojea los planes.>$B$B¡Excelente! Parece que hay muchos más poblados vrykuls en el fiordo. Una tribu diferente a la de los vrykuls está preparando un asalto a la Fortaleza de la Guardia Oeste. Demonios, creo que ya es demasiado tarde. No hemos sabido nada de la Guardia Oeste desde hace días. ¡De todos modos tenemos que avisarlos!', 18019),
(11290, 'esMX', '<El vicealmirante Keller ojea los planes.>$B$B¡Excelente! Parece que hay muchos más poblados vrykuls en el fiordo. Una tribu diferente a la de los vrykuls está preparando un asalto a la Fortaleza de la Guardia Oeste. Demonios, creo que ya es demasiado tarde. No hemos sabido nada de la Guardia Oeste desde hace días. ¡De todos modos tenemos que avisarlos!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Planes de batalla de los Desuelladragones' WHERE `ID`=11290 AND `locale` IN ('esES', 'esMX');

-- ¡A la Fortaleza de la Guardia Oeste! - ID 11291
DELETE FROM `quest_request_items_locale` WHERE `ID`=11291 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11291, 'esES', '¿Valgarde no ha caído? Eso es una sorpresa. Debe ser debido a su ayuda. Seguro que no fue por Keller.', 18019),
(11291, 'esMX', '¿Valgarde no ha caído? Eso es una sorpresa. Debe ser debido a su ayuda. Seguro que no fue por Keller.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11291 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11291, 'esES', '<El capitán Adams coge los planos.>$B$BMe alegra que decidieras venir. Mis consejeros y yo necesitaremos tiempo para estudiar estos planes. Mientras tanto, nos vendrá bien toda la ayuda que podamos conseguir.', 18019),
(11291, 'esMX', '<El capitán Adams coge los planos.>$B$BMe alegra que decidieras venir. Mis consejeros y yo necesitaremos tiempo para estudiar estos planes. Mientras tanto, nos vendrá bien toda la ayuda que podamos conseguir.', 18019);

-- Acechando a los débiles - ID 11292
DELETE FROM `quest_request_items_locale` WHERE `ID`=11292 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11292, 'esES', 'Espero que no hayas regresado con las manos vacías. Creía que teníamos un trato.', 18019),
(11292, 'esMX', 'Espero que no hayas regresado con las manos vacías. Creía que teníamos un trato.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11292 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11292, 'esES', '<El trampero Jethan observa con detalle las criaturas que le has traído.>$B$BBien hecho. Algunas de estas piezas me proporcionarán mayor beneficio que otras, pero seguro que tendré mucho con lo que comerciar con los lugareños.', 18019),
(11292, 'esMX', '<El trampero Jethan observa con detalle las criaturas que le has traído.>$B$BBien hecho. Algunas de estas piezas me proporcionarán mayor beneficio que otras, pero seguro que tendré mucho con lo que comerciar con los lugareños.', 18019);

-- El Círculo del Juicio - ID 11299
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11299 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11299, 'esES', 'Sí. Me has encontrado. ¡Yupiyeeeih!$B$BY no, no tengo la clave. Mi barba fue lo primero que comprobaron esas bestias. Oluf es quien la tiene ahora. Es el jefe de los gladiadores.', 18019),
(11299, 'esMX', 'Sí. Me has encontrado. ¡Yupiyeeeih!$B$BY no, no tengo la clave. Mi barba fue lo primero que comprobaron esas bestias. Oluf es quien la tiene ahora. Es el jefe de los gladiadores.', 18019);

-- Una derrota asombrosa en el Círculo - ID 11300
DELETE FROM `quest_request_items_locale` WHERE `ID`=11300 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11300, 'esES', '¿Daegarn? ¿La clave?', 18019),
(11300, 'esMX', '¿Daegarn? ¿La clave?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11300 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11300, 'esES', '¡Una historia fascinante! ¿Algo está juzgando a esas cosas?¿Con qué finalidad?$B$BBueno, no importa. Alguien más podría descubrir ese asunto. Hemos recuperado la clave y las tablillas... Y solo hemos sufrido dos pérdidas durante esta dura prueba.', 18019),
(11300, 'esMX', '¡Una historia fascinante! ¿Algo está juzgando a esas cosas?¿Con qué finalidad?$B$BBueno, no importa. Alguien más podría descubrir ese asunto. Hemos recuperado la clave y las tablillas... Y solo hemos sufrido dos pérdidas durante esta dura prueba.', 18019);

-- Las enigmáticas ninfas escarcha - ID 11302
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11302 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11302, 'esES', '<Lurielle te escucha mientras te presentas.>$B$BMe alegro de conocerte por fin, $n. Hemos esperado durante mucho tiempo que tú y los demás recién llegados envíen a sus representantes. No solemos aventurarnos más allá de las fronteras de nuestros claros, sobre todo con los cambios por los que está atravesando la tierra.', 18019),
(11302, 'esMX', '<Lurielle te escucha mientras te presentas.>$B$BMe alegro de conocerte por fin, $n. Hemos esperado durante mucho tiempo que tú y los demás recién llegados envíen a sus representantes. No solemos aventurarnos más allá de las fronteras de nuestros claros, sobre todo con los cambios por los que está atravesando la tierra.', 18019);

-- La limpieza - ID 11322
DELETE FROM `quest_request_items_locale` WHERE `ID`=11322 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11322, 'esES', '¿Has encontrado la paz interior en el santuario? ¿Ha desaparecido tu confusión?', 18019),
(11322, 'esMX', '¿Has encontrado la paz interior en el santuario? ¿Ha desaparecido tu confusión?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11322 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11322, 'esES', 'Ya puedo notar el cambio en ti.$B$B¿Estás preparado para continuar?', 18019),
(11322, 'esMX', 'Ya puedo notar el cambio en ti.$B$B¿Estás preparado para continuar?', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Limpiar tu conflicto interior' WHERE `ID`=11322 AND `locale` IN ('esES', 'esMX');

-- En el pellejo de un huargo - ID 11325
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11325 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11325, 'esES', 'Hueles y tienes un aspecto diferente... tú no eres de mi manada. Cuéntame tu historia, tiempo es lo único que me sobra mientras estoy aquí atrapado.', 18019),
(11325, 'esMX', 'Hueles y tienes un aspecto diferente... tú no eres de mi manada. Cuéntame tu historia, tiempo es lo único que me sobra mientras estoy aquí atrapado.', 18019);

-- Huargo alfa - ID 11326
DELETE FROM `quest_request_items_locale` WHERE `ID`=11326 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11326, 'esES', '$n, has vuelto. ¿Qué noticias me traes de Ulkang?', 18019),
(11326, 'esMX', '$n, has vuelto. ¿Qué noticias me traes de Ulkang?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11326 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11326, 'esES', '¡Garwal no era un huargo! Por lo que me dices, debes de estar hablando de un $r.$B$BPero, ¿Ulkang dijo que provenía del sur de las Colinas Pardas? Qué raro, por allí no hay $r.$B$BGracias por ayudar a devolver a Ulkang el puesto que merece entre los suyos. Ahora los dos podremos dormir tranquilos.$B$BPor favor, acepta esto como muestra de mi gratitud.', 18019),
(11326, 'esMX', '¡Garwal no era un huargo! Por lo que me dices, debes de estar hablando de un $r.$B$BPero, ¿Ulkang dijo que provenía del sur de las Colinas Pardas? Qué raro, por allí no hay $r.$B$BGracias por ayudar a devolver a Ulkang el puesto que merece entre los suyos. Ahora los dos podremos dormir tranquilos.$B$BPor favor, acepta esto como muestra de mi gratitud.', 18019);

-- Misión: Devolver el paquete - ID 11327
DELETE FROM `quest_request_items_locale` WHERE `ID`=11327 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11327, 'esES', 'Ese lugar es como una pesadilla. Vrykul o no, nadie merece ser víctima de la Sociedad Real de Boticarios.$B$BMe alegro de haber salido a salvo de ahí. ¿Has encontrado ya ese paquete?', 18019),
(11327, 'esMX', 'Ese lugar es como una pesadilla. Vrykul o no, nadie merece ser víctima de la Sociedad Real de Boticarios.$B$BMe alegro de haber salido a salvo de ahí. ¿Has encontrado ya ese paquete?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11327 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11327, 'esES', 'Santo... ¿pero qué demonios? ¡Mira esto!$B$B¡Tenemos que devolver esto lo antes posible!', 18019),
(11327, 'esMX', 'Santo... ¿pero qué demonios? ¡Mira esto!$B$B¡Tenemos que devolver esto lo antes posible!', 18019);

-- Misión: Inteligencia renegada - ID 11328
DELETE FROM `quest_request_items_locale` WHERE `ID`=11328 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11328, 'esES', '¿Sshí, qué dessheas? Hip.', 18019),
(11328, 'esMX', '¿Sshí, qué dessheas? Hip.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11328 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11328, 'esES', 'Aaahh, ooohh... ¡essho cambia la cosha!$B$BPfale, déjame vfer esho... ¡Me encannnta juguetear con la alquimia!$B$BInteresante, interesante... Esshto, creo que shé qué hacer. Una mezshclita de la cantdidad exacdta de eshto.$B$BSabesh, creo que un poco de eshte licorcsillo también servirá... ¡Hip!', 18019),
(11328, 'esMX', 'Aaahh, ooohh... ¡essho cambia la cosha!$B$BPfale, déjame vfer esho... ¡Me encannnta juguetear con la alquimia!$B$BInteresante, interesante... Esshto, creo que shé qué hacer. Una mezshclita de la cantdidad exacdta de eshto.$B$BSabesh, creo que un poco de eshte licorcsillo también servirá... ¡Hip!', 18019);

-- ¡Probaré lo que sea! - ID 11329
DELETE FROM `quest_request_items_locale` WHERE `ID`=11329 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11329, 'esES', 'Parece que aún sigues entero. ¿Tienes algún cebo de esos?', 18019),
(11329, 'esMX', 'Parece que aún sigues entero. ¿Tienes algún cebo de esos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11329 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11329, 'esES', 'Bueno, estos son sin duda bastante feos, pero supongo que no importa siempre que funcione. Será un alivio cuando la expedición se marche y yo pueda volver a pescar para hacerme la cena de hoy.', 18019),
(11329, 'esMX', 'Bueno, estos son sin duda bastante feos, pero supongo que no importa siempre que funcione. Será un alivio cuando la expedición se marche y yo pueda volver a pescar para hacerme la cena de hoy.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Rascacio del Norte' WHERE `ID`=11329 AND `locale` IN ('esES', 'esMX');

-- Pods shupuesshto... ¡Eshto fva a fvuncionar! - ID 11330
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11330 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11330, 'esES', '¿Eeh? Huuy, ¡qué malll! Vfaya, he empeoraddho lash coshas... De hechso, dcreo que he perfeccionaddo su peshhte... ¡hip!$B$B<Peppy hace una mueca y da un enorme trago de lo que sea aquello que está bebiendo.>$B$BBuenño, nño eshperaba que fuera a shalir assí, pero paddece que no hay alternattivfa... hip.', 18019),
(11330, 'esMX', '¿Eeh? Huuy, ¡qué malll! Vfaya, he empeoraddho lash coshas... De hechso, dcreo que he perfeccionaddo su peshhte... ¡hip!$B$B<Peppy hace una mueca y da un enorme trago de lo que sea aquello que está bebiendo.>$B$BBuenño, nño eshperaba que fuera a shalir assí, pero paddece que no hay alternattivfa... hip.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Mezcla de Peppy administrada al prisionero vrykul' WHERE `ID`=11330 AND `locale` IN ('esES', 'esMX');

-- Se lo cuentas tú... ¡hip! - ID 11331
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11331 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11331, 'esES', 'Sí, $n, ¿qué ocurre ahora?$B$B¡¿QUÉ?! ¿Una superpeste de los Renegados que te derrite en un abrir y cerrar de ojos?$B$B¿Has perdido a mi prisionero vrykul?$B$BBien, sé qué tenemos que hacer. O, mejor dicho, qué TIENES que hacer.', 18019),
(11331, 'esMX', 'Sí, $n, ¿qué ocurre ahora?$B$B¡¿QUÉ?! ¿Una superpeste de los Renegados que te derrite en un abrir y cerrar de ojos?$B$B¿Has perdido a mi prisionero vrykul?$B$BBien, sé qué tenemos que hacer. O, mejor dicho, qué TIENES que hacer.', 18019);

-- Misión: Echar pestes - ID 11332
DELETE FROM `quest_request_items_locale` WHERE `ID`=11332 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11332, 'esES', '¿Ya se han destruido los tanques de la plaga? ¡Esa nueva plaga se cierne sobre nuestras cabezas como una muerte segura, $c!', 18019),
(11332, 'esMX', '¿Ya se han destruido los tanques de la plaga? ¡Esa nueva plaga se cierne sobre nuestras cabezas como una muerte segura, $c!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11332 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11332, 'esES', 'Bien hecho, $n, ¡bien hecho!$B$BEso les enseñará a esos inútiles Renegados a pensárselo dos veces antes de meterse con nosotros.$B$BDiría que te has ganado parte del tesoro.', 18019),
(11332, 'esMX', 'Bien hecho, $n, ¡bien hecho!$B$BEso les enseñará a esos inútiles Renegados a pensárselo dos veces antes de meterse con nosotros.$B$BDiría que te has ganado parte del tesoro.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Tanque de peste destruido' WHERE `ID`=11332 AND `locale` IN ('esES', 'esMX');

-- En el mundo de los espíritus - ID 11333
DELETE FROM `quest_request_items_locale` WHERE `ID`=11333 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11333, 'esES', '¿Has encontrado mi faltriquera de componentes?', 18019),
(11333, 'esMX', '¿Has encontrado mi faltriquera de componentes?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11333 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11333, 'esES', 'Está un poco estropeada pero aún en buen estado.$B$B<Thoralius rebusca por la faltriquera y quita algunas extrañas raíces.>$B$B¡Ahora hay que quemarlas e inhalar!$B$B<Thoralius lanza las raíces al quemador de incienso humeante.>$B$B<Thoralius inhala profundamente. Su cuerpo comienza a agitarse.>$B$BQué... qué... No puede ser... No puedo...', 18019),
(11333, 'esMX', 'Está un poco estropeada pero aún en buen estado.$B$B<Thoralius rebusca por la faltriquera y quita algunas extrañas raíces.>$B$B¡Ahora hay que quemarlas e inhalar!$B$B<Thoralius lanza las raíces al quemador de incienso humeante.>$B$B<Thoralius inhala profundamente. Su cuerpo comienza a agitarse.>$B$BQué... qué... No puede ser... No puedo...', 18019);

-- El eco de Ymiron - ID 11343
DELETE FROM `quest_request_items_locale` WHERE `ID`=11343 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11343, 'esES', '¿Qué ha descubierto?', 18019),
(11343, 'esMX', '¿Qué ha descubierto?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11343 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11343, 'esES', 'No entiendo. ¿Las criaturas que viste se parecían a los vrykuls que están atacando Valgarde?', 18019),
(11343, 'esMX', 'No entiendo. ¿Las criaturas que viste se parecían a los vrykuls que están atacando Valgarde?', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Secretos de Calavermis desvelados' WHERE `ID`=11343 AND `locale` IN ('esES', 'esMX');

-- La angustia de Nafsavar - ID 11344
DELETE FROM `quest_request_items_locale` WHERE `ID`=11344 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11344, 'esES', '¿Qué ha descubierto?', 18019),
(11344, 'esMX', '¿Qué ha descubierto?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11344 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11344, 'esES', '¿Niños humanos nacidos de vrykuls? ¿E Ymiron ordenó la muerte de todos los niños que nacieran humanos?$B$B<Thoralius se queda callado un momento.>$B$BAunque me gustaría negar lo que se me presenta con tanta claridad, no puedo. No hay ningún "eslabón perdido" con los humanos como la Liga de Expedicionarios sugería. Los vrykuls son el eslabón perdido. Son los progenitores de la humanidad.', 18019),
(11344, 'esMX', '¿Niños humanos nacidos de vrykuls? ¿E Ymiron ordenó la muerte de todos los niños que nacieran humanos?$B$B<Thoralius se queda callado un momento.>$B$BAunque me gustaría negar lo que se me presenta con tanta claridad, no puedo. No hay ningún "eslabón perdido" con los humanos como la Liga de Expedicionarios sugería. Los vrykuls son el eslabón perdido. Son los progenitores de la humanidad.', 18019);

-- El libro de las Runas - ID 11346
DELETE FROM `quest_request_items_locale` WHERE `ID`=11346 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11346, 'esES', '¿Has recuperado el libro?', 18019),
(11346, 'esMX', '¿Has recuperado el libro?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11346 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11346, 'esES', '<El prospector Belvar hojea el libro de las Runas.>$B$BMmm... Aquí dentro hay muchas cosas. Voy a tener que ponerme a estudiarlo, y si logro entender lo que hay escrito en estas runas, tendremos que crear las nuestras propias.', 18019),
(11346, 'esMX', '<El prospector Belvar hojea el libro de las Runas.>$B$BMmm... Aquí dentro hay muchas cosas. Voy a tener que ponerme a estudiarlo, y si logro entender lo que hay escrito en estas runas, tendremos que crear las nuestras propias.', 18019);

-- La runa de mando - ID 11348
DELETE FROM `quest_request_items_locale` WHERE `ID`=11348 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11348, 'esES', '¿Has probado la runa?', 18019),
(11348, 'esMX', '¿Has probado la runa?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11348 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11348, 'esES', 'Has hecho bien al derrotar al vinculador Murdis, pero los enanos férreos no se rendirán fácilmente.$B$BHemos avanzado mucho comprendiendo cómo manipulan las runas. Quizás la próxima vez que nos enfrentemos a ellos esta información nos dé ventaja.', 18019),
(11348, 'esMX', 'Has hecho bien al derrotar al vinculador Murdis, pero los enanos férreos no se rendirán fácilmente.$B$BHemos avanzado mucho comprendiendo cómo manipulan las runas. Quizás la próxima vez que nos enfrentemos a ellos esta información nos dé ventaja.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Probar runa de mando', `ObjectiveText2`='Vinculador Murdis' WHERE `ID`=11348 AND `locale` IN ('esES', 'esMX');

-- Dominar las runas - ID 11349
DELETE FROM `quest_request_items_locale` WHERE `ID`=11349 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11349, 'esES', '¿Has regresado con esas herramientas?', 18019),
(11349, 'esMX', '¿Has regresado con esas herramientas?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11349 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11349, 'esES', '<Belvar maneja las herramientas con cuidado.>$B$BVoy a probarlas. Si queremos comprender los motivos de los enanos férreos y derrotarlos, necesito saber qué hacen las runas exactamente.', 18019),
(11349, 'esMX', '<Belvar maneja las herramientas con cuidado.>$B$BVoy a probarlas. Si queremos comprender los motivos de los enanos férreos y derrotarlos, necesito saber qué hacen las runas exactamente.', 18019);

-- La marcha de los gigantes - ID 11355
DELETE FROM `quest_request_items_locale` WHERE `ID`=11355 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11355, 'esES', '¿Qué has encontrado?', 18019),
(11355, 'esMX', '¿Qué has encontrado?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11355 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11355, 'esES', '<El investigador Aderan Bte escucha.>$B$B¿Las runas que representan "norte" y "oeste" aparecían varias veces? Hay una orden estricta para dirigirse en esa dirección, pero las runas actúan como algo más que una simple incitación. Algo los atrae, ¿pero el qué?', 18019),
(11355, 'esMX', '<El investigador Aderan Bte escucha.>$B$B¿Las runas que representan "norte" y "oeste" aparecían varias veces? Hay una orden estricta para dirigirse en esa dirección, pero las runas actúan como algo más que una simple incitación. Algo los atrae, ¿pero el qué?', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Cuerpo de gigante de piedra con runas analizado' WHERE `ID`=11355 AND `locale` IN ('esES', 'esMX');

-- La magnetita - ID 11358
DELETE FROM `quest_request_items_locale` WHERE `ID`=11358 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11358, 'esES', '¿Has descubierto qué piedra de toque atrae a los gigantes?', 18019),
(11358, 'esMX', '¿Has descubierto qué piedra de toque atrae a los gigantes?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11358 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11358, 'esES', '<Aderan te escucha mientras le explicas lo que has descubierto.>$B$B¡Claro! Ese Megalito tiene que ser la clave en los planes de los enanos férreos. ¡Debemos destruirlo antes de que se salgan con la suya!', 18019),
(11358, 'esMX', '<Aderan te escucha mientras le explicas lo que has descubierto.>$B$B¡Claro! Ese Megalito tiene que ser la clave en los planes de los enanos férreos. ¡Debemos destruirlo antes de que se salgan con la suya!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Comparar runas con la tablilla rota' WHERE `ID`=11358 AND `locale` IN ('esES', 'esMX');

-- Destruyendo a Megalito - ID 11359
DELETE FROM `quest_request_items_locale` WHERE `ID`=11359 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11359, 'esES', '¿Traes noticias de la caída de Megalito?', 18019),
(11359, 'esMX', '¿Traes noticias de la caída de Megalito?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11359 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11359, 'esES', 'Has hecho un gran trabajo matando a Megalito, pero me pregunto qué querrán decir sus últimas palabras.$B$B¿Estás seguro de que dijo Forja de Piedra?$B$BNo conozco ningún lugar llamado Forja de Piedra, parece una palabra de orígenes titánicos. ¿Qué planes tendrán los enanos férreos? Esto requiere vigilancia, $n, debemos encontrarlo antes de que los enanos férreos logren su propósito.', 18019),
(11359, 'esMX', 'Has hecho un gran trabajo matando a Megalito, pero me pregunto qué querrán decir sus últimas palabras.$B$B¿Estás seguro de que dijo Forja de Piedra?$B$BNo conozco ningún lugar llamado Forja de Piedra, parece una palabra de orígenes titánicos. ¿Qué planes tendrán los enanos férreos? Esto requiere vigilancia, $n, debemos encontrarlo antes de que los enanos férreos logren su propósito.', 18019);

-- ¡Tengo una máquina voladora! - ID 11390
DELETE FROM `quest_request_items_locale` WHERE `ID`=11390 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11390, 'esES', '¿Eh? ¿Terminaste con todo ese acarreo?', 18019),
(11390, 'esMX', '¿Eh? ¿Terminaste con todo ese acarreo?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11390 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11390, 'esES', 'Buen trabajo, pero creo que te vendría bien un curso de repaso de pilotaje básico.$B$BBueno, no importa, peor es nada. Aquí está tu botín de hoy.', 18019),
(11390, 'esMX', 'Buen trabajo, pero creo que te vendría bien un curso de repaso de pilotaje básico.$B$BBueno, no importa, peor es nada. Aquí está tu botín de hoy.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Saco de reliquias entregado' WHERE `ID`=11390 AND `locale` IN ('esES', 'esMX');

-- Patrulla Las Puertas de Acero - ID 11391
DELETE FROM `quest_request_items_locale` WHERE `ID`=11391 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11391, 'esES', '¡¿Gárgolas?! ¡Las he visto ahí fuera! ¿Te encargaste de todas ellas?$B$B¿A qué viene el mundo cuando un enano no puede ni siquiera cavar sin ser atacado?', 18019),
(11391, 'esMX', '¡¿Gárgolas?! ¡Las he visto ahí fuera! ¿Te encargaste de todas ellas?$B$B¿A qué viene el mundo cuando un enano no puede ni siquiera cavar sin ser atacado?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11391 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11391, 'esES', 'Buena puntería, as.$B$BAquí tienes tu sueldo. Vuelve mañana para otra ronda, ¿oyes?', 18019),
(11391, 'esMX', 'Buena puntería, as.$B$BAquí tienes tu sueldo. Vuelve mañana para otra ronda, ¿oyes?', 18019);

-- ¿Dónde está el expedicionario Jaren? - ID 11393
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11393 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11393, 'esES', '<El explorador sonríe cuando le dices quién te envía. Continúa en tono bajo.>$B$B¿Irena estaba preocupada por mí? Eso lo ha heredado de su padre, ¿sabes?', 18019),
(11393, 'esMX', '<El explorador sonríe cuando le dices quién te envía. Continúa en tono bajo.>$B$B¿Irena estaba preocupada por mí? Eso lo ha heredado de su padre, ¿sabes?', 18019);

-- ¡Y tú que pensabas que los múrlocs olían mal! - ID 11394
DELETE FROM `quest_request_items_locale` WHERE `ID`=11394 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11394, 'esES', 'No sé, $c, parece que aún no has destruido suficientes.', 18019),
(11394, 'esMX', 'No sé, $c, parece que aún no has destruido suficientes.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11394 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11394, 'esES', '<Jaren parece estar muy ilusionado por lo que has logrado, pero te hace señas para que hables en voz muy baja.>$B$B¡Lo has hecho muy bien, $n! Pero si tienes baba de Plaga por todas partes... Deberías darte un chapuzón en la playa. El agua está fría, pero te quitará toda esa porquería rápidamente.', 18019),
(11394, 'esMX', '<Jaren parece estar muy ilusionado por lo que has logrado, pero te hace señas para que hables en voz muy baja.>$B$B¡Lo has hecho muy bien, $n! Pero si tienes baba de Plaga por todas partes... Deberías darte un chapuzón en la playa. El agua está fría, pero te quitará toda esa porquería rápidamente.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Miembro de la Plaga de Costafría muerto' WHERE `ID`=11394 AND `locale` IN ('esES', 'esMX');

-- Es un artefacto de la Plaga - ID 11395
DELETE FROM `quest_request_items_locale` WHERE `ID`=11395 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11395, 'esES', 'Qué artefacto tan extraño, $c. Déjame verlo de cerca.', 18019),
(11395, 'esMX', 'Qué artefacto tan extraño, $c. Déjame verlo de cerca.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11395 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11395, 'esES', '¡Sé lo que es! $n, ¡es un artefacto para controlar esos cristales apestadores!$B$BApuesto lo que sea a que puede usarse para cerrar sus campos de fuerza. Mmm...', 18019),
(11395, 'esMX', '¡Sé lo que es! $n, ¡es un artefacto para controlar esos cristales apestadores!$B$BApuesto lo que sea a que puede usarse para cerrar sus campos de fuerza. Mmm...', 18019);

-- Derriba esos escudos - ID 11396
DELETE FROM `quest_request_items_locale` WHERE `ID`=11396 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11396, 'esES', 'No sé, $n. Creo que tienes que sacar algunas cosas más de esas.', 18019),
(11396, 'esMX', 'No sé, $n. Creo que tienes que sacar algunas cosas más de esas.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11396 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11396, 'esES', '¡Bien!$B$B<Jaren mira rápidamente alrededor para asegurarse de que nadie se haya dado cuenta de su entusiasmo.>$B$BVale, creo que te has ganado tu parte de una de estas cosas que encontré cuando anduve por ahí abajo.$B$BY, $n, si por un casual te encontraras de nuevo en Las Puertas de Acero, transmítele mi amor a Irena y dile que estoy bien.', 18019),
(11396, 'esMX', '¡Bien!$B$B<Jaren mira rápidamente alrededor para asegurarse de que nadie se haya dado cuenta de su entusiasmo.>$B$BVale, creo que te has ganado tu parte de una de estas cosas que encontré cuando anduve por ahí abajo.$B$BY, $n, si por un casual te encontraras de nuevo en Las Puertas de Acero, transmítele mi amor a Irena y dile que estoy bien.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Cristales apestadores destruidos' WHERE `ID`=11396 AND `locale` IN ('esES', 'esMX');

-- Todo debe estar listo - ID 11406
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11406 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11406, 'esES', '¿Así que te envía el intendente?$B$B<Gil parece aliviado.>$B$BPara serte sincero, vamos un poco retrasados aquí y vamos a necesitar ayuda para cumplir nuestras metas.$B$B<Gil se estremece.>$B$BNinguno de los hombres quiere enfrentarse a la cólera del capitán Adams.', 18019),
(11406, 'esMX', '¿Así que te envía el intendente?$B$B<Gil parece aliviado.>$B$BPara serte sincero, vamos un poco retrasados aquí y vamos a necesitar ayuda para cumplir nuestras metas.$B$B<Gil se estremece.>$B$BNinguno de los hombres quiere enfrentarse a la cólera del capitán Adams.', 18019);

-- Aquel que se escapó - ID 11410
DELETE FROM `quest_request_items_locale` WHERE `ID`=11410 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11410, 'esES', 'Estoy deseando probar el nuevo cebo.$B$B¿Has tenido suerte con el Aleta de Escarcha?', 18019),
(11410, 'esMX', 'Estoy deseando probar el nuevo cebo.$B$B¿Has tenido suerte con el Aleta de Escarcha?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11410 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11410, 'esES', '¡Por fin podemos pescar en paz! Por supuesto, cuando pesquemos algo, la expedición llegará y lo reclamará como suyo.$B$BTienes todo nuestro agradecimiento, $n. No nos olvides.', 18019),
(11410, 'esMX', '¡Por fin podemos pescar en paz! Por supuesto, cuando pesquemos algo, la expedición llegará y lo reclamará como suyo.$B$BTienes todo nuestro agradecimiento, $n. No nos olvides.', 18019);

-- Hermanos traicioneros - ID 11414
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11414 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11414, 'esES', 'Me gusta el olor de su sangre sobre tu hocico. Los hermanos no deberían darse la espalda.', 18019),
(11414, 'esMX', 'Me gusta el olor de su sangre sobre tu hocico. Los hermanos no deberían darse la espalda.', 18019);

-- Los ojos del Águila - ID 11416
DELETE FROM `quest_request_items_locale` WHERE `ID`=11416 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11416, 'esES', '¿Tienes los ojos del Águila?', 18019),
(11416, 'esMX', '¿Tienes los ojos del Águila?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11416 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11416, 'esES', '<Ulkang aúlla con fuerza por la derrota de su gran enemiga.>$B$BEl honor de su muerte es tuyo. Me habría gustado que hubiesen sido mis fauces las que le apretaran la yugular.$B$BNo desperdiciemos el sacrificio que ha hecho por nosotros. Toma, ¡come!', 18019),
(11416, 'esMX', '<Ulkang aúlla con fuerza por la derrota de su gran enemiga.>$B$BEl honor de su muerte es tuyo. Me habría gustado que hubiesen sido mis fauces las que le apretaran la yugular.$B$BNo desperdiciemos el sacrificio que ha hecho por nosotros. Toma, ¡come!', 18019);

-- Lo llamamos "Pluma de Acero" - ID 11418
DELETE FROM `quest_request_items_locale` WHERE `ID`=11418 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11418, 'esES', '¿Ha funcionado el talismán de Aderan?', 18019),
(11418, 'esMX', '¿Ha funcionado el talismán de Aderan?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11418 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11418, 'esES', '¿Viste un nido con crías? Umm... Así que nuestro "él" es en realidad "ella", ¿eh?$B$BSupongo que eso lo explica todo. Supongo que yo tampoco querría desplazar un nido lleno de crías solo por tener un nuevo vecino.$B$B<Gil dedica una mueca a Trampero Jethan.>$B$BSeguro que nos llevaríamos bien si el viejo Jethan dejase de intentar hacerse un trofeo con ella.', 18019),
(11418, 'esMX', '¿Viste un nido con crías? Umm... Así que nuestro "él" es en realidad "ella", ¿eh?$B$BSupongo que eso lo explica todo. Supongo que yo tampoco querría desplazar un nido lleno de crías solo por tener un nuevo vecino.$B$B<Gil dedica una mueca a Trampero Jethan.>$B$BSeguro que nos llevaríamos bien si el viejo Jethan dejase de intentar hacerse un trofeo con ella.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Entérate del secreto de Pluma de Acero' WHERE `ID`=11418 AND `locale` IN ('esES', 'esMX');

-- El camino a la venganza - ID 11420
DELETE FROM `quest_request_items_locale` WHERE `ID`=11420 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11420, 'esES', '¿Has encontrado el manual?', 18019),
(11420, 'esMX', '¿Has encontrado el manual?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11420 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11420, 'esES', '<Zorek hojea el manual.>$B$BAjá... Interesante...$B$BSegún este manual, los vrykuls tienen una herramienta especial que les permite controlar los arpones con una precisión mortal. Se parece un poco al timón de uno de nuestros barcos. Además, es portátil y parece que se inserta en los arpones como si fuera una llave. ¡¡Tenemos que conseguir uno de esos!!', 18019),
(11420, 'esMX', '<Zorek hojea el manual.>$B$BAjá... Interesante...$B$BSegún este manual, los vrykuls tienen una herramienta especial que les permite controlar los arpones con una precisión mortal. Se parece un poco al timón de uno de nuestros barcos. Además, es portátil y parece que se inserta en los arpones como si fuera una llave. ¡¡Tenemos que conseguir uno de esos!!', 18019);

-- Estos llegan hasta el 11... - ID 11421
DELETE FROM `quest_request_items_locale` WHERE `ID`=11421 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11421, 'esES', '¿Está Poblado Calavermis en llamas?', 18019),
(11421, 'esMX', '¿Está Poblado Calavermis en llamas?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11421 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11421, 'esES', '¡Un trabajo excelente, $n! Te has llevado por delante a un buen montón de sus jinetes de dragones y has arruinado completamente su liderazgo.$B$B¿Estás preparado para volver a Valgarde e informar de la buena noticia a Zorek? Si la respuesta es sí, ¡tengo una locura en mente!', 18019),
(11421, 'esMX', '¡Un trabajo excelente, $n! Te has llevado por delante a un buen montón de sus jinetes de dragones y has arruinado completamente su liderazgo.$B$B¿Estás preparado para volver a Valgarde e informar de la buena noticia a Zorek? Si la respuesta es sí, ¡tengo una locura en mente!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Defensor Desuelladragones', `ObjectiveText2`='Casa comunal Desuelladragones destruida', `ObjectiveText3`='Caseta del muelle Desuelladragones destruida', `ObjectiveText4`='Almacén Desuelladragones destruido' WHERE `ID`=11421 AND `locale` IN ('esES', 'esMX');

-- Encontrar el mecanismo - ID 11426
DELETE FROM `quest_request_items_locale` WHERE `ID`=11426 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11426, 'esES', '¿Has encontrado el mecanismo?', 18019),
(11426, 'esMX', '¿Has encontrado el mecanismo?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11426 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11426, 'esES', '¡Excelente! ¡Esos simios grandullones se van a enterar de lo que es meterse con la Alianza!', 18019),
(11426, 'esMX', '¡Excelente! ¡Esos simios grandullones se van a enterar de lo que es meterse con la Alianza!', 18019);

-- Reúnete con el teniente Martillo de Hielo - ID 11427
DELETE FROM `quest_request_items_locale` WHERE `ID`=11427 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11427, 'esES', '¿Qué es esto? ¿Acaso parezco una niñera?', 18019),
(11427, 'esMX', '¿Qué es esto? ¿Acaso parezco una niñera?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11427 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11427, 'esES', '<El teniente Martillo de Hielo coge el mecanismo de control de arpón.>$B$B¡Ah, traes regalitos!', 18019),
(11427, 'esMX', '<El teniente Martillo de Hielo coge el mecanismo de control de arpón.>$B$B¡Ah, traes regalitos!', 18019);

-- Déjalo y ondéalo - ID 11429
DELETE FROM `quest_request_items_locale` WHERE `ID`=11429 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11429, 'esES', 'Veo que sigues con vida. Es evidente que no te estás esforzando lo suficiente.', 18019),
(11429, 'esMX', 'Veo que sigues con vida. Es evidente que no te estás esforzando lo suficiente.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11429 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11429, 'esES', '¡Por la Alianza! Eres fuerte, $n. Lo suficientemente fuerte como para machacar algunos cráneos vrykuls en Nafsavar.', 18019),
(11429, 'esMX', '¡Por la Alianza! Eres fuerte, $n. Lo suficientemente fuerte como para machacar algunos cráneos vrykuls en Nafsavar.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Estandarte de la Alianza colocado', `ObjectiveText2`='Estandarte de la Alianza defendido' WHERE `ID`=11429 AND `locale` IN ('esES', 'esMX');

-- Maestro arponero Yavus - ID 11430
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11430 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11430, 'esES', 'Les llevará algún tiempo encontrar al sustituto de Yavus. ¡Este es el mejor momento para dar rienda suelta al plan de Zorek! ¡Mientras estén intentando retomar el control de Nafsavar, vas a usar sus propios arpones contra ellos!', 18019),
(11430, 'esMX', 'Les llevará algún tiempo encontrar al sustituto de Yavus. ¡Este es el mejor momento para dar rienda suelta al plan de Zorek! ¡Mientras estén intentando retomar el control de Nafsavar, vas a usar sus propios arpones contra ellos!', 18019);

-- Gigantes durmientes - ID 11432
DELETE FROM `quest_request_items_locale` WHERE `ID`=11432 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11432, 'esES', '$n, me parece inverosímil que te hayas ocupado lo suficiente del vrykul latente. Vuelve cuando lo hayas hecho.', 18019),
(11432, 'esMX', '$n, me parece inverosímil que te hayas ocupado lo suficiente del vrykul latente. Vuelve cuando lo hayas hecho.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11432 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11432, 'esES', 'Has hecho lo que había que hacer. Aunque algunos consideren deshonroso matar a los indefensos, en este caso habrías estado loco si no lo hubieras hecho.$B$BY, por supuesto, no podríamos haberlos dejado allí para que despertaran mediante el ritual, ¿no es cierto?$B$BEs muy valiente lo que has hecho por todos nosotros en esas catacumbas, $n.', 18019),
(11432, 'esMX', 'Has hecho lo que había que hacer. Aunque algunos consideren deshonroso matar a los indefensos, en este caso habrías estado loco si no lo hubieras hecho.$B$BY, por supuesto, no podríamos haberlos dejado allí para que despertaran mediante el ritual, ¿no es cierto?$B$BEs muy valiente lo que has hecho por todos nosotros en esas catacumbas, $n.', 18019);

-- ¡Vamos a hacer surf! - ID 11436
DELETE FROM `quest_request_items_locale` WHERE `ID`=11436 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11436, 'esES', '<Zorek levanta una ceja hacia ti>.', 18019),
(11436, 'esMX', '<Zorek levanta una ceja hacia ti>.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11436 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11436, 'esES', '¡Estás chiflado, $n! ¿Pero qué tipo de degenerado utilizaría un arpón como medio de transporte?$B$BPero supongo que tienes que estar mal de la cabeza para hacer lo que hiciste en esos acantilados. ¡Bien hecho! Sabemos de buena tinta que el líder de los Desuelladragones, Ingvar, está furioso. Quizás un día estés preparado para pisotearle la cabeza dentro del barro... en nombre de nuestra querida Alianza.', 18019),
(11436, 'esMX', '¡Estás chiflado, $n! ¿Pero qué tipo de degenerado utilizaría un arpón como medio de transporte?$B$BPero supongo que tienes que estar mal de la cabeza para hacer lo que hiciste en esos acantilados. ¡Bien hecho! Sabemos de buena tinta que el líder de los Desuelladragones, Ingvar, está furioso. Quizás un día estés preparado para pisotearle la cabeza dentro del barro... en nombre de nuestra querida Alianza.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Ve a surfear con arpón' WHERE `ID`=11436 AND `locale` IN ('esES', 'esMX');
-- Submarinismo en Cubredaga - ID 11443
DELETE FROM `quest_request_items_locale` WHERE `ID`=11443 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11443, 'esES', '¿Has encontrado esos suministros?', 18019),
(11443, 'esMX', '¿Has encontrado esos suministros?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11443 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11443, 'esES', '¡Guau! Eres realmente eficiente. Bien, entrégame esos cajones. Tengo que documentarlos y hacer inventario y otro montón de cosas que tú no estás preparado para hacer ni para entender. No te preocupes; me aseguraré de informar a Keller del gran trabajo que has hecho allí abajo. Si, ahora puedes irte. ¡Sal pitando!', 18019),
(11443, 'esMX', '¡Guau! Eres realmente eficiente. Bien, entrégame esos cajones. Tengo que documentarlos y hacer inventario y otro montón de cosas que tú no estás preparado para hacer ni para entender. No te preocupes; me aseguraré de informar a Keller del gran trabajo que has hecho allí abajo. Si, ahora puedes irte. ¡Sal pitando!', 18019);

-- La Avanzada de la Liga de Expedicionarios - ID 11448
DELETE FROM `quest_request_items_locale` WHERE `ID`=11448 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11448, 'esES', '<Stanwad refunfuña.>', 18019),
(11448, 'esMX', '<Stanwad refunfuña.>', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11448 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11448, 'esES', '<Stanwad coge el fardo que le das y comienza a analizar los datos.>$B$BVaya. ¿Cuánta gente dices que ha visto esta información?$B$B<Stanwad sacude la cabeza.>$B$BTe alegrará saber que lo que McSorf y su banda de imbéciles han descubierto es una receta antigua de estofado de tundra. ¿No ha visto las representaciones de verduras comunes y el pictograma de una boca humanoide masticando dichas plantitas? ¡No se necesita nada para descifrar este puñetero código!', 18019),
(11448, 'esMX', '<Stanwad coge el fardo que le das y comienza a analizar los datos.>$B$BVaya. ¿Cuánta gente dices que ha visto esta información?$B$B<Stanwad sacude la cabeza.>$B$BTe alegrará saber que lo que McSorf y su banda de imbéciles han descubierto es una receta antigua de estofado de tundra. ¿No ha visto las representaciones de verduras comunes y el pictograma de una boca humanoide masticando dichas plantitas? ¡No se necesita nada para descifrar este puñetero código!', 18019);

-- El rey durmiente - ID 11452
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11452 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11452, 'esES', 'No sé si me acaba de gustar cómo suena eso. El Rey Exánime dándose a la fuga con Ymiron solo puede traernos problemas. Qué pena que no pudieras matarlo igual que hiciste con su reina.$B$BSin embargo, has puesto trabas a sus planes y nos has dado un tiempo precioso que necesitábamos.$B$BY, quién sabe, con esa facilidad que tienes para moverte por aquí, seguro que te vuelves a topar con el rey Ymiron. Seguro que no le va tan bien cuando volváis a encontraros.', 18019),
(11452, 'esMX', 'No sé si me acaba de gustar cómo suena eso. El Rey Exánime dándose a la fuga con Ymiron solo puede traernos problemas. Qué pena que no pudieras matarlo igual que hiciste con su reina.$B$BSin embargo, has puesto trabas a sus planes y nos has dado un tiempo precioso que necesitábamos.$B$BY, quién sabe, con esa facilidad que tienes para moverte por aquí, seguro que te vuelves a topar con el rey Ymiron. Seguro que no le va tan bien cuando volváis a encontraros.', 18019);

-- La confianza hay que ganársela - ID 11460
DELETE FROM `quest_request_items_locale` WHERE `ID`=11460 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11460, 'esES', 'Este ejercicio es importante, $n. Si vas a ser halconero, debes aprender a alimentar a tu pájaro.', 18019),
(11460, 'esMX', 'Este ejercicio es importante, $n. Si vas a ser halconero, debes aprender a alimentar a tu pájaro.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11460 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11460, 'esES', 'Sí, $n, ya puedo ver cómo se forma ese vínculo de compañerismo. Te ha aceptado como su amo.', 18019),
(11460, 'esMX', 'Sí, $n, ya puedo ver cómo se forma ese vínculo de compañerismo. Te ha aceptado como su amo.', 18019);

-- La caravana saqueada - ID 11465
DELETE FROM `quest_request_items_locale` WHERE `ID`=11465 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11465, 'esES', 'Tu falcón debe estar bien alimentado, de lo contrario se comerá la presa que le hayas encargado matar.', 18019),
(11465, 'esMX', 'Tu falcón debe estar bien alimentado, de lo contrario se comerá la presa que le hayas encargado matar.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11465 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11465, 'esES', 'Listos demonios. ¡Y pacientes! Tenemos que dejar de subestimar a nuestro enemigo. ¡Esos vrykuls son unos cazadores mortíferos!$B$BDe cualquier modo, misión cumplida. Quizás sea hora de que caces algo más escurridizo que un pavo gordo, ¿eh?', 18019),
(11465, 'esMX', 'Listos demonios. ¡Y pacientes! Tenemos que dejar de subestimar a nuestro enemigo. ¡Esos vrykuls son unos cazadores mortíferos!$B$BDe cualquier modo, misión cumplida. Quizás sea hora de que caces algo más escurridizo que un pavo gordo, ¿eh?', 18019);

-- Falcón contra halcón - ID 11468
DELETE FROM `quest_request_items_locale` WHERE `ID`=11468 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11468, 'esES', 'Tu falcón debe estar bien alimentado, de lo contrario se comerá la presa que le hayas encargado matar.', 18019),
(11468, 'esMX', 'Tu falcón debe estar bien alimentado, de lo contrario se comerá la presa que le hayas encargado matar.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11468 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11468, 'esES', 'Sí, los halcones son muy territoriales y a menudo viajan en bandadas. Supongo que podría haberte contado esto antes de mandarte al campo.', 18019),
(11468, 'esMX', 'Sí, los halcones son muy territoriales y a menudo viajan en bandadas. Supongo que podría haberte contado esto antes de mandarte al campo.', 18019);

-- No hay honor entre los pájaros - ID 11470
DELETE FROM `quest_request_items_locale` WHERE `ID`=11470 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11470, 'esES', 'Ahora estás al mando, $n. Guía a tu falcón y tráeme esos huevos.', 18019),
(11470, 'esMX', 'Ahora estás al mando, $n. Guía a tu falcón y tráeme esos huevos.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11470 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11470, 'esES', '¡Bravo, $n, bravo! ¡Los lazos que os unen a ti y a tu falcón son fuertes! Quizás podrías llevar a cabo otras misiones de reconocimiento contra los vrykuls en un futuro no muy lejano...', 18019),
(11470, 'esMX', '¡Bravo, $n, bravo! ¡Los lazos que os unen a ti y a tu falcón son fuertes! Quizás podrías llevar a cabo otras misiones de reconocimiento contra los vrykuls en un futuro no muy lejano...', 18019);

-- Problemas en la cima alta - ID 11474
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11474 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11474, 'esES', 'Casi la mitad de nuestro equipo está muerto o desaparecido, joven. Este es nuestro último puesto aquí en lo alto del acantilado. Esos malditos enanos férreos nos han echado de las Ruinas de Ivald y de la Excavación de Baelgun. Pero tengo un plan para que podamos volver antes de que escondan todos nuestros queridos tesoros y perdamos toda esa información para siempre.', 18019),
(11474, 'esMX', 'Casi la mitad de nuestro equipo está muerto o desaparecido, joven. Este es nuestro último puesto aquí en lo alto del acantilado. Esos malditos enanos férreos nos han echado de las Ruinas de Ivald y de la Excavación de Baelgun. Pero tengo un plan para que podamos volver antes de que escondan todos nuestros queridos tesoros y perdamos toda esa información para siempre.', 18019);

-- Herramientas para hacer el trabajo - ID 11475
DELETE FROM `quest_request_items_locale` WHERE `ID`=11475 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11475, 'esES', 'Paso 1: llevarle sus herramientas a Walt.', 18019),
(11475, 'esMX', 'Paso 1: llevarle sus herramientas a Walt.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11475 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11475, 'esES', 'Ahora que tengo mis herramientas puedo comenzar a construir. Bueno, en cuanto tenga los materiales. Eso es lo siguiente que me vas a conseguir.', 18019),
(11475, 'esMX', 'Ahora que tengo mis herramientas puedo comenzar a construir. Bueno, en cuanto tenga los materiales. Eso es lo siguiente que me vas a conseguir.', 18019);

-- ¿Fuera de mi elemento? - ID 11477
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11477 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11477, 'esES', 'Bien hecho, $n. Eso frenará un poco el proceso de enterramiento.', 18019),
(11477, 'esMX', 'Bien hecho, $n. Eso frenará un poco el proceso de enterramiento.', 18019);

-- Aquella avanzada... - ID 11478
DELETE FROM `quest_request_items_locale` WHERE `ID`=11478 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11478, 'esES', '¿Noticias de Donny?', 18019),
(11478, 'esMX', '¿Noticias de Donny?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11478 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11478, 'esES', 'Sí, esto no es nada que no sepamos ya. Al menos Donny sigue vivo.', 18019),
(11478, 'esMX', 'Sí, esto no es nada que no sepamos ya. Al menos Donny sigue vivo.', 18019);

-- Podemos reconstruirlo - ID 11483
DELETE FROM `quest_request_items_locale` WHERE `ID`=11483 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11483, 'esES', '¿Tienes los materiales para la infraestructura?', 18019),
(11483, 'esMX', '¿Tienes los materiales para la infraestructura?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11483 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11483, 'esES', 'Excelente. Combinados con la piel servirán para conseguir un clon perfecto del ensamblaje que utilizan los enanos férreos.', 18019),
(11483, 'esMX', 'Excelente. Combinados con la piel servirán para conseguir un clon perfecto del ensamblaje que utilizan los enanos férreos.', 18019);

-- Tenemos la tecnología - ID 11484
DELETE FROM `quest_request_items_locale` WHERE `ID`=11484 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11484, 'esES', '¡En un abrir y cerrar de ojos estaremos recogiendo nuestras reliquias de nuevo!', 18019),
(11484, 'esMX', '¡En un abrir y cerrar de ojos estaremos recogiendo nuestras reliquias de nuevo!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11484 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11484, 'esES', 'Tendré el ensamblaje preparado en cuanto la infraestructura esté completa.', 18019),
(11484, 'esMX', 'Tendré el ensamblaje preparado en cuanto la infraestructura esté completa.', 18019);

-- Ensamblajes Runaférrea y tú: salto con cohete - ID 11485
DELETE FROM `quest_request_items_locale` WHERE `ID`=11485 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11485, 'esES', 'No te dejes engañar por estos detractores.', 18019),
(11485, 'esMX', 'No te dejes engañar por estos detractores.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11485 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11485, 'esES', 'Ya estás casi listo para utilizar esta obra de arte en el terreno de juego, $n.', 18019),
(11485, 'esMX', 'Ya estás casi listo para utilizar esta obra de arte en el terreno de juego, $n.', 18019);

-- Ensamblajes Runaférrea y tú: recopilación de datos - ID 11489
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11489 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11489, 'esES', '¡Perfecto! ¡Funciona de maravilla!', 18019),
(11489, 'esMX', '¡Perfecto! ¡Funciona de maravilla!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Datos de la prueba recogidos' WHERE `ID`=11489 AND `locale` IN ('esES', 'esMX');

-- Ensamblajes Runaférrea y tú: el engaño - ID 11491
DELETE FROM `quest_request_items_locale` WHERE `ID`=11491 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11491, 'esES', 'No te preocupes por él, $n. Lo superará...', 18019),
(11491, 'esMX', 'No te preocupes por él, $n. Lo superará...', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11491 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11491, 'esES', '¡Le has dado una lección! Ya es hora de ponerte a trabajar.$B$BEspero que te sientas seguro...', 18019),
(11491, 'esMX', '¡Le has dado una lección! Ya es hora de ponerte a trabajar.$B$BEspero que te sientas seguro...', 18019);

-- Reliquias imbuidas de relámpagos - ID 11494
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11494 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11494, 'esES', '¡Y una vez más Walt vuelve a demostrar que es un enano fenomenal! ¿Qué te parece mi ensamblaje ahora, Lebronski?$B$BGracias, $n. Estos datos serán, sin duda, de gran valor... en cuanto averigüe cómo sacarlos del ensamblaje.', 18019),
(11494, 'esMX', '¡Y una vez más Walt vuelve a demostrar que es un enano fenomenal! ¿Qué te parece mi ensamblaje ahora, Lebronski?$B$BGracias, $n. Estos datos serán, sin duda, de gran valor... en cuanto averigüe cómo sacarlos del ensamblaje.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Datos Runaférrea recogidos' WHERE `ID`=11494 AND `locale` IN ('esES', 'esMX');

-- El delicado sonido del trueno - ID 11495
DELETE FROM `quest_request_items_locale` WHERE `ID`=11495 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11495, 'esES', '¿Ha tenido suerte?', 18019),
(11495, 'esMX', '¿Ha tenido suerte?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11495 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11495, 'esES', '¡Increíble! ¿Qué pueden estar tramando esas amenazas férreas? ¿Qué hacen en Las Cumbres Tormentosas? ¿Y qué es ese tal Loken? Enviaré esta información a nuestra base central de operaciones en el Cementerio de Dragones, $n. También les informaré de que has sido de gran valor para la obtención de dicha información.', 18019),
(11495, 'esMX', '¡Increíble! ¿Qué pueden estar tramando esas amenazas férreas? ¿Qué hacen en Las Cumbres Tormentosas? ¿Y qué es ese tal Loken? Enviaré esta información a nuestra base central de operaciones en el Cementerio de Dragones, $n. También les informaré de que has sido de gran valor para la obtención de dicha información.', 18019);

-- Noticias del este - ID 11501
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11501 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11501, 'esES', 'Magnífico... ¡Como si tener a toda la Plaga pegada a nuestro ya-sabes-qué no fuera suficiente, ahora tenemos que encargarnos de un antiguo ensamblaje titánico!$B$BNecesitaré un poco de tiempo para asimilar esta información, $r. Mientras tanto hay mucho trabajo que hacer aquí.', 18019),
(11501, 'esMX', 'Magnífico... ¡Como si tener a toda la Plaga pegada a nuestro ya-sabes-qué no fuera suficiente, ahora tenemos que encargarnos de un antiguo ensamblaje titánico!$B$BNecesitaré un poco de tiempo para asimilar esta información, $r. Mientras tanto hay mucho trabajo que hacer aquí.', 18019);

-- Orfus de Komawa - ID 11573
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11573 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11573, 'esES', '¿Colmillo Corto está vivo? Al menos tengo buenas noticias en este mal día...', 18019),
(11573, 'esMX', '¿Colmillo Corto está vivo? Al menos tengo buenas noticias en este mal día...', 18019);

-- Causas fundamentales - ID 11182
DELETE FROM `quest_request_items_locale` WHERE `ID`=11182 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11182, 'esES', '¿Cómo van tus esfuerzos contra los manipuladores entrometidos, pequeño?', 18019),
(11182, 'esMX', '¿Cómo van tus esfuerzos contra los manipuladores entrometidos, pequeño?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11182 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11182, 'esES', 'Es triste tener que hacer uso de un depredador para acabar con otro, pero es la ley de la naturaleza.$B$BQuizás ahora los protodracos y sus crías puedan vivir en paz de nuevo. Aunque sinceramente lo dudo desde el regreso de los vrykuls.', 18019),
(11182, 'esMX', 'Es triste tener que hacer uso de un depredador para acabar con otro, pero es la ley de la naturaleza.$B$BQuizás ahora los protodracos y sus crías puedan vivir en paz de nuevo. Aunque sinceramente lo dudo desde el regreso de los vrykuls.', 18019);

-- Espíritus del hielo - ID 11313
DELETE FROM `quest_request_items_locale` WHERE `ID`=11313 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11313, 'esES', '¿Has recuperado alguno de los núcleos?', 18019),
(11313, 'esMX', '¿Has recuperado alguno de los núcleos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11313 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11313, 'esES', '<Lurielle toma despacio los núcleos que le das.>$B$BGracias, $n.$B$BAmigos, os prometo que haré todo lo posible para recuperaros.', 18019),
(11313, 'esMX', '<Lurielle toma despacio los núcleos que le das.>$B$BGracias, $n.$B$BAmigos, os prometo que haré todo lo posible para recuperaros.', 18019);

-- Las hermanas caídas - ID 11314
DELETE FROM `quest_request_items_locale` WHERE `ID`=11314 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11314, 'esES', '¿Has podido curar a alguna de mis hermanas con el colgante?', 18019),
(11314, 'esMX', '¿Has podido curar a alguna de mis hermanas con el colgante?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11314 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11314, 'esES', '¿Así que aún hay esperanza para mis hermanas?$B$B<Lurielle aparta la vista de ti y después mira al suelo.>$B$BMe siento culpable por no haber pensado en el colgante antes. Podríamos haber salvado más de las hermanas.', 18019),
(11314, 'esMX', '¿Así que aún hay esperanza para mis hermanas?$B$B<Lurielle aparta la vista de ti y después mira al suelo.>$B$BMe siento culpable por no haber pensado en el colgante antes. Podríamos haber salvado más de las hermanas.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Ninfas escalofrío liberadas' WHERE `ID`=11314 AND `locale` IN ('esES', 'esMX');

-- Enredaderas salvajes - ID 11315
DELETE FROM `quest_request_items_locale` WHERE `ID`=11315 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11315, 'esES', '¿Has regresado del Claro Vibrante?', 18019),
(11315, 'esMX', '¿Has regresado del Claro Vibrante?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11315 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11315, 'esES', 'Te agradezco tu ayuda, $n. El Claro Vibrante era un bello lugar, y cuando regresemos a él volveremos a hacer que lo sea.', 18019),
(11315, 'esMX', 'Te agradezco tu ayuda, $n. El Claro Vibrante era un bello lugar, y cuando regresemos a él volveremos a hacer que lo sea.', 18019);

-- Engendros de El Claro Retorcido - ID 11316
DELETE FROM `quest_request_items_locale` WHERE `ID`=11316 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11316, 'esES', '¿Has visto los horrores del Claro Retorcido por ti mismo?', 18019),
(11316, 'esMX', '¿Has visto los horrores del Claro Retorcido por ti mismo?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11316 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11316, 'esES', 'Has obrado bien, $n. Si hubiésemos contado con aliados como tú cuando la tierra empezó a cambiar, quizás habríamos podido preservar algo de lo que perdimos.', 18019),
(11316, 'esMX', 'Has obrado bien, $n. Si hubiésemos contado con aliados como tú cuando la tierra empezó a cambiar, quizás habríamos podido preservar algo de lo que perdimos.', 18019);

-- Semillas de los vigilantes Almanegra - ID 11319
DELETE FROM `quest_request_items_locale` WHERE `ID`=11319 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11319, 'esES', 'El Claro Retorcido es un lugar terrible. Nunca imaginé que nuestros hogares pudieran convertirse en algo tan detestable.', 18019),
(11319, 'esMX', 'El Claro Retorcido es un lugar terrible. Nunca imaginé que nuestros hogares pudieran convertirse en algo tan detestable.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11319 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11319, 'esES', '¿Te funcionó el núcleo de hielo? Tendré que acordarme de eso. Seguro que los guardianes no se detendrán solo porque echemos a perder una vez su trabajo.', 18019),
(11319, 'esMX', '¿Te funcionó el núcleo de hielo? Tendré que acordarme de eso. Seguro que los guardianes no se detendrán solo porque echemos a perder una vez su trabajo.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Esporas congeladas' WHERE `ID`=11319 AND `locale` IN ('esES', 'esMX');

-- El tridente del hijo - ID 11422
DELETE FROM `quest_request_items_locale` WHERE `ID`=11422 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11422, 'esES', '<Uno de los cadavéricos ojos de pez del viejo Aleta Helada te observa buscando alguna señal del tridente de su hijo.>', 18019),
(11422, 'esMX', '<Uno de los cadavéricos ojos de pez del viejo Aleta Helada te observa buscando alguna señal del tridente de su hijo.>', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11422 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11422, 'esES', '<Al tomar el tridente de su hijo de tus manos, la mano del viejo Aleta Helada parece temblar un poco. ¿Es posible que el anciano múrloc esté entristecido?>$B$B<¿Es eso un poco de humedad acumulándose en la base de su ojo?>', 18019),
(11422, 'esMX', '<Al tomar el tridente de su hijo de tus manos, la mano del viejo Aleta Helada parece temblar un poco. ¿Es posible que el anciano múrloc esté entristecido?>$B$B<¿Es eso un poco de humedad acumulándose en la base de su ojo?>', 18019);

-- Vigilante Hojamarchita - ID 11428
DELETE FROM `quest_request_items_locale` WHERE `ID`=11428 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11428, 'esES', '¿Has librado al Claro Retorcido del vigilante Hojamarchita?', 18019),
(11428, 'esMX', '¿Has librado al Claro Retorcido del vigilante Hojamarchita?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11428 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11428, 'esES', 'Se me partió el corazón cuando supe que los vigilantes se habían vuelto contra nosotras. Antes los considerábamos como nuestros hermanos y amigos más allegados.$B$BSiento gran tristeza por los hermanos y hermanas que hemos perdido, pero sin tu ayuda no cabría esperanza alguna en nuestro futuro. Siempre serás bienvenido entre nosotras, $n.', 18019),
(11428, 'esMX', 'Se me partió el corazón cuando supe que los vigilantes se habían vuelto contra nosotras. Antes los considerábamos como nuestros hermanos y amigos más allegados.$B$BSiento gran tristeza por los hermanos y hermanas que hemos perdido, pero sin tu ayuda no cabría esperanza alguna en nuestro futuro. Siempre serás bienvenido entre nosotras, $n.', 18019);

-- Tesoro olvidado - ID 11434
DELETE FROM `quest_request_items_locale` WHERE `ID`=11434 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11434, 'esES', '¿Conseguiste mis reliquias, $n? Nadie consigue nada en esta vida por su cara bonita... ¡Ni siquiera yo!', 18019),
(11434, 'esMX', '¿Conseguiste mis reliquias, $n? Nadie consigue nada en esta vida por su cara bonita... ¡Ni siquiera yo!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11434 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11434, 'esES', 'Tú y yo vamos a viajar juntos, $n. Con mi cara bonita y tu... eh... actitud positiva, seguro que nos hacemos ricos.', 18019),
(11434, 'esMX', 'Tú y yo vamos a viajar juntos, $n. Con mi cara bonita y tu... eh... actitud positiva, seguro que nos hacemos ricos.', 18019);

-- El olor del dinero - ID 11455
DELETE FROM `quest_request_items_locale` WHERE `ID`=11455 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11455, 'esES', '¿Tienes el almizcle de oso para mí, colega?', 18019),
(11455, 'esMX', '¿Tienes el almizcle de oso para mí, colega?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11455 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11455, 'esES', '¡Excelente! Puede no ser algo tan atrevido como sumergirse en alta mar, ¡pero preferiría comerme una morsa con gastroenteritis antes que dejar escapar esta oportunidad!', 18019),
(11455, 'esMX', '¡Excelente! Puede no ser algo tan atrevido como sumergirse en alta mar, ¡pero preferiría comerme una morsa con gastroenteritis antes que dejar escapar esta oportunidad!', 18019);

-- Alimentar a los supervivientes - ID 11456
DELETE FROM `quest_request_items_locale` WHERE `ID`=11456 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11456, 'esES', '¿Has conseguido la carne que te pedí?', 18019),
(11456, 'esMX', '¿Has conseguido la carne que te pedí?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11456 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11456, 'esES', 'Gracias, $n. Mi pueblo está pasando por momentos de gran necesidad.', 18019),
(11456, 'esMX', 'Gracias, $n. Mi pueblo está pasando por momentos de gran necesidad.', 18019);

-- Armar a Komawa - ID 11457
DELETE FROM `quest_request_items_locale` WHERE `ID`=11457 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11457, 'esES', 'Me alegro de volver a verte, $r.', 18019),
(11457, 'esMX', 'Me alegro de volver a verte, $r.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11457 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11457, 'esES', 'Sigues demostrando tu valor como aliado, $n. Tus obras no caerán en el olvido.', 18019),
(11457, 'esMX', 'Sigues demostrando tu valor como aliado, $n. Tus obras no caerán en el olvido.', 18019);

-- Vengar a Iskaal - ID 11458
DELETE FROM `quest_request_items_locale` WHERE `ID`=11458 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11458, 'esES', '¿Has hecho lo que te pedí, $n?', 18019),
(11458, 'esMX', '¿Has hecho lo que te pedí, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11458 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11458, 'esES', 'Eres un aliado formidable, $n. Mi gente estará en deuda contigo eternamente.', 18019),
(11458, 'esMX', 'Eres un aliado formidable, $n. Mi gente estará en deuda contigo eternamente.', 18019);

-- Zeh'gehn dice - ID 11459
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11459 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11459, 'esES', "¿No has entendido nada de lo que te ha dicho Zeh'gehn? Bueno, claro que no.$B$BVeamos...", 18019),
(11459, 'esMX', "¿No has entendido nada de lo que te ha dicho Zeh'gehn? Bueno, claro que no.$B$BVeamos...", 18019);

-- Deuda de juego - ID 11464
DELETE FROM `quest_request_items_locale` WHERE `ID`=11464 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11464, 'esES', 'Has vuelto. ¿Has conseguido lo que se me debe?', 18019),
(11464, 'esMX', 'Has vuelto. ¿Has conseguido lo que se me debe?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11464 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11464, 'esES', 'Bien hecho. Aquí tienes tus cuartos, $n. Pero aún queda más por hacer.$B$BEn esta isla no faltan piratas morosos.', 18019),
(11464, 'esMX', 'Bien hecho. Aquí tienes tus cuartos, $n. Pero aún queda más por hacer.$B$BEn esta isla no faltan piratas morosos.', 18019);

-- A Jack le gusta su bebida - ID 11466
DELETE FROM `quest_request_items_locale` WHERE `ID`=11466 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11466, 'esES', '¿Has conseguido lo que es mío, $n?', 18019),
(11466, 'esMX', '¿Has conseguido lo que es mío, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11466 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11466, 'esES', 'Estoy impresionado, $n. Y no suelo impresionarme fácilmente.', 18019),
(11466, 'esMX', 'Estoy impresionado, $n. Y no suelo impresionarme fácilmente.', 18019);

-- La deuda de un hombre muerto - ID 11467
DELETE FROM `quest_request_items_locale` WHERE `ID`=11467 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11467, 'esES', '¿Has encontrado el tesoro, $n?', 18019),
(11467, 'esMX', '¿Has encontrado el tesoro, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11467 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11467, 'esES', 'Cogeré el oro, ya que es lo que Conrad me debía. El resto lo puedes guardar, es para ti.$B$BSi cualquier día necesitas algo más estable, podría conseguírtelo. Mientras tanto, espero que todo te vaya viento en popa, amigo.', 18019),
(11467, 'esMX', 'Cogeré el oro, ya que es lo que Conrad me debía. El resto lo puedes guardar, es para ti.$B$BSi cualquier día necesitas algo más estable, podría conseguírtelo. Mientras tanto, espero que todo te vaya viento en popa, amigo.', 18019);

-- Jabón - ID 11469
DELETE FROM `quest_request_items_locale` WHERE `ID`=11469 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11469, 'esES', '¿Dónde está esa grasa? Y no me digas que ya no tiene.$B$BEse Gran Roy es tan endemoniadamente grande que resulta increíble que aún pueda arrastrar el trasero por ahí.', 18019),
(11469, 'esMX', '¿Dónde está esa grasa? Y no me digas que ya no tiene.$B$BEse Gran Roy es tan endemoniadamente grande que resulta increíble que aún pueda arrastrar el trasero por ahí.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11469 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11469, 'esES', '¡¡Puaggh, es lo más pestilente que he olido nunca!!$B$BVenga, ponla ahí. Lanzaré mi hechizo ¡y seguro que se pone a soltar jabón!', 18019),
(11469, 'esMX', '¡¡Puaggh, es lo más pestilente que he olido nunca!!$B$BVenga, ponla ahí. Lanzaré mi hechizo ¡y seguro que se pone a soltar jabón!', 18019);

-- Se acabó lo que se daba - ID 11471
DELETE FROM `quest_request_items_locale` WHERE `ID`=11471 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11471, 'esES', 'Bueno, $n, ¿conseguiste el catalejo de Jonah?$B$BNo puedo tan solo fiarme de tu palabra, ¿sabes? Después de todo soy pirata.', 18019),
(11471, 'esMX', 'Bueno, $n, ¿conseguiste el catalejo de Jonah?$B$BNo puedo tan solo fiarme de tu palabra, ¿sabes? Después de todo soy pirata.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11471 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11471, 'esES', '¡Los días de Jonah Sterling han llegado a su fin! Nunca pensó que esta "zagala" lo conseguiría...$B$BCuando se corra la voz entre los piratas de que Jonah ha muerto, consolidaré mi liderazgo. Tus aliados no volverán a tener problemas con mi tripulación, $n.', 18019),
(11471, 'esMX', '¡Los días de Jonah Sterling han llegado a su fin! Nunca pensó que esta "zagala" lo conseguiría...$B$BCuando se corra la voz entre los piratas de que Jonah ha muerto, consolidaré mi liderazgo. Tus aliados no volverán a tener problemas con mi tripulación, $n.', 18019);

-- El camino a su corazón... - ID 11472
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11472 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11472, 'esES', '¡Qué buenas noticias! Ahora habrá más machos dominantes que crucen el estrecho para aparearse con las hembras. Pronto habrá un montón de nuevas crías en las islas.$B$BGracias, $r. Da igual lo que hayas hecho en tu pasado, ten siempre presente que ¡has ayudado mucho al futuro de Komawa!$B$BTendremos que seguir trabajando bien para que aumente su población. Por favor ven mañana para que podamos emparejar a más.', 18019),
(11472, 'esMX', '¡Qué buenas noticias! Ahora habrá más machos dominantes que crucen el estrecho para aparearse con las hembras. Pronto habrá un montón de nuevas crías en las islas.$B$BGracias, $r. Da igual lo que hayas hecho en tu pasado, ten siempre presente que ¡has ayudado mucho al futuro de Komawa!$B$BTendremos que seguir trabajando bien para que aumente su población. Por favor ven mañana para que podamos emparejar a más.', 18019);

-- Un traidor entre nosotros - ID 11473
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11473 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11473, 'esES', 'Qué bolá, asere. ¿Viniste tú a mí velme?', 18019),
(11473, 'esMX', 'Qué bolá, asere. ¿Viniste tú a mí velme?', 18019);

-- Un cuchillo y un croador - ID 11476
DELETE FROM `quest_request_items_locale` WHERE `ID`=11476 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11476, 'esES', "T'iés el croador y el maschete, tú, ¿verdá?", 18019),
(11476, 'esMX', "T'iés el croador y el maschete, tú, ¿verdá?", 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11476 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11476, 'esES', "Muchas grasias, camarada. ¡E'te croador parese de veldá!", 18019),
(11476, 'esMX', "Muchas grasias, camarada. ¡E'te croador parese de veldá!", 18019);

-- Dan "Pata de Cuervo" - ID 11479
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11479 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11479, 'esES', 'Esas son noticias tristes. Dan era mi viejo amigo... Y ADEMÁS me debía dinero. De todos modos, si estaba trabajando con esos chuchos del Mar del Sur, recibió su merecido.$B$BEn cuanto a ti, amigo, vas a subir cada vez más. En el sentido literal.', 18019),
(11479, 'esMX', 'Esas son noticias tristes. Dan era mi viejo amigo... Y ADEMÁS me debía dinero. De todos modos, si estaba trabajando con esos chuchos del Mar del Sur, recibió su merecido.$B$BEn cuanto a ti, amigo, vas a subir cada vez más. En el sentido literal.', 18019);

-- Conoce a la número dos - ID 11480
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11480 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11480, 'esES', 'Vaya, vaya, vaya, fíjate en quién tenemos aquí: a $n. Apareces en el Cabo Pillastre, y nadie ha oído hablar de ti excepto algún goblin amigo de ese cateto de Terry.$B$BDigamos que soy un poco... escéptica... sobre tus intenciones.', 18019),
(11480, 'esMX', 'Vaya, vaya, vaya, fíjate en quién tenemos aquí: a $n. Apareces en el Cabo Pillastre, y nadie ha oído hablar de ti excepto algún goblin amigo de ese cateto de Terry.$B$BDigamos que soy un poco... escéptica... sobre tus intenciones.', 18019);

-- ¡Los muertos se levantan! - ID 11504
DELETE FROM `quest_request_items_locale` WHERE `ID`=11504 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11504, 'esES', '¡Los colmillarr necesitan tu ayuda!', 18019),
(11504, 'esMX', '¡Los colmillarr necesitan tu ayuda!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11504 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11504, 'esES', '<A Orfus se le erizan los bigotes.>$B$BPiratas... ¿Es que su perversión no va a terminar nunca?$B$BDebemos recuperar los artefactos robados y devolverlos a este maldito lugar para que mi pueblo pueda volver a vivir en paz.', 18019),
(11504, 'esMX', '<A Orfus se le erizan los bigotes.>$B$BPiratas... ¿Es que su perversión no va a terminar nunca?$B$BDebemos recuperar los artefactos robados y devolverlos a este maldito lugar para que mi pueblo pueda volver a vivir en paz.', 18019);

-- El ancestro Atuik y Komawa - ID 11507
DELETE FROM `quest_request_items_locale` WHERE `ID`=11507 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11507, 'esES', '¿Noticias de Orfus?', 18019),
(11507, 'esMX', '¿Noticias de Orfus?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11507 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11507, 'esES', 'Orfus es un gran colmillarr, uno de nuestros mejores guerreros. Sabía que no nos defraudaría.$B$BPermíteme ver lo que has traído.', 18019),
(11507, 'esMX', 'Orfus es un gran colmillarr, uno de nuestros mejores guerreros. Sabía que no nos defraudaría.$B$BPermíteme ver lo que has traído.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11508 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11508, 'esES', 'Yarrr, colega. ¡A Grezzix no le gusta ensuciarse las manos! La vida del pirata es buena para Grezzik, siempre y cuando no tenga que hacer otras cosas.$B$BHe visto esos artefactos. ¡Ese es el motivo por el que estoy aquí y no en el Cabo Pillastre! Son cosas malas, malas...$B$BPero es tu vida, ¿verdad? Quieres entrar en Pillastre y Grezzix puede ayudarte.', 18019),
(11508, 'esMX', 'Yarrr, colega. ¡A Grezzix no le gusta ensuciarse las manos! La vida del pirata es buena para Grezzik, siempre y cuando no tenga que hacer otras cosas.$B$BHe visto esos artefactos. ¡Ese es el motivo por el que estoy aquí y no en el Cabo Pillastre! Son cosas malas, malas...$B$BPero es tu vida, ¿verdad? Quieres entrar en Pillastre y Grezzix puede ayudarte.', 18019);

-- "Credibilidad" callejera - ID 11509
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11509 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11509, 'esES', '<Harry levanta una ceja al verte.>$B$BAsí que eres cómo yo... ¿eh? Un poco excéntrico.$B$B<Harry susurra.>$B$BNadie se viste así por aquí.$B$BCon respecto a esos artefactos... Todo el que ha entrado en contacto con esas cosas ha terminado muerto, desaparecido o ambas cosas.$B$BSi aún quieres saber más sobre el asunto, puedo ayudarte: pero no será gratis.$B$B<Harry guiña un ojo.>$B$BTú velas por mis intereses y yo procuraré no darte una puñalada trapera.', 18019),
(11509, 'esMX', '<Harry levanta una ceja al verte.>$B$BAsí que eres cómo yo... ¿eh? Un poco excéntrico.$B$B<Harry susurra.>$B$BNadie se viste así por aquí.$B$BCon respecto a esos artefactos... Todo el que ha entrado en contacto con esas cosas ha terminado muerto, desaparecido o ambas cosas.$B$BSi aún quieres saber más sobre el asunto, puedo ayudarte: pero no será gratis.$B$B<Harry guiña un ojo.>$B$BTú velas por mis intereses y yo procuraré no darte una puñalada trapera.', 18019);

-- "Movidic" - ID 11510
DELETE FROM `quest_request_items_locale` WHERE `ID`=11510 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11510, 'esES', '¿Te has perdido?', 18019),
(11510, 'esMX', '¿Te has perdido?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11510 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11510, 'esES', '<Harry toma el cristal que le entregas y lo acaricia con mucho cariño.>$B$B¡Mi tesooooro! ¿Te ha hecho daño esa ballenota mala? Todo irá bien. ¡Nunca te volveré a perder de vista!$B$B<Harry levanta la vista y te mira.>$B$BEeh.. ¿por dónde estábamos?', 18019),
(11510, 'esMX', '<Harry toma el cristal que le entregas y lo acaricia con mucho cariño.>$B$B¡Mi tesooooro! ¿Te ha hecho daño esa ballenota mala? Todo irá bien. ¡Nunca te volveré a perder de vista!$B$B<Harry levanta la vista y te mira.>$B$BEeh.. ¿por dónde estábamos?', 18019);

-- El bastón de la Furia de la Tormenta - ID 11511
DELETE FROM `quest_request_items_locale` WHERE `ID`=11511 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11511, 'esES', '¿Tienes el bastón?', 18019),
(11511, 'esMX', '¿Tienes el bastón?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11511 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11511, 'esES', 'Debemos devolver todos los artefactos, $n. Cuando hayamos recuperado los cuatro, volveremos a meterlos en sus tumbas.', 18019),
(11511, 'esMX', 'Debemos devolver todos los artefactos, $n. Cuando hayamos recuperado los cuatro, volveremos a meterlos en sus tumbas.', 18019);

-- El corazón congelado de Isuldof - ID 11512
DELETE FROM `quest_request_items_locale` WHERE `ID`=11512 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11512, 'esES', '¿El... El corazón congelado de Isuldof?', 18019),
(11512, 'esMX', '¿El... El corazón congelado de Isuldof?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11512 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11512, 'esES', 'Debemos devolver todos los artefactos, $n. Cuando hayamos recuperado los cuatro, volveremos a meterlos en sus tumbas.', 18019),
(11512, 'esMX', 'Debemos devolver todos los artefactos, $n. Cuando hayamos recuperado los cuatro, volveremos a meterlos en sus tumbas.', 18019);

-- El escudo perdido de los Aesirites - ID 11519
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11519 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11519, 'esES', "¡Arrr, yo y mi tripulasión robamos ese escudo! ¡Hemos estao intentando recuperarlo de las susias manos d'ese marinero d'agua dulse Sorlof! ¿Vienes a ayudar?$B$BBueno, como puedes ver, llevamos una tripulasión d'esqueletos.$B$B<El Capitán Ellis se ríe.>$B$BEl Hermana Misericordia necesitará otro artillero pa manejar los cañones de la cubierta. ¿Quieres tú ayudal, compay?$B$B¡Ayúdame a derrotar a Sorlof y nos repartiremos el botín! Puedes quedarte con el escudo, mi tripulasión y yo nos quedamos lo demás.", 18019),
(11519, 'esMX', "¡Arrr, yo y mi tripulasión robamos ese escudo! ¡Hemos estao intentando recuperarlo de las susias manos d'ese marinero d'agua dulse Sorlof! ¿Vienes a ayudar?$B$BBueno, como puedes ver, llevamos una tripulasión d'esqueletos.$B$B<El Capitán Ellis se ríe.>$B$BEl Hermana Misericordia necesitará otro artillero pa manejar los cañones de la cubierta. ¿Quieres tú ayudal, compay?$B$B¡Ayúdame a derrotar a Sorlof y nos repartiremos el botín! Puedes quedarte con el escudo, mi tripulasión y yo nos quedamos lo demás.", 18019);

-- Motín en el Misericordia - ID 11527
DELETE FROM `quest_request_items_locale` WHERE `ID`=11527 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11527, 'esES', '¡Los lobos de mar amotinaos y los gigantes abundan!', 18019),
(11527, 'esMX', '¡Los lobos de mar amotinaos y los gigantes abundan!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11527 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11527, 'esES', '¡Espero que las traidoras ratas de bodega esas aprendieran la lesión!', 18019),
(11527, 'esMX', '¡Espero que las traidoras ratas de bodega esas aprendieran la lesión!', 18019);

-- El botín de Sorlof - ID 11529
DELETE FROM `quest_request_items_locale` WHERE `ID`=11529 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11529, 'esES', '¡Rápido, achantado!', 18019),
(11529, 'esMX', '¡Rápido, achantado!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11529 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11529, 'esES', '¡Un trato es un trato, persebe!', 18019),
(11529, 'esMX', '¡Un trato es un trato, persebe!', 18019);

-- El escudo de los Aesirites - ID 11530
DELETE FROM `quest_request_items_locale` WHERE `ID`=11530 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11530, 'esES', '¡Has vuelto!', 18019),
(11530, 'esMX', '¡Has vuelto!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11530 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11530, 'esES', 'Debemos devolver todos los artefactos, $n. Cuando hayamos recuperado los cuatro, volveremos a meterlos en sus tumbas.', 18019),
(11530, 'esMX', 'Debemos devolver todos los artefactos, $n. Cuando hayamos recuperado los cuatro, volveremos a meterlos en sus tumbas.', 18019);

-- La antigua armadura de los Kvaldir - ID 11567
DELETE FROM `quest_request_items_locale` WHERE `ID`=11567 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11567, 'esES', '¿Has encontrado la armadura?', 18019),
(11567, 'esMX', '¿Has encontrado la armadura?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11567 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11567, 'esES', 'Debemos devolver todos los artefactos, $n. Cuando hayamos recuperado los cuatro, volveremos a meterlos en sus tumbas.', 18019),
(11567, 'esMX', 'Debemos devolver todos los artefactos, $n. Cuando hayamos recuperado los cuatro, volveremos a meterlos en sus tumbas.', 18019);

-- Volver a descansar en paz - ID 11568
DELETE FROM `quest_request_items_locale` WHERE `ID`=11568 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11568, 'esES', '¿Está hecho? ¿Están los espíritus en reposo?', 18019),
(11568, 'esMX', '¿Está hecho? ¿Están los espíritus en reposo?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11568 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11568, 'esES', "Malas noticias, $n. Mi gente está en peligro y debemos advertirlos. Esas aberraciones marinas no tendrán piedad de los Kalu'ak.", 18019),
(11568, 'esMX', "Malas noticias, $n. Mi gente está en peligro y debemos advertirlos. Esas aberraciones marinas no tendrán piedad de los Kalu'ak.", 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Escudo de los Aesirites devuelto', `ObjectiveText2`='Bastón de la Furia de la Tormenta devuelto', `ObjectiveText3`='Corazón congelado de Isuldof devuelto', `ObjectiveText4`='Antigua armadura de los Kvaldir devuelta' WHERE `ID`=11568 AND `locale` IN ('esES', 'esMX');

-- Regresa junto a Atuik - ID 11572
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11572 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11572, 'esES', "Los Kalu'ak te agradecen todo lo que has hecho, $n. Ahora debemos prepararnos para la batalla y avisar a nuestros hermanos y hermanas al otro lado del mar sobre lo que se avecina.$B$BEspero que no sea demasiado tarde...", 18019),
(11572, 'esMX', "Los Kalu'ak te agradecen todo lo que has hecho, $n. Ahora debemos prepararnos para la batalla y avisar a nuestros hermanos y hermanas al otro lado del mar sobre lo que se avecina.$B$BEspero que no sea demasiado tarde...", 18019);

-- ¡A Utgarde! - ID 11252
DELETE FROM `quest_request_items_locale` WHERE `ID`=11252 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11252, 'esES', 'Es bueno ver que estás bien, $n.$B$BHemos tenido tantas bajas como podemos manejar.', 18019),
(11252, 'esMX', 'Es bueno ver que estás bien, $n.$B$BHemos tenido tantas bajas como podemos manejar.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11252 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11252, 'esES', '¡Extraordinario!$B$BEsto podría ser el giro de la suerte que todos hemos estado esperando.$B$B¡Bien hecho, $n!', 18019),
(11252, 'esMX', '¡Extraordinario!$B$BEsto podría ser el giro de la suerte que todos hemos estado esperando.$B$B¡Bien hecho, $n!', 18019);

-- Ajuste de cuentas - ID 11272
DELETE FROM `quest_request_items_locale` WHERE `ID`=11272 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11272, 'esES', 'Es bueno verte de nuevo, $n. A no ser que aún no hayas matado a esa aberración de elfo, en cuyo caso yo en tu lugar me pondría en marcha.', 18019),
(11272, 'esMX', 'Es bueno verte de nuevo, $n. A no ser que aún no hayas matado a esa aberración de elfo, en cuyo caso yo en tu lugar me pondría en marcha.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11272 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11272, 'esES', '¿Keleseth está fuera de juego? Excelente.$B$BEso hará que nuestra tarea aquí sea más sencilla.', 18019),
(11272, 'esMX', '¿Keleseth está fuera de juego? Excelente.$B$BEso hará que nuestra tarea aquí sea más sencilla.', 18019);

-- Desarme - ID 13205
DELETE FROM `quest_request_items_locale` WHERE `ID`=13205 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(13205, 'esES', '¿Has conseguido muchas hachas vrykul?', 18019),
(13205, 'esMX', '¿Has conseguido muchas hachas vrykul?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=13205 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(13205, 'esES', '<Mordun silba.>$B$BMíralas, son increíbles.$B$BCasi esperaba que estos neandertales estuvieran meneando palos y lanzando piedras.$B$BNo tengo tanta suerte...', 18019),
(13205, 'esMX', '<Mordun silba.>$B$BMíralas, son increíbles.$B$BCasi esperaba que estos neandertales estuvieran meneando palos y lanzando piedras.$B$BNo tengo tanta suerte...', 18019);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_16' WHERE sql_rev = '1646155636640613000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
