-- DB update 2022_11_13_00 -> 2022_11_15_00
-- Fire brigade esES / esMX
DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (11360, 11439, 11440, 11449, 11450, 11361) AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(11360, 'esES', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
(11439, 'esES', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
(11440, 'esES', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
(11360, 'esMX', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
(11439, 'esMX', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
(11440, 'esMX', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
(11449, 'esES', 'Bien hecho, $N. Niños, prestad atención a $geste:esta; $c. Deja que sea un buen ejemplo para vosotros.', 0),
(11450, 'esES', 'Bien hecho, $N. Niños, prestad atención a $geste:esta; $c. Deja que sea un buen ejemplo para vosotros.', 0),
(11361, 'esES', 'Bien hecho, $N. Niños, prestad atención a $geste:esta; $c. Deja que sea un buen ejemplo para vosotros.', 0),
(11449, 'esMX', 'Bien hecho, $N. Niños, prestad atención a $geste:esta; $c. Deja que sea un buen ejemplo para vosotros.', 0),
(11450, 'esMX', 'Bien hecho, $N. Niños, prestad atención a $geste:esta; $c. Deja que sea un buen ejemplo para vosotros.', 0),
(11361, 'esMX', 'Bien hecho, $N. Niños, prestad atención a $geste:esta; $c. Deja que sea un buen ejemplo para vosotros.', 0);
	
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Apaga fuegos' WHERE `id` = 11360 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Apaga fuegos' WHERE `id` = 11439 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Apaga fuegos' WHERE `id` = 11440 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Apaga fuegos' WHERE `id` = 11449 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Apaga fuegos' WHERE `id` = 11450 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `ObjectiveText1` = 'Apaga fuegos' WHERE `id` = 11361 AND `locale` IN ('esES', 'esMX');

DELETE FROM `quest_request_items_locale` WHERE `ID` IN (11360, 11439, 11440, 11449, 11450, 11361) AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(11360, 'esES', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
(11439, 'esES', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
(11440, 'esES', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
(11360, 'esMX', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
(11439, 'esMX', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
(11440, 'esMX', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
(11449, 'esES', '¿Has apagado algún fuego, $N? El área de entrenamiento está al oeste de Rémol.', 0),
(11450, 'esES', '¿Has apagado algún fuego, $N? El área de entrenamiento está al oeste de Rémol.', 0),
(11361, 'esES', '¿Has apagado algún fuego, $N? El área de entrenamiento está al oeste de Rémol.', 0),
(11449, 'esMX', '¿Has apagado algún fuego, $N? El área de entrenamiento está al oeste de Rémol.', 0),
(11450, 'esMX', '¿Has apagado algún fuego, $N? El área de entrenamiento está al oeste de Rémol.', 0),
(11361, 'esMX', '¿Has apagado algún fuego, $N? El área de entrenamiento está al oeste de Rémol.', 0);

