INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1602401464629835600');

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
