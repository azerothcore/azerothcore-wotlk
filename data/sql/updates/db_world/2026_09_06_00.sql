-- DB update 2026_09_05_03 -> 2026_09_06_00
-- Lore Keeper of Norgannon (Entry 7172)
-- Synchronize the Trogg and Dwarf visual aids with the dialogue that introduces them
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7172) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    (7172, 0, 0, 12, 37, 0, 100, 257, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On AI Init - Say Line 0'),
    (7172, 0, 1, 2, 62, 0, 100, 512, 576, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Close Gossip'),
    (7172, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 26, 2278, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Quest Credit The Platinum Discs'),
    (7172, 0, 3, 0, 62, 0, 100, 257, 576, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Say Line 1'),
    (7172, 0, 4, 5, 62, 0, 100, 512, 569, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 20, 142488, 30, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Set GO State'),
    (7172, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 1, 20000, 20000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Create Timed Event'),
    (7172, 0, 6, 0, 59, 0, 100, 512, 1, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 20, 142488, 30, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Timed Event - Set GO State'),
    (7172, 0, 7, 0, 62, 0, 100, 512, 570, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 20, 142488, 30, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Set GO State'),
    (7172, 0, 8, 9, 62, 0, 100, 512, 571, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 20, 170353, 30, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Set GO State'),
    (7172, 0, 9, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 2, 20000, 20000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Create Timed Event'),
    (7172, 0, 10, 0, 59, 0, 100, 512, 2, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 20, 170353, 30, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Timed Event - Set GO State'),
    (7172, 0, 11, 0, 62, 0, 100, 512, 572, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 20, 170353, 30, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Set GO State'),
    (7172, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 11012, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On AI Init - Cast Stone Watcher of Norgannon Spawn');
