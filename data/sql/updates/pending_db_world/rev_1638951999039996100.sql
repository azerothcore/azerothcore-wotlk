INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638951999039996100');

/* Deprecate unused quest start item (pre-3.3, leads to Varimathras quests)
*/

UPDATE `item_template` SET `Flags` = 16 WHERE (`entry` = 17008);

/* Deprecate unused quest ID (pre-3.3, Varimathras is gone)
*/

INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES 
(1, 6521, 0, 0, 0, 'Deprecated quest: An Unholy Alliance'),
(1, 6522, 0, 0, 0, 'Deprecated quest: An Unholy Alliance');

/* Update Map POI and Text for 'An Unholy Alliance' chain
*/

UPDATE `quest_template` SET `QuestCompletionLog`='Return to Bragor Bloodfist at the Royal Quarter in the Undercity.' WHERE `ID`=14352;
UPDATE `quest_poi` SET `WorldMapAreaId`=382 WHERE `QuestID`=14352 AND `id`=1;
UPDATE `quest_poi` SET `WorldMapAreaId`=382 WHERE `QuestID`=14353 AND `id`=0;

/* Unrelated quests that also had incorrect POI texts
*/

UPDATE `quest_template` SET `QuestCompletionLog`='Return to Bragor Bloodfist at the Royal Quarter in the Undercity.' WHERE `ID`=14351;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Bragor Bloodfist at the Royal Quarter in the Undercity.' WHERE `ID`=14356;
