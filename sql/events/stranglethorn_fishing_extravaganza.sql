REPLACE INTO game_event VALUES(62, "2014-03-23 14:00:00", "2020-12-31 06:00:00", 10080, 180, 301, "Fishing Extravaganza Turn-ins", 0);
REPLACE INTO game_event VALUES(14, "2014-03-23 01:00:00", "2020-12-31 06:00:00", 10080, 1440, 0, "Fishing Extravaganza Announce", 0);
REPLACE INTO game_event VALUES(15, "2014-03-23 14:00:00", "2020-12-31 06:00:00", 10080, 120, 0, "Fishing Extravaganza Fishing Pools", 0);
UPDATE creature_template SET ScriptName="npc_riggle_bassbait" WHERE entry=15077;

-- Speckled Tastyfish (19807)
DELETE FROM fishing_loot_template WHERE entry=33 AND item=11150;
INSERT INTO fishing_loot_template VALUES(33, 11150, 33, 1, 1, -11150, 1);
DELETE FROM reference_loot_template WHERE entry=11150;
INSERT INTO reference_loot_template VALUES(11150, 19807, 33, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES(11150, 19808, 0.01, 1, 1, 1, 1); -- sword fish :D
INSERT INTO reference_loot_template VALUES(11150, 19805, 0.05, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES(11150, 19803, 0.05, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES(11150, 19806, 0.05, 1, 1, 1, 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=10 AND SourceEntry IN(19807, 19808, 19805, 19803, 19806);
INSERT INTO conditions VALUES (10, 11150, 19807, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event
INSERT INTO conditions VALUES (10, 11150, 19808, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event
INSERT INTO conditions VALUES (10, 11150, 19805, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event
INSERT INTO conditions VALUES (10, 11150, 19803, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event
INSERT INTO conditions VALUES (10, 11150, 19806, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event

DELETE FROM gameobject_loot_template WHERE item IN(19803, 19805, 19806, 19807, 19808);
INSERT INTO gameobject_loot_template VALUES(17280, 19807, 75, 1, 1, 1, 1);
INSERT INTO gameobject_loot_template VALUES(17280, 19808, 0.05, 1, 1, 1, 1); -- sword fish :D
INSERT INTO gameobject_loot_template VALUES(17280, 19805, 0.1, 1, 1, 1, 1);
INSERT INTO gameobject_loot_template VALUES(17280, 19803, 0.1, 1, 1, 1, 1);
INSERT INTO gameobject_loot_template VALUES(17280, 19806, 0.1, 1, 1, 1, 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=4 AND SourceEntry IN(19807, 19808, 19805, 19803, 19806);
INSERT INTO conditions VALUES (4, 17280, 19807, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event
INSERT INTO conditions VALUES (4, 17280, 19808, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event
INSERT INTO conditions VALUES (4, 17280, 19805, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event
INSERT INTO conditions VALUES (4, 17280, 19803, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event
INSERT INTO conditions VALUES (4, 17280, 19806, 0, 0, 12, 0, 15, 0, 0, 0, 0, 0, '', 'Fishing Extravaganza'); -- allow fishing event

DELETE FROM creature_text WHERE entry=15077;
INSERT INTO creature_text VALUES(15077, 0, 0, "Let the fishing tournament begin!", 14, 0, 100, 0, 0, 0, 0, "Fishing Extravaganza");
INSERT INTO creature_text VALUES(15077, 1, 0, "We have a winner! $N is the Master Angler!", 14, 0, 100, 0, 0, 0, 0, "Fishing Extravaganza");
INSERT INTO creature_text VALUES(15077, 2, 0, "The fishing tournament has ended!", 14, 0, 100, 0, 0, 0, 0, "Fishing Extravaganza");
UPDATE quest_template SET Flags=0, SpecialFlags=1 WHERE Id IN(8194, 8229, 8228, 8193, 8225, 8224, 8221);
