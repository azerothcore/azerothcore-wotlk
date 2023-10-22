-- DB update 2023_04_19_29 -> 2023_04_19_30
--
-- Remove erronous pickpocket loot
DELETE FROM `pickpocketing_loot_template` WHERE `Entry`=18204 AND `Item`=24543;
