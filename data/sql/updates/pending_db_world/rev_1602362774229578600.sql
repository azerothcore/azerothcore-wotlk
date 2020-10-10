INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1602362774229578600');

UPDATE `quest_template_locale` SET `ObjectiveText1`='Iniciado indigno dominado' WHERE `ID`=12848 AND `locale` IN ('esEs', 'esMX');

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12848 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12848, 'esES', 'Como esperaba, ¡mi caballero elegido ha triunfado! Estás listo, $n.', 18019),
(12848, 'esMX', 'Como esperaba, ¡mi caballero elegido ha triunfado! Estás listo, $n.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12636 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12636, 'esES', 'Se acerca la hora de derramar la sangre de nuestros enemigos. Antes de tirarte de cabeza a la batalla, debes conocer a quién intentas aniquilar. Es lo que diferencia a un caballero de la Muerte de un necrófago descerebrado.$B$BTe otorgaré visión más allá de la visión, mi campeón. Usarás el ojo de Acherus para robar los secretos de nuestros enemigos.', 18019),
(12636, 'esMX', 'Se acerca la hora de derramar la sangre de nuestros enemigos. Antes de tirarte de cabeza a la batalla, debes conocer a quién intentas aniquilar. Es lo que diferencia a un caballero de la Muerte de un necrófago descerebrado.$B$BTe otorgaré visión más allá de la visión, mi campeón. Usarás el ojo de Acherus para robar los secretos de nuestros enemigos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Forja de Nuevo Avalon analizada', `ObjectiveText2`='Concejo de Nuevo Avalon analizado', `ObjectiveText3`='Bastión Escarlata analizado', `ObjectiveText4`='Capilla de la Llama Carmesí analizada' WHERE `ID`=12641 AND `locale` IN ('esES', 'esMX');

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12641 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12641, 'esES', 'Se preparan para luchar como esperaba, pero hay algo más. Noto la presencia de un antiguo enemigo. Un enemigo que aniquilé hace mucho tiempo…$B$BNo importa. Enviaremos el poder de la Plaga al completo antes de que tengan la oportunidad de evacuar sus casas y poner sus defensas en posición.', 18019),
(12641, 'esMX', 'Se preparan para luchar como esperaba, pero hay algo más. Noto la presencia de un antiguo enemigo. Un enemigo que aniquilé hace mucho tiempo…$B$BNo importa. Enviaremos el poder de la Plaga al completo antes de que tengan la oportunidad de evacuar sus casas y poner sus defensas en posición.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12657 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12657, 'esES', 'Pronto resonará el eco de los cuernos de guerra por esta tierra, despertará a los muertos y llamará a la maquinaria de guerra de la Plaga. ¡Ay de aquellos que se crucen por nuestro camino!$B$BTú y tus hermanos dirigiréis la carga, $n. La próxima vez que mire hacia las tierras escarlata, las legiones de Acherus oscurecerán mi visión. La marcha hacia Nuevo Avalon empieza ahora.', 18019),
(12657, 'esMX', 'Pronto resonará el eco de los cuernos de guerra por esta tierra, despertará a los muertos y llamará a la maquinaria de guerra de la Plaga. ¡Ay de aquellos que se crucen por nuestro camino!$B$BTú y tus hermanos dirigiréis la carga, $n. La próxima vez que mire hacia las tierras escarlata, las legiones de Acherus oscurecerán mi visión. La marcha hacia Nuevo Avalon empieza ahora.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12850 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12850, 'esES', '¡La guerra ha empezado, caballero de la Muerte! Te daré mi mejor grifo para que te lleve hasta la Brecha de la Muerte. ¡Caos, muerte y destrucción! ¡Proclamarás todo esto y más!', 18019),
(12850, 'esMX', '¡La guerra ha empezado, caballero de la Muerte! Te daré mi mejor grifo para que te lleve hasta la Brecha de la Muerte. ¡Caos, muerte y destrucción! ¡Proclamarás todo esto y más!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12670 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12670, 'esES', '¿Lo hueles?$B$B<Valanar huele el aire.>$B$BCarne fresca… La esencia del Cruzado Escarlata se huele en el aire.$B$B<Valanar saliva.>$B$BDiscúlpame caballero de la Muerte, seguro que mi gusto por la cocina refinada no te interesa. ¡Estás aquí para trabajar! ¡Para dirigir la carga! Sí, lo sé. El Rey Exánime me ha contado todo lo que necesito sobre ti, $n.$B$BHa llegado la hora de derramar sangre.', 18019),
(12670, 'esMX', '¿Lo hueles?$B$B<Valanar huele el aire.>$B$BCarne fresca… La esencia del Cruzado Escarlata se huele en el aire.$B$B<Valanar saliva.>$B$BDiscúlpame caballero de la Muerte, seguro que mi gusto por la cocina refinada no te interesa. ¡Estás aquí para trabajar! ¡Para dirigir la carga! Sí, lo sé. El Rey Exánime me ha contado todo lo que necesito sobre ti, $n.$B$BHa llegado la hora de derramar sangre.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Cruzado Escarlata asesinado', `ObjectiveText2`='Ciudadano de Villa Refugio asesinado' WHERE `ID`=12678 AND `locale` IN ('esES', 'esMX');
