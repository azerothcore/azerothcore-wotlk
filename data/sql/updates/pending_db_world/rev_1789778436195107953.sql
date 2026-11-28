DELETE FROM `quest_greeting_locale` WHERE `ID` = 3446 AND `Type` = 0 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_greeting_locale` (`ID`, `Type`, `locale`, `Greeting`, `VerifiedBuild`) VALUES
(3446, 0, 'esES', '¡Sí, sí, sí! ¡Justo $gel:la; $r que estaba buscando!$B$B¡Siéntate! Tenemos mucho que hablar.', 0),
(3446, 0, 'esMX', '¡Sí, sí, sí! ¡Justo $gel:la; $r que estaba buscando!$B$B¡Siéntate! Tenemos mucho que hablar.', 0);
