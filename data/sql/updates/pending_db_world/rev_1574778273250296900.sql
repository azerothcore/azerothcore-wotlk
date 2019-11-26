DELETE FROM `smart_scripts` WHERE (`entryorguid`=29618 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29618, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - On Respawn - Enable Auto Attack"),
(29618, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - Linked - Enable Combat Movement"),
(29618, 0, 2, 3, 1, 0, 100, 0, 1000, 60000, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - OOC - Disable Auto Attack"),
(29618, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - Linked - Disable Combat Movement"),
(29618, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 88, 2961800, 2961809, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - Linked - Call Random Action List"),
(29618, 0, 5, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - On Waypoint Path Ended - Despawn After 1 Second"),
(29618, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - On Death - Despawn After 5 Seconds"),
(29618, 0, 7, 8, 8, 0, 100, 0, 66474, 0, 4500, 4500, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - On Spellhit 'Throw Net' - Say Line 0"),
(29618, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 33, 34899, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - On Spellhit 'Throw Net' - Quest Credit 'Gormok Wants His Snobolds'"),
(29618, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Snowblind Follower - On Spellhit 'Throw Net' - Despawn in 5000 ms");