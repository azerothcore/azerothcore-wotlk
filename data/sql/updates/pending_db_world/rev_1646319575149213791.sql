INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646319575149213791');

DELETE FROM `quest_offer_reward_locale` WHERE  RewardText IS NULL;
DELETE FROM `quest_request_items_locale` WHERE  CompletionText IS NULL;
