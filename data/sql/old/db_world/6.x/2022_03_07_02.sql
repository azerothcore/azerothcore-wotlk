-- DB update 2022_03_07_01 -> 2022_03_07_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_07_01 2022_03_07_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646670856940613800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646670856940613800');

-- El diario deteriorado - ID 11986
DELETE FROM `quest_request_items_locale` WHERE `ID`=11986 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11986, 'esES', '¿Qué tienes ahí?', 18019),
(11986, 'esMX', '¿Qué tienes ahí?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11986 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11986, 'esES', '¿Has encontrado el diario de Brann? ¡Increíble! Hace tiempo que la Liga no ha recibido ninguno de sus informes y empezábamos a temernos que lo hubieran capturado o matado. ¿Qué es lo que descubrió dentro de Thor Modan?', 18019),
(11986, 'esMX', '¿Has encontrado el diario de Brann? ¡Increíble! Hace tiempo que la Liga no ha recibido ninguno de sus informes y empezábamos a temernos que lo hubieran capturado o matado. ¿Qué es lo que descubrió dentro de Thor Modan?', 18019);

-- La piedra angular rúnica - ID 11988
DELETE FROM `quest_request_items_locale` WHERE `ID`=11988 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11988, 'esES', '¿Tienes suficientes fragmentos para reconstruir la piedra angular?', 18019),
(11988, 'esMX', '¿Tienes suficientes fragmentos para reconstruir la piedra angular?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11988 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11988, 'esES', '<Torthen trabaja con rapidez para volver a juntar los fragmentos que has recuperado.>$B$BEsto aún está incompleto, pero nos permitirá recuperar casi toda la información de la placa.', 18019),
(11988, 'esMX', '<Torthen trabaja con rapidez para volver a juntar los fragmentos que has recuperado.>$B$BEsto aún está incompleto, pero nos permitirá recuperar casi toda la información de la placa.', 18019);

-- Las profecías rúnicas - ID 11993
DELETE FROM `quest_request_items_locale` WHERE `ID`=11993 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11993, 'esES', '¿Qué has descubierto?', 18019),
(11993, 'esMX', '¿Qué has descubierto?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11993 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11993, 'esES', "<Torthen te escucha cuando le cuentas el contenido de las placas rúnicas.>$B$B¡Por el martillo de Madoran, descubrió toda una nueva ciudad de titanes!$B$B'La cuna de la piedra y el hierro.'$B$B'Ulduar se cobijó de la tormenta.'$B$B¿Qué se supone que significa eso? ¿Quizás de dónde venimos, después de todos estos años?$B$B¡Tenemos que seguirle! ¡Tenemos que encontrarle!", 18019),
(11993, 'esMX', "<Torthen te escucha cuando le cuentas el contenido de las placas rúnicas.>$B$B¡Por el martillo de Madoran, descubrió toda una nueva ciudad de titanes!$B$B'La cuna de la piedra y el hierro.'$B$B'Ulduar se cobijó de la tormenta.'$B$B¿Qué se supone que significa eso? ¿Quizás de dónde venimos, después de todos estos años?$B$B¡Tenemos que seguirle! ¡Tenemos que encontrarle!", 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Primera Profecía descifrada', `ObjectiveText2`='Segunda Profecía descifrada', `ObjectiveText3`='Tercera Profecía descifrada' WHERE `ID`=11993 AND `locale` IN ('esES', 'esMX');

-- Suavizar el golpe - ID 11998
DELETE FROM `quest_request_items_locale` WHERE `ID`=11998 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(11998, 'esES', '¿Qué tienes ahí?', 18019),
(11998, 'esMX', '¿Qué tienes ahí?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=11998 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11998, 'esES', 'Déjame serte sincero... $gun:una; $r que no conozco me trae un barril de la mejor bebida de este maldito bosque. Vale, ¿qué estás tramando?', 18019),
(11998, 'esMX', 'Déjame serte sincero... $gun:una; $r que no conozco me trae un barril de la mejor bebida de este maldito bosque. Vale, ¿qué estás tramando?', 18019);

-- Hermanos en guerra - ID 12002
DELETE FROM `quest_request_items_locale` WHERE `ID`=12002 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12002, 'esES', '¿Cómo van las cosas en Thor Modan?', 18019),
(12002, 'esMX', '¿Cómo van las cosas en Thor Modan?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12002 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12002, 'esES', '<Brugar escucha tu informe.>$B$BParece que las cosas se están calmando un poco por ahí. Empezaremos a buscar entradas al sistema de túneles de los enanos férreos.', 18019),
(12002, 'esMX', '<Brugar escucha tu informe.>$B$BParece que las cosas se están calmando un poco por ahí. Empezaremos a buscar entradas al sistema de túneles de los enanos férreos.', 18019);

-- Destapando los túneles - ID 12003
DELETE FROM `quest_request_items_locale` WHERE `ID`=12003 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12003, 'esES', 'Supongo que no has conseguido encontrar los túneles, ¿verdad?', 18019),
(12003, 'esMX', 'Supongo que no has conseguido encontrar los túneles, ¿verdad?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12003 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12003, 'esES', '<Brugar espeta toda una serie de palabras descontroladas en enánico.>$B$B¿No hay entradas? ¿Ninguna?$B$BNo, claro que no podía ser tan fácil. Bueno, supongo que no podremos evitar tener que hacer una incursión en la ciudad. Mis muchachos nunca podrán volver a su verdadero trabajo.', 18019),
(12003, 'esMX', '<Brugar espeta toda una serie de palabras descontroladas en enánico.>$B$B¿No hay entradas? ¿Ninguna?$B$BNo, claro que no podía ser tan fácil. Bueno, supongo que no podremos evitar tener que hacer una incursión en la ciudad. Mis muchachos nunca podrán volver a su verdadero trabajo.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Investigar edificio norte', `ObjectiveText2`='Investigar edificio este', `ObjectiveText3`='Investigar edificio sur' WHERE `ID`=12003 AND `locale` IN ('esES', 'esMX');

-- El destino de Orlond - ID 12010
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12010 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12010, 'esES', 'Una mirada rápida al cuerpo revela que el perito lleva muerto algún tiempo. Mirando en su bolsa, tropiezas con las anotaciones de Orlond.', 18019),
(12010, 'esMX', 'Una mirada rápida al cuerpo revela que el perito lleva muerto algún tiempo. Mirando en su bolsa, tropiezas con las anotaciones de Orlond.', 18019);

-- ¿Duro como una piedra? - ID 12014
DELETE FROM `quest_request_items_locale` WHERE `ID`=12014 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12014, 'esES', '¿Qué has encontrado?', 18019),
(12014, 'esMX', '¿Qué has encontrado?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12014 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12014, 'esES', '<Brugar mira el informe.>$B$BEsto no es nada bueno. Incluso si pudiéramos excavar los túneles detrás del bloqueo, no tenemos garantías de que no vuelva a derrumbarse. Parece que algunas de esas zonas no se han usado durante varias generaciones. Tendremos que darle al capitán Gryan Mantorrecio las malas noticias.', 18019),
(12014, 'esMX', '<Brugar mira el informe.>$B$BEsto no es nada bueno. Incluso si pudiéramos excavar los túneles detrás del bloqueo, no tenemos garantías de que no vuelva a derrumbarse. Parece que algunas de esas zonas no se han usado durante varias generaciones. Tendremos que darle al capitán Gryan Mantorrecio las malas noticias.', 18019);

-- La arriesgada aventura de Floppy - ID 12027
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12027 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12027, 'esES', '¡Menos mal que encontraste a Emmy! Cuando se fue sin mí, me preocupaba que se perdiera.$B$BMe alegra ver que Floppy también está sano y salvo.', 18019),
(12027, 'esMX', '¡Menos mal que encontraste a Emmy! Cuando se fue sin mí, me preocupaba que se perdiera.$B$BMe alegra ver que Floppy también está sano y salvo.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Ayuda a Emily y a Floppy a volver al campamento' WHERE `ID`=12027 AND `locale` IN ('esES', 'esMX');

-- Descenso a la oscuridad - ID 12105
DELETE FROM `quest_request_items_locale` WHERE `ID`=12105 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12105, 'esES', '¿Qué es lo que tienes ahí?', 18019),
(12105, 'esMX', '¿Qué es lo que tienes ahí?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12105 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12105, 'esES', 'Me imaginé que habría algo más aparte de una ciudad aislada llena de enemigos.$B$BTenemos algunos hombres cerca de la Mina Piedrahueca, sería interesante investigar un poco.', 18019),
(12105, 'esMX', 'Me imaginé que habría algo más aparte de una ciudad aislada llena de enemigos.$B$BTenemos algunos hombres cerca de la Mina Piedrahueca, sería interesante investigar un poco.', 18019);

-- Informa a Gryan Mantorrecio... otra vez - ID 12109
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12109 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12109, 'esES', '¿Te envía Dumont? Muy bien. Veremos en qué puedes ayudar.', 18019),
(12109, 'esMX', '¿Te envía Dumont? Muy bien. Veremos en qué puedes ayudar.', 18019);

-- Visita a Raegar - ID 12128
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12128 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12128, 'esES', 'Mmm... no pareces un ayudante de investigación, lo cual no está mal. Al parecer los enanos férreos se están preparando para la guerra y mi equipo de investigación no ha vuelto. Aquí nos vendría bien algo de ayuda.', 18019),
(12128, 'esMX', 'Mmm... no pareces un ayudante de investigación, lo cual no está mal. Al parecer los enanos férreos se están preparando para la guerra y mi equipo de investigación no ha vuelto. Aquí nos vendría bien algo de ayuda.', 18019);

-- El plan perfecto - ID 12129
DELETE FROM `quest_request_items_locale` WHERE `ID`=12129 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12129, 'esES', '¿Conseguiste esos planos de los forjadores de runas?', 18019),
(12129, 'esMX', '¿Conseguiste esos planos de los forjadores de runas?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12129 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12129, 'esES', '¿Los has conseguido todos? ¡Brillante! Me muero por ver la cara que pondrán cuando el gólem esté terminado.', 18019),
(12129, 'esMX', '¿Los has conseguido todos? ¡Brillante! Me muero por ver la cara que pondrán cuando el gólem esté terminado.', 18019);

-- ¿Por qué fabricarlo cuando puedes apropiártelo? - ID 12130
DELETE FROM `quest_request_items_locale` WHERE `ID`=12130 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12130, 'esES', 'He visto que has conseguido salir entero. ¿Tienes las piezas?', 18019),
(12130, 'esMX', 'He visto que has conseguido salir entero. ¿Tienes las piezas?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12130 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12130, 'esES', '<Raegar se seca la frente con el dorso de la mano.>$B$BOh, no. Esto va a ser más difícil de lo que creía. Estas cosas no tienen números de serie, ni nada, ¿verdad?$B$BNunca hay un gnomo cuando más lo necesitas...', 18019),
(12130, 'esMX', '<Raegar se seca la frente con el dorso de la mano.>$B$BOh, no. Esto va a ser más difícil de lo que creía. Estas cosas no tienen números de serie, ni nada, ¿verdad?$B$BNunca hay un gnomo cuando más lo necesitas...', 18019);

-- Tenemos el poder... - ID 12131
DELETE FROM `quest_request_items_locale` WHERE `ID`=12131 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12131, 'esES', 'Bueno, ¿conseguiste esas células de energía?', 18019),
(12131, 'esMX', 'Bueno, ¿conseguiste esas células de energía?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12131 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12131, 'esES', '<Raegar coge las baterías.>$B$B¡Excelente! Creo que ya estamos listos para empezar.', 18019),
(12131, 'esMX', '<Raegar coge las baterías.>$B$B¡Excelente! Creo que ya estamos listos para empezar.', 18019);

-- ... O quizás no - ID 12138
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12138 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12138, 'esES', 'Por fin está listo. Solo espero que se mantenga en pie lo suficiente como para dejar el trabajo terminado. Si no sacamos de ahí al Señor feudal que dirige Dun Argol, el capitán Gryan se va a llevar una desagradable sorpresa.', 18019),
(12138, 'esMX', 'Por fin está listo. Solo espero que se mantenga en pie lo suficiente como para dejar el trabajo terminado. Si no sacamos de ahí al Señor feudal que dirige Dun Argol, el capitán Gryan se va a llevar una desagradable sorpresa.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Nivel de carga' WHERE `ID`=12138 AND `locale` IN ('esES', 'esMX');

-- El señor feudal férreo y su Yunque - ID 12153
DELETE FROM `quest_request_items_locale` WHERE `ID`=12153 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12153, 'esES', '¿Pudiste superar las defensas del Señor feudal férreo Martillo Furioso?', 18019),
(12153, 'esMX', '¿Pudiste superar las defensas del Señor feudal férreo Martillo Furioso?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12153 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12153, 'esES', '¿Ha funcionado?$B$B<Raegar se aclara la garganta.>$B$BQué digo... ¡Pues claro que funcionó! ¡Es increíble!$B$BDurante años ¡los iniciados de la Liga de Expedicionarios oirán la historia de cómo Raegar Rompecejas, $n y un gólem chatarrero derrotaron al señor feudal de Dun Argol!', 18019),
(12153, 'esMX', '¿Ha funcionado?$B$B<Raegar se aclara la garganta.>$B$BQué digo... ¡Pues claro que funcionó! ¡Es increíble!$B$BDurante años ¡los iniciados de la Liga de Expedicionarios oirán la historia de cómo Raegar Rompecejas, $n y un gólem chatarrero derrotaron al señor feudal de Dun Argol!', 18019);

-- Apagón - ID 12154
DELETE FROM `quest_request_items_locale` WHERE `ID`=12154 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12154, 'esES', '¿Has desactivado la fuente de alimentación de sus runas?', 18019),
(12154, 'esMX', '¿Has desactivado la fuente de alimentación de sus runas?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12154 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12154, 'esES', '<Raegar asiente con aprobación.>$B$BNo puedo soportar ver que se malgastan unos explosivos, y además entorpecerá a nuestros enemigos.', 18019),
(12154, 'esMX', '<Raegar asiente con aprobación.>$B$BNo puedo soportar ver que se malgastan unos explosivos, y además entorpecerá a nuestros enemigos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Batería de Dun Argol destruida' WHERE `ID`=12154 AND `locale` IN ('esES', 'esMX');

-- Mina Piedrahueca - ID 12158
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12158 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12158, 'esES', '¡Dime que has venido a ayudarme!', 18019),
(12158, 'esMX', '¡Dime que has venido a ayudarme!', 18019);

-- Almas sin descanso - ID 12159
DELETE FROM `quest_request_items_locale` WHERE `ID`=12159 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12159, 'esES', '¿Ya has hecho descansar a mis amigos, $n?', 18019),
(12159, 'esMX', '¿Ya has hecho descansar a mis amigos, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12159 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12159, 'esES', '¡Descansad en paz, amigos! No os preocupéis... ¡le diré a todo el mundo que nunca nos rendimos!', 18019),
(12159, 'esMX', '¡Descansad en paz, amigos! No os preocupéis... ¡le diré a todo el mundo que nunca nos rendimos!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Minero en paz' WHERE `ID`=12159 AND `locale` IN ('esES', 'esMX');

-- Un nombre del pasado - ID 12160
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12160 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12160, 'esES', 'Maldita suerte la nuestra. Encontramos una mina operativa a este lado de las colinas y resulta que está llena de miembros de la Plaga.$B$BNo te ofendas, amigo, pero ese superviviente que encontraste parece que está un poco traumatizado por la pérdida de sus amigos. Arugal lleva años muerto... Incluso vi su tumba una vez.', 18019),
(12160, 'esMX', 'Maldita suerte la nuestra. Encontramos una mina operativa a este lado de las colinas y resulta que está llena de miembros de la Plaga.$B$BNo te ofendas, amigo, pero ese superviviente que encontraste parece que está un poco traumatizado por la pérdida de sus amigos. Arugal lleva años muerto... Incluso vi su tumba una vez.', 18019);

-- Ruuna la Ciega - ID 12161
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12161 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12161, 'esES', 'Buscas información fuera de tu alcance y por eso vienes a mí. Pero debo advertirte, desconocido, de que las respuestas a tus preguntas pueden no ser de tu agrado.', 18019),
(12161, 'esMX', 'Buscas información fuera de tu alcance y por eso vienes a mí. Pero debo advertirte, desconocido, de que las respuestas a tus preguntas pueden no ser de tu agrado.', 18019);

-- Los prospectores cautivos - ID 12180
DELETE FROM `quest_request_items_locale` WHERE `ID`=12180 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12180, 'esES', '¿Habéis localizado a los buscadores desaparecidos?', 18019),
(12180, 'esMX', '¿Habéis localizado a los buscadores desaparecidos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12180 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12180, 'esES', '<El montaraz Kilian te escucha mientras le cuentas lo que los prospectores cautivos te dijeron a ti.>$B$B¿Mencionaron a Loken y cierta guerra contra los gigantes de piedra? ¿Estás seguro?$B$BAsí que los instintos de Raegar no iban mal encaminados... Tenemos que encontrar una manera de entrar ahí y averiguar más sobre sus planes.', 18019),
(12180, 'esMX', '<El montaraz Kilian te escucha mientras le cuentas lo que los prospectores cautivos te dijeron a ti.>$B$B¿Mencionaron a Loken y cierta guerra contra los gigantes de piedra? ¿Estás seguro?$B$BAsí que los instintos de Raegar no iban mal encaminados... Tenemos que encontrar una manera de entrar ahí y averiguar más sobre sus planes.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Prospector Gann rescatado', `ObjectiveText2`='Prospector Torgan rescatado', `ObjectiveText3`='Prospectora Varana rescatada' WHERE `ID`=12180 AND `locale` IN ('esES', 'esMX');

-- Dando el pego - ID 12183
DELETE FROM `quest_request_items_locale` WHERE `ID`=12183 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12183, 'esES', '¿Has conseguido el uniforme?', 18019),
(12183, 'esMX', '¿Has conseguido el uniforme?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12183 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12183, 'esES', '<Kilian coge el uniforme.>$B$BEsto servirá. No tendré tiempo de coserle un parchecillo con un "$n" bordado, o algo así, pero para cuando termine contigo, cualquiera que te mire de cerca creerá que eres un sobrestante.', 18019),
(12183, 'esMX', '<Kilian coge el uniforme.>$B$BEsto servirá. No tendré tiempo de coserle un parchecillo con un "$n" bordado, o algo así, pero para cuando termine contigo, cualquiera que te mire de cerca creerá que eres un sobrestante.', 18019);

-- Cultivando una imagen - ID 12184
DELETE FROM `quest_request_items_locale` WHERE `ID`=12184 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12184, 'esES', '¿Has hecho esas fotos?', 18019),
(12184, 'esMX', '¿Has hecho esas fotos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12184 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12184, 'esES', 'Bien, estas servirán. Ahora, diseñemos un conjunto para que pases por un auténtico enano férreo.', 18019),
(12184, 'esMX', 'Bien, estas servirán. Ahora, diseñemos un conjunto para que pases por un auténtico enano férreo.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Imágenes de enanos férreos tomadas' WHERE `ID`=12184 AND `locale` IN ('esES', 'esMX');

-- Ponte tu mejor cara para Loken - ID 12185
DELETE FROM `quest_request_items_locale` WHERE `ID`=12185 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12185, 'esES', '¿Funcionó el disfraz?', 18019),
(12185, 'esMX', '¿Funcionó el disfraz?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12185 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12185, 'esES', '¿Es posible que Loken esté exagerando? Los hijos de los titanes de piedra y de hierro luchando unos contra otros por el control de la antigua ciudad de Ulduar... Es una locura, $n, ¡y podría echar por tierra nuestra única oportunidad para conocer la verdadera historia de la raza enana!', 18019),
(12185, 'esMX', '¿Es posible que Loken esté exagerando? Los hijos de los titanes de piedra y de hierro luchando unos contra otros por el control de la antigua ciudad de Ulduar... Es una locura, $n, ¡y podría echar por tierra nuestra única oportunidad para conocer la verdadera historia de la raza enana!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Mensaje de Loken recibido' WHERE `ID`=12185 AND `locale` IN ('esES', 'esMX');

-- ¡Temporada de trols! - ID 12210
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12210 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12210, 'esES', 'Quieres algo de acción de caza, ¿eh?', 18019),
(12210, 'esMX', 'Quieres algo de acción de caza, ¿eh?', 18019);

-- Reabasteciendo el almacén - ID 12212
DELETE FROM `quest_request_items_locale` WHERE `ID`=12212 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12212, 'esES', '¿Cómo va la caza, $r?', 18019),
(12212, 'esMX', '¿Cómo va la caza, $r?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12212 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12212, 'esES', '¡Estos sí que son buenos trozos de carne!', 18019),
(12212, 'esMX', '¡Estos sí que son buenos trozos de carne!', 18019);

-- ¡O ellos, o nosotros! - ID 12215
DELETE FROM `quest_request_items_locale` WHERE `ID`=12215 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12215, 'esES', 'Espero que haya menos gusanos cazando en estos bosques.', 18019),
(12215, 'esMX', 'Espero que haya menos gusanos cazando en estos bosques.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12215 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12215, 'esES', 'Buen trabajo, $c.$B$BEsto debería ayudar a asegurar que la fauna salvaje de estos lares termine donde debe: asándose en nuestros fuegos.', 18019),
(12215, 'esMX', 'Buen trabajo, $c.$B$BEsto debería ayudar a asegurar que la fauna salvaje de estos lares termine donde debe: asándose en nuestros fuegos.', 18019);

-- ¡Cógeles el trasero! - ID 12216
DELETE FROM `quest_request_items_locale` WHERE `ID`=12216 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12216, 'esES', '¡$gEl:La; $gpoderoso:poderosa; $c ha vuelto!', 18019),
(12216, 'esMX', '¡$gEl:La; $gpoderoso:poderosa; $c ha vuelto!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12216 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12216, 'esES', '¡Excelente!$B$BNuestros almacenes están casi llenos. Has cumplido con tu parte, $n.', 18019),
(12216, 'esMX', '¡Excelente!$B$BNuestros almacenes están casi llenos. Has cumplido con tu parte, $n.', 18019);

-- Ojos de águila - ID 12217
DELETE FROM `quest_request_items_locale` WHERE `ID`=12217 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12217, 'esES', '¿Has completado tu tarea, $c?', 18019),
(12217, 'esMX', '¿Has completado tu tarea, $c?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12217 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12217, 'esES', 'Una tarea sombría, lo sé. Pero ahora podremos descansar mejor sabiendo que los ojos de los enemigos ya no están sobre nosotros.', 18019),
(12217, 'esMX', 'Una tarea sombría, lo sé. Pero ahora podremos descansar mejor sabiendo que los ojos de los enemigos ya no están sobre nosotros.', 18019);

-- El Árbol del Mundo fallido - ID 12219
DELETE FROM `quest_request_items_locale` WHERE `ID`=12219 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12219, 'esES', '¿Has conseguido las muestras, $n?', 18019),
(12219, 'esMX', '¿Has conseguido las muestras, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12219 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12219, 'esES', 'El moco no es natural, $n. Está totalmente corrompido y es... malvado.$B$BDebemos descubrir más.', 18019),
(12219, 'esMX', 'El moco no es natural, $n. Está totalmente corrompido y es... malvado.$B$BDebemos descubrir más.', 18019);

-- Una influencia oscura - ID 12220
DELETE FROM `quest_request_items_locale` WHERE `ID`=12220 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12220, 'esES', '¿Has hecho lo que te pedí, $n?', 18019),
(12220, 'esMX', '¿Has hecho lo que te pedí, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12220 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12220, 'esES', 'La energía en el orbe es... abrumadora...$B$BUna fuerza oscura ha contaminado el suelo cerca de los restos de Vordrassil. Debemos investigar más.', 18019),
(12220, 'esMX', 'La energía en el orbe es... abrumadora...$B$BUna fuerza oscura ha contaminado el suelo cerca de los restos de Vordrassil. Debemos investigar más.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Orbe utilizado bajo el Corazón de Vordrassil', `ObjectiveText2`='Orbe utilizado bajo la Extremidad de Vordrassil', `ObjectiveText3`='Orbe utilizado bajo las Lágrimas de Vordrassil' WHERE `ID`=12220 AND `locale` IN ('esES', 'esMX');

-- Secretos de las vinculadoras de llamas - ID 12222
DELETE FROM `quest_request_items_locale` WHERE `ID`=12222 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12222, 'esES', '¿Has conseguido esos talismanes?', 18019),
(12222, 'esMX', '¿Has conseguido esos talismanes?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12222 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12222, 'esES', 'Con los talismanes en tus manos, el draco no tendrá más opción que obedecerte. No puedo esperar a ver la cara que pondrá el señor feudal cuando se dé cuenta de que estás dando órdenes a su protodraco.', 18019),
(12222, 'esMX', 'Con los talismanes en tus manos, el draco no tendrá más opción que obedecerte. No puedo esperar a ver la cara que pondrá el señor feudal cuando se dé cuenta de que estás dando órdenes a su protodraco.', 18019);

-- Disminuir las filas - ID 12223
DELETE FROM `quest_request_items_locale` WHERE `ID`=12223 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12223, 'esES', '¿Has hecho la acción?', 18019),
(12223, 'esMX', '¿Has hecho la acción?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12223 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12223, 'esES', 'Buen trabajo, $n. Ahora debemos continuar y aprovechar la ventaja.', 18019),
(12223, 'esMX', 'Buen trabajo, $n. Ahora debemos continuar y aprovechar la ventaja.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Huscarle Desuelladragones' WHERE `ID`=12223 AND `locale` IN ('esES', 'esMX');

-- Mmm... ¡Grano ámbar! - ID 12225
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12225 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12225, 'esES', '¡¡¿Que hiciste qué?!!$B$B¡Eso era grano ámbar! ¡El resultado de toda una cosecha!$B$BEsos granos mágicos podrían haber sido la solución a nuestra crisis de hambre. ¡Créeme cuando te digo que vas a arreglarlo, $n!', 18019),
(12225, 'esMX', '¡¡¿Que hiciste qué?!!$B$B¡Eso era grano ámbar! ¡El resultado de toda una cosecha!$B$BEsos granos mágicos podrían haber sido la solución a nuestra crisis de hambre. ¡Créeme cuando te digo que vas a arreglarlo, $n!', 18019);

-- Digiriendo - ID 12226
DELETE FROM `quest_request_items_locale` WHERE `ID`=12226 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12226, 'esES', '¿Has encontrado la raíz negra?', 18019),
(12226, 'esMX', '¿Has encontrado la raíz negra?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12226 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12226, 'esES', 'Estos servirán...$B$B<Anderhol retuerce los tallos con maña, recogiendo unos fluidos negros dentro de un vial minúsculo.>$B$BAhí está, ya es hora de ponerse con ello.', 18019),
(12226, 'esMX', 'Estos servirán...$B$B<Anderhol retuerce los tallos con maña, recogiendo unos fluidos negros dentro de un vial minúsculo.>$B$BAhí está, ya es hora de ponerse con ello.', 18019);

-- Cumplir con tu deber - ID 12227
DELETE FROM `quest_request_items_locale` WHERE `ID`=12227 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12227, 'esES', '¿Ya me conseguiste ese grano, $r?', 18019),
(12227, 'esMX', '¿Ya me conseguiste ese grano, $r?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12227 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12227, 'esES', '¿Bien, $n? ¿Todo salió bien?$B$BMmm, parece que los hemos cogido justo a tiempo...', 18019),
(12227, 'esMX', '¿Bien, $n? ¿Todo salió bien?$B$BMmm, parece que los hemos cogido justo a tiempo...', 18019);

-- Reparación de trituradoras - ID 12244
DELETE FROM `quest_request_items_locale` WHERE `ID`=12244 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12244, 'esES', 'No hay tiempo para charlas. Estas trituradoras podrían inclinar la balanza a favor de la alianza.', 18019),
(12244, 'esMX', 'No hay tiempo para charlas. Estas trituradoras podrían inclinar la balanza a favor de la alianza.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12244 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12244, 'esES', '<Synipus silba.>$B$B¡Oh, es una belleza! La arreglaremos bien.$B$BSi tienes pocas cosas que hacer, ve a hablar con Gordun para que te lleve a Venture Bay. Seguro que necesitan una mano.$B$BAh, y mientras estás allí, usa estas llaves en una trituradora restaurada. ¡Espera a ver lo que pueden hacer estos bebés cuando están limpios!', 18019),
(12244, 'esMX', '<Synipus silba.>$B$B¡Oh, es una belleza! La arreglaremos bien.$B$BSi tienes pocas cosas que hacer, ve a hablar con Gordun para que te lleve a Venture Bay. Seguro que necesitan una mano.$B$BAh, y mientras estás allí, usa estas llaves en una trituradora restaurada. ¡Espera a ver lo que pueden hacer estos bebés cuando están limpios!', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Trituradora entregada' WHERE `ID`=12244 AND `locale` IN ('esES', 'esMX');

-- Una posible relación - ID 12246
DELETE FROM `quest_request_items_locale` WHERE `ID`=12246 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12246, 'esES', '¿Has conseguido las muestras de sangre, $n?', 18019),
(12246, 'esMX', '¿Has conseguido las muestras de sangre, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12246 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12246, 'esES', 'La corrupción presente en esta sangre es la misma que la del moco. Esto no me da buena espina.', 18019),
(12246, 'esMX', 'La corrupción presente en esta sangre es la misma que la del moco. Esto no me da buena espina.', 18019);

-- Hijos de Ursoc - ID 12247
DELETE FROM `quest_request_items_locale` WHERE `ID`=12247 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12247, 'esES', '¿Has hablado ya con Orsonn y Kodian?', 18019),
(12247, 'esMX', '¿Has hablado ya con Orsonn y Kodian?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12247 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12247, 'esES', 'Los hijos de Ursoc son sabios. Sus palabras explican mucho de lo que hemos visto hasta ahora.', 18019),
(12247, 'esMX', 'Los hijos de Ursoc son sabios. Sus palabras explican mucho de lo que hemos visto hasta ahora.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Historia de Orsonn', `ObjectiveText2`='Historia de Kodian' WHERE `ID`=12247 AND `locale` IN ('esES', 'esMX');

-- El árbol joven de Vordrassil - ID 12248
DELETE FROM `quest_request_items_locale` WHERE `ID`=12248 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12248, 'esES', '¿Me has traído las cenizas, $n?', 18019),
(12248, 'esMX', '¿Me has traído las cenizas, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12248 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12248, 'esES', '¡Sí! La magia de Vordrassil sigue presente en estas cenizas. Puede que todavía haya esperanza para Ursoc.', 18019),
(12248, 'esMX', '¡Sí! La magia de Vordrassil sigue presente en estas cenizas. Puede que todavía haya esperanza para Ursoc.', 18019);

-- Ursoc, el dios oso - ID 12249
DELETE FROM `quest_request_items_locale` WHERE `ID`=12249 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12249, 'esES', 'Has vuelto. ¿Tuviste éxito?', 18019),
(12249, 'esMX', 'Has vuelto. ¿Tuviste éxito?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12249 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12249, 'esES', '<La druida parece pálida y su mirada vacía te atraviesa. Ha dejado un paquete previendo tu regreso.>', 18019),
(12249, 'esMX', '<La druida parece pálida y su mirada vacía te atraviesa. Ha dejado un paquete previendo tu regreso.>', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Ursoc purificado' WHERE `ID`=12249 AND `locale` IN ('esES', 'esMX');

-- Las semillas de Vordrassil - ID 12250
DELETE FROM `quest_request_items_locale` WHERE `ID`=12250 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12250, 'esES', '¿Tienes las semillas, $n?', 18019),
(12250, 'esMX', '¿Tienes las semillas, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12250 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12250, 'esES', 'Gracias, $n. Dámelas.$B$BEl poder corruptor de estas semillas es peligroso. Debo destruirlas ahora mismo.', 18019),
(12250, 'esMX', 'Gracias, $n. Dámelas.$B$BEl poder corruptor de estas semillas es peligroso. Debo destruirlas ahora mismo.', 18019);

-- El señor feudal de Runavold - ID 12255
DELETE FROM `quest_request_items_locale` WHERE `ID`=12255 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12255, 'esES', '¿Has vencido al señor feudal? No podemos arriesgarnos a dejarle en el poder.', 18019),
(12255, 'esMX', '¿Has vencido al señor feudal? No podemos arriesgarnos a dejarle en el poder.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12255 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12255, 'esES', 'Buen trabajo, $n. Dudo que cualquiera de los trabajadores forestales hubiera querido jugársela con un protodraco, pero no podíamos permitirnos que los Desuelladragones construyesen una base de poder en las Colinas Pardas. Si pudiéramos ocuparnos tan fácilmente de la Horda...', 18019),
(12255, 'esMX', 'Buen trabajo, $n. Dudo que cualquiera de los trabajadores forestales hubiera querido jugársela con un protodraco, pero no podíamos permitirnos que los Desuelladragones construyesen una base de poder en las Colinas Pardas. Si pudiéramos ocuparnos tan fácilmente de la Horda...', 18019);

-- Piezas y partes - ID 12268
DELETE FROM `quest_request_items_locale` WHERE `ID`=12268 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12268, 'esES', '¿Tienes esas partes para mí, $c?', 18019),
(12268, 'esMX', '¿Tienes esas partes para mí, $c?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12268 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12268, 'esES', 'Sí, efectivamente. Esto debería servir...$B$BYa está. Una trituradora más lista para el combate. Gracias, $n.', 18019),
(12268, 'esMX', 'Sí, efectivamente. Esto debería servir...$B$BYa está. Una trituradora más lista para el combate. Gracias, $n.', 18019);

-- Golpéalos mientras han caído - ID 12289
DELETE FROM `quest_request_items_locale` WHERE `ID`=12289 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12289, 'esES', '¿Cómo va la pelea, $N?', 18019),
(12289, 'esMX', '¿Cómo va la pelea, $N?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12289 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12289, 'esES', 'Bien hecho, $n.$B$BNos has hecho ganar algo de tiempo, aunque probablemente no más de un día. Sin embargo, la Alianza está agradecida por tus esfuerzos.', 18019),
(12289, 'esMX', 'Bien hecho, $n.$B$BNos has hecho ganar algo de tiempo, aunque probablemente no más de un día. Sin embargo, la Alianza está agradecida por tus esfuerzos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Unidades de la Horda eliminadas' WHERE `ID`=12289 AND `locale` IN ('esES', 'esMX');

-- Apoyo local - ID 12292
DELETE FROM `quest_request_items_locale` WHERE `ID`=12292 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12292, 'esES', '¿Me traes ese cofre, $n?', 18019),
(12292, 'esMX', '¿Me traes ese cofre, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12292 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12292, 'esES', 'Está cerrado, ¿verdad? Parece bastante corriente.$B$B<El teniente Dumont sacude el cofre y se oye un sonidito a madera.>$B$BSupongo que no importa. Si esto nos proporciona la ventaja que necesitamos contra la Horda, entonces no me preocupa si la cura contra la Peste está ahí dentro.', 18019),
(12292, 'esMX', 'Está cerrado, ¿verdad? Parece bastante corriente.$B$B<El teniente Dumont sacude el cofre y se oye un sonidito a madera.>$B$BSupongo que no importa. Si esto nos proporciona la ventaja que necesitamos contra la Horda, entonces no me preocupa si la cura contra la Peste está ahí dentro.', 18019);

-- Cierra el trato - ID 12293
DELETE FROM `quest_request_items_locale` WHERE `ID`=12293 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12293, 'esES', '¿Nos has traído algo?', 18019),
(12293, 'esMX', '¿Nos has traído algo?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12293 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12293, 'esES', '¡Lo lograste! Has recuperado el... el cofre que la Horda nos robó. Te lo agradecemos, $n.', 18019),
(12293, 'esMX', '¡Lo lograste! Has recuperado el... el cofre que la Horda nos robó. Te lo agradecemos, $n.', 18019);

-- Un pacto provisional - ID 12294
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12294 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12294, 'esES', 'Qué buenas noticias, $n. Con la ayuda de los trabajadores forestales tendremos el apoyo logístico necesario para superar en táctica a la Horda en esta zona.$B$BTengo algo más que encargarte, si te interesa.', 18019),
(12294, 'esMX', 'Qué buenas noticias, $n. Con la ayuda de los trabajadores forestales tendremos el apoyo logístico necesario para superar en táctica a la Horda en esta zona.$B$BTengo algo más que encargarte, si te interesa.', 18019);

-- Un ejercicio de diplomacia - ID 12295
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12295 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12295, 'esES', '¡Por fin te conozco, $n, qué bien! Hemos oído hablar de ti por aquí. Te doy la bienvenida a Arroyoplata.$B$BEsos tramperos son un buen montón de mozos y mozas. Robustos... conocen muy bien estas tierras. Pronto te darás cuenta de lo fantástico que es que se hayan puesto de nuestro lado.', 18019),
(12295, 'esMX', '¡Por fin te conozco, $n, qué bien! Hemos oído hablar de ti por aquí. Te doy la bienvenida a Arroyoplata.$B$BEsos tramperos son un buen montón de mozos y mozas. Robustos... conocen muy bien estas tierras. Pronto te darás cuenta de lo fantástico que es que se hayan puesto de nuestro lado.', 18019);

-- A vida o muerte - ID 12296
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12296 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12296, 'esES', '¡Maravilloso!$B$BLa Alianza vivirá para ver otro día, en parte debido a su diligencia.$B$BPor favor, acepta mi agradecimiento, amigo.', 18019),
(12296, 'esMX', '¡Maravilloso!$B$BLa Alianza vivirá para ver otro día, en parte debido a su diligencia.$B$BPor favor, acepta mi agradecimiento, amigo.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Infantería de los Páramos de Poniente sanada' WHERE `ID`=12296 AND `locale` IN ('esES', 'esMX');

-- La hospitalidad norteña - ID 12299
DELETE FROM `quest_request_items_locale` WHERE `ID`=12299 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12299, 'esES', '¿Ya has terminado con esos cretinos de la Horda?', 18019),
(12299, 'esMX', '¿Ya has terminado con esos cretinos de la Horda?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12299 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12299, 'esES', 'No está mal, no está mal. Quizás no seas tan enclenque como los otros.', 18019),
(12299, 'esMX', 'No está mal, no está mal. Quizás no seas tan enclenque como los otros.', 18019);

-- Prueba de valor - ID 12300
DELETE FROM `quest_request_items_locale` WHERE `ID`=12300 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12300, 'esES', 'La gente de Arroyoplata... no es lo que parece.', 18019),
(12300, 'esMX', 'La gente de Arroyoplata... no es lo que parece.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12300 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12300, 'esES', 'No lo hagas, $n. La gente que te ha enviado aquí... No deberías confiar en ellos.', 18019),
(12300, 'esMX', 'No lo hagas, $n. La gente que te ha enviado aquí... No deberías confiar en ellos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Prueba de valor' WHERE `ID`=12300 AND `locale` IN ('esES', 'esMX');

-- Una advertencia - ID 12302
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12302 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12302, 'esES', '¿Quién está ahí? ¿Has venido a matarme?$B$B¡Por favor! ¡No tienes por qué hacer esto!', 18019),
(12302, 'esMX', '¿Quién está ahí? ¿Has venido a matarme?$B$B¡Por favor! ¡No tienes por qué hacer esto!', 18019);

-- Raíz aterralobos - ID 12307
DELETE FROM `quest_request_items_locale` WHERE `ID`=12307 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12307, 'esES', 'Sí, ¿$c?', 18019),
(12307, 'esMX', 'Sí, ¿$c?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12307 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12307, 'esES', '<Katja se aleja de ti nerviosa>.$B$BGracias, $n. No llevarás ninguna aterralobos encima, ¿verdad? Tengo ciertas... alergias que aparecen de vez en cuando.', 18019),
(12307, 'esMX', '<Katja se aleja de ti nerviosa>.$B$BGracias, $n. No llevarás ninguna aterralobos encima, ¿verdad? Tengo ciertas... alergias que aparecen de vez en cuando.', 18019);

-- Huye de Arroyoplata - ID 12308
DELETE FROM `quest_request_items_locale` WHERE `ID`=12308 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12308, 'esES', 'Has vuelto. Estaba preocupado por ti, $n.', 18019),
(12308, 'esMX', 'Has vuelto. Estaba preocupado por ti, $n.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12308 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12308, 'esES', 'Huargen. Huargen condenados, mugrientos y dejados de la mano de la Luz.$B$BYa era hora de que les enseñáramos lo que nosotros, gente civilizada, hacemos con las bestias como ellos.', 18019),
(12308, 'esMX', 'Huargen. Huargen condenados, mugrientos y dejados de la mano de la Luz.$B$BYa era hora de que les enseñáramos lo que nosotros, gente civilizada, hacemos con las bestias como ellos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Huye de Arroyoplata' WHERE `ID`=12308 AND `locale` IN ('esES', 'esMX');

-- Una reacción inmediata - ID 12310
DELETE FROM `quest_request_items_locale` WHERE `ID`=12310 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12310, 'esES', '¿Está hecho, $n?', 18019),
(12310, 'esMX', '¿Está hecho, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12310 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12310, 'esES', 'Es una pena que esos tramperos resultasen estar... afligidos. Nos habrían venido muy bien unos cuantos hombres más en la lucha.$B$BQue esas pobres almas descansen en paz.', 18019),
(12310, 'esMX', 'Es una pena que esos tramperos resultasen estar... afligidos. Nos habrían venido muy bien unos cuantos hombres más en la lucha.$B$BQue esas pobres almas descansen en paz.', 18019);

-- ¡Abajo la capitana Zorna! - ID 12314
DELETE FROM `quest_request_items_locale` WHERE `ID`=12314 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12314, 'esES', '¿Has matado al Capitán Zorna?', 18019),
(12314, 'esMX', '¿Has matado al Capitán Zorna?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12314 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12314, 'esES', '¡Buen trabajo, $n! Sin su líder, la Horda se debilitará y desorganizará. Haré que nuestros hombres avancen.', 18019),
(12314, 'esMX', '¡Buen trabajo, $n! Sin su líder, la Horda se debilitará y desorganizará. Haré que nuestros hombres avancen.', 18019);

-- ¡Mantenlos a raya! - ID 12316
DELETE FROM `quest_request_items_locale` WHERE `ID`=12316 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12316, 'esES', '¿Qué tienes que informar?', 18019),
(12316, 'esMX', '¿Qué tienes que informar?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12316 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12316, 'esES', 'Tu valor ha inspirado a los hombres de la Brigada de los Páramos de Poniente. Ahora luchan con más ferocidad. El puerto pronto será nuestro.', 18019),
(12316, 'esMX', 'Tu valor ha inspirado a los hombres de la Brigada de los Páramos de Poniente. Ahora luchan con más ferocidad. El puerto pronto será nuestro.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Horda eliminada en Bahía Ventura' WHERE `ID`=12316 AND `locale` IN ('esES', 'esMX');

-- Ahúmalos - ID 12323
DELETE FROM `quest_request_items_locale` WHERE `ID`=12323 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12323, 'esES', '¿Ya te has cargado a los últimos tipos de la compañía Ventura?', 18019),
(12323, 'esMX', '¿Ya te has cargado a los últimos tipos de la compañía Ventura?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12323 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12323, 'esES', '¡Buen trabajo, soldado! Ahora el resto de los hombres pueden concentrarse en la Horda.', 18019),
(12323, 'esMX', '¡Buen trabajo, soldado! Ahora el resto de los hombres pueden concentrarse en la Horda.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Rezagados de Ventura y Cía. ahuyentados' WHERE `ID`=12323 AND `locale` IN ('esES', 'esMX');

-- Monta - ID 12414
DELETE FROM `quest_request_items_locale` WHERE `ID`=12414 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12414, 'esES', '¿Conseguiste todos los caballos mesteños que necesitaremos?', 18019),
(12414, 'esMX', '¿Conseguiste todos los caballos mesteños que necesitaremos?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12414 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12414, 'esES', '¡Guau! ¡Estos son unos caballos estupendos! Creo que el capi estará encantado con nuestro trabajo.', 18019),
(12414, 'esMX', '¡Guau! ¡Estos son unos caballos estupendos! Creo que el capi estará encantado con nuestro trabajo.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Caballos mesteños de las Tierras Altas recuperados' WHERE `ID`=12414 AND `locale` IN ('esES', 'esMX');

-- Cabalgando sobre el cohete rojo - ID 12437
DELETE FROM `quest_request_items_locale` WHERE `ID`=12437 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12437, 'esES', '¿Ya se quemó el barco maderero de la Horda, $N?', 18019),
(12437, 'esMX', '¿Ya se quemó el barco maderero de la Horda, $N?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12437 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12437, 'esES', 'Es bueno ver que has sobrevivido al impacto. ¡Qué explosión!$B$BNo podemos permitirnos que la Horda se lleve toda esa madera.$B$BBien hecho, $c.', 18019),
(12437, 'esMX', 'Es bueno ver que has sobrevivido al impacto. ¡Qué explosión!$B$BNo podemos permitirnos que la Horda se lleve toda esa madera.$B$BBien hecho, $c.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Barco de leña de la Horda destruido' WHERE `ID`=12437 AND `locale` IN ('esES', 'esMX');

-- Buscando disolvente - ID 12443
DELETE FROM `quest_request_items_locale` WHERE `ID`=12443 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12443, 'esES', '¿Tienes un poco de ese Elemento 115, $n?', 18019),
(12443, 'esMX', '¿Tienes un poco de ese Elemento 115, $n?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12443 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12443, 'esES', 'Ooh, sí. Eso me ahorrará horas.$B$BCoge esto por tus molestias, amigo. Y sigue buscando más Elemento 115. Aceptaré todo el que me traigas.', 18019),
(12443, 'esMX', 'Ooh, sí. Eso me ahorrará horas.$B$BCoge esto por tus molestias, amigo. Y sigue buscando más Elemento 115. Aceptaré todo el que me traigas.', 18019);

-- Escaramuza en Río Negro - ID 12444
DELETE FROM `quest_request_items_locale` WHERE `ID`=12444 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12444, 'esES', '¿Cómo va la caza?', 18019),
(12444, 'esMX', '¿Cómo va la caza?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12444 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12444, 'esES', 'Buen trabajo, $n. Por aquí nos vendrían bien más como tú. Podríamos enseñarle a la Horda que no tiene que meterse con nosotros.', 18019),
(12444, 'esMX', 'Buen trabajo, $n. Por aquí nos vendrían bien más como tú. Podríamos enseñarle a la Horda que no tiene que meterse con nosotros.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Horda en Río Negro eliminada' WHERE `ID`=12444 AND `locale` IN ('esES', 'esMX');

-- Las colinas tienen ojos - ID 12511
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12511 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12511, 'esES', 'Casi te matan de un disparo, ¿eh? Estos de la Horda son unos monstruos salvajes.$B$BPagarán por lo que han hecho. Por lo menos puedes contar con ello, $c.$B$BAhora tienes que ponerte a trabajar.', 18019),
(12511, 'esMX', 'Casi te matan de un disparo, ¿eh? Estos de la Horda son unos monstruos salvajes.$B$BPagarán por lo que han hecho. Por lo menos puedes contar con ello, $c.$B$BAhora tienes que ponerte a trabajar.', 18019);

-- Redistribuir los recursos - ID 12770
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12770 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12770, 'esES', '¡La Luz prevalecerá!', 18019),
(12770, 'esMX', '¡La Luz prevalecerá!', 18019);

-- Aprender a ir y a volver: la manera mágica - ID 12790
DELETE FROM `quest_request_items_locale` WHERE `ID`=12790 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12790, 'esES', 'Siento que aún no has probado los dos cristales de teletransporte.$B$BEstá bien, tómate tu tiempo.', 18019),
(12790, 'esMX', 'Siento que aún no has probado los dos cristales de teletransporte.$B$BEstá bien, tómate tu tiempo.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12790 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12790, 'esES', 'Perfecto, $c. Ahora sabes cómo ir hasta el Bosque Canto de Cristal y también cómo volver.', 18019),
(12790, 'esMX', 'Perfecto, $c. Ahora sabes cómo ir hasta el Bosque Canto de Cristal y también cómo volver.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Cristal de teletransporte a El Confín Violeta usado', `ObjectiveText2`='Cristal de teletransporte a Dalaran usado' WHERE `ID`=12790 AND `locale` IN ('esES', 'esMX');

-- El reino mágico de Dalaran - ID 12794
DELETE FROM `quest_request_items_locale` WHERE `ID`=12794 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12794, 'esES', 'Saludos, $c.', 18019),
(12794, 'esMX', 'Saludos, $c.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12794 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12794, 'esES', 'Bienvenido a Dalaran.$B$BMe aseguraré de que el anillo sea devuelto.', 18019),
(12794, 'esMX', 'Bienvenido a Dalaran.$B$BMe aseguraré de que el anillo sea devuelto.', 18019);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_07_02' WHERE sql_rev = '1646670856940613800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
