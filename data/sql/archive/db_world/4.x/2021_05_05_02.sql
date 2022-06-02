-- DB update 2021_05_05_01 -> 2021_05_05_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_05_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_05_01 2021_05_05_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619616408121276500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619616408121276500');

-- 8355 ¡Truco o trato!
-- https://es.classic.wowhead.com/quest=8355
SET @ID := 8355;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Haz el tren para Talvash', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Bueno, adelante ahora...', 0),
(@ID, 'esMX', 'Bueno, adelante ahora...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Chú, chú! ¡Bien hecho, $n! Aquí tienes tu premio.$B$B¡Feliz día de Halloween!', 0),
(@ID, 'esMX', '¡Chú, chú! ¡Bien hecho, $n! Aquí tienes tu premio.$B$B¡Feliz día de Halloween!', 0);
-- 8356 Saca músculo a cambio de almendrados
-- https://es.classic.wowhead.com/quest=8356
SET @ID := 8356;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Saca músculos para la tabernera Allison', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
UPDATE `quest_offer_reward_locale` SET `RewardText` = '¡Ja, ja, eres muy $gpoderoso:poderosa;! Bien hecho, gracias por tener tan buen talante. Aquí tienes tus caramelos.$B$B¡Feliz Halloween, $n!', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
-- 8357 Bailando por mazapanes
-- https://es.classic.wowhead.com/quest=8357
SET @ID := 8357;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Baila para la tabernera Saelienne', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sabes bailar, ¿no? Intenta poner tu pie derecho adentro... luego tu pie derecho afuera... tu pie derecho adentro... sacúdelo todo...', 0),
(@ID, 'esMX', 'Sabes bailar, ¿no? Intenta poner tu pie derecho adentro... luego tu pie derecho afuera... tu pie derecho adentro... sacúdelo todo...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Vaya, $n! ¡Eres $gun bailarín nato:una bailarina nata;!$B$BAquí tienes tu recompensa por haber participado. ¡Feliz Halloween! ¡Saluda a tu amiguito enfermo! Espero que se recupere pronto.', 0),
(@ID, 'esMX', '¡Vaya, $n! ¡Eres $gun bailarín nato:una bailarina nata;!$B$BAquí tienes tu recompensa por haber participado. ¡Feliz Halloween! ¡Saluda a tu amiguito enfermo! Espero que se recupere pronto.', 0);
-- 8358 ¡Truco o trato!
-- https://es.classic.wowhead.com/quest=8358
SET @ID := 8358;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Haz el tren para Kali Remik', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Bueno, adelante ahora...', 0),
(@ID, 'esMX', 'Bueno, adelante ahora...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Chú, chú! ¡Bien hecho, $n! Aquí tienes tu premio.$B$B¡Feliz día de Halloween!', 0),
(@ID, 'esMX', '¡Chú, chú! ¡Bien hecho, $n! Aquí tienes tu premio.$B$B¡Feliz día de Halloween!', 0);
-- 8359 Saca músculo a cambio de almendrados
-- https://es.classic.wowhead.com/quest=8359
SET @ID := 8359;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Saca músculo para la tabernera Gryshka', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Nada de dulces hasta que saques músculo para mí, $n...', 0),
(@ID, 'esMX', 'Nada de dulces hasta que saques músculo para mí, $n...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Ja, ja, eres muy $gpoderoso:poderosa;! Bien hecho, gracias por tener tan buen talante. Aquí tienes tus caramelos.$B$B¡Feliz Halloween, $n!', 0),
(@ID, 'esMX', '¡Ja, ja, eres muy $gpoderoso:poderosa;! Bien hecho, gracias por tener tan buen talante. Aquí tienes tus caramelos.$B$B¡Feliz Halloween, $n!', 0);
-- 8360 Bailando por mazapanes
-- https://es.classic.wowhead.com/quest=8360
SET @ID := 8360;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Baila para la tabernera Pala', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sabes bailar, ¿no? Intenta poner tu pie derecho adentro... luego tu pie derecho afuera... tu pie derecho adentro... sacúdelo todo...', 0),
(@ID, 'esMX', 'Sabes bailar, ¿no? Intenta poner tu pie derecho adentro... luego tu pie derecho afuera... tu pie derecho adentro... sacúdelo todo...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Vaya, $n! ¡Eres $gun bailarín nato:una bailarina nata;!$B$BAquí tienes tu recompensa por haber participado. ¡Feliz Halloween! ¡Saluda a tu amiguito enfermo! Espero que se recupere pronto.', 0),
(@ID, 'esMX', '¡Vaya, $n! ¡Eres $gun bailarín nato:una bailarina nata;!$B$BAquí tienes tu recompensa por haber participado. ¡Feliz Halloween! ¡Saluda a tu amiguito enfermo! Espero que se recupere pronto.', 0);
-- 8361 Contactos Abisales
-- https://es.classic.wowhead.com/quest=8361
SET @ID := 8361;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Lo has hecho ya?', 0),
(@ID, 'esMX', '¿Lo has hecho ya?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Ja! ¡Lo has conseguido, $n! ¡Pronto aplastaremos al Martillo Crepuscular!', 0),
(@ID, 'esMX', '¡Ja! ¡Lo has conseguido, $n! ¡Pronto aplastaremos al Martillo Crepuscular!', 0);
-- 8362 Blasones Abisales
-- https://es.classic.wowhead.com/quest=8362
SET @ID := 8362;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Has demostrado que puedes manejarte $gsolo:sola; en una pelea, $n. Mantengamos la presión sobre el Martillo Crepuscular. Ve a luchar contra algunos templarios abisales más, te recompensaré con algunas de las cosas que Huum y yo hemos encontrado en la batalla.', 0),
(@ID, 'esMX', 'Has demostrado que puedes manejarte $gsolo:sola; en una pelea, $n. Mantengamos la presión sobre el Martillo Crepuscular. Ve a luchar contra algunos templarios abisales más, te recompensaré con algunas de las cosas que Huum y yo hemos encontrado en la batalla.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo has hecho bien! Eso es menos Templarios de los que preocuparme.$B$BAquí tienes, $n. Espero que haya algo útil para ti.', 0),
(@ID, 'esMX', '¡Lo has hecho bien! Eso es menos Templarios de los que preocuparme.$B$BAquí tienes, $n. Espero que haya algo útil para ti.', 0);
-- 8363 Sellos abisales
-- https://es.classic.wowhead.com/quest=8363
SET @ID := 8363;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Has demostrado que eres más que capaz de enfrentarte a un Duque Abisal, $n. Siempre soy de los que promueven los buenos hábitos. Tráeme más sellos y te daré una recompensa.', 0),
(@ID, 'esMX', 'Has demostrado que eres más que capaz de enfrentarte a un Duque Abisal, $n. Siempre soy de los que promueven los buenos hábitos. Tráeme más sellos y te daré una recompensa.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente, $n! Derrotar a esos duques dejará al Martillo Crepuscular tambaleándose por un tiempo. Como prometí, aquí tienes tu recompensa. Es una de las mejores cosas que Huum y yo hemos encontrado.', 0),
(@ID, 'esMX', '¡Excelente, $n! Derrotar a esos duques dejará al Martillo Crepuscular tambaleándose por un tiempo. Como prometí, aquí tienes tu recompensa. Es una de las mejores cosas que Huum y yo hemos encontrado.', 0);
-- 8364 Cetros Abisales
-- https://es.classic.wowhead.com/quest=8364
SET @ID := 8364;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Realmente has superado todas mis expectativas, $n. Has estado enfrentándote a oponentes que Huum y yo nos lo pensaríamos mucho antes de enfrentarnos.$B$BEn este punto, lo mejor que puedo hacer es seguir recompensando tus esfuerzos en la lucha contra el Martillo Crepuscular y sus amos.$B$BTráeme más cetros abisales y haré todo lo posible para darte una recompensa adecuada.', 0),
(@ID, 'esMX', 'Realmente has superado todas mis expectativas, $n. Has estado enfrentándote a oponentes que Huum y yo nos lo pensaríamos mucho antes de enfrentarnos.$B$BEn este punto, lo mejor que puedo hacer es seguir recompensando tus esfuerzos en la lucha contra el Martillo Crepuscular y sus amos.$B$BTráeme más cetros abisales y haré todo lo posible para darte una recompensa adecuada.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Sabía que vendrías, $n! Aquí tienes tu recompensa.', 0),
(@ID, 'esMX', '¡Sabía que vendrías, $n! Aquí tienes tu recompensa.', 0);
-- Cuestión de honor
-- 8367, 13476
-- https://es.classic.wowhead.com/quest=8367
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8367, 13476) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8367, 'esES', 'Arathi todavía está empapada con la sangre de grandes guerreros y el choque del acero aún resuena en todo Alterac. ¡No pierdas mi tiempo a menos que traigas noticias del frente!', 0),
(13476, 'esES', 'Arathi todavía está empapada con la sangre de grandes guerreros y el choque del acero aún resuena en todo Alterac. ¡No pierdas mi tiempo a menos que traigas noticias del frente!', 0),
(8367, 'esMX', 'Arathi todavía está empapada con la sangre de grandes guerreros y el choque del acero aún resuena en todo Alterac. ¡No pierdas mi tiempo a menos que traigas noticias del frente!', 0),
(13476, 'esMX', 'Arathi todavía está empapada con la sangre de grandes guerreros y el choque del acero aún resuena en todo Alterac. ¡No pierdas mi tiempo a menos que traigas noticias del frente!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8367, 13476) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8367, 'esES', 'Tus pruebas no han sido fáciles, pero tu valor no se te escapó y tus fuerzas no fallaron. Parte con marcas de victoria anteriores, $n. Nadie los necesitará como recordatorio de su valía. Ponte de pie, $n. ¡Hoy caminarás con mucho orgullo porque eres $gun héroe:una heroína;!', 0),
(13476, 'esES', 'Tus pruebas no han sido fáciles, pero tu valor no se te escapó y tus fuerzas no fallaron. Parte con marcas de victoria anteriores, $n. Nadie los necesitará como recordatorio de su valía. Ponte de pie, $n. ¡Hoy caminarás con mucho orgullo porque eres $gun héroe:una heroína;!', 0),
(8367, 'esMX', 'Tus pruebas no han sido fáciles, pero tu valor no se te escapó y tus fuerzas no fallaron. Parte con marcas de victoria anteriores, $n. Nadie los necesitará como recordatorio de su valía. Ponte de pie, $n. ¡Hoy caminarás con mucho orgullo porque eres $gun héroe:una heroína;!', 0),
(13476, 'esMX', 'Tus pruebas no han sido fáciles, pero tu valor no se te escapó y tus fuerzas no fallaron. Parte con marcas de victoria anteriores, $n. Nadie los necesitará como recordatorio de su valía. Ponte de pie, $n. ¡Hoy caminarás con mucho orgullo porque eres $gun héroe:una heroína;!', 0);
-- La batalla por Garganta Grito de Guerra
-- 8368, 8389, 8426, 8427, 8428, 8429, 8430, 8431, 8432, 8433, 8434, 8435
-- https://es.classic.wowhead.com/quest=8368
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8368, 8389, 8426, 8427, 8428, 8429, 8430, 8431, 8432, 8433, 8434, 8435) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8368, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8389, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8426, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8427, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8428, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8429, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8430, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8431, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8432, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8433, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8434, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8435, 'esES', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8368, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8389, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8426, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8427, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8428, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8429, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8430, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8431, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8432, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8433, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8434, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0),
(8435, 'esMX', 'La batalla de la Garganta Grito de Guerra contra las centinelas Ala de Plata tiene una importancia vital. Con la excusa de estar protegiendo un bosque que no les pertenece, la Alianza intenta negar a la Horda una de sus principales fuentes de recursos madereros.$B$B¡No debemos permitirlo, $n! ¡Vuelve a verme cuando puedas demostrar que has servido a la Horda dignamente!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8368, 8389, 8426, 8427, 8428, 8429, 8430, 8431, 8432, 8433, 8434, 8435) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8368, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8389, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8426, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8427, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8428, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8429, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8430, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8431, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8432, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8433, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8434, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8435, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8368, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8389, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8426, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8427, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8428, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8429, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8430, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8431, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8432, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8433, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8434, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(8435, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0);
-- 8369 Invasores del Valle de Alterac
-- https://es.classic.wowhead.com/quest=8369
SET @ID := 8369;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Qué noticias traes de las tierras de los Lobo Gélido? ¿Qué tal va la batalla por el Valle de Alterac?', 0),
(@ID, 'esMX', '¿Qué noticias traes de las tierras de los Lobo Gélido? ¿Qué tal va la batalla por el Valle de Alterac?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Has mostrado una gran valentía al proteger nuestras tierras del Valle de Alterac! Hablaré a mis superiores de tus hazañas.', 0),
(@ID, 'esMX', '¡Has mostrado una gran valentía al proteger nuestras tierras del Valle de Alterac! Hablaré a mis superiores de tus hazañas.', 0);
-- 8373 El poder del pino
-- https://es.classic.wowhead.com/quest=8373
SET @ID := 8373;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, ya casi huele mejor por aquí. Casi.$B$BGracias a ti, $n, Costa Sur podría pasar por otro Halloween. ¡Aquí están sus golosinas, con mi agradecimiento! Si te quedas sin caramelos, creo que hay una gnoma llamado Katrina Shimmerstar en Forjaz que puede venderte más; ella solo está presente durante Halloween, creo.', 0),
(@ID, 'esMX', 'Ah, ya casi huele mejor por aquí. Casi.$B$BGracias a ti, $n, Costa Sur podría pasar por otro Halloween. ¡Aquí están sus golosinas, con mi agradecimiento! Si te quedas sin caramelos, creo que hay una gnoma llamado Katrina Shimmerstar en Forjaz que puede venderte más; ella solo está presente durante Halloween, creo.', 0);
-- 8375 ¡Recuerda el Valle de Alterac!
-- https://es.classic.wowhead.com/quest=8375
SET @ID := 8375;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Qué noticias traes de las tierras de los Picos Tormentas? ¿Cómo va la batalla por el Valle de Alterac?', 0),
(@ID, 'esMX', '¿Qué noticias traes de las tierras de los Picos Tormentas? ¿Cómo va la batalla por el Valle de Alterac?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Has demostrado una gran valentía al proteger nuestras tierras en el Valle de Alterac! Les contaré a mis superiores tus actos.', 0),
(@ID, 'esMX', '¡Has demostrado una gran valentía al proteger nuestras tierras en el Valle de Alterac! Les contaré a mis superiores tus actos.', 0);
-- 8383 ¡Recuerda el Valle de Alterac!
-- https://es.classic.wowhead.com/quest=8383
SET @ID := 8383;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sigue honrando a la Alianza, $n. La Horda no tardará mucho en ser aplastada si seguimos adelante con nuestros esfuerzos.', 0),
(@ID, 'esMX', 'Sigue honrando a la Alianza, $n. La Horda no tardará mucho en ser aplastada si seguimos adelante con nuestros esfuerzos.', 0);
-- 8386 Lucha por Garganta Grito de Guerra
-- https://es.classic.wowhead.com/quest=8386
SET @ID := 8386;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes noticias de Garganta Grito de Guerra, $n?', 0),
(@ID, 'esMX', '¿Tienes noticias de Garganta Grito de Guerra, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0),
(@ID, 'esMX', '¡Excelente! ¡Has demostrado tu valía defendiendo nuestras operaciones en Garganta Grito de Guerra! Que la palabra de tu honor se extienda por todas partes en nuestras tierras.', 0);
-- 8387 Invasores del Valle de Alterac
-- https://es.classic.wowhead.com/quest=8387
SET @ID := 8387;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡La batalla por Alterac sigue ardiendo! ¡Debes volver al Valle de Alterac y expulsar una vez más a los invasores del territorio de Lobo Gélido, $n!', 0),
(@ID, 'esMX', '¡La batalla por Alterac sigue ardiendo! ¡Debes volver al Valle de Alterac y expulsar una vez más a los invasores del territorio de Lobo Gélido, $n!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Buen trabajo, $n! Deberías sentirte $gorgulloso:orgullosa;. ¡Los invasores de la Alianza deben ser expulsados de Alterac!', 0),
(@ID, 'esMX', '¡Buen trabajo, $n! Deberías sentirte $gorgulloso:orgullosa;. ¡Los invasores de la Alianza deben ser expulsados de Alterac!', 0);
-- 8388 Cuestión de honor
-- https://es.classic.wowhead.com/quest=8388
SET @ID := 8388;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muchos valientes guerreros te admiran, $n. Sigue siendo un ejemplo para todos los que luchan contra la Alianza. ¿Qué noticias traes de tus viajes?', 0),
(@ID, 'esMX', 'Muchos valientes guerreros te admiran, $n. Sigue siendo un ejemplo para todos los que luchan contra la Alianza. ¿Qué noticias traes de tus viajes?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sigue honrando a la Horda, $n. Es un placer comprobar que no te has debilitado.', 0),
(@ID, 'esMX', 'Sigue honrando a la Horda, $n. Es un placer comprobar que no te has debilitado.', 0);
-- 8409 Los barriles dañados
-- https://es.classic.wowhead.com/quest=8409
SET @ID := 8409;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Ah, bien! Has mostrado el verdadero espíritu de Halloween, ¡espíritu Renegado, debería decir!$B$B<La clamasombras Yanka se ríe y se frota las manos.>$B$BMe deleito en el hecho de que Costa Sur ahora debe darse un festín con cerveza mala o prescindir de ella. En cuanto a ti, toma estas golosinas. ¡Creo que les encontrarás un buen uso!', 0),
(@ID, 'esMX', '¡Ah, bien! Has mostrado el verdadero espíritu de Halloween, ¡espíritu Renegado, debería decir!$B$B<La clamasombras Yanka se ríe y se frota las manos.>$B$BMe deleito en el hecho de que Costa Sur ahora debe darse un festín con cerveza mala o prescindir de ella. En cuanto a ti, toma estas golosinas. ¡Creo que les encontrarás un buen uso!', 0);
-- 8410 Maestría elemental
-- https://es.classic.wowhead.com/quest=8410
SET @ID := 8410;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Qué tienes para mí, $n?', 0),
(@ID, 'esMX', '¿Qué tienes para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente, colega. Ahora nos entendemos.', 0),
(@ID, 'esMX', 'Excelente, colega. Ahora nos entendemos.', 0);
-- 8411 Dominar los elementos
-- https://es.classic.wowhead.com/quest=8411
SET @ID := 8411;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Dónde están los elementos, colega?', 0),
(@ID, 'esMX', '¿Dónde están los elementos, colega?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estos son los elementos que necesito. Ahora hablamos.', 0),
(@ID, 'esMX', 'Estos son los elementos que necesito. Ahora hablamos.', 0);
-- 8412 Tótem de espíritu
-- https://es.classic.wowhead.com/quest=8412
SET @ID := 8412;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Los espíritus saben lo que estamos haciendo y han estado tratando de matarme! Espero que tengas las piezas.', 0),
(@ID, 'esMX', '¡Los espíritus saben lo que estamos haciendo y han estado tratando de matarme! Espero que tengas las piezas.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Genial, colega! Probémoslo...', 0),
(@ID, 'esMX', '¡Genial, colega! Probémoslo...', 0);
-- 8413 Vudú
-- Notice: English text: Change '$R' to 'troll' in quest_offer_reward.RewardText
-- https://es.classic.wowhead.com/quest=8413
SET @ID := 8413;
UPDATE `quest_offer_reward` SET `RewardText` = 'It\'s about time this troll got a full night\'s rest! The spirit totem will watch over me.$B$BI been a long time collectin\' things, maybe you want somethin\' for all your trouble?', `VerifiedBuild` = 0 WHERE `id` = @ID ;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Dónde están las plumas, colega?', 0),
(@ID, 'esMX', '¿Dónde están las plumas, colega?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Ya es hora de que este trol descanse toda la noche! El tótem espiritual velará por mí.$B$BLlevo mucho tiempo coleccionando cosas, ¿tal vez quieres algo por todos tus problemas?', 0),
(@ID, 'esMX', '¡Ya es hora de que este trol descanse toda la noche! El tótem espiritual velará por mí.$B$BLlevo mucho tiempo coleccionando cosas, ¿tal vez quieres algo por todos tus problemas?', 0);
-- 8414 Expulsión de los demonios
-- https://es.classic.wowhead.com/quest=8414
SET @ID := 8414;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Qué mal me has traído?', 0),
(@ID, 'esMX', '¿Qué mal me has traído?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Existe el riesgo de disipar el mal de un azote, ya que atrae la atención de los muertos vivientes a lo largo de incontables millas. Pero eres fuerte en la Luz, $n, y no temo por ti...', 0),
(@ID, 'esMX', 'Existe el riesgo de disipar el mal de un azote, ya que atrae la atención de los muertos vivientes a lo largo de incontables millas. Pero eres fuerte en la Luz, $n, y no temo por ti...', 0);
-- 8415 Campamento del Orvallo
-- https://es.classic.wowhead.com/quest=8415
SET @ID := 8415;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Muy bien, $n! Veamos de qué estás $ghecho:hecha;.', 0),
(@ID, 'esMX', '¡Muy bien, $n! Veamos de qué estás $ghecho:hecha;.', 0);
-- 8416 Piedras de la Plaga inertes
-- https://es.classic.wowhead.com/quest=8416
SET @ID := 8416;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Pudo Thal\'danis limpiar las piedras de la plaga?', 0),
(@ID, 'esMX', '¿Pudo Thal\'danis limpiar las piedras de la plaga?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Has hecho lo que te pedí sin dudarlo, $n.$B$BLa confianza se gana, parece. Quizás ahora pueda revelarte nuestro plan con más detalle.', 0),
(@ID, 'esMX', 'Has hecho lo que te pedí sin dudarlo, $n.$B$BLa confianza se gana, parece. Quizás ahora pueda revelarte nuestro plan con más detalle.', 0);
-- 8417 Un espíritu afligido
-- https://es.classic.wowhead.com/quest=8417
SET @ID := 8417;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Stoley tosió mi alcohol?', 0),
(@ID, 'esMX', '¿Stoley tosió mi alcohol?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Entonces, has venido a aliviar mi dolor. Ojalá pudieras simplemente derribarme, pero no es tan simple...', 0),
(@ID, 'esMX', 'Entonces, has venido a aliviar mi dolor. Ojalá pudieras simplemente derribarme, pero no es tan simple...', 0);
-- 8418 La forja de la piedra de poderío
-- https://es.classic.wowhead.com/quest=8418
SET @ID := 8418;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has matado a los desgraciados trols?', 0),
(@ID, 'esMX', '¿Has matado a los desgraciados trols?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Esto es excelente, $n. Diría que estoy sorprendido, pero sabía sin lugar a dudas que no nos decepcionarías.$B$BEs un honor para mí concederte una de las Sagradas Piedras de Poder. Úsala bien.', 0),
(@ID, 'esMX', 'Esto es excelente, $n. Diría que estoy sorprendido, pero sabía sin lugar a dudas que no nos decepcionarías.$B$BEs un honor para mí concederte una de las Sagradas Piedras de Poder. Úsala bien.', 0);
-- 8419 Pedido de un diablillo
-- https://es.classic.wowhead.com/quest=8419
SET @ID := 8419;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes mi tela vil?', 0),
(@ID, 'esMX', '¿Tienes mi tela vil?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Qué $gespléndido:espléndida; $n eres!$B$B<Impsy se lleva la tela vil a la cara.>$B$BOh, cómo me encanta sentirlo, la forma en que quema tu piel y teje pensamientos malvados en la mente...', 0),
(@ID, 'esMX', '¡Qué $gespléndido:espléndida; $n eres!$B$B<Impsy se lleva la tela vil a la cara.>$B$BOh, cómo me encanta sentirlo, la forma en que quema tu piel y teje pensamientos malvados en la mente...', 0);

-- 8420 Caliente y picante
-- https://es.classic.wowhead.com/quest=8420
SET @ID := 8420;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes mi tela vil?', 0),
(@ID, 'esMX', '¿Tienes mi tela vil?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Guau! Eres demasiado $gbueno:buena;. ¡Especialmente para $gun:una; $n! $B$B<Impsy se lleva la tela vil a la cara.>$B$BOh, cómo me encanta sentirlo, la forma en que quema tu piel y teje pensamientos malvados en la mente...', 0),
(@ID, 'esMX', '¡Guau! Eres demasiado $gbueno:buena;. ¡Especialmente para $gun:una; $n! $B$B<Impsy se lleva la tela vil a la cara.>$B$BOh, cómo me encanta sentirlo, la forma en que quema tu piel y teje pensamientos malvados en la mente...', 0);
-- 8421 La mercancía equivocada
-- https://es.classic.wowhead.com/quest=8421
SET @ID := 8421;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes los bienes?', 0),
(@ID, 'esMX', '¿Tienes los bienes?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Esto funcionará muy bien.', 0),
(@ID, 'esMX', 'Esto funcionará muy bien.', 0);
-- 8422 Plumas de trol
-- https://es.classic.wowhead.com/quest=8422
SET @ID := 8422;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Trajiste las plumas? ¡Esta muñeca necesita ser rellenada!', 0),
(@ID, 'esMX', '¿Trajiste las plumas? ¡Esta muñeca necesita ser rellenada!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Maravilloso, ahora mi mascota está completa!$B$B<Impsy rápidamente mete la muñeca y le da un abrazo demoníaco.>$B$BOh, qué efecto secundario tan extraño tienen estas plumas de vudú...', 0),
(@ID, 'esMX', '¡Maravilloso, ahora mi mascota está completa!$B$B<Impsy rápidamente mete la muñeca y le da un abrazo demoníaco.>$B$BOh, qué efecto secundario tan extraño tienen estas plumas de vudú...', 0);
-- 8423 Parentesco guerrero
-- https://es.classic.wowhead.com/quest=8423
SET @ID := 8423;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Las espinas ardientes del jabinferno dejan horribles cicatrices. No temas el dolor y la desfiguración, $gguerrero:guerrera;, no son nada comparados con la prisión a la que estoy encadenado.', 0),
(@ID, 'esMX', 'Las espinas ardientes del jabinferno dejan horribles cicatrices. No temas el dolor y la desfiguración, $gguerrero:guerrera;, no son nada comparados con la prisión a la que estoy encadenado.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No necesito pruebas para saber lo que ha hecho, $n. Puedo ver la determinación grabada en tu expresión.', 0),
(@ID, 'esMX', 'No necesito pruebas para saber lo que ha hecho, $n. Puedo ver la determinación grabada en tu expresión.', 0);
-- 8424 La guerra contra los Sombra Jurada
-- https://es.classic.wowhead.com/quest=8424
SET @ID := 8424;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los Sombra Jurada no son derrotados fácilmente, ¿verdad? Pero eres $gun guerrero:una guerrera; y triunfarás o perecerás en el intento.', 0),
(@ID, 'esMX', 'Los Sombra Jurada no son derrotados fácilmente, ¿verdad? Pero eres $gun guerrero:una guerrera; y triunfarás o perecerás en el intento.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ya has mitigado mi dolor y me has honrado. Gracias, $n.', 0),
(@ID, 'esMX', 'Ya has mitigado mi dolor y me has honrado. Gracias, $n.', 0);
-- 8425 Plumas Vudú
-- https://es.classic.wowhead.com/quest=8425
SET @ID := 8425;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Estás de regreso tan pronto? El tiempo ya no es el mismo para mí, quizás haya sido un largo viaje para ti...', 0),
(@ID, 'esMX', '¿Estás de regreso tan pronto? El tiempo ya no es el mismo para mí, quizás haya sido un largo viaje para ti...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Por fin puedo volver a sentir el frío toque del acero, aunque sea sólo por un momento.', 0),
(@ID, 'esMX', 'Por fin puedo volver a sentir el frío toque del acero, aunque sea sólo por un momento.', 0);
-- 8446 Inundación de Pesadilla
-- https://es.classic.wowhead.com/quest=8446
SET @ID := 8446;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Sí, $r?', 0),
(@ID, 'esMX', '¿Sí, $r?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Debo eliminar la mancha de este objeto. Esto puede arrojar algo de luz sobre mis recientes fracasos para profundizar en el Sueño. Dámelo.', 0),
(@ID, 'esMX', 'Debo eliminar la mancha de este objeto. Esto puede arrojar algo de luz sobre mis recientes fracasos para profundizar en el Sueño. Dámelo.', 0);
-- 8447 Leyendas veraces
-- https://es.classic.wowhead.com/quest=8447
SET @ID := 8447;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Toma el anillo, $n. Ha cumplido su propósito para Malfurion. Ahora te servirá para un nuevo propósito...', 0),
(@ID, 'esMX', 'Toma el anillo, $n. Ha cumplido su propósito para Malfurion. Ahora te servirá para un nuevo propósito...', 0);
-- 8470 El tótem de ritual Muertobosque
-- https://es.classic.wowhead.com/quest=8470
SET @ID := 8470;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Dime, $c, ¿en qué puedo ayudarte? Caminas entre nosotros pacíficamente, pero no cabe duda de que ocurre algo. Percibo algo... algo perturbador...', 0),
(@ID, 'esMX', 'Dime, $c, ¿en qué puedo ayudarte? Caminas entre nosotros pacíficamente, pero no cabe duda de que ocurre algo. Percibo algo... algo perturbador...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Este tótem... Lo reconozco... es de los Muertobosque, pero está tan degradado... Cualquier fiebre que haya vuelto a nuestros hermanos en nuestra contra, está sin duda impregnada también en este objeto.$B$BHas hecho bien en traérnoslo, $n. Quizás con algunos rituales y mucho estudio, consigamos descubrir qué contamina las mentes de nuestros hermanos. Gracias. Acepta estas ofrendas a cambio de tu hallazgo.', 0),
(@ID, 'esMX', 'Este tótem... Lo reconozco... es de los Muertobosque, pero está tan degradado... Cualquier fiebre que haya vuelto a nuestros hermanos en nuestra contra, está sin duda impregnada también en este objeto.$B$BHas hecho bien en traérnoslo, $n. Quizás con algunos rituales y mucho estudio, consigamos descubrir qué contamina las mentes de nuestros hermanos. Gracias. Acepta estas ofrendas a cambio de tu hallazgo.', 0);
-- 8471 Tótem de ritual Nevada
-- https://es.classic.wowhead.com/quest=8471
SET @ID := 8471;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c, vienes a nosotros de forma pacífica pero tengo la sensación de que te atañen asuntos graves y muy importantes tanto para un fúrbolg como para $gun:una; $r. ¿Qué has venido a decirnos?', 0),
(@ID, 'esMX', '$c, vienes a nosotros de forma pacífica pero tengo la sensación de que te atañen asuntos graves y muy importantes tanto para un fúrbolg como para $gun:una; $r. ¿Qué has venido a decirnos?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Esto... tiene la forma de un tótem ritual Nevada, pero está deformado por fuerzas que no puedo ni empezar a comprender. Sea cual sea el mal y la corrupción que ha puesto a los Nevada contra nosotros, está presente en este objeto, no hay duda.$B$BEl saber divino es el que os ha traído a ti y a este objeto a nosotros, $n. Lo estudiaremos detenidamente, quizás un día los Nevada dejen de dirigir su ira contra nosotros.$B$BGracias, $gamigo:amiga;, por favor, acepta estos regalos a cambio de toda tu bondad.', 0),
(@ID, 'esMX', 'Esto... tiene la forma de un tótem ritual Nevada, pero está deformado por fuerzas que no puedo ni empezar a comprender. Sea cual sea el mal y la corrupción que ha puesto a los Nevada contra nosotros, está presente en este objeto, no hay duda.$B$BEl saber divino es el que os ha traído a ti y a este objeto a nosotros, $n. Lo estudiaremos detenidamente, quizás un día los Nevada dejen de dirigir su ira contra nosotros.$B$BGracias, $gamigo:amiga;, por favor, acepta estos regalos a cambio de toda tu bondad.', 0);
-- 8474 El colgante del viejo Cortezablanca
-- https://es.wowhead.com/quest=8474
SET @ID := 8474;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo que enseñarme?', 0),
(@ID, 'esMX', '¿Tienes algo que enseñarme?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Este colgante... Se lo regalé al viejo Cortezablanca cuando su gente nos ayudó a reconstruir el poblado.$B$BSupongo que esto significa que está...$B$B<La elfa de sangre carraspea y recupera la compostura.>$B$BGracias por traerme esto, $n. Quiero pedirte algo.', 0),
(@ID, 'esMX', 'Este colgante... Se lo regalé al viejo Cortezablanca cuando su gente nos ayudó a reconstruir el poblado.$B$BSupongo que esto significa que está...$B$B<La elfa de sangre carraspea y recupera la compostura.>$B$BGracias por traerme esto, $n. Quiero pedirte algo.', 0);
-- 8480 El armamento perdido
-- https://es.wowhead.com/quest=8480
SET @ID := 8480;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Traes las armas?', 0),
(@ID, 'esMX', '¿Traes las armas?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo, $n. ¡Les vamos a enseñar a los desdichados de qué estamos hechos!', 0),
(@ID, 'esMX', 'Excelente trabajo, $n. ¡Les vamos a enseñar a los desdichados de qué estamos hechos!', 0);
-- 8481 La raíz de todos los males
-- https://es.wowhead.com/quest=8481
SET @ID := 8481;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Has vuelto, $n... ¿Eso quiere decir que has matado al demonio?', 0),
(@ID, 'esMX', 'Has vuelto, $n... ¿Eso quiere decir que has matado al demonio?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tú... ¡nos has salvado! Al haber derrotado al demonio Xandivious has garantizado la seguridad del Bastión Fauces de Madera durante los próximos años. Eres $gun auténtico héroe:una auténtica heroína; para nosotros.$B$BPor favor, acepta esto con nuestra bendición. Aunque el proceso de curación de los fúrbolgs será lento, y a pesar de que el conflicto todavía persista, les has dado a los Nevada algo que hasta ahora no tenían.$B$BLes has dado la oportunidad de sobrevivir.', 0),
(@ID, 'esMX', 'Tú... ¡nos has salvado! Al haber derrotado al demonio Xandivious has garantizado la seguridad del Bastión Fauces de Madera durante los próximos años. Eres $gun auténtico héroe:una auténtica heroína; para nosotros.$B$BPor favor, acepta esto con nuestra bendición. Aunque el proceso de curación de los fúrbolgs será lento, y a pesar de que el conflicto todavía persista, les has dado a los Nevada algo que hasta ahora no tenían.$B$BLes has dado la oportunidad de sobrevivir.', 0);
-- 8484 Negociar la paz
-- https://es.classic.wowhead.com/quest=8484
SET @ID := 8484;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$n, eres $gbienvenido:bienvenida; en mis dominios. Forjaz siempre debe considerarse el hogar de $gun héroe:una heroína; como tú. Ahora, ¿qué negocios tienes conmigo?', 0),
(@ID, 'esMX', '$n, eres $gbienvenido:bienvenida; en mis dominios. Forjaz siempre debe considerarse el hogar de $gun héroe:una heroína; como tú. Ahora, ¿qué negocios tienes conmigo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De hecho, este es un giro de los acontecimientos sumamente fortuito. Si se lograra una paz duradera con estas criaturas, esto sin duda nos daría una ventaja en los asuntos de Kalimdor... una que los Elfos Nocturnos no pueden mantener por sí mismos. ¡Notificaré esto a los otros líderes de la Alianza de inmediato y se enviarán más diplomáticos!$B$BEn cuanto a ti, $n... has demostrado valentía tanto en la diplomacia como en la acción. Te doy las gracias, al igual que toda la Alianza.', 0),
(@ID, 'esMX', 'De hecho, este es un giro de los acontecimientos sumamente fortuito. Si se lograra una paz duradera con estas criaturas, esto sin duda nos daría una ventaja en los asuntos de Kalimdor... una que los Elfos Nocturnos no pueden mantener por sí mismos. ¡Notificaré esto a los otros líderes de la Alianza de inmediato y se enviarán más diplomáticos!$B$BEn cuanto a ti, $n... has demostrado valentía tanto en la diplomacia como en la acción. Te doy las gracias, al igual que toda la Alianza.', 0);
-- 8485 Negociar la paz
-- https://es.classic.wowhead.com/quest=8485
SET @ID := 8485;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los saludos del Jefe de Guerra te son otorgados, $n. Tus acciones hacen que la Horda se fortalezca en estos tiempos difíciles. Ahora, ¿qué negocios tienes conmigo?', 0),
(@ID, 'esMX', 'Los saludos del Jefe de Guerra te son otorgados, $n. Tus acciones hacen que la Horda se fortalezca en estos tiempos difíciles. Ahora, ¿qué negocios tienes conmigo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'De hecho, este es un giro de los acontecimientos sumamente fortuito. Si se lograra una paz duradera con estas criaturas, esto ciertamente nos daría una ventaja para proteger a Kalimdor de amenazas externas. Notificaré esto a los otros líderes de la Horda de inmediato y se enviarán más diplomáticos.$B$BEn cuanto a ti, $n... has demostrado valentía tanto en la diplomacia como en la acción. Te doy las gracias, al igual que toda la Horda.', 0),
(@ID, 'esMX', 'De hecho, este es un giro de los acontecimientos sumamente fortuito. Si se lograra una paz duradera con estas criaturas, esto ciertamente nos daría una ventaja para proteger a Kalimdor de amenazas externas. Notificaré esto a los otros líderes de la Horda de inmediato y se enviarán más diplomáticos.$B$BEn cuanto a ti, $n... has demostrado valentía tanto en la diplomacia como en la acción. Te doy las gracias, al igual que toda la Horda.', 0);
-- 8492 ¡La Alianza necesita lingotes de cobre!
-- https://es.classic.wowhead.com/quest=8492
SET @ID := 8492;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has reunido ya esos 20 lingotes de cobre, soldado?', 0),
(@ID, 'esMX', '¿Has reunido ya esos 20 lingotes de cobre, soldado?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo lograste, $gchico:chica;! Pondremos esos lingotes de cobre en la pila y le sacaremos provecho para el material de guerra ahora mismo. Es la entrega de gente como tú lo que me hace sentirme orgulloso de servir a la Alianza. ¡Buen trabajo, soldado!$B$BY si por casualidad te encontraras con más lingotes de cobre, asegúrate de que llegan hasta mí.', 0),
(@ID, 'esMX', '¡Lo lograste, $gchico:chica;! Pondremos esos lingotes de cobre en la pila y le sacaremos provecho para el material de guerra ahora mismo. Es la entrega de gente como tú lo que me hace sentirme orgulloso de servir a la Alianza. ¡Buen trabajo, soldado!$B$BY si por casualidad te encontraras con más lingotes de cobre, asegúrate de que llegan hasta mí.', 0);
-- 8493 ¡La Alianza necesita más lingotes de cobre!
-- https://es.classic.wowhead.com/quest=8493
SET @ID := 8493;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Otra vez aquí, $c? ¡Fantástico! Los lingotes que nos has conseguido hasta ahora serán muy útiles para confeccionar todo tipo de cosas para la guerra. Sé que, entre otras cosas, el cobre se usará en piezas para los tanques de vapor en construcción, además de para una reducida flota de girocópteros que queremos desplegar si el tiempo lo permite.$B$BPero que estas pilas no te engañen, necesitamos aún más pilas de lingotes de cobre si puedes conseguirlas para preparar la guerra de Ahn\'Qiraj. ¿Nos ayudarás?', 0),
(@ID, 'esMX', '¿Otra vez aquí, $c? ¡Fantástico! Los lingotes que nos has conseguido hasta ahora serán muy útiles para confeccionar todo tipo de cosas para la guerra. Sé que, entre otras cosas, el cobre se usará en piezas para los tanques de vapor en construcción, además de para una reducida flota de girocópteros que queremos desplegar si el tiempo lo permite.$B$BPero que estas pilas no te engañen, necesitamos aún más pilas de lingotes de cobre si puedes conseguirlas para preparar la guerra de Ahn\'Qiraj. ¿Nos ayudarás?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente trabajo! Cavar en busca de ese cobre y fundirlo debe de haber sido toda una aventura. A menos que lo compraras en la casa de subastas. De cualquier modo, a mí me va bien. Recibirás toda clase de elogios por tu contribución a los preparativos para la guerra, $c. Y no dudes en traerme más lingotes de cobre si los tienes.', 0),
(@ID, 'esMX', '¡Excelente trabajo! Cavar en busca de ese cobre y fundirlo debe de haber sido toda una aventura. A menos que lo compraras en la casa de subastas. De cualquier modo, a mí me va bien. Recibirás toda clase de elogios por tu contribución a los preparativos para la guerra, $c. Y no dudes en traerme más lingotes de cobre si los tienes.', 0);
-- 8494 ¡La Alianza necesita barras de hierro!
-- https://es.classic.wowhead.com/quest=8494
SET @ID := 8494;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si tienes esas veinte barras de hierro, ¡no quiero saber dónde las tienes escondidas!', 0),
(@ID, 'esMX', 'Si tienes esas veinte barras de hierro, ¡no quiero saber dónde las tienes escondidas!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Bueno, bueno, si es $n. Y saliste adelante. Supongo que ahora tendré que estar pendiente de ti. Me duele decir esto, pero gracias por tus esfuerzos. La Alianza no lo olvidará, y yo tampoco. Ahora sal y empápate de cualquier otra cosa que necesites recolectar.', 0),
(@ID, 'esMX', 'Bueno, bueno, si es $n. Y saliste adelante. Supongo que ahora tendré que estar pendiente de ti. Me duele decir esto, pero gracias por tus esfuerzos. La Alianza no lo olvidará, y yo tampoco. Ahora sal y empápate de cualquier otra cosa que necesites recolectar.', 0);
-- 8495 ¡La Alianza necesita más barras de hierro!
-- https://es.classic.wowhead.com/quest=8495
SET @ID := 8495;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Ya has vuelto? ¿Así pretendes conseguir que mejore la opinión que tengo de ti, $c? ¡Es que se me saltan las lágrimas! Así que, como verás, aún no tenemos suficientes barras de hierro para todas las armas, armaduras, tanques de vapor y demás chismes que hay que construir para la caza de bichos. ¿Crees que podrás hacer un hueco para traer otra pila de 20 barras de hierro entre un garbeo y otro a Zul\'Gurub, o adondequiera que vayan los jóvenes de hoy en día?', 0),
(@ID, 'esMX', '¿Ya has vuelto? ¿Así pretendes conseguir que mejore la opinión que tengo de ti, $c? ¡Es que se me saltan las lágrimas! Así que, como verás, aún no tenemos suficientes barras de hierro para todas las armas, armaduras, tanques de vapor y demás chismes que hay que construir para la caza de bichos. ¿Crees que podrás hacer un hueco para traer otra pila de 20 barras de hierro entre un garbeo y otro a Zul\'Gurub, o adondequiera que vayan los jóvenes de hoy en día?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Debe ser un día frío en las Estepas Ardientes. Mira, es $n y me ha traído un regalo. ¡Veinte barras de hierro! Justo lo que siempre quise.$B$BSin embargo, con toda seriedad, gracias, $n. Te acreditas a ti y a toda la Alianza. ¡Ahora regresa y trae más cosas para el esfuerzo de guerra!', 0),
(@ID, 'esMX', 'Debe ser un día frío en las Estepas Ardientes. Mira, es $n y me ha traído un regalo. ¡Veinte barras de hierro! Justo lo que siempre quise.$B$BSin embargo, con toda seriedad, gracias, $n. Te acreditas a ti y a toda la Alianza. ¡Ahora regresa y trae más cosas para el esfuerzo de guerra!', 0);
-- Vendas para el campo de batalla
-- 8496, 8810
-- https://es.classic.wowhead.com/quest=8496
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8496, 8810) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8496, 'esES', '¿Tienes algo para mí, $n?', 0),
(8810, 'esES', '¿Tienes algo para mí, $n?', 0),
(8496, 'esMX', '¿Tienes algo para mí, $n?', 0),
(8810, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8496, 8810) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8496, 'esES', 'Justo a tiempo. Estos suministros salvarán vidas, $n. Se agradece tu trabajo. Aquí está tu próxima tarea.', 0),
(8810, 'esES', 'Justo a tiempo. Estos suministros salvarán vidas, $n. Se agradece tu trabajo. Aquí está tu próxima tarea.', 0),
(8496, 'esMX', 'Justo a tiempo. Estos suministros salvarán vidas, $n. Se agradece tu trabajo. Aquí está tu próxima tarea.', 0),
(8810, 'esMX', 'Justo a tiempo. Estos suministros salvarán vidas, $n. Se agradece tu trabajo. Aquí está tu próxima tarea.', 0);
-- 8497 Material de supervivencia en el desierto
-- https://es.classic.wowhead.com/quest=8497
SET @ID := 8497;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo para mí, $n?', 0),
(@ID, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! Los necesitábamos, $n. Gracias.', 0),
(@ID, 'esMX', '¡Excelente! Los necesitábamos, $n. Gracias.', 0);
-- 8498 Órdenes de batalla Crepusculares
-- https://es.classic.wowhead.com/quest=8498
SET @ID := 8498;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Me has traído algo?', 0),
(@ID, 'esMX', '¿Me has traído algo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente. Es importante adelantarse al próximo movimiento del enemigo. Esta información nos permitirá anticiparnos a los ataques del Martillo Crepuscular.', 0),
(@ID, 'esMX', 'Excelente. Es importante adelantarse al próximo movimiento del enemigo. Esta información nos permitirá anticiparnos a los ataques del Martillo Crepuscular.', 0);
-- 8499 ¡La Alianza necesita barras de torio!
-- https://es.classic.wowhead.com/quest=8499
SET @ID := 8499;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Oh, ¿un envío de mi hermano? ¡Espléndido! ¡La fortuna realmente brilla sobre mí hoy!', 0),
(@ID, 'esMX', 'Oh, ¿un envío de mi hermano? ¡Espléndido! ¡La fortuna realmente brilla sobre mí hoy!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Entonces Gnoarn no confía en mis habilidades de reconocimiento? Me pregunto porque...', 0),
(@ID, 'esMX', '¿Entonces Gnoarn no confía en mis habilidades de reconocimiento? Me pregunto porque...', 0);
-- 8500 ¡La Alianza necesita más barras de torio!
-- https://es.classic.wowhead.com/quest=8500
SET @ID := 8500;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Es tan bueno verte de nuevo, $n. Espero que te haya ido bien. Es cierto que todavía necesitamos barras de torio. Si tienes de sobra, las estoy recolectando para el esfuerzo bélico de Ahn\'Qiraj.', 0),
(@ID, 'esMX', 'Es tan bueno verte de nuevo, $n. Espero que te haya ido bien. Es cierto que todavía necesitamos barras de torio. Si tienes de sobra, las estoy recolectando para el esfuerzo bélico de Ahn\'Qiraj.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente, $n! Un trabajo bien hecho. Me ocuparé de que esas barras caigan sobre el palé y lleguen a las manos de los herreros e ingenieros que están trabajando arduamente en la construcción de suministros para nuestro ejército. Gracias de nuevo, y si te encuentras con más barras de torio, no dudes en volver.', 0),
(@ID, 'esMX', '¡Excelente, $n! Un trabajo bien hecho. Me ocuparé de que esas barras caigan sobre el palé y lleguen a las manos de los herreros e ingenieros que están trabajando arduamente en la construcción de suministros para nuestro ejército. Gracias de nuevo, y si te encuentras con más barras de torio, no dudes en volver.', 0);
-- 8501 Objetivo: los aguijoneros Colmen'Ashi
-- https://es.classic.wowhead.com/quest=8501
SET @ID := 8501;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Quieres decirme algo, $n?', 0),
(@ID, 'esMX', '¿Quieres decirme algo, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo, $n. Se ha notado tu participación en el ataque a Colmen\'Ashi.', 0),
(@ID, 'esMX', 'Excelente trabajo, $n. Se ha notado tu participación en el ataque a Colmen\'Ashi.', 0);
-- 8502 Objetivo: los trabajadores Colmen'Ashi
-- https://es.classic.wowhead.com/quest=8502
SET @ID := 8502;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo que decirme, $n?', 0),
(@ID, 'esMX', '¿Tienes algo que decirme, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo, $n. Sin sus trabajadores, los silítidos tendrán dificultades para reparar cualquier daño infligido a la estructura de su colmena.', 0),
(@ID, 'esMX', 'Excelente trabajo, $n. Sin sus trabajadores, los silítidos tendrán dificultades para reparar cualquier daño infligido a la estructura de su colmena.', 0);
-- 8503 ¡La Alianza necesita algas estranguladoras!
-- https://es.classic.wowhead.com/quest=8503
SET @ID := 8503;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡No es verdad! Nunca quitaría ninguna alga estranguladora de la parte superior de las pilas aquí. Uno podría tener la tentación de considerar que es prácticamente una panacea de utilidad. *tos* ¿No tienes ese alga estranguladora que discutimos antes?', 0),
(@ID, 'esMX', '¡No es verdad! Nunca quitaría ninguna alga estranguladora de la parte superior de las pilas aquí. Uno podría tener la tentación de considerar que es prácticamente una panacea de utilidad. *tos* ¿No tienes ese alga estranguladora que discutimos antes?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Hurra! Veinte menos. Eres $gel mejor:la mejor;. Supongo que debería empacarlos todos antes de que se marchiten. ¡Tantas algas estranguladoras, tan poco tiempo!$B$B¡Gracias de nuevo, $n!', 0),
(@ID, 'esMX', '¡Hurra! Veinte menos. Eres $gel mejor:la mejor;. Supongo que debería empacarlos todos antes de que se marchiten. ¡Tantas algas estranguladoras, tan poco tiempo!$B$B¡Gracias de nuevo, $n!', 0);
-- 8505 ¡La Alianza necesita lotos cárdenos!
-- https://es.classic.wowhead.com/quest=8505
SET @ID := 8505;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tiene los lotos cárdenos que solicité?', 0),
(@ID, 'esMX', '¿Tiene los lotos cárdenos que solicité?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tu contribución es muy apreciada, $c. Sólo mediante los esfuerzos combinados de todos seremos capaces de repeler el implacable avance de los silítidos y cualquier fuerza que los impulse. Incluso la Horda está acumulando su propia reserva de loto cárdeno. Si encuentras más, por favor regrese a mí.', 0),
(@ID, 'esMX', 'Tu contribución es muy apreciada, $c. Sólo mediante los esfuerzos combinados de todos seremos capaces de repeler el implacable avance de los silítidos y cualquier fuerza que los impulse. Incluso la Horda está acumulando su propia reserva de loto cárdeno. Si encuentras más, por favor regrese a mí.', 0);
-- 8507 Servicio de campo
-- https://es.classic.wowhead.com/quest=8507
SET @ID := 8507;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Encontrarás las fuerzas del Capitán Yunquenegro estacionadas fuera de Colmen\'Zora. Si no puedes encontrarlo, habla con su teniente, Janela Martillotenaz.', 0),
(@ID, 'esMX', 'Encontrarás las fuerzas del Capitán Yunquenegro estacionadas fuera de Colmen\'Zora. Si no puedes encontrarlo, habla con su teniente, Janela Martillotenaz.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, $n He preparado un conjunto de tareas que deberían hacer un uso óptimo de tus habilidades.$B$B¡Con los tus continuos esfuerzos y los de otros como tú, nuestro enemigo pronto será derrotado de una vez por todas!$B$BSi necesitas un nuevo informe de misión, regresa con el Capitán Yunquenegro.', 0),
(@ID, 'esMX', 'Muy bien, $n He preparado un conjunto de tareas que deberían hacer un uso óptimo de tus habilidades.$B$B¡Con los tus continuos esfuerzos y los de otros como tú, nuestro enemigo pronto será derrotado de una vez por todas!$B$BSi necesitas un nuevo informe de misión, regresa con el Capitán Yunquenegro.', 0);
-- 8508 Documentación de instrucción de campo
-- https://es.classic.wowhead.com/quest=8508
SET @ID := 8508;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Supongo que quiere esos papeles firmados, <muchacho:muchacha>', 0),
(@ID, 'esMX', 'Supongo que quiere esos papeles firmados, <muchacho:muchacha>', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, supongo que esa pequeña escaramuza pasará a ser un deber de campo hoy en día. Llévalos de regreso a Fuerte Cenarion, estoy seguro de que tendrán un trabajo a tu medida.$B$B¡Márchate!', 0),
(@ID, 'esMX', 'Sí, supongo que esa pequeña escaramuza pasará a ser un deber de campo hoy en día. Llévalos de regreso a Fuerte Cenarion, estoy seguro de que tendrán un trabajo a tu medida.$B$B¡Márchate!', 0);
-- 8509 ¡La Alianza necesita lágrimas de Arthas!
-- https://es.classic.wowhead.com/quest=8509
SET @ID := 8509;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Qué es eso? ¡Habla, $n! ¿Tienes ese envío de lágrimas de Arthas que pedí?', 0),
(@ID, 'esMX', '¿Qué es eso? ¡Habla, $n! ¿Tienes ese envío de lágrimas de Arthas que pedí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Buen trabajo, $n. Debo decir que estoy gratamente sorprendida. No creerías la cantidad de personas que han venido, ofreciéndose a ayudar, pero nunca regresan. Permíteme meterlas en una caja y contarlas con tu nombre, y luego podemos hablar de nuevo sobre si necesito más de esas plantas.', 0),
(@ID, 'esMX', 'Buen trabajo, $n. Debo decir que estoy gratamente sorprendida. No creerías la cantidad de personas que han venido, ofreciéndose a ayudar, pero nunca regresan. Permíteme meterlas en una caja y contarlas con tu nombre, y luego podemos hablar de nuevo sobre si necesito más de esas plantas.', 0);
-- 8511 ¡La Alianza necesita cuero semipesado!
-- https://es.classic.wowhead.com/quest=8511
SET @ID := 8511;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$n, espero que sea el cuero ligero que prometiste.', 0),
(@ID, 'esMX', '$n, espero que sea el cuero ligero que prometiste.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Me atrevo a decir que la Alianza estará muy contenta con estas pieles, $n. Me aseguraré de que no se desperdicie nada. Gracias, y asegúrate de volver a consultarme una vez que los haya contado para ver si necesitamos más.', 0),
(@ID, 'esMX', 'Me atrevo a decir que la Alianza estará muy contenta con estas pieles, $n. Me aseguraré de que no se desperdicie nada. Gracias, y asegúrate de volver a consultarme una vez que los haya contado para ver si necesitamos más.', 0);
-- 8512 ¡La Alianza necesita más cuero semipesado!
-- https://es.classic.wowhead.com/quest=8512
SET @ID := 8512;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Es bueno verte de nuevo, $n. Parece que necesitamos más cuero ligero para los distintos materiales de guerra. Si me traes una pila de diez, sería perfecto.', 0),
(@ID, 'esMX', 'Es bueno verte de nuevo, $n. Parece que necesitamos más cuero ligero para los distintos materiales de guerra. Si me traes una pila de diez, sería perfecto.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias por tu generosa donación, $n. Voy a ponerlos en la pila ahora mismo, y estoy segura de que en poco tiempo se transformarán en un buen conjunto de armadura, algunos parches de cuero o se usarán para otra cosa en nuestros preparativos. Parece que siempre necesitamos más cuero ligero. Vuelve pronto y visítame.', 0),
(@ID, 'esMX', 'Gracias por tu generosa donación, $n. Voy a ponerlos en la pila ahora mismo, y estoy segura de que en poco tiempo se transformarán en un buen conjunto de armadura, algunos parches de cuero o se usarán para otra cosa en nuestros preparativos. Parece que siempre necesitamos más cuero ligero. Vuelve pronto y visítame.', 0);

-- 8513 ¡La Alianza necesita cuero medio!
-- https://es.classic.wowhead.com/quest=8513
SET @ID := 8513;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí señor, te recuerdo. ¿Es ese el cuero medio que llevas contigo?', 0),
(@ID, 'esMX', 'Sí señor, te recuerdo. ¿Es ese el cuero medio que llevas contigo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Guau! Parecía que solo estabas aquí ofreciéndote como $gvoluntario:voluntaria; para ayudar. Muchas gracias por la donación. Los empacaré y los contaré. Seguro que sabes cómo alegrarle el día a un chico.', 0),
(@ID, 'esMX', '¡Guau! Parecía que solo estabas aquí ofreciéndote como $gvoluntario:voluntaria; para ayudar. Muchas gracias por la donación. Los empacaré y los contaré. Seguro que sabes cómo alegrarle el día a un chico.', 0);
-- 8514 ¡La Alianza necesita más cuero medio!
-- https://es.classic.wowhead.com/quest=8514
SET @ID := 8514;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí $gseñor:señora;, parece que hemos reunido muchas piezas de cuero medio, pero necesitamos más. Puedo asegurarte que todo se aprovechará; ni una sola pieza se desperdiciará. Sé que es mucho pedir, pero si aún estás $gdispuesto:dispuesta;, podría usar tu ayuda para intentar hacer mella en el resto de mi cuota.', 0),
(@ID, 'esMX', 'Sí $gseñor:señora;, parece que hemos reunido muchas piezas de cuero medio, pero necesitamos más. Puedo asegurarte que todo se aprovechará; ni una sola pieza se desperdiciará. Sé que es mucho pedir, pero si aún estás $gdispuesto:dispuesta;, podría usar tu ayuda para intentar hacer mella en el resto de mi cuota.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Caramba, seguro que has traído mucho cuero medio, $gseñor:señora;! Me aseguraré de que todo esto se utilice correctamente, sí, de hecho. ¡Con tu ayuda, habremos completado nuestra provisión de cuero medio en poco tiempo!$B$B¡Gracias, $n!', 0),
(@ID, 'esMX', '¡Caramba, seguro que has traído mucho cuero medio, $gseñor:señora;! Me aseguraré de que todo esto se utilice correctamente, sí, de hecho. ¡Con tu ayuda, habremos completado nuestra provisión de cuero medio en poco tiempo!$B$B¡Gracias, $n!', 0);
-- 8515 ¡La Alianza necesita cuero grueso!
-- https://es.classic.wowhead.com/quest=8515
SET @ID := 8515;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Es ese el cuero grueso que tienes en tu mochila, $n? ¿Lo es? ¡No puedo esperar a que me lo entregues! Todos van a estar tan contentos con nosotros, ¿no crees?', 0),
(@ID, 'esMX', '¿Es ese el cuero grueso que tienes en tu mochila, $n? ¿Lo es? ¡No puedo esperar a que me lo entregues! Todos van a estar tan contentos con nosotros, ¿no crees?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Oh, sabía que podías hacerlo, $n, ¡simplemente lo sabía! Los pondré en las manos adecuadas tan pronto como pueda. Ahora veamos aquí. Mmm, parece que nuestra cuenta va bastante bien. Deberías volver a consultarme en un momento, una vez que termine de contar para ver si necesitamos más. ¡Porque si lo hacemos, tú eres $gel:la; que quiero que lo reuna para mí!', 0),
(@ID, 'esMX', 'Oh, sabía que podías hacerlo, $n, ¡simplemente lo sabía! Los pondré en las manos adecuadas tan pronto como pueda. Ahora veamos aquí. Mmm, parece que nuestra cuenta va bastante bien. Deberías volver a consultarme en un momento, una vez que termine de contar para ver si necesitamos más. ¡Porque si lo hacemos, tú eres $gel:la; que quiero que lo reuna para mí!', 0);
-- 8516 ¡La Alianza necesita más cuero grueso!
-- https://es.classic.wowhead.com/quest=8516
SET @ID := 8516;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, la pila todavía no es lo suficientemente alta. $n, todavía no hemos alcanzado nuestro objetivo de cuero grueso. ¡Piensa en todas las cosas que podemos hacer con todo ese cuero! Todo tipo de armaduras y armas. ¡Cosas para el interior de los tanques de vapor y visores de rifle! Y gafas de ingeniería, ¡siempre son divertidas!$B$B¿Me traerás de vuelta un poco más de cuero grueso?', 0),
(@ID, 'esMX', 'Sí, la pila todavía no es lo suficientemente alta. $n, todavía no hemos alcanzado nuestro objetivo de cuero grueso. ¡Piensa en todas las cosas que podemos hacer con todo ese cuero! Todo tipo de armaduras y armas. ¡Cosas para el interior de los tanques de vapor y visores de rifle! Y gafas de ingeniería, ¡siempre son divertidas!$B$B¿Me traerás de vuelta un poco más de cuero grueso?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Lo hiciste otra vez! Es simplemente asombroso cómo sales, recolectas todas estas cosas, y luego las traes aquí y las entregas. Te lo digo, cuando se enteren de cuánto has estado ayudando por aquí, ¡no podrás caminar por la calle sin que la gente te pida tu autógrafo!$B$BGracias de nuevo por tu generosa donación de cuero grueso, $n.', 0),
(@ID, 'esMX', '¡Lo hiciste otra vez! Es simplemente asombroso cómo sales, recolectas todas estas cosas, y luego las traes aquí y las entregas. Te lo digo, cuando se enteren de cuánto has estado ayudando por aquí, ¡no podrás caminar por la calle sin que la gente te pida tu autógrafo!$B$BGracias de nuevo por tu generosa donación de cuero grueso, $n.', 0);
-- 8517 ¡La Alianza necesita vendas de lino!
-- https://es.classic.wowhead.com/quest=8517
SET @ID := 8517;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes las veinte vendas de lino que necesito, $n?', 0),
(@ID, 'esMX', '¿Tienes las veinte vendas de lino que necesito, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muchos son los soldados que se beneficiarán de tu contribución de hoy, $n. Me ocuparé personalmente de que la Alianza conozca sus esfuerzos. Permítame un momento para almacenar estos vendajes correctamente y actualizar mi recuento, y luego consulta conmigo para ver si necesito más.$B$B¡Que la Luz de Elune brille sobre ti, $r!', 0),
(@ID, 'esMX', 'Muchos son los soldados que se beneficiarán de tu contribución de hoy, $n. Me ocuparé personalmente de que la Alianza conozca sus esfuerzos. Permítame un momento para almacenar estos vendajes correctamente y actualizar mi recuento, y luego consulta conmigo para ver si necesito más.$B$B¡Que la Luz de Elune brille sobre ti, $r!', 0);
-- 8518 ¡La Alianza necesita más vendas de lino!
-- https://es.classic.wowhead.com/quest=8518
SET @ID := 8518;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Nunca dejará de asombrarme el altruismo demostrado cuando tantos optarían por una alternativa egoísta. $c, todavía necesito unas cuantas vendas de lino para poder dar mi encargo por cumplido. ¿Me ayudarás una vez más a reunir esas vendas?', 0),
(@ID, 'esMX', 'Nunca dejará de asombrarme el altruismo demostrado cuando tantos optarían por una alternativa egoísta. $c, todavía necesito unas cuantas vendas de lino para poder dar mi encargo por cumplido. ¿Me ayudarás una vez más a reunir esas vendas?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Mereces todos mis elogios, $n. Mientras muchos se aprovecharían de la economía de nuestra guerra para enriquecerse enfervorecidos por la avaricia, has demostrado una y otra vez que tu entrega a la Alianza, y por ende a todo Azeroth, es lo primero.$B$B¡Que la bendición de Elune siempre esté contigo!', 0),
(@ID, 'esMX', 'Mereces todos mis elogios, $n. Mientras muchos se aprovecharían de la economía de nuestra guerra para enriquecerse enfervorecidos por la avaricia, has demostrado una y otra vez que tu entrega a la Alianza, y por ende a todo Azeroth, es lo primero.$B$B¡Que la bendición de Elune siempre esté contigo!', 0);
-- 8519 Un peón en el ajedrez de la vida
-- https://es.classic.wowhead.com/quest=8519
SET @ID := 8519;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Después de la traición de Staghelm, recogí los pedazos destrozados del Cetro de las arenas movedizas y regresé aquí. Tenía toda la intención de proteger el cetro de aquellos que tratarían de usarlo para causar daño a nuestro mundo; así nació la carga de los Vuelo de Dragón.$B$BUn cetro dividido entre los cuatro poderosos Aspectos resultaría casi imposible de restaurar para aquellos que deliberadamente buscan el caos... o eso pensé. Qué tonto fui. Incluso ahora me persigue ese vuelo maldito.', 0),
(@ID, 'esMX', 'Después de la traición de Staghelm, recogí los pedazos destrozados del Cetro de las arenas movedizas y regresé aquí. Tenía toda la intención de proteger el cetro de aquellos que tratarían de usarlo para causar daño a nuestro mundo; así nació la carga de los Vuelo de Dragón.$B$BUn cetro dividido entre los cuatro poderosos Aspectos resultaría casi imposible de restaurar para aquellos que deliberadamente buscan el caos... o eso pensé. Qué tonto fui. Incluso ahora me persigue ese vuelo maldito.', 0);
-- 8520 ¡La Alianza necesita vendas de seda!
-- https://es.classic.wowhead.com/quest=8520
SET @ID := 8520;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Hola, $c, ¿ya has conseguido esas veinte vendas de seda?', 0),
(@ID, 'esMX', 'Hola, $c, ¿ya has conseguido esas veinte vendas de seda?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '$c, ¡lo lograste! Gracias a ti estamos un paso más cerca de conseguir nuestro objetivo con las vendas de seda. Las guardaré y luego podremos hablar más si quieres.', 0),
(@ID, 'esMX', '$c, ¡lo lograste! Gracias a ti estamos un paso más cerca de conseguir nuestro objetivo con las vendas de seda. Las guardaré y luego podremos hablar más si quieres.', 0);
-- 8521 ¡La Alianza necesita más vendas de seda!
-- https://es.classic.wowhead.com/quest=8521
SET @ID := 8521;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Es muy amable por tu parte ofrecerte a ayudarme de nuevo, $c. Parece que hemos reunido la gran cantidad de vendas de seda que se nos ha encomendado, pero aún necesitamos más. $n, ¿hay alguna forma que te parezca adecuada para hacer otro paquete y traerlo? La Alianza y yo estaremos muy agradecidos.', 0),
(@ID, 'esMX', 'Es muy amable por tu parte ofrecerte a ayudarme de nuevo, $c. Parece que hemos reunido la gran cantidad de vendas de seda que se nos ha encomendado, pero aún necesitamos más. $n, ¿hay alguna forma que te parezca adecuada para hacer otro paquete y traerlo? La Alianza y yo estaremos muy agradecidos.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Eres una persona tan desinteresada. Muchas gracias por tu contribución al esfuerzo de guerra. Son las personas como tú las que van a marcar la diferencia entre el éxito y el fracaso en Ahn\'Qiraj. Solo espero que todo esto sea suficiente.$B$BGracias de nuevo, $n.', 0),
(@ID, 'esMX', 'Eres una persona tan desinteresada. Muchas gracias por tu contribución al esfuerzo de guerra. Son las personas como tú las que van a marcar la diferencia entre el éxito y el fracaso en Ahn\'Qiraj. Solo espero que todo esto sea suficiente.$B$BGracias de nuevo, $n.', 0);
-- 8522 ¡La Alianza necesita vendas de paño rúnico!
-- https://es.classic.wowhead.com/quest=8522
SET @ID := 8522;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los días pasan uno tras otro y seguimos adelante. $n, ¿tienes esas vendas de paño rúnico?', 0),
(@ID, 'esMX', 'Los días pasan uno tras otro y seguimos adelante. $n, ¿tienes esas vendas de paño rúnico?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tu perseverancia en esta tarea es digna de elogio, $n. Guardaré estas vendas y luego me gustaría volver a hablar contigo sobre la posibilidad de que recojas aún más vendas de paño rúnico.', 0),
(@ID, 'esMX', 'Tu perseverancia en esta tarea es digna de elogio, $n. Guardaré estas vendas y luego me gustaría volver a hablar contigo sobre la posibilidad de que recojas aún más vendas de paño rúnico.', 0);
-- 8523 ¡La Alianza necesita más vendas de paño rúnico!
-- https://es.classic.wowhead.com/quest=8523
SET @ID := 8523;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Así que venimos a discutir asuntos urgentes una vez más, $n. Una vez más te agradezco tus esfuerzos; no todos son tan tan desinteresados. Pero aún queda mucho trabajo por hacer.$B$B$n, ¿volverás a recoger vendas de paño rúnico y me las devolverás aquí?', 0),
(@ID, 'esMX', 'Así que venimos a discutir asuntos urgentes una vez más, $n. Una vez más te agradezco tus esfuerzos; no todos son tan tan desinteresados. Pero aún queda mucho trabajo por hacer.$B$B$n, ¿volverás a recoger vendas de paño rúnico y me las devolverás aquí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Vamos por buen camino, $n. Eres $gun excelente compañero:una excelente compañera; de trabajo. Una vez más te doy las gracias por tus esfuerzos en nombre de toda la Alianza. Ven y habla de nuevo conmigo pronto.', 0),
(@ID, 'esMX', 'Vamos por buen camino, $n. Eres $gun excelente compañero:una excelente compañera; de trabajo. Una vez más te doy las gracias por tus esfuerzos en nombre de toda la Alianza. Ven y habla de nuevo conmigo pronto.', 0);
-- 8524 ¡La Alianza necesita atún blanco arco iris!
-- https://es.classic.wowhead.com/quest=8524
SET @ID := 8524;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estoy dispuesto a apostar que has regresado con todo ese atún blanco del que estábamos hablando antes, ¿verdad, $n?', 0),
(@ID, 'esMX', 'Estoy dispuesto a apostar que has regresado con todo ese atún blanco del que estábamos hablando antes, ¿verdad, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Dos para la Alianza, uno para mí, dos para la Alianza, uno para mí. Hola, $gpescador:pescadora;, excelente trabajo. Puedo ver que vas a ser un verdadero mérito para el club. Sin embargo, me parece que probablemente necesitemos más de ese atún blanco. ¿Por qué no te diriges hacia fuera y pescas un poco más? Ya puedo escuchar mi estómago retumbar.', 0),
(@ID, 'esMX', 'Dos para la Alianza, uno para mí, dos para la Alianza, uno para mí. Hola, $gpescador:pescadora;, excelente trabajo. Puedo ver que vas a ser un verdadero mérito para el club. Sin embargo, me parece que probablemente necesitemos más de ese atún blanco. ¿Por qué no te diriges hacia fuera y pescas un poco más? Ya puedo escuchar mi estómago retumbar.', 0);
-- 8525 ¡La Alianza necesita más atún blanco arco iris!
-- https://es.classic.wowhead.com/quest=8525
SET @ID := 8525;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Qué! ¿Tú otra vez? Bueno, seré el tío de un mono... excepto que soy un Gnomo. ¡Gastrónomo Salao para ser precisos! Así que volviste a ayudar, ¿eh? Bueno, no puedo decir que te culpo. ¿No te encanta el olor de toda esa comida? <babeando>$B$B¡Basta de holgazanear! ¡Sal y tráeme más atún blanco arcoíris!', 0),
(@ID, 'esMX', '¡Qué! ¿Tú otra vez? Bueno, seré el tío de un mono... excepto que soy un Gnomo. ¡Gastrónomo Salao para ser precisos! Así que volviste a ayudar, ¿eh? Bueno, no puedo decir que te culpo. ¿No te encanta el olor de toda esa comida? <babeando>$B$B¡Basta de holgazanear! ¡Sal y tráeme más atún blanco arcoíris!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sabía que lo tenías dentro, $gchico:chica;. Tienes el aspecto de alguien que sabe lo que le gusta. Específicamente que te gusta complacerme y los poderes fácticos. Y eso lo tienes, te lo garantizo.$B$BJaja, está bien, simplemente guardaré estos peces adecuadamente, y luego tú y yo podemos tener una pequeña charla sobre que recolectes otros veinte atunes.', 0),
(@ID, 'esMX', 'Sabía que lo tenías dentro, $gchico:chica;. Tienes el aspecto de alguien que sabe lo que le gusta. Específicamente que te gusta complacerme y los poderes fácticos. Y eso lo tienes, te lo garantizo.$B$BJaja, está bien, simplemente guardaré estos peces adecuadamente, y luego tú y yo podemos tener una pequeña charla sobre que recolectes otros veinte atunes.', 0);
-- 8526 ¡La Alianza necesita raptor asado!
-- https://es.classic.wowhead.com/quest=8526
SET @ID := 8526;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Entonces, ¿ya tienes todo ese raptor asado?', 0),
(@ID, 'esMX', 'Entonces, ¿ya tienes todo ese raptor asado?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Vaya, eso es genial. Gracias por traerme toda esta carne de animal quemada, $n. Lo pondré en la pila de allí. Seguro que alguien se ocupará de ello. Supongo que si tienes algo de tiempo, ¿querrás traerme más?', 0),
(@ID, 'esMX', 'Vaya, eso es genial. Gracias por traerme toda esta carne de animal quemada, $n. Lo pondré en la pila de allí. Seguro que alguien se ocupará de ello. Supongo que si tienes algo de tiempo, ¿querrás traerme más?', 0);
-- 8528 ¡La Alianza necesita serviolas moteadas!
-- https://es.classic.wowhead.com/quest=8528
SET @ID := 8528;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estoy segura de que regresarás pronto con las serviolas moteadas que discutimos.', 0),
(@ID, 'esMX', 'Estoy segura de que regresarás pronto con las serviolas moteadas que discutimos.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias por este regalo, $n, y de manera tan oportuna también. Seguramente a nuestros soldados no les faltará algo de comer. Solo déjame guardar estos peces correctamente y luego tú y yo podemos discutir una segunda entrega, si estás $gdispuesto:dispuesta;.', 0),
(@ID, 'esMX', 'Gracias por este regalo, $n, y de manera tan oportuna también. Seguramente a nuestros soldados no les faltará algo de comer. Solo déjame guardar estos peces correctamente y luego tú y yo podemos discutir una segunda entrega, si estás $gdispuesto:dispuesta;.', 0);
-- 8529 ¡La Alianza necesita más serviolas moteadas!
-- https://es.classic.wowhead.com/quest=8529
SET @ID := 8529;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si todavía estás $gdispuesto:dispuesta;, me gustaría enviarte de regreso para que traigas otra carga de serviolas moteadas, $n. Me imagino que, con la experiencia de la primera vez, esta captura debería ser mucho más rápida y sencilla. ¿Estás en el juego?', 0),
(@ID, 'esMX', 'Si todavía estás $gdispuesto:dispuesta;, me gustaría enviarte de regreso para que traigas otra carga de serviolas moteadas, $n. Me imagino que, con la experiencia de la primera vez, esta captura debería ser mucho más rápida y sencilla. ¿Estás en el juego?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Eres $gun verdadero:una verdadera; miembro de la Alianza, $n. Tus esfuerzos no pasarán desapercibidos ni serán despreciados. Y gracias por cocinar el pescado también. Me encargaré de que se almacenen correctamente y luego tendré que actualizar mi recuento. Cada uno nos acerca mucho más a alcanzar nuestro objetivo.', 0),
(@ID, 'esMX', 'Eres $gun verdadero:una verdadera; miembro de la Alianza, $n. Tus esfuerzos no pasarán desapercibidos ni serán despreciados. Y gracias por cocinar el pescado también. Me encargaré de que se almacenen correctamente y luego tendré que actualizar mi recuento. Cada uno nos acerca mucho más a alcanzar nuestro objetivo.', 0);
-- 8532 ¡La Horda necesita lingotes de cobre!
-- https://es.classic.wowhead.com/quest=8532
SET @ID := 8532;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Espero que eso que traes son los 20 lingotes de cobre, $c.', 0),
(@ID, 'esMX', 'Espero que eso que traes son los 20 lingotes de cobre, $c.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estos lingotes servirán y gracias por no sacarles brillo. De nada sirve embellecerlos cuando se van a fundir para todo tipo de material que se debe construir para la guerra. Me ocuparé de poner esto en las pilas y me aseguraré de que se aprovechan bien. Vuelve a hablar conmigo si te interesara traer otros 20.', 0),
(@ID, 'esMX', 'Estos lingotes servirán y gracias por no sacarles brillo. De nada sirve embellecerlos cuando se van a fundir para todo tipo de material que se debe construir para la guerra. Me ocuparé de poner esto en las pilas y me aseguraré de que se aprovechan bien. Vuelve a hablar conmigo si te interesara traer otros 20.', 0);
-- 8533 ¡La Horda necesita más lingotes de cobre!
-- https://es.classic.wowhead.com/quest=8533
SET @ID := 8533;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Ya has vuelto? No tardarás en convertirte en $gun auténtico minero:una auténtica minera;, $c. Así que ya sabes de qué va; necesito que vayas a extraer un montón de mineral de cobre, lo fundas en lingotes y me los traigas aquí. Sé que es algo de lo que eres capaz, el tema es ¿estás $gdispuesto:dispuesta; a hacerlo?', 0),
(@ID, 'esMX', '¿Ya has vuelto? No tardarás en convertirte en $gun auténtico minero:una auténtica minera;, $c. Así que ya sabes de qué va; necesito que vayas a extraer un montón de mineral de cobre, lo fundas en lingotes y me los traigas aquí. Sé que es algo de lo que eres capaz, el tema es ¿estás $gdispuesto:dispuesta; a hacerlo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Me lo has probado una vez más, $n. Me ocuparé de que este cobre se utilice a su debido tiempo. Sin embargo, por ahora, necesito colocar estas barras de cobre en el palé y contarlas. Si todavía te sientes $ganimado:animada;, podría usar tu ayuda para reunir aún más barras de cobre.', 0),
(@ID, 'esMX', 'Me lo has probado una vez más, $n. Me ocuparé de que este cobre se utilice a su debido tiempo. Sin embargo, por ahora, necesito colocar estas barras de cobre en el palé y contarlas. Si todavía te sientes $ganimado:animada;, podría usar tu ayuda para reunir aún más barras de cobre.', 0);
-- 8534 Informe de exploración de Colmen'Zora
-- https://es.classic.wowhead.com/quest=8534
SET @ID := 8534;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Encontrarás al Explorador Azenel dentro de Colmen\'Zora. ¡Date prisa, $n! El tiempo es esencial.', 0),
(@ID, 'esMX', 'Encontrarás al Explorador Azenel dentro de Colmen\'Zora. ¡Date prisa, $n! El tiempo es esencial.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Apreciamos mucho tus esfuerzos, $n. Leeré estos informes de exploración de inmediato, siéntete libre de repasar tu próxima tarea.', 0),
(@ID, 'esMX', 'Apreciamos mucho tus esfuerzos, $n. Leeré estos informes de exploración de inmediato, siéntete libre de repasar tu próxima tarea.', 0);
-- Templario vetusto
-- 8535, 8536, 8537
-- https://es.classic.wowhead.com/quest=8535
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8535, 8536, 8537) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8535, 'esES', '¿Has terminado tu tarea, $n?', 0),
(8536, 'esES', '¿Has terminado tu tarea, $n?', 0),
(8537, 'esES', '¿Has terminado tu tarea, $n?', 0),
(8535, 'esMX', '¿Has terminado tu tarea, $n?', 0),
(8536, 'esMX', '¿Has terminado tu tarea, $n?', 0),
(8537, 'esMX', '¿Has terminado tu tarea, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8535, 8536, 8537) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8535, 'esES', 'Buen trabajo, $n. Aquí está su próxima tarea.', 0),
(8536, 'esES', 'Buen trabajo, $n. Aquí está su próxima tarea.', 0),
(8537, 'esES', 'Buen trabajo, $n. Aquí está su próxima tarea.', 0),
(8535, 'esMX', 'Buen trabajo, $n. Aquí está su próxima tarea.', 0),
(8536, 'esMX', 'Buen trabajo, $n. Aquí está su próxima tarea.', 0),
(8537, 'esMX', 'Buen trabajo, $n. Aquí está su próxima tarea.', 0);
-- 8538 Los cuatro Duques
-- https://es.classic.wowhead.com/quest=8538
SET @ID := 8538;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has terminado tu tarea, $n?', 0),
(@ID, 'esMX', '¿Has terminado tu tarea, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Hoy has conseguido un gran logro para nuestra causa, $n. Has vencido a algunos de nuestros enemigos más poderosos. Por eso, te felicito enormemente.', 0),
(@ID, 'esMX', 'Hoy has conseguido un gran logro para nuestra causa, $n. Has vencido a algunos de nuestros enemigos más poderosos. Por eso, te felicito enormemente.', 0);
-- 8539 Objetivo: las hermanas de la colmena de Colmen'Zora
-- https://es.classic.wowhead.com/quest=8539
SET @ID := 8539;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo que decirme, $n?', 0),
(@ID, 'esMX', '¿Tienes algo que decirme, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo, $n. Eres $gun digno aliado:una digna aliada;.', 0),
(@ID, 'esMX', 'Excelente trabajo, $n. Eres $gun digno aliado:una digna aliada;.', 0);
-- Botas para la guardia
-- 8540, 8541
-- https://es.classic.wowhead.com/quest=8540
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8540, 8541) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8540, 'esES', '¿Tienes algo para mí, $n?', 0),
(8541, 'esES', '¿Tienes algo para mí, $n?', 0),
(8540, 'esMX', '¿Tienes algo para mí, $n?', 0),
(8541, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8540, 8541) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8540, 'esES', 'Excelente. Las necesitábamos, $n. Buen trabajo.', 0),
(8541, 'esES', 'Excelente. Las necesitábamos, $n. Buen trabajo.', 0),
(8540, 'esMX', 'Excelente. Las necesitábamos, $n. Buen trabajo.', 0),
(8541, 'esMX', 'Excelente. Las necesitábamos, $n. Buen trabajo.', 0);
-- 8542 ¡La Horda necesita lingotes de estaño!
-- https://es.classic.wowhead.com/quest=8542
SET @ID := 8542;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Cuántos lingotes de estaño tienes, $c? Después de la guerra creo que necesitaré que alguien me enseñe a contar.', 0),
(@ID, 'esMX', '¿Cuántos lingotes de estaño tienes, $c? Después de la guerra creo que necesitaré que alguien me enseñe a contar.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Bueno, supongo que parece el número correcto de lingotes de estaño. ¡No intentes engañarme, $c! Al contar me duele el cráneo. Ahora voy y pongo estas barras en la pila y tú sales y me traes más de lo mismo.', 0),
(@ID, 'esMX', 'Bueno, supongo que parece el número correcto de lingotes de estaño. ¡No intentes engañarme, $c! Al contar me duele el cráneo. Ahora voy y pongo estas barras en la pila y tú sales y me traes más de lo mismo.', 0);
-- 8543 ¡La Horda necesita más lingotes de estaño!
-- https://es.classic.wowhead.com/quest=8543
SET @ID := 8543;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, veo que te tomas en serio la guerra. Sin embargo, estoy un poco nervioso esperando a que comience, y estoy seguro de que tú también, $n. Será glorioso cuando comience. La Horda corriendo sobre las arenas del desierto de Silithus, armas en mano, cargando de contra las masas de insectos. ¡Ese día todos tendrán un gran honor!$B$B¡Har! Pero primero necesitamos más lingotes de estaño. Es curioso cómo una cosa tan pequeña puede marcar una diferencia tan grande, ¿no crees?', 0),
(@ID, 'esMX', 'Muy bien, veo que te tomas en serio la guerra. Sin embargo, estoy un poco nervioso esperando a que comience, y estoy seguro de que tú también, $n. Será glorioso cuando comience. La Horda corriendo sobre las arenas del desierto de Silithus, armas en mano, cargando de contra las masas de insectos. ¡Ese día todos tendrán un gran honor!$B$B¡Har! Pero primero necesitamos más lingotes de estaño. Es curioso cómo una cosa tan pequeña puede marcar una diferencia tan grande, ¿no crees?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Throm\'ka, $n. Nos honras a mí y a la Horda con tus lingotes de estaño. Los pondré en la pila y luego vendrán y harán cosas con ellos. Y luego, cuando todo esté hecho, iremos a la guerra y le mostraremos a la insignificante Alianza cómo luchar contra los insectos.$B$B¡Ahora tráeme más lingotes de estaño!', 0),
(@ID, 'esMX', 'Throm\'ka, $n. Nos honras a mí y a la Horda con tus lingotes de estaño. Los pondré en la pila y luego vendrán y harán cosas con ellos. Y luego, cuando todo esté hecho, iremos a la guerra y le mostraremos a la insignificante Alianza cómo luchar contra los insectos.$B$B¡Ahora tráeme más lingotes de estaño!', 0);
-- 8544 Las bufas de conquistador
-- https://es.classic.wowhead.com/quest=8544
SET @ID := 8544;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Ha recogido los componentes que necesito?', 0),
(@ID, 'esMX', '¿Ha recogido los componentes que necesito?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Con los materiales que traes y de las escamas de nuestros enemigos qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que verte infunda miedo en nuestros enemigos.', 0),
(@ID, 'esMX', 'Con los materiales que traes y de las escamas de nuestros enemigos qiraji caídos, te hago estas hombreras, mortal. Que te brinden la protección que necesitas y que verte infunda miedo en nuestros enemigos.', 0);
-- 8545 ¡La Horda necesita barras de mitril!
-- https://es.classic.wowhead.com/quest=8545
SET @ID := 8545;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Seguro que sería bueno tener todas las barras de mitril que necesitamos pa\' el esfuerzo bélico de Ahn\'Qiraj. ¿Es por eso qu\'has vuelto, colega? ¿Tienes mis barras?', 0),
(@ID, 'esMX', 'Seguro que sería bueno tener todas las barras de mitril que necesitamos pa\' el esfuerzo bélico de Ahn\'Qiraj. ¿Es por eso qu\'has vuelto, colega? ¿Tienes mis barras?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Este será un buen comienzo pa\' ti y pa\' mí, $n. Son otras veinte barras de mitril que puedo poner en las pilas y marcar fuera de la lista. Todo se v\'a aprovechar pa\' hacer el material de guerra.$B$BAsegúrate de volver a verme porque ¿sabes que?, parece que vamos a necesitar más d\'esas barras de mitril.', 0),
(@ID, 'esMX', 'Este será un buen comienzo pa\' ti y pa\' mí, $n. Son otras veinte barras de mitril que puedo poner en las pilas y marcar fuera de la lista. Todo se v\'a aprovechar pa\' hacer el material de guerra.$B$BAsegúrate de volver a verme porque ¿sabes que?, parece que vamos a necesitar más d\'esas barras de mitril.', 0);
-- 8546 ¡La Horda necesita más barras de mitril!
-- Notice: English text is also missing in quest_request_items.CompletionText
-- https://es.classic.wowhead.com/quest=8546
SET @ID := 8546;
UPDATE `quest_request_items` SET `CompletionText` = 'Yup, I be glad you\'re here, mon. You helped me before, and now I need your help again. We still lookin\' ta bring in more mithril bars for the war effort; gonna build lots of armor and weapons and things to go squish them bugs at Ahn\'Qiraj.$B$BSo if you be a true friend, you bring me back more stacks of mithril bars. I take all you got until we hit our quota. You have some for me now?', `VerifiedBuild` = 0 WHERE `id` = @ID ;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, m’alegro qu’hayas venío, colega. M’has ayudao antes y ahora vuelvo a necesitarte. Entoavía hay que traer más lingotes de mitril pa’ los preparativos de la guerra; vamos a construir un montón d’armaduras, armas y tal y tal pa\' aplastar a esos bichos d’Ahn\'Qiraj.$B$BSi eres $gun amigo:una amiga; de verdad, tráeme más pilas de lingotes de mitril. Me lo quedaré to\' hasta qu\'alcancemos nuestro cupo. ¿No tendrás algunos pa’ mí ahora?', 0),
(@ID, 'esMX', 'Sí, m’alegro qu’hayas venío, colega. M’has ayudao antes y ahora vuelvo a necesitarte. Entoavía hay que traer más lingotes de mitril pa’ los preparativos de la guerra; vamos a construir un montón d’armaduras, armas y tal y tal pa\' aplastar a esos bichos d’Ahn\'Qiraj.$B$BSi eres $gun amigo:una amiga; de verdad, tráeme más pilas de lingotes de mitril. Me lo quedaré to\' hasta qu\'alcancemos nuestro cupo. ¿No tendrás algunos pa’ mí ahora?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Un trabajo increíble, $n! Otros 20 lingotes y nos acercaremos al objetivo y tendremos más material pa\' la guerra. M’ocuparé de que lo guarden. Y si consigues otro montón de lingotes de mitril, asegúrate de que los traes a la menda.', 0),
(@ID, 'esMX', '¡Un trabajo increíble, $n! Otros 20 lingotes y nos acercaremos al objetivo y tendremos más material pa\' la guerra. M’ocuparé de que lo guarden. Y si consigues otro montón de lingotes de mitril, asegúrate de que los traes a la menda.', 0);
-- 8548 Equipamiento de Voluntario
-- https://es.classic.wowhead.com/quest=8548
SET @ID := 8548;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Nos conviene mantener bien preparados a nuestros aliados más leales, $n.', 0),
(@ID, 'esMX', 'Nos conviene mantener bien preparados a nuestros aliados más leales, $n.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Buen trabajo, $n. Acepta esto en nombre del Círculo Cenarion. ¡Seguro que te lo has ganado, $gamigo:maiga;!', 0),
(@ID, 'esMX', 'Buen trabajo, $n. Acepta esto en nombre del Círculo Cenarion. ¡Seguro que te lo has ganado, $gamigo:maiga;!', 0);
-- 8549 ¡La Horda necesita flores de paz!
-- https://es.classic.wowhead.com/quest=8549
SET @ID := 8549;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Vete ahora, $n. Busca, $n.', 0),
(@ID, 'esMX', 'Vete ahora, $n. Busca, $n.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No ha sido una tarea fácil, pero has sobresalido. Claro que no te apresures a pensar que me has impresionado, $n.', 0),
(@ID, 'esMX', 'No ha sido una tarea fácil, pero has sobresalido. Claro que no te apresures a pensar que me has impresionado, $n.', 0);
-- 8550 ¡La Horda necesita más flores de paz!
-- https://es.classic.wowhead.com/quest=8550
SET @ID := 8550;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias por tus continuos esfuerzos, $n. Te traes un gran honor a ti $gmismo:misma; y a tus antepasados con tu generosidad desinteresada, ¡y todos lo sabrán! Guardaré estas hierbas para que se mantengan frescas hasta que se necesiten. Una vez más, revelas el verdadero espíritu de la Horda, la lucha por vencer y la promesa de que podemos trabajar juntos para lograrlo.', 0),
(@ID, 'esMX', 'Gracias por tus continuos esfuerzos, $n. Te traes un gran honor a ti $gmismo:misma; y a tus antepasados con tu generosidad desinteresada, ¡y todos lo sabrán! Guardaré estas hierbas para que se mantengan frescas hasta que se necesiten. Una vez más, revelas el verdadero espíritu de la Horda, la lucha por vencer y la promesa de que podemos trabajar juntos para lograrlo.', 0);
-- 8551 El cofre del Capitán
-- https://es.classic.wowhead.com/quest=8551
SET @ID := 8551;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Buenas, $n! ¿Has encontrado a Gorlash? Ese cofre era mi favorito y tiene un compartimiento oculto donde guardaba mis mayores tesoros.', 0),
(@ID, 'esMX', '¡Buenas, $n! ¿Has encontrado a Gorlash? Ese cofre era mi favorito y tiene un compartimiento oculto donde guardaba mis mayores tesoros.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡La has encontrado! ¡Oh, qué día tan feliz! Gracias, $n. Recuperar mi cofre hace que se enfríe el fuego que arde en mi interior.$B$BPero mi venganza todavía no ha terminado...', 0),
(@ID, 'esMX', '¡La has encontrado! ¡Oh, qué día tan feliz! Gracias, $n. Recuperar mi cofre hace que se enfríe el fuego que arde en mi interior.$B$BPero mi venganza todavía no ha terminado...', 0);
-- 8552 La banda con monograma
-- https://es.classic.wowhead.com/quest=8552
SET @ID := 8552;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Hola! ¿Tienes algo de lo que hablar conmigo?', 0),
(@ID, 'esMX', '¡Hola! ¿Tienes algo de lo que hablar conmigo?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has recuperado mi banda? Entonces... tienes que haber matado a ese gigante marino Mok\'rash. ¡Hurra!$B$BMe alegro de que ese villano asqueroso esté muerto. Mok\'rash fue uno de los tres gigantes marinos que destrozó mis barcos y mató a mi tripulación.$B$BTres veces.$B$BEres $gun:una; $c de gran valía, $n.', 0),
(@ID, 'esMX', '¿Has recuperado mi banda? Entonces... tienes que haber matado a ese gigante marino Mok\'rash. ¡Hurra!$B$BMe alegro de que ese villano asqueroso esté muerto. Mok\'rash fue uno de los tres gigantes marinos que destrozó mis barcos y mató a mi tripulación.$B$BTres veces.$B$BEres $gun:una; $c de gran valía, $n.', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
