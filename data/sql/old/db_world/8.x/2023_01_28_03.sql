-- DB update 2023_01_28_02 -> 2023_01_28_03
DELETE FROM `item_template_locale` WHERE `ID` = 11000 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(11000, 'esES', 'Llave Sombratiniebla', 'Maestro de la llave de las Profundidades, Cortesía de F.F.F.', 0),
(11000, 'esMX', 'Llave Sombratiniebla', 'Maestro de la llave de las Profundidades, Cortesía de F.F.F.', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 8072 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8072, 'esES', 'Llave de la torre de Silixiz', '', 0),
(8072, 'esMX', 'Llave de la torre de Silixiz', '', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 44582 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(44582, 'esES', 'Llave del Iris de enfoque', '', 0),
(44582, 'esMX', 'Llave del Iris de enfoque', '', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 44581 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(44581, 'esES', 'Llave heroica del Iris de enfoque', '', 0),
(44581, 'esMX', 'Llave heroica del Iris de enfoque', '', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 5397 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(5397, 'esES', 'Pólvora Defias', '', 0),
(5397, 'esMX', 'Pólvora Defias', '', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 24490 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(24490, 'esES', 'La llave del maestro', '', 0),
(24490, 'esMX', 'La llave del maestro', '', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 13704 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(13704, 'esES', 'Llave esqueleto', '', 0),
(13704, 'esMX', 'Llave esqueleto', '', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 2719 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(2719, 'esES', 'Llave de latón pequeña', '', 0),
(2719, 'esMX', 'Llave de latón pequeña', '', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 5396 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(5396, 'esES', 'Llave de la Garganta de Fuego', '', 0),
(5396, 'esMX', 'Llave de la Garganta de Fuego', '', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 30633 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30633, 'esES', 'Llave Auchenai', 'Desbloquea la dificultad heroica de las mazmorras de Auchindoun.', 0),
(30633, 'esMX', 'Llave Auchenai', 'Desbloquea la dificultad heroica de las mazmorras de Auchindoun.', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 30623 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30623, 'esES', 'Llave de depósito', 'Desbloquea la dificultad heroica de las mazmorras de la Reserva Colmillo Torcido.', 0),
(30623, 'esMX', 'Llave de depósito', 'Desbloquea la dificultad heroica de las mazmorras de la Reserva Colmillo Torcido.', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 30637 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30637, 'esES', 'Llave de Forjallamas', 'Desbloquea la dificultad heroica de las mazmorras de la Ciudadela del Fuego Infernal.', 0),
(30637, 'esMX', 'Llave de Forjallamas', 'Desbloquea la dificultad heroica de las mazmorras de la Ciudadela del Fuego Infernal.', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 30622 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30622, 'esES', 'Llave de Forjallamas', 'Desbloquea la dificultad heroica de las mazmorras de la Ciudadela del Fuego Infernal.', 0),
(30622, 'esMX', 'Llave de Forjallamas', 'Desbloquea la dificultad heroica de las mazmorras de la Ciudadela del Fuego Infernal.', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 30634 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30634, 'esES', 'Llave forjada de distorsión', 'Desbloquea la dificultad heroica de las mazmorras de El Castillo de la Tempestad.', 0),
(30634, 'esMX', 'Llave forjada de distorsión', 'Desbloquea la dificultad heroica de las mazmorras de El Castillo de la Tempestad.', 0);

DELETE FROM `item_template_locale` WHERE `ID` = 30635 AND `locale` IN ('esES', 'esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30635, 'esES', 'Llave del tiempo', 'Desbloquea la dificultad heroica de las mazmorras de las Cavernas del Tiempo.', 0),
(30635, 'esMX', 'Llave del tiempo', 'Desbloquea la dificultad heroica de las mazmorras de las Cavernas del Tiempo.', 0);
