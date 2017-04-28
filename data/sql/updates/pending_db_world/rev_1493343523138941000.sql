INSERT INTO version_db_world (`sql_rev`) VALUES ('1493343523138941000');
-- replace "Mac" with actual player name ($N) in the reward text
UPDATE `quest_template`
SET `OfferRewardText`= "Great Spirit Totem! This is dire news indeed. I must begin to plan for whatever may come.$b$b$N, as promised, here is your reward for your brave service.$b$b"
WHERE `ID`= 5064;
--
