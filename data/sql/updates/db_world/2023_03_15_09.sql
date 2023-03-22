-- DB update 2023_03_15_08 -> 2023_03_15_09
-- Store Targetlist of group (id 1)
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` IN (183770, 183956, 184311, 184312));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(183770, 1, 0 , 1 , 62, 0, 100, 0, 8036, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'B\'naar Control Console - On Gossip Option Select - Store Target List'),
(183770, 1, 1 , 2 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'B\'naar Control Console - Linked with previous event - Store Target List Party'),
(183770, 1, 2 , 3 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 20209, 1, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 2918.95, 4189.98, 161.88, 0.34, 'B\'naar Control Console - Linked with previous event - Summon B\'naar Control Console'),
(183770, 1, 3 , 4 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 20209, 0, 0, 0, 0, 0, 0, 0, 'B\'naar Control Console - Linked with previous event - Send Targetlist to B\'naar Control Console'),
(183770, 1, 4 , 5 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 19, 20209, 0, 0, 0, 0, 0, 0, 0, 'B\'naar Control Console - Linked with previous event - Send Targetlist to B\'naar Control Console'),
(183770, 1, 5 , 6 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'B\'naar Control Console - Linked with previous event - Close Gossip'),
(183770, 1, 6 , 0 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 18377000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'B\'naar Control Console - Linked with previous event - Run Script'),
(183770, 1, 7 , 8 , 38, 0, 100, 0, 1, 1, 2000, 2000, 0, 104, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'B\'naar Control Console - On Data Set - Fail Quest'),
(183770, 1, 8 , 9 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 20209, 0, 0, 0, 0, 0, 0, 0, 'B\'naar Control Console - On Data Set - Say'),
(183770, 1, 9 , 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 7, 7, 0, 0, 0, 0, 19, 20209, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - On Data Set - Set Data'),
(183770, 1, 10, 0 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'B\'naar Control Console - On Data Set - Reset Scripts'),

(183956, 1, 0 , 1 , 62, 0, 100, 0, 8113, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - On Gossip Option Select - Store Target List'),
(183956, 1, 1 , 2 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - Linked with previous event - Store Target List Party'),
(183956, 1, 2 , 3 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 20417, 1, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 2426.77, 2750.38, 133.24, 2.14, 'Coruu Control Console - Linked with previous event - Summon Coruu Control Console'),
(183956, 1, 3 , 4 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 20417, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - Linked with previous event - Send Targetlist to Coruu Control Console'),
(183956, 1, 4 , 5 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 19, 20417, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - Linked with previous event - Send Targetlist to Coruu Control Console'),
(183956, 1, 5 , 6 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - Linked with previous event - Close Gossip'),
(183956, 1, 6 , 0 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 18395600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - Linked with previous event - Run Script'),
(183956, 1, 7 , 8 , 38, 0, 100, 0, 1, 1, 2000, 2000, 0, 104, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - On Data Set - Fail Quest'),
(183956, 1, 8 , 9 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 20417, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - On Data Set - Say'),
(183956, 1, 9 , 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 7, 7, 0, 0, 0, 0, 19, 20417, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - On Data Set - Set Data'),
(183956, 1, 10, 0 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coruu Control Console - On Data Set - Reset Scripts'),

(184311, 1, 0 , 1 , 62, 0, 100, 0, 8115, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - On Gossip Option Select - Store Target List'),
(184311, 1, 1 , 2 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - Linked with previous event - Store Target List Party'),
(184311, 1, 2 , 3 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 20418, 1, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 2976.48, 2183.29, 163.2, 1.85, 'Duru Control Console - Linked with previous event - Summon Duru Control Console'),
(184311, 1, 3 , 4 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 20418, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - Linked with previous event - Send Targetlist to Duru Control Console'),
(184311, 1, 4 , 5 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 19, 20418, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - Linked with previous event - Send Targetlist to Duru Control Console'),
(184311, 1, 5 , 6 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - Linked with previous event - Close Gossip'),
(184311, 1, 6 , 0 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 18431100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - Linked with previous event - Run Script'),
(184311, 1, 7 , 8 , 38, 0, 100, 0, 1, 1, 2000, 2000, 0, 104, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - On Data Set - Fail Quest'),
(184311, 1, 8 , 9 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 20418, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - On Data Set - Say'),
(184311, 1, 9 , 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 7, 7, 0, 0, 0, 0, 19, 20418, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - On Data Set - Set Data'),
(184311, 1, 10, 0 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Duru Control Console - On Data Set - Reset Scripts'),

(184312, 1, 0 , 1 , 62, 0, 100, 0, 8116, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - On Gossip Option Select - Store Target List'),
(184312, 1, 1 , 2 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - Linked with previous event - Store Target List Party'),
(184312, 1, 2 , 3 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 20440, 1, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 4013.71, 4028.76, 192.1, 1.25, 'Ara Control Console - Linked with previous event - Summon Ara Control Console'),
(184312, 1, 3 , 4 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 20440, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - Linked with previous event - Send Targetlist to Ara Control Console'),
(184312, 1, 4 , 5 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 19, 20440, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - Linked with previous event - Send Targetlist to Ara Control Console'),
(184312, 1, 5 , 6 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - Linked with previous event - Close Gossip'),
(184312, 1, 6 , 0 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 18431200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - Linked with previous event - Run Script'),
(184312, 1, 7 , 8 , 38, 0, 100, 0, 1, 1, 2000, 2000, 0, 104, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - On Data Set - Fail Quest'),
(184312, 1, 8 , 9 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 20440, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - On Data Set - Say'),
(184312, 1, 9 , 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 7, 7, 0, 0, 0, 0, 19, 20440, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - On Data Set - Set Data'),
(184312, 1, 10, 0 , 61, 0, 100, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ara Control Console - On Data Set - Reset Scripts');

-- Update to new Stored ID
UPDATE `smart_scripts` SET `target_param1`=2 WHERE (`entryorguid` = 20209) AND (`source_type` = 0) AND (`id` IN (11, 12, 13));
UPDATE `smart_scripts` SET `target_param1`=2 WHERE (`entryorguid` = 20417) AND (`source_type` = 0) AND (`id` IN (13, 14, 15));
UPDATE `smart_scripts` SET `target_param1`=2 WHERE (`entryorguid` = 20418) AND (`source_type` = 0) AND (`id` IN (15, 16, 17));
UPDATE `smart_scripts` SET `target_param1`=2 WHERE (`entryorguid` = 20440) AND (`source_type` = 0) AND (`id` IN (14, 15, 16));

-- Fix Flags
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432|256 WHERE (`entry` IN (20209, 20417, 20418, 20440));

-- Delete wrong spawns of Technicians causing trouble with Duro
DELETE FROM `creature` WHERE `id1` = 20218;

-- Fix Wrong WPs being assigned
UPDATE `smart_scripts` SET `action_param1`=2021802, `action_param2`=2021803 WHERE (`id`=12 AND `source_type` = 0 AND `entryorguid` = 20218);
UPDATE `smart_scripts` SET `action_param1`=2021804, `action_param2`=2021805 WHERE (`id`=14 AND `source_type` = 0 AND `entryorguid` = 20218);
