INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607246968593658900');

-- Alliance
DELETE FROM `quest_request_items` WHERE `ID`=24535;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES (24535, 0, 0, 'Did you visit the ground where Thalorien fell defending the Sunwell?', 12340);

DELETE FROM `quest_request_items_locale` WHERE `ID`=24535 AND `locale`='deDE';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES (24535, 'deDE', 'Seid Ihr an dem Ort gewesen, an dem Thalorien fiel, als er den Sonnenbrunnen verteidigte?', 18019);

DELETE FROM `quest_offer_reward` WHERE `ID`=24535;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES (24535, 0, 0, 0, 0, 0, 0, 0, 0, 'I confess that I did not expect Thalorien''s spirit to recognize you as the heir to Quel''Delar, but I defer to his judgment. You may enter the Sunwell, but I remind you that you are a guest in our most sacred of precincts, and you should act accordingly.', 12340);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=24535 AND `locale`='deDE';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (24535, 'deDE', 'Ich gebe zu, dass ich nicht erwartet hätte, dass Thalorien Euch als Erben Quel''Delars anerkennt, aber ich respektiere sein Urteil. Ihr dürft zum Sonnenbrunnen gehen, doch ich erinnere Euch daran, dass Ihr an unserem allerheiligsten Ort zu Gast seid und Euch dementsprechend zu verhalten habt.', 18019);

-- Horde
DELETE FROM `quest_offer_reward` WHERE `ID`=24563;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES (24563, 0, 0, 0, 0, 0, 0, 0, 0, 'You truly do carry Quel''Delar. This is a great day for all of Quel''Thalas and the sin''dorei. You have my leave to enter the Sunwell and finish the sword''s restoration. Keep your head high, $N. The children of Silvermoon have dreamt of this day for years.', 12340);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=24563 AND `locale`='deDE';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (24563, 'deDE', 'Ihr tragt wirklich Quel''Delar bei Euch. Heute ist ein großer Tag für ganz Quel''Thalas und die Sin''dorei! Ihr habt meine Erlaubnis, zum Sonnenbrunnen zu gehen und die Wiederherstellung des Schwertes abzuschließen. Lasst den Kopf nicht hängen, $N. Die Söhne und Töchter Silbermonds haben viele Jahre auf diesen Tag gewartet.', 18019);
