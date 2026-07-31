--
-- Zeppelin, Alliance - Westguard Keep to Shattered Straits (taxi path 727)
UPDATE `gameobject_template` SET `ScriptName` = 'go_transport_westguard_zeppelin' WHERE (`entry` = 186371);

-- Harrowmeiser - dock announcements, fired from the taxi arrival event 15431
DELETE FROM `creature_text` WHERE (`CreatureID` = 23823);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23823, 0, 0, 'My zeppelin has docked. Despite my being held captive, and the sorry state that she\'s in, she\'ll be departing the dock again in two minutes.', 14, 0, 100, 0, 0, 0, 22336, 0, 'Harrowmeiser - Arrival'),
(23823, 1, 0, 'The zeppelin\'s leaving for a tour around the bay in less than one minute!  Oh, and if anyone feels like setting me free, I\'m on the dock.', 14, 0, 100, 0, 0, 0, 22337, 0, 'Harrowmeiser - Departure');

-- Harrowmeiser and Bombardier Petrov - gossip text picked from the zeppelin's path
-- progress, which also pushes the world state that npc_text 11322 and 11332 substitute
-- into "in less than $3078w minutes"
UPDATE `creature_template` SET `ScriptName` = 'npc_harrowmeiser' WHERE (`entry` = 23823);
UPDATE `creature_template` SET `ScriptName` = 'npc_bombardier_petrov' WHERE (`entry` = 23895);
