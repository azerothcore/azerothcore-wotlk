-- DB update 2021_05_06_02 -> 2021_05_06_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_06_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_06_02 2021_05_06_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619734944662755000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619734944662755000');

-- 8876 Cohetes pequeños
-- https://es.classic.wowhead.com/quest=8876
SET @ID := 8876;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, muy bien. Aquí están tus recetas, $n, y que Elune te bendiga.', 0),
(@ID, 'esMX', 'Ah, muy bien. Aquí están tus recetas, $n, y que Elune te bendiga.', 0);
-- 8877 Lanzador de fuegos artificiales
-- https://es.classic.wowhead.com/quest=8877
SET @ID := 8877;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Aquí tienes, $n. Aquí está el esquema para crear un lanzador de fuegos artificiales. Coloca los lanzadores donde desees celebrar y luego da la bienvenida a tus amigos para que se unan a la fiesta.', 0),
(@ID, 'esMX', 'Aquí tienes, $n. Aquí está el esquema para crear un lanzador de fuegos artificiales. Coloca los lanzadores donde desees celebrar y luego da la bienvenida a tus amigos para que se unan a la fiesta.', 0);
-- 8878 Patrones para las fiestas
-- https://es.classic.wowhead.com/quest=8878
SET @ID := 8878;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Aquí están los patrones, $n. Estoy seguro de que el producto de este conocimiento te resultará bastante hermoso.', 0),
(@ID, 'esMX', 'Aquí están los patrones, $n. Estoy seguro de que el producto de este conocimiento te resultará bastante hermoso.', 0);
-- 8879 Cohetes grandes
-- https://es.classic.wowhead.com/quest=8879
SET @ID := 8879;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, acepto estas monedas de linaje. Aquí están tus recetas, $n. ¡Puedes usarlas para difundir la gloria de Elune!', 0),
(@ID, 'esMX', 'Muy bien, acepto estas monedas de linaje. Aquí están tus recetas, $n. ¡Puedes usarlas para difundir la gloria de Elune!', 0);
-- 8880 Tracas de cohetes
-- https://es.classic.wowhead.com/quest=8880
SET @ID := 8880;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Aquí tienes, $n. Toma estas recetas y aprende sus secretos. Te deseo suerte y espero ver tus magníficas creaciones.', 0),
(@ID, 'esMX', 'Aquí tienes, $n. Toma estas recetas y aprende sus secretos. Te deseo suerte y espero ver tus magníficas creaciones.', 0);
-- 8881 Tracas de cohetes grandes
-- https://es.classic.wowhead.com/quest=8881
SET @ID := 8881;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Las tracas de cohetes grandes requieren vastos recursos y habilidad para crearlas, ¡pero su brillantez y belleza merecen ese esfuerzo! Tráeme monedas de linaje y te otorgaré el conocimiento de su elaboración.', 0),
(@ID, 'esMX', 'Las tracas de cohetes grandes requieren vastos recursos y habilidad para crearlas, ¡pero su brillantez y belleza merecen ese esfuerzo! Tráeme monedas de linaje y te otorgaré el conocimiento de su elaboración.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias, $n. Aquí está la receta para tracas de cohetes grandes. Que tus productos traigan alegría y suerte a todos los que los miran.', 0),
(@ID, 'esMX', 'Gracias, $n. Aquí está la receta para tracas de cohetes grandes. Que tus productos traigan alegría y suerte a todos los que los miran.', 0);
-- 8882 Lanzatracas
-- https://es.classic.wowhead.com/quest=8882
SET @ID := 8882;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los espectáculos de fuegos artificiales más espléndidos deben incluir tracas de cohetes, ¡y esas tracas deben dispararse desde lanzadores de tracas! Entonces, ¿no es lógico que aprendas los secretos para hacer lanzadores de tracas? Tráeme monedas de linaje y te daré este conocimiento.', 0),
(@ID, 'esMX', 'Los espectáculos de fuegos artificiales más espléndidos deben incluir tracas de cohetes, ¡y esas tracas deben dispararse desde lanzadores de tracas! Entonces, ¿no es lógico que aprendas los secretos para hacer lanzadores de tracas? Tráeme monedas de linaje y te daré este conocimiento.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Aquí está tu esquema. Estúdialo de cerca y aprende...$B$BBuena suerte, $n. ¡Que tus celebraciones compitan con las del Festival Lunar!', 0),
(@ID, 'esMX', 'Aquí está tu esquema. Estúdialo de cerca y aprende...$B$BBuena suerte, $n. ¡Que tus celebraciones compitan con las del Festival Lunar!', 0);
-- 8883 Valadar Cantoestelar
-- https://es.wowhead.com/quest=8883
SET @ID := 8883;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡$n, $gbienvenido:bienvenida; al Amparo de la Noche, sede de El Festival Lunar! Aunque nuestro poblado está alejado y remoto para las gentes de Azeroth, durante estos días de celebración abrimos nuestros brazos y corazones a todo el mundo.$B$BDisfruta de tu visita, $n, y vuelve a hablar conmigo o con mi hermana cuando estés $glisto:lista;.', 0),
(@ID, 'esMX', '¡$n, $gbienvenido:bienvenida; al Amparo de la Noche, sede de El Festival Lunar! Aunque nuestro poblado está alejado y remoto para las gentes de Azeroth, durante estos días de celebración abrimos nuestros brazos y corazones a todo el mundo.$B$BDisfruta de tu visita, $n, y vuelve a hablar conmigo o con mi hermana cuando estés $glisto:lista;.', 0);
-- 8884 Aquí, pescadito...
-- https://es.wowhead.com/quest=8884
SET @ID := 8884;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los forestales de El Retiro del Errante estamos reparando el daño infligido a nuestras hermosas tierras y haremos lo que sea necesario para conseguirlo.$B$B¿Traes las cabezas de múrloc que te pedí?', 0),
(@ID, 'esMX', 'Los forestales de El Retiro del Errante estamos reparando el daño infligido a nuestras hermosas tierras y haremos lo que sea necesario para conseguirlo.$B$B¿Traes las cabezas de múrloc que te pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Buen trabajo, $c. Por el olor diría que me traes lo que pedí, incluso más. Seguro que las aprovecharemos para hacer sopa o algo.$B$BPero, por desgracia, tus esfuerzos no parecen haber dado resultado: los múrlocs no se han retirado. ¡Hay que tomar medidas más extremas!', 0),
(@ID, 'esMX', 'Buen trabajo, $c. Por el olor diría que me traes lo que pedí, incluso más. Seguro que las aprovecharemos para hacer sopa o algo.$B$BPero, por desgracia, tus esfuerzos no parecen haber dado resultado: los múrlocs no se han retirado. ¡Hay que tomar medidas más extremas!', 0);
-- 8885 El anillo de Mmmrrrggglll
-- https://es.wowhead.com/quest=8885
SET @ID := 8885;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Eres el vehículo de mi venganza, $c. ¿Traes el anillo?', 0),
(@ID, 'esMX', 'Eres el vehículo de mi venganza, $c. ¿Traes el anillo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Al fin! Aunque los Malaescama no se han retirado como esperaba, me divertí mucho con su pánico cuando liquidaste a su jefe. Tienes mi gratitud y la de los sin\'dorei de Ciudad de Lunargenta.$B$BAcepta esto como muestra de agradecimiento por tus servicios.', 0),
(@ID, 'esMX', '¡Al fin! Aunque los Malaescama no se han retirado como esperaba, me divertí mucho con su pánico cuando liquidaste a su jefe. Tienes mi gratitud y la de los sin\'dorei de Ciudad de Lunargenta.$B$BAcepta esto como muestra de agradecimiento por tus servicios.', 0);
-- 8886 ¡Piratas Malaescama!
-- https://es.wowhead.com/quest=8886
SET @ID := 8886;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Agradezco la ayuda de alguien como tú, $n. Casi me hace sonreír, pero entonces me acuerdo de lo que esos monstruos le han hecho a mi nave y de lo que está pasando en Quel\'Thalas.$B$B¿Conseguiste recuperar parte de mi carga?', 0),
(@ID, 'esMX', 'Agradezco la ayuda de alguien como tú, $n. Casi me hace sonreír, pero entonces me acuerdo de lo que esos monstruos le han hecho a mi nave y de lo que está pasando en Quel\'Thalas.$B$B¿Conseguiste recuperar parte de mi carga?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Fantástico! ¡Me has salvado de la ruina y me has vengado de esas asquerosas criaturas!$B$BAhora a ver si consigo que esas forestales tan guapas me ayuden con la carga y podré marcharme por fin. Tendré que volver cuando Velendris retome el astillero.$B$BTen esta moneda. No puedo permitirme más, pero lo menos que puedo hacer es pagarte por tu ayuda.', 0),
(@ID, 'esMX', '¡Fantástico! ¡Me has salvado de la ruina y me has vengado de esas asquerosas criaturas!$B$BAhora a ver si consigo que esas forestales tan guapas me ayuden con la carga y podré marcharme por fin. Tendré que volver cuando Velendris retome el astillero.$B$BTen esta moneda. No puedo permitirme más, pero lo menos que puedo hacer es pagarte por tu ayuda.', 0);
-- 8887 Rutas perdidas de la capitana Kelisendra
-- https://es.wowhead.com/quest=8887
SET @ID := 8887;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Hola, $c, me alegro de verte. Sé que es absurdo que esté aquí cuando El Puerto ha sido invadido por los desdichados. Velendris y sus forestales han jurado protegerme a condición de que me vaya en cuanto haya recuperado mi carga.$B$B¿Qué traes? Eso me suena.', 0),
(@ID, 'esMX', 'Hola, $c, me alegro de verte. Sé que es absurdo que esté aquí cuando El Puerto ha sido invadido por los desdichados. Velendris y sus forestales han jurado protegerme a condición de que me vaya en cuanto haya recuperado mi carga.$B$B¿Qué traes? Eso me suena.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Estupendo, $c! ¡No sabía que los múrlocs Malaescama se habían llevado también mis planes de navegación! Sin ellos no habría podido salir a la mar aun después de haber retomado El Puerto y reparado la nave.$B$B¡Muchas gracias! Acepta esta moneda en muestra de gratitud.', 0),
(@ID, 'esMX', '¡Estupendo, $c! ¡No sabía que los múrlocs Malaescama se habían llevado también mis planes de navegación! Sin ellos no habría podido salir a la mar aun después de haber retomado El Puerto y reparado la nave.$B$B¡Muchas gracias! Acepta esta moneda en muestra de gratitud.', 0);
-- 8898 Queridísima Colara:
-- https://es.classic.wowhead.com/quest=8898
SET @ID := 8898;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Hola, $gguapo:guapa;, ¿querías algo?', 0),
(@ID, 'esMX', 'Hola, $gguapo:guapa;, ¿querías algo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tormek? Ah, sí, el barbudito simpático.$B$B¡Qué bien que se acuerde de mí!', 0),
(@ID, 'esMX', '¿Tormek? Ah, sí, el barbudito simpático.$B$B¡Qué bien que se acuerde de mí!', 0);
-- 8899 Queridísima Colara:
-- https://es.classic.wowhead.com/quest=8899
SET @ID := 8899;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Hola $gguapo:guapa;. ¿Te puedo ayudar en algo?', 0),
(@ID, 'esMX', 'Hola $gguapo:guapa;. ¿Te puedo ayudar en algo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Nunca antes había recibido algo como esto. ¡Que adorable!', 0),
(@ID, 'esMX', 'Nunca antes había recibido algo como esto. ¡Que adorable!', 0);
-- 8900 Queridísima Elenia:
-- https://es.classic.wowhead.com/quest=8900
SET @ID := 8900;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, ¿y a qué debo este placer?', 0),
(@ID, 'esMX', 'Ah, ¿y a qué debo este placer?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No esperaba que un orco fuera tan elocuente. Por supuesto, nunca antes había tenido la oportunidad de conocerlos. Gracias por traerme esto.', 0),
(@ID, 'esMX', 'No esperaba que un orco fuera tan elocuente. Por supuesto, nunca antes había tenido la oportunidad de conocerlos. Gracias por traerme esto.', 0);
-- 8901 Queridísima Elenia:
-- https://es.classic.wowhead.com/quest=8901
SET @ID := 8901;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, ¿y a qué debo este placer?', 0),
(@ID, 'esMX', 'Ah, ¿y a qué debo este placer?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Qué amables palabras escribe Temma para mí. Pero, por mucho que me conmuevan sus palabras, no puedo considerar el amor de un tauren. En pensamientos, cuerpo y mente somos demasiado diferentes.$B$BEs bueno que no tenga que recibir estos pensamientos suyos en persona. No pude soportar romperle el corazón.', 0),
(@ID, 'esMX', 'Qué amables palabras escribe Temma para mí. Pero, por mucho que me conmuevan sus palabras, no puedo considerar el amor de un tauren. En pensamientos, cuerpo y mente somos demasiado diferentes.$B$BEs bueno que no tenga que recibir estos pensamientos suyos en persona. No pude soportar romperle el corazón.', 0);
-- 8902 Queridísima Elenia:
-- https://es.classic.wowhead.com/quest=8902
SET @ID := 8902;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, ¿y a qué debo este placer?', 0),
(@ID, 'esMX', 'Ah, ¿y a qué debo este placer?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Esto trae recuerdos de hace una vida, $n. Elenia Tor. Ese iba a ser mi nombre, sabes. Tendríamos una hermosa ceremonia a orillas del lago. Cuando se jubilara, encontraríamos una granja donde retirarnos.$B$BSueños simples, entonces.$B$BPero si me viera ahora, dudo que incluso vea a Elenia en mí. Solo carne fría y un corazón muerto...', 0),
(@ID, 'esMX', 'Esto trae recuerdos de hace una vida, $n. Elenia Tor. Ese iba a ser mi nombre, sabes. Tendríamos una hermosa ceremonia a orillas del lago. Cuando se jubilara, encontraríamos una granja donde retirarnos.$B$BSueños simples, entonces.$B$BPero si me viera ahora, dudo que incluso vea a Elenia en mí. Solo carne fría y un corazón muerto...', 0);
-- 8903 Amor peligroso
-- https://es.classic.wowhead.com/quest=8903
SET @ID := 8903;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Dime, ¿los guardias también están afectados por esta locura de amor?', 0),
(@ID, 'esMX', 'Dime, ¿los guardias también están afectados por esta locura de amor?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De modo que estaba en lo cierto. ¡Esto es terrible! ¿Cómo ha podido pasar? Déjame pensar... Tiene que haber alguna razón.', 0),
(@ID, 'esMX', 'De modo que estaba en lo cierto. ¡Esto es terrible! ¿Cómo ha podido pasar? Déjame pensar... Tiene que haber alguna razón.', 0);
-- 8904 Amor peligroso
-- https://es.classic.wowhead.com/quest=8904
SET @ID := 8904;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tenía razón en preocuparme? ¿Han vencido a nuestros guardias idiotas?', 0),
(@ID, 'esMX', '¿Tenía razón en preocuparme? ¿Han vencido a nuestros guardias idiotas?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De modo que estaba en lo cierto. ¡Esto es terrible! ¿Cómo ha podido pasar? Déjame pensar... Tiene que haber alguna razón.', 0),
(@ID, 'esMX', 'De modo que estaba en lo cierto. ¡Esto es terrible! ¿Cómo ha podido pasar? Déjame pensar... Tiene que haber alguna razón.', 0);
-- Una propuesta seria
-- 8905, 8906, 8907, 8908, 8909, 8910, 8911, 8912, 10492
-- https://es.classic.wowhead.com/quest=8905
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8905, 8906, 8907, 8908, 8909, 8910, 8911, 8912, 10492) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8905, 'esES', '¿Me has traído lo que te pedí, $n?', 0),
(8906, 'esES', '¿Me has traído lo que te pedí, $n?', 0),
(8907, 'esES', '¿Me has traído lo que te pedí, $n?', 0),
(8908, 'esES', '¿Me has traído lo que te pedí, $n?', 0),
(8909, 'esES', '¿Me has traído lo que te pedí, $n?', 0),
(8910, 'esES', '¿Me has traído lo que te pedí, $n?', 0),
(8911, 'esES', '¿Me has traído lo que te pedí, $n?', 0),
(8912, 'esES', '¿Me has traído lo que te pedí, $n?', 0),
(10492, 'esES', '¿Me has traído lo que te pedí, $n?', 0),
(8905, 'esMX', '¿Me has traído lo que te pedí, $n?', 0),
(8906, 'esMX', '¿Me has traído lo que te pedí, $n?', 0),
(8907, 'esMX', '¿Me has traído lo que te pedí, $n?', 0),
(8908, 'esMX', '¿Me has traído lo que te pedí, $n?', 0),
(8909, 'esMX', '¿Me has traído lo que te pedí, $n?', 0),
(8910, 'esMX', '¿Me has traído lo que te pedí, $n?', 0),
(8911, 'esMX', '¿Me has traído lo que te pedí, $n?', 0),
(8912, 'esMX', '¿Me has traído lo que te pedí, $n?', 0),
(10492, 'esMX', '¿Me has traído lo que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8905, 8906, 8907, 8908, 8909, 8910, 8911, 8912, 10492) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8905, 'esES', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8906, 'esES', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8907, 'esES', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8908, 'esES', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8909, 'esES', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8910, 'esES', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8911, 'esES', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8912, 'esES', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(10492, 'esES', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8905, 'esMX', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8906, 'esMX', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8907, 'esMX', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8908, 'esMX', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8909, 'esMX', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8910, 'esMX', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8911, 'esMX', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(8912, 'esMX', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0),
(10492, 'esMX', '¡Excelente! Entonces realicemos el intercambio. Es difícil desprenderse de esta excelente armadura, pero me temo que no la necesitaré en un tiempo.$B$BSi estás $ginteresado:interesada; en realizar más trabajos para mí, podría estar dispuesta a renunciar al resto de las piezas.', 0);
-- Una propuesta seria
-- 8913, 8914, 8915, 8916, 8917, 8918, 8919, 8920, 10493
-- https://es.classic.wowhead.com/quest=8913
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8913, 8914, 8915, 8916, 8917, 8918, 8919, 8920, 10493) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8913, 'esES', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8914, 'esES', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8915, 'esES', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8916, 'esES', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8917, 'esES', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8918, 'esES', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8919, 'esES', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8920, 'esES', '¿Ha obtenido los artículos que necesito, $n?', 0),
(10493, 'esES', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8913, 'esMX', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8914, 'esMX', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8915, 'esMX', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8916, 'esMX', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8917, 'esMX', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8918, 'esMX', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8919, 'esMX', '¿Ha obtenido los artículos que necesito, $n?', 0),
(8920, 'esMX', '¿Ha obtenido los artículos que necesito, $n?', 0),
(10493, 'esMX', '¿Ha obtenido los artículos que necesito, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8913, 8914, 8915, 8916, 8917, 8918, 8919, 8920, 10493) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8913, 'esES', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8914, 'esES', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8915, 'esES', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8916, 'esES', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8917, 'esES', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8918, 'esES', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8919, 'esES', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8920, 'esES', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(10493, 'esES', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8913, 'esMX', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8914, 'esMX', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8915, 'esMX', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8916, 'esMX', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8917, 'esMX', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8918, 'esMX', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8919, 'esMX', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(8920, 'esMX', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0),
(10493, 'esMX', 'Ah, sí. Mux estará bastante contento con esto.$B$BEsos brazales eran parte de mi mejor conjunto de armadura. Si estás $ginteresado:interesada; en brindarme más ayuda, estaría dispuesto a considerar separarme del resto.', 0);
-- 8921 El destilador ectoplásmico
-- https://es.classic.wowhead.com/quest=8921
SET @ID := 8921;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Entiendo que los materiales son un poco caros... ¡pero te prometo que cada uno de ellos es necesario!', 0),
(@ID, 'esMX', 'Entiendo que los materiales son un poco caros... ¡pero te prometo que cada uno de ellos es necesario!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estos son precisamente los materiales que necesitaba. ¡Muy oportuno también, $n!$B$B¡En unos momentos tendré tu destilador listo para funcionar! Mientras tanto, toma esto como una recompensa por ayudarme en mi proyecto.', 0),
(@ID, 'esMX', 'Estos son precisamente los materiales que necesitaba. ¡Muy oportuno también, $n!$B$B¡En unos momentos tendré tu destilador listo para funcionar! Mientras tanto, toma esto como una recompensa por ayudarme en mi proyecto.', 0);
-- 8922 Un artefacto sobrenatural
-- https://es.classic.wowhead.com/quest=8922
SET @ID := 8922;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo para mi?', 0),
(@ID, 'esMX', '¿Tienes algo para mi?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! ¡Justo cuando estaba acabando!$B$B¿Dices que te envió Deliana?', 0),
(@ID, 'esMX', '¡Excelente! ¡Justo cuando estaba acabando!$B$B¿Dices que te envió Deliana?', 0);
-- 8923 Un artefacto sobrenatural
-- https://es.wowhead.com/quest=8923
SET @ID := 8923;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Quieres hablar conmigo?', 0),
(@ID, 'esMX', '¿Quieres hablar conmigo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! ¡Justo cuando estaba acabando!$B$B¿Dices que te envió Mokvar?', 0),
(@ID, 'esMX', '¡Excelente! ¡Justo cuando estaba acabando!$B$B¿Dices que te envió Mokvar?', 0);
-- 8924 Caza de ectoplasmas
-- https://es.classic.wowhead.com/quest=8924
SET @ID := 8924;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Ya reuniste el ectoplasma, $r?', 0),
(@ID, 'esMX', '¿Ya reuniste el ectoplasma, $r?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, ¡estos lo harán genial!$B$B¡Al aprovechar las energías de otro mundo contenidas en estas sustancias, podremos llegar a aquellos cuyas almas aún no han abandonado este mundo!', 0),
(@ID, 'esMX', 'Sí, ¡estos lo harán genial!$B$B¡Al aprovechar las energías de otro mundo contenidas en estas sustancias, podremos llegar a aquellos cuyas almas aún no han abandonado este mundo!', 0);
-- 8925 Fuente de energía portátil
-- https://es.classic.wowhead.com/quest=8925
SET @ID := 8925;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has encontrado al Señor del Magma, $n?', 0),
(@ID, 'esMX', '¿Has encontrado al Señor del Magma, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo has hecho! ¡Esto sin duda proporcionará suficiente energía para encender al revelador fantasma extradimensional!', 0),
(@ID, 'esMX', '¡Lo has hecho! ¡Esto sin duda proporcionará suficiente energía para encender al revelador fantasma extradimensional!', 0);
-- Una compensación justa
-- 8926, 8931, 8932, 8933, 8934, 8935, 8936, 8937, 10494
-- https://es.classic.wowhead.com/quest=8926
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8926, 8931, 8932, 8933, 8934, 8935, 8936, 8937, 10494) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8926, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8931, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8932, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8933, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8934, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8935, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8936, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8937, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(10494, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8926, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8931, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8932, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8933, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8934, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8935, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8936, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8937, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(10494, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8926, 8931, 8932, 8933, 8934, 8935, 8936, 8937, 10494) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8926, 'esES', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8931, 'esES', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8932, 'esES', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8933, 'esES', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8934, 'esES', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8935, 'esES', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8936, 'esES', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8937, 'esES', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(10494, 'esES', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8926, 'esMX', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8931, 'esMX', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8932, 'esMX', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8933, 'esMX', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8934, 'esMX', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8935, 'esMX', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8936, 'esMX', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(8937, 'esMX', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0),
(10494, 'esMX', 'Has cumplido tu parte del trato, yo cumpliré la mía.$B$BSolo recuerda que me aferro a las mejores piezas hasta que termines tu trabajo.', 0);

-- Una compensación justa
-- 8927, 8938, 8939, 8940, 8941, 8942, 8943, 8944, 10495
-- https://es.wowhead.com/quest=8927
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8927, 8938, 8939, 8940, 8941, 8942, 8943, 8944, 10495) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8927, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8938, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8939, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8940, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8941, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8942, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8943, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8944, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(10495, 'esES', '¿Estás $glisto:lista; para comerciar?', 0),
(8927, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8938, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8939, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8940, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8941, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8942, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8943, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(8944, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0),
(10495, 'esMX', '¿Estás $glisto:lista; para comerciar?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8927, 8938, 8939, 8940, 8941, 8942, 8943, 8944, 10495) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8927, 'esES', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8938, 'esES', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8939, 'esES', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8940, 'esES', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8941, 'esES', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8942, 'esES', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8943, 'esES', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8944, 'esES', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(10495, 'esES', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8927, 'esMX', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8938, 'esMX', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8939, 'esMX', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8940, 'esMX', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8941, 'esMX', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8942, 'esMX', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8943, 'esMX', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(8944, 'esMX', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0),
(10495, 'esMX', 'Nuestro acuerdo sigue vigente. Solo recuerda, esto es solo una muestra de lo que te espera. Líbrame de este destino maldito y te recompensaré con objetos de un poder verdaderamente grandioso.', 0);
-- 8928 Un mercader sospechoso
-- https://es.classic.wowhead.com/quest=8928
SET @ID := 8928;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has tenido suerte encontrando al diablillo en Garganta Negro Rumor?', 0),
(@ID, 'esMX', '¿Has tenido suerte encontrando al diablillo en Garganta Negro Rumor?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo hiciste! Esta vara funcionará perfectamente. Ahora a ponerlo todo junto...', 0),
(@ID, 'esMX', '¡Lo hiciste! Esta vara funcionará perfectamente. Ahora a ponerlo todo junto...', 0);
-- 8929 Buscando a Anthion
-- https://es.classic.wowhead.com/quest=8929
SET @ID := 8929;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Deliana te ha puesto en contacto conmigo? Haré todo lo posible para ayudarte, pero primero debo pedirte un gran favor.', 0),
(@ID, 'esMX', '¿Deliana te ha puesto en contacto conmigo? Haré todo lo posible para ayudarte, pero primero debo pedirte un gran favor.', 0);
-- 8930 Buscando a Anthion
-- https://es.classic.wowhead.com/quest=8930
SET @ID := 8930;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Mokvar te ha puesto en contacto conmigo? Haré todo lo posible para ayudarte, pero primero debo pedirte un gran favor.', 0),
(@ID, 'esMX', '¿Mokvar te ha puesto en contacto conmigo? Haré todo lo posible para ayudarte, pero primero debo pedirte un gran favor.', 0);
-- 8945 La súplica de un muerto
-- https://es.classic.wowhead.com/quest=8945
SET @ID := 8945;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Ysida liberada', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Dime, ¿está viva Ysida?', 0),
(@ID, 'esMX', 'Dime, ¿está viva Ysida?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias por rescatarme... temía por mi vida. Acepta esto como una pequeña muestra de mi gratitud.$B$BAnthion está... no... no puede ser...', 0),
(@ID, 'esMX', 'Gracias por rescatarme... temía por mi vida. Acepta esto como una pequeña muestra de mi gratitud.$B$BAnthion está... no... no puede ser...', 0);
-- 8946 Prueba de vida
-- https://es.classic.wowhead.com/quest=8946
SET @ID := 8946;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ysida... ¿está viva?', 0),
(@ID, 'esMX', 'Ysida... ¿está viva?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ese guardapelo... ¡la encontraste! Puedo descansar en paz por fin.$B$BAhora responderé cualquier pregunta que puedas tener, $n. Pero date prisa, mi tiempo en este mundo se termina.', 0),
(@ID, 'esMX', 'Ese guardapelo... ¡la encontraste! Puedo descansar en paz por fin.$B$BAhora responderé cualquier pregunta que puedas tener, $n. Pero date prisa, mi tiempo en este mundo se termina.', 0);
-- 8947 La extraña petición de Anthion
-- https://es.classic.wowhead.com/quest=8947
SET @ID := 8947;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Obtuviste los materiales que te pedí, $n?', 0),
(@ID, 'esMX', '¿Obtuviste los materiales que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente. Los transmutaré en algo más adecuado a nuestras necesidades.', 0),
(@ID, 'esMX', 'Excelente. Los transmutaré en algo más adecuado a nuestras necesidades.', 0);
-- 8948 Un viejo amigo de Anthion
-- https://es.classic.wowhead.com/quest=8948
SET @ID := 8948;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Habla $gextraño:extraña;, ¿no ves que estoy ocupado?', 0),
(@ID, 'esMX', 'Habla $gextraño:extraña;, ¿no ves que estoy ocupado?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Dices que Anthion te envió? Pensé que estaba muerto. Supongo que he escuchado cosas más extrañas en mi vida.$B$BMuy bien entonces. ¿Qué quieres que haga con este estandarte?', 0),
(@ID, 'esMX', '¿Dices que Anthion te envió? Pensé que estaba muerto. Supongo que he escuchado cosas más extrañas en mi vida.$B$BMuy bien entonces. ¿Qué quieres que haga con este estandarte?', 0);
-- 8949 La vendetta de Falrin
-- https://es.classic.wowhead.com/quest=8949
SET @ID := 8949;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has hecho el favor que te pedí, $n?', 0),
(@ID, 'esMX', '¿Has hecho el favor que te pedí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Hmmm... por extraño que parezca, no me siento mejor por la muerte de mi hermano a manos de esos brutos.$B$BBueno, cumpliste tu parte del trato. Veamos qué puedo hacer por ti.', 0),
(@ID, 'esMX', 'Hmmm... por extraño que parezca, no me siento mejor por la muerte de mi hermano a manos de esos brutos.$B$BBueno, cumpliste tu parte del trato. Veamos qué puedo hacer por ti.', 0);
-- 8950 El encantamiento del provocador
-- https://es.classic.wowhead.com/quest=8950
SET @ID := 8950;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Ha reunido los materiales que necesito, $n?', 0),
(@ID, 'esMX', '¿Ha reunido los materiales que necesito, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, estos funcionarán bien. Cuando termine, ninguna fuerza en el mundo podrá impedir que tu víctima acepte tu desafío.', 0),
(@ID, 'esMX', 'Sí, estos funcionarán bien. Cuando termine, ninguna fuerza en el mundo podrá impedir que tu víctima acepte tu desafío.', 0);
-- La despedida de Anthion
-- 8951, 8952, 8953, 8954, 8955, 8956, 8958, 8959, 10496
-- https://es.wowhead.com/quest=8951
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8951, 8952, 8953, 8954, 8955, 8956, 8958, 8959, 10496) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8951, 'esES', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8952, 'esES', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8953, 'esES', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8954, 'esES', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8955, 'esES', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8956, 'esES', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8958, 'esES', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8959, 'esES', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(10496, 'esES', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8951, 'esMX', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8952, 'esMX', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8953, 'esMX', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8954, 'esMX', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8955, 'esMX', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8956, 'esMX', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8958, 'esMX', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(8959, 'esMX', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0),
(10496, 'esMX', 'Has vuelto, $n. Debes contarme todo lo que has descubierto. Pero primero permítenos arreglar tu recompensa.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8951, 8952, 8953, 8954, 8955, 8956, 8958, 8959, 10496) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8951, 'esES', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8952, 'esES', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8953, 'esES', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8954, 'esES', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8955, 'esES', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8956, 'esES', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8958, 'esES', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8959, 'esES', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(10496, 'esES', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8951, 'esMX', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8952, 'esMX', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8953, 'esMX', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8954, 'esMX', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8955, 'esMX', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8956, 'esMX', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8958, 'esMX', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(8959, 'esMX', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0),
(10496, 'esMX', '¡No puedo creer que nuestras vidas estén casi perdidas por culpa de un estúpido medallón! ¿Y estás $gseguro:segura; de que Anthion mencionó a Bodley?$B$BBueno, has hecho tu trabajo, así que saquemos tu recompensa.', 0);
-- La despedida de Anthion
-- 8957, 9016, 9017, 9018, 9019, 9020, 9021, 9022, 10497
-- https://es.wowhead.com/quest=8957
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8957, 9016, 9017, 9018, 9019, 9020, 9021, 9022, 10497) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8957, 'esES', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9016, 'esES', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9017, 'esES', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9018, 'esES', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9019, 'esES', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9020, 'esES', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9021, 'esES', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9022, 'esES', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(10497, 'esES', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(8957, 'esMX', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9016, 'esMX', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9017, 'esMX', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9018, 'esMX', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9019, 'esMX', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9020, 'esMX', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9021, 'esMX', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(9022, 'esMX', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0),
(10497, 'esMX', 'Has vuelto y veo en tus ojos que tienes mucho que contarme, $n. Primero, permítenos ocuparnos de tu recompensa.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8957, 9016, 9017, 9018, 9019, 9020, 9021, 9022, 10497) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8957, 'esES', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9016, 'esES', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9017, 'esES', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9018, 'esES', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9019, 'esES', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9020, 'esES', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9021, 'esES', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9022, 'esES', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(10497, 'esES', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(8957, 'esMX', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9016, 'esMX', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9017, 'esMX', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9018, 'esMX', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9019, 'esMX', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9020, 'esMX', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9021, 'esMX', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(9022, 'esMX', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0),
(10497, 'esMX', 'Esta maldición nos fue otorgada por un simple medallón. Lord Valthalak ciertamente sabe cómo guardar rencor.$B$BNos esforzaremos por encontrar las piezas restantes, con suerte antes de que me encuentre con una muerte prematura. Pero antes de eso, veamos cuál es tu recompensa.', 0);
-- El triste destino de Bodley
-- 8960, 9032
-- https://es.wowhead.com/quest=8960
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8960, 9032) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8960, 'esES', 'Estoy tan contento de que puedas verme. ¡Finalmente alguien con quien hablar!$B$B¿Nos ayudarás, $n? ¿Ayudarás a reparar el mal que perpetramos y arreglarás las cosas? Si es cierto que ya tienes la Pieza Superior del Amuleto de Lord Valthalak, entonces creo que puedo ponerte en la dirección correcta para conseguir las otras dos partes, reunirlas y acabar con todo esto.$B$BAh, por cierto, hola, mi nombre es Bodley. ¡Un placer conocerte!', 0),
(9032, 'esES', 'Estoy tan contento de que puedas verme. ¡Finalmente alguien con quien hablar!$B$B¿Nos ayudarás, $n? ¿Ayudarás a reparar el mal que perpetramos y arreglarás las cosas? Si es cierto que ya tienes la Pieza Superior del Amuleto de Lord Valthalak, entonces creo que puedo ponerte en la dirección correcta para conseguir las otras dos partes, reunirlas y acabar con todo esto.$B$BAh, por cierto, hola, mi nombre es Bodley. ¡Un placer conocerte!', 0),
(8960, 'esMX', 'Estoy tan contento de que puedas verme. ¡Finalmente alguien con quien hablar!$B$B¿Nos ayudarás, $n? ¿Ayudarás a reparar el mal que perpetramos y arreglarás las cosas? Si es cierto que ya tienes la Pieza Superior del Amuleto de Lord Valthalak, entonces creo que puedo ponerte en la dirección correcta para conseguir las otras dos partes, reunirlas y acabar con todo esto.$B$BAh, por cierto, hola, mi nombre es Bodley. ¡Un placer conocerte!', 0),
(9032, 'esMX', 'Estoy tan contento de que puedas verme. ¡Finalmente alguien con quien hablar!$B$B¿Nos ayudarás, $n? ¿Ayudarás a reparar el mal que perpetramos y arreglarás las cosas? Si es cierto que ya tienes la Pieza Superior del Amuleto de Lord Valthalak, entonces creo que puedo ponerte en la dirección correcta para conseguir las otras dos partes, reunirlas y acabar con todo esto.$B$BAh, por cierto, hola, mi nombre es Bodley. ¡Un placer conocerte!', 0);
-- 8961 Tres reyes de Fuego
-- https://es.wowhead.com/quest=8961
SET @ID := 8961;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Fue nuestra locura... nuestra perdición que aceptáramos ese último trabajo. Si tan solo no hubiéramos robado inadvertidamente el espíritu de Lord Valthalak, que estaba contenido en el amuleto; si tan solo no hubieramos dividido el amuleto como codiciosos mercenarios. Hoy estaría vivo, tal vez bebiendo una cerveza o lanzando a uno de mis hijos al aire.$B$B$n, no permitas que la avaricia de los innobles de nuestra antigua compañía de mercenarios también sea tu perdición.', 0),
(@ID, 'esMX', 'Fue nuestra locura... nuestra perdición que aceptáramos ese último trabajo. Si tan solo no hubiéramos robado inadvertidamente el espíritu de Lord Valthalak, que estaba contenido en el amuleto; si tan solo no hubieramos dividido el amuleto como codiciosos mercenarios. Hoy estaría vivo, tal vez bebiendo una cerveza o lanzando a uno de mis hijos al aire.$B$B$n, no permitas que la avaricia de los innobles de nuestra antigua compañía de mercenarios también sea tu perdición.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estoy impresionado, $n, pero no hay tiempo que perder. Te daré tu próxima tarea, porque todavía necesitarás adquirir algunos componentes importantes antes de que podamos continuar.$B$BHáblame de nuevo cuando sientas que estás $glisto:lista; para el desafío que te espera.', 0),
(@ID, 'esMX', 'Estoy impresionado, $n, pero no hay tiempo que perder. Te daré tu próxima tarea, porque todavía necesitarás adquirir algunos componentes importantes antes de que podamos continuar.$B$BHáblame de nuevo cuando sientas que estás $glisto:lista; para el desafío que te espera.', 0);
-- 8962 Componentes importantes
-- https://es.classic.wowhead.com/quest=8962
SET @ID := 8962;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c, ¿Has regresado ya con lo que te envié a recoger?', 0),
(@ID, 'esMX', '$c, ¿Has regresado ya con lo que te envié a recoger?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo bien hecho, $n. Imbuiré la esencia de los restos en el blandón.$B$BAhora todo lo que queda es ir a la parte inferior de la Cumbre Roca Negra, a la cámara donde reside el Maestro de Guerra Voone en Tazz\'Alaor, y usar el blandón para convocar al espíritu corrupto de mi antiguo cohorte, Mor Grayhoof. No puede descansar hasta que le quiten la pieza del amuleto.', 0),
(@ID, 'esMX', 'Un trabajo bien hecho, $n. Imbuiré la esencia de los restos en el blandón.$B$BAhora todo lo que queda es ir a la parte inferior de la Cumbre Roca Negra, a la cámara donde reside el Maestro de Guerra Voone en Tazz\'Alaor, y usar el blandón para convocar al espíritu corrupto de mi antiguo cohorte, Mor Grayhoof. No puede descansar hasta que le quiten la pieza del amuleto.', 0);
-- 8963 Componentes importantes
-- https://es.classic.wowhead.com/quest=8963
SET @ID := 8963;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c, ¿Has regresado ya con lo que te envié a recoger?', 0),
(@ID, 'esMX', '$c, ¿Has regresado ya con lo que te envié a recoger?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo bien hecho, $n. Imbuiré la esencia de la reliquia en el blandón.$B$BAhora todo lo que queda es ir al Santuario de Eldretharr en el ala este de Dire Maul, y usar el blandón para convocar el espíritu de mi antigua cohorte, Isalien. Su espíritu ha sido corrompido por la posesión de la pieza del amuleto de Valthalak y la porción de su alma dentro del mismo.', 0),
(@ID, 'esMX', 'Un trabajo bien hecho, $n. Imbuiré la esencia de la reliquia en el blandón.$B$BAhora todo lo que queda es ir al Santuario de Eldretharr en el ala este de Dire Maul, y usar el blandón para convocar el espíritu de mi antigua cohorte, Isalien. Su espíritu ha sido corrompido por la posesión de la pieza del amuleto de Valthalak y la porción de su alma dentro del mismo.', 0);
-- 8964 Componentes importantes
-- https://es.classic.wowhead.com/quest=8964
SET @ID := 8964;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c, ¿Has regresado ya con lo que te envié a recoger?', 0),
(@ID, 'esMX', '$c, ¿Has regresado ya con lo que te envié a recoger?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo bien hecho, $n. Imbuiré la esencia de la espada en el blandón.$B$BAhora todo lo que queda es entrar en El Trono Carmesí dentro del Bastión Escarlata en Stratholme, y usar el blandón para convocar los restos de mis antiguos cohortes, Jarien y Sothos. Sus almas se han torcido aún más por la posesión de la pieza de amuleto de Valthalak y su espíritu dentro.', 0),
(@ID, 'esMX', 'Un trabajo bien hecho, $n. Imbuiré la esencia de la espada en el blandón.$B$BAhora todo lo que queda es entrar en El Trono Carmesí dentro del Bastión Escarlata en Stratholme, y usar el blandón para convocar los restos de mis antiguos cohortes, Jarien y Sothos. Sus almas se han torcido aún más por la posesión de la pieza de amuleto de Valthalak y su espíritu dentro.', 0);
-- 8965 Componentes importantes
-- https://es.classic.wowhead.com/quest=8965
SET @ID := 8965;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c, ¿Has regresado ya con lo que te envié a recoger?', 0),
(@ID, 'esMX', '$c, ¿Has regresado ya con lo que te envié a recoger?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un trabajo bien hecho, $n. Imbuiré la esencia de las cenizas en el blandón.$B$BAhora todo lo que queda es entrar en Scholomance, en la cámara de Ras Susurro Gélido, y usar el blandón para invocar el espíritu de mi antiguo cohorte, Kormok. La pieza del amuleto y el espíritu de Valthalak en su interior lo han corrompido aún más, y no descansará hasta que se lo quites por la fuerza.', 0),
(@ID, 'esMX', 'Un trabajo bien hecho, $n. Imbuiré la esencia de las cenizas en el blandón.$B$BAhora todo lo que queda es entrar en Scholomance, en la cámara de Ras Susurro Gélido, y usar el blandón para invocar el espíritu de mi antiguo cohorte, Kormok. La pieza del amuleto y el espíritu de Valthalak en su interior lo han corrompido aún más, y no descansará hasta que se lo quites por la fuerza.', 0);
-- 8966 La parte izquierda del amuleto de Lord Valthalak
-- https://es.classic.wowhead.com/quest=8966
SET @ID := 8966;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Entonces está hecho? ¿Has recuperado la pieza izquierda del amuleto de Lord Valthalak y finalmente has dejado descansar el espíritu de mi antiguo compañero, Mor Pezuña Gris?', 0),
(@ID, 'esMX', '¿Entonces está hecho? ¿Has recuperado la pieza izquierda del amuleto de Lord Valthalak y finalmente has dejado descansar el espíritu de mi antiguo compañero, Mor Pezuña Gris?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Has hecho algo grande, $n. Un espíritu descansa en paz, pero aún queda mucho trabajo por hacer antes de que podamos dejar todo esto atrás.$B$BDesafortunadamente, no sé la ubicación del que murió con la pieza derecha del amuleto en su poder. Pero no temas; En vida fui un aficionado al arte de la adivinación, así que tengo otra tarea para ti, que nos permitirá descubrir la pieza final.', 0),
(@ID, 'esMX', 'Has hecho algo grande, $n. Un espíritu descansa en paz, pero aún queda mucho trabajo por hacer antes de que podamos dejar todo esto atrás.$B$BDesafortunadamente, no sé la ubicación del que murió con la pieza derecha del amuleto en su poder. Pero no temas; En vida fui un aficionado al arte de la adivinación, así que tengo otra tarea para ti, que nos permitirá descubrir la pieza final.', 0);
-- 8967 La parte izquierda del amuleto de Lord Valthalak
-- https://es.classic.wowhead.com/quest=8967
SET @ID := 8967;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Seguramente aún no te has ocupado de la salvación del espíritu de Isalien y la recuperación de la pieza izquierda del amuleto de Lord Valthalak, $n.', 0),
(@ID, 'esMX', 'Seguramente aún no te has ocupado de la salvación del espíritu de Isalien y la recuperación de la pieza izquierda del amuleto de Lord Valthalak, $n.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias, $n, por hacer descansar el espíritu de Isalien. Ahora, tal vez, encontrará la paz con su diosa. Pero aún queda mucho trabajo por delante si queremos salir de este delicado aprieto en el que nos encontramos.$B$BDesafortunadamente, no sé la ubicación del que murió con la pieza derecha del amuleto en su poder. Pero no temas; En vida fui un aficionado al arte de la adivinación, así que tengo otra tarea para ti, que nos permitirá descubrir la pieza final.', 0),
(@ID, 'esMX', 'Gracias, $n, por hacer descansar el espíritu de Isalien. Ahora, tal vez, encontrará la paz con su diosa. Pero aún queda mucho trabajo por delante si queremos salir de este delicado aprieto en el que nos encontramos.$B$BDesafortunadamente, no sé la ubicación del que murió con la pieza derecha del amuleto en su poder. Pero no temas; En vida fui un aficionado al arte de la adivinación, así que tengo otra tarea para ti, que nos permitirá descubrir la pieza final.', 0);
-- 8968 La parte izquierda del amuleto de Lord Valthalak
-- https://es.classic.wowhead.com/quest=8968
SET @ID := 8968;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$n, ¿Esto significa que ya dejaste descansar las almas de esos dos tontos y recuperaste la pieza izquierda del amuleto de Lord Valthalak?', 0),
(@ID, 'esMX', '$n, ¿Esto significa que ya dejaste descansar las almas de esos dos tontos y recuperaste la pieza izquierda del amuleto de Lord Valthalak?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Supongo que es lo mejor que las almas de esos dos finalmente hayan descansado, incluso si no me agradaron mientras estaban vivos. En cualquier caso, tenemos lo que buscábamos, ¡y eso definitivamente es algo bueno!$B$BDesafortunadamente, no sé la ubicación del que murió con la pieza derecha del amuleto en su poder. Pero no temas; En vida fui un aficionado al arte de la adivinación, así que tengo otra tarea para ti, que nos permitirá descubrir la pieza final.', 0),
(@ID, 'esMX', 'Supongo que es lo mejor que las almas de esos dos finalmente hayan descansado, incluso si no me agradaron mientras estaban vivos. En cualquier caso, tenemos lo que buscábamos, ¡y eso definitivamente es algo bueno!$B$BDesafortunadamente, no sé la ubicación del que murió con la pieza derecha del amuleto en su poder. Pero no temas; En vida fui un aficionado al arte de la adivinación, así que tengo otra tarea para ti, que nos permitirá descubrir la pieza final.', 0);
-- 8969 La parte izquierda del amuleto de Lord Valthalak
-- https://es.classic.wowhead.com/quest=8969
SET @ID := 8969;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te felicito, $n, si has regresado con la pieza izquierda del amuleto. Sin embargo, si no es así, ocúpate de eso, ya que no hay tiempo que perder, ¡te lo aseguro!', 0),
(@ID, 'esMX', 'Te felicito, $n, si has regresado con la pieza izquierda del amuleto. Sin embargo, si no es así, ocúpate de eso, ya que no hay tiempo que perder, ¡te lo aseguro!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Buen trabajo, $n! Kormok no fue tan malo para un ogro, al menos no mientras aún estaba vivo, así que espero que obtenga el descanso que se merece. Pero tenemos más trabajo por delante.$B$BDesafortunadamente, no sé la ubicación del que murió con la pieza derecha del amuleto en su poder. Pero no temas; En vida fui un aficionado al arte de la adivinación, así que tengo otra tarea para ti, que nos permitirá descubrir la pieza final.', 0),
(@ID, 'esMX', '¡Buen trabajo, $n! Kormok no fue tan malo para un ogro, al menos no mientras aún estaba vivo, así que espero que obtenga el descanso que se merece. Pero tenemos más trabajo por delante.$B$BDesafortunadamente, no sé la ubicación del que murió con la pieza derecha del amuleto en su poder. Pero no temas; En vida fui un aficionado al arte de la adivinación, así que tengo otra tarea para ti, que nos permitirá descubrir la pieza final.', 0);
-- 8970 En tu destino veo la Isla de Alcaz...
-- https://es.classic.wowhead.com/quest=8970
SET @ID := 8970;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Alga de sangre, $n, un montón, eso es lo que necesito para potenciar mis hechizos adivinatorios. Es probable que tengas que llevar al menos a un par de amigos contigo a la Isla de Alcaz para recogerlo... ¡esos Strashaz son un grupo desagradable!', 0),
(@ID, 'esMX', 'Alga de sangre, $n, un montón, eso es lo que necesito para potenciar mis hechizos adivinatorios. Es probable que tengas que llevar al menos a un par de amigos contigo a la Isla de Alcaz para recogerlo... ¡esos Strashaz son un grupo desagradable!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Para ser honesto, $n, me sorprende que hayas regresado de una pieza. Por otra parte, supongo que la Isla de Alcaz es la menor de tus preocupaciones en este momento.$B$BOk, dame un momento... la adivinación no es algo de lo que puedas chasquear los dedos y esperar respuestas precisas.', 0),
(@ID, 'esMX', 'Para ser honesto, $n, me sorprende que hayas regresado de una pieza. Por otra parte, supongo que la Isla de Alcaz es la menor de tus preocupaciones en este momento.$B$BOk, dame un momento... la adivinación no es algo de lo que puedas chasquear los dedos y esperar respuestas precisas.', 0);
-- 8977 Regresa junto a Deliana
-- https://es.classic.wowhead.com/quest=8977
SET @ID := 8977;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has vuelto?', 0),
(@ID, 'esMX', '¿Has vuelto?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! Lo has hecho bien, $n. No estoy segura de confiar en la destreza del goblin, pero no me queda otra opción.', 0),
(@ID, 'esMX', '¡Excelente! Lo has hecho bien, $n. No estoy segura de confiar en la destreza del goblin, pero no me queda otra opción.', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
