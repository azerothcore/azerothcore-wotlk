-- DB update 2024_12_29_00 -> 2024_12_29_01
--
DELETE FROM `gameobject_template_locale` WHERE `name` = '';
DELETE FROM `gameobject_template_locale` WHERE `name` = 'NULL';
DELETE FROM `gameobject_template_locale` WHERE `name` IS NULL;
DELETE FROM `quest_offer_reward_locale` WHERE `RewardText` = '';
DELETE FROM `quest_offer_reward_locale` WHERE `RewardText` = 'NULL';
DELETE FROM `quest_offer_reward_locale` WHERE `RewardText` IS NULL;
