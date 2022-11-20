-- esES missing reward_locale 
DELETE FROM `quest_offer_reward_locale` WHERE `locale` IN ('esES', 'esMX') AND `ID` IN (13153, 13154, 13156, 13185, 13186, 13191, 13192, 13193, 13194, 13195, 13196, 13197, 13198, 13199, 13200, 13201, 13202, 13538, 13539);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(13153, 'esES', 'Ais... Aún está empapado. ¿No podrías haberlo secado primero?', 0),
(13154, 'esES', '¡Excelente! Esto ayudará a avivar las llamas de la guerra en los próximos días.', 0),
(13156, 'esES', '¡Excelente! Esto ayudará a nuestras tropas a protegerse del frío.', 0),
(13185, 'esES', 'Buen trabajo. A Murp le hubiera gustado estar allí para ayudar.', 0),
(13186, 'esES', '¡Excelente! Eso debería ralentizar su asalto.', 0),
(13191, 'esES', '¡Excelente! ¡Esto nos ayudará a vencer a la Alianza en las batallas que quedan por venir!', 0),
(13192, 'esES', 'Oh. ¡Ese e\'h el equipo, colega!', 0),
(13193, 'esES', 'Me temo que me voy a pasar otra noche afilando huesos. ¿Por qué no me quedé en la Ciudad de Lunargenta como mi hermano?', 0),
(13194, 'esES', 'Gracias, esto nos ayudará a tratar las heridas profundas de nuestros soldados.', 0),
(13195, 'esES', '¡Excelente! Esto ayudará a nuestras tropas a protegerse del frío.', 0),
(13196, 'esES', '¡Excelente! Esto ayudará a avivar las llamas de la guerra en los próximos días.', 0),
(13197, 'esES', '¡Excelente! Esto ayudará a avivar las llamas de la guerra en los próximos días.', 0),
(13198, 'esES', 'Ais... Aún está empapado. ¿No podrías haberlo secado primero?', 0),
(13199, 'esES', 'Me temo que me voy a pasar otra noche afilando huesos. ¿Por qué no me quedé en la Ciudad de Lunargenta como mi hermano?', 0),
(13200, 'esES', '¡Excelente! ¡Eso debería hacer mella en sus máquinas de guerra!', 0),
(13201, 'esES', 'Gracias, esto nos ayudará a tratar las heridas profundas de nuestros soldados.', 0),
(13202, 'esES', 'Oh. ¡Ese e\'h el equipo, colega!', 0),
(13538, 'esES', '¡He oído la explosión desde aquí! Excelente trabajo, ya hemos comenzado a redirigir la energía hacia la reliquia del Titán para sobrecargar nuestras propias fuerzas.', 0),
(13539, 'esES', 'Ahora para matar al enemigo, nuestros hombres y mujeres deben despertar su ira. Para tener una ventaja al derrotar al enemigo, deben tener su recompensa. Espero que esto sea suficiente por tu servicio con la Horda.', 0),
-- esMX missing reward_locale
(13153, 'esMX', 'Ais... Aún está empapado. ¿No podrías haberlo secado primero?', 0),
(13154, 'esMX', '¡Excelente! Esto ayudará a avivar las llamas de la guerra en los próximos días.', 0),
(13156, 'esMX', '¡Excelente! Esto ayudará a nuestras tropas a protegerse del frío.', 0),
(13185, 'esMX', 'Buen trabajo. A Murp le hubiera gustado estar allí para ayudar.', 0),
(13186, 'esMX', '¡Excelente! Eso debería ralentizar su asalto.', 0),
(13191, 'esMX', '¡Excelente! ¡Esto nos ayudará a vencer a la Alianza en las batallas que quedan por venir!', 0),
(13192, 'esMX', 'Oh. ¡Ese e\'h el equipo, colega!', 0),
(13193, 'esMX', 'Me temo que me voy a pasar otra noche afilando huesos. ¿Por qué no me quedé en la Ciudad de Lunargenta como mi hermano?', 0),
(13194, 'esMX', 'Gracias, esto nos ayudará a tratar las heridas profundas de nuestros soldados.', 0),
(13195, 'esMX', '¡Excelente! Esto ayudará a nuestras tropas a protegerse del frío.', 0),
(13196, 'esMX', '¡Excelente! Esto ayudará a avivar las llamas de la guerra en los próximos días.', 0),
(13197, 'esMX', '¡Excelente! Esto ayudará a avivar las llamas de la guerra en los próximos días.', 0),
(13198, 'esMX', 'Ais... Aún está empapado. ¿No podrías haberlo secado primero?', 0),
(13199, 'esMX', 'Me temo que me voy a pasar otra noche afilando huesos. ¿Por qué no me quedé en la Ciudad de Lunargenta como mi hermano?', 0),
(13200, 'esMX', '¡Excelente! ¡Eso debería hacer mella en sus máquinas de guerra!', 0),
(13201, 'esMX', 'Gracias, esto nos ayudará a tratar las heridas profundas de nuestros soldados.', 0),
(13202, 'esMX', 'Oh. ¡Ese e\'h el equipo, colega!', 0),
(13538, 'esMX', '¡He oído la explosión desde aquí! Excelente trabajo, ya hemos comenzado a redirigir la energía hacia la reliquia del Titán para sobrecargar nuestras propias fuerzas.', 0),
(13539, 'esMX', 'Ahora para matar al enemigo, nuestros hombres y mujeres deben despertar su ira. Para tener una ventaja al derrotar al enemigo, deben tener su recompensa. Espero que esto sea suficiente por tu servicio con la Horda.', 0);
-- 2 SECTION
-- esES missing quest_request_items_locale 
DELETE FROM `quest_request_items_locale` WHERE `locale` IN ('esES', 'esMX') AND `ID` IN (13153, 13156, 13177, 13179, 13181, 13185, 13186, 13191, 13192, 13194, 13195, 13197, 13198, 13200, 13201, 13202, 13222, 13539);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(13153, 'esES', 'Entonces, ¿has encontrado la armadura?', 0),
(13156, 'esES', '¡Espero que no hayas levantado ningún Azotador por error! La semana pasada le dieron una buena tunda de latigazos a nuestro oficial.', 0),
(13177, 'esES', 'Y bien, ¿Has completado tu misión?', 0),
(13179, 'esES', 'Y bien, ¿Has completado tu misión?', 0),
(13181, 'esES', '¿Entonces hemos ganado?', 0),
(13185, 'esES', '¿Has destruido sus vehículos de asedio?', 0),
(13186, 'esES', 'No hay tiempo que perder. ¿Has destruido sus vehículos de asedio?', 0),
(13191, 'esES', '¿Y bien? ¿Has averiguado donde se encuentran las llamas enfurecidas o la Alianza te ha dado una paliza y has huído como un bebé llorón?', 0),
(13192, 'esES', '¿Trae\'h la armadura colega?', 0),
(13194, 'esES', '¿Has podido recuperar las hierbas? La fiebre y heridas aumentan por horas.', 0),
(13195, 'esES', '¡Espero que no hayas levantado ningún Azotador por error! La semana pasada le dieron una buena tunda de latigazos a nuestro oficial.', 0),
(13197, 'esES', '¿Y bien? ¿Has averiguado donde se encuentran las llamas enfurecidas o la Horda te ha dado una paliza y has huído como un bebé llorón?', 0),
(13198, 'esES', 'Entonces, ¿has encontrado la armadura?', 0),
(13200, 'esES', '¿Y bien? ¿Has averiguado donde se encuentran las llamas enfurecidas o la Alianza te ha dado una paliza y has huído como un bebé llorón?', 0),
(13201, 'esES', '¿Has podido recuperar las hierbas? La fiebre y heridas aumentan por horas.', 0),
(13202, 'esES', '¿Traes la armadura colega?', 0),
(13222, 'esES', 'No hay tiempo que perder. ¿Has destruido la Fortaleza?', 0),
(13539, 'esES', 'Mi odio por los brujos solo es superado por el que le tengo a los no-muertos. Sin embargo, ambos pueden demostrar ser útiles a veces.', 0),
-- esMX missing quest_request_items_locale 
(13153, 'esMX', 'Entonces, ¿has encontrado la armadura?', 0),
(13156, 'esMX', '¡Espero que no hayas levantado ningún Azotador por error! La semana pasada le dieron una buena tunda de latigazos a nuestro oficial.', 0),
(13177, 'esMX', 'Y bien, ¿Has completado tu misión?', 0),
(13179, 'esMX', 'Y bien, ¿Has completado tu misión?', 0),
(13181, 'esMX', '¿Entonces hemos ganado?', 0),
(13185, 'esMX', '¿Has destruido sus vehículos de asedio?', 0),
(13186, 'esMX', 'No hay tiempo que perder. ¿Has destruido sus vehículos de asedio?', 0),
(13191, 'esMX', '¿Y bien? ¿Has averiguado donde se encuentran las llamas enfurecidas o la Alianza te ha dado una paliza y has huído como un bebé llorón?', 0),
(13192, 'esMX', '¿Trae\'h la armadura colega?', 0),
(13194, 'esMX', '¿Has podido recuperar las hierbas? La fiebre y heridas aumentan por horas.', 0),
(13195, 'esMX', '¡Espero que no hayas levantado ningún Azotador por error! La semana pasada le dieron una buena tunda de latigazos a nuestro oficial.', 0),
(13197, 'esMX', '¿Y bien? ¿Has averiguado donde se encuentran las llamas enfurecidas o la Horda te ha dado una paliza y has huído como un bebé llorón?', 0),
(13198, 'esMX', 'Entonces, ¿has encontrado la armadura?', 0),
(13200, 'esMX', '¿Y bien? ¿Has averiguado donde se encuentran las llamas enfurecidas o la Alianza te ha dado una paliza y has huído como un bebé llorón?', 0),
(13201, 'esMX', '¿Has podido recuperar las hierbas? La fiebre y heridas aumentan por horas.', 0),
(13202, 'esMX', '¿Traes la armadura colega?', 0),
(13222, 'esMX', 'No hay tiempo que perder. ¿Has destruido la Fortaleza?', 0),
(13539, 'esMX', 'Mi odio por los brujos solo es superado por el que le tengo a los no-muertos. Sin embargo, ambos pueden demostrar ser útiles a veces.', 0);
-- SECTION 3
-- quest_template_locale esES
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Aparatos de asedio de la Alianza destruidos', `ObjectiveText2` = '', `ObjectiveText3` = '', `ObjectiveText4` = '' WHERE `locale` IN ('esES', 'esMX') AND ID = 13185;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Aparatos de asedio de la Horda destruidos', `ObjectiveText2` = '', `ObjectiveText3` = '', `ObjectiveText4` = '' WHERE `locale` IN ('esES', 'esMX') AND ID = 13186;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Vehículo de asedio defendido', `ObjectiveText2` = '', `ObjectiveText3` = '', `ObjectiveText4` = '' WHERE `locale` IN ('esES', 'esMX') AND ID = 13222;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Destruye una torre sur en Conquista del Invierno', `ObjectiveText2` = '', `ObjectiveText3` = '', `ObjectiveText4` = '' WHERE `locale` IN ('esES', 'esMX') AND ID = 13539;
