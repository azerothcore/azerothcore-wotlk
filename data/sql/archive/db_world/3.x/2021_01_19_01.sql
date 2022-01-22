-- DB update 2021_01_19_00 -> 2021_01_19_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_19_00 2021_01_19_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1607503600897995800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607503600897995800');

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (783, 5261, 33, 18, 6, 3903, 3904, 3905, 15, 21, 3105, 3101, 3102, 3103, 3100, 3104, 5623, 5624, 54, 2158, 47, 60, 61, 1097, 62, 76, 40, 239, 11, 176, 35, 52, 83, 5545, 37, 45, 71, 39, 59, 46, 106, 111, 107, 114, 88, 85, 86, 84, 87, 16) AND `locale` IN ('esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(783,'esES','Ah, bien. Otro voluntario. Estamos recibiendo muchos de ustedes estos días. Espero que sean suficientes.$B$BLas tierras humanas están siendo amenazadas desde afuera, y muchas de nuestras fuerzas han sido preparadas en el extranjero. Esto, a su vez, deja espacio para que los grupos corruptos y sin ley prosperen dentro de nuestras fronteras.$B$BEs una batalla de muchos frentes, más que nosotros $N. Prepárese para una larga campaña.',18019),
(5261,'esES','Es verdad. Estoy buscando a alguien para cazarme lobos! ¿Acaso eres esa persona?',18019),
(33,'esES','Fue una tarea oscura amigo, pero usted ayudó con su parte de la negociación.$B$BTengo algunas cosas aquí que probablemente quieras tomar.¡A tú elección! ',18019),
(18,'esES','De vuelta con algunos pañuelos, ya veo. El ejército de ventormenta aprecia su ayuda.',18019),
(6,'esES','¡Hah, tú lo atrapaste! ¡Has hecho un gran servicio a Elwynn, y por ese motivo te has ganado una buena recompensa!',18019),
(3903,'esES','¿El sargento Willem te dijo que hablaras conmigo? Es un hombre valiente y siempre dispuesto a ayudar, pero sus duquetes lo mantienen atrapado en la abadía de villanorte y me temo que el problema que tengo hoy está más allá de él.$B$B¿Tal vez usted pueda ayudarme? ',18019),
(3904,'esES','¡Oh, gracias $N! ¡Salvaste mi cosecha! Y espero que haya mostrado a algunos de esos defias que no pueden causar más problemas por aquí.$B$BTal vez nos falten guardias hoy en día ¡pero tenemos suerte de que héroes como tú nos protejan! ',18019),
(3905,'esES','Vamos a ver aquí...$B$B¡Oh, Dios mío! ¡Las uvas de Milly han sido salvadas! ¡Cuando ella me dijo que los bandidos invadían sus viñedos casi me desesperaba, pero mi fe en la luz no vacila!$B$B¡Y a través de tu valentía, ahora tenemos uvas para más vino! ¡Que la luz te bendiga $N y por favor mantente a salvo!',18019),
(15,'esES','No me gusta oír hablar de todos estos kobolds en nuestra mina. No pueden salir bien de aquí, por favor tome esto como pago y cuando esté listo hable conmigo de nuevo. Me gustaría que volviera a las minas una vez más...',18019),
(21,'esES','Una vez más, te has ganado mi respeto y la gratitud del ejército de ventormenta. Todavía pueden haber kobolds en la mina, pero luego iré yo mismo y otros soldados para ponerles fin. Por el momento, tenemos otra tarea para usted. ',18019),
(3105,'esES','A medida que creces en poder, serás tentado, siempre debes recordar para poder controlarse usted mismo. No voy a mentir, la corrupción puede llegar a cualquier practicante de lo arcano; especialmente uno que trata con criaturas del infierno retorcido. Sea paciente y sea prudente, pero no dejes que eso reprima tu ambición.$B$BA medida que crezcas serás más poderoso, vuelve a mí y te enseñaré más acerca de nuestros caminos.',18019),
(3101,'esES','Mientras tanto, deberías saber una o dos cosas más. Usted es un símbolo para muchos aquí en esta tierra, actúe por consiguiente. La luz sagrada brilla dentro de ti, y será obvio para tus aliados y tus enemigos.$B$BAdemás, mientras ganas sabiduría y poder, necesitarás entrenar para aprender nuevas habilidades. Ahí es donde entro yo. Cuando usted siente que ha ganado una cierta experiencia aquí en villanorte, vuelva a mí y le enseñaré todo lo que sé, esté listo para aprender. ¡Buena suerte... Paladín!',18019),
(3102,'esES','Te encontrarás con mucha gente que desea nuestras habilidades $N. Aventureros, IV:7... diablos, incluso la hermandad defias querría un espía o dos dentro de ventormenta. Pero recuerda esto, eres tu propio jefe. ¡No dejes que nadie te use para hacer algo que no quieras! Además, tenemos todas las cartas... hasta que termine la partida.$B$BDe todos modos, sólo quería presentarme y hacer saber que estoy aquí si necesitas cualquier entrenamiento. Ven cuando desees.',18019),
(3103,'esES','A medida que tu creces en experiencia, puedes regresar a mí, haré lo que pueda para impartir mis conocimientos sobre ti. Hasta entonces, ve con compasión en tu corazón, y deja que la sabiduría sea tu guía. Recuerda, el mundo sólo se convierte en un lugar mejor si lo haces así.',18019),
(3100,'esES','Vete al valle, apréndete el diseño de la tierra y vuelve a mí cuando necesites entrenamiento. Yo estaré aquí noche y día.$B$BLos caballeros de la mano de plata han hecho bien en hacer este lugar bastante seguro, pero como usted se reúne con otros ciudadanos, encontrará que todos ellos tienen problemas, aún así podrían utilizar la ayuda de un $C para solucionarlos. Buena suerte. ',18019),
(3104,'esES','Ja ja, yo sabía que mi nota no te disuadiría de tu camino. Entonces, estás preparado, ¿no? ¿Preparado para aceptar su destino? ¿Preparado para desafiar a los dioses y a cualquier otra fuerza que se le presentara ante usted en el cumplimiento del conocimiento y el poder?$B$BNo le mentiré $N, usted será temido tanto como respetado. Pero también sepa esto, voy a estar aquí cuando necesite entrenamiento. Simplemente búscame a medida que te hagas más poderoso.',18019),
(5623,'esES','Me alegro de que haya venido $N. Tenemos mucho que discutir sobre su futuro y su camino dentro de la luz.',18019),
(5624,'esES','Excelente $N con un protector más sano allí afuera para ayudar a la ciudad, estaremos mucho más seguros. Me alegra ver que ya estás aprendiendo a usar tus habilidades sabiamente. Si sientes que estás listo para más entrenamiento en cualquier momento, por favor vuelva a mí. Pero por ahora, llévate esta bata. Hará que otros sepan que eres una de nuestras órdenes. Si no quiere ponérselo, está bien. Más tarde habrá más pruebas y esta túnica no es necesaria para hacer eso.',18019),
(54,'esES','Aquí dice que le han otorgado el estatus de diputado con los alguaciles de ventormenta. Felicitaciones.$B$BY buena suerte manteniendo a Elwynn seguro, no es un picnic... Aunque con la mayoría del ejército ocupado haciendo quien sabe qué, para quién sabe qué noble!$B$BEs difícil hacer un seguimiento de la política en estos días tan oscuros...',18019),
(2158,'esES','Descanso y relajación para el cansancio y el frío ¡Ese es nuestro lema! Por favor, tome asiento junto al fuego y deje descansar sus huesos.$B$B¿Le gustaría probar una muestra de buena comida y bebida?',18019),
(47,'esES','Gracias por el polvo $N. Aquí está su efectivo y... Aquí está un símbolo de los asociados de mi parte. Puede que lo encuentres útil. ¡Útil útil!',18019),
(60,'esES','Estabas ocupado cazando kobolds, ¿no? Gracias por las velas $N, y aquí está su recompensa...',18019),
(61,'esES','Aquí está su pago, y mientras está aquí... ¡Mira a tu alrededor! Estoy seguro de que tenemos una poción u otra baratija que usted encontrará útil.',18019),
(1097,'esES','¿Estás aquí para ayudar con mi entrega? ¡Muy bien!',18019),
(62,'esES','Esto es una mala noticia. ¿Qué sigue? ¿¡dragones!? Tendremos que aumentar nuestras patrullas cerca de aquella mina. Gracias por sus esfuerzos $N. espere un momento... Podría tener otra tarea para usted.',18019),
(76,'esES','¿Kobolds en la cantera de jaspe, dices? Maldición! La situación se agrava por el momento.$B$BGracias por el informe $N, pero desearía que el informe que trajiste hibiesen sido buenas noticias.',18019),
(40,'esES','Sí, hablé con Remy. Lo respeto como comerciante, aunque todos los informes de murlocs hacia el este han sido muy tontos en el mejor de los casos.$B$BSus preocupaciones son obvias, pero a menos que reciba un informe militar de una amenaza murloc, no podemos permitirnos enviar más tropas hacia el este.',18019),
(239,'esES','El mariscal Dughan te envió, ¿eh? Bueno, tú no pareces del ejército, pero si Dughan te envió aquí ¡es suficiente para mí!$B$BNuestra situación es, por lo menos, un tanto estresante. Espero que nos des una mano.',18019),
(11,'esES','¡Veo que has estado ocupado! Tienes nuestro agradecimiento $N',18019),
(176,'esES','¡Bien hecho! ¡Estaba pensando que nadie derribaría a ese monstruo!$B$BAquí tienes $N, y gracias, ese Gnoll me estaba dando un dolor de cabeza ¡del tamaño del clan roca negra!',18019),
(35,'esES','Sí, los murlocs se han asentado en esta zona, y alrededor de los arroyos del oriente de Elwynn. No sabemos por qué están aquí, pero son agresivos y al menos semi-inteligentes.',18019),
(52,'esES','Muchas gracias por la ayuda $N. Algo en el bosque debe estar haciendo estos animales tan audaces.$B$BSea lo que sea, espero que se quede ahí.',18019),
(83,'esES','Ah, estos son pañuelos bonitos, pero son un poco ásperos...$B$BAquí tienes!',18019),
(5545,'esES','¡Excelente! Muchas gracias, debería ser capaz de completar la orden a tiempo. Para mostrar mi gratitud, me gustaría ofrecerte algunas monedas como compensación por su ayuda.$B$BGracias y adiós.',18019),
(37,'esES','Aunque el cadáver ha sido despojado en gran parte, cerca se encuentra tirado un medallón con las palabras: "Footman Malakai Stone" grabadas sobre él.',18019),
(45,'esES','Encuentras alrededor del cuello del cadáver un medallón de metal con las palabras inscritas: "Footman Rolf Hartford".',18019),
(71,'esES','Has confirmado mis temores $N. Los murlocs son una amenaza que no podemos ignorar.',18019),
(39,'esES','Hmm, esta noticia es preocupante. Ya nuestras defensas eran limitadas y perder a Rolf y Malakai por culpa de esos murlocs nos puso en una posición aún peor.$B$BSi las cosas no mejoran, ¡Habrá peleas en villadorada al final de la semana!',18019),
(59,'esES','Ah, gracias por el material. Por favor, siéntase libre de elegir su armadura.$B$BBuena suerte valiente $C, y que esta armadura te sirva bien.',18019),
(46,'esES','¿Tienes las aletas? ¡Genial! El alguacil Dughan estará ansioso de saber más acerca de la situación murloc en el este de Elwynn, me gustaría decirle que ahora todo está bajo control.$B$BGracias a tus acciones nos hemos dado cuenta de este problema.',18019),
(106,'esES','¡Ah! No puedo soportar que nos separemos. ¡Tengo que verla!',18019),
(111,'esES','Mientras que nuestras familias estén peleando, Tommy Joe y Maybell no tienen mucho futuro, pero... tal vez podamos reunirlos sólo por un rato.$B$BHm, ¿qué podemos hacer...?',18019),
(107,'esES','Mi corazón se sale con esas dos pobres almas, Maybell y Tommy Joe. Recuerdo una vez haber sido joven y enamorado.$B$B¡Debe haber algo que pueda hacer para ayudarles! Déjame pensar.',18019),
(114,'esES','¡Oh...yo! Me siento culpable engañando a mi familia, pero mis sentimientos por Tommy Joe son demasiado fuertes como para ignorarlos.$B$BGracias $N. Beberé este licor tan pronto como sea. Tengo la oportunidad, y no quiero alejarme de mi amor.$B$BY para ti... por favor toma esto.',18019),
(88,'esES','¡Gracias a Dios! Ese cerdo se estaba poniendo tan gordo que había comido toda nuestra cosecha! Gracias $N.$B$B¿Alguno de estos te queda bien? ',18019),
(85,'esES','¿Perdiste un qué? Bueno, yo no tomé ningún collar ¡porque yo no soy un ladrón!$B$BPodría saber quién lo hizo, pero... <Sonrisa>... tengo demasiado hambre para recordar.',18019),
(86,'esES','Aunque esta carne de jabalí es salvaje, podría cocinarla a fuego lento ¡sería suficiente para que cualquier tarta sea sabrosa!',18019),
(84,'esES','¡Mm, ñam ñam! ¡Esta tarta es la mejor!$B$BCreo que mi memoria está regresando...',18019),
(87,'esES','¡Oh, lo encontraste! ¡Gracias, gracias!$B$BToma, toma esto. Era de mi marido y él siempre dijo que era de buena suerte. ¡Ojalá no lo hubiera olvidado en su última campaña! *Suspiro* ',18019),
(16,'esES','Gracias $N y vuelve si quieres intercambiar de nuevo.',18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (783, 5261, 33, 18, 6, 3903, 3904, 3905, 15, 21, 3105, 3101, 3102, 3103, 3100, 3104, 5623, 5624, 54, 2158, 47, 60, 61, 1097, 62, 76, 40, 239, 11, 176, 35, 52, 83, 5545, 37, 45, 71, 39, 59, 46, 106, 111, 107, 114, 88, 85, 86, 84, 87, 16) AND `locale` IN ('esMX');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(783,'esMX','Ah, bien. Otro voluntario. Estamos recibiendo muchos de ustedes estos días. Espero que sean suficientes.$B$BLas tierras humanas están siendo amenazadas desde afuera, y muchas de nuestras fuerzas han sido preparadas en el extranjero. Esto, a su vez, deja espacio para que los grupos corruptos y sin ley prosperen dentro de nuestras fronteras.$B$BEs una batalla de muchos frentes, más que nosotros $N. Prepárese para una larga campaña.',18019),
(5261,'esMX','Es verdad. Estoy buscando a alguien para cazarme lobos! ¿Acaso eres esa persona?',18019),
(33,'esMX','Fue una tarea oscura amigo, pero usted ayudó con su parte de la negociación.$B$BTengo algunas cosas aquí que probablemente quieras tomar.¡A tú elección! ',18019),
(18,'esMX','De vuelta con algunos pañuelos, ya veo. El ejército de ventormenta aprecia su ayuda.',18019),
(6,'esMX','¡Hah, tú lo atrapaste! ¡Has hecho un gran servicio a Elwynn, y por ese motivo te has ganado una buena recompensa!',18019),
(3903,'esMX','¿El sargento Willem te dijo que hablaras conmigo? Es un hombre valiente y siempre dispuesto a ayudar, pero sus duquetes lo mantienen atrapado en la abadía de villanorte y me temo que el problema que tengo hoy está más allá de él.$B$B¿Tal vez usted pueda ayudarme? ',18019),
(3904,'esMX','¡Oh, gracias $N! ¡Salvaste mi cosecha! Y espero que haya mostrado a algunos de esos defias que no pueden causar más problemas por aquí.$B$BTal vez nos falten guardias hoy en día ¡pero tenemos suerte de que héroes como tú nos protejan! ',18019),
(3905,'esMX','Vamos a ver aquí...$B$B¡Oh, Dios mío! ¡Las uvas de Milly han sido salvadas! ¡Cuando ella me dijo que los bandidos invadían sus viñedos casi me desesperaba, pero mi fe en la luz no vacila!$B$B¡Y a través de tu valentía, ahora tenemos uvas para más vino! ¡Que la luz te bendiga $N y por favor mantente a salvo!',18019),
(15,'esMX','No me gusta oír hablar de todos estos kobolds en nuestra mina. No pueden salir bien de aquí, por favor tome esto como pago y cuando esté listo hable conmigo de nuevo. Me gustaría que volviera a las minas una vez más...',18019),
(21,'esMX','Una vez más, te has ganado mi respeto y la gratitud del ejército de ventormenta. Todavía pueden haber kobolds en la mina, pero luego iré yo mismo y otros soldados para ponerles fin. Por el momento, tenemos otra tarea para usted. ',18019),
(3105,'esMX','A medida que creces en poder, serás tentado, siempre debes recordar para poder controlarse usted mismo. No voy a mentir, la corrupción puede llegar a cualquier practicante de lo arcano; especialmente uno que trata con criaturas del infierno retorcido. Sea paciente y sea prudente, pero no dejes que eso reprima tu ambición.$B$BA medida que crezcas serás más poderoso, vuelve a mí y te enseñaré más acerca de nuestros caminos.',18019),
(3101,'esMX','Mientras tanto, deberías saber una o dos cosas más. Usted es un símbolo para muchos aquí en esta tierra, actúe por consiguiente. La luz sagrada brilla dentro de ti, y será obvio para tus aliados y tus enemigos.$B$BAdemás, mientras ganas sabiduría y poder, necesitarás entrenar para aprender nuevas habilidades. Ahí es donde entro yo. Cuando usted siente que ha ganado una cierta experiencia aquí en villanorte, vuelva a mí y le enseñaré todo lo que sé, esté listo para aprender. ¡Buena suerte... Paladín!',18019),
(3102,'esMX','Te encontrarás con mucha gente que desea nuestras habilidades $N. Aventureros, IV:7... diablos, incluso la hermandad defias querría un espía o dos dentro de ventormenta. Pero recuerda esto, eres tu propio jefe. ¡No dejes que nadie te use para hacer algo que no quieras! Además, tenemos todas las cartas... hasta que termine la partida.$B$BDe todos modos, sólo quería presentarme y hacer saber que estoy aquí si necesitas cualquier entrenamiento. Ven cuando desees.',18019),
(3103,'esMX','A medida que tu creces en experiencia, puedes regresar a mí, haré lo que pueda para impartir mis conocimientos sobre ti. Hasta entonces, ve con compasión en tu corazón, y deja que la sabiduría sea tu guía. Recuerda, el mundo sólo se convierte en un lugar mejor si lo haces así.',18019),
(3100,'esMX','Vete al valle, apréndete el diseño de la tierra y vuelve a mí cuando necesites entrenamiento. Yo estaré aquí noche y día.$B$BLos caballeros de la mano de plata han hecho bien en hacer este lugar bastante seguro, pero como usted se reúne con otros ciudadanos, encontrará que todos ellos tienen problemas, aún así podrían utilizar la ayuda de un $C para solucionarlos. Buena suerte. ',18019),
(3104,'esMX','Ja ja, yo sabía que mi nota no te disuadiría de tu camino. Entonces, estás preparado, ¿no? ¿Preparado para aceptar su destino? ¿Preparado para desafiar a los dioses y a cualquier otra fuerza que se le presentara ante usted en el cumplimiento del conocimiento y el poder?$B$BNo le mentiré $N, usted será temido tanto como respetado. Pero también sepa esto, voy a estar aquí cuando necesite entrenamiento. Simplemente búscame a medida que te hagas más poderoso.',18019),
(5623,'esMX','Me alegro de que haya venido $N. Tenemos mucho que discutir sobre su futuro y su camino dentro de la luz.',18019),
(5624,'esMX','Excelente $N con un protector más sano allí afuera para ayudar a la ciudad, estaremos mucho más seguros. Me alegra ver que ya estás aprendiendo a usar tus habilidades sabiamente. Si sientes que estás listo para más entrenamiento en cualquier momento, por favor vuelva a mí. Pero por ahora, llévate esta bata. Hará que otros sepan que eres una de nuestras órdenes. Si no quiere ponérselo, está bien. Más tarde habrá más pruebas y esta túnica no es necesaria para hacer eso.',18019),
(54,'esMX','Aquí dice que le han otorgado el estatus de diputado con los alguaciles de ventormenta. Felicitaciones.$B$BY buena suerte manteniendo a Elwynn seguro, no es un picnic... Aunque con la mayoría del ejército ocupado haciendo quien sabe qué, para quién sabe qué noble!$B$BEs difícil hacer un seguimiento de la política en estos días tan oscuros...',18019),
(2158,'esMX','Descanso y relajación para el cansancio y el frío ¡Ese es nuestro lema! Por favor, tome asiento junto al fuego y deje descansar sus huesos.$B$B¿Le gustaría probar una muestra de buena comida y bebida?',18019),
(47,'esMX','Gracias por el polvo $N. Aquí está su efectivo y... Aquí está un símbolo de los asociados de mi parte. Puede que lo encuentres útil. ¡Útil útil!',18019),
(60,'esMX','Estabas ocupado cazando kobolds, ¿no? Gracias por las velas $N, y aquí está su recompensa...',18019),
(61,'esMX','Aquí está su pago, y mientras está aquí... ¡Mira a tu alrededor! Estoy seguro de que tenemos una poción u otra baratija que usted encontrará útil.',18019),
(1097,'esMX','¿Estás aquí para ayudar con mi entrega? ¡Muy bien!',18019),
(62,'esMX','Esto es una mala noticia. ¿Qué sigue? ¿¡dragones!? Tendremos que aumentar nuestras patrullas cerca de aquella mina. Gracias por sus esfuerzos $N. espere un momento... Podría tener otra tarea para usted.',18019),
(76,'esMX','¿Kobolds en la cantera de jaspe, dices? Maldición! La situación se agrava por el momento.$B$BGracias por el informe $N, pero desearía que el informe que trajiste hibiesen sido buenas noticias.',18019),
(40,'esMX','Sí, hablé con Remy. Lo respeto como comerciante, aunque todos los informes de murlocs hacia el este han sido muy tontos en el mejor de los casos.$B$BSus preocupaciones son obvias, pero a menos que reciba un informe militar de una amenaza murloc, no podemos permitirnos enviar más tropas hacia el este.',18019),
(239,'esMX','El mariscal Dughan te envió, ¿eh? Bueno, tú no pareces del ejército, pero si Dughan te envió aquí ¡es suficiente para mí!$B$BNuestra situación es, por lo menos, un tanto estresante. Espero que nos des una mano.',18019),
(11,'esMX','¡Veo que has estado ocupado! Tienes nuestro agradecimiento $N',18019),
(176,'esMX','¡Bien hecho! ¡Estaba pensando que nadie derribaría a ese monstruo!$B$BAquí tienes $N, y gracias, ese Gnoll me estaba dando un dolor de cabeza ¡del tamaño del clan roca negra!',18019),
(35,'esMX','Sí, los murlocs se han asentado en esta zona, y alrededor de los arroyos del oriente de Elwynn. No sabemos por qué están aquí, pero son agresivos y al menos semi-inteligentes.',18019),
(52,'esMX','Muchas gracias por la ayuda $N. Algo en el bosque debe estar haciendo estos animales tan audaces.$B$BSea lo que sea, espero que se quede ahí.',18019),
(83,'esMX','Ah, estos son pañuelos bonitos, pero son un poco ásperos...$B$BAquí tienes!',18019),
(5545,'esMX','¡Excelente! Muchas gracias, debería ser capaz de completar la orden a tiempo. Para mostrar mi gratitud, me gustaría ofrecerte algunas monedas como compensación por su ayuda.$B$BGracias y adiós.',18019),
(37,'esMX','Aunque el cadáver ha sido despojado en gran parte, cerca se encuentra tirado un medallón con las palabras: "Footman Malakai Stone" grabadas sobre él.',18019),
(45,'esMX','Encuentras alrededor del cuello del cadáver un medallón de metal con las palabras inscritas: "Footman Rolf Hartford".',18019),
(71,'esMX','Has confirmado mis temores $N. Los murlocs son una amenaza que no podemos ignorar.',18019),
(39,'esMX','Hmm, esta noticia es preocupante. Ya nuestras defensas eran limitadas y perder a Rolf y Malakai por culpa de esos murlocs nos puso en una posición aún peor.$B$BSi las cosas no mejoran, ¡Habrá peleas en villadorada al final de la semana!',18019),
(59,'esMX','Ah, gracias por el material. Por favor, siéntase libre de elegir su armadura.$B$BBuena suerte valiente $C, y que esta armadura te sirva bien.',18019),
(46,'esMX','¿Tienes las aletas? ¡Genial! El alguacil Dughan estará ansioso de saber más acerca de la situación murloc en el este de Elwynn, me gustaría decirle que ahora todo está bajo control.$B$BGracias a tus acciones nos hemos dado cuenta de este problema.',18019),
(106,'esMX','¡Ah! No puedo soportar que nos separemos. ¡Tengo que verla!',18019),
(111,'esMX','Mientras que nuestras familias estén peleando, Tommy Joe y Maybell no tienen mucho futuro, pero... tal vez podamos reunirlos sólo por un rato.$B$BHm, ¿qué podemos hacer...?',18019),
(107,'esMX','Mi corazón se sale con esas dos pobres almas, Maybell y Tommy Joe. Recuerdo una vez haber sido joven y enamorado.$B$B¡Debe haber algo que pueda hacer para ayudarles! Déjame pensar.',18019),
(114,'esMX','¡Oh...yo! Me siento culpable engañando a mi familia, pero mis sentimientos por Tommy Joe son demasiado fuertes como para ignorarlos.$B$BGracias $N. Beberé este licor tan pronto como sea. Tengo la oportunidad, y no quiero alejarme de mi amor.$B$BY para ti... por favor toma esto.',18019),
(88,'esMX','¡Gracias a Dios! Ese cerdo se estaba poniendo tan gordo que había comido toda nuestra cosecha! Gracias $N.$B$B¿Alguno de estos te queda bien? ',18019),
(85,'esMX','¿Perdiste un qué? Bueno, yo no tomé ningún collar ¡porque yo no soy un ladrón!$B$BPodría saber quién lo hizo, pero... <Sonrisa>... tengo demasiado hambre para recordar.',18019),
(86,'esMX','Aunque esta carne de jabalí es salvaje, podría cocinarla a fuego lento ¡sería suficiente para que cualquier tarta sea sabrosa!',18019),
(84,'esMX','¡Mm, ñam ñam! ¡Esta tarta es la mejor!$B$BCreo que mi memoria está regresando...',18019),
(87,'esMX','¡Oh, lo encontraste! ¡Gracias, gracias!$B$BToma, toma esto. Era de mi marido y él siempre dijo que era de buena suerte. ¡Ojalá no lo hubiera olvidado en su última campaña! *Suspiro* ',18019),
(16,'esMX','Gracias $N y vuelve si quieres intercambiar de nuevo.',18019);

DELETE FROM `quest_request_items_locale` WHERE `ID` IN (33, 18, 6, 3904, 3905, 15, 21, 3105, 3101, 3102, 3103, 3100, 3104, 54, 47, 60, 61, 62, 76, 11, 176, 52, 83, 5545, 71, 59, 46, 106, 107, 114, 88, 86, 84, 87, 16) AND `locale` IN ('esES');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(33,'esES','Hey $N. ¿Cómo va la caza de lobos jóvenes malsanos?',18019),
(18,'esES','¿Ya has reunido esos pañuelos para mí?',18019),
(6,'esES','¿Encontraste la cabaña de Garrick? ¿Estamos finalmente libres de ese villano?',18019),
(3904,'esES','¿Tienes mis cosechas $N?',18019),
(3905,'esES','¡Pareces estar de buen humor! ¡Ven! Siéntese y tome un trago.',18019),
(15,'esES','¿Has estado en las minas? ¿Estás listo para informar?',18019),
(21,'esES','Sé que es un trabajo sangriento $N, pero es vital para la seguridad de villanorte. ¿Estás listo para informar?',18019),
(3105,'esES','Ah, así que has llegado, y no en un momento justo $N. Algunos de los guardias estuvieron aquí hace unos momentos y me estuvieron dando miradas curiosas... patéticos mundanos.',18019),
(3101,'esES','¡Por fin! Nos encontramos cara a cara, hermano a hermano. Le doy la bienvenida a villanorte. Esta será su casa por un corto tiempo mientras aprendes los detalles de cómo se hacen las cosas, pero sabes que ventormenta no está muy lejos, y tarde o temprano, tu camino te llevará allí. Pero hasta entonces sea paciente, caballero de la mano de plata.',18019),
(3102,'esES','Has venido de una pieza, y no parece que te haya visto mucha gente. No quiero llamar la atención... Seguro que lo entiendes.$B$B¿Algún problema? Me alegro. No tardarán en llegar.',18019),
(3103,'esES','Ah, por fin has venido. Sabía que encontrarías el camino hacia mí. La luz sagrada brilla sobre ti y el camino que has escogido. Estos tiempos son duros, la legión ardiente todavía tiene presencia en Azeroth, la totalidad de Kalimdor busca nuevas formas de defenderse de sus propias tribulaciones, y ahora está usted para ayudar a todos los que pueda.',18019),
(3100,'esES','Ah, tienes mi carta $N... Bien.$B$BHa habido una afluencia de guerreros en bosque de elwynn recientemente, lo cual es bueno para ventormenta, pero malo para los kobolds y defias en el área. ',18019),
(3104,'esES','Hola $N. Soy Khelden. ¿Hay algo que pueda hacer por ti?',18019),
(54,'esES','¿Tienes algo de McBride? Villanorte es un jardín comparado con bosque de elwynn, pero me pregunto qué tiene que informar el alguacil McBride.$B$BDéjame tener sus papeles... ',18019),
(47,'esES','¡Psst! ¿Tienes ese polvo de oro para mí...para mí?',18019),
(60,'esES','¿Ya reuniste las velas?',18019),
(61,'esES','¿Un envío de mi hermano? ¡Espléndido! ¡Hoy la fortuna me brilla verdaderamente!',18019),
(62,'esES','¿Qué tienes que informar $N? ¿Has estado en la mina Abisal?',18019),
(76,'esES','Hola $N. ¿Qué tiene que informar? ¿Has explorado la cantera de jaspe?',18019),
(11,'esES','Hola $N. ¿Has estado matando a los Gnolls?',18019),
(176,'esES','Sí, Hogger ha sido un verdadero dolor de cabeza para mí y mis hombres. ¿Tienes algo que informar sobre la bestia?',18019),
(52,'esES','¿Mataste a aquellos osos y lobos?',18019),
(83,'esES','Me estoy quedando sin lino. ¿Tienes algo para mí?',18019),
(5545,'esES','Esa fecha límite no se está alejando. Por favor apresúrate y recoge los fardos de madera.',18019),
(71,'esES','Hola $N. ¿Descubriste el destino de Rolf y Malakai?',18019),
(59,'esES','He sido comisionada por el ejército de ventormenta para proveer a su gente armaduras de tela y cuero.$B$BSi tienes material para mí, entonces estaría encantada de hacer algo por ti.',18019),
(46,'esES','¿Cómo va la cacería $N?',18019),
(106,'esES','¿Tienes qué? Maybell es la luz de mi aburrida vida. ¡Rápido, déjame ver su carta!',18019),
(107,'esES','Tienes algo de "Abuela" Pedregosa, ¿eh? ¡No he visto a Mildred en años! Me pregunto qué tiene que decir...',18019),
(114,'esES','¿Le entregaste mi carta a Tommy Joe? ¿Qué dijo?',18019),
(88,'esES','¿La has visto ya? ¿La has visto?',18019),
(86,'esES','No creo que esté bien alimentar al chico que robó mi collar en primer lugar, pero si eso es lo que se necesita para recuperar lo que es mío ¡entonces que así sea!$B$B¿Tienes carne de jabalí?',18019),
(84,'esES','¡Ugh, me muero de hambre! ¿Ya tienes ese pastel para mí, $N?',18019),
(87,'esES','Hola $N. ¿Has encontrado mi collar?',18019),
(16,'esES','Cultivar es un trabajo sediento, y siempre estoy buscando agua de mamantial refrescante.$B$BSi tienes agua, entonces estoy dispuesto a hacer un intercambio.',18019);

DELETE FROM `quest_request_items_locale` WHERE `ID` IN (33, 18, 6, 3904, 3905, 15, 21, 3105, 3101, 3102, 3103, 3100, 3104, 54, 47, 60, 61, 62, 76, 11, 176, 52, 83, 5545, 71, 59, 46, 106, 107, 114, 88, 86, 84, 87, 16) AND `locale` IN ('esMX');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(33,'esMX','Hey $N. ¿Cómo va la caza de lobos jóvenes malsanos?',18019),
(18,'esMX','¿Ya has reunido esos pañuelos para mí?',18019),
(6,'esMX','¿Encontraste la cabaña de Garrick? ¿Estamos finalmente libres de ese villano?',18019),
(3904,'esMX','¿Tienes mis cosechas $N?',18019),
(3905,'esMX','¡Pareces estar de buen humor! ¡Ven! Siéntese y tome un trago.',18019),
(15,'esMX','¿Has estado en las minas? ¿Estás listo para informar?',18019),
(21,'esMX','Sé que es un trabajo sangriento $N, pero es vital para la seguridad de villanorte. ¿Estás listo para informar?',18019),
(3105,'esMX','Ah, así que has llegado, y no en un momento justo $N. Algunos de los guardias estuvieron aquí hace unos momentos y me estuvieron dando miradas curiosas... patéticos mundanos.',18019),
(3101,'esMX','¡Por fin! Nos encontramos cara a cara, hermano a hermano. Le doy la bienvenida a villanorte. Esta será su casa por un corto tiempo mientras aprendes los detalles de cómo se hacen las cosas, pero sabes que ventormenta no está muy lejos, y tarde o temprano, tu camino te llevará allí. Pero hasta entonces sea paciente, caballero de la mano de plata.',18019),
(3102,'esMX','Has venido de una pieza, y no parece que te haya visto mucha gente. No quiero llamar la atención... Seguro que lo entiendes.$B$B¿Algún problema? Me alegro. No tardarán en llegar.',18019),
(3103,'esMX','Ah, por fin has venido. Sabía que encontrarías el camino hacia mí. La luz sagrada brilla sobre ti y el camino que has escogido. Estos tiempos son duros, la legión ardiente todavía tiene presencia en Azeroth, la totalidad de Kalimdor busca nuevas formas de defenderse de sus propias tribulaciones, y ahora está usted para ayudar a todos los que pueda.',18019),
(3100,'esMX','Ah, tienes mi carta $N... Bien.$B$BHa habido una afluencia de guerreros en bosque de elwynn recientemente, lo cual es bueno para ventormenta, pero malo para los kobolds y defias en el área. ',18019),
(3104,'esMX','Hola $N. Soy Khelden. ¿Hay algo que pueda hacer por ti?',18019),
(54,'esMX','¿Tienes algo de McBride? Villanorte es un jardín comparado con bosque de elwynn, pero me pregunto qué tiene que informar el alguacil McBride.$B$BDéjame tener sus papeles... ',18019),
(47,'esMX','¡Psst! ¿Tienes ese polvo de oro para mí...para mí?',18019),
(60,'esMX','¿Ya reuniste las velas?',18019),
(61,'esMX','¿Un envío de mi hermano? ¡Espléndido! ¡Hoy la fortuna me brilla verdaderamente!',18019),
(62,'esMX','¿Qué tienes que informar $N? ¿Has estado en la mina Abisal?',18019),
(76,'esMX','Hola $N. ¿Qué tiene que informar? ¿Has explorado la cantera de jaspe?',18019),
(11,'esMX','Hola $N. ¿Has estado matando a los Gnolls?',18019),
(176,'esMX','Sí, Hogger ha sido un verdadero dolor de cabeza para mí y mis hombres. ¿Tienes algo que informar sobre la bestia?',18019),
(52,'esMX','¿Mataste a aquellos osos y lobos?',18019),
(83,'esMX','Me estoy quedando sin lino. ¿Tienes algo para mí?',18019),
(5545,'esMX','Esa fecha límite no se está alejando. Por favor apresúrate y recoge los fardos de madera.',18019),
(71,'esMX','Hola $N. ¿Descubriste el destino de Rolf y Malakai?',18019),
(59,'esMX','He sido comisionada por el ejército de ventormenta para proveer a su gente armaduras de tela y cuero.$B$BSi tienes material para mí, entonces estaría encantada de hacer algo por ti.',18019),
(46,'esMX','¿Cómo va la cacería $N?',18019),
(106,'esMX','¿Tienes qué? Maybell es la luz de mi aburrida vida. ¡Rápido, déjame ver su carta!',18019),
(107,'esMX','Tienes algo de "Abuela" Pedregosa, ¿eh? ¡No he visto a Mildred en años! Me pregunto qué tiene que decir...',18019),
(114,'esMX','¿Le entregaste mi carta a Tommy Joe? ¿Qué dijo?',18019),
(88,'esMX','¿La has visto ya? ¿La has visto?',18019),
(86,'esMX','No creo que esté bien alimentar al chico que robó mi collar en primer lugar, pero si eso es lo que se necesita para recuperar lo que es mío ¡entonces que así sea!$B$B¿Tienes carne de jabalí?',18019),
(84,'esMX','¡Ugh, me muero de hambre! ¿Ya tienes ese pastel para mí, $N?',18019),
(87,'esMX','Hola $N. ¿Has encontrado mi collar?',18019),
(16,'esMX','Cultivar es un trabajo sediento, y siempre estoy buscando agua de mamantial refrescante.$B$BSi tienes agua, entonces estoy dispuesto a hacer un intercambio.',18019);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
