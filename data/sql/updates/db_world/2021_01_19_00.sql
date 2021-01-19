-- DB update 2021_01_18_03 -> 2021_01_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_18_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_18_03 2021_01_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1608817912001240800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1608817912001240800');

UPDATE `quest_template_locale` SET `ObjectiveText1`='Iniciado indigno dominado' WHERE `ID`=12848 AND `locale` IN ('esEs', 'esMX');
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12848 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12848, 'esES', 'Como esperaba, ¡mi caballero elegido ha triunfado! Estás listo, $n.', 18019),
(12848, 'esMX', 'Como esperaba, ¡mi caballero elegido ha triunfado! Estás listo, $n.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12636 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12636, 'esES', 'Se acerca la hora de derramar la sangre de nuestros enemigos. Antes de tirarte de cabeza a la batalla, debes conocer a quién intentas aniquilar. Es lo que diferencia a un caballero de la Muerte de un necrófago descerebrado.$B$BTe otorgaré visión más allá de la visión, mi campeón. Usarás el ojo de Acherus para robar los secretos de nuestros enemigos.', 18019),
(12636, 'esMX', 'Se acerca la hora de derramar la sangre de nuestros enemigos. Antes de tirarte de cabeza a la batalla, debes conocer a quién intentas aniquilar. Es lo que diferencia a un caballero de la Muerte de un necrófago descerebrado.$B$BTe otorgaré visión más allá de la visión, mi campeón. Usarás el ojo de Acherus para robar los secretos de nuestros enemigos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Forja de Nuevo Avalon analizada', `ObjectiveText2`='Concejo de Nuevo Avalon analizado', `ObjectiveText3`='Bastión Escarlata analizado', `ObjectiveText4`='Capilla de la Llama Carmesí analizada' WHERE `ID`=12641 AND `locale` IN ('esES', 'esMX');
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12641 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12641, 'esES', 'Se preparan para luchar como esperaba, pero hay algo más. Noto la presencia de un antiguo enemigo. Un enemigo que aniquilé hace mucho tiempo…$B$BNo importa. Enviaremos el poder de la Plaga al completo antes de que tengan la oportunidad de evacuar sus casas y poner sus defensas en posición.', 18019),
(12641, 'esMX', 'Se preparan para luchar como esperaba, pero hay algo más. Noto la presencia de un antiguo enemigo. Un enemigo que aniquilé hace mucho tiempo…$B$BNo importa. Enviaremos el poder de la Plaga al completo antes de que tengan la oportunidad de evacuar sus casas y poner sus defensas en posición.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12657 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12657, 'esES', 'Pronto resonará el eco de los cuernos de guerra por esta tierra, despertará a los muertos y llamará a la maquinaria de guerra de la Plaga. ¡Ay de aquellos que se crucen por nuestro camino!$B$BTú y tus hermanos dirigiréis la carga, $n. La próxima vez que mire hacia las tierras escarlata, las legiones de Acherus oscurecerán mi visión. La marcha hacia Nuevo Avalon empieza ahora.', 18019),
(12657, 'esMX', 'Pronto resonará el eco de los cuernos de guerra por esta tierra, despertará a los muertos y llamará a la maquinaria de guerra de la Plaga. ¡Ay de aquellos que se crucen por nuestro camino!$B$BTú y tus hermanos dirigiréis la carga, $n. La próxima vez que mire hacia las tierras escarlata, las legiones de Acherus oscurecerán mi visión. La marcha hacia Nuevo Avalon empieza ahora.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12850 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12850, 'esES', '¡La guerra ha empezado, caballero de la Muerte! Te daré mi mejor grifo para que te lleve hasta la Brecha de la Muerte. ¡Caos, muerte y destrucción! ¡Proclamarás todo esto y más!', 18019),
(12850, 'esMX', '¡La guerra ha empezado, caballero de la Muerte! Te daré mi mejor grifo para que te lleve hasta la Brecha de la Muerte. ¡Caos, muerte y destrucción! ¡Proclamarás todo esto y más!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12670 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12670, 'esES', '¿Lo hueles?$B$B<Valanar huele el aire.>$B$BCarne fresca… La esencia del Cruzado Escarlata se huele en el aire.$B$B<Valanar saliva.>$B$BDiscúlpame caballero de la Muerte, seguro que mi gusto por la cocina refinada no te interesa. ¡Estás aquí para trabajar! ¡Para dirigir la carga! Sí, lo sé. El Rey Exánime me ha contado todo lo que necesito sobre ti, $n.$B$BHa llegado la hora de derramar sangre.', 18019),
(12670, 'esMX', '¿Lo hueles?$B$B<Valanar huele el aire.>$B$BCarne fresca… La esencia del Cruzado Escarlata se huele en el aire.$B$B<Valanar saliva.>$B$BDiscúlpame caballero de la Muerte, seguro que mi gusto por la cocina refinada no te interesa. ¡Estás aquí para trabajar! ¡Para dirigir la carga! Sí, lo sé. El Rey Exánime me ha contado todo lo que necesito sobre ti, $n.$B$BHa llegado la hora de derramar sangre.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Cruzado Escarlata asesinado', `ObjectiveText2`='Ciudadano de Villa Refugio asesinado' WHERE `ID`=12678 AND `locale` IN ('esES', 'esMX');
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12678 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12678, 'esES', '¿Lo sientes, $n? Esta sensación es puro poder recorriendo tu cuerpo. Tal cosa no puede existir para los mortales.$B$BYa se han desmantelado las primeras filas. Los geists acabarán el trabajo y prepararán el terreno para Razuvious. Ahora debemos centrarnos en objetivos más tácticos.', 18019),
(12678, 'esMX', '¿Lo sientes, $n? Esta sensación es puro poder recorriendo tu cuerpo. Tal cosa no puede existir para los mortales.$B$BYa se han desmantelado las primeras filas. Los geists acabarán el trabajo y prepararán el terreno para Razuvious. Ahora debemos centrarnos en objetivos más tácticos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Caballo robado con éxito' WHERE `ID`=12680 AND `locale` IN ('esEs', 'esMX');
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12680 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12680, 'esES', 'Ahora la verdadera prueba. ¿Puedes dominar a un destrero suelto y coger brutalmente la cosa que más deseas?', 18019),
(12680, 'esMX', 'Ahora la verdadera prueba. ¿Puedes dominar a un destrero suelto y coger brutalmente la cosa que más deseas?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12687 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12687, 'esES', 'Has conseguido lo que la mayoría de principiantes no ha podido conseguir, $n. Por ello recibirás un buen premio.', 18019),
(12687, 'esMX', 'Has conseguido lo que la mayoría de principiantes no ha podido conseguir, $n. Por ello recibirás un buen premio.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Caballeros de la Muerte derrotados en duelo' WHERE `ID`=12733 AND `locale` IN ('esEs', 'esMX');
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12733 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12733, 'esES', '¡Después de la victoria viene la gloria, caballero de la Muerte! ¡Bien hecho! Hoy el Rey Exánime te mira con buenos ojos.', 18019),
(12733, 'esMX', '¡Después de la victoria viene la gloria, caballero de la Muerte! ¡Bien hecho! Hoy el Rey Exánime te mira con buenos ojos.', 18019);

UPDATE `creature_text` SET `BroadcastTextId`=29258 WHERE `CreatureID`=28406 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=29259 WHERE `CreatureID`=28406 AND `GroupID`=2 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=29260 WHERE `CreatureID`=28406 AND `GroupID`=3 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=29261 WHERE `CreatureID`=28406 AND `GroupID`=4 AND `ID`=0;

UPDATE `creature_text` SET `BroadcastTextId`=28790 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=28789 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=28793 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=28788 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=3;
UPDATE `creature_text` SET `BroadcastTextId`=28787 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=4;

UPDATE `creature_text` SET `BroadcastTextId`=28767 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=28764 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=1 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=28763 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=1 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=28765 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=1 AND `ID`=3;

UPDATE `creature_text` SET `BroadcastTextId`=28768 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=28766 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=28770 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=28769 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=3;
UPDATE `creature_text` SET `BroadcastTextId`=28792 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=4;

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12679 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12679, 'esES', '¡Bien hecho, caballero de la Muerte! ¡Alimentas la máquina de guerra de la Plaga con tus actos!$B$BAh sí, tu premio, como te prometí.', 18019),
(12679, 'esMX', '¡Bien hecho, caballero de la Muerte! ¡Alimentas la máquina de guerra de la Plaga con tus actos!$B$BAh sí, tu premio, como te prometí.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12679 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12679, 'esES', 'La mayoría de flechas han acabado en la trayectoria donde apuntan o cerca de la Granja de Villa Refugio, en el sur.', 18019),
(12679, 'esMX', 'La mayoría de flechas han acabado en la trayectoria donde apuntan o cerca de la Granja de Villa Refugio, en el sur.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12697 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12697, 'esES', 'Has luchado mucho para invadir el reino del Cosechador… Espera.$B$B<Gothik consulta sus notas.>$B$BDiscúlpame, $c. Cuesta cambiar las antiguas costumbres.$B$B¿Valanar te envió, entonces? Creo que eres bastante competente.$B$BTengo un regalo para los perros Escarlata. Uno que, estoy seguro, acelerará sus trabajos en las minas.', 18019),
(12697, 'esMX', 'Has luchado mucho para invadir el reino del Cosechador… Espera.$B$B<Gothik consulta sus notas.>$B$BDiscúlpame, $c. Cuesta cambiar las antiguas costumbres.$B$B¿Valanar te envió, entonces? Creo que eres bastante competente.$B$BTengo un regalo para los perros Escarlata. Uno que, estoy seguro, acelerará sus trabajos en las minas.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Necrófago escarlata convertido' WHERE `ID`=12698 AND `locale` IN ('esEs', 'esMX');

UPDATE `creature_text` SET `BroadcastTextId`=28941 WHERE `CreatureID`=28658 AND `GroupID`=0 AND `ID`=0;
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12698 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12698, 'esES', 'Ahora saben que las minas ya no son seguras. Doblarán sus esfuerzos en retirarse y ¡nos las dejarán libres para nosotros!', 18019),
(12698, 'esMX', 'Ahora saben que las minas ya no son seguras. Doblarán sus esfuerzos en retirarse y ¡nos las dejarán libres para nosotros!', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12698 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12698, 'esES', 'Una pequeña nota: los mineros no siempre se convierten en necrófago. A veces se convierten en espíritus enfurecidos, empeñados en matarte.', 18019),
(12698, 'esMX', 'Una pequeña nota: los mineros no siempre se convierten en necrófago. A veces se convierten en espíritus enfurecidos, empeñados en matarte.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12700 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12700, 'esES', 'Nos has hecho un buen servicio, caballero de la Muerte. Pocos de tus hermanos han sobrevivido nuestro ataque a los intrusos Escarlata. Eres uno de los más fuertes.$B$B<El príncipe Valanar asiente con la cabeza.>$B$BHacia el este, pasada la Mina Villa Refugio, está la costa llamada la Punta de la Luz por la Cruzada Escarlata. Un millar de soldados nos separa de sus barcos. ¿Insuperable? No lo creo...', 18019),
(12700, 'esMX', 'Nos has hecho un buen servicio, caballero de la Muerte. Pocos de tus hermanos han sobrevivido nuestro ataque a los intrusos Escarlata. Eres uno de los más fuertes.$B$B<El príncipe Valanar asiente con la cabeza.>$B$BHacia el este, pasada la Mina Villa Refugio, está la costa llamada la Punta de la Luz por la Cruzada Escarlata. Un millar de soldados nos separa de sus barcos. ¿Insuperable? No lo creo...', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Defensor escarlata asesinado' WHERE `ID`=12701 AND `locale` IN ('esEs', 'esMX');

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12701 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12701, 'esES', '¡La flota Escarlata al completo ha sido exterminada en cuestión de minutos! ¡Recibiré una mención de honor del Rey Exánime por esto! Todo lo que queda de la Cruzada Escarlata ahora son los ciudadanos de Nuevo Avalon.$B$BColocaré los ignitores y nigromantes en Villa Refugio inmediatamente. ¡Tú llevarás mi informe al Alto Señor!', 18019),
(12701, 'esMX', '¡La flota Escarlata al completo ha sido exterminada en cuestión de minutos! ¡Recibiré una mención de honor del Rey Exánime por esto! Todo lo que queda de la Cruzada Escarlata ahora son los ciudadanos de Nuevo Avalon.$B$BColocaré los ignitores y nigromantes en Villa Refugio inmediatamente. ¡Tú llevarás mi informe al Alto Señor!', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12706 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12706, 'esES', 'Estaba seguro de que no volverías aquí de una pieza, $c. Tal vez hay más de ti de lo que supuse al principio.', 18019),
(12706, 'esMX', 'Estaba seguro de que no volverías aquí de una pieza, $c. Tal vez hay más de ti de lo que supuse al principio.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12706 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12706, 'esES', '<Alto señor Darion Mograine lee el informe.>$B$B¿Toda la flota escarlata?$B$B<Alto señor Darion Mograine asiente con la cabeza.>$B$BTal poder, $n... No he visto tal despliegue de dominación en años... desde que mi padre ejerció...$B$BNo es importante...$B$BSí, su recomendación, no lo olvidaré.', 18019),
(12706, 'esMX', '<Alto señor Darion Mograine lee el informe.>$B$B¿Toda la flota escarlata?$B$B<Alto señor Darion Mograine asiente con la cabeza.>$B$BTal poder, $n... No he visto tal despliegue de dominación en años... desde que mi padre ejerció...$B$BNo es importante...$B$BSí, su recomendación, no lo olvidaré.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12714 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12714, 'esES', '¡Villa Refugio es nuestra! Un millar de cadáveres yacen en el suelo esperando pacientemente renacer. ¡Ahora atacamos a nuestro enemigo con la fuerza renacida de la Plaga!$B$BLos necrófagos ya han empezado su ataque en Nuevo Avalon. Nuestras fuerzas avanzan detrás de ellos y han tomado la Cripta de los Recuerdos.', 18019),
(12714, 'esMX', '¡Villa Refugio es nuestra! Un millar de cadáveres yacen en el suelo esperando pacientemente renacer. ¡Ahora atacamos a nuestro enemigo con la fuerza renacida de la Plaga!$B$BLos necrófagos ya han empezado su ataque en Nuevo Avalon. Nuestras fuerzas avanzan detrás de ellos y han tomado la Cripta de los Recuerdos.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12716 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12716, 'esES', '¿Has conseguido los objetos que te he pedido?', 18019),
(12716, 'esMX', '¿Has conseguido los objetos que te he pedido?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12716 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12716, 'esES', '¡Perfecto! Ahora dame un momento para poner todo en orden.', 18019),
(12716, 'esMX', '¡Perfecto! Ahora dame un momento para poner todo en orden.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12717 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12717, 'esES', 'La caldera de peste está parada.', 18019),
(12717, 'esMX', 'La caldera de peste está parada.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12717 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12717, 'esES', 'La caldera de peste cobra vida cuando pones las calaveras dentro.$B$BA los pocos segundos algunos viales de líquido negro flotan hasta arriba.', 18019),
(12717, 'esMX', 'La caldera de peste cobra vida cuando pones las calaveras dentro.$B$BA los pocos segundos algunos viales de líquido negro flotan hasta arriba.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12718 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12718, 'esES', 'El caldero de la plaga burbujea y agita su bebida tóxica, arrojando un gas espeso por todas partes.$B$B¿Tienes más cráneos de los Cruzados para colocarlos dentro?', 18019),
(12718, 'esMX', 'El caldero de la plaga burbujea y agita su bebida tóxica, arrojando un gas espeso por todas partes.$B$B¿Tienes más cráneos de los Cruzados para colocarlos dentro?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12718 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12718, 'esES', 'La caldera de peste cobra vida cuando las calaveras se ponen dentro.$B$BA los pocos segundos, la caldera de peste te ofrece el oscuro y espumoso esplendor del brebaje especial de Noth.', 18019),
(12718, 'esMX', 'La caldera de peste cobra vida cuando las calaveras se ponen dentro.$B$BA los pocos segundos, la caldera de peste te ofrece el oscuro y espumoso esplendor del brebaje especial de Noth.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12715 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12715, 'esES', 'Saludos, caballero de la Muerte. Soy el señor de sangre, Keleseth, gobernador de la parte sureste de Rasganorte. El Rey Exánime espera usar mis talentos para acabar con esta afrenta mortal a la Plaga. Me complace cumplir con todo lo que el Rey Exánime me pide. Claro está que un mar de infinitas almas para saciar mi sed endulzarán el trato, ¿no crees?', 18019),
(12715, 'esMX', 'Saludos, caballero de la Muerte. Soy el señor de sangre, Keleseth, gobernador de la parte sureste de Rasganorte. El Rey Exánime espera usar mis talentos para acabar con esta afrenta mortal a la Plaga. Me complace cumplir con todo lo que el Rey Exánime me pide. Claro está que un mar de infinitas almas para saciar mi sed endulzarán el trato, ¿no crees?', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Soldado de la Cruzada Escarlata asesinado', `ObjectiveText2`='Ciudadano de Nuevo Avalon asesinado' WHERE `id`=12722 AND `locale` IN ('esES', 'esMX');

DELETE FROM `quest_request_items_locale` WHERE `ID`=12719 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12719, 'esES', '¡No hay escapatoria!', 18019),
(12719, 'esMX', '¡No hay escapatoria!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12719 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12719, 'esES', 'El registro nos contará muchas cosas sobre los insectos Escarlatas.$B$B<Keleseth echa un vistazo rápido a las páginas del registro.>$B$BDatos sobre muertes, nacimientos, pero lo más importante, movimientos.$B$BMira aquí, $n, ya han enviado estas naves fuera. Déjame ver aquí… ¿Hacia dónde se dirigen?$B$B¿QUÉ? Es imposible. ¡Se dirigen hacia Rasganorte!$B$BJunto a las coordenadas figuran las palabras "Alba Carmesí".', 18019),
(12719, 'esMX', 'El registro nos contará muchas cosas sobre los insectos Escarlatas.$B$B<Keleseth echa un vistazo rápido a las páginas del registro.>$B$BDatos sobre muertes, nacimientos, pero lo más importante, movimientos.$B$BMira aquí, $n, ya han enviado estas naves fuera. Déjame ver aquí… ¿Hacia dónde se dirigen?$B$B¿QUÉ? Es imposible. ¡Se dirigen hacia Rasganorte!$B$BJunto a las coordenadas figuran las palabras "Alba Carmesí".', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12722 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12722, 'esES', 'Eres bastante eficaz con esa espada, $n. Quizá, con el permiso del Rey Exánime, ¿estarías interesado en convertirte en uno de mis subordinados? Stratholme está buscando un nuevo alcalde.', 18019),
(12722, 'esMX', 'Eres bastante eficaz con esa espada, $n. Quizá, con el permiso del Rey Exánime, ¿estarías interesado en convertirte en uno de mis subordinados? Stratholme está buscando un nuevo alcalde.', 18019);

UPDATE `creature_text` SET `BroadcastTextId`=29719 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=29721 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=29720 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=29716 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=3;
UPDATE `creature_text` SET `BroadcastTextId`=29717 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=4;

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12720 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12720, 'esES', '¿Un despertar? ¡No sabes lo que dices, $gchico:chica;! ¿Qué clase de loco dejaría a su gente en medio de los fríos baldíos? Puede que este mensajero tenga la respuesta.', 18019),
(12720, 'esMX', '¿Un despertar? ¡No sabes lo que dices, $gchico:chica;! ¿Qué clase de loco dejaría a su gente en medio de los fríos baldíos? Puede que este mensajero tenga la respuesta.', 18019);

UPDATE `creature_text` SET `BroadcastTextId`=29713 WHERE `CreatureID` IN (28936, 28610) AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=29715 WHERE `CreatureID` IN (28936, 28610) AND `GroupID`=0 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=29714 WHERE `CreatureID` IN (28936, 28610) AND `GroupID`=0 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=29716 WHERE `CreatureID` IN (28936, 28610) AND `GroupID`=0 AND `ID`=3;
UPDATE `creature_text` SET `BroadcastTextId`=29717 WHERE `CreatureID` IN (28936, 28610) AND `GroupID`=0 AND `ID`=4;

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12723 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12723, 'esES', 'Parece que aceptamos a cualquiera en la orden oscura estos días. Cuando me concedieron el don, las cosas eran distintas. ¡Muy distintas!$B$BY en lo que concierne a este mensajero...', 18019),
(12723, 'esMX', 'Parece que aceptamos a cualquiera en la orden oscura estos días. Cuando me concedieron el don, las cosas eran distintas. ¡Muy distintas!$B$BY en lo que concierne a este mensajero...', 18019);

UPDATE `creature_text` SET `BroadcastTextId`=29713 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=29715 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=29714 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=29716 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=3;
UPDATE `creature_text` SET `BroadcastTextId`=29717 WHERE `CreatureID`=28939 AND `GroupID`=0 AND `ID`=4;

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12725 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12725, 'esES', 'Has hecho una tontería al venir a buscarme. He fracasado. Tendrías que haberme dado por muerto. Ahora nos pueden matar a los dos.$B$B<Koltira sacude la cabeza>$B$BSomos caballeros de la Muerte de la Plaga. Esto infringe nuestro pacto de hermandad oscura.$B$BThassarian, ¡maldito necio!', 18019),
(12725, 'esMX', 'Has hecho una tontería al venir a buscarme. He fracasado. Tendrías que haberme dado por muerto. Ahora nos pueden matar a los dos.$B$B<Koltira sacude la cabeza>$B$BSomos caballeros de la Muerte de la Plaga. Esto infringe nuestro pacto de hermandad oscura.$B$BThassarian, ¡maldito necio!', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12727 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12727, 'esES', '¿Qué pasa con Koltira?', 18019),
(12727, 'esMX', '¿Qué pasa con Koltira?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12727 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12727, 'esES', '¡Voy a alimentar a los necrófagos con la cabeza de este monstruo!$B$B<Thassarian lanza la cabeza a la habitación trasera.>$B$B¿Se escapó Koltira?$B$B<Thassarian hace una pausa.>$B$BSeguro que sí. Aquellas paredes no pueden pararlo.$B$BEs la hora de la venganza.', 18019),
(12727, 'esMX', '¡Voy a alimentar a los necrófagos con la cabeza de este monstruo!$B$B<Thassarian lanza la cabeza a la habitación trasera.>$B$B¿Se escapó Koltira?$B$B<Thassarian hace una pausa.>$B$BSeguro que sí. Aquellas paredes no pueden pararlo.$B$BEs la hora de la venganza.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12724 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12724, 'esES', '¡Devasta el bastión! ¡El horario está ahí!', 18019),
(12724, 'esMX', '¡Devasta el bastión! ¡El horario está ahí!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12724 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12724, 'esES', '<Orbaz ojea el horario por encima.>$B$B¡Estos cretinos despreciables han estado ocupados! Rutas de patrullas del norte, rutas de patrullas del sur, rutas de patrullas del oeste y rutas de patrullas del este. Pero nada sobre las rutas de sus mensajeros. Espera un momento, ¿qué es esto? Parece una ruta de patrulla del oeste que viene de las Tierras de la Peste del Oeste. ¡Esta patrulla llegará hasta aquí hoy! Necesitaré tiempo para ingeniar un plan.', 18019),
(12724, 'esMX', '<Orbaz ojea el horario por encima.>$B$B¡Estos cretinos despreciables han estado ocupados! Rutas de patrullas del norte, rutas de patrullas del sur, rutas de patrullas del oeste y rutas de patrullas del este. Pero nada sobre las rutas de sus mensajeros. Espera un momento, ¿qué es esto? Parece una ruta de patrulla del oeste que viene de las Tierras de la Peste del Oeste. ¡Esta patrulla llegará hasta aquí hoy! Necesitaré tiempo para ingeniar un plan.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12738 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12738, 'esES', 'Solo son de carne y hueso, no son rival para la Plaga.$B$BNo encontramos a ninguno de nuestros hermanos, pero tropezamos con algo especial.', 18019),
(12738, 'esMX', 'Solo son de carne y hueso, no son rival para la Plaga.$B$BNo encontramos a ninguno de nuestros hermanos, pero tropezamos con algo especial.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12742 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12742, 'esES', '¿Cómo se siente?', 18019),
(12742, 'esMX', '¿Cómo se siente?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12742 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12742, 'esES', 'Se sintió bien, ¿no? Ya no eres uno de ellos, $n. Eres plaga. Eres uno de nosotros. Para siempre...', 18019),
(12742, 'esMX', 'Se sintió bien, ¿no? Ya no eres uno de ellos, $n. Eres plaga. Eres uno de nosotros. Para siempre...', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12751 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12751, 'esES', '¡Otra victoria de la Plaga! Estos perros escarlata no tienen ningún otro lugar donde huir y esconderse. Ahora tan solo es una cuestión de tiempo...', 18019),
(12751, 'esMX', '¡Otra victoria de la Plaga! Estos perros escarlata no tienen ningún otro lugar donde huir y esconderse. Ahora tan solo es una cuestión de tiempo...', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12754 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12754, 'esES', 'Perderás al mensajero y luego estaré obligado a matarte. Por estar obligado quiero decir que será un placer acabar con tu vida.$B$B¡DATE PRISA!', 18019),
(12754, 'esMX', 'Perderás al mensajero y luego estaré obligado a matarte. Por estar obligado quiero decir que será un placer acabar con tu vida.$B$B¡DATE PRISA!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12754 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12754, 'esES', '<Orbaz lee el mensaje.>$B$BEl ejército de Vega del Amparo y Tirisfal se dirigirán a la masacre.$B$B<Orbaz sonríe.>$B$BAhora a por la segunda parte del plan. Entregarás este mensaje en mano a la alta general Abbendis. La ropa te servirá para esto...', 18019),
(12754, 'esMX', '<Orbaz lee el mensaje.>$B$BEl ejército de Vega del Amparo y Tirisfal se dirigirán a la masacre.$B$B<Orbaz sonríe.>$B$BAhora a por la segunda parte del plan. Entregarás este mensaje en mano a la alta general Abbendis. La ropa te servirá para esto...', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12755 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12755, 'esES', '¿Dónde has estado? Llegas con dos horas de retraso. Estábamos a punto de enviar un mensajero al alto comandante.', 18019),
(12755, 'esMX', '¿Dónde has estado? Llegas con dos horas de retraso. Estábamos a punto de enviar un mensajero al alto comandante.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12755 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12755, 'esES', '<La alta general Abbendis lee el mensaje.>$B$B¡Maldito sea! ¡Los ejércitos de Vega del Amparo y Tirisfal no tienen que llegar hasta Nuevo Avalon! La plaga los matará a todos salvajemente.', 18019),
(12755, 'esMX', '<La alta general Abbendis lee el mensaje.>$B$B¡Maldito sea! ¡Los ejércitos de Vega del Amparo y Tirisfal no tienen que llegar hasta Nuevo Avalon! La plaga los matará a todos salvajemente.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12756 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12756, 'esES', '<Orbaz se ríe.>$B$B¿Qué es esto? ¿Un libro para niños?', 18019),
(12756, 'esMX', '<Orbaz se ríe.>$B$B¿Qué es esto? ¿Un libro para niños?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12756 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12756, 'esES', "<Orbaz ojea el diario.>$B$B¡Qué porquería! ¿Esto es el 'Alba Carmesí'?$B$B¡Navegan hacia la muerte! Vamos a centrarnos en los ejércitos invasores.", 18019),
(12756, 'esMX', "<Orbaz ojea el diario.>$B$B¡Qué porquería! ¿Esto es el 'Alba Carmesí'?$B$B¡Navegan hacia la muerte! Vamos a centrarnos en los ejércitos invasores.", 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12757 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12757, 'esES', '¿Qué has hecho?', 18019),
(12757, 'esMX', '¿Qué has hecho?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12757 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12757, 'esES', '¡Te has convertido en una máquina de matar, caballero de la Muerte! ¡Arrasaremos con estos ejércitos que se aproximan enseñándoles lo que es la muerte!', 18019),
(12757, 'esMX', '¡Te has convertido en una máquina de matar, caballero de la Muerte! ¡Arrasaremos con estos ejércitos que se aproximan enseñándoles lo que es la muerte!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12778 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12778, 'esES', 'Me has servido bien, $n. La marca de la Plaga se ha quemado en estas tierras Escarlatas. Has cosechado muerte y destrucción hasta donde puede alcanzar la vista y me has ofrecido el último ejército escarlata.$B$BAhora es hora de que acabes lo que empezaste.', 18019),
(12778, 'esMX', 'Me has servido bien, $n. La marca de la Plaga se ha quemado en estas tierras Escarlatas. Has cosechado muerte y destrucción hasta donde puede alcanzar la vista y me has ofrecido el último ejército escarlata.$B$BAhora es hora de que acabes lo que empezaste.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Soldados escarlata matados', `ObjectiveText2`='Balista escarlata aniquilado'  WHERE `ID`=12779 AND `locale` IN ('esEs', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `ID`=12779 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12779, 'esES', 'Mátalos a todos...', 18019),
(12779, 'esMX', 'Mátalos a todos...', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12779 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12779, 'esES', 'Arrodíllate, campeón. Te pongo este casco para completar tu cara de terror. Cualquiera que se atreva a mirar tu rostro oscuro sabrá que la muerte se acerca. No dejes que nadie se atreva a acercarse tanto a tu rey de manera que pueda hacer frente a tu ira despiadada, $n.$B$BSolo queda una tarea final pendiente…$B$BLa Capilla de la Esperanza de la Luz.', 18019),
(12779, 'esMX', 'Arrodíllate, campeón. Te pongo este casco para completar tu cara de terror. Cualquiera que se atreva a mirar tu rostro oscuro sabrá que la muerte se acerca. No dejes que nadie se atreva a acercarse tanto a tu rey de manera que pueda hacer frente a tu ira despiadada, $n.$B$BSolo queda una tarea final pendiente…$B$BLa Capilla de la Esperanza de la Luz.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12800 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12800, 'esES', '¡El Alto Señor y los otros caballeros de la Muerte están preparando el ataque! Aplastaremos todo lo que queda de vida en este lugar.', 18019),
(12800, 'esMX', '¡El Alto Señor y los otros caballeros de la Muerte están preparando el ataque! Aplastaremos todo lo que queda de vida en este lugar.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='La luz del alba descubierta' WHERE `ID`=12801 AND `locale` IN ('esEs', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `ID`=12801 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(12801, 'esES', '<Darion Mograine asiente con la cabeza.>', 18019),
(12801, 'esMX', '<Darion Mograine asiente con la cabeza.>', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12801 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(12801, 'esES', 'No habrá compensación para nosotros, $n. Estamos condenados a vagar por la tierra como monstruos. El Rey Exánime nos ha liberado de su control, pero los espectros del pasado permanecerán en nuestros recuerdos para siempre.$B$BTenemos que enmendar de la única manera que sabemos: con la muerte…$B$BAhora te ordeno que te unas a mí y a Acherus como caballero de la Espada de Ébano. Juntos acabaremos con el Rey Exánime y pondremos fin a la Plaga.', 18019),
(12801, 'esMX', 'No habrá compensación para nosotros, $n. Estamos condenados a vagar por la tierra como monstruos. El Rey Exánime nos ha liberado de su control, pero los espectros del pasado permanecerán en nuestros recuerdos para siempre.$B$BTenemos que enmendar de la única manera que sabemos: con la muerte…$B$BAhora te ordeno que te unas a mí y a Acherus como caballero de la Espada de Ébano. Juntos acabaremos con el Rey Exánime y pondremos fin a la Plaga.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=13165 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(13165, 'esES', 'El Rey Exánime, herido por la Crematoria, ha vuelto a Rasganorte, pero los últimos soldados aún resisten en el segundo piso.', 18019),
(13165, 'esMX', 'El Rey Exánime, herido por la Crematoria, ha vuelto a Rasganorte, pero los últimos soldados aún resisten en el segundo piso.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Remendejo', `ObjectiveText2`='Miembro de la Plaga asesinado'  WHERE `ID`=13166 AND `locale` IN ('esEs', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `ID`=13166 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(13166, 'esES', '¡Acherus será nuestro!', 18019),
(13166, 'esMX', '¡Acherus será nuestro!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=13166 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(13166, 'esES', 'Bien hecho, caballero de la Muerte. Se ocuparán de los quedan de la Plaga pronto y el proceso de reconstrucción comenzará de nuevo.$B$BPero tengo una última tarea para ti.', 18019),
(13166, 'esMX', 'Bien hecho, caballero de la Muerte. Se ocuparán de los quedan de la Plaga pronto y el proceso de reconstrucción comenzará de nuevo.$B$BPero tengo una última tarea para ti.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=13188 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(13188, 'esES', 'Te quedan pocos momentos de vida.', 18019),
(13188, 'esMX', 'Te quedan pocos momentos de vida.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=13188 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(13188, 'esES', '<Varian Wrynn mira a la distancia.>$B$BClaro, viejo amigo... Sangre y honor.$B$B<Varian Wrynn fija su mirada en ti.>$B$BSi no fuera por esta carta de Tirion, llevarías grilletes. Solo la protección de uno de los más grandes paladines que han existido podría asegurar tu supervivencia.$B$BNosotros... lucharemos juntos contra la Plaga. ¡Contra el Rey Exánime!$B$B¡GLORIA A LA ALIANZA!', 18019),
(13188, 'esMX', '<Varian Wrynn mira a la distancia.>$B$BClaro, viejo amigo... Sangre y honor.$B$B<Varian Wrynn fija su mirada en ti.>$B$BSi no fuera por esta carta de Tirion, llevarías grilletes. Solo la protección de uno de los más grandes paladines que han existido podría asegurar tu supervivencia.$B$BNosotros... lucharemos juntos contra la Plaga. ¡Contra el Rey Exánime!$B$B¡GLORIA A LA ALIANZA!', 18019);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
