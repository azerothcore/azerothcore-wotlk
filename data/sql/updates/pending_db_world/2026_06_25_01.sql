-- Dark Portal battle demon wave and defender behavior fixes.
-- Consolidates final creature tuning, formation, waypoint, SmartAI, and condition updates.

UPDATE `creature_template` SET `DamageModifier` = CASE `entry`
    WHEN 18944 THEN 2.4 -- Fel Soldier
    WHEN 18946 THEN 6.7 -- Infernal Siegebreaker
    WHEN 19005 THEN 11  -- Wrath Master
END
WHERE `entry` IN (18944, 18946, 19005);

-- The two mage entries carried UNIT_FLAG_DISABLE_MOVE (0x4) in their template
-- unit_flags, which rooted them in place: they teleported to the path start but
-- could not walk the escort path (stuck "on the portal"). Clear the flag so they
-- march with the rest of the battalion. Only these two entries had it set.
UPDATE `creature_template` SET `unit_flags` = `unit_flags` & ~0x4
WHERE `entry` IN (18949, 18971); -- Stormwind Mage, Undercity Mage

-- -----------------------------------------------------------------------------
-- 2) Infernal target marker placement + movement behavior
-- -----------------------------------------------------------------------------
UPDATE `creature` SET `position_x` = -274.3799,
    `position_y` = 1174.073,
    `position_z` = 83.321175,
    `orientation` = 3.1407077
WHERE `guid` = 74081 AND `id1` = 21075;

UPDATE `creature` SET `position_x` = -216.51663,
    `position_y` = 1173.5674,
    `position_z` = 83.321175,
    `orientation` = 4.703648
WHERE `guid` = 74082 AND `id1` = 21075;

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 21075;
INSERT INTO `creature_template_movement`
(`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`)
VALUES
(21075, 2, 0, 1, 1, 0, 0, NULL);

-- Rebuild every touched SmartAI package from its complete final state.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-68745, -68744, -68314, -68313, -68312, -68311, 18944, 18945, 18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)) OR (`source_type` = 9 AND `entryorguid` IN (1900500, 1900501, 1900502, 1900503));
INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-68745,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infernal Relay (Hellfire) - On Respawn - Set Active On'),
(-68745,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infernal Relay (Hellfire) - On Corpse Removed - Set Active On'),
(-68745,0,46,47,63,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18948,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Stormwind Soldier'),
(-68745,0,47,48,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18949,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Stormwind Mage'),
(-68745,0,48,49,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18950,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Orgrimmar Grunt'),
(-68745,0,49,50,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18965,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Darnassian Archer'),
(-68745,0,50,51,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18966,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Justinius'),
(-68745,0,51,52,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18969,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Melgromm'),
(-68745,0,52,53,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18970,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Darkspear Axe Thrower'),
(-68745,0,53,54,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18971,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Undercity Mage'),
(-68745,0,54,55,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18972,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Orgrimmar Shaman'),
(-68745,0,55,0,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18986,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Ironforge Paladin'),
(-68744,0,5,6,61,0,100,0,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-230.616,1102.52,41.6672,4.24008,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,6,7,61,0,100,0,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-256.508,1108.92,41.6667,4.7019,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,7,8,61,0,100,0,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-242.871,1108.85,41.6667,4.69012,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,8,9,61,0,100,0,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-271.232,1105.23,41.6668,5.0713,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,9,0,61,0,100,0,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-231.023,1106.31,41.6668,4.43121,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infernal Relay (Hellfire) - On Respawn - Set Active On'),
(-68744,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infernal Relay (Hellfire) - On Corpse Removed - Set Active On'),
(-68744,0,46,47,63,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18948,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Stormwind Soldier'),
(-68744,0,47,48,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18949,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Stormwind Mage'),
(-68744,0,48,49,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18950,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Orgrimmar Grunt'),
(-68744,0,49,50,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18965,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Darnassian Archer'),
(-68744,0,50,51,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18966,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Justinius'),
(-68744,0,51,52,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18969,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Melgromm'),
(-68744,0,52,53,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18970,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Darkspear Axe Thrower'),
(-68744,0,53,54,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18971,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Undercity Mage'),
(-68744,0,54,55,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18972,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Orgrimmar Shaman'),
(-68744,0,55,0,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18986,0,220,2,0,0,0,0,'Infernal Relay - Startup - Respawn dead Ironforge Paladin'),
(-68314,0,0,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Set Active'),
(-68314,0,1,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Corpse Removed - Set Active'),
(-68314,0,2,3,11,0,100,0,0,0,0,0,0,0,11,51347,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Cast Teleport Visual Only'),
(-68314,0,3,0,61,0,100,512,0,0,0,0,0,0,67,1,5000,5000,0,0,100,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Create Timed Event'),
(-68314,0,4,0,59,0,100,512,1,0,0,0,0,0,80,1900503,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Run Script'),
(-68314,0,5,0,59,0,100,512,1,0,0,0,0,0,53,1,68314,0,0,0,2,1,0,0,0,0,0,0,0,0,'Wrath Master - On Timed Event - Start WP'),
(-68314,0,6,0,17,0,100,512,0,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Wrath Master - Just Summoned - Store Target'),
(-68314,0,7,0,6,0,100,512,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Death - Despawn'),
(-68314,0,8,0,4,0,100,0,0,0,0,0,0,0,39,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Aggro - Call For Help'),
(-68314,0,10,0,0,0,100,0,3000,13000,15000,31000,0,0,11,29574,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - In Combat - Cast Rend'),
(-68314,0,11,0,0,0,100,0,6000,19000,21000,36000,0,0,11,35871,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - In Combat - Cast Spellbreaker'),
(-68313,0,0,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Set Active'),
(-68313,0,1,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Corpse Removed - Set Active'),
(-68313,0,2,3,11,0,100,0,0,0,0,0,0,0,11,51347,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Cast Teleport Visual Only'),
(-68313,0,3,0,61,0,100,512,0,0,0,0,0,0,67,1,5000,5000,0,0,100,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Create Timed Event'),
(-68313,0,4,0,59,0,100,512,1,0,0,0,0,0,80,1900502,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Run Script'),
(-68313,0,5,0,59,0,100,512,1,0,0,0,0,0,53,1,68313,0,0,0,2,1,0,0,0,0,0,0,0,0,'Wrath Master - On Timed Event - Start WP'),
(-68313,0,6,0,17,0,100,512,0,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Wrath Master - Just Summoned - Store Target'),
(-68313,0,7,0,6,0,100,512,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Death - Despawn'),
(-68313,0,8,0,4,0,100,0,0,0,0,0,0,0,39,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Aggro - Call For Help'),
(-68313,0,10,0,0,0,100,0,3000,13000,15000,31000,0,0,11,29574,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - In Combat - Cast Rend'),
(-68313,0,11,0,0,0,100,0,6000,19000,21000,36000,0,0,11,35871,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - In Combat - Cast Spellbreaker'),
(-68312,0,0,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Set Active'),
(-68312,0,1,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Corpse Removed - Set Active'),
(-68312,0,2,3,11,0,100,0,0,0,0,0,0,0,11,51347,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Cast Teleport Visual Only'),
(-68312,0,3,0,61,0,100,512,0,0,0,0,0,0,67,1,5000,5000,0,0,100,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Create Timed Event'),
(-68312,0,4,0,59,0,100,512,1,0,0,0,0,0,80,1900501,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Run Script'),
(-68312,0,5,0,59,0,100,512,1,0,0,0,0,0,53,1,68312,0,0,0,2,1,0,0,0,0,0,0,0,0,'Wrath Master - On Timed Event - Start WP'),
(-68312,0,6,0,17,0,100,512,0,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Wrath Master - Just Summoned - Store Target'),
(-68312,0,7,0,6,0,100,512,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Death - Despawn'),
(-68312,0,8,0,4,0,100,0,0,0,0,0,0,0,39,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Aggro - Call For Help'),
(-68312,0,10,0,0,0,100,0,3000,13000,15000,31000,0,0,11,29574,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - In Combat - Cast Rend'),
(-68312,0,11,0,0,0,100,0,6000,19000,21000,36000,0,0,11,35871,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - In Combat - Cast Spellbreaker'),
(-68311,0,0,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Set Active'),
(-68311,0,1,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Corpse Removed - Set Active'),
(-68311,0,2,3,11,0,100,0,0,0,0,0,0,0,11,51347,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Cast Teleport Visual Only'),
(-68311,0,3,0,61,0,100,512,0,0,0,0,0,0,67,1,5000,5000,0,0,100,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Create Timed Event'),
(-68311,0,4,0,59,0,100,512,1,0,0,0,0,0,80,1900500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Run Script'),
(-68311,0,5,0,59,0,100,512,1,0,0,0,0,0,53,1,68311,0,0,0,2,1,0,0,0,0,0,0,0,0,'Wrath Master - On Timed Event - Start WP'),
(-68311,0,6,0,17,0,100,512,0,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Wrath Master - Just Summoned - Store Target'),
(-68311,0,7,0,6,0,100,512,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Death - Despawn'),
(-68311,0,8,0,4,0,100,0,0,0,0,0,0,0,39,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Aggro - Call For Help'),
(-68311,0,10,0,0,0,100,0,3000,13000,15000,31000,0,0,11,29574,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - In Combat - Cast Rend'),
(-68311,0,11,0,0,0,100,0,6000,19000,21000,36000,0,0,11,35871,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - In Combat - Cast Spellbreaker'),
(18944,0,0,0,38,0,100,512,1,1,0,0,0,0,29,1,120,0,0,0,0,23,0,0,0,0,0,0,0,0,'Fel Soldier - On Data Set - Follow'),
(18944,0,1,0,38,0,100,512,2,2,0,0,0,0,29,6,120,0,0,0,0,23,0,0,0,0,0,0,0,0,'Fel Soldier - On Data Set - Follow'),
(18944,0,2,0,38,0,100,512,3,3,0,0,0,0,29,1,240,0,0,0,0,23,0,0,0,0,0,0,0,0,'Fel Soldier - On Data Set - Follow'),
(18944,0,3,0,38,0,100,512,4,4,0,0,0,0,29,6,240,0,0,0,0,23,0,0,0,0,0,0,0,0,'Fel Soldier - On Data Set - Follow'),
(18944,0,4,5,25,0,100,257,0,0,0,0,0,0,11,51347,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - On Reset - Cast Teleport Visual Only'),
(18944,0,5,0,61,0,100,512,0,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - On Respawn - Set Run False'),
(18944,0,10,0,0,0,100,0,3000,12000,9000,15000,0,0,11,15496,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Fel Soldier - In Combat - Cast Cleave'),
(18944,0,11,0,0,0,100,0,6000,20000,16000,33000,0,0,11,32009,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Fel Soldier - In Combat - Cast Cutdown'),
(18944,0,12,0,4,0,100,0,0,0,0,0,0,0,39,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - On Aggro - Call For Help'),
(18944,0,13,0,60,0,100,512,5000,5000,5000,5000,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - On Update - Set Home Position'),
(18944,0,14,0,1,0,100,512,10000,10000,10000,10000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - On Update - Despawn'),
(18944,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - On Respawn - Set Active On'),
(18944,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - On Corpse Removed - Set Active On'),
(18945,0,0,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Pit Commander - On Respawn - Set Active'),
(18945,0,1,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Pit Commander - On Corpse Removed - Set Active'),
(18945,0,2,3,11,0,100,512,0,0,0,0,0,0,211,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Pit Commander - On Respawn - No Phase Event Reset'),
(18945,0,3,4,61,0,100,512,0,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Pit Commander - On Respawn - Set Event Phase 0'),
(18945,0,4,0,61,0,100,512,0,0,0,0,0,0,80,1894500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Pit Commander - On Respawn - Run Script'),
(18945,0,5,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Pit Commander - On Reached Home - Set Event Phase'),
(18945,0,7,0,40,0,100,512,43,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Pit Commander - On WP Reached - Set Event Phase'),
(18945,0,8,0,6,0,100,512,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Pit Commander - On Death - Despawn'),
(18945,0,10,0,0,0,100,0,3000,7000,7000,11000,0,0,11,16044,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Pit Commander - In Combat - Cast Cleave'),
(18945,0,11,0,0,0,100,0,12000,19000,21000,31000,0,0,11,33627,0,0,0,0,0,5,20,0,0,0,0,0,0,0,'Pit Commander - In Combat - Cast Rain of Fire'),
(18945,0,12,0,1,1,100,0,2000,2000,50000,50000,0,0,11,33393,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Pit Commander - Out of Combat - Cast Summon Infernals'),
(18945,0,13,0,1,1,100,512,6000,6000,50000,50000,0,0,45,33637,0,0,0,0,0,10,74081,21075,0,0,0,0,0,0,'Pit Commander - Out of Combat - Set Data'),
(18945,0,14,0,1,1,100,512,7000,7000,50000,50000,0,0,45,33637,0,0,0,0,0,10,74082,21075,0,0,0,0,0,0,'Pit Commander - Out of Combat - Set Data'),
(18948,0,0,1,11,0,100,512,0,0,0,0,0,0,67,1,500,6500,0,0,100,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Respawn - Create Timed Event'),
(18948,0,1,0,61,0,100,512,0,0,0,0,0,0,62,0,0,0,0,0,0,1,0,0,0,0,-337.49,962.62,54.4,1.57,'Stormwind Soldier - On Respawn - Teleport'),
(18948,0,2,12,59,0,100,0,1,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Timed Event - Stop Combat'),
(18948,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On WP Reached - Play Emote'),
(18948,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On WP Reached - Create Timed Event'),
(18948,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Timed Event - Set Home Position to Respawn'),
(18948,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Timed Event - Evade'),
(18948,0,7,0,4,0,100,0,0,0,0,0,0,0,39,30,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Aggro - Call For Help'),
(18948,0,10,0,0,0,100,0,3000,9000,8000,13000,0,0,11,33626,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Stormwind Soldier - In Combat - Cast Strike'),
(18948,0,11,0,0,0,40,0,3000,29000,28000,53000,0,0,11,23511,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - In Combat - Cast Demoralizing Shout'),
(18948,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920001,0,0,0,2,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - Linked - Start WP'),
(18948,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Respawn - Set Active On'),
(18948,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Corpse Removed - Set Active On'),
(18948,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Respawn - Set Passive while marching'),
(18948,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On reached home marker - Activate combat'),
(18948,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On reached home - Enter combat-ready phase'),
(18948,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Stormwind Soldier - Combat-ready - Engage nearest enemy (hold line)'),
(18948,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Respawn - Set corpse delay to 10s'),
(18949,0,0,1,11,0,100,512,0,0,0,0,0,0,67,1,500,1500,0,0,100,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Respawn - Create Timed Event'),
(18949,0,1,0,61,0,100,512,0,0,0,0,0,0,62,0,0,0,0,0,0,1,0,0,0,0,-337.49,962.62,54.4,1.57,'Stormwind Mage - On Respawn - Teleport'),
(18949,0,2,12,59,0,100,512,1,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Timed Event - Evade'),
(18949,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On plateau WP 11 - Salute commanders'),
(18949,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Stormwind Mage - Linked - Create timed event 2'),
(18949,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - Timed event 2 - Set home to spawn'),
(18949,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - Linked - Evade to spawn marker'),
(18949,0,10,0,0,0,100,0,1000,2000,3000,5000,0,0,11,33417,1088,0,0,0,0,2,0,0,0,0,0,0,0,0,'Stormwind Mage - In Combat - Cast Fireball'),
(18949,0,11,0,0,0,100,0,3000,17000,20000,40000,0,0,11,33419,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Stormwind Mage - In Combat - Cast Arcane Missiles'),
(18949,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920004,0,0,0,2,1,0,0,0,0,0,0,0,0,'Stormwind Mage - Linked - Start WP (upper plateau)'),
(18949,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Respawn - Set Active On'),
(18949,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Corpse Removed - Set Active On'),
(18949,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Respawn - Set Passive while marching'),
(18949,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On reached home marker - Activate combat'),
(18949,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On reached home - Enter combat-ready phase'),
(18949,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,22,0,0,0,0,0,0,0,'Stormwind Mage - Combat-ready - Engage nearest enemy (hold line)'),
(18949,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Respawn - Set corpse delay to 10s'),
(18950,0,0,1,11,0,100,512,0,0,0,0,0,0,67,1,500,6500,0,0,100,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Respawn - Create Timed Event'),
(18950,0,1,0,61,0,100,512,0,0,0,0,0,0,62,0,0,0,0,0,0,1,0,0,0,0,-161.31,965.4,54.4,1.57,'Orgrimmar Grunt - On Respawn - Teleport'),
(18950,0,2,12,59,0,100,0,1,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Timed Event - Stop Combat'),
(18950,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On WP Reached - Play Emote'),
(18950,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On WP Reached - Create Timed Event'),
(18950,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Timed Event - Set Home Position to Respawn'),
(18950,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Timed Event - Evade'),
(18950,0,7,0,4,0,100,0,0,0,0,0,0,0,39,30,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Aggro - Call For Help'),
(18950,0,10,0,0,0,100,0,3000,9000,8000,13000,0,0,11,33626,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - In Combat - Cast Strike'),
(18950,0,11,0,0,0,40,0,3000,29000,28000,53000,0,0,11,23511,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - In Combat - Cast Demoralizing Shout'),
(18950,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920011,0,0,0,2,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - Linked - Start WP'),
(18950,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Respawn - Set Active On'),
(18950,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Corpse Removed - Set Active On'),
(18950,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Respawn - Set Passive while marching'),
(18950,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On reached home marker - Activate combat'),
(18950,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On reached home - Enter combat-ready phase'),
(18950,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Orgrimmar Grunt - Combat-ready - Engage nearest enemy (hold line)'),
(18950,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Respawn - Set corpse delay to 10s'),
(18965,0,0,1,11,0,100,512,0,0,0,0,0,0,67,1,500,6500,0,0,100,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Respawn - Create Timed Event'),
(18965,0,1,0,61,0,100,512,0,0,0,0,0,0,62,0,0,0,0,0,0,1,0,0,0,0,-337.49,962.62,54.4,1.57,'Darnassian Archer - On Respawn - Teleport'),
(18965,0,2,12,59,0,100,0,1,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Timed Event - Stop Combat'),
(18965,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On WP Reached - Play Emote'),
(18965,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On WP Reached - Create Timed Event'),
(18965,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Timed Event - Set Home Position to Respawn'),
(18965,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Timed Event - Evade'),
(18965,0,10,0,9,0,100,0,0,0,2000,3000,5,30,11,15620,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Darnassian Archer - Within 5-30 Range - Cast Shoot'),
(18965,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920003,0,0,0,2,1,0,0,0,0,0,0,0,0,'Darnassian Archer - Linked - Start WP'),
(18965,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Respawn - Set Active On'),
(18965,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Corpse Removed - Set Active On'),
(18965,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Respawn - Set Passive while marching'),
(18965,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On reached home marker - Activate combat'),
(18965,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On reached home - Enter combat-ready phase'),
(18965,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Darnassian Archer - Combat-ready - Engage nearest enemy (hold line)'),
(18965,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Respawn - Set corpse delay to 10s'),
(18966,0,0,0,4,0,100,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Aggro - Say Line 0'),
(18966,0,1,0,0,0,100,0,5000,10000,10000,20000,0,0,11,33554,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Justinius the Harbinger - In Combat - Cast Judgement of Command'),
(18966,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Respawn - Set Active On'),
(18966,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Corpse Removed - Set Active On'),
(18966,0,74,0,0,0,100,0,7000,11000,12000,18000,0,0,11,20922,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Justinius the Harbinger - In Combat - Cast Consecration (Rank 3)'),
(18966,0,75,0,2,0,100,0,1,45,8000,14000,0,0,11,37254,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - At 45% HP - Cast Flash of Light'),
(18966,0,76,0,4,0,100,1,0,0,0,0,0,0,11,29381,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Aggro - Cast Greater Blessing of Might'),
(18966,0,77,0,2,0,100,0,1,15,60000,60000,0,0,11,13874,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - At 15% HP - Cast Divine Shield'),
(18966,0,78,0,1,0,100,0,2000,2000,30000,30000,0,0,11,29381,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - Out of Combat - Buff allies (Greater Blessing of Might)'),
(18966,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius - On Respawn - Set Passive while marching'),
(18966,0,99,0,11,0,100,512,0,0,0,0,0,0,67,9,15000,15000,0,0,100,1,0,0,0,0,0,0,0,0,'Justinius - On Respawn - Arm activation timer (no march)'),
(18966,0,100,0,59,0,100,512,9,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius - Activation timer 9 - Set aggressive'),
(18966,0,101,0,59,0,100,512,9,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius - Activation timer 9 - Enter combat-ready phase'),
(18966,0,102,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Justinius - Combat-ready - Engage nearest enemy (hold line)'),
(18966,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Respawn - Set corpse delay to 10s'),
(18969,0,0,0,0,0,100,0,5000,10000,10000,20000,0,0,11,33643,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Melgromm Highmountain - In Combat - Cast Chain Lightning'),
(18969,0,1,0,0,0,100,0,5000,10000,10000,20000,0,0,11,22885,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Melgromm Highmountain - In Combat - Cast Earth Shock'),
(18969,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - On Respawn - Set Active On'),
(18969,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - On Corpse Removed - Set Active On'),
(18969,0,73,0,0,0,100,0,6000,10000,22000,30000,0,0,11,33570,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - In Combat - Cast Strength of the Storm Totem'),
(18969,0,74,0,2,0,100,0,1,50,7000,12000,0,0,11,33642,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - At 50% HP - Cast Chain Heal'),
(18969,0,75,0,0,0,100,0,9000,14000,25000,31000,0,0,11,33560,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - In Combat - Cast Magma Flow Totem'),
(18969,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm - On Respawn - Set Passive while marching'),
(18969,0,99,0,11,0,100,512,0,0,0,0,0,0,67,9,15000,15000,0,0,100,1,0,0,0,0,0,0,0,0,'Melgromm - On Respawn - Arm activation timer (no march)'),
(18969,0,100,0,59,0,100,512,9,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm - Activation timer 9 - Set aggressive'),
(18969,0,101,0,59,0,100,512,9,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm - Activation timer 9 - Enter combat-ready phase'),
(18969,0,102,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Melgromm - Combat-ready - Engage nearest enemy (hold line)'),
(18969,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - On Respawn - Set corpse delay to 10s'),
(18970,0,0,1,11,0,100,512,0,0,0,0,0,0,67,1,500,6500,0,0,100,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Respawn - Create Timed Event'),
(18970,0,1,0,61,0,100,512,0,0,0,0,0,0,62,0,0,0,0,0,0,1,0,0,0,0,-161.31,965.4,54.4,1.57,'Darkspear Axe Thrower - On Respawn - Teleport'),
(18970,0,2,12,59,0,100,0,1,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Timed Event - Stop Combat'),
(18970,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On WP Reached - Play Emote'),
(18970,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On WP Reached - Create Timed Event'),
(18970,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Timed Event - Set Home Position to Respawn'),
(18970,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Timed Event - Evade'),
(18970,0,10,0,0,0,100,0,0,2000,2300,3900,0,0,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - In Combat - Cast Throw'),
(18970,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920013,0,0,0,2,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - Linked - Start WP'),
(18970,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Respawn - Set Active On'),
(18970,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Corpse Removed - Set Active On'),
(18970,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Respawn - Set Passive while marching'),
(18970,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On reached home marker - Activate combat'),
(18970,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On reached home - Enter combat-ready phase'),
(18970,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Darkspear Axe Thrower - Combat-ready - Engage nearest enemy (hold line)'),
(18970,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Respawn - Set corpse delay to 10s'),
(18971,0,0,1,11,0,100,512,0,0,0,0,0,0,67,1,500,1500,0,0,100,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Respawn - Create Timed Event'),
(18971,0,1,0,61,0,100,512,0,0,0,0,0,0,62,0,0,0,0,0,0,1,0,0,0,0,-161.31,965.4,54.4,1.57,'Undercity Mage - On Respawn - Teleport'),
(18971,0,2,12,59,0,100,512,1,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Timed Event - Evade'),
(18971,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On plateau WP 11 - Salute commanders'),
(18971,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Undercity Mage - Linked - Create timed event 2'),
(18971,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - Timed event 2 - Set home to spawn'),
(18971,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - Linked - Evade to spawn marker'),
(18971,0,10,0,0,0,100,0,1000,2000,3000,5000,0,0,11,33417,1088,0,0,0,0,2,0,0,0,0,0,0,0,0,'Undercity Mage - In Combat - Cast Fireball'),
(18971,0,11,0,0,0,100,0,3000,17000,20000,40000,0,0,11,33419,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Undercity Mage - In Combat - Cast Arcane Missiles'),
(18971,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920014,0,0,0,2,1,0,0,0,0,0,0,0,0,'Undercity Mage - Linked - Start WP (upper plateau)'),
(18971,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Respawn - Set Active On'),
(18971,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Corpse Removed - Set Active On'),
(18971,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Respawn - Set Passive while marching'),
(18971,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On reached home marker - Activate combat'),
(18971,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On reached home - Enter combat-ready phase'),
(18971,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,22,0,0,0,0,0,0,0,'Undercity Mage - Combat-ready - Engage nearest enemy (hold line)'),
(18971,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Respawn - Set corpse delay to 10s'),
(18972,0,0,1,11,0,100,512,0,0,0,0,0,0,67,1,500,6500,0,0,100,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Respawn - Create Timed Event'),
(18972,0,1,0,61,0,100,512,0,0,0,0,0,0,62,0,0,0,0,0,0,1,0,0,0,0,-161.31,965.4,54.4,1.57,'Orgrimmar Shaman - On Respawn - Teleport'),
(18972,0,2,12,59,0,100,0,1,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Timed Event - Stop Combat'),
(18972,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On WP Reached - Play Emote'),
(18972,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On WP Reached - Create Timed Event'),
(18972,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Timed Event - Set Home Position to Respawn'),
(18972,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Timed Event - Evade'),
(18972,0,10,0,0,0,100,0,3000,12000,12000,18000,0,0,11,15616,0,0,0,0,0,5,20,0,0,0,0,0,0,0,'Orgrimmar Shaman - In Combat - Cast Flame Shock'),
(18972,0,11,0,0,0,100,0,0,5000,60000,60000,0,0,11,20545,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - In Combat - Cast Lightning Shield'),
(18972,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920012,0,0,0,2,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - Linked - Start WP'),
(18972,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Respawn - Set Active On'),
(18972,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Corpse Removed - Set Active On'),
(18972,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Respawn - Set Passive while marching'),
(18972,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On reached home marker - Activate combat'),
(18972,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On reached home - Enter combat-ready phase'),
(18972,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Orgrimmar Shaman - Combat-ready - Engage nearest enemy (hold line)'),
(18972,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Respawn - Set corpse delay to 10s'),
(18986,0,0,1,11,0,100,512,0,0,0,0,0,0,67,1,500,6500,0,0,100,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Respawn - Create Timed Event'),
(18986,0,1,0,61,0,100,512,0,0,0,0,0,0,62,0,0,0,0,0,0,1,0,0,0,0,-337.49,962.62,54.4,1.57,'Ironforge Paladin - On Respawn - Teleport'),
(18986,0,2,12,59,0,100,0,1,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Timed Event - Stop Combat'),
(18986,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On WP Reached - Play Emote'),
(18986,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On WP Reached - Create Timed Event'),
(18986,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Timed Event - Set Home Position to Respawn'),
(18986,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Timed Event - Evade'),
(18986,0,10,0,0,0,100,0,3000,9000,8000,13000,0,0,11,20696,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Ironforge Paladin - In Combat - Cast Holy Smite'),
(18986,0,11,0,0,0,40,0,3000,12000,15000,28000,0,0,11,33632,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Ironforge Paladin - In Combat - Cast Exorcism'),
(18986,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920002,0,0,0,2,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - Linked - Start WP'),
(18986,0,42,0,11,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Respawn - Set Active On'),
(18986,0,43,0,36,0,100,512,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Corpse Removed - Set Active On'),
(18986,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Respawn - Set Passive while marching'),
(18986,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On reached home marker - Activate combat'),
(18986,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On reached home - Enter combat-ready phase'),
(18986,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Ironforge Paladin - Combat-ready - Engage nearest enemy (hold line)'),
(18986,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Respawn - Set corpse delay to 10s'),
(1900500,9,0,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-298,1529,37.92391,0.18216586,'Wrath Master - On Script - Summon Fel Soldier'),
(1900500,9,1,0,0,0,100,0,0,0,0,0,0,0,45,1,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900500,9,2,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-307,1530,37.92391,0.18216586,'Wrath Master - On Script - Summon Fel Soldier'),
(1900500,9,3,0,0,0,100,0,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900500,9,4,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-297.8,1520.7,37.92391,0.18216586,'Wrath Master - On Script - Summon Fel Soldier'),
(1900500,9,5,0,0,0,100,0,0,0,0,0,0,0,45,3,3,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900500,9,6,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-307.4,1519.9,37.92391,0.18216586,'Wrath Master - On Script - Summon Fel Soldier'),
(1900500,9,7,0,0,0,100,0,0,0,0,0,0,0,45,4,4,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900501,9,0,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-142,1514.9,33.62471,3.0842154,'Wrath Master - On Script - Summon Fel Soldier'),
(1900501,9,1,0,0,0,100,0,0,0,0,0,0,0,45,1,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900501,9,2,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-151.1,1515.4,33.62471,3.0842154,'Wrath Master - On Script - Summon Fel Soldier'),
(1900501,9,3,0,0,0,100,0,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900501,9,4,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-141.8,1506,33.62471,3.0842154,'Wrath Master - On Script - Summon Fel Soldier'),
(1900501,9,5,0,0,0,100,0,0,0,0,0,0,0,45,3,3,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900501,9,6,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-151.4,1505.2,33.62471,3.0842154,'Wrath Master - On Script - Summon Fel Soldier'),
(1900501,9,7,0,0,0,100,0,0,0,0,0,0,0,45,4,4,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900502,9,0,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-80,1886,74.695015,2.5140123,'Wrath Master - On Script - Summon Fel Soldier'),
(1900502,9,1,0,0,0,100,0,0,0,0,0,0,0,45,1,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900502,9,2,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-89.2,1886.5,74.695015,2.5140123,'Wrath Master - On Script - Summon Fel Soldier'),
(1900502,9,3,0,0,0,100,0,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900502,9,4,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-79.8,1877.7,74.695015,2.5140123,'Wrath Master - On Script - Summon Fel Soldier'),
(1900502,9,5,0,0,0,100,0,0,0,0,0,0,0,45,3,3,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900502,9,6,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-89.6,1876.9,74.695015,2.5140123,'Wrath Master - On Script - Summon Fel Soldier'),
(1900502,9,7,0,0,0,100,0,0,0,0,0,0,0,45,4,4,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900503,9,0,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-414.7,1851.2,81.09361,1.7246842,'Wrath Master - On Script - Summon Fel Soldier'),
(1900503,9,1,0,0,0,100,0,0,0,0,0,0,0,45,1,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900503,9,2,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-424.3,1851.8,81.09361,1.7246842,'Wrath Master - On Script - Summon Fel Soldier'),
(1900503,9,3,0,0,0,100,0,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900503,9,4,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-414.4,1842.5,81.09361,1.7246842,'Wrath Master - On Script - Summon Fel Soldier'),
(1900503,9,5,0,0,0,100,0,0,0,0,0,0,0,45,3,3,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data'),
(1900503,9,6,0,0,0,100,0,0,0,0,0,0,0,12,18944,8,0,0,0,0,8,0,0,0,0,-425,1841.7,81.09361,1.7246842,'Wrath Master - On Script - Summon Fel Soldier'),
(1900503,9,7,0,0,0,100,0,0,0,0,0,0,0,45,4,4,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data');

-- =============================================================================
-- Per-role waypoints: all NPCs march the high terrace to the commander plateau
-- (point 11, behind Justinius/Melgromm) and salute there. The path ENDS at the
-- plateau so the base script chain (reach point 11 -> emote -> set home to spawn
-- -> evade) sends each unit back to its OWN spawn marker via pathfinding (down
-- the stairs). This spreads them across the markers instead of stacking on one.
-- =============================================================================

DELETE FROM `waypoints` WHERE `entry` IN (920001,920002,920003,920004,920005,920011,920012,920013,920014,920015);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
-- 920001  Stormwind Soldiers : high terrace -> plateau salute (pt11 = last)
(920001,1,-334.99,968.724,54.284,'Soldiers - terrace'),
(920001,2,-332.945,976.655,54.296,'Soldiers - terrace'),
(920001,3,-329.261,988.924,54.304,'Soldiers - terrace'),
(920001,4,-322.755,1002.57,54.299,'Soldiers - terrace'),
(920001,5,-316.731,1015.21,54.295,'Soldiers - terrace'),
(920001,6,-308.524,1019.75,54.276,'Soldiers - terrace'),
(920001,7,-296.914,1021.11,54.309,'Soldiers - terrace'),
(920001,8,-283.465,1025.01,54.301,'Soldiers - terrace'),
(920001,9,-273.568,1036.39,54.326,'Soldiers - terrace'),
(920001,10,-267,1054,54.32,'Soldiers - approach plateau'),
(920001,11,-267,1066,54.39,'Soldiers - plateau SALUTE (behind commanders)'),
-- 920002  Ironforge Paladins : plateau salute (pt11 = last)
(920002,1,-334.99,968.724,54.284,'Paladins - terrace'),
(920002,2,-332.945,976.655,54.296,'Paladins - terrace'),
(920002,3,-329.261,988.924,54.304,'Paladins - terrace'),
(920002,4,-322.755,1002.57,54.299,'Paladins - terrace'),
(920002,5,-316.731,1015.21,54.295,'Paladins - terrace'),
(920002,6,-308.524,1019.75,54.276,'Paladins - terrace'),
(920002,7,-296.914,1021.11,54.309,'Paladins - terrace'),
(920002,8,-283.465,1025.01,54.301,'Paladins - terrace'),
(920002,9,-273.568,1036.39,54.326,'Paladins - terrace'),
(920002,10,-267,1054,54.32,'Paladins - approach plateau'),
(920002,11,-267,1066,54.39,'Paladins - plateau SALUTE (behind commanders)'),
-- 920003  Darnassian Archers : plateau salute (pt11 = last)
(920003,1,-334.99,968.724,54.284,'Archers - terrace'),
(920003,2,-332.945,976.655,54.296,'Archers - terrace'),
(920003,3,-329.261,988.924,54.304,'Archers - terrace'),
(920003,4,-322.755,1002.57,54.299,'Archers - terrace'),
(920003,5,-316.731,1015.21,54.295,'Archers - terrace'),
(920003,6,-308.524,1019.75,54.276,'Archers - terrace'),
(920003,7,-296.914,1021.11,54.309,'Archers - terrace'),
(920003,8,-283.465,1025.01,54.301,'Archers - terrace'),
(920003,9,-273.568,1036.39,54.326,'Archers - terrace'),
(920003,10,-267,1054,54.32,'Archers - approach plateau'),
(920003,11,-267,1066,54.39,'Archers - plateau SALUTE (behind commanders)'),
-- 920004  Stormwind Mages : plateau salute (pt11 = last, stays high)
(920004,1,-334.99,968.724,54.284,'SW Mages - terrace'),
(920004,2,-332.945,976.655,54.296,'SW Mages - terrace'),
(920004,3,-329.261,988.924,54.304,'SW Mages - terrace'),
(920004,4,-322.755,1002.57,54.299,'SW Mages - terrace'),
(920004,5,-316.731,1015.21,54.295,'SW Mages - terrace'),
(920004,6,-308.524,1019.75,54.276,'SW Mages - terrace'),
(920004,7,-296.914,1021.11,54.309,'SW Mages - terrace'),
(920004,8,-283.465,1025.01,54.301,'SW Mages - terrace'),
(920004,9,-273.568,1036.39,54.326,'SW Mages - terrace'),
(920004,10,-270,1054,54.32,'SW Mages - approach plateau'),
(920004,11,-270,1066,54.39,'SW Mages - plateau SALUTE (behind commanders)'),
-- 920005  Justinius (spawns at top already)  -> marker 68609
(920005,1,-269.433,1072.02,54.3907,'Justinius - top plateau marker'),
-- 920011  Orgrimmar Grunts : plateau salute (pt11 = last)
(920011,1,-163.282,972.931,54.2865,'Grunts - terrace'),
(920011,2,-167.265,987.781,54.3042,'Grunts - terrace'),
(920011,3,-170.451,998.956,54.2921,'Grunts - terrace'),
(920011,4,-177.333,1012.5,54.2872,'Grunts - terrace'),
(920011,5,-189.116,1020.06,54.2777,'Grunts - terrace'),
(920011,6,-206.5,1022.07,54.3103,'Grunts - terrace'),
(920011,7,-220.28,1024.54,54.3101,'Grunts - terrace'),
(920011,8,-228.761,1035.68,54.326,'Grunts - terrace'),
(920011,9,-233.435,1046.39,54.3183,'Grunts - terrace'),
(920011,10,-234,1058,54.32,'Grunts - approach plateau'),
(920011,11,-233,1066,54.39,'Grunts - plateau SALUTE (behind commanders)'),
-- 920012  Orgrimmar Shamans : plateau salute (pt11 = last)
(920012,1,-163.282,972.931,54.2865,'Shamans - terrace'),
(920012,2,-167.265,987.781,54.3042,'Shamans - terrace'),
(920012,3,-170.451,998.956,54.2921,'Shamans - terrace'),
(920012,4,-177.333,1012.5,54.2872,'Shamans - terrace'),
(920012,5,-189.116,1020.06,54.2777,'Shamans - terrace'),
(920012,6,-206.5,1022.07,54.3103,'Shamans - terrace'),
(920012,7,-220.28,1024.54,54.3101,'Shamans - terrace'),
(920012,8,-228.761,1035.68,54.326,'Shamans - terrace'),
(920012,9,-233.435,1046.39,54.3183,'Shamans - terrace'),
(920012,10,-234,1058,54.32,'Shamans - approach plateau'),
(920012,11,-233,1066,54.39,'Shamans - plateau SALUTE (behind commanders)'),
-- 920013  Darkspear Axe Throwers : plateau salute (pt11 = last)
(920013,1,-163.282,972.931,54.2865,'Axe Throwers - terrace'),
(920013,2,-167.265,987.781,54.3042,'Axe Throwers - terrace'),
(920013,3,-170.451,998.956,54.2921,'Axe Throwers - terrace'),
(920013,4,-177.333,1012.5,54.2872,'Axe Throwers - terrace'),
(920013,5,-189.116,1020.06,54.2777,'Axe Throwers - terrace'),
(920013,6,-206.5,1022.07,54.3103,'Axe Throwers - terrace'),
(920013,7,-220.28,1024.54,54.3101,'Axe Throwers - terrace'),
(920013,8,-228.761,1035.68,54.326,'Axe Throwers - terrace'),
(920013,9,-233.435,1046.39,54.3183,'Axe Throwers - terrace'),
(920013,10,-234,1058,54.32,'Axe Throwers - approach plateau'),
(920013,11,-233,1066,54.39,'Axe Throwers - plateau SALUTE (behind commanders)'),
-- 920014  Undercity Mages : plateau salute (pt11 = last, stays high)
(920014,1,-163.282,972.931,54.2865,'UC Mages - terrace'),
(920014,2,-167.265,987.781,54.3042,'UC Mages - terrace'),
(920014,3,-170.451,998.956,54.2921,'UC Mages - terrace'),
(920014,4,-177.333,1012.5,54.2872,'UC Mages - terrace'),
(920014,5,-189.116,1020.06,54.2777,'UC Mages - terrace'),
(920014,6,-206.5,1022.07,54.3103,'UC Mages - terrace'),
(920014,7,-220.28,1024.54,54.3101,'UC Mages - terrace'),
(920014,8,-228.761,1035.68,54.326,'UC Mages - terrace'),
(920014,9,-233.435,1046.39,54.3183,'UC Mages - terrace'),
(920014,10,-230,1058,54.32,'UC Mages - approach plateau'),
(920014,11,-230,1066,54.39,'UC Mages - plateau SALUTE (behind commanders)'),
-- 920015  Melgromm (spawns at top already)  -> marker 68616
(920015,1,-230.394,1072.02,54.391,'Melgromm - top plateau marker');

-- Rebuild formations by ROLE/ROW: each unit type occupies the marker row matching
-- its terrain tier (plateau mages/commanders, ramp archers, mid casters, front melee),
-- pairing 1 unit -> 1 distinct marker so no two units stack on the same marker.
SET @FORMATION_FLAGS := 515; -- FOLLOW_LEADER + mutual assist

DROP TEMPORARY TABLE IF EXISTS `tmp_dp_assign`;
DROP TEMPORARY TABLE IF EXISTS `tmp_dp_used`;

CREATE TEMPORARY TABLE `tmp_dp_assign` AS
WITH `mk` AS (
    SELECT `guid`, `position_x` AS `x`, `position_y` AS `y`, `position_z` AS `z`,
           CASE WHEN `position_x` <= -250 THEN 'A' ELSE 'H' END AS `side`,
           CASE WHEN `position_z` >= 52 THEN 'plat'
                WHEN `position_z` >= 44 THEN 'ramp'
                WHEN `position_y` >= 1096 THEN 'front'
                ELSE 'mid' END AS `band`
    FROM `creature`
    WHERE `map` = 530 AND `id1` = 19179
      AND `position_x` BETWEEN -280 AND -220 AND `position_y` BETWEEN 1065 AND 1100
), `platrk` AS (
    SELECT
        `guid`, `x`, `side`,
        ROW_NUMBER() OVER (PARTITION BY `side` ORDER BY `y`) AS `prn`
    FROM `mk` WHERE `band` = 'plat'
), `mkrole` AS (
    SELECT `guid`, `x`, `side`, CASE WHEN `prn` = 1 THEN 'cmd' ELSE 'mage' END AS `role` FROM `platrk`
    UNION ALL
    SELECT `guid`, `x`, `side`, `band` FROM `mk` WHERE `band` IN ('ramp','front','mid')
), `mkn` AS (
    SELECT
        `guid`, `side`, `role`, ROW_NUMBER() OVER (PARTITION BY `side`, `role` ORDER BY `x`) AS `rn`
    FROM `mkrole`
), `un` AS (
    SELECT `guid`, `id1`, `position_x` AS `x`,
           CASE WHEN `position_x` <= -250 THEN 'A' ELSE 'H' END AS `side`,
           CASE `id1`
                WHEN 18948 THEN 'front' WHEN 18986 THEN 'mid' WHEN 18965 THEN 'ramp'
                WHEN 18949 THEN 'mage'  WHEN 18966 THEN 'cmd'
                WHEN 18950 THEN 'front' WHEN 18972 THEN 'mid' WHEN 18970 THEN 'ramp'
                WHEN 18971 THEN 'mage'  WHEN 18969 THEN 'cmd' END AS `role`
    FROM `creature`
    WHERE `map` = 530
      AND `id1` IN (18948,18986,18965,18949,18966,18950,18972,18970,18971,18969)
      AND `position_x` BETWEEN -290 AND -210 AND `position_y` BETWEEN 1065 AND 1105
), `unflt` AS (
    -- drop the lone boundary grunt on the Alliance side (no Horde-melee marker there)
    SELECT * FROM `un` WHERE NOT (`id1` = 18950 AND `side` = 'A')
), `unn` AS (
    SELECT
        `guid`, `side`, `role`, ROW_NUMBER() OVER (PARTITION BY `side`, `role` ORDER BY `x`) AS `rn`
    FROM `unflt`
)
SELECT
    `u`.`guid` AS `member_guid`, `m`.`guid` AS `marker_guid`
FROM `unn` AS `u`
JOIN `mkn` AS `m` ON `u`.`side` = `m`.`side` AND `u`.`role` = `m`.`role` AND `u`.`rn` = `m`.`rn`;

-- Markers that actually receive a unit (used as formation leaders).
CREATE TEMPORARY TABLE `tmp_dp_used` AS
SELECT DISTINCT `marker_guid` FROM `tmp_dp_assign`;

-- Clear any existing formation rows for these army units and markers.
DELETE FROM `creature_formations` WHERE `leaderGUID` IN ( SELECT `guid` FROM `creature` WHERE `map` = 530 AND `id1` = 19179 AND `position_x` BETWEEN -280 AND -220 AND `position_y` BETWEEN 1065 AND 1100 );
-- Leader self-rows (a formation only activates when its leader is present as a member).
INSERT INTO `creature_formations`
(`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`)
SELECT `marker_guid`, `marker_guid`, 0, 0, @FORMATION_FLAGS, 0, 0 FROM `tmp_dp_used`;

-- Member rows: each unit pinned (dist 0) onto its own role-matched marker.
DELETE FROM `creature_formations` WHERE `memberGUID` IN ( SELECT `guid` FROM `creature` WHERE `map` = 530 AND `id1` IN (18948,18949,18950,18965,18966,18969,18970,18971,18972,18986) AND `position_x` BETWEEN -290 AND -210 AND `position_y` BETWEEN 1065 AND 1105 );
INSERT INTO `creature_formations`
(`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`)
SELECT `marker_guid`, `member_guid`, 0, 0, @FORMATION_FLAGS, 0, 0 FROM `tmp_dp_assign`;

DROP TEMPORARY TABLE IF EXISTS `tmp_dp_assign`;
DROP TEMPORARY TABLE IF EXISTS `tmp_dp_used`;

-- Totem passive spells. The summon spells (33560/33570) only create the totem
-- creature; the buff/effect comes from the totem auto-casting its own passive on
-- summon (Totem::InitSummon casts creature_template_spell index 0). These two
-- totems had NO creature_template_spell row, so they spawned inert and did nothing
-- ("the totem not buffing nearby allies"). Give them their authentic passive:
--   19225 Strength of the Storm Totem -> 33571 (party % stat buff, radiates to
--          nearby allies that share the totem's faction; the totem inherits its
--          summoner Melgromm's faction via Minion::InitStats).
--   19222 Magma Flow Totem            -> 33561 (periodic fire damage to enemies).
DELETE FROM `creature_template_spell` WHERE `CreatureID` IN (19222, 19225) AND `Index` = 0;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(19225, 0, 33571, NULL),
(19222, 0, 33561, NULL);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 18966 AND `SourceGroup` = 75) OR (`SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 33559 AND `SourceGroup` IN (1, 2, 3));
INSERT INTO `conditions`
(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
 `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
 `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(22,75,18966,0,0,24,2,3,0,0,0,0,0,'','Justinius Consecration only runs when his victim is a demon');

-- Fix Justinius Greater Blessing of Might (29381) to his NPC allies. Target can't be a player.
-- ConditionType 32 = CONDITION_TYPE_MASK
-- Value1 = 0x0010 (TYPEMASK_PLAYER)
-- NegativeCondition = 1 (Must NOT be a player)
-- ConditionTarget = 0 (0 = the target being validated by the spell search, 1 = the caster of the spell)
-- SourceType = 13 (CONDITION_SOURCE_TYPE_SPELL_IMPLICIT_TARGET)

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=29381;
INSERT INTO `conditions`
(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 29381, 0, 0, 32, 0, 16, 0, 0, 1, 0, 0, '', 'Justinius Greater Blessing of Might cannot target players');

UPDATE `creature` SET `map` = 530,
    `zoneId` = 3483,
    `areaId` = 3483,
    `spawnMask` = 1,
    `phaseMask` = 4294967295,
    `position_x` = -302.05676,
    `position_y` = 1524.8987,
    `position_z` = 37.92391,
    `orientation` = 0.18216586,
    `spawntimesecs` = 10,
    `wander_distance` = 0,
    `MovementType` = 0,
    `curhealth` = 143620,
    `Comment` = 'GUID SAI'
WHERE `guid` = 68311 AND `id1` = 19005;

UPDATE `creature` SET `map` = 530,
    `zoneId` = 3483,
    `areaId` = 3483,
    `spawnMask` = 1,
    `phaseMask` = 4294967295,
    `position_x` = -146.42024,
    `position_y` = 1510.6957,
    `position_z` = 33.62471,
    `orientation` = 3.0842154,
    `spawntimesecs` = 10,
    `wander_distance` = 0,
    `MovementType` = 0,
    `curhealth` = 143620,
    `Comment` = 'GUID SAI'
WHERE `guid` = 68312 AND `id1` = 19005;

UPDATE `creature` SET `map` = 530,
    `zoneId` = 3483,
    `areaId` = 3804,
    `spawnMask` = 1,
    `phaseMask` = 4294967295,
    `position_x` = -84.32881,
    `position_y` = 1881.8777,
    `position_z` = 74.695015,
    `orientation` = 2.5140123,
    `spawntimesecs` = 10,
    `wander_distance` = 0,
    `MovementType` = 0,
    `curhealth` = 143620,
    `Comment` = 'GUID SAI'
WHERE `guid` = 68313 AND `id1` = 19005;

UPDATE `creature` SET `map` = 530,
    `zoneId` = 3483,
    `areaId` = 3804,
    `spawnMask` = 1,
    `phaseMask` = 4294967295,
    `position_x` = -419.23682,
    `position_y` = 1846.775,
    `position_z` = 81.09361,
    `orientation` = 1.7246842,
    `spawntimesecs` = 10,
    `wander_distance` = 0,
    `MovementType` = 0,
    `curhealth` = 143620,
    `Comment` = 'GUID SAI'
WHERE `guid` = 68314 AND `id1` = 19005;

DELETE FROM `waypoint_data` WHERE `id` IN (68311, 68312, 68313, 68314);
INSERT INTO `waypoint_data`
(`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(68311, 1, -302.05676, 1524.8987, 37.92391, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 2, -288.00, 1490.00, 54.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 3, -279.00, 1448.00, 45.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 4, -267.00, 1378.00, 39.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 5, -257.00, 1285.00, 39.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 6, -249.00, 1165.00, 48.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 7, -247.00, 1088.00, 54.00, NULL, 0, 0, 0, 0, 0, 100, 0),

(68312, 1, -146.42024, 1510.6957, 33.62471, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 2, -171.00, 1470.00, 39.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 3, -190.00, 1400.00, 35.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 4, -215.00, 1300.00, 36.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 5, -235.00, 1200.00, 44.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 6, -245.00, 1095.00, 54.00, NULL, 0, 0, 0, 0, 0, 100, 0),

(68313, 1, -84.32881, 1881.8777, 74.695015, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 2, -120.00, 1820.00, 78.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 3, -155.00, 1760.00, 68.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 4, -190.00, 1680.00, 58.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 5, -220.00, 1580.00, 48.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 6, -245.00, 1450.00, 40.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 7, -250.00, 1300.00, 39.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 8, -247.00, 1125.00, 52.00, NULL, 0, 0, 0, 0, 0, 100, 0),

(68314, 1, -419.23682, 1846.775, 81.09361, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 2, -390.00, 1785.00, 75.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 3, -350.00, 1700.00, 62.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 4, -315.00, 1600.00, 52.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 5, -285.00, 1500.00, 45.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 6, -260.00, 1350.00, 40.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 7, -250.00, 1185.00, 47.00, NULL, 0, 0, 0, 0, 0, 100, 0);
