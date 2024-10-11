-- DB update 2023_11_10_01 -> 2023_11_10_02
-- fix commoner spawns, auras and equips

SET @GEVENT1  := 1;  -- Midsummer
SET @GEVENT2  := 2;  -- Winter Veil
SET @GEVENT3  := 7;  -- Lunar Festival
SET @GEVENT4  := 9;  -- Noblegarden
SET @GEVENT5  := 10; -- Children's Week
SET @GEVENT6  := 12; -- Hallow's End
SET @GEVENT7  := 24; -- Brewfest
SET @GEVENT8  := 26; -- Pilgrim's Bounty
SET @GEVENT9  := 46; -- Spirit of Competition
SET @GEVENT10 := 50; -- Pirate's Day
SET @GEVENT11 := 51; -- Day of the Dead

SET @SPELLDEFAULT   := 65523; -- Gossip NPC Appearance - Default (Noblegarden, Children's Week, Pilgrim's Bounty)
SET @SPELLMIDSUMMER := 65526; -- Gossip NPC Appearance - Midsummer
SET @SPELLWINTER    := 65522; -- Gossip NPC Appearance - Winter Veil
SET @SPELLLUNAR     := 65524; -- Gossip NPC Appearance - Lunar Festival
SET @SPELLHALLOWEEN := 65525; -- Gossip NPC Appearance - Hallow's End
SET @SPELLBREWFEST  := 65511; -- Gossip NPC Appearance - Brewfest
SET @SPELLSPIRIT    := 65527; -- Gossip NPC Appearance - Spirit of Competition
SET @SPELLPIRATE    := 65528; -- Gossip NPC Appearance - Pirates' Day
SET @SPELLDOTD      := 65529; -- Gossip NPC Appearance - Day of the Dead (DotD)

SET @CID1  := 18927; -- Human Commoner
SET @CID2  := 19148; -- Dwarf Commoner
SET @CID3  := 19169; -- Blood Elf Commoner
SET @CID4  := 19171; -- Draenei Commoner
SET @CID5  := 19172; -- Gnome Commoner
SET @CID6  := 19173; -- Night Elf Commoner
SET @CID7  := 19175; -- Orc Commoner
SET @CID8  := 19176; -- Tauren Commoner
SET @CID9  := 19177; -- Troll Commoner
SET @CID10 := 19178; -- Forsaken Commoner
SET @CID11 := 20102; -- Goblin Commoner

SET @SAIOFFSET := 100;

-- Goblin Commoner - fix default modelids
UPDATE `creature_template` SET `modelid1` = 19340, `modelid2` = 19343 WHERE `entry` = @CID11;

-- remove any fixed addons/auras/equipment
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
DELETE FROM `creature_template_addon` WHERE `entry` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11);
UPDATE `creature` SET `equipment_id`=0 WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11);
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11);

-- remove duplicate spawns
DELETE FROM `creature` WHERE `guid` IN (240303, 121254, 121255, 128461, 128462, 128463, 128464, 129440, 129441, 134675, 134676, 200000, 200001, 240305, 240314, 240318, 240319, 240413, 244364, 244365, 244366, 244367, 244368, 244369, 244370, 244371, 244372, 244379, 244380, 244381, 244382, 244383, 244384, 244385, 244386, 244387, 244388, 244389, 244390, 244391, 244392, 244800, 244801, 244802, 244803, 244804, 244805, 244822, 244823, 244824, 244825, 244832, 244833, 244834, 244835, 244836, 244837, 244838, 244839, 244840, 244841, 244842, 244843, 244844, 244845, 85986, 86168, 86235, 86236, 86355, 86846, 86847, 89407, 89408, 89409, 89410, 89420, 89421, 89422, 91567, 91568, 91573, 91574, 91575, 91576, 91577, 91578, 91585, 91586, 91589, 91591, 91592, 91616, 91617, 91618, 91619, 91620, 91621, 91761) AND `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11);
DELETE FROM `game_event_creature` WHERE `guid` IN (240303, 121254, 121255, 128461, 128462, 128463, 128464, 129440, 129441, 134675, 134676, 200000, 200001, 240305, 240314, 240318, 240319, 240413, 244364, 244365, 244366, 244367, 244368, 244369, 244370, 244371, 244372, 244379, 244380, 244381, 244382, 244383, 244384, 244385, 244386, 244387, 244388, 244389, 244390, 244391, 244392, 244800, 244801, 244802, 244803, 244804, 244805, 244822, 244823, 244824, 244825, 244832, 244833, 244834, 244835, 244836, 244837, 244838, 244839, 244840, 244841, 244842, 244843, 244844, 244845, 85986, 86168, 86235, 86236, 86355, 86846, 86847, 89407, 89408, 89409, 89410, 89420, 89421, 89422, 91567, 91568, 91573, 91574, 91575, 91576, 91577, 91578, 91585, 91586, 91589, 91591, 91592, 91616, 91617, 91618, 91619, 91620, 91621, 91761);

-- remove all commoner spawns in Harvest Festival
-- Harvest Festival runs parallel to Brewfest
-- Commoners are already spawned and dressed for Brewfest in this period
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11)) AND `eventEntry` = 11;

-- spawn commoners for all relevant events
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11)) AND `eventEntry` in (@GEVENT1, @GEVENT2, @GEVENT3, @GEVENT4, @GEVENT5, @GEVENT6, @GEVENT7, @GEVENT8, @GEVENT9, @GEVENT10, @GEVENT11);
INSERT INTO `game_event_creature` (SELECT @GEVENT1 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT2 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT3 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT4 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT5 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT6 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT7 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT8 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT9 , `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT10, `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));
INSERT INTO `game_event_creature` (SELECT @GEVENT11, `guid`  FROM `creature` WHERE `id1` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11));

-- dress commoners for each event
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11);

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11)) AND (`source_type` = 0) AND (`id` BETWEEN @SAIOFFSET AND @SAIOFFSET+10);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Human Commoner
(@CID1, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID1, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID1, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID1, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID1, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID1, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID1, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID1, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID1, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID1, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID1, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Dwarf Commoner
(@CID2, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID2, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID2, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID2, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID2, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID2, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID2, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID2, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID2, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID2, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID2, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dwarf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Blood Elf Commoner
(@CID3, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID3, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID3, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID3, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID3, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID3, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID3, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID3, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID3, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID3, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID3, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Draenei Commoner
(@CID4, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID4, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID4, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID4, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID4, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID4, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID4, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID4, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID4, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID4, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID4, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draenei Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Gnome Commoner
(@CID5, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID5, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID5, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID5, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID5, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID5, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID5, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID5, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID5, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID5, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID5, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnome Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Night Elf Commoner
(@CID6, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID6, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID6, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID6, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID6, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID6, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID6, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID6, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID6, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID6, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID6, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Orc Commoner
(@CID7, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID7, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID7, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID7, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID7, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID7, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID7, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID7, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID7, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID7, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID7, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orc Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Tauren Commoner
(@CID8, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID8, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID8, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID8, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID8, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID8, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID8, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID8, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID8, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID8, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID8, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Troll Commoner
(@CID9, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID9, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID9, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID9, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID9, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID9, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID9, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID9, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID9, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID9, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID9, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troll Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Forsaken Commoner
(@CID10, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID10, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID10, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID10, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID10, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID10, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID10, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID10, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID10, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID10, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID10, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\''),
-- Goblin Commoner
(@CID11, 0, @SAIOFFSET   , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLMIDSUMMER, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Midsummer\''),
(@CID11, 0, @SAIOFFSET+1 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLWINTER   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Winter Veil\''),
(@CID11, 0, @SAIOFFSET+2 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLLUNAR    , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Lunar Festival\''),
(@CID11, 0, @SAIOFFSET+3 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID11, 0, @SAIOFFSET+4 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID11, 0, @SAIOFFSET+5 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLHALLOWEEN, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Hallow\'s End\''),
(@CID11, 0, @SAIOFFSET+6 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLBREWFEST , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Brewfest\''),
(@CID11, 0, @SAIOFFSET+7 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDEFAULT  , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Default\''),
(@CID11, 0, @SAIOFFSET+8 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLSPIRIT   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Spirit of Competition\''),
(@CID11, 0, @SAIOFFSET+9 , 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLPIRATE   , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Pirates\' Day\''),
(@CID11, 0, @SAIOFFSET+10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, @SPELLDOTD     , 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - On Respawn - Cast \'Gossip NPC Appearance - Day of the Dead (DotD)\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` BETWEEN @SAIOFFSET+1 AND @SAIOFFSET+11) AND (`SourceEntry` IN (@CID1, @CID2, @CID3, @CID4, @CID5, @CID6, @CID7, @CID8, @CID9, @CID10, @CID11)) AND (`ConditionTypeOrReference` = 12) AND (`ConditionTarget` = 1) AND (`ConditionValue1` IN (@GEVENT1, @GEVENT2, @GEVENT3, @GEVENT4, @GEVENT5, @GEVENT6, @GEVENT7, @GEVENT8, @GEVENT9, @GEVENT10, @GEVENT11));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Human Commoner
(22, @SAIOFFSET+1 , @CID1, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Human Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID1, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Human Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID1, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Human Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID1, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Human Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID1, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Human Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID1, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Human Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID1, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Human Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID1, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Human Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID1, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Human Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID1, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Human Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID1, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Human Commoner - Day of the Dead festival must be active'),
-- Dwarf Commoner
(22, @SAIOFFSET+1 , @CID2, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID2, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID2, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID2, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID2, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID2, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID2, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID2, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID2, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID2, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID2, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Dwarf Commoner - Day of the Dead festival must be active'),
-- Blood Elf Commoner
(22, @SAIOFFSET+1 , @CID3, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID3, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID3, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID3, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID3, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID3, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID3, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID3, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID3, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID3, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID3, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Blood Elf Commoner - Day of the Dead festival must be active'),
-- Draenei Commoner
(22, @SAIOFFSET+1 , @CID4, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Draenei Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID4, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Draenei Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID4, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Draenei Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID4, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Draenei Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID4, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Draenei Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID4, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Draenei Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID4, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Draenei Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID4, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Draenei Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID4, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Draenei Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID4, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Draenei Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID4, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Draenei Commoner - Day of the Dead festival must be active'),
-- Gnome Commoner
(22, @SAIOFFSET+1 , @CID5, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Gnome Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID5, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Gnome Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID5, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Gnome Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID5, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Gnome Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID5, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Gnome Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID5, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Gnome Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID5, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Gnome Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID5, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Gnome Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID5, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Gnome Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID5, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Gnome Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID5, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Gnome Commoner - Day of the Dead festival must be active'),
-- Night Elf Commoner
(22, @SAIOFFSET+1 , @CID6, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID6, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID6, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID6, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID6, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID6, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID6, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID6, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID6, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID6, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID6, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Night Elf Commoner - Day of the Dead festival must be active'),
-- Orc Commoner
(22, @SAIOFFSET+1 , @CID7, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Orc Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID7, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Orc Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID7, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Orc Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID7, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Orc Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID7, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Orc Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID7, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Orc Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID7, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Orc Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID7, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Orc Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID7, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Orc Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID7, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Orc Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID7, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Orc Commoner - Day of the Dead festival must be active'),
-- Tauren Commoner
(22, @SAIOFFSET+1 , @CID8, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Tauren Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID8, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Tauren Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID8, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Tauren Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID8, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Tauren Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID8, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Tauren Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID8, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Tauren Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID8, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Tauren Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID8, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Tauren Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID8, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Tauren Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID8, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Tauren Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID8, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Tauren Commoner - Day of the Dead festival must be active'),
-- Troll Commoner
(22, @SAIOFFSET+1 , @CID9, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Troll Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID9, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Troll Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID9, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Troll Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID9, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Troll Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID9, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Troll Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID9, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Troll Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID9, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Troll Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID9, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Troll Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID9, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Troll Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID9, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Troll Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID9, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Troll Commoner - Day of the Dead festival must be active'),
-- Forsaken Commoner
(22, @SAIOFFSET+1 , @CID10, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID10, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID10, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID10, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID10, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID10, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID10, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID10, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID10, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID10, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID10, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Forsaken Commoner - Day of the Dead festival must be active'),
-- Goblin Commoner
(22, @SAIOFFSET+1 , @CID11, 0, 0, 12, 1, @GEVENT1 , 0, 0, 0, 0, 0, '', 'Goblin Commoner - Midsummer festival must be active'),
(22, @SAIOFFSET+2 , @CID11, 0, 0, 12, 1, @GEVENT2 , 0, 0, 0, 0, 0, '', 'Goblin Commoner - Winter Veil festival must be active'),
(22, @SAIOFFSET+3 , @CID11, 0, 0, 12, 1, @GEVENT3 , 0, 0, 0, 0, 0, '', 'Goblin Commoner - Lunar Festival festival must be active'),
(22, @SAIOFFSET+4 , @CID11, 0, 0, 12, 1, @GEVENT4 , 0, 0, 0, 0, 0, '', 'Goblin Commoner - Noblegarden festival must be active'),
(22, @SAIOFFSET+5 , @CID11, 0, 0, 12, 1, @GEVENT5 , 0, 0, 0, 0, 0, '', 'Goblin Commoner - Children\'s Week festival must be active'),
(22, @SAIOFFSET+6 , @CID11, 0, 0, 12, 1, @GEVENT6 , 0, 0, 0, 0, 0, '', 'Goblin Commoner - Hallow\'s End festival must be active'),
(22, @SAIOFFSET+7 , @CID11, 0, 0, 12, 1, @GEVENT7 , 0, 0, 0, 0, 0, '', 'Goblin Commoner - Brewfest festival must be active'),
(22, @SAIOFFSET+8 , @CID11, 0, 0, 12, 1, @GEVENT8 , 0, 0, 0, 0, 0, '', 'Goblin Commoner - Pilgrim\'s Bounty festival must be active'),
(22, @SAIOFFSET+9 , @CID11, 0, 0, 12, 1, @GEVENT9 , 0, 0, 0, 0, 0, '', 'Goblin Commoner - Spirit of Competition festival must be active'),
(22, @SAIOFFSET+10, @CID11, 0, 0, 12, 1, @GEVENT10, 0, 0, 0, 0, 0, '', 'Goblin Commoner - Pirate\'s Day festival must be active'),
(22, @SAIOFFSET+11, @CID11, 0, 0, 12, 1, @GEVENT11, 0, 0, 0, 0, 0, '', 'Goblin Commoner - Day of the Dead festival must be active');
