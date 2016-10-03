INSERT INTO version_db_world(`sql_rev`) VALUES ('1475527352519816200');

--Fix #116

DELETE FROM gameobject_template WHERE entry = 176248;

INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES 
(176248, 3, 336, 'Premium Siabi Tobacco', '', '', '', 0, 4, 1, 0, 0, 0, 0, 0, 0, 43, 5000, 0, 1, 0, 0, 5225, 0, 5214, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartGameObjectAI', '', 12340);

INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
 (5000, 13172, -100, 1, 0, 1, 1);
