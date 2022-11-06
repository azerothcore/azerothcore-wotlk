-- Fire brigade esES / esMX
INSERT INTO quest_offer_reward_locale (ID, locale, RewardText, VerifiedBuild) VALUES
	(11360, 'esES', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
	(11439, 'esES', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
	(11440, 'esES', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
    (11360, 'esMX', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
	(11439, 'esMX', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0),
	(11440, 'esMX', '¡Estás mojado y lleno de ceniza! ¡Tienes que haber estado apagando fuegos!$b$b¡Bien hecho! Como miembro honorífico de la brigada de bomberos, te ruego que regreses si alguna vez te necesitamos.', 0);
	
	UPDATE quest_template_locale SET ObjectiveText1 = 'Apaga fuegos' WHERE id = 11360 AND (locale = 'esES' OR locale = 'esMX');
	UPDATE quest_template_locale SET ObjectiveText1 = 'Apaga fuegos' WHERE id = 11439 AND (locale = 'esES' OR locale = 'esMX');
	UPDATE quest_template_locale SET ObjectiveText1 = 'Apaga fuegos' WHERE id = 11440 AND (locale = 'esES' OR locale = 'esMX');

INSERT INTO quest_request_items_locale (ID, locale, CompletionText, VerifiedBuild) VALUES 
	(11360, 'esES', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
	(11439, 'esES', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
	(11440, 'esES', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
    (11360, 'esMX', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
	(11439, 'esMX', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0),
	(11440, 'esMX', 'Hola, $N. ¿Has estado perfeccionando tu técnica como bombero? ¡No te olvides del area de práctica al norte!', 0);
