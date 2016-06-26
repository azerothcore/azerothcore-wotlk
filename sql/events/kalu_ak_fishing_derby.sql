REPLACE INTO game_event VALUES(63, "2014-03-22 13:00:00", "2020-12-31 06:00:00", 10080, 180, 424, "Kalu'ak Fishing Derby Turn-ins", 0);
REPLACE INTO game_event VALUES(64, "2014-03-22 14:00:00", "2020-12-31 06:00:00", 10080, 60, 0, "Kalu'ak Fishing Derby Fishing Pools", 0);
UPDATE creature_template SET ScriptName="npc_elder_clearwater" WHERE entry=38294;

-- Blacktip Shark (50289)
DELETE FROM reference_loot_template WHERE item=50289;
INSERT INTO reference_loot_template VALUES(11019, 50289, 0.05, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES(11020, 50289, 0.05, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES(11021, 50289, 0.05, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES(11022, 50289, 0.05, 1, 1, 1, 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=10 AND SourceEntry=50289;
INSERT INTO conditions VALUES (10, 11019, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (10, 11020, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (10, 11021, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (10, 11022, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event

DELETE FROM gameobject_loot_template WHERE item=50289;
INSERT INTO gameobject_loot_template VALUES (25668, 50289, 0.05, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25665, 50289, 0.05, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25664, 50289, 0.05, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25669, 50289, 0.05, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25663, 50289, 0.05, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25662, 50289, 0.05, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25673, 50289, 0.05, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25674, 50289, 0.05, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25671, 50289, 0.05, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25670, 50289, 0.05, 1, 2, 1, 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=4 AND SourceEntry=50289;
INSERT INTO conditions VALUES (4, 25668, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (4, 25665, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (4, 25664, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (4, 25669, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (4, 25663, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (4, 25662, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (4, 25673, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (4, 25674, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (4, 25671, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event
INSERT INTO conditions VALUES (4, 25670, 50289, 0, 0, 12, 0, 64, 0, 0, 0, 0, 0, '', 'Kalu\'ak Fishing Derby'); -- allow fishing event


DELETE FROM creature_text WHERE entry=38294;
INSERT INTO creature_text VALUES(38294, 0, 0, "The Kalu'ak Fishing Derby starts in 5 minutes!", 14, 0, 100, 0, 0, 0, 0, "Kalu'ak Fishing Derby");
INSERT INTO creature_text VALUES(38294, 1, 0, "The Kalu'ak Fishing Derby has begun! The first person to bring a blacktip shark to me in Dalaran will be declared the winner! Blacktip sharks can be caught anywhere you can catch a pygmy suckerfish.", 14, 0, 100, 0, 0, 0, 0, "Kalu'ak Fishing Derby");
INSERT INTO creature_text VALUES(38294, 2, 0, "$N has won the Kalu'ak Fishing Derby!", 14, 0, 100, 0, 0, 0, 0, "Kalu'ak Fishing Derby");
INSERT INTO creature_text VALUES(38294, 3, 0, "The Kalu'ak Fishing Derby has ended! If you caught a shark, please bring it to me within the hour.", 14, 0, 100, 0, 0, 0, 0, "Kalu'ak Fishing Derby");
UPDATE quest_template SET Flags=0, SpecialFlags=1 WHERE Id IN(24803, 24806);
