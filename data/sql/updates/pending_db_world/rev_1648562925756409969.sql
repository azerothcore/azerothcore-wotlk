INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648562925756409969');

DELETE FROM `quest_request_items_locale` WHERE `ID` = 12718 AND `locale` = "frFR" ;
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12718,"frFR","La mixture toxique bouillonne dans le chaudron de peste, répandant une épaisse fumée aux alentours.$b$bAvez-vous plus de crânes de croisés à y jeter ?",18019);
