-- DB update 2021_11_01_00 -> 2021_11_01_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_01_00 2021_11_01_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634598950367001300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634598950367001300');

-- Quest: The Missing Scout - ID: 9309
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9309 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9309, 'esES', 'Ayuda... ¡elfos de sangre! Me... tendieron... una emboscada. No me queda... mucho.', 18019),
(9309, 'esMX', 'Ayuda... ¡elfos de sangre! Me... tendieron... una emboscada. No me queda... mucho.', 18019);

-- Quest: The Blood Elves - ID: 10303
DELETE FROM `quest_request_items_locale` WHERE `ID`=10303 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(10303, 'esES', 'Son demasiados... Debemos reducirlos o los supervivientes no tendrán ninguna oportunidad contra ellos.', 18019),
(10303, 'esMX', 'Son demasiados... Debemos reducirlos o los supervivientes no tendrán ninguna oportunidad contra ellos.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=10303 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(10303, 'esES', 'Esos elfos de sangre quieren matarnos a todos. ¿Qué podemos hacer para impedirlo?', 18019),
(10303, 'esMX', 'Esos elfos de sangre quieren matarnos a todos. ¿Qué podemos hacer para impedirlo?', 18019);

-- Quest: Blood Elf Spy - ID: 9311
DELETE FROM `quest_request_items_locale` WHERE `ID`=9311 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9311, 'esES', 'Entonces es cierto... ¡un grupo de exploradores de elfos de sangre aquí en el Valle de Ammen! ¿Cómo nos han seguido?$B$BEnviaré a alguien inmediatamente para que traiga a Tolaan de vuelta.', 18019),
(9311, 'esMX', 'Entonces es cierto... ¡un grupo de exploradores de elfos de sangre aquí en el Valle de Ammen! ¿Cómo nos han seguido?$B$BEnviaré a alguien inmediatamente para que traiga a Tolaan de vuelta.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9311 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9311, 'esES', 'Gracias por encargarte de la elfa de sangre; seguro que ella era la líder. Nos ocuparemos de los rezagados, no te preocupes.$B$BAcepta una de estas armas como prueba de mi gratitud.', 18019),
(9311, 'esMX', 'Gracias por encargarte de la elfa de sangre; seguro que ella era la líder. Nos ocuparemos de los rezagados, no te preocupes.$B$BAcepta una de estas armas como prueba de mi gratitud.', 18019);

-- Quest: Blood Elf Plans - ID: 9798
DELETE FROM `quest_request_items_locale` WHERE `ID`=9798 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9798, 'esES', '¿Qué tienes ahí?', 18019),
(9798, 'esMX', '¿Qué tienes ahí?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9798 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9798, 'esES', 'A ver, déjame leer esos planes.$B$B¿Los elfos de sangre nos han seguido hasta aquí? Son terriblemente malvados, deberíamos acabar con todos ellos.$B$B<El vindicador hace una pausa para recuperar la compostura.>$B$BPerdona, eso no era necesario. Estamos en deuda contigo por la información que nos has proporcionado, $n.', 18019),
(9798, 'esMX', 'A ver, déjame leer esos planes.$B$B¿Los elfos de sangre nos han seguido hasta aquí? Son terriblemente malvados, deberíamos acabar con todos ellos.$B$B<El vindicador hace una pausa para recuperar la compostura.>$B$BPerdona, eso no era necesario. Estamos en deuda contigo por la información que nos has proporcionado, $n.', 18019);

-- Quest: The Emitter - ID: 9312
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9312 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9312, 'esES', '¡Ya está, lo tengo! ¡Creo que he conseguido arreglar el emisor! Ahí está, activaré este último cristal y eso debería funcionar.$B$BMira el emisor, $n. Parece que empieza a funcionar... ¡está apareciendo alguien!', 18019),
(9312, 'esMX', '¡Ya está, lo tengo! ¡Creo que he conseguido arreglar el emisor! Ahí está, activaré este último cristal y eso debería funcionar.$B$BMira el emisor, $n. Parece que empieza a funcionar... ¡está apareciendo alguien!', 18019);

-- Quest: Call of Earth - ID: 9449
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9449 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9449, 'esES', '¡Tienes valor al venir a pedirme respuestas después de lo que tu gente le hizo a estas islas! Pero admiro la valentía, así que compartiré algo de lo que sé contigo.$B$BLa tierra que hay bajo tus pies conforma los cimientos de todas las cosas. El cielo, las aguas, incluso el fuego reposan sobre la tierra. Los otros a menudo forman tempestades, pero la tierra obedece. Proporciona fuerza y entereza a los seres.$B$BAhora debes ponerte a prueba, $c.', 18019),
(9449, 'esMX', '¡Tienes valor al venir a pedirme respuestas después de lo que tu gente le hizo a estas islas! Pero admiro la valentía, así que compartiré algo de lo que sé contigo.$B$BLa tierra que hay bajo tus pies conforma los cimientos de todas las cosas. El cielo, las aguas, incluso el fuego reposan sobre la tierra. Los otros a menudo forman tempestades, pero la tierra obedece. Proporciona fuerza y entereza a los seres.$B$BAhora debes ponerte a prueba, $c.', 18019);

-- Quest: Call of Earth - ID: 9450
DELETE FROM `quest_request_items_locale` WHERE `ID`=9450 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9450, 'esES', 'Los elementos me siguen pareciendo desequilibrados, $n.', 18019),
(9450, 'esMX', 'Los elementos me siguen pareciendo desequilibrados, $n.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9450 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9450, 'esES', 'Has hecho bien. Al diluir los espíritus inquietos has ayudado a curar el desequilibrio entre los elementos, que tu gente causó inadvertidamente.$B$BA lo largo de tu viaje como $c debes tener esto en mente cuando invoques nuestro poder. El equilibrio debe ser preservado.', 18019),
(9450, 'esMX', 'Has hecho bien. Al diluir los espíritus inquietos has ayudado a curar el desequilibrio entre los elementos, que tu gente causó inadvertidamente.$B$BA lo largo de tu viaje como $c debes tener esto en mente cuando invoques nuestro poder. El equilibrio debe ser preservado.', 18019);

-- Quest: Call of Earth - ID: 9451
DELETE FROM `quest_request_items_locale` WHERE `ID`=9451 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9451, 'esES', 'Juntos, los Tábidos y los $r recuperarán un entendimiento profundo de los misterios de los elementos.$B$B¿Traes lo necesario para crear tu tótem de Tierra?', 18019),
(9451, 'esMX', 'Juntos, los Tábidos y los $r recuperarán un entendimiento profundo de los misterios de los elementos.$B$B¿Traes lo necesario para crear tu tótem de Tierra?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9451 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9451, 'esES', 'Muy bien, $n. Al ayudar a restaurar el equilibrio de los elementos en la arboleda, has creado equilibrio entre el elemento tierra de este mundo y los $r. Quizás esto ayude a quienes desaprueban nuestro modo de vida a comprendernos mejor.$B$BVoy a hacerte un tótem con el que podrás doblegar el poder de la tierra a tu voluntad. Y a su debido tiempo te serán revelados más misterios de la tierra.$B$BToma tu tótem, $c.', 18019),
(9451, 'esMX', 'Muy bien, $n. Al ayudar a restaurar el equilibrio de los elementos en la arboleda, has creado equilibrio entre el elemento tierra de este mundo y los $r. Quizás esto ayude a quienes desaprueban nuestro modo de vida a comprendernos mejor.$B$BVoy a hacerte un tótem con el que podrás doblegar el poder de la tierra a tu voluntad. Y a su debido tiempo te serán revelados más misterios de la tierra.$B$BToma tu tótem, $c.', 18019);

-- Quest: Red Snapper - Very Tasty! - ID: 9452
DELETE FROM `quest_request_items_locale` WHERE `ID`=9452 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9452, 'esES', 'Cuidado con los múrlocs; son unas criaturas pequeñas, raras y muy, muy molestas.', 18019),
(9452, 'esMX', 'Cuidado con los múrlocs; son unas criaturas pequeñas, raras y muy, muy molestas.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9452 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9452, 'esES', 'Espero que los múrlocs no dieran mucho problema, $n. Estoy en deuda contigo por todo lo que has hecho.$B$B¿Quieres que te enseñe a pescar? Yo pongo la caña y un regalito.', 18019),
(9452, 'esMX', 'Espero que los múrlocs no dieran mucho problema, $n. Estoy en deuda contigo por todo lo que has hecho.$B$B¿Quieres que te enseñe a pescar? Yo pongo la caña y un regalito.', 18019);

-- Quest: Find Acteon! - ID: 9453
DELETE FROM `quest_request_items_locale` WHERE `ID`=9453 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9453, 'esES', '¿Qué te parece mi armadura? ¡La hice yo! Es un poco distinta de lo normal, pero muy cómoda.', 18019),
(9453, 'esMX', '¿Qué te parece mi armadura? ¡La hice yo! Es un poco distinta de lo normal, pero muy cómoda.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9453 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9453, 'esES', 'Pobre Diktynna, vaya susto se llevó con ese múrloc.$B$B<Acteon suspira.>$B$BEspero que se recupere pronto...$B$BSupongo que buscas trabajo. Bien, ¡en la Avanzada Azur no te va a faltar!', 18019),
(9453, 'esMX', 'Pobre Diktynna, vaya susto se llevó con ese múrloc.$B$B<Acteon suspira.>$B$BEspero que se recupere pronto...$B$BSupongo que buscas trabajo. Bien, ¡en la Avanzada Azur no te va a faltar!', 18019);

-- Quest: The Great Moongraze Hunt - ID: 9454
DELETE FROM `quest_request_items_locale` WHERE `ID`=9454 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(9454, 'esES', 'Las pieles de venado son delicadas, lo que suele dar una carne tierna y suculenta.', 18019),
(9454, 'esMX', 'Las pieles de venado son delicadas, lo que suele dar una carne tierna y suculenta.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=9454 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9454, 'esES', '¡Bien hecho, $n, bien hecho!$B$BToma, cociné unos lomos mientras no estabas. ¿Quieres la receta también?', 18019),
(9454, 'esMX', '¡Bien hecho, $n, bien hecho!$B$BToma, cociné unos lomos mientras no estabas. ¿Quieres la receta también?', 18019);

-- Quest: The Great Moongraze Hunt - ID: 10324
DELETE FROM `quest_request_items_locale` WHERE `ID`=10324 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(10324, 'esES', 'Las pieles de los ciervos son tupidas y resistentes, con lo que su carne es muy dura, prácticamente incomible. Pero nos vale para otros propósitos.', 18019),
(10324, 'esMX', 'Las pieles de los ciervos son tupidas y resistentes, con lo que su carne es muy dura, prácticamente incomible. Pero nos vale para otros propósitos.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=10324 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(10324, 'esES', '¡Maravilloso! Te estás convirtiendo en un gran cazador, $n.$B$B¿Te gustaría parecerte más a mí? ¡Pues puedes hacerlo! Cuando estabas cazando, hice estos objetos con algunas pieles que tenía por aquí. ¡Elige uno!', 18019),
(10324, 'esMX', '¡Maravilloso! Te estás convirtiendo en un gran cazador, $n.$B$B¿Te gustaría parecerte más a mí? ¡Pues puedes hacerlo! Cuando estabas cazando, hice estos objetos con algunas pieles que tenía por aquí. ¡Elige uno!', 18019);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_01_01' WHERE sql_rev = '1634598950367001300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
