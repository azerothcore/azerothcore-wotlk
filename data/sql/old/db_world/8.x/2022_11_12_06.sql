-- DB update 2022_11_12_05 -> 2022_11_12_06
-- Update and insert some missing quests and creature texts (esES and esMX)
-- QUEST_TEMPLATE_LOCALE
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Miembro de la Plaga asesinado'  WHERE `id` = 12919 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Cianigosa asesinada'  WHERE `id` = 13159 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Miembros de la Horda asesinados'  WHERE `id` = 13177 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Miembros de la Alianza asesinados'  WHERE `id` = 13178 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Miembros de la Horda asesinados'  WHERE `id` = 13179 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Miembros de la Alianza asesinados'  WHERE `id` = 13180 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Destruye una de las tres torres sur'  WHERE `id` = 13538 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Miembro de la Plaga de Corona de Hielo muerto'  WHERE `id` = 13676 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Vehículo de Asedio de la Horda Defendido'  WHERE `id` = 13223 AND `locale` IN ('esES', 'esMX');
-- CREATURE_TEXT_LOCALE
DELETE FROM `creature_text_locale` WHERE `CreatureID` IN (29120, 32169, 32170) AND `locale` IN ('esES', 'esMX');
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `id`, `locale`, `TEXT`) VALUES	
	(29120, 5, 0, 'esES', 'Yo fuí el Rey de este Imperio, hace mucho. En vida yo era un campeón. En la muerte regresé como conquistador. Ahora vuelvo a proteger el Reino. Irónico ¿Verdad?'),
	(29120, 5, 0, 'esMX', 'Yo fuí el Rey de este Imperio, hace mucho. En vida yo era un campeón. En la muerte regresé como conquistador. Ahora vuelvo a proteger el Reino. Irónico ¿Verdad?'),
	(32169, 0, 0, 'esES', '¡Se necesitan refuerzos para combatir en el campo de batalla de Conquista del Invierno! He abierto un portal para viajar rápido al campo de batalla en el Enclave de Plata.'),
	(32169, 0, 0, 'esMX', '¡Se necesitan refuerzos para combatir en el campo de batalla de Conquista del Invierno! He abierto un portal para viajar rápido al campo de batalla en el Enclave de Plata.'),
	(32170, 0, 0, 'esES', '¡La batalla por el control de la Fortaleza de Conquista del Invierno comenzará en 5 minutos! ¡Preparaos para la batalla!'),
	(32170, 0, 0, 'esMX', '¡La batalla por el control de la Fortaleza de Conquista del Invierno comenzará en 5 minutos! ¡Prepárense para la batalla!');
-- QUEST_REQUEST_ITEMS_LOCALE
DELETE FROM `quest_request_items_locale` WHERE `ID` IN (11405, 13154, 13538, 13193, 13196, 13199, 13159, 13183, 13223, 13180, 13178) AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
	(11405, 'esES', 'Esta tierra ha sido removida recientemente. En la capa superior hay lombrices que intentan escapar de la profunda oscuridad que se extiende debajo.', 0),
	(11405, 'esMX', 'Esta tierra ha sido removida recientemente. En la capa superior hay lombrices que intentan escapar de la profunda oscuridad que se extiende debajo.', 0),
	(13154, 'esES', '¿Como ha ido la caza? He oído rumores de que ese lugar esta embrujado, aunque no se me ocurriría aventurarme solo por ese lugar.', 0),
	(13154, 'esMX', '¿Como ha ido la caza? He oído rumores de que ese lugar esta embrujado, aunque no se me ocurriría aventurarme solo por ese lugar.', 0),
	(13538, 'esES', '¿Tienes alguna noticia que provenga del sur?', 0),
	(13538, 'esMX', '¿Tienes alguna noticia que provenga del sur?', 0),
	(13193, 'esES', '¿Ya has vuelto? Maldita sea, pensaba que podría descansar un poco.', 0),
	(13193, 'esMX', '¿Ya has vuelto? Maldita sea, pensaba que podría descansar un poco.', 0),
	(13196, 'eseS', '¿Como ha ido la caza? He oído rumores de que ese lugar esta embrujado, aunque no se me ocurriría aventurarme solo por ese lugar.', 0),
	(13196, 'esMX', '¿Como ha ido la caza? He oído rumores de que ese lugar esta embrujado, aunque no se me ocurriría aventurarme solo por ese lugar.', 0),
	(13199, 'esES', '¿Ya has vuelto? Maldita sea, pensaba que podría descansar un poco.', 0),
	(13199, 'esMX', '¿Ya has vuelto? Maldita sea, pensaba que podría descansar un poco.', 0),
	(13159, 'esES', '¿Se ha terminado? ¿Has sido capaz de resistir el asalto?', 0),
	(13159, 'esMX', '¿Se ha terminado? ¿Has sido capaz de resistir el asalto?', 0),
	(13183, 'esES', '¿Qué nuevas noticias nos traes?', 0),
	(13183, 'esMX', '¿Qué nuevas noticias nos traes?', 0),
	(13223, 'esES', '¿Has protegido las Máquinas de Asedio?', 0),
	(13223, 'esMX', '¿Has protegido las Máquinas de Asedio?', 0),
	(13180, 'esES', 'Bueno, ¿Has completado tu misión?', 0),
	(13180, 'esMX', 'Bueno, ¿Has completado tu misión?', 0),
	(13178, 'esES', 'Bueno, ¿Has completado tu misión?', 0),
	(13178, 'esMX', 'Bueno, ¿Has completado tu misión?', 0);
-- QUEST_OFFER_REWARD_LOCALE
DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN(11404, 11405, 13222, 13223, 13177, 13179, 13181, 13183, 13158, 13159, 24585, 13178, 13180) AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
	(11404, 'esES', '¿Dejarás la vela e invocarás a El Jinete decapitado de su descanso maldito?', 0),
	(11404, 'esMX', '¿Dejarás la vela e invocarás a El Jinete decapitado de su descanso maldito?', 0),
	(11405, 'esES', '¿Dejarás la vela e invocarás a El Jinete decapitado de su descanso maldito?', 0),
	(11405, 'esMX', '¿Dejarás la vela e invocarás a El Jinete decapitado de su descanso maldito?', 0),
	(13222, 'esES', '¡Eso les enseñará el poder de invención de los gnomos!', 0),
	(13222, 'esMX', '¡Eso les enseñará el poder de invención de los gnomos!', 0),
	(13223, 'esES', 'Buen trabajo. A Murp le hubiera gustado estar allí para ayudar.', 0),
	(13223, 'esMX', 'Buen trabajo. A Murp le hubiera gustado estar allí para ayudar.', 0),
	(13177, 'esES', '¡Madre mía! Está claro que formas parte de los campeones de la Alianza.', 0),
	(13177, 'esMX', '¡Madre mía! Está claro que formas parte de los campeones de la Alianza.', 0),
	(13179, 'esES', '¡Madre mía! Está claro que formas parte de los campeones de la Alianza.', 0),
	(13179, 'esMX', '¡Madre mía! Está claro que formas parte de los campeones de la Alianza.', 0),
	(13181, 'esES', '¡Exactamente lo que quería escuchar! Una victoria en el Lago Conquista del Invierno, aunque solo sea temporal, es crucial para nuestra estrategia general contra la Horda.', 0),
	(13181, 'esMX', '¡Exactamente lo que quería escuchar! Una victoria en el Lago Conquista del Invierno, aunque solo sea temporal, es crucial para nuestra estrategia general contra la Horda.', 0),
	(13183, 'esES', 'Es una gran hazaña lo que has conseguido hoy. ¡Que se reconozca tu sacrificio!', 0),
	(13183, 'esMX', 'Es una gran hazaña lo que has conseguido hoy. ¡Que se reconozca tu sacrificio!', 0),
	(13158, 'esES', 'Más vale tarde que nunca.$b$b¿Estás listo para defender Dalaran, $c?', 0),
	(13158, 'esMX', 'Más vale tarde que nunca.$b$b¿Estás listo para defender Dalaran, $c?', 0),
	(13159, 'esES', 'Entonces, ¿hemos evitado la crisis?$b$bQué buena noticia. Informaré a Rhonin.$b$bPor favor, acepta esto con la gratitud de Dalaran.', 0),
	(13159, 'esMX', 'Entonces, ¿hemos evitado la crisis?$b$bQué buena noticia. Informaré a Rhonin.$b$bPor favor, acepta esto con la gratitud de Dalaran.', 0),
	(24585, 'esES', 'Jamás dejan de sorprenderme los horrores que se pueden crear mediante el uso de la tecnología.', 0),
	(24585, 'esMX', 'Jamás dejan de sorprenderme los horrores que se pueden crear mediante el uso de la tecnología.', 0),
	(13178, 'esES', '¡Lok\'tar! ¡Victoria para la Horda!', 0),
	(13178, 'esMX', '¡Lok\'tar! ¡Victoria para la Horda!', 0),
	(13180, 'esES', '¡Lok\'tar! ¡Victoria para la Horda!', 0),
	(13180, 'esMX', '¡Lok\'tar! ¡Victoria para la Horda!', 0);
-- ITEM_TEMPLATE_LOCALE
DELETE FROM `item_template_locale` WHERE `ID` = 42482 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `NAME`, `Description`, `VerifiedBuild`) VALUES
	(42482, 'esES', 'Llave de El Bastión Violeta', '', 0),
	(42482, 'esMX', 'Llave de El Bastión Violeta', '', 0);
