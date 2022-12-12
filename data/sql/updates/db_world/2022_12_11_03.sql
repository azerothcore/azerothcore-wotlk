-- DB update 2022_12_11_02 -> 2022_12_11_03
-- Fix issue 13914
DELETE FROM `quest_greeting_locale` WHERE `locale` IN ('esES', 'esMX') AND `ID` = 5638;
INSERT INTO `quest_greeting_locale` (`ID`, `type`, `locale`, `Greeting`) VALUES 
(5638, 0, 'esES', 'Tengo muchas cosas que hacer por aquí en Desolace, $N. Roetten quiere que recojamos algunos componentes para uno de nuestros clientes y buscar alguno de esos objetos perdidos.$b$bViéndote que estás aquí para ayudar. ¿Por qué no empezamos?'),
(5638, 0, 'esMX', 'Tengo muchas cosas que hacer por aquí en Desolace, $N. Roetten quiere que recojamos algunos componentes para uno de nuestros clientes y buscar alguno de esos objetos perdidos.$b$bViéndote que estás aquí para ayudar. ¿Por qué no empezamos?');
