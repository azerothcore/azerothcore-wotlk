-- DB update 2026_08_25_02 -> 2026_08_26_00
--
DELETE FROM `creature_text` WHERE `CreatureID` = 34119 AND `GroupID` BETWEEN 0 AND 5;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
    (34119, 0, 0, 'What a battle! Did you see that, Rhydian?!', 14, 0, 100, 0, 0, 0, 34225, 3, 'Brann Bronzebeard'),
    (34119, 1, 0, 'Perhaps so, but it''s only a matter of time until we break back into Ulduar. Any luck finding a way to teleport inside?', 14, 0, 100, 0, 0, 0, 34226, 3, 'Brann Bronzebeard'),
    (34119, 2, 0, 'Oi. So we''ll have to contend with that thing after all then?', 14, 0, 100, 0, 0, 0, 34229, 3, 'Brann Bronzebeard'),
    (34119, 3, 0, 'What about the plated proto-drake and the fire giant that were spotted nearby? Think your mages can handle those?', 14, 0, 100, 0, 0, 0, 34231, 3, 'Brann Bronzebeard'),
    (34119, 4, 0, 'Sneak?! What do you think we are, marmots?', 14, 0, 100, 0, 0, 0, 34233, 3, 'Brann Bronzebeard'),
    (34119, 5, 0, 'Fine. If our allies are going to be the ones getting their hands dirty, we''ll leave it to them to decide how to proceed.', 14, 0, 100, 0, 0, 0, 34235, 3, 'Brann Bronzebeard');

DELETE FROM `creature_text` WHERE `CreatureID` = 33696 AND `GroupID` BETWEEN 2 AND 6;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
    (33696, 2, 0, 'Our friends fought well, Brann, but we''re not done yet.', 14, 0, 100, 0, 0, 0, 34227, 3, 'Archmage Rhydian'),
    (33696, 3, 0, 'None at all. I suspect it has something to do with that giant mechanical construct that our scouts spotted in front of the gate.', 14, 0, 100, 0, 0, 0, 34228, 3, 'Archmage Rhydian'),
    (33696, 4, 0, 'The Kirin Tor can''t possibly spare any additional resources to take on anything that size. We may not have to though.', 14, 0, 100, 0, 0, 0, 34230, 3, 'Archmage Rhydian'),
    (33696, 5, 0, 'We can sneak past them. As long as we can take down that construct in front of the gate, we should be able to get inside.', 14, 0, 100, 0, 0, 0, 34232, 3, 'Archmage Rhydian'),
    (33696, 6, 0, 'We''re hunting an old god, Brann.', 14, 0, 100, 0, 0, 0, 34234, 3, 'Archmage Rhydian');

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 603 AND `summonerType` = 2 AND `groupId` IN (0, 1, 2, 3, 4, 5, 6, 7);
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
    (603, 2, 0, 34119, 233.9606, -123.4371, 409.6916, 6.152104, 8, 0, 'Flame Leviathan outro - Brann Bronzebeard'),
    (603, 2, 0, 34144, 214.305, -97.7288, 409.902, 4.69557, 8, 0, 'Flame Leviathan outro - Expedition Mercenary'),
    (603, 2, 0, 34144, 214.345, -93.4653, 409.902, 4.70543, 8, 0, 'Flame Leviathan outro - Expedition Mercenary'),
    (603, 2, 0, 34144, 214.357, -88.4769, 409.902, 4.72817, 8, 0, 'Flame Leviathan outro - Expedition Mercenary'),
    (603, 2, 0, 34144, 244.563, -98.3617, 409.819, 4.68692, 8, 0, 'Flame Leviathan outro - Expedition Mercenary'),
    (603, 2, 0, 34144, 244.701, -94.1342, 409.819, 4.80294, 8, 0, 'Flame Leviathan outro - Expedition Mercenary'),
    (603, 2, 0, 34144, 244.495, -89.2472, 409.819, 4.60713, 8, 0, 'Flame Leviathan outro - Expedition Mercenary'),
    (603, 2, 0, 34145, 256.192, -100.648, 409.817, 4.53754, 8, 0, 'Flame Leviathan outro - Expedition Engineer'),
    (603, 2, 0, 34145, 256.93, -96.4637, 409.819, 4.75397, 8, 0, 'Flame Leviathan outro - Expedition Engineer'),
    (603, 2, 0, 34145, 257.797, -91.5382, 409.819, 4.6667, 8, 0, 'Flame Leviathan outro - Expedition Engineer'),
    (603, 2, 0, 34145, 224.66, -98.4238, 409.902, 4.68688, 8, 0, 'Flame Leviathan outro - Expedition Engineer'),
    (603, 2, 0, 34145, 224.788, -93.4255, 409.902, 4.92305, 8, 0, 'Flame Leviathan outro - Expedition Engineer'),
    (603, 2, 0, 34145, 224.916, -88.4271, 409.902, 4.6683, 8, 0, 'Flame Leviathan outro - Expedition Engineer'),
    (603, 2, 1, 34144, 174.96938, -50.3517, 409.81348, 6.189358, 8, 0, 'Flame Leviathan outro - Expedition Mercenary (march start)'),
    (603, 2, 1, 34144, 169.75806, -50.084938, 409.8034, 6.21121, 8, 0, 'Flame Leviathan outro - Expedition Mercenary (march start)'),
    (603, 2, 1, 34144, 165.67856, -49.93559, 409.80365, 6.238564, 8, 0, 'Flame Leviathan outro - Expedition Mercenary (march start)'),
    (603, 2, 1, 34144, 175.66461, -36.33496, 409.86987, 0.145557, 8, 0, 'Flame Leviathan outro - Expedition Mercenary (march start)'),
    (603, 2, 1, 34144, 170.46495, -36.359524, 409.80362, 0.073692, 8, 0, 'Flame Leviathan outro - Expedition Mercenary (march start)'),
    (603, 2, 1, 34144, 166.39493, -36.500145, 409.80362, 0.017686, 8, 0, 'Flame Leviathan outro - Expedition Mercenary (march start)'),
    (603, 2, 1, 34145, 172.66048, -28.88596, 409.88696, 0.074632, 8, 0, 'Flame Leviathan outro - Expedition Engineer (march start)'),
    (603, 2, 1, 34145, 167.35666, -28.648111, 409.88696, 0.027685, 8, 0, 'Flame Leviathan outro - Expedition Engineer (march start)'),
    (603, 2, 1, 34145, 162.81847, -28.781794, 409.88696, 0.010288, 8, 0, 'Flame Leviathan outro - Expedition Engineer (march start)'),
    (603, 2, 1, 34145, 173.35124, -43.763077, 409.7804, 6.220645, 8, 0, 'Flame Leviathan outro - Expedition Engineer (march start)'),
    (603, 2, 1, 34145, 169.66489, -43.603226, 409.80365, 6.228433, 8, 0, 'Flame Leviathan outro - Expedition Engineer (march start)'),
    (603, 2, 1, 34145, 165.013, -43.62926, 409.80362, 6.264964, 8, 0, 'Flame Leviathan outro - Expedition Engineer (march start)'),
    (603, 2, 2, 33696, 235.96461, -135.27695, 409.68192, 1.152289, 8, 0, 'Flame Leviathan outro - Archmage Rhydian'),
    (603, 2, 3, 34120, 246.4216, -80.03793, 416.2025, 4.43, 8, 0, 'Flame Leviathan outro - Brann''s Flying Machine'),
    (603, 2, 4, 34119, 246.18864, -80.409645, 409.73053, 4.3, 8, 0, 'Flame Leviathan outro - Brann Bronzebeard (at the flying machine)'),
    (603, 2, 5, 33672, 213.43213, -126.89188, 409.66467, 1.413717, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 217.12311, -127.19917, 409.65933, 1.48353, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 220.89046, -127.4266, 409.65076, 1.53589, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 215.50282, -117.47635, 409.6517, 1.413717, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 219.1938, -117.78364, 409.6517, 1.48353, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 222.96115, -118.01107, 409.69476, 1.53589, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 250.41705, -127.29872, 409.887, 1.413717, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 254.10774, -127.60563, 409.887, 1.48353, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 257.87512, -127.83306, 409.887, 1.53589, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 247.926, -117.22721, 409.887, 1.413717, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 251.61697, -117.53451, 409.887, 1.48353, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 5, 33672, 255.38434, -117.76194, 409.887, 1.53589, 8, 0, 'Flame Leviathan outro - Kirin Tor Mage'),
    (603, 2, 6, 32780, -705.9705, -92.55729, 430.51917, 0, 8, 0, 'Flame Leviathan outro - Base camp teleporter stalker'),
    (603, 2, 7, 33662, 240.24995, -136.47862, 409.65237, 3.455752, 8, 0, 'Flame Leviathan outro - Kirin Tor Battle-Mage (channels at the portal)'),
    (603, 2, 7, 33662, 230.50803, -137.14876, 409.65076, 5.846853, 8, 0, 'Flame Leviathan outro - Kirin Tor Battle-Mage (channels at the portal)'),
    (603, 2, 7, 33662, 127.4796, -70.88797, 409.88696, 3.176499, 8, 0, 'Flame Leviathan outro - Kirin Tor Battle-Mage (Formation Grounds teleporter)');

DELETE FROM `gameobject` WHERE `guid` = 34283;

DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 603 AND `summonerType` = 2 AND `groupId` IN (0, 1);
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
    (603, 2, 0, 194569, -706.122, -92.6024, 429.876, 0, 0, 0, 0, 1, 0, 'Flame Leviathan outro - Expedition Base Camp teleporter'),
    (603, 2, 1, 194481, 235.41939, -138.5261, 409.5674, 0, 0, 0, 0, 1, 0, 'Flame Leviathan outro - Portal to Dalaran');

DELETE FROM `waypoint_data` WHERE `id` IN (341190, 336960);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
    (336960, 1, 243.5128, -126.59239, 409.80365, NULL, 0, 0),
    (336960, 2, 242.85948, -123.83485, 409.80365, NULL, 0, 0),
    (336960, 3, 239.31581, -123.64426, 409.80365, NULL, 0, 0),
    (341190, 1, 246.18864, -80.409645, 409.73053, NULL, 0, 0),
    (341190, 2, 243.60237, -79.01533, 409.76364, NULL, 0, 0),
    (341190, 3, 232.66634, -111.32069, 409.80365, NULL, 0, 0),
    (341190, 4, 229.933, -122.90609, 409.5674, NULL, 0, 0),
    (341190, 5, 233.96056, -123.43707, 409.6916, NULL, 0, 0);

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 34120;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
    (34120, 1, 0, 2, 0, 0, 0, NULL);

DELETE FROM `gossip_menu` WHERE `MenuID` = 90002;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
    (90002, 14471);

UPDATE `creature_template` SET `gossip_menu_id` = 90002, `npcflag` = `npcflag` | 1 WHERE `entry` = 34119;
