-- DB update 2021_05_06_04 -> 2021_05_06_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_06_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_06_04 2021_05_06_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619817090623034700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619817090623034700');

-- 9059 Las manoplas de acechacriptas
-- https://es.classic.wowhead.com/quest=9059
SET @ID := 9059;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Manoplas de acechacriptas.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Manoplas de acechacriptas.', 0);
-- 9060 La faja de acechacriptas
-- https://es.classic.wowhead.com/quest=9060
SET @ID := 9060;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Faja de acechacriptas.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Faja de acechacriptas.', 0);
-- 9061 Los guardamuñecas de acechacriptas
-- https://es.classic.wowhead.com/quest=9061
SET @ID := 9061;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unos Guardamuñecas de acechacriptas.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unos Guardamuñecas de acechacriptas.', 0);
-- 9063 Torwa Abrecaminos
-- https://es.classic.wowhead.com/quest=9063
SET @ID := 9063;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Has hecho un largo camino para venir a verme, $c, y has llegado justo a tiempo.', 0),
(@ID, 'esMX', 'Has hecho un largo camino para venir a verme, $c, y has llegado justo a tiempo.', 0);
-- 9068 La guerrera Rompeterra
-- https://es.classic.wowhead.com/quest=9068
SET @ID := 9068;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Guerrera Rompeterra.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Guerrera Rompeterra.', 0);
-- 9069 Las musleras Rompeterra
-- https://es.classic.wowhead.com/quest=9069
SET @ID := 9069;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Musleras Rompeterra.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Musleras Rompeterra.', 0);
-- 9070 La celada Rompeterra
-- https://es.classic.wowhead.com/quest=9070
SET @ID := 9070;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Celada Rompeterra.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Celada Rompeterra.', 0);
-- 9071 Las bufas Rompeterra
-- https://es.classic.wowhead.com/quest=9071
SET @ID := 9071;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Bufas Rompeterra.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Bufas Rompeterra.', 0);
-- 9072 Las botas Rompeterra
-- https://es.classic.wowhead.com/quest=9072
SET @ID := 9072;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Botas Rompeterra.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer unas Botas Rompeterra.', 0);
-- 9073 Las manoplas Rompeterra
-- https://es.classic.wowhead.com/quest=9073
SET @ID := 9073;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me has traído lo que necesito?', 0),
(@ID, 'esMX', '¿Me has traído lo que necesito?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Estas manoplas canalizan el poder de los elementos!', 0),
(@ID, 'esMX', '¡Estas manoplas canalizan el poder de los elementos!', 0);
-- 9074 La faja Rompeterra
-- https://es.classic.wowhead.com/quest=9074
SET @ID := 9074;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Faja Rompeterra.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Faja Rompeterra.', 0);
-- 9075 Los guardamuñecas Rompeterra
-- https://es.classic.wowhead.com/quest=9075
SET @ID := 9075;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me has traído lo que necesito?', 0),
(@ID, 'esMX', '¿Me has traído lo que necesito?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los guardamuñecas están listos, $n.$B$B<Rimblat hace una reverencia.>', 0),
(@ID, 'esMX', 'Los guardamuñecas están listos, $n.$B$B<Rimblat hace una reverencia.>', 0);
-- 9076 El jefe de los desdichados
-- https://es.wowhead.com/quest=9076
SET @ID := 9076;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me traes la cabeza? No tengo tiempo que perder, $n.', 0),
(@ID, 'esMX', '¿Me traes la cabeza? No tengo tiempo que perder, $n.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo derrotaste! Claro que mis hombres lo habían ablandado un poco antes.$B$BEs broma, $c. Lo hiciste muy bien. No te metas en líos y te harás de una buena reputación.', 0),
(@ID, 'esMX', '¡Lo derrotaste! Claro que mis hombres lo habían ablandado un poco antes.$B$BEs broma, $c. Lo hiciste muy bien. No te metas en líos y te harás de una buena reputación.', 0);
-- 9077 La coraza Segahuesos
-- https://es.classic.wowhead.com/quest=9077
SET @ID := 9077;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Coraza Segahuesos.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer una Coraza Segahuesos.', 0);
-- 9078 Los quijotes Segahuesos
-- https://es.classic.wowhead.com/quest=9078
SET @ID := 9078;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Rohan se ríe.>$B$BMe acabo de dar cuenta de la ironía de todo esto.', 0),
(@ID, 'esMX', '<Rohan se ríe.>$B$BMe acabo de dar cuenta de la ironía de todo esto.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ten cuidado al caminar con esas cosas. Puedes cortarte.', 0),
(@ID, 'esMX', 'Ten cuidado al caminar con esas cosas. Puedes cortarte.', 0);
-- 9079 El casco Segahuesos
-- https://es.classic.wowhead.com/quest=9079
SET @ID := 9079;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer un Casco Segahuesos.', 0),
(@ID, 'esMX', '¡Excelente $n! tienes todo lo que te pedí y ahora puedo hacer un Casco Segahuesos.', 0);
-- 9080 Los espaldares Segahuesos
-- https://es.classic.wowhead.com/quest=9080
SET @ID := 9080;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Rohan te mira con recelo.>$B$B¿Has estado en Mano de Tyr últimamente?', 0),
(@ID, 'esMX', '<Rohan te mira con recelo.>$B$B¿Has estado en Mano de Tyr últimamente?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Rohan se seca el sudor de la frente>.$B$B¡Estos hombros requirieron algo de trabajo! No salgas y te maten como a un matorral, $n.', 0),
(@ID, 'esMX', '<Rohan se seca el sudor de la frente>.$B$B¡Estos hombros requirieron algo de trabajo! No salgas y te maten como a un matorral, $n.', 0);
-- 9081 Los escarpes Segahuesos
-- https://es.classic.wowhead.com/quest=9081
SET @ID := 9081;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Solo tráeme los materiales y deja de perder mi tiempo, $n.', 0),
(@ID, 'esMX', 'Solo tráeme los materiales y deja de perder mi tiempo, $n.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Se ponen el los pies. Dime, no has vuelto a husmear en la Mano de Tyr, ¿verdad?', 0),
(@ID, 'esMX', 'Se ponen el los pies. Dime, no has vuelto a husmear en la Mano de Tyr, ¿verdad?', 0);
-- 9082 Los guanteletes Segahuesos
-- https://es.classic.wowhead.com/quest=9082
SET @ID := 9082;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Cómo esperas que haga algo sin los elementos que te pedí?', 0),
(@ID, 'esMX', '¿Cómo esperas que haga algo sin los elementos que te pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estos guanteletes podrían usarlos como armas si fuera necesario. ¡Úsalos con orgullo!', 0),
(@ID, 'esMX', 'Estos guanteletes podrían usarlos como armas si fuera necesario. ¡Úsalos con orgullo!', 0);
-- 9083 Los guardarrenes Segahuesos
-- https://es.classic.wowhead.com/quest=9083
SET @ID := 9083;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Cómo esperas que haga algo sin los elementos que te pedí?', 0),
(@ID, 'esMX', '¿Cómo esperas que haga algo sin los elementos que te pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El cinturón está listo, $n. ¿Alguna vez has visto un artículo de tan alta calidad vendido por tan poco?', 0),
(@ID, 'esMX', 'El cinturón está listo, $n. ¿Alguna vez has visto un artículo de tan alta calidad vendido por tan poco?', 0);
-- 9084 Los brazales Segahuesos
-- https://es.classic.wowhead.com/quest=9084
SET @ID := 9084;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Cómo esperas que haga algo sin los elementos que te pedí?', 0),
(@ID, 'esMX', '¿Cómo esperas que haga algo sin los elementos que te pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los brazaletes están listos, $n.$B$B<Rohan hace una reverencia.>', 0),
(@ID, 'esMX', 'Los brazaletes están listos, $n.$B$B<Rohan hace una reverencia.>', 0);
-- 9085 Sombras del Apocalipsis
-- https://es.classic.wowhead.com/quest=9085
SET @ID := 9085;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has tenido suerte, $n?', 0),
(@ID, 'esMX', '¿Has tenido suerte, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo, $n. Con las sombras destruidas, nuestra esperanza de victoria contra el Rey Exánime sobrevive.', 0),
(@ID, 'esMX', 'Excelente trabajo, $n. Con las sombras destruidas, nuestra esperanza de victoria contra el Rey Exánime sobrevive.', 0);
-- 9086 La guerrera Caminasueños
-- https://es.classic.wowhead.com/quest=9086
SET @ID := 9086;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El costo del material es alto, pero pronto lo olvidarás.', 0),
(@ID, 'esMX', 'El costo del material es alto, pero pronto lo olvidarás.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tu Guerrera Caminasueños está lista, $n.', 0),
(@ID, 'esMX', 'Tu Guerrera Caminasueños está lista, $n.', 0);
-- 9087 Las musleras Caminasueños
-- https://es.classic.wowhead.com/quest=9087
SET @ID := 9087;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El costo del material es alto, pero pronto lo olvidarás.', 0),
(@ID, 'esMX', 'El costo del material es alto, pero pronto lo olvidarás.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Como prometí, Musleras Caminasueños.$B$B<Rayne te entrega la armadura.>', 0),
(@ID, 'esMX', 'Como prometí, Musleras Caminasueños.$B$B<Rayne te entrega la armadura.>', 0);
-- 9088 La celada Caminasueños
-- https://es.classic.wowhead.com/quest=9088
SET @ID := 9088;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El costo del material es alto, pero pronto lo olvidarás.', 0),
(@ID, 'esMX', 'El costo del material es alto, pero pronto lo olvidarás.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tu Celada Caminasueños está lista, $n.', 0),
(@ID, 'esMX', 'Tu Celada Caminasueños está lista, $n.', 0);
-- 9089 Las bufas Caminasueños
-- https://es.classic.wowhead.com/quest=9089
SET @ID := 9089;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El costo del material es alto, pero pronto lo olvidarás.', 0),
(@ID, 'esMX', 'El costo del material es alto, pero pronto lo olvidarás.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tus Bufas Caminasueños están listas, $n.', 0),
(@ID, 'esMX', 'Tus Bufas Caminasueños están listas, $n.', 0);
-- 9090 Las botas Caminasueños
-- https://es.classic.wowhead.com/quest=9090
SET @ID := 9090;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El costo del material es alto, pero pronto lo olvidarás.', 0),
(@ID, 'esMX', 'El costo del material es alto, pero pronto lo olvidarás.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tus Botas Caminasueños están listas, $n.', 0),
(@ID, 'esMX', 'Tus Botas Caminasueños están listas, $n.', 0);
-- 9091 Las manoplas Caminasueños
-- https://es.classic.wowhead.com/quest=9091
SET @ID := 9091;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El costo del material es alto, pero pronto lo olvidarás.', 0),
(@ID, 'esMX', 'El costo del material es alto, pero pronto lo olvidarás.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tus Manoplas Caminasueños están listas, $n.', 0),
(@ID, 'esMX', 'Tus Manoplas Caminasueños están listas, $n.', 0);
-- 9092 La faja Caminasueños
-- https://es.classic.wowhead.com/quest=9092
SET @ID := 9092;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El costo del material es alto, pero pronto lo olvidarás.', 0),
(@ID, 'esMX', 'El costo del material es alto, pero pronto lo olvidarás.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tu Faja Caminasueños está lista, $n.', 0),
(@ID, 'esMX', 'Tu Faja Caminasueños está lista, $n.', 0);
-- 9093 Los guardamuñecas Caminasueños
-- https://es.classic.wowhead.com/quest=9093
SET @ID := 9093;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El costo del material es alto, pero pronto lo olvidarás.', 0),
(@ID, 'esMX', 'El costo del material es alto, pero pronto lo olvidarás.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tus Guardamuñecas Caminasueños están listos, $n.', 0),
(@ID, 'esMX', 'Tus Guardamuñecas Caminasueños están listos, $n.', 0);
-- 9095 La toga de Fuego de Escarcha
-- https://es.classic.wowhead.com/quest=9095
SET @ID := 9095;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una Toga de Fuego de Escarcha.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una Toga de Fuego de Escarcha.', 0);
-- 9096 Los leotardos de Fuego de Escarcha
-- https://es.classic.wowhead.com/quest=9096
SET @ID := 9096;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Leotardos de Fuego de Escarcha.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Leotardos de Fuego de Escarcha.', 0);
-- 9097 El aro de Fuego de Escarcha
-- https://es.classic.wowhead.com/quest=9097
SET @ID := 9097;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Aro de Fuego de Escarcha.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Aro de Fuego de Escarcha.', 0);

-- 9098 Las hombreras de Fuego de Escarcha
-- https://es.classic.wowhead.com/quest=9098
SET @ID := 9098;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Hombreras de Fuego de Escarcha.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Hombreras de Fuego de Escarcha.', 0);
-- 9099 Los botines de Fuego de Escarcha
-- https://es.classic.wowhead.com/quest=9099
SET @ID := 9099;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Botines de Fuego de Escarcha.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Botines de Fuego de Escarcha.', 0);
-- 9100 Los guantes de Fuego de Escarcha
-- https://es.classic.wowhead.com/quest=9100
SET @ID := 9100;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Guantes de Fuego de Escarcha.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Guantes de Fuego de Escarcha.', 0);
-- 9101 El cinturón de Fuego de Escarcha
-- https://es.classic.wowhead.com/quest=9101
SET @ID := 9101;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Cinturón de Fuego de Escarcha.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Cinturón de Fuego de Escarcha.', 0);
-- 9102 Las ataduras de Fuego de Escarcha
-- https://es.classic.wowhead.com/quest=9102
SET @ID := 9102;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Ataduras de Fuego de Escarcha.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Ataduras de Fuego de Escarcha.', 0);
-- 9103 La toga corazón de la peste
-- https://es.classic.wowhead.com/quest=9103
SET @ID := 9103;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una Toga corazón de peste.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una Toga corazón de peste.', 0);
-- 9104 Los leotardos corazón de la peste
-- https://es.classic.wowhead.com/quest=9104
SET @ID := 9104;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Leotardos corazón de peste.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Leotardos corazón de peste.', 0);
-- 9105 El aro corazón de la peste
-- https://es.classic.wowhead.com/quest=9105
SET @ID := 9105;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Aro corazón de peste.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Aro corazón de peste.', 0);
-- 9106 Las hombreras corazón de la peste
-- https://es.classic.wowhead.com/quest=9106
SET @ID := 9106;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Hombreras corazón de peste.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Hombreras corazón de peste.', 0);
-- 9107 Los botines corazón de peste
-- https://es.classic.wowhead.com/quest=9107
SET @ID := 9107;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Botines corazón de peste.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Botines corazón de peste.', 0);
-- 9108 Los guantes corazón de la peste
-- https://es.classic.wowhead.com/quest=9108
SET @ID := 9108;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Guantes corazón de peste.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Guantes corazón de peste.', 0);
-- 9109 El cinturón corazón de la peste
-- https://es.classic.wowhead.com/quest=9109
SET @ID := 9109;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Cinturón corazón de peste.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Cinturón corazón de peste.', 0);
-- 9110 Las ataduras corazón de la peste
-- https://es.classic.wowhead.com/quest=9110
SET @ID := 9110;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Ataduras corazón de peste.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Ataduras corazón de peste.', 0);
-- 9111 La toga de fe
-- https://es.classic.wowhead.com/quest=9111
SET @ID := 9111;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una Toga de fe.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer una Toga de fe.', 0);
-- 9112 Los leotardos de fe
-- https://es.classic.wowhead.com/quest=9112
SET @ID := 9112;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Leotardos de fe.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unos Leotardos de fe.', 0);
-- 9113 El aro de fe
-- https://es.classic.wowhead.com/quest=9113
SET @ID := 9113;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Aro de fe.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Aro de fe.', 0);
-- 9114 Las hombreras de fe
-- https://es.classic.wowhead.com/quest=9114
SET @ID := 9114;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me has traído los reactivos, $gniño:niña;?', 0),
(@ID, 'esMX', '¿Me has traído los reactivos, $gniño:niña;?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Las vestiduras están listas, $n. Golpea a los que dañarían nuestro mundo con tu fuego justo.', 0),
(@ID, 'esMX', 'Las vestiduras están listas, $n. Golpea a los que dañarían nuestro mundo con tu fuego justo.', 0);
-- 9115 Los botines de fe
-- https://es.classic.wowhead.com/quest=9115
SET @ID := 9115;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me has traído lo que necesito, $gniño:niña;?', 0),
(@ID, 'esMX', '¿Me has traído lo que necesito, $gniño:niña;?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Las vestiduras están listas, $n. Golpea con tu fuejo justo a los que dañarían nuestro mundo.', 0),
(@ID, 'esMX', 'Las vestiduras están listas, $n. Golpea con tu fuejo justo a los que dañarían nuestro mundo.', 0);
-- 9116 Los guantes de fe
-- https://es.classic.wowhead.com/quest=9116
SET @ID := 9116;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me has traído lo que necesito, $gniño:niña;?', 0),
(@ID, 'esMX', '¿Me has traído lo que necesito, $gniño:niña;?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Las vestiduras están listas, $n. Golpea con tu fuejo justo a los que dañarían nuestro mundo.', 0),
(@ID, 'esMX', 'Las vestiduras están listas, $n. Golpea con tu fuejo justo a los que dañarían nuestro mundo.', 0);
-- 9117 El cinturón de fe
-- https://es.classic.wowhead.com/quest=9117
SET @ID := 9117;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Cinturón de fe.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer un Cinturón de fe.', 0);
-- 9118 Las ataduras de fe
-- https://es.classic.wowhead.com/quest=9118
SET @ID := 9118;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0),
(@ID, 'esMX', 'Te faltan algunas piezas para la misión, ¡por favor ve y consíguelas todas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Ataduras de fe.', 0),
(@ID, 'esMX', '¡Excelente $n! obtuviste todo tal como te pedí y ahora puedo hacer unas Ataduras de fe.', 0);
-- 9120 La caída de Kel'Thuzad
-- https://es.classic.wowhead.com/quest=9120
SET @ID := 9120;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'En todos mis días de vida, nunca hubiera esperado ver esto...$B$B<El padre Montoy parece estar salivando.>$B$BOh, sí, serás $grecompensado, querido niño:recompensada, querida niña;. Serás $grecompensado:recompensada; enormemente. ¡Dámelo ahora!', 0),
(@ID, 'esMX', 'En todos mis días de vida, nunca hubiera esperado ver esto...$B$B<El padre Montoy parece estar salivando.>$B$BOh, sí, serás $grecompensado, querido niño:recompensada, querida niña;. Serás $grecompensado:recompensada; enormemente. ¡Dámelo ahora!', 0);
-- La ciudadela del terror: Naxxramas
-- 9121, 9122, 9123
-- https://es.classic.wowhead.com/quest=9121
DELETE FROM `quest_request_items_locale` WHERE `id` IN(9121, 9122, 9123) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9121, 'esES', 'Nadie ha entrado en Naxxramas y vivido para contarlo.', 0),
(9122, 'esES', 'Nadie ha entrado en Naxxramas y vivido para contarlo.', 0),
(9123, 'esES', 'Nadie ha entrado en Naxxramas y vivido para contarlo.', 0),
(9121, 'esMX', 'Nadie ha entrado en Naxxramas y vivido para contarlo.', 0),
(9122, 'esMX', 'Nadie ha entrado en Naxxramas y vivido para contarlo.', 0),
(9123, 'esMX', 'Nadie ha entrado en Naxxramas y vivido para contarlo.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(9121, 9122, 9123) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9121, 'esES', 'Sentirás un hormigueo; eso quiere decir que funciona. Después podrás cruzar el portal rúnico del Bosque de la Peste para entrar en Naxxramas.', 0),
(9122, 'esES', 'Sentirás un hormigueo; eso quiere decir que funciona. Después podrás cruzar el portal rúnico del Bosque de la Peste para entrar en Naxxramas.', 0),
(9123, 'esES', 'Sentirás un hormigueo; eso quiere decir que funciona. Después podrás cruzar el portal rúnico del Bosque de la Peste para entrar en Naxxramas.', 0),
(9121, 'esMX', 'Sentirás un hormigueo; eso quiere decir que funciona. Después podrás cruzar el portal rúnico del Bosque de la Peste para entrar en Naxxramas.', 0),
(9122, 'esMX', 'Sentirás un hormigueo; eso quiere decir que funciona. Después podrás cruzar el portal rúnico del Bosque de la Peste para entrar en Naxxramas.', 0),
(9123, 'esMX', 'Sentirás un hormigueo; eso quiere decir que funciona. Después podrás cruzar el portal rúnico del Bosque de la Peste para entrar en Naxxramas.', 0);
-- 9124 La armadura de acechacriptas no se hace sola...
-- https://es.classic.wowhead.com/quest=9124
SET @ID := 9124;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Cómo va la cacería?', 0),
(@ID, 'esMX', '¿Cómo va la cacería?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, eso estará bien, $n. Recuerda, siempre acepto más partes. Por cada paquete que me traigas, te recompensaré con una insignia.', 0),
(@ID, 'esMX', 'Ah, eso estará bien, $n. Recuerda, siempre acepto más partes. Por cada paquete que me traigas, te recompensaré con una insignia.', 0);
-- 9125 Trozos de maligno de cripta
-- https://es.classic.wowhead.com/quest=9125
SET @ID := 9125;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Hiciste un trabajo ejemplar en el primer paquete, $n. Si tienes más, los tomaré ahora. Por cada paquete que entregues, te recompensaré con otra insignia.', 0),
(@ID, 'esMX', 'Hiciste un trabajo ejemplar en el primer paquete, $n. Si tienes más, los tomaré ahora. Por cada paquete que entregues, te recompensaré con otra insignia.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente, $n! Definitivamente, estos serán de gran utilidad.', 0),
(@ID, 'esMX', '¡Excelente, $n! Definitivamente, estos serán de gran utilidad.', 0);
-- 9126 Excavaciones para la armadura Segahuesos
-- https://es.classic.wowhead.com/quest=9126
SET @ID := 9126;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Puedo indicarte dónde encontrar esqueletos, $c.', 0),
(@ID, 'esMX', 'Puedo indicarte dónde encontrar esqueletos, $c.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Trabajas rápido, $n. Rápido como un zorro... Oye, ¿te he hablado alguna vez del tiempo en que fui miembro de un cuarteto de peluquería?$B$BRecuérdame que te cuente esa historia uno de estos días.', 0),
(@ID, 'esMX', 'Trabajas rápido, $n. Rápido como un zorro... Oye, ¿te he hablado alguna vez del tiempo en que fui miembro de un cuarteto de peluquería?$B$BRecuérdame que te cuente esa historia uno de estos días.', 0);
-- 9127 Trozos de hueso
-- https://es.classic.wowhead.com/quest=9127
SET @ID := 9127;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Con este oficio, nunca tengo demasiados fragmentos de hueso, $n. Siempre que tengas fragmentos de más, tráemelos y te recompensaré con otra insignia.', 0),
(@ID, 'esMX', 'Con este oficio, nunca tengo demasiados fragmentos de hueso, $n. Siempre que tengas fragmentos de más, tráemelos y te recompensaré con otra insignia.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Dentro de poco haré realidad mi sueño de convertirme en miembro del cuerpo de baile de la discoteca de Gadgetzan! Sigue trabajando así, $n.', 0),
(@ID, 'esMX', '¡Dentro de poco haré realidad mi sueño de convertirme en miembro del cuerpo de baile de la discoteca de Gadgetzan! Sigue trabajando así, $n.', 0);
-- 9128 La ecuación elemental
-- https://es.classic.wowhead.com/quest=9128
SET @ID := 9128;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Solo puedo guiarte en la dirección correcta, $n.', 0),
(@ID, 'esMX', 'Solo puedo guiarte en la dirección correcta, $n.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Buen trabajo, $n! Como prometí, la insignia es tuya. Solo recuerda, hay más de donde vino eso...', 0),
(@ID, 'esMX', '¡Buen trabajo, $n! Como prometí, la insignia es tuya. Solo recuerda, hay más de donde vino eso...', 0);
-- 9129 Núcleo de elementos
-- https://es.classic.wowhead.com/quest=9129
SET @ID := 9129;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'A decir verdad, uso los núcleos para crear una armadura Fuego de Escarcha. Es la armadura que usan los magos que luchan en Naxxramas. Sin ti y otros como tú, definitivamente estaríamos perdiendo esta guerra.$B$BDicho esto, tráeme más núcleos y te concederé más insignias.', 0),
(@ID, 'esMX', 'A decir verdad, uso los núcleos para crear una armadura Fuego de Escarcha. Es la armadura que usan los magos que luchan en Naxxramas. Sin ti y otros como tú, definitivamente estaríamos perdiendo esta guerra.$B$BDicho esto, tráeme más núcleos y te concederé más insignias.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Nos prestas un gran servicio, $n. ¡Bien hecho!', 0),
(@ID, 'esMX', 'Nos prestas un gran servicio, $n. ¡Bien hecho!', 0);
-- 9131 Armar la acorator
-- https://es.classic.wowhead.com/quest=9131
SET @ID := 9131;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Korfax te gruñe.>$B$B¿Qué quieres? ¿Direcciones? Puedo proporcionarte eso...', 0),
(@ID, 'esMX', '<Korfax te gruñe.>$B$B¿Qué quieres? ¿Direcciones? Puedo proporcionarte eso...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Esto valdrá por ahora. Si obtienes más, ya sabes dónde encontrarme.', 0),
(@ID, 'esMX', 'Esto valdrá por ahora. Si obtienes más, ya sabes dónde encontrarme.', 0);
-- 9132 Fragmentos de hierro negro
-- https://es.classic.wowhead.com/quest=9132
SET @ID := 9132;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Por cada brazada de restos que me traigas, te daré una insignia. Cuantos más restos traigas, mejor. Y ahora, fuera de mi vista, ¡antes de que te parta en dos!', 0),
(@ID, 'esMX', 'Por cada brazada de restos que me traigas, te daré una insignia. Cuantos más restos traigas, mejor. Y ahora, fuera de mi vista, ¡antes de que te parta en dos!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Eso es todo lo que me has traído? Creo que no me escuchaste con atención. ¡Necesito MÁS!', 0),
(@ID, 'esMX', '¿Eso es todo lo que me has traído? Creo que no me escuchaste con atención. ¡Necesito MÁS!', 0);
-- 9137 Hojas salvajes
-- https://es.classic.wowhead.com/quest=9137
SET @ID := 9137;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Por cada manojo de hojas que me entregue, te pagaré con la insignia de El Alba o de la Cruzada, tu elijes.$B$BLas insignias se pueden entregar al intendente para obtener varias recompensas.', 0),
(@ID, 'esMX', 'Por cada manojo de hojas que me entregue, te pagaré con la insignia de El Alba o de la Cruzada, tu elijes.$B$BLas insignias se pueden entregar al intendente para obtener varias recompensas.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias, $n. Tu trabajo es vital para el éxito de nuestra campaña contra la Plaga.', 0),
(@ID, 'esMX', 'Gracias, $n. Tu trabajo es vital para el éxito de nuestra campaña contra la Plaga.', 0);
-- 9141 Me llaman "El Gallo"
-- https://es.classic.wowhead.com/quest=9141
SET @ID := 9141;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<El comandante Metz mordisquea su puro.>$B$B¿Qué quieres? Soy un hombre ocupado.', 0),
(@ID, 'esMX', '<El comandante Metz mordisquea su puro.>$B$B¿Qué quieres? Soy un hombre ocupado.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Está bien, la cosa funciona así: por cada muestra de valor que me traigas, yo te daré una libranza. Completas la orden de esa libranza y entregas el pedido al maestro de manada Mazadura. ¿Lo pillas? Bien. Ahora, largo de aquí.', 0),
(@ID, 'esMX', 'Está bien, la cosa funciona así: por cada muestra de valor que me traigas, yo te daré una libranza. Completas la orden de esa libranza y entregas el pedido al maestro de manada Mazadura. ¿Lo pillas? Bien. Ahora, largo de aquí.', 0);
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
