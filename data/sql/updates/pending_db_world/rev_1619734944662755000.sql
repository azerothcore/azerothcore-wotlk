INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619734944662755000');

-- 8731 Servicio de campo
-- https://es.classic.wowhead.com/quest=8731
SET @ID := 8731;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has completado tu servicio de campo, $n? El Capitán Machacacráneos está fuera de Colmen\'Regal.', 0),
(@ID, 'esMX', '¿Has completado tu servicio de campo, $n? El Capitán Machacacráneos está fuera de Colmen\'Regal.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Puedo decir que Krug tiene poca habilidad para el papeleo. ¡Lo firmó con sangre silítida!$B$BMuy bien, $n. He preparado un conjunto de tareas que deberían hacer un buen uso de tus habilidades como $c.$B$BCon tus continuos esfuerzos los de otros como tú, ¡nuestro enemigo pronto será aplastado!', 0),
(@ID, 'esMX', 'Puedo decir que Krug tiene poca habilidad para el papeleo. ¡Lo firmó con sangre silítida!$B$BMuy bien, $n. He preparado un conjunto de tareas que deberían hacer un buen uso de tus habilidades como $c.$B$BCon tus continuos esfuerzos los de otros como tú, ¡nuestro enemigo pronto será aplastado!', 0);
-- 8732 Documentación de instrucción de campo
-- https://es.classic.wowhead.com/quest=8732
SET @ID := 8732;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Supongo que quiere esos papeles firmados, <chico:chica>', 0),
(@ID, 'esMX', 'Supongo que quiere esos papeles firmados, <chico:chica>', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, supongo que esa pequeña escaramuza pasará a ser un deber de campo hoy en día. Llévalos de regreso a Fuerte Cenarion, estoy seguro de que tendrán un trabajo a tu medida.$B$B¡Márchate!', 0),
(@ID, 'esMX', 'Sí, supongo que esa pequeña escaramuza pasará a ser un deber de campo hoy en día. Llévalos de regreso a Fuerte Cenarion, estoy seguro de que tendrán un trabajo a tu medida.$B$B¡Márchate!', 0);
-- 8733 Eranikus, el Tirano del Sueño
-- https://es.classic.wowhead.com/quest=8733
SET @ID := 8733;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'La brizna está en silencio excepto por un suave zumbido. Curiosamente, es capaz de comunicarse contigo a través de pensamientos.', 0),
(@ID, 'esMX', 'La brizna está en silencio excepto por un suave zumbido. Curiosamente, es capaz de comunicarse contigo a través de pensamientos.', 0);
-- 8734 Tyrande y Remulos
-- https://es.classic.wowhead.com/quest=8734
SET @ID := 8734;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sería imposible sacar a Eranikus del Sueño si se negaba. Sin embargo, sus intenciones requieren que entre en nuestro mundo. Busca destruir la manifestación viviente de Malfurion. Hacer esto significaría el fin de uno de los aliados más poderosos del Sueño. La Pesadilla consumiría por completo todo lo que queda si Malfurion cayera...', 0),
(@ID, 'esMX', 'Sería imposible sacar a Eranikus del Sueño si se negaba. Sin embargo, sus intenciones requieren que entre en nuestro mundo. Busca destruir la manifestación viviente de Malfurion. Hacer esto significaría el fin de uno de los aliados más poderosos del Sueño. La Pesadilla consumiría por completo todo lo que queda si Malfurion cayera...', 0);
-- 8735 La corrupción de Pesadilla
-- https://es.classic.wowhead.com/quest=8735
SET @ID := 8735;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Remulos está perdido en sus pensamientos.>', 0),
(@ID, 'esMX', '<Remulos está perdido en sus pensamientos.>', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Estas $gpreparado:preparada;? ¿Está el mundo preparado para lo que vamos a invocar? No lo sé... estoy obligado por el deber hacia Malfurion. Deber y honor...', 0),
(@ID, 'esMX', '¿Estas $gpreparado:preparada;? ¿Está el mundo preparado para lo que vamos a invocar? No lo sé... estoy obligado por el deber hacia Malfurion. Deber y honor...', 0);
-- 8736 La Pesadilla se manifiesta
-- https://es.classic.wowhead.com/quest=8736
SET @ID := 8736;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Está redimido, $n. Ahora regresa al Sueño para corregir lo que solo él ha hecho mal. Eranikus será un poderoso aliado para Malfurion y mi padre.$B$BEste armamento que me dio la propia Ysera es para ti, $n. Harías bien en utilizarlo en tus batallas contra los qiraji.', 0),
(@ID, 'esMX', 'Está redimido, $n. Ahora regresa al Sueño para corregir lo que solo él ha hecho mal. Eranikus será un poderoso aliado para Malfurion y mi padre.$B$BEste armamento que me dio la propia Ysera es para ti, $n. Harías bien en utilizarlo en tus batallas contra los qiraji.', 0);
-- 8737 Templario azur
-- https://es.classic.wowhead.com/quest=8737
SET @ID := 8737;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has terminado tu tarea, $n?', 0),
(@ID, 'esMX', '¿Has terminado tu tarea, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Buen trabajo, $n. Aquí está tu próxima tarea.', 0),
(@ID, 'esMX', 'Buen trabajo, $n. Aquí está tu próxima tarea.', 0);
-- 8738 Informe de exploración de Colmen'Regal
-- https://es.classic.wowhead.com/quest=8738
SET @ID := 8738;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Encontrarás al Explorador Landion dentro de Colmen\'Regal. ¡Date prisa, $n! El tiempo es esencial.', 0),
(@ID, 'esMX', 'Encontrarás al Explorador Landion dentro de Colmen\'Regal. ¡Date prisa, $n! El tiempo es esencial.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Apreciamos mucho tus esfuerzos, $n. Leeré estos informes de exploración de inmediato, siéntete libre de repasar tu próxima tarea.', 0),
(@ID, 'esMX', 'Apreciamos mucho tus esfuerzos, $n. Leeré estos informes de exploración de inmediato, siéntete libre de repasar tu próxima tarea.', 0);
-- 8739 Informe de exploración de Colmen'Ashi
-- https://es.classic.wowhead.com/quest=8739
SET @ID := 8739;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Encontrarás al Explorador Jalia dentro de Colmen\'Ashi. ¡Date prisa, $n! El tiempo es esencial.', 0),
(@ID, 'esMX', 'Encontrarás al Explorador Jalia dentro de Colmen\'Ashi. ¡Date prisa, $n! El tiempo es esencial.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Apreciamos mucho tus esfuerzos, $n. Leeré estos informes de exploración de inmediato, siéntete libre de repasar tu próxima tarea.', 0),
(@ID, 'esMX', 'Apreciamos mucho tus esfuerzos, $n. Leeré estos informes de exploración de inmediato, siéntete libre de repasar tu próxima tarea.', 0);
-- 8740 Los merodeadores Crepusculares
-- https://es.classic.wowhead.com/quest=8740
SET @ID := 8740;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has terminado tu tarea, $n?', 0),
(@ID, 'esMX', '¿Has terminado tu tarea, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Bien hecho, $n. Los merodeadores crepusculares estaban causando un número inaceptable de bajas en nuestras patrullas. Aquí está su próxima tarea.', 0),
(@ID, 'esMX', 'Bien hecho, $n. Los merodeadores crepusculares estaban causando un número inaceptable de bajas en nuestras patrullas. Aquí está su próxima tarea.', 0);
-- 8741 El regreso del Campeón
-- https://es.classic.wowhead.com/quest=8741
SET @ID := 8741;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tus obras serán conocidas por todos, $gcampeón:campeona;. Cantarán tus alabanzas desde Orgrimmar hasta los confines de los Mares del Sur. Todos sabrán $gdel campeón:de la campeona; del Vuelo de Bronce, $n.', 0),
(@ID, 'esMX', 'Tus obras serán conocidas por todos, $gcampeón:campeona;. Cantarán tus alabanzas desde Orgrimmar hasta los confines de los Mares del Sur. Todos sabrán $gdel campeón:de la campeona; del Vuelo de Bronce, $n.', 0);
-- 8742 El poder de Kalimdor
-- https://es.classic.wowhead.com/quest=8742
SET @ID := 8742;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Han pasado mil años y, tal como estaba predestinado, $guno:una; está frente a mí. $gUno:Una; que guiará a su pueblo a una nueva era.$B$BEl Dios Antiguo tiembla, $n. Oh, sí, teme tu fe. Rompe la profecía de C\'Thun.$B$BSabe que vienes, $gcampeón:campeona;, y que contigo viene el poder de Kalimdor. Solo tienes que avisarme cuando estés $gpreparado:preparada; y te concederé el Cetro de las arenas movedizas.', 0),
(@ID, 'esMX', 'Han pasado mil años y, tal como estaba predestinado, $guno:una; está frente a mí. $gUno:Una; que guiará a su pueblo a una nueva era.$B$BEl Dios Antiguo tiembla, $n. Oh, sí, teme tu fe. Rompe la profecía de C\'Thun.$B$BSabe que vienes, $gcampeón:campeona;, y que contigo viene el poder de Kalimdor. Solo tienes que avisarme cuando estés $gpreparado:preparada; y te concederé el Cetro de las arenas movedizas.', 0);
-- 8743 Golpear el gong
-- https://es.classic.wowhead.com/quest=8743
SET @ID := 8743;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El Gong de Escarabajo se cierne inquietantemente ante ti. Ármate, $n; porque una vez que suene el Gong, se abrirán las puertas de Ahn\'Qiraj.$B$BDe las fauces debilitadas de la bestia solo puede venir el caos y la destrucción. ¡Defiende a tu pueblo!', 0),
(@ID, 'esMX', 'El Gong de Escarabajo se cierne inquietantemente ante ti. Ármate, $n; porque una vez que suene el Gong, se abrirán las puertas de Ahn\'Qiraj.$B$BDe las fauces debilitadas de la bestia solo puede venir el caos y la destrucción. ¡Defiende a tu pueblo!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Del suelo cerca del gong brota un cristal especial. Quizás el favor de la Prole.', 0),
(@ID, 'esMX', 'Del suelo cerca del gong brota un cristal especial. Quizás el favor de la Prole.', 0);
-- 8744 Un presente envuelto con cuidado
-- https://es.wowhead.com/quest=8744
SET @ID := 8744;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'La etiqueta de este regalo dice:$B$BPara $n:$B$B¡Que pases unas dulces y felices fiestas del Gran Invierno!', 0),
(@ID, 'esMX', 'La etiqueta de este regalo dice:$B$BPara $n:$B$B¡Que pases unas dulces y felices fiestas del Gran Invierno!', 0);
-- Metzen el reno
-- 8746, 8762
-- https://es.classic.wowhead.com/quest=8746
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Rescata al reno Metzen', `VerifiedBuild` = 0 WHERE `id` IN(8746, 8762) AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8746, 8762) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8746, 'esES', '¿Conseguiste localizar a Metzen con las notas que te di? No quiero ni pensar en cómo lo estarán tratando... ¡Pero no podemos pagar el rescate!', 0),
(8762, 'esES', '¿Conseguiste localizar a Metzen con las notas que te di? No quiero ni pensar en cómo lo estarán tratando... ¡Pero no podemos pagar el rescate!', 0),
(8746, 'esMX', '¿Conseguiste localizar a Metzen con las notas que te di? No quiero ni pensar en cómo lo estarán tratando... ¡Pero no podemos pagar el rescate!', 0),
(8762, 'esMX', '¿Conseguiste localizar a Metzen con las notas que te di? No quiero ni pensar en cómo lo estarán tratando... ¡Pero no podemos pagar el rescate!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8746, 8762) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8746, 'esES', '¡Bravo!$B$BMetzen ya está a salvo en los establos de Papá Invierno. ¡Sabía que el polvo funcionaría! Has salvado el Festival de Invierno y a Pastos de Bosquehumeante, $n.$B$BAcepta esto como prueba de gratitud; te gustará. ¡Feliz Festival de Invierno!', 0),
(8762, 'esES', '¡Bravo!$B$BMetzen ya está a salvo en los establos de Papá Invierno. ¡Sabía que el polvo funcionaría! Has salvado el Festival de Invierno y a Pastos de Bosquehumeante, $n.$B$BAcepta esto como prueba de gratitud; te gustará. ¡Feliz Festival de Invierno!', 0),
(8746, 'esMX', '¡Bravo!$B$BMetzen ya está a salvo en los establos de Papá Invierno. ¡Sabía que el polvo funcionaría! Has salvado el Festival de Invierno y a Pastos de Bosquehumeante, $n.$B$BAcepta esto como prueba de gratitud; te gustará. ¡Feliz Festival de Invierno!', 0),
(8762, 'esMX', '¡Bravo!$B$BMetzen ya está a salvo en los establos de Papá Invierno. ¡Sabía que el polvo funcionaría! Has salvado el Festival de Invierno y a Pastos de Bosquehumeante, $n.$B$BAcepta esto como prueba de gratitud; te gustará. ¡Feliz Festival de Invierno!', 0);
-- El camino del protector
-- 8747, 8752, 8757
-- https://es.classic.wowhead.com/quest=8747
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8747, 8752, 8757) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8747, 'esES', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8752, 'esES', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8757, 'esES', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8747, 'esMX', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8752, 'esMX', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8757, 'esMX', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8747, 8752, 8757) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8747, 'esES', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8752, 'esES', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8757, 'esES', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8747, 'esMX', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8752, 'esMX', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0),
(8757, 'esMX', 'Impresionante, $gpequeño:pequeña;. Has pasado por muchos problemas para ganarte el favor del Vuelo de Bronce. Se nota tu dedicación.$B$BEl Sello del Vuelo de Bronce, ofrecerá una protección superior contra las fuerzas del mal.$B$BTen cuidado, una vez que hayas elegido tu camino, no tendrás nada en caso de que cambies de opinión.', 0);
-- El camino del protector
-- 8748, 8753, 8758
-- https://es.classic.wowhead.com/quest=8748
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8748, 8753, 8758) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8748, 'esES', 'Se ha reconocido su continua defensa de los niños de Kalimdor. Dame tu anillo de sello para que pueda potenciar sus poderes.', 0),
(8753, 'esES', 'Se ha reconocido su continua defensa de los niños de Kalimdor. Dame tu anillo de sello para que pueda potenciar sus poderes.', 0),
(8758, 'esES', 'Se ha reconocido su continua defensa de los niños de Kalimdor. Dame tu anillo de sello para que pueda potenciar sus poderes.', 0),
(8748, 'esMX', 'Se ha reconocido su continua defensa de los niños de Kalimdor. Dame tu anillo de sello para que pueda potenciar sus poderes.', 0),
(8753, 'esMX', 'Se ha reconocido su continua defensa de los niños de Kalimdor. Dame tu anillo de sello para que pueda potenciar sus poderes.', 0),
(8758, 'esMX', 'Se ha reconocido su continua defensa de los niños de Kalimdor. Dame tu anillo de sello para que pueda potenciar sus poderes.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8748, 8753, 8758) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8748, 'esES', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8753, 'esES', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8758, 'esES', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8748, 'esMX', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8753, 'esMX', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8758, 'esMX', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0);
-- El camino del protector
-- 8749, 8754, 8759
-- https://es.classic.wowhead.com/quest=8749
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8749, 8754, 8759) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8749, 'esES', 'Honras a los de mi especie, $n. ¡Derriba a los enemigos de Kalimdor! Muéstrales lo que significa desfigurar la tierra de la eterna luz de las estrellas.$B$BHas obtenido otra mejora. Dame tu anillo de sello para que pueda reforzar su poder.', 0),
(8754, 'esES', 'Honras a los de mi especie, $n. ¡Derriba a los enemigos de Kalimdor! Muéstrales lo que significa desfigurar la tierra de la eterna luz de las estrellas.$B$BHas obtenido otra mejora. Dame tu anillo de sello para que pueda reforzar su poder.', 0),
(8759, 'esES', 'Honras a los de mi especie, $n. ¡Derriba a los enemigos de Kalimdor! Muéstrales lo que significa desfigurar la tierra de la eterna luz de las estrellas.$B$BHas obtenido otra mejora. Dame tu anillo de sello para que pueda reforzar su poder.', 0),
(8749, 'esMX', 'Honras a los de mi especie, $n. ¡Derriba a los enemigos de Kalimdor! Muéstrales lo que significa desfigurar la tierra de la eterna luz de las estrellas.$B$BHas obtenido otra mejora. Dame tu anillo de sello para que pueda reforzar su poder.', 0),
(8754, 'esMX', 'Honras a los de mi especie, $n. ¡Derriba a los enemigos de Kalimdor! Muéstrales lo que significa desfigurar la tierra de la eterna luz de las estrellas.$B$BHas obtenido otra mejora. Dame tu anillo de sello para que pueda reforzar su poder.', 0),
(8759, 'esMX', 'Honras a los de mi especie, $n. ¡Derriba a los enemigos de Kalimdor! Muéstrales lo que significa desfigurar la tierra de la eterna luz de las estrellas.$B$BHas obtenido otra mejora. Dame tu anillo de sello para que pueda reforzar su poder.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8749, 8754, 8759) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8749, 'esES', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8754, 'esES', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8759, 'esES', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8749, 'esMX', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8754, 'esMX', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8759, 'esMX', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0);
-- El camino del protector
-- 8750, 8755, 8760
-- https://es.classic.wowhead.com/quest=8750
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8750, 8755, 8760) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8750, 'esES', 'Una dedicación de esta magnitud es una rareza. Has demostrado que tu voluntad es inquebrantable, $n. Serás $grecompensado:recompensada; por tu inquebrantable vigilancia de nuestro mundo.$B$BDame tu anillo de sello para que pueda fortalecer su encantamiento.', 0),
(8755, 'esES', 'Una dedicación de esta magnitud es una rareza. Has demostrado que tu voluntad es inquebrantable, $n. Serás $grecompensado:recompensada; por tu inquebrantable vigilancia de nuestro mundo.$B$BDame tu anillo de sello para que pueda fortalecer su encantamiento.', 0),
(8760, 'esES', 'Una dedicación de esta magnitud es una rareza. Has demostrado que tu voluntad es inquebrantable, $n. Serás $grecompensado:recompensada; por tu inquebrantable vigilancia de nuestro mundo.$B$BDame tu anillo de sello para que pueda fortalecer su encantamiento.', 0),
(8750, 'esMX', 'Una dedicación de esta magnitud es una rareza. Has demostrado que tu voluntad es inquebrantable, $n. Serás $grecompensado:recompensada; por tu inquebrantable vigilancia de nuestro mundo.$B$BDame tu anillo de sello para que pueda fortalecer su encantamiento.', 0),
(8755, 'esMX', 'Una dedicación de esta magnitud es una rareza. Has demostrado que tu voluntad es inquebrantable, $n. Serás $grecompensado:recompensada; por tu inquebrantable vigilancia de nuestro mundo.$B$BDame tu anillo de sello para que pueda fortalecer su encantamiento.', 0),
(8760, 'esMX', 'Una dedicación de esta magnitud es una rareza. Has demostrado que tu voluntad es inquebrantable, $n. Serás $grecompensado:recompensada; por tu inquebrantable vigilancia de nuestro mundo.$B$BDame tu anillo de sello para que pueda fortalecer su encantamiento.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8750, 8755, 8760) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8750, 'esES', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8755, 'esES', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8760, 'esES', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8750, 'esMX', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8755, 'esMX', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0),
(8760, 'esMX', 'Tu ascenso en el rango de la Prole es de lo más impresionante, $n. ¡Que nunca te desvíes del camino del protector!', 0);
-- 8751 El protector de Kalimdor
-- https://es.wowhead.com/quest=8751
SET @ID := 8751;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Nunca había visto tanta tenacidad! El Vuelo Bronce te concede un último encantamiento. ¡El mismísimo Atemporal así lo ha pedido!$B$BDame tu sello para que pueda hacer los ajustes necesarios.', 0),
(@ID, 'esMX', '¡Nunca había visto tanta tenacidad! El Vuelo Bronce te concede un último encantamiento. ¡El mismísimo Atemporal así lo ha pedido!$B$BDame tu sello para que pueda hacer los ajustes necesarios.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Arriba, $gprotector:protectora; de Kalimdor! ¡Levántate y obtén tu reconocimiento!', 0),
(@ID, 'esMX', '¡Arriba, $gprotector:protectora; de Kalimdor! ¡Levántate y obtén tu reconocimiento!', 0);
-- 8756 El conquistador qiraji
-- https://es.classic.wowhead.com/quest=8756
SET @ID := 8756;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Nunca había visto tanta tenacidad! El Vuelo de Bronce te otorga un encantamiento final. ¡El Atemporal mismo lo ha pedido así!$B$BEntrégame tu anillo de sello para que pueda hacer los ajustes necesarios.', 0),
(@ID, 'esMX', '¡Nunca había visto tanta tenacidad! El Vuelo de Bronce te otorga un encantamiento final. ¡El Atemporal mismo lo ha pedido así!$B$BEntrégame tu anillo de sello para que pueda hacer los ajustes necesarios.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Levántate, $gconquistador:conquistadora; Qiraji! ¡Levántate y sé $greconocido:reconocida;!', 0),
(@ID, 'esMX', '¡Levántate, $gconquistador:conquistadora; Qiraji! ¡Levántate y sé $greconocido:reconocida;!', 0);
-- 8761 El gran convocador
-- https://es.classic.wowhead.com/quest=8761
SET @ID := 8761;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Nunca había visto tanta tenacidad! El Vuelo Bronce te concede un último encantamiento. ¡El mismísimo Atemporal así lo ha pedido!$B$BDame tu sello para que pueda hacer los ajustes necesarios.', 0),
(@ID, 'esMX', '¡Nunca había visto tanta tenacidad! El Vuelo Bronce te concede un último encantamiento. ¡El mismísimo Atemporal así lo ha pedido!$B$BDame tu sello para que pueda hacer los ajustes necesarios.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Arriba, gran $gconvocador:convocadora;! ¡Yérguete y obtén tu reconocimiento!', 0),
(@ID, 'esMX', '¡Arriba, gran $gconvocador:convocadora;! ¡Yérguete y obtén tu reconocimiento!', 0);
-- Cambio de ruta: protector, nunca más
-- 8764, 8765, 8766
-- https://es.classic.wowhead.com/quest=8764
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8764, 8765, 8766) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8764, 'esES', '$gCampeón:Campeona;, si decides caminar por otro camino, regálame tu anillo de sello y una montaña de escarabajos de nuestros enemigos en Ahn\'Qiraj.', 0),
(8765, 'esES', '$gCampeón:Campeona;, si decides caminar por otro camino, regálame tu anillo de sello y una montaña de escarabajos de nuestros enemigos en Ahn\'Qiraj.', 0),
(8766, 'esES', '$gCampeón:Campeona;, si decides caminar por otro camino, regálame tu anillo de sello y una montaña de escarabajos de nuestros enemigos en Ahn\'Qiraj.', 0),
(8764, 'esMX', '$gCampeón:Campeona;, si decides caminar por otro camino, regálame tu anillo de sello y una montaña de escarabajos de nuestros enemigos en Ahn\'Qiraj.', 0),
(8765, 'esMX', '$gCampeón:Campeona;, si decides caminar por otro camino, regálame tu anillo de sello y una montaña de escarabajos de nuestros enemigos en Ahn\'Qiraj.', 0),
(8766, 'esMX', '$gCampeón:Campeona;, si decides caminar por otro camino, regálame tu anillo de sello y una montaña de escarabajos de nuestros enemigos en Ahn\'Qiraj.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8764, 8765, 8766) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8764, 'esES', 'Está bien, $n. Si cambias de opinión, estaré aquí para ayudarte.', 0),
(8765, 'esES', 'Está bien, $n. Si cambias de opinión, estaré aquí para ayudarte.', 0),
(8766, 'esES', 'Está bien, $n. Si cambias de opinión, estaré aquí para ayudarte.', 0),
(8764, 'esMX', 'Está bien, $n. Si cambias de opinión, estaré aquí para ayudarte.', 0),
(8765, 'esMX', 'Está bien, $n. Si cambias de opinión, estaré aquí para ayudarte.', 0),
(8766, 'esMX', 'Está bien, $n. Si cambias de opinión, estaré aquí para ayudarte.', 0);
-- Un obsequio ligeramente agitado
-- 8767, 8788
-- https://es.classic.wowhead.com/quest=8767
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8767, 8788) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8767, 'esES', 'Parece que han agitado este regalo un par de veces. Su etiqueta dice:$B$BPara $gun:una; $r $c muy especial.', 0),
(8788, 'esES', 'Parece que han agitado este regalo un par de veces. Su etiqueta dice:$B$BPara $gun:una; $r $c muy especial.', 0),
(8767, 'esMX', 'Parece que han agitado este regalo un par de veces. Su etiqueta dice:$B$BPara $gun:una; $r $c muy especial.', 0),
(8788, 'esMX', 'Parece que han agitado este regalo un par de veces. Su etiqueta dice:$B$BPara $gun:una; $r $c muy especial.', 0);
-- 8768 Un presente con envoltorio alegre
-- https://es.wowhead.com/quest=8768
SET @ID := 8768;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El regalo está envuelto con motivos propios de estas fiestas y tiene tu nombre.$B$BEspera, ¿no acaba de moverse?', 0),
(@ID, 'esMX', 'El regalo está envuelto con motivos propios de estas fiestas y tiene tu nombre.$B$BEspera, ¿no acaba de moverse?', 0);
-- 8769 Un presente que hace tic tac
-- https://es.classic.wowhead.com/quest=8769
SET @ID := 8769;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tus amigos de los Pastos de Bosquehumeante te desean unas felices Fiestas del Gran Invierno.', 0),
(@ID, 'esMX', 'Tus amigos de los Pastos de Bosquehumeante te desean unas felices Fiestas del Gran Invierno.', 0);
-- 8770 Objetivo: los defensores Colmen'Ashi
-- https://es.classic.wowhead.com/quest=8770
SET @ID := 8770;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo que decirme, $n?', 0),
(@ID, 'esMX', '¿Tienes algo que decirme, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo, $n. Tu diligencia es tan notable como siempre.', 0),
(@ID, 'esMX', 'Excelente trabajo, $n. Tu diligencia es tan notable como siempre.', 0);
-- 8771 Objetivo: los acecharenas Colmen'Ashi
-- https://es.classic.wowhead.com/quest=8771
SET @ID := 8771;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo que decirme, $n?', 0),
(@ID, 'esMX', '¿Tienes algo que decirme, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo, $n. Se ha notado tu participación en el ataque a Colmen\'Ashi.', 0),
(@ID, 'esMX', 'Excelente trabajo, $n. Se ha notado tu participación en el ataque a Colmen\'Ashi.', 0);
-- 8772 Objetivo: los oteadores de Colmen'Zora
-- https://es.classic.wowhead.com/quest=8772
SET @ID := 8772;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo que decirme, $n?', 0),
(@ID, 'esMX', '¿Tienes algo que decirme, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo, $n. Se ha notado tu participación en el ataque a Colmen\'Zora.', 0),
(@ID, 'esMX', 'Excelente trabajo, $n. Se ha notado tu participación en el ataque a Colmen\'Zora.', 0);
-- 8773 Objetivo: los atracadores de Colmen'Zora
-- https://es.classic.wowhead.com/quest=8773
SET @ID := 8773;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo que decirme, $n?', 0),
(@ID, 'esMX', '¿Tienes algo que decirme, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Escuché cosas buenas sobre tu participación en el ataque de Colmen\'Zora. Siguen con el buen trabajo y la victoria pronto será nuestra.', 0),
(@ID, 'esMX', 'Escuché cosas buenas sobre tu participación en el ataque de Colmen\'Zora. Siguen con el buen trabajo y la victoria pronto será nuestra.', 0);
-- Objetivo: los emboscadores Colmen'Regal
-- 8774, 8775, 8776, 8777
-- https://es.classic.wowhead.com/quest=8774
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8774, 8775, 8776, 8777) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8774, 'esES', '¿Tienes algo que decirme, $n?', 0),
(8775, 'esES', '¿Tienes algo que decirme, $n?', 0),
(8776, 'esES', '¿Tienes algo que decirme, $n?', 0),
(8777, 'esES', '¿Tienes algo que decirme, $n?', 0),
(8774, 'esMX', '¿Tienes algo que decirme, $n?', 0),
(8775, 'esMX', '¿Tienes algo que decirme, $n?', 0),
(8776, 'esMX', '¿Tienes algo que decirme, $n?', 0),
(8777, 'esMX', '¿Tienes algo que decirme, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8774, 8775, 8776, 8777) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8774, 'esES', 'Excelente trabajo, $n. Tu participación en el ataque a Colmen\'Regal ha sido notoria.', 0),
(8775, 'esES', 'Excelente trabajo, $n. Tu participación en el ataque a Colmen\'Regal ha sido notoria.', 0),
(8776, 'esES', 'Excelente trabajo, $n. Tu participación en el ataque a Colmen\'Regal ha sido notoria.', 0),
(8777, 'esES', 'Excelente trabajo, $n. Tu participación en el ataque a Colmen\'Regal ha sido notoria.', 0),
(8774, 'esMX', 'Excelente trabajo, $n. Tu participación en el ataque a Colmen\'Regal ha sido notoria.', 0),
(8775, 'esMX', 'Excelente trabajo, $n. Tu participación en el ataque a Colmen\'Regal ha sido notoria.', 0),
(8776, 'esMX', 'Excelente trabajo, $n. Tu participación en el ataque a Colmen\'Regal ha sido notoria.', 0),
(8777, 'esMX', 'Excelente trabajo, $n. Tu participación en el ataque a Colmen\'Regal ha sido notoria.', 0);

-- 8778 ¡La Brigada de Forjaz necesita explosivos!
-- https://es.classic.wowhead.com/quest=8778
SET @ID := 8778;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo que decirme, $n?', 0),
(@ID, 'esMX', '¿Tienes algo que decirme, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Ah, sí! ¡Estos serán útiles! ¡Muchas gracias, $n!', 0),
(@ID, 'esMX', '¡Ah, sí! ¡Estos serán útiles! ¡Muchas gracias, $n!', 0);
-- Materiales de visión
-- 8779, 8807
-- https://es.classic.wowhead.com/quest=8779
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8779, 8807) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8779, 'esES', '¿Tienes algo para mí, $n?', 0),
(8807, 'esES', '¿Tienes algo para mí, $n?', 0),
(8779, 'esMX', '¿Tienes algo para mí, $n?', 0),
(8807, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8779, 8807) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8779, 'esES', 'Pues sí... ¡serán de gran ayuda! Estos materiales son muy difíciles de conseguir en el desierto, $n. Gracias.', 0),
(8807, 'esES', 'Pues sí... ¡serán de gran ayuda! Estos materiales son muy difíciles de conseguir en el desierto, $n. Gracias.', 0),
(8779, 'esMX', 'Pues sí... ¡serán de gran ayuda! Estos materiales son muy difíciles de conseguir en el desierto, $n. Gracias.', 0),
(8807, 'esMX', 'Pues sí... ¡serán de gran ayuda! Estos materiales son muy difíciles de conseguir en el desierto, $n. Gracias.', 0);
-- 8780 Refuerzos para armadura para el campo de batalla
-- https://es.classic.wowhead.com/quest=8780
SET @ID := 8780;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo para mí, $n?', 0),
(@ID, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias, se las daré a los muchachos.', 0),
(@ID, 'esMX', 'Gracias, se las daré a los muchachos.', 0);
-- 8781 Armas para el campo de batalla
-- https://es.classic.wowhead.com/quest=8781
SET @ID := 8781;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo para mí, $n?', 0),
(@ID, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Oh, excelente! Ya no tendré que escuchar quejas sobre cuchillas desafiladas. Gracias, $n.', 0),
(@ID, 'esMX', '¡Oh, excelente! Ya no tendré que escuchar quejas sobre cuchillas desafiladas. Gracias, $n.', 0);
-- 8782 Suministros para uniformes
-- https://es.classic.wowhead.com/quest=8782
SET @ID := 8782;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo para mí, $n?', 0),
(@ID, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, los necesitábamos. Se agradece tu trabajo, $n.', 0),
(@ID, 'esMX', 'Ah, los necesitábamos. Se agradece tu trabajo, $n.', 0);
-- Materiales encantados
-- 8783, 8809
-- https://es.classic.wowhead.com/quest=8783
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8783, 8809) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8783, 'esES', '¿Tienes algo para mí, $n?', 0),
(8809, 'esES', '¿Tienes algo para mí, $n?', 0),
(8783, 'esMX', '¿Tienes algo para mí, $n?', 0),
(8809, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8783, 8809) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8783, 'esES', 'Ah, sí. Estos materiales son de excelente calidad. Gracias, $n.', 0),
(8809, 'esES', 'Ah, sí. Estos materiales son de excelente calidad. Gracias, $n.', 0),
(8783, 'esMX', 'Ah, sí. Estos materiales son de excelente calidad. Gracias, $n.', 0),
(8809, 'esMX', 'Ah, sí. Estos materiales son de excelente calidad. Gracias, $n.', 0);
-- 8784 Los secretos de los qiraji
-- https://es.classic.wowhead.com/quest=8784
SET @ID := 8784;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Estás brillante! Sé lo que eso significa...', 0),
(@ID, 'esMX', '¡Estás brillante! Sé lo que eso significa...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Un hallazgo extraordinario, $n. ¡Sencillamente maravilloso! Con esto seguro que lograremos penetrar en las perversas mentes de nuestro enemigo.', 0),
(@ID, 'esMX', 'Un hallazgo extraordinario, $n. ¡Sencillamente maravilloso! Con esto seguro que lograremos penetrar en las perversas mentes de nuestro enemigo.', 0);
-- 8785 ¡La Legión de Orgrimmar necesita mojo!
-- https://es.classic.wowhead.com/quest=8785
SET @ID := 8785;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes mis materiales, $n?', 0),
(@ID, 'esMX', '¿Tienes mis materiales, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, sí. ¡Justo lo que necesitaba! Haré un brebaje especial con esto. ¡Al silítido no le gustará nada!', 0),
(@ID, 'esMX', 'Ah, sí. ¡Justo lo que necesitaba! Haré un brebaje especial con esto. ¡Al silítido no le gustará nada!', 0);
-- 8786 Armas para el campo de batalla
-- https://es.classic.wowhead.com/quest=8786
SET @ID := 8786;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo para mí, $n?', 0),
(@ID, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente trabajo. Estábamos escasos de esto, $n.', 0),
(@ID, 'esMX', 'Excelente trabajo. Estábamos escasos de esto, $n.', 0);
-- 8787 Refuerzos para armadura para el campo de batalla
-- https://es.classic.wowhead.com/quest=8787
SET @ID := 8787;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo para mí, $n?', 0),
(@ID, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, sí... se los distribuiré a las tropas, $n. ¡La Legión de Orgrimmar te lo agradece!', 0),
(@ID, 'esMX', 'Ah, sí... se los distribuiré a las tropas, $n. ¡La Legión de Orgrimmar te lo agradece!', 0);
-- 8789 Armamentos imperiales qiraji
-- https://es.classic.wowhead.com/quest=8789
SET @ID := 8789;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Busca lo que te he pedido. Te convertirás en algo más grande que la suma de tus partes, $gcampeón:campeona;.', 0),
(@ID, 'esMX', 'Busca lo que te he pedido. Te convertirás en algo más grande que la suma de tus partes, $gcampeón:campeona;.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Imbuidas de elementium, estas armas atravesarán a los qiraji y a su dios con increíble facilidad.', 0),
(@ID, 'esMX', 'Imbuidas de elementium, estas armas atravesarán a los qiraji y a su dios con increíble facilidad.', 0);
-- 8790 Atavío imperial qiraji
-- https://es.classic.wowhead.com/quest=8790
SET @ID := 8790;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los abatirás y nos liberarás de estas cadenas.', 0),
(@ID, 'esMX', 'Los abatirás y nos liberarás de estas cadenas.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Usa bien el objeto, $n. Haz que sientan el dolor que tanto les gusta infligir a los demás.', 0),
(@ID, 'esMX', 'Usa bien el objeto, $n. Haz que sientan el dolor que tanto les gusta infligir a los demás.', 0);
-- 8791 La caída de Osirio
-- https://es.classic.wowhead.com/quest=8791
SET @ID := 8791;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, $n, ¡has regresado! Y $genterito:enterita;, si se me permite añadir. ¿Qué nuevas traes de Ahn\'Qiraj?', 0),
(@ID, 'esMX', 'Ah, $n, ¡has regresado! Y $genterito:enterita;, si se me permite añadir. ¿Qué nuevas traes de Ahn\'Qiraj?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Recibe mis más elevados elogios y el objeto de poder que prefieras, $n. Le has prestado un gran servicio al pueblo de Kalimdor.', 0),
(@ID, 'esMX', 'Recibe mis más elevados elogios y el objeto de poder que prefieras, $n. Le has prestado un gran servicio al pueblo de Kalimdor.', 0);
-- ¡La Horda te necesita!
-- 8792, 8793, 8794, 10500
-- https://es.classic.wowhead.com/quest=8792
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8792, 8793, 8794, 10500) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8792, 'esES', '¡Throm\'ka, $c! Es bueno ver a tantos miembros de la Horda, como tú, $n, salir a prestar tu apoyo para sentar las bases de la próxima Guerra de Ahn\'Qiraj. El esfuerzo aquí garantizará la victoria contra los silítidos y sus malvados amos escondidos dentro de Ahn\'Qiraj.$B$BAhora que estás aquí, asegúrese de hablar con los diversos recolectores y ofrecer tu ayuda para reunir los materiales que necesitan.', 0),
(8793, 'esES', '¡Throm\'ka, $c! Es bueno ver a tantos miembros de la Horda, como tú, $n, salir a prestar tu apoyo para sentar las bases de la próxima Guerra de Ahn\'Qiraj. El esfuerzo aquí garantizará la victoria contra los silítidos y sus malvados amos escondidos dentro de Ahn\'Qiraj.$B$BAhora que estás aquí, asegúrese de hablar con los diversos recolectores y ofrecer tu ayuda para reunir los materiales que necesitan.', 0),
(8794, 'esES', '¡Throm\'ka, $c! Es bueno ver a tantos miembros de la Horda, como tú, $n, salir a prestar tu apoyo para sentar las bases de la próxima Guerra de Ahn\'Qiraj. El esfuerzo aquí garantizará la victoria contra los silítidos y sus malvados amos escondidos dentro de Ahn\'Qiraj.$B$BAhora que estás aquí, asegúrese de hablar con los diversos recolectores y ofrecer tu ayuda para reunir los materiales que necesitan.', 0),
(10500, 'esES', '¡Throm\'ka, $c! Es bueno ver a tantos miembros de la Horda, como tú, $n, salir a prestar tu apoyo para sentar las bases de la próxima Guerra de Ahn\'Qiraj. El esfuerzo aquí garantizará la victoria contra los silítidos y sus malvados amos escondidos dentro de Ahn\'Qiraj.$B$BAhora que estás aquí, asegúrese de hablar con los diversos recolectores y ofrecer tu ayuda para reunir los materiales que necesitan.', 0),
(8792, 'esMX', '¡Throm\'ka, $c! Es bueno ver a tantos miembros de la Horda, como tú, $n, salir a prestar tu apoyo para sentar las bases de la próxima Guerra de Ahn\'Qiraj. El esfuerzo aquí garantizará la victoria contra los silítidos y sus malvados amos escondidos dentro de Ahn\'Qiraj.$B$BAhora que estás aquí, asegúrese de hablar con los diversos recolectores y ofrecer tu ayuda para reunir los materiales que necesitan.', 0),
(8793, 'esMX', '¡Throm\'ka, $c! Es bueno ver a tantos miembros de la Horda, como tú, $n, salir a prestar tu apoyo para sentar las bases de la próxima Guerra de Ahn\'Qiraj. El esfuerzo aquí garantizará la victoria contra los silítidos y sus malvados amos escondidos dentro de Ahn\'Qiraj.$B$BAhora que estás aquí, asegúrese de hablar con los diversos recolectores y ofrecer tu ayuda para reunir los materiales que necesitan.', 0),
(8794, 'esMX', '¡Throm\'ka, $c! Es bueno ver a tantos miembros de la Horda, como tú, $n, salir a prestar tu apoyo para sentar las bases de la próxima Guerra de Ahn\'Qiraj. El esfuerzo aquí garantizará la victoria contra los silítidos y sus malvados amos escondidos dentro de Ahn\'Qiraj.$B$BAhora que estás aquí, asegúrese de hablar con los diversos recolectores y ofrecer tu ayuda para reunir los materiales que necesitan.', 0),
(10500, 'esMX', '¡Throm\'ka, $c! Es bueno ver a tantos miembros de la Horda, como tú, $n, salir a prestar tu apoyo para sentar las bases de la próxima Guerra de Ahn\'Qiraj. El esfuerzo aquí garantizará la victoria contra los silítidos y sus malvados amos escondidos dentro de Ahn\'Qiraj.$B$BAhora que estás aquí, asegúrese de hablar con los diversos recolectores y ofrecer tu ayuda para reunir los materiales que necesitan.', 0);
-- 8798 Un yeti propio
-- https://es.classic.wowhead.com/quest=8798
SET @ID := 8798;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Vaya! ¡¿Sabes qué?! ¡Tú también eres $gingeniero:ingeniera;! Como me ayudaste a darles una lección a mis amigos, ¡voy a enseñarte a hacer tu propio yeti mecánico! ¡Ahora la diversión no va a parar nunca y podrás asustar a quien quieras! Siempre que puedas conseguir los componentes, claro.$B$B¿Qué dices, $n? ¿Quieres aprender los secretos para hacer un yeti mecánico?', 0),
(@ID, 'esMX', '¡Vaya! ¡¿Sabes qué?! ¡Tú también eres $gingeniero:ingeniera;! Como me ayudaste a darles una lección a mis amigos, ¡voy a enseñarte a hacer tu propio yeti mecánico! ¡Ahora la diversión no va a parar nunca y podrás asustar a quien quieras! Siempre que puedas conseguir los componentes, claro.$B$B¿Qué dices, $n? ¿Quieres aprender los secretos para hacer un yeti mecánico?', 0);
-- 8800 Equipamiento de Cenarius
-- https://es.classic.wowhead.com/quest=8800
SET @ID := 8800;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Kaldon te ha enviado? Muy bien, veamos lo que podemos hacer por ti.', 0),
(@ID, 'esMX', '¿Kaldon te ha enviado? Muy bien, veamos lo que podemos hacer por ti.', 0);
-- 8801 El legado de C'Thun
-- https://es.classic.wowhead.com/quest=8801
SET @ID := 8801;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Caelastrasz se arrodilla ante ti.>$B$B$gSeñor:Señona; $n, nos has liberado de sus garras.', 0),
(@ID, 'esMX', '<Caelastrasz se arrodilla ante ti.>$B$B$gSeñor:Señona; $n, nos has liberado de sus garras.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Abandonaremos este lugar, $gseñor:señora; $n, cuando estemos seguros de que el mal que lo impregna ha quedado completamente destruido. Tu viaje de leyenda casi toca a su fin.', 0),
(@ID, 'esMX', 'Abandonaremos este lugar, $gseñor:señora; $n, cuando estemos seguros de que el mal que lo impregna ha quedado completamente destruido. Tu viaje de leyenda casi toca a su fin.', 0);
-- 8802 La salvación de Kalimdor
-- https://es.classic.wowhead.com/quest=8802
SET @ID := 8802;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡$gSeñor:Señora; $n! Se acabó...', 0),
(@ID, 'esMX', '¡$gSeñor:Señora; $n! Se acabó...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'El Maestro ha dejado esto para ti, $gCampeón:Campeona;. Desde el alijo intemporal: una colección de artefactos de diferentes épocas; tú eliges.', 0),
(@ID, 'esMX', 'El Maestro ha dejado esto para ti, $gCampeón:Campeona;. Desde el alijo intemporal: una colección de artefactos de diferentes épocas; tú eliges.', 0);
-- 8803 Un obsequio festivo
-- https://es.wowhead.com/quest=8803
SET @ID := 8803;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'La nota de este regalo dice:$B$BPara $n:$B$Bcon la esperanza de que te ayude a repartir calor y felicidad por todo Azeroth.$B$BDe parte del Gran Padre Invierno.', 0),
(@ID, 'esMX', 'La nota de este regalo dice:$B$BPara $n:$B$Bcon la esperanza de que te ayude a repartir calor y felicidad por todo Azeroth.$B$BDe parte del Gran Padre Invierno.', 0);
-- Material de supervivencia en el desierto
-- 8804, 8805, 8806
-- https://es.classic.wowhead.com/quest=8804
DELETE FROM `quest_request_items_locale` WHERE `id` IN(8804, 8805, 8806) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(8804, 'esES', '¿Tienes algo para mí, $n?', 0),
(8805, 'esES', '¿Tienes algo para mí, $n?', 0),
(8806, 'esES', '¿Tienes algo para mí, $n?', 0),
(8804, 'esMX', '¿Tienes algo para mí, $n?', 0),
(8805, 'esMX', '¿Tienes algo para mí, $n?', 0),
(8806, 'esMX', '¿Tienes algo para mí, $n?', 0);
-- 8808 Suministros para uniformes
-- https://es.classic.wowhead.com/quest=8808
SET @ID := 8808;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo para mí, $n?', 0),
(@ID, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ah, las necesitábamos. Se agradece tu trabajo, $n.', 0),
(@ID, 'esMX', 'Ah, las necesitábamos. Se agradece tu trabajo, $n.', 0);
-- 8811 Un sello de honor
-- https://es.classic.wowhead.com/quest=8811
SET @ID := 8811;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Ventormenta.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Ventormenta.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8812 Un sello de honor
-- https://es.classic.wowhead.com/quest=8812
SET @ID := 8812;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Forjaz.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Forjaz.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8813 Un sello de honor
-- https://es.classic.wowhead.com/quest=8813
SET @ID := 8813;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Darnassus.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Darnassus.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8814 Un sello de honor
-- https://es.classic.wowhead.com/quest=8814
SET @ID := 8814;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con los Exiliados de Gnomeregan.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con los Exiliados de Gnomeregan.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8815 Un sello de honor
-- https://es.classic.wowhead.com/quest=8815
SET @ID := 8815;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Orgrimmar.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Orgrimmar.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8816 Un sello de honor
-- https://es.classic.wowhead.com/quest=8816
SET @ID := 8816;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Entrañas.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Entrañas.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8817 Un sello de honor
-- https://es.classic.wowhead.com/quest=8817
SET @ID := 8817;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Cima del Trueno.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Cima del Trueno.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8818 Un sello de honor
-- https://es.classic.wowhead.com/quest=8818
SET @ID := 8818;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con la tribu Lanza Negra.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con la tribu Lanza Negra.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8819 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8819
SET @ID := 8819;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Ventormenta. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Ventormenta. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8820 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8820
SET @ID := 8820;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Forjaz. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Forjaz. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8821 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8821
SET @ID := 8821;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Darnassus. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Darnassus. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8822 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8822
SET @ID := 8822;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas entre los Exiliados de Gnomeregan. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas entre los Exiliados de Gnomeregan. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);

-- 8823 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8823
SET @ID := 8823;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Orgrimmar. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Orgrimmar. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8824 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8824
SET @ID := 8824;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Entrañas. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Entrañas. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8825 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8825
SET @ID := 8825;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Cima del Trueno. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Cima del Trueno. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8826 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8826
SET @ID := 8826;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en la tribu Lanza Negra. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en la tribu Lanza Negra. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia..$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- Regalos del invierno
-- 8827, 8828
-- https://es.wowhead.com/quest=8827
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8827, 8828) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8827, 'esES', '¡Oh, hola! Solo puedes haber venido por una razón: para abrir tus regalos del Festival de Invierno.$B$BNo, no te preocupes, el Gran Padre Invierno no se ha olvidado de su $r $c $gfavorito:favorita;. Mira debajo del árbol y encontrarás tus regalos.$B$BEn estos días de generosidad, ¿no crees que a tus amigos les gustaría tener alguno de los excelentes productos de los Pastos de Bosquehumeante?', 0),
(8828, 'esES', '¡Oh, hola! Solo puedes haber venido por una razón: para abrir tus regalos del Festival de Invierno.$B$BNo, no te preocupes, el Gran Padre Invierno no se ha olvidado de su $r $c $gfavorito:favorita;. Mira debajo del árbol y encontrarás tus regalos.$B$BEn estos días de generosidad, ¿no crees que a tus amigos les gustaría tener alguno de los excelentes productos de los Pastos de Bosquehumeante?', 0),
(8827, 'esMX', '¡Oh, hola! Solo puedes haber venido por una razón: para abrir tus regalos del Festival de Invierno.$B$BNo, no te preocupes, el Gran Padre Invierno no se ha olvidado de su $r $c $gfavorito:favorita;. Mira debajo del árbol y encontrarás tus regalos.$B$BEn estos días de generosidad, ¿no crees que a tus amigos les gustaría tener alguno de los excelentes productos de los Pastos de Bosquehumeante?', 0),
(8828, 'esMX', '¡Oh, hola! Solo puedes haber venido por una razón: para abrir tus regalos del Festival de Invierno.$B$BNo, no te preocupes, el Gran Padre Invierno no se ha olvidado de su $r $c $gfavorito:favorita;. Mira debajo del árbol y encontrarás tus regalos.$B$BEn estos días de generosidad, ¿no crees que a tus amigos les gustaría tener alguno de los excelentes productos de los Pastos de Bosquehumeante?', 0);
-- 8829 El último engaño
-- https://es.classic.wowhead.com/quest=8829
SET @ID := 8829;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Tienes algo para mí, $n?', 0),
(@ID, 'esMX', '¿Tienes algo para mí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, creo que esto será suficiente. Lo confeccionaré con los colores usados por los emisarios del Martillo Crepuscular. Rezo a Elune para que mis habilidades puedan engañar a nuestros enemigos una vez más.$B$BPero no te preocupes por eso, has hecho tu parte y por eso serás $grecompensado:recompensada; apropiadamente. Eres $gun aliado:una aliada; leal y $gdigno:digna;, $n.', 0),
(@ID, 'esMX', 'Sí, creo que esto será suficiente. Lo confeccionaré con los colores usados por los emisarios del Martillo Crepuscular. Rezo a Elune para que mis habilidades puedan engañar a nuestros enemigos una vez más.$B$BPero no te preocupes por eso, has hecho tu parte y por eso serás $grecompensado:recompensada; apropiadamente. Eres $gun aliado:una aliada; leal y $gdigno:digna;, $n.', 0);
-- 8830 Un sello de honor
-- https://es.classic.wowhead.com/quest=8830
SET @ID := 8830;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Para aquellos aventureros que solo tengan un sello de honor, lo cambiaré por una pequeña cantidad de reconocimiento con Ventormenta.$B$BTen en cuenta que es mejor entregar una pila de diez sellos a la vez; tus esfuerzos recibirán un mayor reconocimiento al hacerlo. Ofrecemos un intercambio de sello único como servicio para aquellos que no tienen suficiente para una pila completa de diez.$B$BDicho esto, estoy lista para ayudarte si aún desea entregar un solo sello.', 0),
(@ID, 'esMX', 'Para aquellos aventureros que solo tengan un sello de honor, lo cambiaré por una pequeña cantidad de reconocimiento con Ventormenta.$B$BTen en cuenta que es mejor entregar una pila de diez sellos a la vez; tus esfuerzos recibirán un mayor reconocimiento al hacerlo. Ofrecemos un intercambio de sello único como servicio para aquellos que no tienen suficiente para una pila completa de diez.$B$BDicho esto, estoy lista para ayudarte si aún desea entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus acciones se han guardado en los registros y se te reconoce debidamente por tus esfuerzos. Sigue con el buen trabajo, $n.$B$BSi tienes más sellos para entregar, entonces puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus acciones se han guardado en los registros y se te reconoce debidamente por tus esfuerzos. Sigue con el buen trabajo, $n.$B$BSi tienes más sellos para entregar, entonces puedo seguir ayudándote.', 0);
-- 8831 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8831
SET @ID := 8831;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Ventormenta. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Ventormenta. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son $glos aventureros:las aventureras; como tú, $n, $glos:las; que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8832 Un sello de honor
-- https://es.classic.wowhead.com/quest=8832
SET @ID := 8832;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Entrañas.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Entrañas.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8833 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8833
SET @ID := 8833;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Entrañas. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Entrañas. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8834 Un sello de honor
-- https://es.classic.wowhead.com/quest=8834
SET @ID := 8834;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Forjaz.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Forjaz.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8835 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8835
SET @ID := 8835;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Forjaz. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Forjaz. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8836 Un sello de honor
-- https://es.classic.wowhead.com/quest=8836
SET @ID := 8836;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Darnassus.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Darnassus.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8837 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8837
SET @ID := 8837;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Darnassus. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Darnassus. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8838 Un sello de honor
-- https://es.classic.wowhead.com/quest=8838
SET @ID := 8838;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con los Exiliados de Gnomeregan.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con los Exiliados de Gnomeregan.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8839 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8839
SET @ID := 8839;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas entre los Exiliados de Gnomeregan. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas entre los Exiliados de Gnomeregan. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8840 Un sello de honor
-- https://es.classic.wowhead.com/quest=8840
SET @ID := 8840;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Orgrimmar.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Orgrimmar.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8841 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8841
SET @ID := 8841;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Orgrimmar. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Orgrimmar. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8842 Un sello de honor
-- https://es.classic.wowhead.com/quest=8842
SET @ID := 8842;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Cima del Trueno.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con Cima del Trueno.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8843 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8843
SET @ID := 8843;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Cima del Trueno. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en Cima del Trueno. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8844 Un sello de honor
-- https://es.classic.wowhead.com/quest=8844
SET @ID := 8844;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con la tribu Lanza Negra.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0),
(@ID, 'esMX', 'Si los aventureros solo tienen un sello de honor, se les entrega a cambio una pequeña cantidad de reputación con la tribu Lanza Negra.$B$BPor favor, no olvides que es mejor entregarme diez sellos al mismo tiempo, tus esfuerzos se verán mejor recompensados. Permitimos el intercambio de un solo sello como servicio para aquellos que no pueden completar un juego de diez.$B$BDicho esto, ya puedo ayudarte si sigues queriendo entregar un solo sello.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0),
(@ID, 'esMX', 'Muy bien, tus hazañas han sido registradas y tus esfuerzos han sido debidamente reconocidos. Sigue haciéndolo así, $c.$B$BSi tienes más sellos que entregar puedo seguir ayudándote.', 0);
-- 8845 Diez sellos de honor
-- https://es.classic.wowhead.com/quest=8845
SET @ID := 8845;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en la tribu Lanza Negra. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0),
(@ID, 'esMX', 'Acepto sellos de honor de los aventureros que los han conseguido cumpliendo con su deber. Por cada diez que me entregues me aseguraré de que tus hazañas sean reconocidas y admiradas en la tribu Lanza Negra. También acepto sellos de uno en uno, pero a cambio de un nivel mucho menor de reputación. Estamos mucho más interesados en las hazañas ligadas a un compromiso duradero... pero ningún acto queda ignorado.$B$BDicho esto, me encantaría tener tus sellos si estás $glisto:lista; para entregar un paquete.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0),
(@ID, 'esMX', '¡Excelente! El esfuerzo que has hecho para ganar estos sellos no es pequeño, y tus servicios serán debidamente reconocidos. Son los aventureros como tú, $n, los que marcan la diferencia.$B$BHazme saber si tienes más sellos que entregar. Será un placer ayudarte siempre que necesites hacer un intercambio.', 0);
-- 8857 Los secretos de los Colosos: Ashi
-- https://es.classic.wowhead.com/quest=8857
SET @ID := 8857;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Sí? ¿Qué llevas ahí?', 0),
(@ID, 'esMX', '¿Sí? ¿Qué llevas ahí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Qué magnífica coraza! ¡Buen trabajo!', 0),
(@ID, 'esMX', '¡Qué magnífica coraza! ¡Buen trabajo!', 0);
-- 8858 Los secretos de los Colosos: Regal
-- https://es.classic.wowhead.com/quest=8858
SET @ID := 8858;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Mmm...', 0),
(@ID, 'esMX', 'Mmm...', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Magnífico; con esto se podría crear una armadura excelente. Ten, la recompensa prometida.', 0),
(@ID, 'esMX', 'Magnífico; con esto se podría crear una armadura excelente. Ten, la recompensa prometida.', 0);
-- 8859 Los secretos de los Colosos: Zora
-- https://es.classic.wowhead.com/quest=8859
SET @ID := 8859;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Eso que llevas parece pesado.', 0),
(@ID, 'esMX', 'Eso que llevas parece pesado.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Justo a tiempo! ¡Buen trabajo!', 0),
(@ID, 'esMX', '¡Justo a tiempo! ¡Buen trabajo!', 0);
-- 8861 ¡Las fiestas de Año Nuevo!
-- https://es.classic.wowhead.com/quest=8861
SET @ID := 8861;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Buen día, $n! ¿Viniste a Cima del Trueno para nuestras celebraciones? ¿O estás aquí para descansar entre cacerías?', 0),
(@ID, 'esMX', '¡Buen día, $n! ¿Viniste a Cima del Trueno para nuestras celebraciones? ¿O estás aquí para descansar entre cacerías?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Oh muy bien! ¡Estos suministros ayudarán a alimentar a nuestra gente para celebrar el año nuevo!$B$BGracias, $n. Estoy en deuda contigo. Por favor, toma estas monedas... y sigue mi consejo: bebe con entusiasmo de los barriles de afuera y únete a nuestros juerguistas en un baile de celebración.', 0),
(@ID, 'esMX', '¡Oh muy bien! ¡Estos suministros ayudarán a alimentar a nuestra gente para celebrar el año nuevo!$B$BGracias, $n. Estoy en deuda contigo. Por favor, toma estas monedas... y sigue mi consejo: bebe con entusiasmo de los barriles de afuera y únete a nuestros juerguistas en un baile de celebración.', 0);
-- 8862 Vela de Elune
-- https://es.classic.wowhead.com/quest=8862
SET @ID := 8862;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'La vela de Elune es un artefacto de gran reverencia para los discípulos del Festival Lunar. ¡Guardada dentro de la vela está la verdadera luz de la luna, lista para ser desatada!$B$BEsta luz es inofensiva para la mayoría de las criaturas, pero encontrarás que Omen y sus secuaces se queman y deslumbran con ella.', 0),
(@ID, 'esMX', 'La vela de Elune es un artefacto de gran reverencia para los discípulos del Festival Lunar. ¡Guardada dentro de la vela está la verdadera luz de la luna, lista para ser desatada!$B$BEsta luz es inofensiva para la mayoría de las criaturas, pero encontrarás que Omen y sus secuaces se queman y deslumbran con ella.', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, acepto estas monedas de linaje. Por favor, llévate la vela de Elune con mi bendición. Además, disfruta de estos fuegos artificiales de cortesía.$B$BQue tu Festival Lunar sea jubiloso y lleno de alegría, $n.$B$BY si eliges enfrentarte a Omen y sus secuaces, encontrarás la vela de Elune bastante útil...', 0),
(@ID, 'esMX', 'Muy bien, acepto estas monedas de linaje. Por favor, llévate la vela de Elune con mi bendición. Además, disfruta de estos fuegos artificiales de cortesía.$B$BQue tu Festival Lunar sea jubiloso y lleno de alegría, $n.$B$BY si eliges enfrentarte a Omen y sus secuaces, encontrarás la vela de Elune bastante útil...', 0);
-- 8863 Albóndigas festivas
-- https://es.classic.wowhead.com/quest=8863
SET @ID := 8863;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Excelente, disfruta de estas albóndigas con mis cumplidos. Si bien no son más que una pequeña muestra de agradecimiento por el honor que te has traído a ti $gmismo:misma; a través de tus acciones, creo que las disfrutarás de todos modos.$B$BSi tienes más monedas de linaje, estoy listo para ofrecerte una amplia gama de artículos a cambio.', 0),
(@ID, 'esMX', 'Excelente, disfruta de estas albóndigas con mis cumplidos. Si bien no son más que una pequeña muestra de agradecimiento por el honor que te has traído a ti $gmismo:misma; a través de tus acciones, creo que las disfrutarás de todos modos.$B$BSi tienes más monedas de linaje, estoy listo para ofrecerte una amplia gama de artículos a cambio.', 0);
-- 8864 Vestidos para el Festival Lunar
-- https://es.classic.wowhead.com/quest=8864
SET @ID := 8864;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tengo una selección de vestidos que te pueden interesar. Estos vestidos se han usado en el pasado durante el Festival Lunar, y la selección que tengo hoy es quizás la mejor que he visto. Cada uno está hecho a mano únicamente con los componentes más finos y suaves.$B$BA cambio de algunas monedas de linaje, te dejaré elegir uno de los tres estilos que tengo y lo podrás conservar como tuyo. ¿Esto es aceptable para ti?', 0),
(@ID, 'esMX', 'Tengo una selección de vestidos que te pueden interesar. Estos vestidos se han usado en el pasado durante el Festival Lunar, y la selección que tengo hoy es quizás la mejor que he visto. Cada uno está hecho a mano únicamente con los componentes más finos y suaves.$B$BA cambio de algunas monedas de linaje, te dejaré elegir uno de los tres estilos que tengo y lo podrás conservar como tuyo. ¿Esto es aceptable para ti?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, acepto estas monedas de linaje. Por favor, llévate tu vestido con mi bendición. Además, disfruta de estos fuegos artificiales de cortesía.$B$BComo has honrado a tus mayores, me honras a mí con tu mera presencia. Gracias, y que tu Festival Lunar sea feliz.', 0),
(@ID, 'esMX', 'Muy bien, acepto estas monedas de linaje. Por favor, llévate tu vestido con mi bendición. Además, disfruta de estos fuegos artificiales de cortesía.$B$BComo has honrado a tus mayores, me honras a mí con tu mera presencia. Gracias, y que tu Festival Lunar sea feliz.', 0);
-- 8865 Trajes pantalón para el Festival Lunar
-- https://es.classic.wowhead.com/quest=8865
SET @ID := 8865;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Me complace informarte que tengo una excelente selección de pantalones festivos disponibles para que los poseas... pero solo a cambio de monedas de linaje. Si la moda es importante para ti, ¡esto es lo que estás buscando! Te aseguro que no encontrarás pantalones como estos en ningún otro lugar.$B$BA cambio de algunas monedas de linaje, te dejaré elegir uno de los tres estilos que tengo y será tuyo. ¿Esto es aceptable para ti?', 0),
(@ID, 'esMX', 'Me complace informarte que tengo una excelente selección de pantalones festivos disponibles para que los poseas... pero solo a cambio de monedas de linaje. Si la moda es importante para ti, ¡esto es lo que estás buscando! Te aseguro que no encontrarás pantalones como estos en ningún otro lugar.$B$BA cambio de algunas monedas de linaje, te dejaré elegir uno de los tres estilos que tengo y será tuyo. ¿Esto es aceptable para ti?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Muy bien, acepto estas monedas de linaje. Por favor, llévate tu pantalón con mi bendición. Además, disfruta de estos fuegos artificiales de cortesía.$B$BSi tienes más monedas de linaje para comerciar, vuelve a hablar conmigo. Ofreceré varios artículos durante todo el Festival Lunar.', 0),
(@ID, 'esMX', 'Muy bien, acepto estas monedas de linaje. Por favor, llévate tu pantalón con mi bendición. Además, disfruta de estos fuegos artificiales de cortesía.$B$BSi tienes más monedas de linaje para comerciar, vuelve a hablar conmigo. Ofreceré varios artículos durante todo el Festival Lunar.', 0);
-- 8866 Barbabronce el Ancestro
-- https://es.wowhead.com/quest=8866
SET @ID := 8866;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0),
(@ID, 'esMX', 'Me alegra saber que la gente de estas tierras sigue prestando homenaje a las antiguas razas. Te deseo todo lo mejor, $n, y te ofrezco esta muestra...', 0);
-- 8867 Fuegos artificiales lunares
-- https://es.wowhead.com/quest=8867
SET @ID := 8867;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Fuegos artificiales lunares disparados', `ObjectiveText2` = 'Cohetes lunares disparados', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Encontraste los lanzacohetes, $n?', 0),
(@ID, 'esMX', '¿Encontraste los lanzacohetes, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Bien hecho, $n.$B$BAhora que ya estás metido en el ambiente, ¿por qué no aceptas esta invitación al Festival Lunar?$B$BEs una celebración fantástica si tienes algo de tiempo. Hay comida, bebida, se cuentan cuentos y... claro, ¡hay más fuegos artificiales!$B$BAbre la invitación cuando estés dentro del círculo de La Gran Luz de Luna y serás transportado directamente al Claro de la Luna.', 0),
(@ID, 'esMX', 'Bien hecho, $n.$B$BAhora que ya estás metido en el ambiente, ¿por qué no aceptas esta invitación al Festival Lunar?$B$BEs una celebración fantástica si tienes algo de tiempo. Hay comida, bebida, se cuentan cuentos y... claro, ¡hay más fuegos artificiales!$B$BAbre la invitación cuando estés dentro del círculo de La Gran Luz de Luna y serás transportado directamente al Claro de la Luna.', 0);
-- 8868 La bendición de Elune
-- https://es.wowhead.com/quest=8868
SET @ID := 8868;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Buen trabajo, $n. Augurio no puede morir porque tiene la bendición de Elune, pero al menos reposará tranquilo un año más.$B$BBrindemos por el poder de Augurio, por el tuyo, $n, y porque has dado un poco de paz al héroe.', 0),
(@ID, 'esMX', 'Buen trabajo, $n. Augurio no puede morir porque tiene la bendición de Elune, pero al menos reposará tranquilo un año más.$B$BBrindemos por el poder de Augurio, por el tuyo, $n, y porque has dado un poco de paz al héroe.', 0);
-- El Festival Lunar
-- 8870, 8871, 8872, 8873, 8874, 8875
-- https://es.classic.wowhead.com/quest=8870
DELETE FROM `quest_offer_reward_locale` WHERE `id` IN(8870, 8871, 8872, 8873, 8874, 8875) AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8870, 'esES', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8871, 'esES', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8872, 'esES', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8873, 'esES', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8874, 'esES', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8875, 'esES', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8870, 'esMX', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8871, 'esMX', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8872, 'esMX', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8873, 'esMX', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8874, 'esMX', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0),
(8875, 'esMX', 'Te doy la bienvenida, $n. ¿Vienes a unirte a nuestras celebraciones?', 0);

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

-- 9142 Libranza del artesano
-- https://es.classic.wowhead.com/quest=9142
SET @ID := 9142;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Te lo has ganado, don nadie. Ahora, no llores por tus órdenes. Llénalos o destrúyelos.', 0),
(@ID, 'esMX', 'Te lo has ganado, don nadie. Ahora, no llores por tus órdenes. Llénalos o destrúyelos.', 0);
-- 9151 El Sagrario del Sol
-- https://es.wowhead.com/quest=9151
SET @ID := 9151;
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Te envía Darenis? Bueno, supongo que tu ayuda nos vendrá bien para luchar contra las huestes de Dar\'Khan.', 0),
(@ID, 'esMX', '¿Te envía Darenis? Bueno, supongo que tu ayuda nos vendrá bien para luchar contra las huestes de Dar\'Khan.', 0);
-- 9153 Bajo la Sombra
-- https://es.classic.wowhead.com/quest=9153
SET @ID := 9153;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Eliminar esta amenaza llevará tiempo. ¿Estás $gdispuesto:dispuesta;, $n?', 0),
(@ID, 'esMX', 'Eliminar esta amenaza llevará tiempo. ¿Estás $gdispuesto:dispuesta;, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Buen trabajo, $n. Pese a las derrotas, conseguiremos rechazar la amenaza de la Peste.$B$BDescansa ahora, pero después tendrás que volver al campo de batalla para defender el terreno ganado hoy.$B$BSi nos traes más runas necróticas, te las cambiaremos por objetos especiales que te ayudarán en tus batallas futuras.', 0),
(@ID, 'esMX', 'Buen trabajo, $n. Pese a las derrotas, conseguiremos rechazar la amenaza de la Peste.$B$BDescansa ahora, pero después tendrás que volver al campo de batalla para defender el terreno ganado hoy.$B$BSi nos traes más runas necróticas, te las cambiaremos por objetos especiales que te ayudarán en tus batallas futuras.', 0);
-- 9164 Cautivos en la Ciudad de la Muerte
-- https://es.wowhead.com/quest=9164
SET @ID := 9164;
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Boticaria Enith rescatada', `ObjectiveText2` = 'Aprendiz Varnis rescatado', `ObjectiveText4` = 'Forestal Vedoran rescatado', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Qué fue de los prisioneros en la Ciudad de la Muerte? ¿Ya te has aventurado allí?', 0),
(@ID, 'esMX', '¿Qué fue de los prisioneros en la Ciudad de la Muerte? ¿Ya te has aventurado allí?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Gracias, $n. Sin ti esos prisioneros habrían perdido el juicio y el alma a manos de la Plaga.', 0),
(@ID, 'esMX', 'Gracias, $n. Sin ti esos prisioneros habrían perdido el juicio y el alma a manos de la Plaga.', 0);
-- 9165 La libranza de salvoconducto
-- https://es.classic.wowhead.com/quest=9165
SET @ID := 9165;
UPDATE `quest_template_locale` SET `ObjectiveText2` = 'Salvoconducto firmado', `VerifiedBuild` = 0 WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Nombre, rango y número de serie!', 0),
(@ID, 'esMX', '¡Nombre, rango y número de serie!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<El comandante de envios Metz toma la orden y la firma.>$B$BExcelente trabajo, $n. ¡Sobresaliente incluso! Toma esto como muestra de nuestro agradecimiento. Sin juego de palabras, don nadie.', 0),
(@ID, 'esMX', '<El comandante de envios Metz toma la orden y la firma.>$B$BExcelente trabajo, $n. ¡Sobresaliente incluso! Toma esto como muestra de nuestro agradecimiento. Sin juego de palabras, don nadie.', 0);
-- 9167 La muerte del traidor
-- https://es.wowhead.com/quest=9167
SET @ID := 9167;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Lo has hecho? ¿Has matado a Dar\'Khan?', 0),
(@ID, 'esMX', '¿Lo has hecho? ¿Has matado a Dar\'Khan?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Has asestado un golpe mortal al dominio de la Plaga en esta región.$B$BAhora que ha muerto el traidor, no tardaremos en recuperar nuestras tierras y nuestra grandeza.', 0),
(@ID, 'esMX', 'Has asestado un golpe mortal al dominio de la Plaga en esta región.$B$BAhora que ha muerto el traidor, no tardaremos en recuperar nuestras tierras y nuestra grandeza.', 0);
-- 9170 Los tenientes de Dar'Khan
-- https://es.wowhead.com/quest=9170
SET @ID := 9170;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Has logrado cortar la cadena de mando de la Plaga, $n? ¿Están muertos los lugartenientes de Dar\'Khan?', 0),
(@ID, 'esMX', '¿Has logrado cortar la cadena de mando de la Plaga, $n? ¿Están muertos los lugartenientes de Dar\'Khan?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡El ejército de Dar\'Khan se derrumba! La Plaga no tiene ninguna posibilidad de resistir ante el poder conjunto de los sin\'dorei y los Renegados.', 0),
(@ID, 'esMX', '¡El ejército de Dar\'Khan se derrumba! La Plaga no tiene ninguna posibilidad de resistir ante el poder conjunto de los sin\'dorei y los Renegados.', 0);
-- 9175 El collar de Sylvanas
-- https://es.wowhead.com/quest=9175
SET @ID := 9175;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Qué tienes ahí, $n?', 0),
(@ID, 'esMX', '¿Qué tienes ahí, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡¿Dices que lo tenía uno de los miembros de la Plaga en la Aguja Brisaveloz y que hay una inscripción?! ¡A ver!$B$BAquí tienes, una moneda por un buen trabajo.', 0),
(@ID, 'esMX', '¡¿Dices que lo tenía uno de los miembros de la Plaga en la Aguja Brisaveloz y que hay una inscripción?! ¡A ver!$B$BAquí tienes, una moneda por un buen trabajo.', 0);
-- 9178 Libranza del artesano: contrapeso denso
-- https://es.classic.wowhead.com/quest=9178
SET @ID := 9178;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $n?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sí, estos serán útiles para las armas de ataque de la infantería.', 0),
(@ID, 'esMX', 'Sí, estos serán útiles para las armas de ataque de la infantería.', 0);
-- 9179 Libranza del artesano: peto de placas imperiales
-- https://es.classic.wowhead.com/quest=9179
SET @ID := 9179;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $n?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Más armaduras para las tropas! ¡Fantástico, $n!', 0),
(@ID, 'esMX', '¡Más armaduras para las tropas! ¡Fantástico, $n!', 0);
-- 9180 Viaje a Entrañas
-- https://es.wowhead.com/quest=9180
SET @ID := 9180;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Y tú eres...?$B$B¿Qué traes ahí? Ese collar me suena. ¡Dámelo!', 0),
(@ID, 'esMX', '¿Y tú eres...?$B$B¿Qué traes ahí? Ese collar me suena. ¡Dámelo!', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<Sylvanas te arranca el collar de las manos.>$B$B¡No puede ser! Después de tanto tiempo, lo creía perdido para siempre.$B$B<Al cabo de un momento parece volver en sí y recobra la compostura.>$B$B¿Creías que esto me haría gracia? ¿Pensabas acaso que añoro los tiempos anteriores a mi reinado sobre los Renegados? Como tú, esto no significa nada para mí, y Alleria Brisaveloz no es más que un lejano recuerdo!$B$B<Arroja el amuleto al suelo.>$B$BPuedes retirarte, $c.', 0),
(@ID, 'esMX', '<Sylvanas te arranca el collar de las manos.>$B$B¡No puede ser! Después de tanto tiempo, lo creía perdido para siempre.$B$B<Al cabo de un momento parece volver en sí y recobra la compostura.>$B$B¿Creías que esto me haría gracia? ¿Pensabas acaso que añoro los tiempos anteriores a mi reinado sobre los Renegados? Como tú, esto no significa nada para mí, y Alleria Brisaveloz no es más que un lejano recuerdo!$B$B<Arroja el amuleto al suelo.>$B$BPuedes retirarte, $c.', 0);
-- 9181 Libranza del artesano: martillo volcánico
-- https://es.classic.wowhead.com/quest=9181
SET @ID := 9181;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $n?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estos deberían ir bien con las densas piedras de peso que estamos acumulando.', 0),
(@ID, 'esMX', 'Estos deberían ir bien con las densas piedras de peso que estamos acumulando.', 0);
-- 9182 Libranza del artesano: hacha de batalla de torio enorme
-- https://es.classic.wowhead.com/quest=9182
SET @ID := 9182;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $n?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'No son tan grandes como esperaba. Pero, un trato es un trato.', 0),
(@ID, 'esMX', 'No son tan grandes como esperaba. Pero, un trato es un trato.', 0);
-- 9183 Libranza del artesano: aro radiante
-- https://es.classic.wowhead.com/quest=9183
SET @ID := 9183;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $n?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $n?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Todavía no puedo creer que Metz espere que nuestras tropas usen esta basura de baja calidad para protegerse de los congelados ataques de la Plaga.', 0),
(@ID, 'esMX', 'Todavía no puedo creer que Metz espere que nuestras tropas usen esta basura de baja calidad para protegerse de los congelados ataques de la Plaga.', 0);
-- 9184 Libranza del artesano: cinta de cuero maligno
-- https://es.classic.wowhead.com/quest=9184
SET @ID := 9184;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estos son... malignos.', 0),
(@ID, 'esMX', 'Estos son... malignos.', 0);
-- 9185 Libranza del artesano: refuerzo para armadura basto
-- https://es.classic.wowhead.com/quest=9185
SET @ID := 9185;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los refuerzos de armadura tienen muchos usos, $n. No son SOLO para mejorar ciertas piezas de armadura para mayor protección. Como esta de aquí, la voy a usar como tetera acogedora.', 0),
(@ID, 'esMX', 'Los refuerzos de armadura tienen muchos usos, $n. No son SOLO para mejorar ciertas piezas de armadura para mayor protección. Como esta de aquí, la voy a usar como tetera acogedora.', 0);
-- 9186 Libranza del artesano: cinturón de cuero maligno
-- https://es.classic.wowhead.com/quest=9186
SET @ID := 9186;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estos cinturones son en realidad más malignos que las cintas para la cabeza, si puedes creer que tal cosa es posible.', 0),
(@ID, 'esMX', 'Estos cinturones son en realidad más malignos que las cintas para la cabeza, si puedes creer que tal cosa es posible.', 0);
-- 9187 Libranza del artesano: pantalones de cuero rúnico
-- https://es.classic.wowhead.com/quest=9187
SET @ID := 9187;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Los druidas definitivamente apreciarán la artesanía que se empleó en la fabricación de estos pantalones. Muchas gracias, $n.', 0),
(@ID, 'esMX', 'Los druidas definitivamente apreciarán la artesanía que se empleó en la fabricación de estos pantalones. Muchas gracias, $n.', 0);
-- 9188 Libranza del artesano: pantalones de paño brillante
-- https://es.classic.wowhead.com/quest=9188
SET @ID := 9188;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Casi puedo ver mi reflejo en estas cosas! Esto es una locura.', 0),
(@ID, 'esMX', '¡Casi puedo ver mi reflejo en estas cosas! Esto es una locura.', 0);
-- 9189 Entrega a El Sepulcro
-- https://es.wowhead.com/quest=9189
SET @ID := 9189;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Saludos, $ghermano:hermana;. ¿Qué novedades traes?', 0),
(@ID, 'esMX', 'Saludos, $ghermano:hermana;. ¿Qué novedades traes?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Veo aquí que el Embajador Penasol tiene grandes esperanzas en tu continuo ascenso como un valor para los sin\'dorei. Sin embargo, desafortunado ese asunto con Lady Sylvanas. No le hagas caso, $n, hiciste lo correcto al devolverle el collar. Debería haber estado agradecida, pero así es la realeza.$B$BMientras estés aquí, si decides ayudar con las tareas de los Renegados, comportate lo mejor que puedas. No querrías dañar nuestro nuevo vínculo con la Horda, ¿verdad?', 0),
(@ID, 'esMX', 'Veo aquí que el Embajador Penasol tiene grandes esperanzas en tu continuo ascenso como un valor para los sin\'dorei. Sin embargo, desafortunado ese asunto con Lady Sylvanas. No le hagas caso, $n, hiciste lo correcto al devolverle el collar. Debería haber estado agradecida, pero así es la realeza.$B$BMientras estés aquí, si decides ayudar con las tareas de los Renegados, comportate lo mejor que puedas. No querrías dañar nuestro nuevo vínculo con la Horda, ¿verdad?', 0);
-- 9190 Libranza del artesano: botas de paño rúnico
-- https://es.classic.wowhead.com/quest=9190
SET @ID := 9190;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡Por la barba de Barbabronce! Me has traido botas de paño rúnico... Supongo que perdí esa apuesta.', 0),
(@ID, 'esMX', '¡Por la barba de Barbabronce! Me has traido botas de paño rúnico... Supongo que perdí esa apuesta.', 0);
-- 9191 Libranza del artesano: bolsa de paño rúnico
-- https://es.classic.wowhead.com/quest=9191
SET @ID := 9191;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡$gBendito:Bendita; seas! ¿Son esos lo que creo que son? Las tropas se han estado quejando sin parar por la falta de espacio de almacenamiento para todo lo que se requiere mientras están en el campo. Uno de ellos incluso me dibujó un diagrama...$B$BEstos definitivamente ayudarán a aliviar algunos de los lloriqueos.', 0),
(@ID, 'esMX', '¡$gBendito:Bendita; seas! ¿Son esos lo que creo que son? Las tropas se han estado quejando sin parar por la falta de espacio de almacenamiento para todo lo que se requiere mientras están en el campo. Uno de ellos incluso me dibujó un diagrama...$B$BEstos definitivamente ayudarán a aliviar algunos de los lloriqueos.', 0);
-- 9194 Libranza del artesano: toga de paño rúnico
-- https://es.classic.wowhead.com/quest=9194
SET @ID := 9194;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¡No deberías haberlo hecho! No, en serio, no deberías haberlo hecho. No sé qué está pensando Metz, pero nadie usará estas túnicas en Naxxramas.$B$B<El maestro de manada Mazadura suspira.>$B$BBah, tendré que transferir otro montón de basura al frente y otra reprimenda más del Mariscal de campo Cuevas.', 0),
(@ID, 'esMX', '¡No deberías haberlo hecho! No, en serio, no deberías haberlo hecho. No sé qué está pensando Metz, pero nadie usará estas túnicas en Naxxramas.$B$B<El maestro de manada Mazadura suspira.>$B$BBah, tendré que transferir otro montón de basura al frente y otra reprimenda más del Mariscal de campo Cuevas.', 0);
-- 9195 Libranza del artesano: carga de zapador goblin
-- https://es.classic.wowhead.com/quest=9195
SET @ID := 9195;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Ahora estás hablando mi idioma, $n. Cosas que hacen BOOM!', 0),
(@ID, 'esMX', 'Ahora estás hablando mi idioma, $n. Cosas que hacen BOOM!', 0);
-- 9196 Libranza del artesano: granada de torio
-- https://es.classic.wowhead.com/quest=9196
SET @ID := 9196;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Deben haber costado una bonita pieza de cobre. ¿Tengo razón o tengo razón, $n?', 0),
(@ID, 'esMX', 'Deben haber costado una bonita pieza de cobre. ¿Tengo razón o tengo razón, $n?', 0);
-- 9197 Libranza del artesano: gallo de batalla gnómico
-- https://es.classic.wowhead.com/quest=9197
SET @ID := 9197;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Por qué sonríes? ¿Que es tan gracioso? Escucha, $gseñorito:señorita;, un pollo de batalla gnómico es una unidad muy importante y no debe tomarse a la ligera, NUNCA. Los enviamos a áreas que podrían estar muy plagadas o infestadas y limpian cualquier insecto plagado o gusanos carroñeros que aún puedan estar revoloteando. Todo el mundo sabe que los robots son inmunes a la plaga.$B$BApuesto a que no te sientes tan inteligente ahora, ¿verdad? Maniquí grande...', 0),
(@ID, 'esMX', '¿Por qué sonríes? ¿Que es tan gracioso? Escucha, $gseñorito:señorita;, un pollo de batalla gnómico es una unidad muy importante y no debe tomarse a la ligera, NUNCA. Los enviamos a áreas que podrían estar muy plagadas o infestadas y limpian cualquier insecto plagado o gusanos carroñeros que aún puedan estar revoloteando. Todo el mundo sabe que los robots son inmunes a la plaga.$B$BApuesto a que no te sientes tan inteligente ahora, ¿verdad? Maniquí grande...', 0);
-- 9198 Libranza del artesano: tubo de torio
-- https://es.classic.wowhead.com/quest=9198
SET @ID := 9198;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Tubos de torio? Vaya, gracias.$B$B<El maestro de manada Mazadura arroja la pila de tubos de torio a una gran pila de chatarra variada.>', 0),
(@ID, 'esMX', 'Tubos de torio? Vaya, gracias.$B$B<El maestro de manada Mazadura arroja la pila de tubos de torio a una gran pila de chatarra variada.>', 0);
-- 9200 Libranza del artesano: poción de maná sublime
-- https://es.classic.wowhead.com/quest=9200
SET @ID := 9200;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'La utilidad de esto debería ser evidente.', 0),
(@ID, 'esMX', 'La utilidad de esto debería ser evidente.', 0);
-- 9201 Libranza del artesano: poción de Protección contra lo Arcano superior
-- https://es.classic.wowhead.com/quest=9201
SET @ID := 9201;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '<El Maestro de manada Mazadura abre una de las pociones de protección arcana y bebe un trago.>$B$B¡WOOT! ¡Esto ta pega una patada en el pecho, bebé! ¡Una buena patada!', 0),
(@ID, 'esMX', '<El Maestro de manada Mazadura abre una de las pociones de protección arcana y bebe un trago.>$B$B¡WOOT! ¡Esto ta pega una patada en el pecho, bebé! ¡Una buena patada!', 0);
-- 9202 Libranza del artesano: poción de sanación sublime
-- https://es.classic.wowhead.com/quest=9202
SET @ID := 9202;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Sabes cómo las llaman las tropas en el frente? Sacerdotes embotellados...$B$B<Canta el maestro de manada Mazadura.>$B$B"Soy tu sacerdote embotellado bebé... tienes que beberme de la manera correcta..."$B$B¿Qué pasa $ghijo:hija;? Es una canción muy popular en estos lugares.', 0),
(@ID, 'esMX', '¿Sabes cómo las llaman las tropas en el frente? Sacerdotes embotellados...$B$B<Canta el maestro de manada Mazadura.>$B$B"Soy tu sacerdote embotellado bebé... tienes que beberme de la manera correcta..."$B$B¿Qué pasa $ghijo:hija;? Es una canción muy popular en estos lugares.', 0);
-- 9203 Libranza del artesano: poción de petrificación
-- https://es.classic.wowhead.com/quest=9203
SET @ID := 9203;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Sin comentarios.$B$B<El maestro de manada Mazadura te fulmina con la mirada.>$B$B¡Dije sin comentarios! ¡Ahora sal de mi vista!', 0),
(@ID, 'esMX', 'Sin comentarios.$B$B<El maestro de manada Mazadura te fulmina con la mirada.>$B$B¡Dije sin comentarios! ¡Ahora sal de mi vista!', 0);
-- 9204 Libranza del artesano: anguila escama pétrea
-- https://es.classic.wowhead.com/quest=9204
SET @ID := 9204;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Podrías haber usado esto para otra cosa, pero no lo hiciste, ¿verdad? No sirve de nada llorar por eso ahora, $n.', 0),
(@ID, 'esMX', 'Podrías haber usado esto para otra cosa, pero no lo hiciste, ¿verdad? No sirve de nada llorar por eso ahora, $n.', 0);
-- 9205 Libranza del artesano: pez coraza de placas
-- https://es.classic.wowhead.com/quest=9205
SET @ID := 9205;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Realmente no sabes para qué son?$B$B<El maestro de manada Mazadura se ríe.>$B$B¡Como te diría...!', 0),
(@ID, 'esMX', '¿Realmente no sabes para qué son?$B$B<El maestro de manada Mazadura se ríe.>$B$B¡Como te diría...!', 0);
-- 9206 Libranza del artesano: anguila relámpago
-- https://es.classic.wowhead.com/quest=9206
SET @ID := 9206;
DELETE FROM `quest_request_items_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`id`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(@ID, 'esES', '¿Completando una orden de trabajo, $c?', 0),
(@ID, 'esMX', '¿Completando una orden de trabajo, $c?', 0);
DELETE FROM `quest_offer_reward_locale` WHERE `id` = @ID AND `locale` IN('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`id`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(@ID, 'esES', 'Estos hacen los mejores rollos de anguila del mundo. Eso es así - DE TODO EL MUNDO.', 0),
(@ID, 'esMX', 'Estos hacen los mejores rollos de anguila del mundo. Eso es así - DE TODO EL MUNDO.', 0);
