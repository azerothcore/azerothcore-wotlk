-- DB update 2023_06_27_00 -> 2023_06_29_00
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=1045 AND `locale`='ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1045, 'ruRU', 'Славная работа, $N. Спасибо тебе.', 18019);
