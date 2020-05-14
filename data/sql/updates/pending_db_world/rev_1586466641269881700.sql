INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586466641269881700');

DELETE FROM `quest_template_addon` WHERE `id` IN (6804,6821,6822,6823,6824,7486);
INSERT INTO `quest_template_addon` (`id`, `ProvidedItemCount`) VALUES
(6804, 1);

UPDATE `quest_template_addon` SET `NextQuestID` = 0, `ExclusiveGroup` = 0 WHERE `id` = 6805;

DELETE FROM `creature_queststarter` WHERE `quest` IN (6804,6821,6822,6823,6824,7486);
DELETE FROM `creature_questender` WHERE `quest` IN (6804,6821,6822,6823,6824,7486);
