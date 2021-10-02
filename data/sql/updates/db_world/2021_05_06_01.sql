-- DB update 2021_05_06_00 -> 2021_05_06_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_06_00 2021_05_06_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619616883919180600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619616883919180600');

-- 8554 Enfréntate a Negolash
-- https://es.classic.wowhead.com/quest=8554
SET @ID := 8554;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has conseguido mi alfanje, $n?', 0),
(@ID, 'esMX', '¿Has conseguido mi alfanje, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Has conseguido quitarle mi alfanje a Negolash! ¡No puedo creer que tenga tanta suerte, $n! Conocerte ha hecho que mi suerte cambiase, ¡para mejor, eso sin duda!$B$B¡Gracias! Y si alguna vez consigo un barco y quieres navegar los mares, ¡serás mi $ginvitado:invitada; de honor!', 0),
(@ID, 'esMX', '¡Has conseguido quitarle mi alfanje a Negolash! ¡No puedo creer que tenga tanta suerte, $n! Conocerte ha hecho que mi suerte cambiase, ¡para mejor, eso sin duda!$B$B¡Gracias! Y si alguna vez consigo un barco y quieres navegar los mares, ¡serás mi $ginvitado:invitada; de honor!', 0);
-- 8555 Encomienda a los Vuelos
-- https://es.classic.wowhead.com/quest=8555
SET @ID := 8555;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Eranikus, Vaelastrasz y Azuregos... Sin duda, conoces a estos dragones, mortal. No es coincidencia que hayan desempeñado papeles tan influyentes como observadores de nuestro mundo.$B$BDesafortunadamente (y mi propia ingenuidad es parcialmente culpable) ya sea por agentes de los Dioses Antiguos o por traición de aquellos que los llamarían amigos, cada guardián ha caído en la tragedia. Hasta qué punto ha alimentado mi propia desconfianza hacia los de tu especie.$B$BBúscalos... Y $r, prepárate para lo peor.', 0),
(@ID, 'esMX', 'Eranikus, Vaelastrasz y Azuregos... Sin duda, conoces a estos dragones, mortal. No es coincidencia que hayan desempeñado papeles tan influyentes como observadores de nuestro mundo.$B$BDesafortunadamente (y mi propia ingenuidad es parcialmente culpable) ya sea por agentes de los Dioses Antiguos o por traición de aquellos que los llamarían amigos, cada guardián ha caído en la tragedia. Hasta qué punto ha alimentado mi propia desconfianza hacia los de tu especie.$B$BBúscalos... Y $r, prepárate para lo peor.', 0);
-- 8556 El sello de fuerza implacable
-- https://es.classic.wowhead.com/quest=8556
SET @ID := 8556;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste el anillo y los materiales, $n?', 0),
(@ID, 'esMX', '¿Me trajiste el anillo y los materiales, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(@ID, 'esMX', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0);
-- 8557 El mantón de fuerza implacable
-- https://es.classic.wowhead.com/quest=8557
SET @ID := 8557;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Trajiste los materiales para la capa, $n?', 0),
(@ID, 'esMX', '¿Trajiste los materiales para la capa, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los Qiraji.', 0),
(@ID, 'esMX', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los Qiraji.', 0);
-- 8558 La hoz de fuerza implacable
-- https://es.classic.wowhead.com/quest=8558
SET @ID := 8558;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que necesito, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que necesito, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Lo has hecho bien, $n. Esta es una empuñadura de obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrimela con gran confianza y vence a nuestros enemigos!', 0),
(@ID, 'esMX', 'Lo has hecho bien, $n. Esta es una empuñadura de obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrimela con gran confianza y vence a nuestros enemigos!', 0);
-- 8559 Las grebas de conquistador
-- https://es.classic.wowhead.com/quest=8559
SET @ID := 8559;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes todo lo que solicité, $n?', 0),
(@ID, 'esMX', '¿Tienes todo lo que solicité, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe las doy confiando en que te ayudarán a aplastar al vil Qiraji.', 0),
(@ID, 'esMX', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe las doy confiando en que te ayudarán a aplastar al vil Qiraji.', 0);
-- Las musleras de conquistador
-- 8560, 8593
-- https://es.classic.wowhead.com/quest=8560
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8560, 8593) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8560, 'esES', '¿Trajiste los componentes que necesito, $n?', 0),
(8593, 'esES', '¿Trajiste los componentes que necesito, $n?', 0),
(8560, 'esMX', '¿Trajiste los componentes que necesito, $n?', 0),
(8593, 'esMX', '¿Trajiste los componentes que necesito, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8560, 8593) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8560, 'esES', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0),
(8593, 'esES', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0),
(8560, 'esMX', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0),
(8593, 'esMX', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0);
-- La corona de conquistador
-- 8561, 8592
-- https://es.classic.wowhead.com/quest=8561
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8561, 8592) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8561, 'esES', '¿Me trajiste los componentes que pedí, $n?', 0),
(8592, 'esES', '¿Me trajiste los componentes que pedí, $n?', 0),
(8561, 'esMX', '¿Me trajiste los componentes que pedí, $n?', 0),
(8592, 'esMX', '¿Me trajiste los componentes que pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8561, 8592) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8561, 'esES', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(8592, 'esES', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(8561, 'esMX', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(8592, 'esMX', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0);
-- 8562 La coraza de conquistador
-- https://es.classic.wowhead.com/quest=8562
SET @ID := 8562;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'En su morada en Ahn\'Qiraj, el pavoroso C\'Thun aguarda dormido.', 0),
(@ID, 'esMX', 'En su morada en Ahn\'Qiraj, el pavoroso C\'Thun aguarda dormido.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No esperaba que regresaras de tu intento, $n.$B$BHas cumplido un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun, no solo has salvado todo Azeroth, sino que también has inclinado la balanza de los eventos cósmicos más allá de tu comprensión.$B$BAcepta esta coraza como símbolo de la gloria y la carga que vendrá como consecuencia de tus acciones.$B$B¡Que su poder te ayude en los desafíos que te esperan, $gasesino:asesina; de dioses!', 0),
(@ID, 'esMX', 'No esperaba que regresaras de tu intento, $n.$B$BHas cumplido un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun, no solo has salvado todo Azeroth, sino que también has inclinado la balanza de los eventos cósmicos más allá de tu comprensión.$B$BAcepta esta coraza como símbolo de la gloria y la carga que vendrá como consecuencia de tus acciones.$B$B¡Que su poder te ayude en los desafíos que te esperan, $gasesino:asesina; de dioses!', 0);
-- 8564 Instrucción de sacerdote
-- https://es.classic.wowhead.com/quest=8564
SET @ID := 8564;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$gBienvenido:Bienvenida;, $n. Soy Matrona Arena. Ofrezco mis servicios a quienes buscan aprender los caminos $gdel:de la; $n. Este camino a menudo se malinterpreta como un camino de pacifismo; para nosotros, los elfos de sangre, esto no podría estar más lejos de la verdad. Si bien reparamos tanto los huesos como el espíritu, también actuamos como un puño de venganza para aquellos que se rebelen contra nosotros.$B$BTe prepararé, pero todo lo que te pido es que cubras los costos de capacitación que puedan surgir y que aprendas con la mente abierta. Si estás de acuerdo con esto, podemos comenzar.', 0),
(@ID, 'esMX', '$gBienvenido:Bienvenida;, $n. Soy Matrona Arena. Ofrezco mis servicios a quienes buscan aprender los caminos $gdel:de la; $n. Este camino a menudo se malinterpreta como un camino de pacifismo; para nosotros, los elfos de sangre, esto no podría estar más lejos de la verdad. Si bien reparamos tanto los huesos como el espíritu, también actuamos como un puño de venganza para aquellos que se rebelen contra nosotros.$B$BTe prepararé, pero todo lo que te pido es que cubras los costos de capacitación que puedan surgir y que aprendas con la mente abierta. Si estás de acuerdo con esto, podemos comenzar.', 0);
-- Equipamiento de Veterano
-- 8572, 8573, 8574
-- https://es.classic.wowhead.com/quest=8572
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8572, 8573, 8574) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8572, 'esES', 'Nos conviene mantener bien preparados a nuestros aliados más leales, $n.', 0),
(8573, 'esES', 'Nos conviene mantener bien preparados a nuestros aliados más leales, $n.', 0),
(8574, 'esES', 'Nos conviene mantener bien preparados a nuestros aliados más leales, $n.', 0),
(8572, 'esMX', 'Nos conviene mantener bien preparados a nuestros aliados más leales, $n.', 0),
(8573, 'esMX', 'Nos conviene mantener bien preparados a nuestros aliados más leales, $n.', 0),
(8574, 'esMX', 'Nos conviene mantener bien preparados a nuestros aliados más leales, $n.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8572, 8573, 8574) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8572, 'esES', 'Buen trabajo, $n. Acepta esto en nombre del Círculo Cenarion. ¡Seguro que te lo has ganado, $gamigo:amiga;!', 0),
(8573, 'esES', 'Buen trabajo, $n. Acepta esto en nombre del Círculo Cenarion. ¡Seguro que te lo has ganado, $gamigo:amiga;!', 0),
(8574, 'esES', 'Buen trabajo, $n. Acepta esto en nombre del Círculo Cenarion. ¡Seguro que te lo has ganado, $gamigo:amiga;!', 0),
(8572, 'esMX', 'Buen trabajo, $n. Acepta esto en nombre del Círculo Cenarion. ¡Seguro que te lo has ganado, $gamigo:amiga;!', 0),
(8573, 'esMX', 'Buen trabajo, $n. Acepta esto en nombre del Círculo Cenarion. ¡Seguro que te lo has ganado, $gamigo:amiga;!', 0),
(8574, 'esMX', 'Buen trabajo, $n. Acepta esto en nombre del Círculo Cenarion. ¡Seguro que te lo has ganado, $gamigo:amiga;!', 0);
-- 8575 El libro de contabilidad mágico de Azuregos
-- https://es.classic.wowhead.com/quest=8575
SET @ID := 8575;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Ooooh! ¡Cosa mágica pulsante! ¿Para mí?', 0),
(@ID, 'esMX', '¡Ooooh! ¡Cosa mágica pulsante! ¿Para mí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Narain examina ansiosamente el texto.>$B$B¡Excepcional, $r! ¿Qué es? No puedo leer ni una pizca de Dracónico.', 0),
(@ID, 'esMX', '<Narain examina ansiosamente el texto.>$B$B¡Excepcional, $r! ¿Qué es? No puedo leer ni una pizca de Dracónico.', 0);
-- 8576 La traducción del libro de contabilidad
-- https://es.classic.wowhead.com/quest=8576
SET @ID := 8576;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo primero es lo primero, $n! Necesitamos averiguar qué escribió Azuregos en este libro contable.$B$B¿Dices que te ha dicho que hagas una boya de arcanita y que este es el esquema? Es extraño que escribiera esto en Dracónico. Esa vieja cabra sabe que no puedo leer estas tonterías.$B$BSi esto va a funcionar, voy a necesitar mis gafas de adivinación, un pollo de 500 kilos y el volumen II de "Dracónico para Torpes". No necesariamente en ese orden.', 0),
(@ID, 'esMX', '¡Lo primero es lo primero, $n! Necesitamos averiguar qué escribió Azuregos en este libro contable.$B$B¿Dices que te ha dicho que hagas una boya de arcanita y que este es el esquema? Es extraño que escribiera esto en Dracónico. Esa vieja cabra sabe que no puedo leer estas tonterías.$B$BSi esto va a funcionar, voy a necesitar mis gafas de adivinación, un pollo de 500 kilos y el volumen II de "Dracónico para Torpes". No necesariamente en ese orden.', 0);
-- 8577 Guisón, ex mejor amigo
-- https://es.classic.wowhead.com/quest=8577
SET @ID := 8577;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No puedo creer que me haya encontrado. Estaba seguro de que lo había perdido cuando estaba en Terrallende. ¡No voy a volver allí, $r! ¡De ninguna manera, de ninguna manera! Estoy harto de ser su mejor amigo a tiempo parcial y esclavo a tiempo completo.', 0),
(@ID, 'esMX', 'No puedo creer que me haya encontrado. Estaba seguro de que lo había perdido cuando estaba en Terrallende. ¡No voy a volver allí, $r! ¡De ninguna manera, de ninguna manera! Estoy harto de ser su mejor amigo a tiempo parcial y esclavo a tiempo completo.', 0);
-- 8578 ¿Unas gafas? ¡Sin problemas!
-- https://es.classic.wowhead.com/quest=8578
SET @ID := 8578;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El núcleo fundido, ¿eh? ¡Espero que mis gafas estén todavía de una pieza!', 0),
(@ID, 'esMX', 'El núcleo fundido, ¿eh? ¡Espero que mis gafas estén todavía de una pieza!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Sobresaliente! Ahora, ¿dónde puse ese pollo de 500 kilos y el Volumen II de "Dracónico para Torpes"??? ¡Ah, y aquí hay algo por todo tu arduo trabajo!', 0),
(@ID, 'esMX', '¡Sobresaliente! Ahora, ¿dónde puse ese pollo de 500 kilos y el Volumen II de "Dracónico para Torpes"??? ¡Ah, y aquí hay algo por todo tu arduo trabajo!', 0);
-- 8580 ¡La Horda necesita flores de fuego!
-- https://es.classic.wowhead.com/quest=8580
SET @ID := 8580;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Terminaste de recolectar esas muestras? ¡Podríamos perder a Noggle en cualquier momento!', 0),
(@ID, 'esMX', '¿Terminaste de recolectar esas muestras? ¡Podríamos perder a Noggle en cualquier momento!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Cruza los dedos, amigo! ¡Esperamos que podamos salvar a Noggle!', 0),
(@ID, 'esMX', '¡Cruza los dedos, amigo! ¡Esperamos que podamos salvar a Noggle!', 0);
-- 8581 ¡La Horda necesita más flores de fuego!
-- https://es.classic.wowhead.com/quest=8581
SET @ID := 8581;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿N\'es una broma, $n? ¿Traes flores de fuego tan rápido? ¡Pele\'keiki las cuenta ahora mismo, colega! Estás haciendo a Pele\'keiki tan feliz, qu\'él se lo dirá a todos, $n ¡el mejor coleccionista de flores de fuego! Pele\'keiki no puede esperar a que comience la guerra. Ahora realmente iluminamos el cielo sobre Silithus, ¿verdad, colega?', 0),
(@ID, 'esMX', '¿N\'es una broma, $n? ¿Traes flores de fuego tan rápido? ¡Pele\'keiki las cuenta ahora mismo, colega! Estás haciendo a Pele\'keiki tan feliz, qu\'él se lo dirá a todos, $n ¡el mejor coleccionista de flores de fuego! Pele\'keiki no puede esperar a que comience la guerra. Ahora realmente iluminamos el cielo sobre Silithus, ¿verdad, colega?', 0);
-- 8582 ¡La Horda necesita lotos cárdenos!
-- https://es.classic.wowhead.com/quest=8582
SET @ID := 8582;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has vuelto ya con el loto cárdeno que te pedí, $c? Es vital que lo hagas en el menor tiempo posible no vaya a ser que todo lo que estoy intentando aquí se malogre.', 0),
(@ID, 'esMX', '¿Has vuelto ya con el loto cárdeno que te pedí, $c? Es vital que lo hagas en el menor tiempo posible no vaya a ser que todo lo que estoy intentando aquí se malogre.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo digno de elogio, $c. Mediré estos ejemplares para que se usen apropiadamente y tomaré nota de tu contribución. Habrá que guardar debidamente el loto cárdeno hasta que esté listo. En cuanto a ti, si aún estás disponible, aún voy a necesitar más loto cárdeno. Así que pásate de nuevo pronto.', 0),
(@ID, 'esMX', 'Un trabajo digno de elogio, $c. Mediré estos ejemplares para que se usen apropiadamente y tomaré nota de tu contribución. Habrá que guardar debidamente el loto cárdeno hasta que esté listo. En cuanto a ti, si aún estás disponible, aún voy a necesitar más loto cárdeno. Así que pásate de nuevo pronto.', 0);
-- 8583 ¡La Horda necesita más lotos cárdenos!
-- Notice: English text is also missing in quest_request_items.CompletionText
-- https://es.classic.wowhead.com/quest=8583
SET @ID := 8583;
UPDATE `quest_request_items` SET `CompletionText` = 'In fact it does appear that we are in need of even more purple lotus, $c. While my own studies have yet to determine a new useful application for the herb, there are tried and true methodologies yet to be employed.$B$BI need you to once again go out into the field and collect at least twenty purple lotus samples. Return them to me here.', `VerifiedBuild` = 0 WHERE `id` = @ID ;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De hecho, al parecer necesitamos aún más loto cárdeno, $c. Aunque mis nuevas investigaciones no hayan permitido todavía descubrir nuevas aplicaciones de utilidad para esta hierba, aún quedan metodologías ciertas y probadas que aprovechar.$B$BNecesito que vayas de nuevo al campo y recolectes al menos 20 ejemplares de loto cárdeno. Cuando los tengas, tráemelos aquí.', 0),
(@ID, 'esMX', 'De hecho, al parecer necesitamos aún más loto cárdeno, $c. Aunque mis nuevas investigaciones no hayan permitido todavía descubrir nuevas aplicaciones de utilidad para esta hierba, aún quedan metodologías ciertas y probadas que aprovechar.$B$BNecesito que vayas de nuevo al campo y recolectes al menos 20 ejemplares de loto cárdeno. Cuando los tengas, tráemelos aquí.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo de primera y de lo más preciso, $n. Tu diligencia es digna de elogio, al igual que tu celeridad. Me ocuparé personalmente de que no se desperdicia un ápice de este loto cárdeno.$B$BGracias otra vez y si encuentras más loto cárdeno, no dudes en traérmelo tan $graudo:rauda; como puedas.', 0),
(@ID, 'esMX', 'Un trabajo de primera y de lo más preciso, $n. Tu diligencia es digna de elogio, al igual que tu celeridad. Me ocuparé personalmente de que no se desperdicia un ápice de este loto cárdeno.$B$BGracias otra vez y si encuentras más loto cárdeno, no dudes en traérmelo tan $graudo:rauda; como puedas.', 0);
-- 8584 ¡Nunca me preguntes por mi negocio!
-- https://es.classic.wowhead.com/quest=8584
SET @ID := 8584;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Dirge se rasca la cabeza.>$B$B¿Un pollo de 500 kilos? ¡No hay tal cosa! Ya no, al menos. Sabía de un pollo así... El Pollo Negro de la Muerte...$B$B<La voz de Dirge se apaga.>$B$BPero sí, nadie vio ese pollo y vivió para contarlo. Tengo una idea que podría beneficiarnos a los dos, $gchico:chica;.', 0),
(@ID, 'esMX', '<Dirge se rasca la cabeza.>$B$B¿Un pollo de 500 kilos? ¡No hay tal cosa! Ya no, al menos. Sabía de un pollo así... El Pollo Negro de la Muerte...$B$B<La voz de Dirge se apaga.>$B$BPero sí, nadie vio ese pollo y vivió para contarlo. Tengo una idea que podría beneficiarnos a los dos, $gchico:chica;.', 0);
-- 8585 La Isla del Terror
-- https://es.classic.wowhead.com/quest=8585
SET @ID := 8585;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Mmmmm... quimerok...', 0),
(@ID, 'esMX', 'Mmmmm... quimerok...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Mira esos solomillos! ¡Fantástico!$B$BAhora sobre ese pollo... Hrmm, déjame ver. Voy a necesitar unos minutos para idear la receta.', 0),
(@ID, 'esMX', '¡Mira esos solomillos! ¡Fantástico!$B$BAhora sobre ese pollo... Hrmm, déjame ver. Voy a necesitar unos minutos para idear la receta.', 0);
-- 8586 Fabulosas chuletillas de quimerok de Dirge
-- https://es.classic.wowhead.com/quest=8586
SET @ID := 8586;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Date prisa, $gchico:chica;. No queremos que esta carne se eche a perder.', 0),
(@ID, 'esMX', 'Date prisa, $gchico:chica;. No queremos que esta carne se eche a perder.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Está listo! Te presento mi mayor creación: ¡Fabulosas chuletillas de quimerok de Dirge!', 0),
(@ID, 'esMX', '¡Está listo! Te presento mi mayor creación: ¡Fabulosas chuletillas de quimerok de Dirge!', 0);
-- 8587 Regresa junto a Narain
-- https://es.classic.wowhead.com/quest=8587
SET @ID := 8587;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Qué es ese delicioso olor?', 0),
(@ID, 'esMX', '¿Qué es ese delicioso olor?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Narain clava las dos manos en el enorme pollo, llenándose la cara del delicioso manjar de Dirge.>$B$BMMmmm... ¡Esto es increíble! ¡El mejor pollo que he comido!', 0),
(@ID, 'esMX', '<Narain clava las dos manos en el enorme pollo, llenándose la cara del delicioso manjar de Dirge.>$B$BMMmmm... ¡Esto es increíble! ¡El mejor pollo que he comido!', 0);
-- 8588 ¡La Horda necesita cuero pesado!
-- https://es.classic.wowhead.com/quest=8588
SET @ID := 8588;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No tengo tiempo para jueguecitos si solo has venido a dar discursos, $c. Hay demasiadas pilas de cuero pesado que curtir. Vuelve cuando tengas al menos 10 para mí.', 0),
(@ID, 'esMX', 'No tengo tiempo para jueguecitos si solo has venido a dar discursos, $c. Hay demasiadas pilas de cuero pesado que curtir. Vuelve cuando tengas al menos 10 para mí.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, así que ya tienes el cuero pesado que necesitaba. Afilada es tu espada, $c; ¡estas pieles son muy buenas! Ahora que hemos empezado con buen pie, me ocuparé de que se aproveche debidamente tu contribución. Y si encuentras más cuero pesado, tráemelo.', 0),
(@ID, 'esMX', 'Ah, así que ya tienes el cuero pesado que necesitaba. Afilada es tu espada, $c; ¡estas pieles son muy buenas! Ahora que hemos empezado con buen pie, me ocuparé de que se aproveche debidamente tu contribución. Y si encuentras más cuero pesado, tráemelo.', 0);
-- 8589 ¡La Horda necesita más cuero pesado!
-- Notice: English text is also missing in quest_request_items.CompletionText
-- https://es.classic.wowhead.com/quest=8589
SET @ID := 8589;
UPDATE `quest_request_items` SET `CompletionText` = 'It\'s true, $c, I still need more heavy leather. The requests from the generals and their quartermasters seem endless. And that\'s nothing compared to what the zeppelin masters are asking for!$B$BI need to get my quota collected on the double. $n, bring me more stacks of heavy leather as soon as you can!', `VerifiedBuild` = 0 WHERE `id` = @ID ;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Así es, $c, aún necesito más cuero pesado. Los pedidos de los generales y sus intendentes no se acaban nunca. ¡Y eso no es nada comparado con lo que los maestros de zepelín están pidiendo!$B$BTengo que completar mi cupo a paso ligero. $n, tráeme más pilas de cuero pesado ¡tan pronto como puedas!', 0),
(@ID, 'esMX', 'Así es, $c, aún necesito más cuero pesado. Los pedidos de los generales y sus intendentes no se acaban nunca. ¡Y eso no es nada comparado con lo que los maestros de zepelín están pidiendo!$B$BTengo que completar mi cupo a paso ligero. $n, tráeme más pilas de cuero pesado ¡tan pronto como puedas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Así me gusta, colega! Muchísimas gracias por el cuero pesado. Cada granito de arena es importante. Voy a dejar estas pieles en una pila para que los demás peleteros puedan trabajarlas.$B$BGracias otra vez, $n, y si te topas con más cuero pesado, ya sabes dónde encontrarme.', 0),
(@ID, 'esMX', '¡Así me gusta, colega! Muchísimas gracias por el cuero pesado. Cada granito de arena es importante. Voy a dejar estas pieles en una pila para que los demás peleteros puedan trabajarlas.$B$BGracias otra vez, $n, y si te topas con más cuero pesado, ya sabes dónde encontrarme.', 0);
-- 8590 ¡La Horda necesita cuero grueso!
-- https://es.classic.wowhead.com/quest=8590
SET @ID := 8590;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, $c, ¿tan pronto de vuelta con las 10 piezas de cuero grueso de las que hablamos?', 0),
(@ID, 'esMX', 'Ah, $c, ¿tan pronto de vuelta con las 10 piezas de cuero grueso de las que hablamos?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Buen trabajo, $c. Estoy segura de que todas estas pieles de cuero grueso servirán para reforzar los zepelines y confeccionar todo tipo de armas y armaduras. Cuentas con mi más sincero agradecimiento, así como con el de la Horda. Vuelve si encuentras más cuero grueso en tus viajes y que la suerte te acompañe.', 0),
(@ID, 'esMX', 'Buen trabajo, $c. Estoy segura de que todas estas pieles de cuero grueso servirán para reforzar los zepelines y confeccionar todo tipo de armas y armaduras. Cuentas con mi más sincero agradecimiento, así como con el de la Horda. Vuelve si encuentras más cuero grueso en tus viajes y que la suerte te acompañe.', 0);
-- 8591 ¡La Horda necesita más cuero grueso!
-- Notice: English text is also missing in quest_request_items.CompletionText
-- https://es.classic.wowhead.com/quest=8591
SET @ID := 8591;
UPDATE `quest_request_items` SET `CompletionText` = '$c, as you can see I still need to gather up more thick leather. Once again I ask your help with this task, and promise that if you complete it, you will be recognized for your efforts.$B$BTime is of the essence! Return to me with the thick leather so that we can finish our preparations and go to war, hero!', `VerifiedBuild` = 0 WHERE `id` = @ID ;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c, como ves, necesito recolectar aún más cuero grueso. Una vez más te pido tu ayuda para esta tarea y prometo que si la completas, se te reconocerá tu dedicación.$B$B¡El tiempo es vital! ¡Vuelve aquí cuando tengas el cuero pesado para que pueda acabar nuestros preparativos para la guerra, $ghéroe:heroína;!', 0),
(@ID, 'esMX', '$c, como ves, necesito recolectar aún más cuero grueso. Una vez más te pido tu ayuda para esta tarea y prometo que si la completas, se te reconocerá tu dedicación.$B$B¡El tiempo es vital! ¡Vuelve aquí cuando tengas el cuero pesado para que pueda acabar nuestros preparativos para la guerra, $ghéroe:heroína;!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo conseguiste, $n, sabía que lo conseguirías! Una vez más, gracias en nombre de toda la Horda. Se toma buena nota de tu trabajo y se agradece. Y si encuentras más cuero grueso que te gustaría donar, tráemelo aquí.$B$B¡Lok\'tar Ogar, $c!', 0),
(@ID, 'esMX', '¡Lo conseguiste, $n, sabía que lo conseguirías! Una vez más, gracias en nombre de toda la Horda. Se toma buena nota de tu trabajo y se agradece. Y si encuentras más cuero grueso que te gustaría donar, tráemelo aquí.$B$B¡Lok\'tar Ogar, $c!', 0);
-- 8594 El manto del Oráculo
-- https://es.classic.wowhead.com/quest=8594
SET @ID := 8594;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Ha recogido los componentes que necesito?', 0),
(@ID, 'esMX', '¿Ha recogido los componentes que necesito?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que verlos infunda miedo en nuestros enemigos.', 0),
(@ID, 'esMX', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que verlos infunda miedo en nuestros enemigos.', 0);
-- 8595 Campeones mortales
-- https://es.wowhead.com/quest=8595
SET @ID := 8595;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Matar a un Señor qiraji es un logro notable para $gun:una; mortal, $n. Sin embargo, son muchos y poderosos. Sigue derrotándolos y demuestra lo que vales como $gnuestro Campeón:nuestra Campeona;.', 0),
(@ID, 'esMX', 'Matar a un Señor qiraji es un logro notable para $gun:una; mortal, $n. Sin embargo, son muchos y poderosos. Sigue derrotándolos y demuestra lo que vales como $gnuestro Campeón:nuestra Campeona;.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sigues sirviéndonos bien, $n. Nuestro pacto sigue en pie.', 0),
(@ID, 'esMX', 'Sigues sirviéndonos bien, $n. Nuestro pacto sigue en pie.', 0);
-- 8596 Los borceguíes del Oráculo
-- https://es.wowhead.com/quest=8596
SET @ID := 8596;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has conseguido esos objetos que te pedí, $n?', 0),
(@ID, 'esMX', '¿Has conseguido esos objetos que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Lo has hecho muy bien, $n. Has demostrado que no eres $gun:una; mortal cualquiera.$B$BTe entrego estas confiando en que te ayudarán a aplastar a los malvados qiraji.', 0),
(@ID, 'esMX', 'Lo has hecho muy bien, $n. Has demostrado que no eres $gun:una; mortal cualquiera.$B$BTe entrego estas confiando en que te ayudarán a aplastar a los malvados qiraji.', 0);
-- 8597 Dracónico para torpes
-- https://es.classic.wowhead.com/quest=8597
SET @ID := 8597;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡El libro no está! Encima del montículo de tierra hay una nota.', 0),
(@ID, 'esMX', '¡El libro no está! Encima del montículo de tierra hay una nota.', 0);
-- 8598 ReScaTe
-- https://es.classic.wowhead.com/quest=8598
SET @ID := 8598;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Dime, ¿cuál es el problema?', 0),
(@ID, 'esMX', 'Dime, ¿cuál es el problema?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<La cara de Narain se pone de un rojo brillante.>$B$BTorturar a mi... libro, ¿lo harán? ¡Les enseñaré lo que significa meterse con un gnomo psíquico!', 0),
(@ID, 'esMX', '<La cara de Narain se pone de un rojo brillante.>$B$BTorturar a mi... libro, ¿lo harán? ¡Les enseñaré lo que significa meterse con un gnomo psíquico!', 0);
-- 8599 Una canción de amor para Narain
-- https://es.classic.wowhead.com/quest=8599
SET @ID := 8599;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Hueles a pescado!', 0),
(@ID, 'esMX', '¡Hueles a pescado!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿¡Qué!?$B$B<Narain comienza a inquietarse.>$B$BBueno, umm... ¿Qué quieres que haga??? ¡Ella es un pez! ¡UN PESCADO, te lo digo! Y soy un gnomo. Nunca podría funcionar.', 0),
(@ID, 'esMX', '¿¡Qué!?$B$B<Narain comienza a inquietarse.>$B$BBueno, umm... ¿Qué quieres que haga??? ¡Ella es un pez! ¡UN PESCADO, te lo digo! Y soy un gnomo. Nunca podría funcionar.', 0);
-- 8600 ¡La Horda necesita pieles de cuero basto!
-- https://es.classic.wowhead.com/quest=8600
SET @ID := 8600;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡No es posible que te lleve tanto tiempo desollar 10 pieles de cuero basto para mí! ¿Quizás necesites afilar tu cuchillo de desollar? ¿O acaso estoy confundido y las tienes ahí en tu bolsa?', 0),
(@ID, 'esMX', '¡No es posible que te lleve tanto tiempo desollar 10 pieles de cuero basto para mí! ¿Quizás necesites afilar tu cuchillo de desollar? ¿O acaso estoy confundido y las tienes ahí en tu bolsa?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, parece que has hecho un buen trabajo, aunque algunas de estas pieles tienen los bordes algo irregulares. No importa, has completado la tarea y te has ganado una recompensa. Si te vuelves a encontrar con más cuero basto, tráemelo inmediatamente.', 0),
(@ID, 'esMX', 'Muy bien, parece que has hecho un buen trabajo, aunque algunas de estas pieles tienen los bordes algo irregulares. No importa, has completado la tarea y te has ganado una recompensa. Si te vuelves a encontrar con más cuero basto, tráemelo inmediatamente.', 0);

-- 8601 ¡La Horda necesita más pieles de cuero basto!
-- https://es.classic.wowhead.com/quest=8601
SET @ID := 8601;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Práctica, práctica, práctica. Con un cuchillo bien afilado y la habilidad para usarlo llegarás lejos en este mundo, $n. Parece que los bordes de estas pieles están mejor que las últimas. ¿Compraste un cuchillo nuevo?$B$BSea como fuere, te agradecemos tus esfuerzos. He tomado buena nota de tu donación y se aprovechará bien, te lo aseguro. Si te acabas haciendo con más cuero basto, vuelve por aquí y habla conmigo ya que seguramente me hará falta más.', 0),
(@ID, 'esMX', 'Práctica, práctica, práctica. Con un cuchillo bien afilado y la habilidad para usarlo llegarás lejos en este mundo, $n. Parece que los bordes de estas pieles están mejor que las últimas. ¿Compraste un cuchillo nuevo?$B$BSea como fuere, te agradecemos tus esfuerzos. He tomado buena nota de tu donación y se aprovechará bien, te lo aseguro. Si te acabas haciendo con más cuero basto, vuelve por aquí y habla conmigo ya que seguramente me hará falta más.', 0);
-- 8602 Los espaldares de clamatormentas
-- https://es.classic.wowhead.com/quest=8602
SET @ID := 8602;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Ha recogido los componentes que necesito?', 0),
(@ID, 'esMX', '¿Ha recogido los componentes que necesito?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que verlos infunda miedo en nuestros enemigos.', 0),
(@ID, 'esMX', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que verlos infunda miedo en nuestros enemigos.', 0);
-- 8603 Las vestimentas del Oráculo
-- https://es.wowhead.com/quest=8603
SET @ID := 8603;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0),
(@ID, 'esMX', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0),
(@ID, 'esMX', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0);
-- 8604 ¡La Horda necesita vendas de lana!
-- https://es.classic.wowhead.com/quest=8604
SET @ID := 8604;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, $c, ¿has vuelto tan rápido con las vendas de lana?', 0),
(@ID, 'esMX', 'Ah, $c, ¿has vuelto tan rápido con las vendas de lana?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tienes mi agradecimiento, $c, y el agradecimiento de la Horda. Si encuentras más vendas de lana, tráemelas aquí si deseas contribuir aún más al esfuerzo de guerra. Hasta entonces, ¡que tus antepasados velen por ti!', 0),
(@ID, 'esMX', 'Tienes mi agradecimiento, $c, y el agradecimiento de la Horda. Si encuentras más vendas de lana, tráemelas aquí si deseas contribuir aún más al esfuerzo de guerra. Hasta entonces, ¡que tus antepasados velen por ti!', 0);
-- 8605 ¡La Horda necesita más vendas de lana!
-- https://es.classic.wowhead.com/quest=8605
SET @ID := 8605;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Como $c, mereces todos mis respetos, $n! Me aseguraré de que esas vendas van a parar a las manos apropiadas. Cuentas con mi más sincero agradecimiento, así como con el de la Horda.$B$BVe en paz y vuelve si te encuentras con que te sobran vendas de lana. Toda contribución nos viene bien.', 0),
(@ID, 'esMX', '¡Como $c, mereces todos mis respetos, $n! Me aseguraré de que esas vendas van a parar a las manos apropiadas. Cuentas con mi más sincero agradecimiento, así como con el de la Horda.$B$BVe en paz y vuelve si te encuentras con que te sobran vendas de lana. Toda contribución nos viene bien.', 0);
-- 8606 ¡Señuelo!
-- https://es.classic.wowhead.com/quest=8606
SET @ID := 8606;
UPDATE `quest_template_locale` SET `ObjectiveText1` = '¿Para quién trabaja el Número Dos?', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Creo que es posible que hayamos subestimado a estos secuestradores de libros.', 0),
(@ID, 'esMX', 'Creo que es posible que hayamos subestimado a estos secuestradores de libros.', 0);
-- 8607 ¡La Horda necesita vendas de tejido mágico!
-- https://es.classic.wowhead.com/quest=8607
SET @ID := 8607;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡No me falles, me dejarías mal, $c! Vuelve lo antes posible con las vendas de tejido mágico de las que hablamos.', 0),
(@ID, 'esMX', '¡No me falles, me dejarías mal, $c! Vuelve lo antes posible con las vendas de tejido mágico de las que hablamos.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sorprendente, aunque aceptable. Quizás he subestimado tus facultades, $c. Quizás. Has completado una tarea muy sencilla y por ello recibirás una recompensa aún mayor. Pero que no se te suba a la cabeza. Si realmente quieres demostrar lo que vales, tendrás que volver a salir ahí fuera y traerme otro lote de vendas de tejido mágico.', 0),
(@ID, 'esMX', 'Sorprendente, aunque aceptable. Quizás he subestimado tus facultades, $c. Quizás. Has completado una tarea muy sencilla y por ello recibirás una recompensa aún mayor. Pero que no se te suba a la cabeza. Si realmente quieres demostrar lo que vales, tendrás que volver a salir ahí fuera y traerme otro lote de vendas de tejido mágico.', 0);
-- 8608 ¡La Horda necesita más vendas de tejido mágico!
-- https://es.classic.wowhead.com/quest=8608
SET @ID := 8608;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Asombroso, $c, lo has vuelto a conseguir! Bueno, cierto es que suelen decir que tengo buen olfato para elegir a mis colaboradores. Muy bien, se anotará tu contribución y recibirás los beneficios sociales que tu trabajo merece. Te sugiero que vuelvas de ronda y recolectes otro lote de vendas de tejido mágico si realmente quieres demostrar lo que vales.', 0),
(@ID, 'esMX', '¡Asombroso, $c, lo has vuelto a conseguir! Bueno, cierto es que suelen decir que tengo buen olfato para elegir a mis colaboradores. Muy bien, se anotará tu contribución y recibirás los beneficios sociales que tu trabajo merece. Te sugiero que vuelvas de ronda y recolectes otro lote de vendas de tejido mágico si realmente quieres demostrar lo que vales.', 0);
-- 8609 ¡La Horda necesita vendas de paño rúnico!
-- https://es.classic.wowhead.com/quest=8609
SET @ID := 8609;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Se avecina la guerra, me parece, $c. Te agradezco el tiempo y el esfuerzo que has dedicado a ayudarnos en nuestras tareas de recolección. ¿Has regresado porque ya tienes las vendas de paño rúnico de las que hablamos antes?', 0),
(@ID, 'esMX', 'Se avecina la guerra, me parece, $c. Te agradezco el tiempo y el esfuerzo que has dedicado a ayudarnos en nuestras tareas de recolección. ¿Has regresado porque ya tienes las vendas de paño rúnico de las que hablamos antes?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Eres un orgullo para la Horda, $c. Gracias por tus continuos esfuerzos, ¡de corazón! Tendré que envolver estas nuevas vendas y hacer un recuento para ver cuánto nos falta para el objetivo. Si te apetece, puedes recolectar más vendas de paño rúnico y traérmelas aquí.', 0),
(@ID, 'esMX', 'Eres un orgullo para la Horda, $c. Gracias por tus continuos esfuerzos, ¡de corazón! Tendré que envolver estas nuevas vendas y hacer un recuento para ver cuánto nos falta para el objetivo. Si te apetece, puedes recolectar más vendas de paño rúnico y traérmelas aquí.', 0);
-- 8610 ¡La Horda necesita más vendas de paño rúnico!
-- https://es.classic.wowhead.com/quest=8610
SET @ID := 8610;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muestras un gran altruismo en tus actos, $n. Y con ello probablemente se salven muchas vidas de quienes van a combatir en Ahn\'Qiraj. Gracias y que sepas que cuentas con el agradecimiento de la Horda por tu donación. Si confeccionas o encuentras más vendas de paño rúnico, te ruego pienses en traérmelas aquí.', 0),
(@ID, 'esMX', 'Muestras un gran altruismo en tus actos, $n. Y con ello probablemente se salven muchas vidas de quienes van a combatir en Ahn\'Qiraj. Gracias y que sepas que cuentas con el agradecimiento de la Horda por tu donación. Si confeccionas o encuentras más vendas de paño rúnico, te ruego pienses en traérmelas aquí.', 0);
-- 8611 ¡La Horda necesita filetes de lobo magro!
-- https://es.classic.wowhead.com/quest=8611
SET @ID := 8611;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿De vuelta con esos magros filetes de lobo tan pronto, $c? No me importa si están demasiado hechos o crudos, ¡solo asegúrate de que estén sabrosos y tráemelos rápido!', 0),
(@ID, 'esMX', '¿De vuelta con esos magros filetes de lobo tan pronto, $c? No me importa si están demasiado hechos o crudos, ¡solo asegúrate de que estén sabrosos y tráemelos rápido!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ok, este montón de carne me parece bien. Los salaré y luego los empaquetaré y, con suerte, se mantendrán lo suficientemente frescos como para ser comestibles cuando llegue el momento.$B$BGracias por la contribución, $c. ¿Crees que podrías traerme otro lote?', 0),
(@ID, 'esMX', 'Ok, este montón de carne me parece bien. Los salaré y luego los empaquetaré y, con suerte, se mantendrán lo suficientemente frescos como para ser comestibles cuando llegue el momento.$B$BGracias por la contribución, $c. ¿Crees que podrías traerme otro lote?', 0);
-- 8613 ¡La Horda necesita serviolas moteadas!
-- https://es.classic.wowhead.com/quest=8613
SET @ID := 8613;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Regresaste tan pronto con las serviolas moteadas, $c? ¿T\'acuerdas de cocinarlo bien? N\'estamos sirviendo pescado crudo a los soldados bajo el ardiente sol del desierto, sin duda.', 0),
(@ID, 'esMX', '¿Regresaste tan pronto con las serviolas moteadas, $c? ¿T\'acuerdas de cocinarlo bien? N\'estamos sirviendo pescado crudo a los soldados bajo el ardiente sol del desierto, sin duda.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Oh sí, esto es lo bueno. L\'empaquetaré muy bien pa\'que no se desperdicie. Gracias por ayudarme así. Creo qu\'eres $gel pescador:la pescadora; número uno por toda esta serviola moteada. Y si pescas y cocinas aún más, tráemelo aquí; ¡M\'aseguraré de que todos sepan que l\'hiciste!', 0),
(@ID, 'esMX', 'Oh sí, esto es lo bueno. L\'empaquetaré muy bien pa\'que no se desperdicie. Gracias por ayudarme así. Creo qu\'eres $gel pescador:la pescadora; número uno por toda esta serviola moteada. Y si pescas y cocinas aún más, tráemelo aquí; ¡M\'aseguraré de que todos sepan que l\'hiciste!', 0);
-- 8614 ¡La Horda necesita más serviolas moteadas!
-- https://es.classic.wowhead.com/quest=8614
SET @ID := 8614;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡La pesca más guay, $n! Lo que se dice un trabajo bueno y honesto. ¡Y sin espinas! Gracias por conseguir to\'a esa serviola moteada, colega. ¡Vuelve pronto si cocinas más!', 0),
(@ID, 'esMX', '¡La pesca más guay, $n! Lo que se dice un trabajo bueno y honesto. ¡Y sin espinas! Gracias por conseguir to\'a esa serviola moteada, colega. ¡Vuelve pronto si cocinas más!', 0);
-- 8615 ¡La Horda necesita salmón asado!
-- https://es.classic.wowhead.com/quest=8615
SET @ID := 8615;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has vuelto con el salmón asado, $c? Recuerda, debe estar bien asado; Desafortunadamente, no tengo ningún uso para el pescado crudo.', 0),
(@ID, 'esMX', '¿Has vuelto con el salmón asado, $c? Recuerda, debe estar bien asado; Desafortunadamente, no tengo ningún uso para el pescado crudo.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias por demostrar tu interés en ayudar con el esfuerzo bélico, $c. Muchos simplemente ignorarían nuestras necesidades y optarían por obtener ganancias. Pero no cuentan con la gratitud de la Horda, como tú ahora. Sus corazones no están llenos, ya que el tuyo debe estar lleno del orgullo que proviene de la generosidad desinteresada.$B$BNuevamente, te lo agradezco. Si encuentra tiempo para ayudarnos más, antes de que finalicen nuestros preparativos, estaré aquí esperando.', 0),
(@ID, 'esMX', 'Gracias por demostrar tu interés en ayudar con el esfuerzo bélico, $c. Muchos simplemente ignorarían nuestras necesidades y optarían por obtener ganancias. Pero no cuentan con la gratitud de la Horda, como tú ahora. Sus corazones no están llenos, ya que el tuyo debe estar lleno del orgullo que proviene de la generosidad desinteresada.$B$BNuevamente, te lo agradezco. Si encuentra tiempo para ayudarnos más, antes de que finalicen nuestros preparativos, estaré aquí esperando.', 0);
-- 8619 Alborhondo el Ancestro
-- https://es.wowhead.com/quest=8619
SET @ID := 8619;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(@ID, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0);
-- 8620 La única receta
-- https://es.classic.wowhead.com/quest=8620
SET @ID := 8620;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Me pongo los pantalones como tú, una pierna y luego la otra. Excepto cuando tengo los pantalones puestos, entonces hago boyas de arcanita. ¡Boyas de arcanita, bebé!', 0),
(@ID, 'esMX', 'Me pongo los pantalones como tú, una pierna y luego la otra. Excepto cuando tengo los pantalones puestos, entonces hago boyas de arcanita. ¡Boyas de arcanita, bebé!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Fantástico! ¡No puedo creer que hayas pasado por el lío! ¿Eres una especie de máquina? Si fuera yo, probablemente habría dejado que el mundo se derrumbara.$B$BTe doy mi turbante, $gseñor:señora;. Ninguna buena acción debe quedar sin recompensa.', 0),
(@ID, 'esMX', '¡Fantástico! ¡No puedo creer que hayas pasado por el lío! ¿Eres una especie de máquina? Si fuera yo, probablemente habría dejado que el mundo se derrumbara.$B$BTe doy mi turbante, $gseñor:señora;. Ninguna buena acción debe quedar sin recompensa.', 0);
-- 8621 Los guardapiés de clamatormentas
-- https://es.classic.wowhead.com/quest=8621
SET @ID := 8621;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has adquirido los artículos que te pedí, $n?', 0),
(@ID, 'esMX', '¿Has adquirido los artículos que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0),
(@ID, 'esMX', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0);
-- 8622 El camisote de clamatormentas
-- https://es.classic.wowhead.com/quest=8622
SET @ID := 8622;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'En su morada en Ahn\'Qiraj, el pavoroso C\'Thun aguarda dormido.', 0),
(@ID, 'esMX', 'En su morada en Ahn\'Qiraj, el pavoroso C\'Thun aguarda dormido.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No esperaba que volvieras de tu intento, $n.$B$BHas cumplido un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun, no solo has salvado todo Azeroth, sino que también has inclinado la balanza de los eventos cósmicos más allá de tu comprensión.$B$BAcepta esta coraza como símbolo de la gloria y la carga que vendrán como consecuencia de tus acciones.$B$B¡Que su poder te ayude en los desafíos que te esperan, asesino de dioses!', 0),
(@ID, 'esMX', 'No esperaba que volvieras de tu intento, $n.$B$BHas cumplido un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun, no solo has salvado todo Azeroth, sino que también has inclinado la balanza de los eventos cósmicos más allá de tu comprensión.$B$BAcepta esta coraza como símbolo de la gloria y la carga que vendrán como consecuencia de tus acciones.$B$B¡Que su poder te ayude en los desafíos que te esperan, asesino de dioses!', 0);
-- 8623 La diadema de clamatormentas
-- https://es.classic.wowhead.com/quest=8623
SET @ID := 8623;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(@ID, 'esMX', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0);
-- 8624 Los leotardos de clamatormentas
-- https://es.classic.wowhead.com/quest=8624
SET @ID := 8624;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
-- 8625 Las hombreras enigma
-- https://es.classic.wowhead.com/quest=8625
SET @ID := 8625;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0),
(@ID, 'esMX', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0);
-- 8626 Los guardapiés de asediador
-- https://es.classic.wowhead.com/quest=8626
SET @ID := 8626;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0),
(@ID, 'esMX', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0);
-- 8627 La coraza del Vengador
-- https://es.classic.wowhead.com/quest=8627
SET @ID := 8627;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0),
(@ID, 'esMX', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0),
(@ID, 'esMX', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0);
-- 8628 La corona del Vengador
-- https://es.classic.wowhead.com/quest=8628
SET @ID := 8628;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0),
(@ID, 'esMX', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0);
-- 8629 Las musleras del Vengador
-- https://es.classic.wowhead.com/quest=8629
SET @ID := 8629;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0),
(@ID, 'esMX', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0);
-- 8630 Los espaldares del Vengador
-- https://es.classic.wowhead.com/quest=8630
SET @ID := 8630;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0),
(@ID, 'esMX', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0);
-- 8631 Los leotardos enigma
-- https://es.classic.wowhead.com/quest=8631
SET @ID := 8631;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
-- 8632 El aro enigma
-- https://es.classic.wowhead.com/quest=8632
SET @ID := 8632;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(@ID, 'esMX', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0);
-- 8633 Togas Enigma
-- https://es.classic.wowhead.com/quest=8633
SET @ID := 8633;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0),
(@ID, 'esMX', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0),
(@ID, 'esMX', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0);
-- 8634 Las botas enigma
-- https://es.classic.wowhead.com/quest=8634
SET @ID := 8634;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0),
(@ID, 'esMX', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0);
-- 8635 Parterroca el Ancestro
-- https://es.wowhead.com/quest=8635
SET @ID := 8635;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Las batallas de eras pasadas son las semillas de las que crecen las leyendas. El tuyo es un tiempo de héroes, joven. Que tu propia leyenda tome raíces y crezca con fuerza.$B$BTe deseo lo mejor, $n, y te ofrezco esta muestra...', 0),
(@ID, 'esMX', 'Las batallas de eras pasadas son las semillas de las que crecen las leyendas. El tuyo es un tiempo de héroes, joven. Que tu propia leyenda tome raíces y crezca con fuerza.$B$BTe deseo lo mejor, $n, y te ofrezco esta muestra...', 0);
-- 8636 Rocaestruendo el Ancestro
-- https://es.classic.wowhead.com/quest=8636
SET @ID := 8636;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'La materia de la vida está condenada a morir y volver a la tierra, pero la materia del espíritu vive toda la eternidad. Te deseo lo mejor, $n, y te ofrezco esta muestra...', 0),
(@ID, 'esMX', 'La materia de la vida está condenada a morir y volver a la tierra, pero la materia del espíritu vive toda la eternidad. Te deseo lo mejor, $n, y te ofrezco esta muestra...', 0);
-- 8637 Las botas de mortífero
-- https://es.classic.wowhead.com/quest=8637
SET @ID := 8637;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0),
(@ID, 'esMX', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0);
-- 8638 El jubón de mortífero
-- https://es.classic.wowhead.com/quest=8638
SET @ID := 8638;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0),
(@ID, 'esMX', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0),
(@ID, 'esMX', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0);
-- 8639 El yelmo de mortífero
-- https://es.classic.wowhead.com/quest=8639
SET @ID := 8639;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(@ID, 'esMX', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0);
-- 8640 Los leotardos de mortífero
-- https://es.classic.wowhead.com/quest=8640
SET @ID := 8640;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
-- 8641 Las bufas de mortífero
-- https://es.classic.wowhead.com/quest=8641
SET @ID := 8641;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0),
(@ID, 'esMX', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0);

-- Venaplata el Ancestro
-- 8642, 8643, 8644, 8645, 8647, 8648, 8650, 8651, 8652, 8653, 8654
-- https://es.wowhead.com/quest=8642
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8642, 8643, 8644, 8645, 8647, 8648, 8650, 8651, 8652, 8653, 8654) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8642, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8643, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8644, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8645, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8647, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8648, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8650, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8651, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8652, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8653, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8654, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8642, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8643, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8644, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8645, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8647, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8648, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8650, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8651, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8652, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8653, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(8654, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0);
-- Las grebas del Vengador
-- 8655, 8660, 8665
-- https://es.classic.wowhead.com/quest=8655
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8655, 8660, 8665) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8655, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8660, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8665, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8655, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8660, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8665, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8655, 8660, 8665) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8655, 'esES', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0),
(8660, 'esES', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0),
(8665, 'esES', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0),
(8655, 'esMX', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0),
(8660, 'esMX', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0),
(8665, 'esMX', 'Lo has hecho bien, $n. Has probado que no eres $gun:una; mortal $gordinario:ordinaria;.$B$BTe los doy con la confianza de que te ayudarán a aplastar al vil qiraji.', 0);
-- El camisote de asediador
-- 8656, 8666
-- https://es.classic.wowhead.com/quest=8656
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8656, 8666) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8656, 'esES', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0),
(8666, 'esES', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0),
(8656, 'esMX', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0),
(8666, 'esMX', 'En su morada de Ahn\'Qiraj, el terrible C\'Thun aguarda dormido apaciblemente.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8656, 8666) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8656, 'esES', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0),
(8666, 'esES', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0),
(8656, 'esMX', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0),
(8666, 'esMX', 'No esperaba que regresaras de tu intento, $n.$B$BHas alcanzado un destino más grande que el de la mayoría de los seres inmortales.$B$BAl matar a C\'Thun no solo has salvado a todo Azeroth, también has cambiado el balance de los acontecimientos cósmicos más allá de tu comprensión.$B$BAcepta esta togas como símbolo de la gloria y el peso de las consecuencias que tus acciones acarrearán.$B$BQue su poder te ayude en los retos que te aguardan, ¡$gasesino:asesina; de dioses!', 0);
-- La diadema de asediador
-- 8657, 8662, 8667
-- https://es.classic.wowhead.com/quest=8657
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8657, 8662, 8667) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8657, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8662, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8667, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8657, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8662, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8667, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8657, 8662, 8667) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8657, 'esES', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(8662, 'esES', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(8667, 'esES', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(8657, 'esMX', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(8662, 'esMX', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0),
(8667, 'esMX', '¡Lo has logrado! Los susurros de los Emperadores Gemelos han cesado.$B$BToma esto como recompensa. El mero hecho de verlo infundirá miedo en los corazones de los Qiraji... les recordará a sus líderes caídos y $gal:a la; mortal que los mató.', 0);
-- 8658 Los leotardos de asediador
-- https://es.classic.wowhead.com/quest=8658
SET @ID := 8658;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(@ID, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
-- Los espaldares de asediador
-- 8659, 8664, 8669
-- https://es.classic.wowhead.com/quest=8659
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8659, 8664, 8669) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8659, 'esES', '¿Me trajiste los componentes que te pedí?', 0),
(8664, 'esES', '¿Me trajiste los componentes que te pedí?', 0),
(8669, 'esES', '¿Me trajiste los componentes que te pedí?', 0),
(8659, 'esMX', '¿Me trajiste los componentes que te pedí?', 0),
(8664, 'esMX', '¿Me trajiste los componentes que te pedí?', 0),
(8669, 'esMX', '¿Me trajiste los componentes que te pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8659, 8664, 8669) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8659, 'esES', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0),
(8664, 'esES', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0),
(8669, 'esES', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0),
(8659, 'esMX', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0),
(8664, 'esMX', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0),
(8669, 'esMX', 'De los materiales que traes y de las escamas de nuestros enemigos Qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que al verte infunda miedo en nuestros enemigos.', 0);
-- Las calzas clamacondenas
-- 8663, 8668
-- https://es.classic.wowhead.com/quest=8663
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8663, 8668) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8663, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8668, 'esES', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8663, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0),
(8668, 'esMX', '¿Me trajiste los componentes que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8663, 8668) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8663, 'esES', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0),
(8668, 'esES', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0),
(8663, 'esMX', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0),
(8668, 'esMX', 'Sí... la piel del gusano será una excelente capa protectora. Combinado con las partes más fuertes de los Qiraji que hemos destruido en nuestro camino hacia aquí, esto debería ser una formidable pieza de armadura. ¡Que te ayude a afrontar los horrores indescriptibles que te aguardan en el interior!', 0);
-- Tótem de Runa el Ancestro
-- 8670, 8671, 8672, 8673, 8674, 8675, 8676, 8677, 8678, 8679, 8680, 8681, 8682, 8683, 8684, 8685, 8686
-- https://es.wowhead.com/quest=8670
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8670, 8671, 8672, 8673, 8674, 8675, 8676, 8677, 8678, 8679, 8680, 8681, 8682, 8683, 8684, 8685, 8686) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8670, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8671, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8672, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8673, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8674, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8675, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8676, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8677, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8678, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8679, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8680, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8681, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8682, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8683, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8684, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8685, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8686, 'esES', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8670, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8671, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8672, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8673, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8674, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8675, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8676, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8677, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8678, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8679, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8680, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8681, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8682, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8683, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8684, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8685, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0),
(8686, 'esMX', 'Tu espíritu arde lleno de vida, joven $c. Acepto el homenaje que me rindes, y te ofrezco a cambio esta muestra...', 0);
-- 8687 Objetivo: los tuneladores de Colmen'Zora
-- https://es.classic.wowhead.com/quest=8687
SET @ID := 8687;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo que decirme, $c?', 0),
(@ID, 'esMX', '¿Tienes algo que decirme, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo, $n. Sin sus tuneladores, los silítidos tendrán dificultades para reparar cualquier daño infligido a la estructura de su colmena. Supongo que querrás una nueva tarea.', 0),
(@ID, 'esMX', 'Excelente trabajo, $n. Sin sus tuneladores, los silítidos tendrán dificultades para reparar cualquier daño infligido a la estructura de su colmena. Supongo que querrás una nueva tarea.', 0);
-- 8688 Fuerteviento el Ancestro
-- https://es.wowhead.com/quest=8688
SET @ID := 8688;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(@ID, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0);
-- El embozo de sabiduría infinita
-- 8689, 8690, 8691, 8692, 8693, 8694, 8695, 8696
-- https://es.classic.wowhead.com/quest=8689
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8689, 8690, 8691, 8692, 8693, 8694, 8695, 8696) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8689, 'esES', '¿Trajiste los materiales para la capa, $n?', 0),
(8690, 'esES', '¿Trajiste los materiales para la capa, $n?', 0),
(8691, 'esES', '¿Trajiste los materiales para la capa, $n?', 0),
(8692, 'esES', '¿Trajiste los materiales para la capa, $n?', 0),
(8693, 'esES', '¿Trajiste los materiales para la capa, $n?', 0),
(8694, 'esES', '¿Trajiste los materiales para la capa, $n?', 0),
(8695, 'esES', '¿Trajiste los materiales para la capa, $n?', 0),
(8696, 'esES', '¿Trajiste los materiales para la capa, $n?', 0),
(8689, 'esMX', '¿Trajiste los materiales para la capa, $n?', 0),
(8690, 'esMX', '¿Trajiste los materiales para la capa, $n?', 0),
(8691, 'esMX', '¿Trajiste los materiales para la capa, $n?', 0),
(8692, 'esMX', '¿Trajiste los materiales para la capa, $n?', 0),
(8693, 'esMX', '¿Trajiste los materiales para la capa, $n?', 0),
(8694, 'esMX', '¿Trajiste los materiales para la capa, $n?', 0),
(8695, 'esMX', '¿Trajiste los materiales para la capa, $n?', 0),
(8696, 'esMX', '¿Trajiste los materiales para la capa, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8689, 8690, 8691, 8692, 8693, 8694, 8695, 8696) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8689, 'esES', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8690, 'esES', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8691, 'esES', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8692, 'esES', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8693, 'esES', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8694, 'esES', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8695, 'esES', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8696, 'esES', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8689, 'esMX', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8690, 'esMX', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8691, 'esMX', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8692, 'esMX', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8693, 'esMX', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8694, 'esMX', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8695, 'esMX', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0),
(8696, 'esMX', 'Ah, sí... este mantón está impecable.$B$BToma esta capa, $n. Que te proteja de la magia repugnante de los qiraji.', 0);
-- El anillo de sabiduría infinita
-- 8697, 8698, 8699, 8700, 8701, 8702, 8703, 8704
-- https://es.classic.wowhead.com/quest=8697
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8697, 8698, 8699, 8700, 8701, 8702, 8703, 8704) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8697, 'esES', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8698, 'esES', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8699, 'esES', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8700, 'esES', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8701, 'esES', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8702, 'esES', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8703, 'esES', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8704, 'esES', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8697, 'esMX', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8698, 'esMX', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8699, 'esMX', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8700, 'esMX', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8701, 'esMX', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8702, 'esMX', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8703, 'esMX', '¿Me trajiste el anillo y los materiales, $n?', 0),
(8704, 'esMX', '¿Me trajiste el anillo y los materiales, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8697, 8698, 8699, 8700, 8701, 8702, 8703, 8704) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8697, 'esES', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8698, 'esES', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8699, 'esES', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8700, 'esES', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8701, 'esES', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8702, 'esES', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8703, 'esES', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8704, 'esES', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8697, 'esMX', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8698, 'esMX', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8699, 'esMX', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8700, 'esMX', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8701, 'esMX', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8702, 'esMX', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8703, 'esMX', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0),
(8704, 'esMX', 'Cambiaré la gema del anillo por ti. Descubrirás que el efecto es mucho más... agradable.', 0);
-- El mazo de sabiduría infinita
-- 8705, 8706, 8707, 8708, 8709, 8710, 8711, 8712
-- https://es.classic.wowhead.com/quest=8705
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8705, 8706, 8707, 8708, 8709, 8710, 8711, 8712) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8705, 'esES', '¿Me trajiste los componentes que necesito, $n?', 0),
(8706, 'esES', '¿Me trajiste los componentes que necesito, $n?', 0),
(8707, 'esES', '¿Me trajiste los componentes que necesito, $n?', 0),
(8708, 'esES', '¿Me trajiste los componentes que necesito, $n?', 0),
(8709, 'esES', '¿Me trajiste los componentes que necesito, $n?', 0),
(8710, 'esES', '¿Me trajiste los componentes que necesito, $n?', 0),
(8711, 'esES', '¿Me trajiste los componentes que necesito, $n?', 0),
(8712, 'esES', '¿Me trajiste los componentes que necesito, $n?', 0),
(8705, 'esMX', '¿Me trajiste los componentes que necesito, $n?', 0),
(8706, 'esMX', '¿Me trajiste los componentes que necesito, $n?', 0),
(8707, 'esMX', '¿Me trajiste los componentes que necesito, $n?', 0),
(8708, 'esMX', '¿Me trajiste los componentes que necesito, $n?', 0),
(8709, 'esMX', '¿Me trajiste los componentes que necesito, $n?', 0),
(8710, 'esMX', '¿Me trajiste los componentes que necesito, $n?', 0),
(8711, 'esMX', '¿Me trajiste los componentes que necesito, $n?', 0),
(8712, 'esMX', '¿Me trajiste los componentes que necesito, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8705, 8706, 8707, 8708, 8709, 8710, 8711, 8712) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8705, 'esES', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8706, 'esES', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8707, 'esES', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8708, 'esES', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8709, 'esES', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8710, 'esES', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8711, 'esES', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8712, 'esES', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8705, 'esMX', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8706, 'esMX', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8707, 'esMX', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8708, 'esMX', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8709, 'esMX', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8710, 'esMX', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8711, 'esMX', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0),
(8712, 'esMX', 'Lo has hecho bien, $n. Esta empuñadura es una obra maestra... el equilibrio es perfecto.$B$BToma tu arma, $n. ¡Esgrímela con confianza y vence a nuestros enemigos!', 0);
-- Cantoestelar el Ancestro
-- 8713, 8714, 8715, 8716, 8717, 8718, 8719, 8720, 8721, 8722, 8723, 8724, 8725, 8726, 8727
-- https://es.classic.wowhead.com/quest=8713
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8713, 8714, 8715, 8716, 8717, 8718, 8719, 8720, 8721, 8722, 8723, 8724, 8725, 8726, 8727) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8713, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8714, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8715, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8716, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8717, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8718, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8719, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8720, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8721, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8722, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8723, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8724, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8725, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8726, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8727, 'esES', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8713, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8714, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8715, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8716, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8717, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8718, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8719, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8720, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8721, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8722, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8723, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8724, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8725, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8726, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0),
(8727, 'esMX', 'Los cielos, con sus incontables estrellas, guardan las respuestas a los misterios terrenales, $n. ¿Pueden entonces el sabio o el afortunado, mirar hacia arriba y descubrir la verdad?', 0);
-- 8728 Buenas y malas noticias
-- https://es.classic.wowhead.com/quest=8728
SET @ID := 8728;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Las boyas de arcanita no se hacen solas, $n. Y NO, no puedes pedir dinero prestado.', 0),
(@ID, 'esMX', 'Las boyas de arcanita no se hacen solas, $n. Y NO, no puedes pedir dinero prestado.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trato es un trato. Espero que sepas en lo que te estás metiendo, $n. Esto es un gran problema de pesca.', 0),
(@ID, 'esMX', 'Un trato es un trato. Espero que sepas en lo que te estás metiendo, $n. Esto es un gran problema de pesca.', 0);
-- 8729 La cólera de Neptulon
-- https://es.classic.wowhead.com/quest=8729
SET @ID := 8729;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El tiempo se acaba, $gcampeón:campeona;.', 0),
(@ID, 'esMX', 'El tiempo se acaba, $gcampeón:campeona;.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Bien hecho, $n. Pronto podré reformar el cetro de las arenas movedizas.', 0),
(@ID, 'esMX', 'Bien hecho, $n. Pronto podré reformar el cetro de las arenas movedizas.', 0);
-- 8730 La corrupción de Nefarius
-- https://es.classic.wowhead.com/quest=8730
SET @ID := 8730;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Otro de nuestros héroes perdió ante el engendro de Alamuerte. Seremos maldecidos con este sufrimiento para siempre...', 0),
(@ID, 'esMX', 'Otro de nuestros héroes perdió ante el engendro de Alamuerte. Seremos maldecidos con este sufrimiento para siempre...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El alma de Vaelastrasz está en paz, $gcampeón:campeona;. Todos los Aspectos observan tu progreso con gran interés. Debes saber que tiene aliados poderosos.$B$BSe me ordenó que te conceda algo que te ayude en esta lucha. Úsalo bien...', 0),
(@ID, 'esMX', 'El alma de Vaelastrasz está en paz, $gcampeón:campeona;. Todos los Aspectos observan tu progreso con gran interés. Debes saber que tiene aliados poderosos.$B$BSe me ordenó que te conceda algo que te ayude en esta lucha. Úsalo bien...', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
