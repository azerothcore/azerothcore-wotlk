-- DB update 2023_03_04_09 -> 2023_03_04_10
-- Falthir the Sightless, add 8143 (Rogue revered neck quest)
DELETE FROM `creature_queststarter` WHERE `id` = 14905 AND `quest` = 8143;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (14905, 8143);

DELETE FROM `creature_questender` WHERE `id` = 14905 AND `quest` = 8143;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (14905, 8143);
-- Remove race restrictions. (Rogue exalted neck quest)
UPDATE `quest_template` SET `AllowableRaces` = 0 WHERE `ID` = 8144;

-- Remove race restrictions. (Paladin exalted neck quest)
UPDATE `quest_template` SET `AllowableRaces` = 0 WHERE `ID` = 8048;
