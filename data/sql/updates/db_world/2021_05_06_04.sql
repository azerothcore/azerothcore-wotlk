-- DB update 2021_05_06_03 -> 2021_05_06_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_06_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_06_03 2021_05_06_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619816909908602400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619816909908602400');

-- 8978 Regresa junto a Mokvar
-- https://es.classic.wowhead.com/quest=8978
SET @ID := 8978;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has vuelto con el dispositivo?', 0),
(@ID, 'esMX', '¿Has vuelto con el dispositivo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Has vuelto con el dispositivo! Estoy impresionado por tu dedicación, $n. Excelente trabajo.', 0),
(@ID, 'esMX', '¡Has vuelto con el dispositivo! Estoy impresionado por tu dedicación, $n. Excelente trabajo.', 0);
-- 8979 El presentimiento de Fenstad
-- https://es.classic.wowhead.com/quest=8979
SET @ID := 8979;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Cómo puedo servirte?', 0),
(@ID, 'esMX', '¿Cómo puedo servirte?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Otra de las obsesiones de Fenstad, ya veo. ¿Cree que la Real Sociedad de Boticarios no tiene nada mejor que hacer que realizar sus pequeñas investigaciones?$B$BMuy bien, lo complaceré una vez más.', 0),
(@ID, 'esMX', 'Otra de las obsesiones de Fenstad, ya veo. ¿Cree que la Real Sociedad de Boticarios no tiene nada mejor que hacer que realizar sus pequeñas investigaciones?$B$BMuy bien, lo complaceré una vez más.', 0);
-- 8980 La evaluación de Zinge
-- https://es.classic.wowhead.com/quest=8980
SET @ID := 8980;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Entonces, estaba en lo cierto. No debemos perder el tiempo. Debemos determinar la fuente de estas fragancias contaminadas.$B$BEsto es para reembolsarte la compra de la colonia y el perfume.', 0),
(@ID, 'esMX', 'Entonces, estaba en lo cierto. No debemos perder el tiempo. Debemos determinar la fuente de estas fragancias contaminadas.$B$BEsto es para reembolsarte la compra de la colonia y el perfume.', 0);
-- 8982 Rastrear la fuente
-- https://es.classic.wowhead.com/quest=8982
SET @ID := 8982;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, sí, recientemente recibí stock del perfume y la colonia. No sé cuánto tiempo puedo mantenerlo en los estantes, parece que nadie tiene suficiente.$B$BSi me preguntas, no veo cuál es el problema.', 0),
(@ID, 'esMX', 'Ah, sí, recientemente recibí stock del perfume y la colonia. No sé cuánto tiempo puedo mantenerlo en los estantes, parece que nadie tiene suficiente.$B$BSi me preguntas, no veo cuál es el problema.', 0);
-- 8983 Rastrear la fuente
-- https://es.classic.wowhead.com/quest=8983
SET @ID := 8983;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Me temo que vendí todo mi suministro de perfume y colonia a Norman, el posadero. Si deseas algo, debes hablar con él, asumiendo que le quede algo.$B$BAdemás, no deberías perder el tiempo. Creo que la colonia te resultará irresistible.', 0),
(@ID, 'esMX', 'Me temo que vendí todo mi suministro de perfume y colonia a Norman, el posadero. Si deseas algo, debes hablar con él, asumiendo que le quede algo.$B$BAdemás, no deberías perder el tiempo. Creo que la colonia te resultará irresistible.', 0);
-- 8984 El descubrimiento de la fuente
-- https://es.classic.wowhead.com/quest=8984
SET @ID := 8984;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, hice esas fragancias. Maravilloso olor, ¿no? Irresistible.$B$BUna vez que los guerreros de la Alianza y la Horda estén enamorados con estos sentimientos de amor, serán impotentes para detener el surgimiento del Consejo de la Sombra.$B$BEstarán debilitados, desprevenidos. Mientras se preocupan por sus seres queridos, perderán su ventaja.$B$BLa solución fue tan simple. ¿Por qué me tomó tanto tiempo encontrarlo? La debilidad de todos es a través del corazón. Y no hay nada que puedas hacer para detener lo inevitable.', 0),
(@ID, 'esMX', 'Sí, hice esas fragancias. Maravilloso olor, ¿no? Irresistible.$B$BUna vez que los guerreros de la Alianza y la Horda estén enamorados con estos sentimientos de amor, serán impotentes para detener el surgimiento del Consejo de la Sombra.$B$BEstarán debilitados, desprevenidos. Mientras se preocupan por sus seres queridos, perderán su ventaja.$B$BLa solución fue tan simple. ¿Por qué me tomó tanto tiempo encontrarlo? La debilidad de todos es a través del corazón. Y no hay nada que puedas hacer para detener lo inevitable.', 0);
-- 8985 Más componentes importantes
-- https://es.classic.wowhead.com/quest=8985
SET @ID := 8985;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c ¿Has regresado ya con lo que te envié a recoger?', 0),
(@ID, 'esMX', '$c ¿Has regresado ya con lo que te envié a recoger?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo bien hecho, $n. Imbuiré la esencia de la reliquia en el blandón.$B$BAhora todo lo que queda es ir al Santuario de Eldretharr en el ala este de La Masacre, y usar el blandón para convocar el espíritu de mi antigua cohorte, Isalien. Su espíritu ha sido corrompido por la posesión de la pieza del amuleto de Valthalak y la porción de su alma dentro de ella.$B$BOh, por cierto, me sobraron algunas algas de sangre de tu viaje a la Isla de Alcaz, así que las convertí en pociones para ti. ¡Elige una!', 0),
(@ID, 'esMX', 'Un trabajo bien hecho, $n. Imbuiré la esencia de la reliquia en el blandón.$B$BAhora todo lo que queda es ir al Santuario de Eldretharr en el ala este de La Masacre, y usar el blandón para convocar el espíritu de mi antigua cohorte, Isalien. Su espíritu ha sido corrompido por la posesión de la pieza del amuleto de Valthalak y la porción de su alma dentro de ella.$B$BOh, por cierto, me sobraron algunas algas de sangre de tu viaje a la Isla de Alcaz, así que las convertí en pociones para ti. ¡Elige una!', 0);
-- 8986 Más componentes importantes
-- https://es.classic.wowhead.com/quest=8986
SET @ID := 8986;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c ¿Has regresado ya con lo que te envié a recoger?', 0),
(@ID, 'esMX', '$c ¿Has regresado ya con lo que te envié a recoger?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo bien hecho, $n. Imbuiré la esencia de los restos en el blandón.$B$BAhora todo lo que queda es ir a la parte inferior de Cumbre de Roca Negra, a la cámara donde reside el Maestro de Guerra Voone en Tazz\'Alaor, y usar el blandón para convocar al espíritu corrupto de mi antiguo cohorte, Mor Pezuña Gris. No puede descansar hasta que le quiten la pieza del amuleto.$B$BOh, por cierto, me sobraron algunas algas de sangre de tu viaje a la isla de Alcaz, así que te las convertí en pociones. ¡Elige una!', 0),
(@ID, 'esMX', 'Un trabajo bien hecho, $n. Imbuiré la esencia de los restos en el blandón.$B$BAhora todo lo que queda es ir a la parte inferior de Cumbre de Roca Negra, a la cámara donde reside el Maestro de Guerra Voone en Tazz\'Alaor, y usar el blandón para convocar al espíritu corrupto de mi antiguo cohorte, Mor Pezuña Gris. No puede descansar hasta que le quiten la pieza del amuleto.$B$BOh, por cierto, me sobraron algunas algas de sangre de tu viaje a la isla de Alcaz, así que te las convertí en pociones. ¡Elige una!', 0);
-- 8987 Más componentes importantes
-- https://es.classic.wowhead.com/quest=8987
SET @ID := 8987;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c ¿Has regresado ya con lo que te envié a recoger?', 0),
(@ID, 'esMX', '$c ¿Has regresado ya con lo que te envié a recoger?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo bien hecho, $n. Imbuiré la esencia de la espada en el blandón.$B$BAhora todo lo que queda es entrar en El Trono Carmesí dentro del Bastión Escarlata en Stratholme, y usar el blandón para convocar los restos de mis antiguos cohortes, Jarien y Sothos. Sus almas se han torcido aún más por la posesión de la pieza de amuleto de Valthalak y su espíritu dentro.$B$BOh, por cierto, me sobraron algunas algas de sangre de tu viaje a la isla de Alcaz, así que te las convertí en pociones. ¡Elige una!', 0),
(@ID, 'esMX', 'Un trabajo bien hecho, $n. Imbuiré la esencia de la espada en el blandón.$B$BAhora todo lo que queda es entrar en El Trono Carmesí dentro del Bastión Escarlata en Stratholme, y usar el blandón para convocar los restos de mis antiguos cohortes, Jarien y Sothos. Sus almas se han torcido aún más por la posesión de la pieza de amuleto de Valthalak y su espíritu dentro.$B$BOh, por cierto, me sobraron algunas algas de sangre de tu viaje a la isla de Alcaz, así que te las convertí en pociones. ¡Elige una!', 0);
-- 8988 Más componentes importantes
-- https://es.classic.wowhead.com/quest=8988
SET @ID := 8988;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c ¿Has regresado ya con lo que te envié a recoger?', 0),
(@ID, 'esMX', '$c ¿Has regresado ya con lo que te envié a recoger?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo bien hecho, $n. Imbuiré la esencia de las cenizas en el blandón.$B$BAhora todo lo que queda es entrar en Scholomance, en la cámara de Ras Murmuhielo, y usar el blandón para invocar el espíritu de mi antiguo cohorte, Kormok. La pieza del amuleto y el espíritu de Valthalak en su interior lo han corrompido aún más, y no descansará hasta que se lo quites por la fuerza.$B$BOh, por cierto, me sobraron algunas algas de sangre de tu viaje a la isla de Alcaz, así que te las convertí en pociones. ¡Elige una!', 0),
(@ID, 'esMX', 'Un trabajo bien hecho, $n. Imbuiré la esencia de las cenizas en el blandón.$B$BAhora todo lo que queda es entrar en Scholomance, en la cámara de Ras Murmuhielo, y usar el blandón para invocar el espíritu de mi antiguo cohorte, Kormok. La pieza del amuleto y el espíritu de Valthalak en su interior lo han corrompido aún más, y no descansará hasta que se lo quites por la fuerza.$B$BOh, por cierto, me sobraron algunas algas de sangre de tu viaje a la isla de Alcaz, así que te las convertí en pociones. ¡Elige una!', 0);
-- 8989 La parte derecha del amuleto de Lord Valthalak
-- https://es.classic.wowhead.com/quest=8989
SET @ID := 8989;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Entonces está hecho? ¿Ha recuperado la parte derecha del amuleto de Lord Valthalak, has unido el amuleto en un todo y finalmente has puesto a descansar el espíritu de mi antiguo compañero, Mor Pezuña Gris?', 0),
(@ID, 'esMX', '¿Entonces está hecho? ¿Ha recuperado la parte derecha del amuleto de Lord Valthalak, has unido el amuleto en un todo y finalmente has puesto a descansar el espíritu de mi antiguo compañero, Mor Pezuña Gris?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias por ayudar a Mor Pezuña Gris, $n. Otro espíritu descansa en paz, ¡y ahora tenemos el amuleto reensamblado! Pero todavía tenemos la prueba más difícil por delante.$B$BPara que el blandón esté en sintonía con la llamada de Lord Valthalak, hay algunos elementos más que debes ser recolectar y traerlos aquí.', 0),
(@ID, 'esMX', 'Gracias por ayudar a Mor Pezuña Gris, $n. Otro espíritu descansa en paz, ¡y ahora tenemos el amuleto reensamblado! Pero todavía tenemos la prueba más difícil por delante.$B$BPara que el blandón esté en sintonía con la llamada de Lord Valthalak, hay algunos elementos más que debes ser recolectar y traerlos aquí.', 0);
-- 8990 La parte derecha del amuleto de Lord Valthalak
-- https://es.classic.wowhead.com/quest=8990
SET @ID := 8990;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Seguramente aún no te has ocupado de la salvación del espíritu de Isalien y la recuperación de la parte derecha del amuleto de Lord Valthalak, $n. Asegúrate de volver a combinar las piezas del amuleto antes de dármelo.', 0),
(@ID, 'esMX', 'Seguramente aún no te has ocupado de la salvación del espíritu de Isalien y la recuperación de la parte derecha del amuleto de Lord Valthalak, $n. Asegúrate de volver a combinar las piezas del amuleto antes de dármelo.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias, $n, por hacer descansar el espíritu de Isalien. Ahora, tal vez, encontrará la paz con su diosa. ¡Y también tenemos el amuleto reensamblado! Pero todavía tenemos la prueba más difícil por delante.$B$BPara que el blandón esté en sintonía con la llamada de Lord Valthalak, hay algunos elementos más que debes recolectar y traer hasta aquí.', 0),
(@ID, 'esMX', 'Gracias, $n, por hacer descansar el espíritu de Isalien. Ahora, tal vez, encontrará la paz con su diosa. ¡Y también tenemos el amuleto reensamblado! Pero todavía tenemos la prueba más difícil por delante.$B$BPara que el blandón esté en sintonía con la llamada de Lord Valthalak, hay algunos elementos más que debes recolectar y traer hasta aquí.', 0);
-- 8991 La parte derecha del amuleto de Lord Valthalak
-- https://es.classic.wowhead.com/quest=8991
SET @ID := 8991;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c, ¿Esto significa que ya has puesto a descansar las almas de esos dos tontos y has recombinado las piezas del amuleto de Lord Valthalak?', 0),
(@ID, 'esMX', '$c, ¿Esto significa que ya has puesto a descansar las almas de esos dos tontos y has recombinado las piezas del amuleto de Lord Valthalak?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Supongo que es lo mejor que las almas de esos dos finalmente hayan descansado, incluso si no me agradaron mientras estaban vivos. En cualquier caso, tenemos lo que buscábamos, ¡y ahora el amuleto está reensamblado! Pero todavía tenemos la prueba más difícil por delante.$B$BPara que el blandón esté en sintonía con la llamada de Lord Valthalak, hay algunos elementos más que debes recolectar y traers de regreso aquí.', 0),
(@ID, 'esMX', 'Supongo que es lo mejor que las almas de esos dos finalmente hayan descansado, incluso si no me agradaron mientras estaban vivos. En cualquier caso, tenemos lo que buscábamos, ¡y ahora el amuleto está reensamblado! Pero todavía tenemos la prueba más difícil por delante.$B$BPara que el blandón esté en sintonía con la llamada de Lord Valthalak, hay algunos elementos más que debes recolectar y traers de regreso aquí.', 0);
-- 8992 La parte derecha del amuleto de Lord Valthalak
-- https://es.classic.wowhead.com/quest=8992
SET @ID := 8992;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te felicito, $n, si has regresado con el amuleto completo. Sin embargo, si no es así, ocúpate de eso, ya que no hay tiempo que perder, ¡te lo aseguro!', 0),
(@ID, 'esMX', 'Te felicito, $n, si has regresado con el amuleto completo. Sin embargo, si no es así, ocúpate de eso, ya que no hay tiempo que perder, ¡te lo aseguro!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Buen trabajo, $n! Kormok no fue tan malo para un ogro, al menos no mientras aún estaba vivo, así que espero que obtenga el descanso que se merece. ¡Y ahora tenemos el amuleto completo! Pero todavía tenemos la prueba más difícil por delante.$B$BPara que el blandón esté en sintonía con la llamada de Lord Valthalak, hay algunos elementos más que debes recolectar y traer de regreso aquí.', 0),
(@ID, 'esMX', '¡Buen trabajo, $n! Kormok no fue tan malo para un ogro, al menos no mientras aún estaba vivo, así que espero que obtenga el descanso que se merece. ¡Y ahora tenemos el amuleto completo! Pero todavía tenemos la prueba más difícil por delante.$B$BPara que el blandón esté en sintonía con la llamada de Lord Valthalak, hay algunos elementos más que debes recolectar y traer de regreso aquí.', 0);
-- 8993 Ofrecer regalos
-- https://es.classic.wowhead.com/quest=8993
SET @ID := 8993;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Magnífico! Lo pondré con los demás regalos.$B$B¡No esperaba tantos! Desde luego, sabéis cómo honrar a los jefes.$B$BBueno, uno más para la lista...', 0),
(@ID, 'esMX', '¡Magnífico! Lo pondré con los demás regalos.$B$B¡No esperaba tantos! Desde luego, sabéis cómo honrar a los jefes.$B$BBueno, uno más para la lista...', 0);
-- 8994 Últimos preparativos
-- https://es.classic.wowhead.com/quest=8994
SET @ID := 8994;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Hemos recorrido un largo camino, $n, y solo quería decir que pase lo que pase, ¡gracias! Te has puesto en peligro de muerte para tratar de ayudar a los miembros supervivientes de nuestra compañía mercenaria, La Hoja Velada, y en lo que a mí respecta, ahora eres uno de nosotros.', 0),
(@ID, 'esMX', 'Hemos recorrido un largo camino, $n, y solo quería decir que pase lo que pase, ¡gracias! Te has puesto en peligro de muerte para tratar de ayudar a los miembros supervivientes de nuestra compañía mercenaria, La Hoja Velada, y en lo que a mí respecta, ahora eres uno de nosotros.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Eso es. Extraeré el metal de los brazaletes e impregnaré el blandón con estos componentes finales. Entonces estará listo para que convoques a Lord Valthalak y, finalmente, le devuelvas su amuleto espiritual.$B$BHas recorrido una gran distancia, $n, ¡no vaciles ahora que el final está a la vista!', 0),
(@ID, 'esMX', 'Eso es. Extraeré el metal de los brazaletes e impregnaré el blandón con estos componentes finales. Entonces estará listo para que convoques a Lord Valthalak y, finalmente, le devuelvas su amuleto espiritual.$B$BHas recorrido una gran distancia, $n, ¡no vaciles ahora que el final está a la vista!', 0);
-- 8995 Mea Culpa, Lord Valthalak
-- https://es.classic.wowhead.com/quest=8995
SET @ID := 8995;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$n, ¡te atreves a perturbar mi descanso!', 0),
(@ID, 'esMX', '$n, ¡te atreves a perturbar mi descanso!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Qué suerte para ti que sé que no eres parte del grupo original que me robó esto.$B$B¡Recuperaré lo que es mío ahora, mortal! ¡Dame el amuleto!', 0),
(@ID, 'esMX', 'Qué suerte para ti que sé que no eres parte del grupo original que me robó esto.$B$B¡Recuperaré lo que es mío ahora, mortal! ¡Dame el amuleto!', 0);
-- 8996 Regresa junto a Bodley
-- https://es.classic.wowhead.com/quest=8996
SET @ID := 8996;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$n, ¡has vuelto y sigues con vida! Bueno, al menos eso te convierte en uno de nosotros.$B$B¡Vas a tener que contármelo todo!', 0),
(@ID, 'esMX', '$n, ¡has vuelto y sigues con vida! Bueno, al menos eso te convierte en uno de nosotros.$B$B¡Vas a tener que contármelo todo!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Realmente dijo todo eso? Vaya, no puedo creer que vaya a despedir a los asesinos espectrales y acechadores, incluso si insinuó que causaría más daño a mis compañeros vivos en el futuro.$B$B¡Este es un gran día, $n! Has logrado lo que pocos pudieron y nos has absuelto al menos en parte de algunos de nuestros pecados pasados.$B$B¡Gracias! Como muestra de agradecimiento, me gustaría darte esto. Puedes usarlo para convocar espíritus en los mismos lugares encantados que ya conoces, y también en algunos otros.', 0),
(@ID, 'esMX', '¿Realmente dijo todo eso? Vaya, no puedo creer que vaya a despedir a los asesinos espectrales y acechadores, incluso si insinuó que causaría más daño a mis compañeros vivos en el futuro.$B$B¡Este es un gran día, $n! Has logrado lo que pocos pudieron y nos has absuelto al menos en parte de algunos de nuestros pecados pasados.$B$B¡Gracias! Como muestra de agradecimiento, me gustaría darte esto. Puedes usarlo para convocar espíritus en los mismos lugares encantados que ya conoces, y también en algunos otros.', 0);
-- 8997 Regreso al principio
-- https://es.classic.wowhead.com/quest=8997
SET @ID := 8997;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estoy muy feliz de verte regresar a mí $gsano y salvo:sana y salva;, $n. Te ves bien, si no un poco peor por el desgaste.$B$BVen, cuéntame todo lo que ha sucedido.', 0),
(@ID, 'esMX', 'Estoy muy feliz de verte regresar a mí $gsano y salvo:sana y salva;, $n. Te ves bien, si no un poco peor por el desgaste.$B$BVen, cuéntame todo lo que ha sucedido.', 0);
-- 8998 Regreso al principio
-- https://es.classic.wowhead.com/quest=8998
SET @ID := 8998;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Me alegra ver que has sobrevivido, $n. Te ves bien, si no un poco más $gcansado:cansada;.$B$BVen, cuéntame todo lo que ha sucedido.', 0),
(@ID, 'esMX', 'Me alegra ver que has sobrevivido, $n. Te ves bien, si no un poco más $gcansado:cansada;.$B$BVen, cuéntame todo lo que ha sucedido.', 0);
-- 8999 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=8999
SET @ID := 8999;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De acuerdo con nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Corazón Salvaje a cambio de tu nuevo jubón y capucha Cueroferal?', 0),
(@ID, 'esMX', 'De acuerdo con nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Corazón Salvaje a cambio de tu nuevo jubón y capucha Cueroferal?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0),
(@ID, 'esMX', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0);
-- 9000 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9000
SET @ID := 9000;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Acechabestias a cambio de tu nuevo almete y manto de maestro de bestias?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Acechabestias a cambio de tu nuevo almete y manto de maestro de bestias?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0),
(@ID, 'esMX', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0);
-- 9001 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9001
SET @ID := 9001;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar las piezas de tu magister a cambio de tu nueva corona y toga de hechicero?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar las piezas de tu magister a cambio de tu nueva corona y toga de hechicero?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0),
(@ID, 'esMX', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0);
-- 9002 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9002
SET @ID := 9002;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas Forjaluz a cambio de tu nuevo casco y coraza Forjaalma?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas Forjaluz a cambio de tu nuevo casco y coraza Forjaalma?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0),
(@ID, 'esMX', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0);
-- 9003 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9003
SET @ID := 9003;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de devoto a cambio de tu nueva corona y túnica virtuosas?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de devoto a cambio de tu nueva corona y túnica virtuosas?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0),
(@ID, 'esMX', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0);
-- 9004 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9004
SET @ID := 9004;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de arte sombrío a cambio de tu nueva almete y túnica Mantoscuro?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de arte sombrío a cambio de tu nueva almete y túnica Mantoscuro?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0),
(@ID, 'esMX', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0);
-- 9005 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9005
SET @ID := 9005;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de calígine a cambio de tu nueva máscara y túnica de Brumamorta?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de calígine a cambio de tu nueva máscara y túnica de Brumamorta?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0),
(@ID, 'esMX', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0);
-- 9006 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9006
SET @ID := 9006;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Valor a cambio de tu nuevo Yelmo y Peto de heroísmo?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Valor a cambio de tu nuevo Yelmo y Peto de heroísmo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0),
(@ID, 'esMX', 'Te voy a extrañar, $n. Te debo una gran deuda de gratitud; Creo que nunca podré devolverlo.$B$BEspero que disfrutes de tu nueva armadura para la cabeza y el pecho, y que te proteja durante mucho tiempo.', 0);
-- 9007 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9007
SET @ID := 9007;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De acuerdo con nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Corazón Salvaje a cambio de tu nuevo chaleco y capucha de Cueroferal?', 0),
(@ID, 'esMX', 'De acuerdo con nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Corazón Salvaje a cambio de tu nuevo chaleco y capucha de Cueroferal?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0),
(@ID, 'esMX', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0);
-- 9008 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9008
SET @ID := 9008;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de acechabestias a cambio de tu nueva gorra y túnica de maestro de bestias?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de acechabestias a cambio de tu nueva gorra y túnica de maestro de bestias?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0),
(@ID, 'esMX', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0);
-- 9009 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9009
SET @ID := 9009;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de devoto a cambio de tu nueva corona y túnica virtuosas?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de devoto a cambio de tu nueva corona y túnica virtuosas?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0),
(@ID, 'esMX', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0);
-- 9010 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9010
SET @ID := 9010;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de arte sombrío a cambio de tu nueva gorra y túnica Mantoscuro?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de arte sombrío a cambio de tu nueva gorra y túnica Mantoscuro?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0),
(@ID, 'esMX', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0);
-- 9011 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9011
SET @ID := 9011;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de elementos a cambio de tu nueva Almófar y Jubón de los Cinco Truenos?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de elementos a cambio de tu nueva Almófar y Jubón de los Cinco Truenos?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0),
(@ID, 'esMX', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0);
-- 9012 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9012
SET @ID := 9012;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas calígine a cambio de tu nueva Máscara y Toga Brumamorta?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas calígine a cambio de tu nueva Máscara y Toga Brumamorta?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0),
(@ID, 'esMX', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0);
-- 9013 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9013
SET @ID := 9013;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Valor a cambio de tu nuevo Yelmo y Coraza de heroísmo?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar tus piezas de Valor a cambio de tu nuevo Yelmo y Coraza de heroísmo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0),
(@ID, 'esMX', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0);

-- 9014 Guardar lo mejor para el final
-- https://es.classic.wowhead.com/quest=9014
SET @ID := 9014;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Según nuestro trato, ¿estás $glisto:lista; para entregar las piezas de magister a cambio de tu nueva corona y toga de hechicero?', 0),
(@ID, 'esMX', 'Según nuestro trato, ¿estás $glisto:lista; para entregar las piezas de magister a cambio de tu nueva corona y toga de hechicero?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0),
(@ID, 'esMX', 'Realmente te extrañaré, $n. Tengo una deuda contigo y que tal vez nunca pueda pagar.$B$BDisfruta de tu nueva armadura para la cabeza y el pecho. ¡Que te proteja durante mucho tiempo y te ayude a alcanzar un honor aún mayor!', 0);
-- 9015 El reto
-- https://es.classic.wowhead.com/quest=9015
SET @ID := 9015;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Equipo de Theldren derrotado', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Has vuelto, $n!', 0),
(@ID, 'esMX', '¡Has vuelto, $n!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has recuperado parte del medallón, $n?', 0),
(@ID, 'esMX', '¿Has recuperado parte del medallón, $n?', 0);
-- 9023 El veneno perfecto
-- https://es.classic.wowhead.com/quest=9023
SET @ID := 9023;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Será mejor que lleves compañía para este trabajo, $n.', 0),
(@ID, 'esMX', 'Será mejor que lleves compañía para este trabajo, $n.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Tienes la gratitud de Ravenholdt! ¡Elige lo que quieras!', 0),
(@ID, 'esMX', '¡Tienes la gratitud de Ravenholdt! ¡Elige lo que quieras!', 0);
-- 9024 El presentimiento de Aristan
-- https://es.classic.wowhead.com/quest=9024
SET @ID := 9024;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Puedo ayudarte en algo?', 0),
(@ID, 'esMX', '¿Puedo ayudarte en algo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Entiendo a Aristan, pero creo que exagera. Me parece que ha olvidado lo que es ser joven y ardiente.$B$BPero no se lo vayas a decir; no creo que se lo tomara bien.', 0),
(@ID, 'esMX', 'Entiendo a Aristan, pero creo que exagera. Me parece que ha olvidado lo que es ser joven y ardiente.$B$BPero no se lo vayas a decir; no creo que se lo tomara bien.', 0);
-- 9025 El descubrimiento de Morgan
-- https://es.classic.wowhead.com/quest=9025
SET @ID := 9025;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Me inquieta sobremanera comprobar que mis sospechas eran correctas. Debemos ser cautos.$B$BTen, por el perfume y la colonia.', 0),
(@ID, 'esMX', 'Me inquieta sobremanera comprobar que mis sospechas eran correctas. Debemos ser cautos.$B$BTen, por el perfume y la colonia.', 0);
-- 9026 Rastrear la fuente
-- https://es.classic.wowhead.com/quest=9026
SET @ID := 9026;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, acabo de recibir el perfume y la colonia y se venden muy bien; vamos, me los quitan de las manos.$B$BLa verdad es que es un poco aburrido, ahora todo el mundo huele igual.', 0),
(@ID, 'esMX', 'Sí, acabo de recibir el perfume y la colonia y se venden muy bien; vamos, me los quitan de las manos.$B$BLa verdad es que es un poco aburrido, ahora todo el mundo huele igual.', 0);
-- 9027 Rastrear la fuente
-- https://es.classic.wowhead.com/quest=9027
SET @ID := 9027;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, estas fragancias son el éxito de la temporada; no deja de venir gente preguntando por ellas.$B$BAquí se han agotado las existencias; prueba con Allison, la posadera de La Rosa Áurea.$B$BPero date prisa; te digo que esas fragancias son irresistibles.', 0),
(@ID, 'esMX', 'Sí, estas fragancias son el éxito de la temporada; no deja de venir gente preguntando por ellas.$B$BAquí se han agotado las existencias; prueba con Allison, la posadera de La Rosa Áurea.$B$BPero date prisa; te digo que esas fragancias son irresistibles.', 0);
-- 9028 El descubrimiento de la fuente
-- https://es.classic.wowhead.com/quest=9028
SET @ID := 9028;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, yo creé esas fragancias. ¿A que son magníficas?$B$BLos soldados de la Alianza y de la Horda estarán tan distraídos con sus amoríos que no podrán detener el avance del Consejo de la Sombra.$B$BEstarán debilitados y desprevenidos.$B$BEs un truco tan sencillo que no comprendo cómo no se me ocurrió antes. Y tú no puedes hacer nada para evitarlo.', 0),
(@ID, 'esMX', 'Sí, yo creé esas fragancias. ¿A que son magníficas?$B$BLos soldados de la Alianza y de la Horda estarán tan distraídos con sus amoríos que no podrán detener el avance del Consejo de la Sombra.$B$BEstarán debilitados y desprevenidos.$B$BEs un truco tan sencillo que no comprendo cómo no se me ocurrió antes. Y tú no puedes hacer nada para evitarlo.', 0);
-- 9029 Una caldera burbujeante
-- https://es.classic.wowhead.com/quest=9029
SET @ID := 9029;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Del caldero emana un aroma agradable.', 0),
(@ID, 'esMX', 'Del caldero emana un aroma agradable.', 0);
-- 9033 Ecos de Guerra
-- https://es.classic.wowhead.com/quest=9033
SET @ID := 9033;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Deber, honor, dedicación... ¿Qué significan estas palabras para ti?', 0),
(@ID, 'esMX', 'Deber, honor, dedicación... ¿Qué significan estas palabras para ti?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Buen trabajo! Recibirás tu recompensa mediante los servicios de los habitantes de la Capilla de la Esperanza de la Luz.', 0),
(@ID, 'esMX', '¡Buen trabajo! Recibirás tu recompensa mediante los servicios de los habitantes de la Capilla de la Esperanza de la Luz.', 0);
-- 9034 La coraza acorator
-- https://es.classic.wowhead.com/quest=9034
SET @ID := 9034;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una coraza acorator.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una coraza acorator.', 0);
-- 9036 Los quijotes acorator
-- https://es.classic.wowhead.com/quest=9036
SET @ID := 9036;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos quijotes acorator.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos quijotes acorator.', 0);
-- 9037 El casco acorator
-- https://es.classic.wowhead.com/quest=9037
SET @ID := 9037;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un casco acorator.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un casco acorator.', 0);
-- 9038 Los espaldares acorator
-- https://es.classic.wowhead.com/quest=9038
SET @ID := 9038;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos espaldares acorator.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos espaldares acorator.', 0);
-- 9039 Los escarpes acorator
-- https://es.classic.wowhead.com/quest=9039
SET @ID := 9039;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos escarpes acorator.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos escarpes acorator.', 0);
-- 9040 Los guanteletes acorator
-- https://es.classic.wowhead.com/quest=9040
SET @ID := 9040;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos guanteletes acorator.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos guanteletes acorator.', 0);
-- 9041 Los guardarrenes acorator
-- https://es.classic.wowhead.com/quest=9041
SET @ID := 9041;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos guardarrenes acorator.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos guardarrenes acorator.', 0);
-- 9042 Los brazales acorator
-- https://es.classic.wowhead.com/quest=9042
SET @ID := 9042;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos brazales acorator.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos brazales acorator.', 0);
-- 9043 La túnica de redención
-- https://es.classic.wowhead.com/quest=9043
SET @ID := 9043;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una Guerrera de redención.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una Guerrera de redención.', 0);
-- 9044 Las musleras de redención
-- https://es.classic.wowhead.com/quest=9044
SET @ID := 9044;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Musleras de redención.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Musleras de redención.', 0);
-- 9045 La celada de redención
-- https://es.classic.wowhead.com/quest=9045
SET @ID := 9045;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Eligor señala tu cabeza.>$B$BMantenla cubierta, $n.', 0),
(@ID, 'esMX', '<Eligor señala tu cabeza.>$B$BMantenla cubierta, $n.', 0);
-- 9046 Las bufas de redención
-- https://es.classic.wowhead.com/quest=9046
SET @ID := 9046;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿No ves que estamos en medio de algo, $n?', 0),
(@ID, 'esMX', '¿No ves que estamos en medio de algo, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Cualquier $c te dirá que la mayor parte de su poder proviene de los hombros. Cuanto más grande, mejor...', 0),
(@ID, 'esMX', 'Cualquier $c te dirá que la mayor parte de su poder proviene de los hombros. Cuanto más grande, mejor...', 0);
-- 9047 Las botas de redención
-- https://es.classic.wowhead.com/quest=9047
SET @ID := 9047;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Debes proporcionarme lo que te he pedido si voy a empezar a crear.', 0),
(@ID, 'esMX', 'Debes proporcionarme lo que te he pedido si voy a empezar a crear.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estas botas protegerán tus pies contra los ataques de la Plaga.', 0),
(@ID, 'esMX', 'Estas botas protegerán tus pies contra los ataques de la Plaga.', 0);
-- 9048 Las manoplas de redención
-- https://es.classic.wowhead.com/quest=9048
SET @ID := 9048;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Debes proporcionarme lo que te he pedido si voy a empezar a crear.', 0),
(@ID, 'esMX', 'Debes proporcionarme lo que te he pedido si voy a empezar a crear.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Deja que la Luz atraviese estas manoplas y derribe a tus enemigos!', 0),
(@ID, 'esMX', '¡Deja que la Luz atraviese estas manoplas y derribe a tus enemigos!', 0);
-- 9049 La faja de redención
-- https://es.classic.wowhead.com/quest=9049
SET @ID := 9049;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Debes proporcionarme lo que te he pedido si voy a empezar a crear.', 0),
(@ID, 'esMX', 'Debes proporcionarme lo que te he pedido si voy a empezar a crear.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Esta faja tendrá dos funciones: 1) Te protegerá y te guiará contra la Plaga y 2) Te hará lucir 10 kilos más $gliviano:liviana;.', 0),
(@ID, 'esMX', 'Esta faja tendrá dos funciones: 1) Te protegerá y te guiará contra la Plaga y 2) Te hará lucir 10 kilos más $gliviano:liviana;.', 0);
-- 9050 Los guardamuñecas de redención
-- https://es.classic.wowhead.com/quest=9050
SET @ID := 9050;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Debes proporcionarme lo que te he pedido si voy a empezar a crear.', 0),
(@ID, 'esMX', 'Debes proporcionarme lo que te he pedido si voy a empezar a crear.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estos son excepcionalmente rentables de construir, pero ten en cuenta que pueden oxidarse si los salpica demasiado.', 0),
(@ID, 'esMX', 'Estos son excepcionalmente rentables de construir, pero ten en cuenta que pueden oxidarse si los salpica demasiado.', 0);
-- 9051 Prueba de toxicidad
-- https://es.classic.wowhead.com/quest=9051
SET @ID := 9051;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Pudiste pacificar a la gran bestia?', 0),
(@ID, 'esMX', '¿Pudiste pacificar a la gran bestia?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$n, gracias por tu valentía y saber hacer.$B$BDime, ¿qué efecto ha tenido la toxina en el demosaurio?', 0),
(@ID, 'esMX', '$n, gracias por tu valentía y saber hacer.$B$BDime, ¿qué efecto ha tenido la toxina en el demosaurio?', 0);
-- 9052 Veneno de Sangrepétalo
-- https://es.classic.wowhead.com/quest=9052
SET @ID := 9052;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has tenido éxito?', 0),
(@ID, 'esMX', '¿Has tenido éxito?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Al fin los ingredientes!$B$BCon esto y la tierra de Un\'Goro, no tendré problemas para preparar la toxina.', 0),
(@ID, 'esMX', '¡Al fin los ingredientes!$B$BCon esto y la tierra de Un\'Goro, no tendré problemas para preparar la toxina.', 0);
-- 9053 Un ingrediente mejor
-- https://es.classic.wowhead.com/quest=9053
SET @ID := 9053;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has recuperado la vid?', 0),
(@ID, 'esMX', '¿Has recuperado la vid?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Por fin, la toxina se puede crear por completo. No me atrevo a pedirte que se lo vuelvas a aplicar a la criatura, ya te he pedido demasiado.$B$BTienes mi agradecimiento y respeto. Que te vaya bien en tus viajes, $n.', 0),
(@ID, 'esMX', 'Por fin, la toxina se puede crear por completo. No me atrevo a pedirte que se lo vuelvas a aplicar a la criatura, ya te he pedido demasiado.$B$BTienes mi agradecimiento y respeto. Que te vaya bien en tus viajes, $n.', 0);
-- 9054 La guerrera de acechacriptas
-- https://es.classic.wowhead.com/quest=9054
SET @ID := 9054;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes los artículos que pedí, $c?', 0),
(@ID, 'esMX', '¿Tienes los artículos que pedí, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ellos te temerán, $n.', 0),
(@ID, 'esMX', 'Ellos te temerán, $n.', 0);
-- 9055 Las musleras de acechacriptas
-- https://es.classic.wowhead.com/quest=9055
SET @ID := 9055;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes los artículos que pedí, $c?', 0),
(@ID, 'esMX', '¿Tienes los artículos que pedí, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'A medida que te pongas esta armadura, notarás que tu personalidad está cambiando. Obtendrás una habilidad sobrenatural para matar. Quizás, incluso, ansia de sangre.$B$BQue se sepa que no seré responsable del caos que puedas causar...', 0),
(@ID, 'esMX', 'A medida que te pongas esta armadura, notarás que tu personalidad está cambiando. Obtendrás una habilidad sobrenatural para matar. Quizás, incluso, ansia de sangre.$B$BQue se sepa que no seré responsable del caos que puedas causar...', 0);
-- 9056 La celada de acechacriptas
-- https://es.classic.wowhead.com/quest=9056
SET @ID := 9056;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes los artículos que pedí, $c?', 0),
(@ID, 'esMX', '¿Tienes los artículos que pedí, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te estás convirtiendo en una criatura temible, $n.', 0),
(@ID, 'esMX', 'Te estás convirtiendo en una criatura temible, $n.', 0);
-- 9057 Las bufas de acechacriptas
-- https://es.classic.wowhead.com/quest=9057
SET @ID := 9057;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Bufas de acechacriptas.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Bufas de acechacriptas.', 0);
-- 9058 Las botas de acechacriptas
-- https://es.classic.wowhead.com/quest=9058
SET @ID := 9058;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Botas de acechacriptas.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Botas de acechacriptas.', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
