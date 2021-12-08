INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638951999039996100');

/* Deprecate unused quest start item (pre-3.3, leads to Varimathras quests)
*/

UPDATE `item_template` SET `name` = 'Small Scroll [DEPRECATED]' WHERE (`entry` = 17008);

/* Deprecate unused quest ID (pre-3.3, Varimathras is gone)
*/

UPDATE `quest_template` SET `LogTitle` = 'An Unholy Alliance [DEPRECATED]' WHERE (`ID` = 6522);
UPDATE `quest_template` SET `LogTitle` = 'An Unholy Alliance [DEPRECATED]' WHERE (`ID` = 6521);

/* Update Map POI Text for An Unholy Alliance
*/

UPDATE `quest_template` SET `QuestCompletionLog`='Return to Bragor Bloodfist at the Royal Quarter in the Undercity.' WHERE `ID`=14352;

/* Unrelated quests that also had incorrect POI texts
*/

UPDATE `quest_template` SET `QuestCompletionLog`='Return to Bragor Bloodfist at the Royal Quarter in the Undercity.' WHERE `ID`=14351;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Bragor Bloodfist at the Royal Quarter in the Undercity.' WHERE `ID`=14356;
