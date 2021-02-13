INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613178860602736100');

/* Add missing emotes for Maybell Maclure when offering quest Young Lovers=id106
   Source: https://www.youtube.com/watch?v=Y6XYsgc2epI
*/

DELETE FROM `quest_details` WHERE `ID` = 106;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `EmoteDelay2`, `VerifiedBuild`) VALUES ('106', '18', '20', '1', '12340');
