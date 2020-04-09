INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586466641269881700');

DELETE FROM `quest_template_addon` WHERE `id` IN (6804,6821,6822,6823,6824,7486);

UPDATE `quest_template_addon` SET `NextQuestID` = 0, `ExclusiveGroup` = 0 WHERE `id` = 6805;

DELETE FROM `creature_queststarter` WHERE `quest` IN (6804,6821,6822,6823,6824,7486);
DELETE FROM `creature_questender` WHERE `quest` IN (6804,6821,6822,6823,6824,7486);

DELETE FROM `disables` WHERE `SourceType` = 1 AND `entry` IN (6804,6821,6822,6823,6824,7486);
INSERT INTO `disables` (`SourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1, 6804, 0, 0, 0, 'Deprecated Quest: Poisoned Water'),
(1, 6821, 0, 0, 0, 'Deprecated Quest: Eye of the Emerseer'),
(1, 6822, 0, 0, 0, 'Deprecated Quest: The Molten Core'),
(1, 6823, 0, 0, 0, 'Deprecated Quest: Agent of Hydraxis'),
(1, 6824, 0, 0, 0, 'Deprecated Quest: Hands of the Enemy'),
(1, 7486, 0, 0, 0, 'Deprecated Quest: A Heroe\'s Reward');
