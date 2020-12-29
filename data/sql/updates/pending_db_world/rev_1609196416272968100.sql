-- INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609196416272968100');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '', `spell1` = 0, `unit_flags`=`unit_flags`|512 WHERE (`entry` = 17243);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -61966);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-61966, 0, 0, 2, 62, 0, 100, 0, 7426, 0, 0, 0, 0, 80, 1724300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - On Gossip Option 0 Selected - Run Script'),
(-61966, 0, 1, 0, 0, 0, 100, 0, 0, 250, 8000, 15000, 0, 11, 7978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - In Combat - Cast \'Throw Dynamite\''),
(-61966, 0, 2, 0, 61, 0, 100, 0, 7426, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - On Gossip Option 0 Selected - Set Event Phase 2'),
(-61966, 0, 3, 4, 1, 1, 100, 0, 120000, 150000, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Out of Combat - Say Line 11 (Phase 1)'),
(-61966, 0, 4, 0, 61, 1, 100, 0, 120000, 150000, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Out of Combat - Say Line 12 (Phase 1)'),
(-61966, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - On Reset - Set Event Phase 1'),
(-61966, 0, 6, 7, 1, 1, 100, 0, 15000, 15000, 0, 0, 0, 2, 875, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Out of Combat - Set Faction 875 (Phase 1)'),
(-61966, 0, 7, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Out of Combat - Add Npc Flags Gossip (Phase 1)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1724300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1724300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Close Gossip'),
(1724300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Set Orientation Invoker'),
(1724300, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Remove Npc Flags Gossip'),
(1724300, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Say Line 1'),
(1724300, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Say Line 2'),
(1724300, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Say Line 3'),
(1724300, 9, 6, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Say Line 4'),
(1724300, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Say Line 5'),
(1724300, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Set Faction 14'),
(1724300, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineer "Spark" Overgrind - Actionlist - Start Attacking');

DELETE FROM `creature_text` WHERE `CreatureID`=17243 AND `GroupID`=1 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(17243, 1, 0, '%s laughs.', 16, 7, 100, 11, 0, 0, 13785, 0, 'Engineer Spark - Show Gnomercy #1'),
(17243, 2, 0, 'Does it frighten you to know that there are those that would serve the Legion with such devotion as to remain unwavering citizens of your pointless civilizations until called upon?', 12, 7, 100, 0, 0, 0, 13787, 0, 'Engineer Spark - Show Gnomercy #2'),
(17243, 3, 0, 'Live in fear, die by the will of Kael\'thas... It\'s all the same.', 12, 7, 100, 0, 0, 0, 13791, 0, 'Engineer Spark - Show Gnomercy #3'),
(17243, 4, 0, 'And now, I cut you!', 12, 7, 100, 0, 0, 0, 14090, 0, 'Engineer Spark - Show Gnomercy #4'),
(17243, 5, 0, 'DIE!', 12, 7, 100, 0, 0, 0, 14091, 0, 'Engineer Spark - Show Gnomercy #5'),
(17243, 6, 0, '%s picks up the naga flag.', 16, 7, 100, 0, 0, 0, 13775, 0, 'Engineer Spark - Tree\'s Company #1'),
(17243, 7, 0, 'What\'s the big idea? You nearly blew my cover, idiot! I told you to put the compass and navigation maps somewhere safe - not out in the open for any fool to discover.', 12, 7, 100, 0, 0, 0, 13777, 0, 'Engineer Spark - Tree\'s Company #2'),
(17243, 8, 0, 'The Master has gone to great lengths to secure information about the whereabouts of the Exodar. You could have blown the entire operation, including the cover of our spy on the inside.', 12, 7, 100, 0, 0, 0, 13778, 0, 'Engineer Spark - Tree\'s Company #3'),
(17243, 9, 0, 'Relax? Do you know what Kael\'thas does to those that fail him, Geezle? Eternal suffering and pain... Do NOT screw this up, fool.', 12, 7, 100, 0, 0, 0, 13780, 0, 'Engineer Spark - Tree\'s Company #4'),
(17243, 10, 0, 'Our Bloodmyst scouts have located our contact. The fool, Velen, will soon leave himself open and defenseless -- long enough for us to strike! Now get out of my sight before I vaporize you...', 12, 7, 100, 0, 0, 0, 13781, 0, 'Engineer Spark - Tree\'s Company #5'),
(17243, 11, 0, 'A-ha! Found one!', 12, 7, 100, 0, 0, 0, 14076, 0, 'Engineer Spark - Wandering on Beach #1'),
(17243, 11, 1, 'Another one!', 12, 7, 100, 0, 0, 0, 14077, 0, 'Engineer Spark - Wandering on Beach #2'),
(17243, 11, 2, 'Oh that\'s a big one!', 12, 7, 100, 0, 0, 0, 14078, 0, 'Engineer Spark - Wandering on Beach #3'),
(17243, 11, 3, 'It\'s ironic, I hate the ocean but I love the beach.', 12, 7, 100, 0, 0, 0, 14080, 0, 'Engineer Spark - Wandering on Beach #4'),
(17243, 11, 4, 'I wonder if you can really hear the ocean in these things.', 12, 7, 100, 0, 0, 0, 14079, 0, 'Engineer Spark - Wandering on Beach #5'),
(17243, 11, 5, 'Yes Master, all goes along as planned.', 12, 7, 100, 0, 0, 0, 14082, 0, 'Engineer Spark - Wandering on Beach #6'),
(17243, 12, 0, '%s places the shell in his pack.', 16, 7, 100, 0, 0, 0, 14083, 0, 'Engineer Spark - Wandering on Beach - Emotes #1'),
(17243, 12, 1, '%s examines the shell.', 16, 7, 100, 0, 0, 0, 14086, 0, 'Engineer Spark - Wandering on Beach - Emotes #2'),
(17243, 12, 2, '%s holds the shell up to his ear.', 16, 7, 100, 0, 0, 0, 14084, 0, 'Engineer Spark - Wandering on Beach - Emotes #3');
