-- DB update 2023_01_05_01 -> 2023_01_05_02
DELETE FROM `quest_greeting_locale` WHERE `ID` = 3390 AND `locale` IN ('esES', 'esMX');
INSERT INTO `quest_greeting_locale` (`ID`, `type`, `locale`, `Greeting`, `VerifiedBuild`) VALUES
(3390, 0, 'esES', 'Los Baldíos cuentan con una gran riqueza de sustancias de las que nosotros, los boticarios de Lordaeron, podemos aprovecharnos.', 47014),
(3390, 0, 'esMX', 'Los Baldíos cuentan con una gran riqueza de sustancias de las que nosotros, los boticarios de Lordaeron, podemos aprovecharnos.', 47014);
