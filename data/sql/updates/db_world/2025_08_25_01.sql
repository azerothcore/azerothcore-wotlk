-- DB update 2025_08_25_00 -> 2025_08_25_01
-- set dark portal creatures active
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (18944, 18946, 18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986, -68744, -68745, -74081, -74082)) AND (`source_type` = 0) AND (`event_type` IN (11, 36)) AND (`id` IN (42, 43));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- 18944 Fel Soldier
(18944, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Soldier - On Respawn - Set Active On'),
(18944, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Soldier - On Corpse Removed - Set Active On'),
-- 18945 Pit Commander, already set active
-- 18946 Infernal Siegebreaker
(18946, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Siegebreaker - On Respawn - Set Active On'),
(18946, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Siegebreaker - On Corpse Removed - Set Active On'),
-- 18948 Stormwind Soldier
(18948, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Soldier - On Respawn - Set Active On'),
(18948, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Soldier - On Corpse Removed - Set Active On'),
-- 18949 Stormwind Mage
(18949, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Mage - On Respawn - Set Active On'),
(18949, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Mage - On Corpse Removed - Set Active On'),
-- 18950 Orgrimmar Grunt
(18950, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Respawn - Set Active On'),
(18950, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Corpse Removed - Set Active On'),
-- 18965 Darnassian Archer
(18965, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Archer - On Respawn - Set Active On'),
(18965, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Archer - On Corpse Removed - Set Active On'),
-- 18966 Justinius the Harbinger
(18966, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Justinius the Harbinger - On Respawn - Set Active On'),
(18966, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Justinius the Harbinger - On Corpse Removed - Set Active On'),
-- 18969 Melgromm Highmountain
(18969, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Melgromm Highmountain - On Respawn - Set Active On'),
(18969, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Melgromm Highmountain - On Corpse Removed - Set Active On'),
-- 18970 Darkspear Axe Thrower
(18970, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkspear Axe Thrower - On Respawn - Set Active On'),
(18970, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkspear Axe Thrower - On Corpse Removed - Set Active On'),
-- 18971 Undercity Mage
(18971, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Mage - On Respawn - Set Active On'),
(18971, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Mage - On Corpse Removed - Set Active On'),
-- 18972 Orgrimmar Shaman
(18972, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Shaman - On Respawn - Set Active On'),
(18972, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Shaman - On Corpse Removed - Set Active On'),
-- 18986 Ironforge Paladin
(18986, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Paladin - On Respawn - Set Active On'),
(18986, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Paladin - On Corpse Removed - Set Active On'),
-- 19005 Wrath Master, GUID SAI -68311, -68312, -68313, -68314, already set active
-- 19215 Infernal Relay (Hellfire)
(-68744, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Relay (Hellfire) - On Respawn - Set Active On'),
(-68744, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Relay (Hellfire) - On Corpse Removed - Set Active On'),
(-68745, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Relay (Hellfire) - On Respawn - Set Active On'),
(-68745, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Relay (Hellfire) - On Corpse Removed - Set Active On'),
-- 21075 Infernal Target (Hyjal)
(-74081, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - On Respawn - Set Active On'),
(-74081, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal)- On Corpse Removed - Set Active On'),
(-74082, 0, 42, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - On Respawn - Set Active On'),
(-74082, 0, 43, 0, 36, 0, 100, 512, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Target (Hyjal) - On Corpse Removed - Set Active On');

-- cleanup
-- Infernal Relay (Hellfire) used to set nearby 19005 Wrath Master active
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -68744) AND (`source_type` = 0) AND (`id` IN (10));
UPDATE `smart_scripts` SET `link` = 0 WHERE (`entryorguid` = -68744) AND (`source_type` = 0) AND (`id` IN (9));

-- update spawn comment for GUID SAI
UPDATE `creature` SET `Comment` = 'GUID SAI, SAI Target' WHERE (`id1` = 19215) AND (`guid` = 68745);
