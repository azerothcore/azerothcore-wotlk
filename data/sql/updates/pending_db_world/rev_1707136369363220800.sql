-- reassign equipment_id to creatures 25949, 26221
-- after spawns have been updated with sniffed values
UPDATE `creature` SET `equipment_id` = 1 WHERE (`id1` IN (25949, 26221)) AND (`guid` IN (245627, 90494, 90495, 90496, 90498, 90499, 90508, 12458, 12459, 12460));
