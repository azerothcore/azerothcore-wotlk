-- set dark portal creatures active
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (18948, 18949, 18950, 18965, 18970, 18971, 18986, 18966, 18969)) AND (`source_type` = 0) AND (`event_type` = 11) AND (`id` IN (42));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- 18948 Stormwind soldier
(18948, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Soldier - On Respawn - Set Active On'),
-- 18949 Stormwind Mage
(18949, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Mage - On Respawn - Set Active On'),
-- 18950 Orgrimmar Grunt
(18950, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Respawn - Set Active On'),
-- 18965 Darnassian Archer
(18965, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Archer - On Respawn - Set Active On'),
-- 18970 Darkspear Axe Thrower
(18970, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkspear Axe Thrower - On Respawn - Set Active On'),
-- 18971 Undercity Mage
(18971, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Mage - On Respawn - Set Active On'),
-- 18986 Ironforge Paladin
(18986, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Paladin - On Respawn - Set Active On'),
-- 18966 Justinius the Harbinger
(18966, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Justinius the Harbinger - On Respawn - Set Active On'),
-- 18969 Melgromm Highmountain
(18969, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Melgromm Highmountain - On Respawn - Set Active On');

-- TODO
-- 19005 Wrath Master
-- 18345 Fel Soldier
-- 19215 Infernal Relay (Hellfire)
