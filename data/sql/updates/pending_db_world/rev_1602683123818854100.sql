INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1602683123818854100');

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
