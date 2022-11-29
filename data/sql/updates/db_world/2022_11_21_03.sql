-- DB update 2022_11_21_02 -> 2022_11_21_03
-- esES missing reward_locale 
DELETE FROM `quest_offer_reward_locale` WHERE `locale` IN ('esES', 'esMX') AND `ID` IN (11262, 12118, 12182, 12297, 12298, 12918, 12952, 13087, 13089, 13206, 13268, 13269);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(11262, 'esES', 'Excelente trabajo, $N. Ahora que nos hemos librado de su líder, nuestros esfuerzos contra esos vrykuls deberían ser más fructíferos.$b$b¡Un servicio así merece una recompensa!', 0),
(12118, 'esES', '¿Qué dices, $R? ¿Te envía Anuniaq?$b$bBien, bien... hay mucho trabajo. ¡Toda ayuda es bien recibida!', 0),
(12182, 'esES', '¡Qué gran día! ¡Y mira por donde, más allá de la montaña al noreste hay todo un campo de la Plaga para que lo borremos del mapa!', 0),
(12297, 'esES', '<Greer se sube las gafas por encima de los ojos y lee la nota, vuelve a mirarte curioso cuando termina.>$b$b¡Vas a coger el hipogrifo más rápido que tengo, $R! Esta información debe llegar al Alto comandante Aterravermis sin dilación!', 0),
(12298, 'esES', '<El Alto comandante lee la misiva y la estruja.>$b$b¿Sabes dónde están ahora los de esta lista? Mira afuera, junto a la puerta frontal. Son los que cuelgan de los arcos.$b$bCebo de necrófagos...', 0),
(12918, 'esES', 'Estas son perfectas para reponer mi stock. No solo te enseñaré el arte del tallado a la perfección, sino que cortaré una de esas gemas de forma perfecta para ti como recompensa.', 0),
(12952, 'esES', 'Estas servirán. Puedo enseñarte el arte del tallado a la perfección y también darte unas muestras como prueba de mis habilidades.', 0),
(13087, 'esES', '¡Has recogío mi carne! Aquí tienes tu receta, ¡Tengo cosas que cocinar!', 0),
(13089, 'esES', 'Podemos convertir esta carne rápidamente en estofado.', 0),
(13206, 'esES', 'Marrah ha informado acerca de la superioridad del armamento vrykul. Echaremos un vistazo a estas a ver si podemos aprender algo.$b$bToma esto por las molestias, $C.', 0),
(13268, 'esES', 'Vuelve cuando tengas la suficiente habilidad y podre proporcionarte un entrenamiento de sastrería.', 0),
(13269, 'esES', 'Mata suficientes humanoides y recoge sus telas.', 0),
-- esMX missing reward_locale
(11262, 'esMX', 'Excelente trabajo, $N. Ahora que nos hemos librado de su líder, nuestros esfuerzos contra esos vrykuls deberían ser más fructíferos.$b$b¡Un servicio así merece una recompensa!', 0),
(12118, 'esMX', '¿Qué dices, $R? ¿Te envía Anuniaq?$b$bBien, bien... hay mucho trabajo. ¡Toda ayuda es bien recibida!', 0),
(12182, 'esMX', '¡Qué gran día! ¡Y mira por donde, más allá de la montaña al noreste hay todo un campo de la Plaga para que lo borremos del mapa!', 0),
(12297, 'esMX', '<Greer se sube las gafas por encima de los ojos y lee la nota, vuelve a mirarte curioso cuando termina.>$b$b¡Vas a coger el hipogrifo más rápido que tengo, $R! Esta información debe llegar al Alto comandante Aterravermis sin dilación!', 0),
(12298, 'esMX', '<El Alto comandante lee la misiva y la estruja.>$b$b¿Sabes dónde están ahora los de esta lista? Mira afuera, junto a la puerta frontal. Son los que cuelgan de los arcos.$b$bCebo de necrófagos...', 0),
(12918, 'esMX', 'Estas son perfectas para reponer mi stock. No solo te enseñaré el arte del tallado a la perfección, sino que cortaré una de esas gemas de forma perfecta para ti como recompensa.', 0),
(12952, 'esMX', 'Estas servirán. Puedo enseñarte el arte del tallado a la perfección y también darte unas muestras como prueba de mis habilidades.', 0),
(13087, 'esMX', '¡Has obtenío mi carne! Aquí tienes tu receta, ¡Tengo cosas que cocinar!', 0),
(13089, 'esMX', 'Podemos convertir esta carne rápidamente en estofado.', 0),
(13206, 'esMX', 'Marrah ha informado acerca de la superioridad del armamento vrykul. Echaremos un vistazo a estas a ver si podemos aprender algo.$b$bToma esto por las molestias, $C.', 0),
(13268, 'esMX', 'Vuelve cuando tengas la suficiente habilidad y podre proporcionarte un entrenamiento de sastrería.', 0),
(13269, 'esMX', 'Mata suficientes humanoides y obtén sus telas.', 0);
-- 2 SECTION
-- esES missing quest_request_items_locale 
DELETE FROM `quest_request_items_locale` WHERE `locale` IN ('esES', 'esMX') AND `ID` IN (11262, 11452, 11453, 12182, 12297, 12298, 12918, 12952, 13087, 13089, 13206, 13268, 13269);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(11262, 'esES', 'Prepárate, $R.$b$bAún queda mucho por hacer. Esto es solo la punta del iceberg, por decirlo de alguna manera.', 0),
(11452, 'esES', '¡$n, qué nuevas noticias nos traes?', 0),
(11453, 'esES', '¡$n, qué nuevas noticias nos traes?', 0),
(12182, 'esES', '¿Eres tú $gel:la; chic$go:a; de los recados?', 0),
(12297, 'esES', 'Hola, $c.', 0),
(12298, 'esES', '¿Qué tienes ahí, soldado?', 0),
(12918, 'esES', 'Eres muy generoso. Lo mejor que puedo hacer es enseñarte el arte del tallado a la perfección.', 0),
(12952, 'esES', 'Estos servirán. Te enseñaré el arte del tallado a la perfección.', 0),
(13087, 'esES', '¡¿¡¿DÓNDE ESTÁ MI CARNE!?!?', 0),
(13089, 'esES', 'El estofado aguarda...', 0),
(13206, 'esES', '¿Qué tienes ahí, $c?', 0),
(13268, 'esES', 'Pareces alguien que sabe manejarse con la aguja y el hilo así que creo que tal vez pueda ayudarte.$B$BLos humanoides de las tierras de Rasganorte visten prendas que se pueden convertir en tela si sabes cómo hacerlo.$B$BPor un poco de oro, me dispongo a enseñarte el arte de la Recolección de Telas, que te proporcionará telas de tejido de escarcha adicionales de los humanoides de Rasganorte que mates.', 0),
(13269, 'esES', 'Los humanoides de las tierras de Rasganorte visten prendas que se pueden convertir en tela si sabes cómo hacerlo.$b$bPor un poco de oro, me dispongo a enseñarte el arte de la Recolección de Telas, que te proporcionará telas de tejido de escarcha adicionales de los humanoides de Rasganorte que mates.', 0),
-- esMX missing quest_request_items_locale 
(11262, 'esMX', 'Prepárate, $R.$b$bAún queda mucho por hacer. Esto es solo la punta del iceberg, por decirlo de alguna manera.', 0),
(11452, 'esMX', '¡$n, qué nuevas noticias nos traes?', 0),
(11453, 'esMX', '¡$n, qué nuevas noticias nos traes?', 0),
(12182, 'esMX', '¿Eres tú $gel:la; chic$go:a; de los recados?', 0),
(12297, 'esMX', 'Hola, $c.', 0),
(12298, 'esMX', '¿Qué tienes ahí, soldado?', 0),
(12918, 'esMX', 'Eres muy generoso. Lo mejor que puedo hacer es enseñarte el arte del tallado a la perfección.', 0),
(12952, 'esMX', 'Estos servirán. Te enseñaré el arte del tallado a la perfección.', 0),
(13087, 'esMX', '¡¿¡¿DÓNDE ESTÁ MI CARNE!?!?', 0),
(13089, 'esMX', 'El estofado aguarda...', 0),
(13206, 'esMX', '¿Qué tienes ahí, $c?', 0),
(13268, 'esMX', 'Pareces alguien que sabe manejarse con la aguja y el hilo así que creo que tal vez pueda ayudarte.$B$BLos humanoides de las tierras de Rasganorte visten prendas que se pueden convertir en tela si sabes cómo hacerlo.$B$BPor un poco de oro, me dispongo a enseñarte el arte de la Recolección de Telas, que te proporcionará telas de tejido de escarcha adicionales de los humanoides de Rasganorte que mates.', 0),
(13269, 'esMX', 'Los humanoides de las tierras de Rasganorte visten prendas que se pueden convertir en tela si sabes cómo hacerlo.$b$bPor un poco de oro, me dispongo a enseñarte el arte de la Recolección de Telas, que te proporcionará telas de tejido de escarcha adicionales de los humanoides de Rasganorte que mates.', 0);
