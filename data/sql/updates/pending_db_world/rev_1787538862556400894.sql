--
-- Shallow Grave
UPDATE `gameobject_template` SET `Data7` = 0 WHERE `entry` = 128403;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 128308) AND (`source_type` = 1);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 128403) AND (`source_type` = 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    (128308, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 0, 11, 10247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shallow Grave - On Gossip Hello - Cast Summon Zul\'Farrak Zombies'),
    (128308, 1, 1, 0, 64, 0, 100, 1, 0, 0, 0, 0, 0, 41, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shallow Grave - On Gossip Hello - Despawn after 5 minutes'),
    (128403, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 0, 11, 10247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shallow Grave - On Gossip Hello - Cast Summon Zul\'Farrak Zombies'),
    (128403, 1, 1, 0, 64, 0, 100, 1, 0, 0, 0, 0, 0, 41, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shallow Grave - On Gossip Hello - Despawn after 5 minutes');
