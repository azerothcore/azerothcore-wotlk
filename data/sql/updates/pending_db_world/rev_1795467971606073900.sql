-- The sleeping Gordok Hyenas stand up on aggro and on evade; creature_addon puts them back to sleep once home.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 134217728 WHERE `entry` = 12418;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-50414, -50415, -50416) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-50414, 0, 1000, 1001, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 16093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Aggro - Remove Aura \'Self Visual - Sleep Until Cancelled (DND)\''),
(-50414, 0, 1001, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Aggro - Remove Flag Standstate Dead'),
(-50414, 0, 1002, 1003, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 16093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Evade - Remove Aura \'Self Visual - Sleep Until Cancelled (DND)\''),
(-50414, 0, 1003, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Evade - Remove Flag Standstate Dead'),
(-50415, 0, 1000, 1001, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 16093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Aggro - Remove Aura \'Self Visual - Sleep Until Cancelled (DND)\''),
(-50415, 0, 1001, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Aggro - Remove Flag Standstate Dead'),
(-50415, 0, 1002, 1003, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 16093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Evade - Remove Aura \'Self Visual - Sleep Until Cancelled (DND)\''),
(-50415, 0, 1003, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Evade - Remove Flag Standstate Dead'),
(-50416, 0, 1000, 1001, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 16093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Aggro - Remove Aura \'Self Visual - Sleep Until Cancelled (DND)\''),
(-50416, 0, 1001, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Aggro - Remove Flag Standstate Dead'),
(-50416, 0, 1002, 1003, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 16093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Evade - Remove Aura \'Self Visual - Sleep Until Cancelled (DND)\''),
(-50416, 0, 1003, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordok Hyena - On Evade - Remove Flag Standstate Dead');
