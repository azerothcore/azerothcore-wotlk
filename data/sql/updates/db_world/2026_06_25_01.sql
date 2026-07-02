-- Dark Portal battle demon wave and defender behavior fixes.
-- Consolidates final creature tuning, formation, waypoint, SmartAI, and condition updates.


-- -----------------------------------------------------------------------------
-- 1) Creature template final HP values
-- -----------------------------------------------------------------------------
UPDATE `creature_template`
SET `HealthModifier` = 12
WHERE `entry` = 18946; -- Infernal Siegebreaker

UPDATE `creature_template`
SET `DamageModifier` = CASE `entry`
    WHEN 18944 THEN 2.4 -- Fel Soldier
    WHEN 18946 THEN 6.7 -- Infernal Siegebreaker
    WHEN 19005 THEN 11  -- Wrath Master
END
WHERE `entry` IN (18944, 18946, 19005);

UPDATE `creature_template`
SET `HealthModifier` = 40
WHERE `entry` IN (18966, 18969); -- Justinius, Melgromm (2x over base 20)

-- The two mage entries carried UNIT_FLAG_DISABLE_MOVE (0x4) in their template
-- unit_flags, which rooted them in place: they teleported to the path start but
-- could not walk the escort path (stuck "on the portal"). Clear the flag so they
-- march with the rest of the battalion. Only these two entries had it set.
UPDATE `creature_template`
SET `unit_flags` = `unit_flags` & ~0x4
WHERE `entry` IN (18949, 18971); -- Stormwind Mage, Undercity Mage

-- Justinius had creature_template_addon.emote = 375 (a combat-ready/attack stance
-- emote state), which locked him into the melee attack animation even while idle.
-- Clear it to 0 (matching Melgromm) so he stands normally when not fighting.
UPDATE `creature_template_addon`
SET `emote` = 0
WHERE `entry` = 18966; -- Justinius the Harbinger

-- -----------------------------------------------------------------------------
-- 2) Infernal target marker placement + movement behavior
-- -----------------------------------------------------------------------------
UPDATE `creature`
SET `position_x` = -274.3799,
    `position_y` = 1174.073,
    `position_z` = 83.321175,
    `orientation` = 3.1407077
WHERE `guid` = 74081;

UPDATE `creature`
SET `position_x` = -216.51663,
    `position_y` = 1173.5674,
    `position_z` = 83.321175,
    `orientation` = 4.703648
WHERE `guid` = 74082;

INSERT INTO `creature_template_movement`
(`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`)
VALUES
(21075, 2, 0, 1, 1, 0, 0, NULL)
ON DUPLICATE KEY UPDATE
    `Ground` = VALUES(`Ground`),
    `Swim` = VALUES(`Swim`),
    `Flight` = VALUES(`Flight`),
    `Rooted` = VALUES(`Rooted`),
    `Chase` = VALUES(`Chase`),
    `Random` = VALUES(`Random`),
    `InteractionPauseTimer` = VALUES(`InteractionPauseTimer`);

-- -----------------------------------------------------------------------------
-- 3) Army assist + retarget behavior (final values)
-- -----------------------------------------------------------------------------
UPDATE `smart_scripts`
SET `action_param1` = 90
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18950)
  AND `id` = 7
  AND `action_type` = 39;

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18949, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `id` = 44;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18949, 0, 44, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Mage - On Aggro - Call For Help'),
(18965, 0, 44, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Archer - On Aggro - Call For Help'),
(18966, 0, 44, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Justinius the Harbinger - On Aggro - Call For Help'),
(18969, 0, 44, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Melgromm Highmountain - On Aggro - Call For Help'),
(18970, 0, 44, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkspear Axe Thrower - On Aggro - Call For Help'),
(18971, 0, 44, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Mage - On Aggro - Call For Help'),
(18972, 0, 44, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Shaman - On Aggro - Call For Help'),
(18986, 0, 44, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Paladin - On Aggro - Call For Help');

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `id` = 45;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18948, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Soldier - On Kill - Attack Closest Enemy'),
(18949, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Mage - On Kill - Attack Closest Enemy'),
(18950, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Kill - Attack Closest Enemy'),
(18965, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Archer - On Kill - Attack Closest Enemy'),
(18966, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Justinius the Harbinger - On Kill - Attack Closest Enemy'),
(18969, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Melgromm Highmountain - On Kill - Attack Closest Enemy'),
(18970, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Darkspear Axe Thrower - On Kill - Attack Closest Enemy'),
(18971, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Undercity Mage - On Kill - Attack Closest Enemy'),
(18972, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Shaman - On Kill - Attack Closest Enemy'),
(18986, 0, 45, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 60, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Paladin - On Kill - Attack Closest Enemy');

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `id` = 70;

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `id` = 71;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18948,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Stormwind Soldier - IC pulse - Retarget closest enemy'),
(18949,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Stormwind Mage - IC pulse - Retarget closest enemy'),
(18950,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Orgrimmar Grunt - IC pulse - Retarget closest enemy'),
(18965,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Darnassian Archer - IC pulse - Retarget closest enemy'),
(18966,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Justinius - IC pulse - Retarget closest enemy'),
(18969,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Melgromm - IC pulse - Retarget closest enemy'),
(18970,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Darkspear Axe Thrower - IC pulse - Retarget closest enemy'),
(18971,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Undercity Mage - IC pulse - Retarget closest enemy'),
(18972,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Orgrimmar Shaman - IC pulse - Retarget closest enemy'),
(18986,0,71,0,0,0,100,0,1000,1500,2500,3500,0,0,49,0,0,0,0,0,0,25,55,0,0,0,0,0,0,0,'Ironforge Paladin - IC pulse - Retarget closest enemy');

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` = 18969
  AND `id` = 73;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18969,0,73,0,0,0,100,0,6000,10000,22000,30000,0,0,11,33570,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - In Combat - Cast Strength of the Storm Totem');

-- Keep assist behavior enabled so the army responds together when one unit is attacked.
UPDATE `smart_scripts`
SET `event_chance` = 100
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18950)
  AND `id` = 7
  AND `action_type` = 39;

UPDATE `smart_scripts`
SET `event_chance` = 100
WHERE `source_type` = 0
  AND `entryorguid` IN (18949, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `id` = 44
  AND `action_type` = 39;

-- Creature respawn behavior: passive respawn state with state flip at waypoint 11.
-- Only apply to melee units and archers; casters keep default behavior.

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `id` = 90;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18948,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Respawn - Return to Spawn Point'),
(18949,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Respawn - Return to Spawn Point'),
(18950,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Respawn - Return to Spawn Point'),
(18965,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Respawn - Return to Spawn Point'),
(18966,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Respawn - Return to Spawn Point'),
(18969,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - On Respawn - Return to Spawn Point'),
(18970,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Respawn - Return to Spawn Point'),
(18971,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Respawn - Return to Spawn Point'),
(18972,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Respawn - Return to Spawn Point'),
(18986,0,90,0,11,0,100,512,0,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Respawn - Return to Spawn Point');

-- Darnassian Archer: use bow at range; melee auto-attacks handle close targets.
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` = 18965
  AND `id` = 10;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18965,0,10,0,9,0,100,0,0,0,2000,3000,5,30,11,15620,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Darnassian Archer - Within 5-30 Range - Cast Shoot');


-- Respawn behavior (final state)

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `event_type` = 6
  AND `action_type` = 41;

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `id` IN (47, 48, 72);


-- Demon wave control
UPDATE `smart_scripts`
SET `action_param1` = 1
WHERE `source_type` = 0
  AND `entryorguid` = 18944
  AND `id` = 13
  AND `action_type` = 101;

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (-68311, -68312, -68313, -68314)
  AND `id` = 20;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-68311, 0, 20, 0, 40, 0, 100, 0, 33, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrath Master (68311) - On final WP - Set Home Position Here'),
(-68312, 0, 20, 0, 40, 0, 100, 0, 33, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrath Master (68312) - On final WP - Set Home Position Here'),
(-68313, 0, 20, 0, 40, 0, 100, 0, 59, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrath Master (68313) - On final WP - Set Home Position Here'),
(-68314, 0, 20, 0, 40, 0, 100, 0, 52, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrath Master (68314) - On final WP - Set Home Position Here');

-- -----------------------------------------------------------------------------
-- Remove the redundant/buggy Infernal Relay demon-summon (relay -68744 ids 0-4,
-- 44, 45). Each permanent Wrath Master (68311-68314) already summons its own four
-- Fel Soldiers AND issues SET_DATA so they follow it, then marches via waypoints
-- (see timed action lists 1900500-1900503 below). The relay duplicated that with a
-- SECOND Wrath Master (entry 19005, which has NO entry-level AI -> stood motionless)
-- plus four un-commanded Fel Soldiers at the SAME coordinates, and it fired the
-- summon on BOTH Just Created (id 44) and Respawn (id 45) -- both of which run at
-- server start -- so multiple waves stacked on the staging point and never moved.
-- Delete the whole relay summon; only the working Wrath-Master-driven waves remain.
-- -----------------------------------------------------------------------------
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` = -68744
  AND `id` IN (0, 1, 2, 3, 4, 44, 45);

UPDATE `smart_scripts`
SET `event_type` = 59,
    `event_param1` = 1,
    `event_param2` = 0,
    `event_param3` = 0,
    `event_param4` = 0,
    `event_param5` = 0,
    `event_param6` = 0
WHERE `source_type` = 0
  AND `entryorguid` IN (-68311, -68312, -68313, -68314)
  AND `id` = 4
  AND `action_type` = 80;

UPDATE `smart_scripts`
SET `action_param2` = 5000,
    `action_param3` = 5000
WHERE `source_type` = 0
  AND `entryorguid` IN (-68311, -68312, -68313, -68314)
  AND `id` = 3
  AND `action_type` = 67;

UPDATE `smart_scripts`
SET `action_param1` = 10000
WHERE `source_type` = 0
  AND `entryorguid` IN (-68311, -68312, -68313, -68314)
  AND `id` = 7
  AND `action_type` = 41;

-- id=4 was converted to a standalone Timed Event handler (event_type 59) above, so
-- id=3 must no longer link to it (a link target must be event_type 61). The timed
-- event created by id=3 now drives id=4/id=5; clear the dangling link.
UPDATE `smart_scripts`
SET `link` = 0
WHERE `source_type` = 0
  AND `entryorguid` IN (-68311, -68312, -68313, -68314)
  AND `id` = 3
  AND `action_type` = 67
  AND `link` = 4;

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (-68744, -68745)
  AND `id` BETWEEN 46 AND 60;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
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
(-68745,0,46,47,63,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18948,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Stormwind Soldier'),
(-68745,0,47,48,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18949,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Stormwind Mage'),
(-68745,0,48,49,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18950,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Orgrimmar Grunt'),
(-68745,0,49,50,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18965,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Darnassian Archer'),
(-68745,0,50,51,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18966,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Justinius'),
(-68745,0,51,52,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18969,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Melgromm'),
(-68745,0,52,53,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18970,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Darkspear Axe Thrower'),
(-68745,0,53,54,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18971,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Undercity Mage'),
(-68745,0,54,55,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18972,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Orgrimmar Shaman'),
(-68745,0,55,0,61,0,100,0,0,0,0,0,0,0,70,1,0,0,0,0,0,9,18986,0,220,2,0,0,0,0,'Infernal Relay B - Startup - Respawn dead Ironforge Paladin');

UPDATE `smart_scripts`
SET `event_param3` = 50000,
    `event_param4` = 50000
WHERE `source_type` = 0
  AND `entryorguid` = 18945
  AND `id` IN (12, 13, 14)
  AND `event_type` = 1;

-- Explicitly remove the temporary commander priority override.
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18966, 18969)
  AND `id` = 46
  AND `action_type` = 49
  AND `target_type` = 19
  AND `target_param1` = 19005;


-- =============================================================================
-- Per-role waypoints: all NPCs march the high terrace to the commander plateau
-- (point 11, behind Justinius/Melgromm) and salute there. The path ENDS at the
-- plateau so the base script chain (reach point 11 -> emote -> set home to spawn
-- -> evade) sends each unit back to its OWN spawn marker via pathfinding (down
-- the stairs). This spreads them across the markers instead of stacking on one.
-- =============================================================================

DELETE FROM `waypoints`
WHERE `entry` IN (920001,920002,920003,920004,920005,920011,920012,920013,920014,920015);

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

-- Redirect Start WP for the 6 entries that already have id=12 in base.
UPDATE `smart_scripts` SET `action_param2`=920001
WHERE `source_type`=0 AND `entryorguid`=18948 AND `id`=12 AND `action_type`=53;

UPDATE `smart_scripts` SET `action_param2`=920002
WHERE `source_type`=0 AND `entryorguid`=18986 AND `id`=12 AND `action_type`=53;

UPDATE `smart_scripts` SET `action_param2`=920003
WHERE `source_type`=0 AND `entryorguid`=18965 AND `id`=12 AND `action_type`=53;

UPDATE `smart_scripts` SET `action_param2`=920011
WHERE `source_type`=0 AND `entryorguid`=18950 AND `id`=12 AND `action_type`=53;

UPDATE `smart_scripts` SET `action_param2`=920012
WHERE `source_type`=0 AND `entryorguid`=18972 AND `id`=12 AND `action_type`=53;

UPDATE `smart_scripts` SET `action_param2`=920013
WHERE `source_type`=0 AND `entryorguid`=18970 AND `id`=12 AND `action_type`=53;

-- Fix the two mage entries.
-- Root bug: snapshot replaced id=12 with a Linked Start WP, but id=2 (Evade) has link=0
-- so the chain never reaches id=12. Fix: set link=12 on id=2, update id=12 path.
UPDATE `smart_scripts`
SET `link` = 12
WHERE `source_type`=0
  AND `entryorguid` IN (18949, 18971)
  AND `id` = 2
  AND `event_type` = 59;

DELETE FROM `smart_scripts`
WHERE `source_type`=0
  AND `entryorguid` IN (18949, 18971)
  AND `id` = 12;

INSERT INTO `smart_scripts`
(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
 `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,
 `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
 `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,
 `target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(18949,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920004,0,0,0,2,1,0,0,0,0,0,0,0,0,'Stormwind Mage - Linked - Start WP (upper plateau)'),
(18971,0,12,0,61,0,100,512,0,0,0,0,0,0,53,2,920014,0,0,0,2,1,0,0,0,0,0,0,0,0,'Undercity Mage - Linked - Start WP (upper plateau)');


-- Plateau salute + return-to-spawn (spread).
-- The base script chain already does: reach point 11 -> emote (id3) -> 2s timer
-- (id4) -> SET_HOME_POS (id5) -> EVADE (id6). We only need to (a) make the emote
-- a military salute (66), and (b) make SET_HOME_POS use the unit's SPAWN position
-- (spawnPos=1) instead of the current plateau spot, so the evade walks each unit
-- back to its OWN spawn marker (pathfinding down the stairs) rather than stacking.
UPDATE `smart_scripts`
SET `action_param1` = 66
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18970, 18971, 18972, 18986)
  AND `id` = 3
  AND `action_type` = 5;

UPDATE `smart_scripts`
SET `action_param1` = 1
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18970, 18971, 18972, 18986)
  AND `id` = 5
  AND `action_type` = 101;

-- Remove the earlier duplicate salute (ids 96/97); the base id3 chain handles it.
DELETE FROM `smart_scripts`
WHERE `source_type`=0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18970, 18971, 18972, 18986)
  AND `id` IN (96, 97);

-- The two mage entries (18949, 18971) lack the ground units' base id3..id6
-- salute/return chain, so add it explicitly: on reaching plateau WP 11 -> salute
-- (emote 66) -> 2s timer -> SET_HOME_POS to spawn (spawnPos=1) -> EVADE, which
-- walks each mage back to its own spawn marker (spreads them, no stacking).
DELETE FROM `smart_scripts`
WHERE `source_type`=0 AND `entryorguid` IN (18949, 18971) AND `id` IN (3, 4, 5, 6);
INSERT INTO `smart_scripts`
(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
 `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,
 `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
 `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,
 `target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(18949,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On plateau WP 11 - Salute commanders'),
(18949,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Stormwind Mage - Linked - Create timed event 2'),
(18949,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - Timed event 2 - Set home to spawn'),
(18949,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - Linked - Evade to spawn marker'),
(18971,0,3,4,40,0,100,0,11,0,0,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On plateau WP 11 - Salute commanders'),
(18971,0,4,0,61,0,100,512,0,0,0,0,0,0,67,2,2000,2000,0,0,100,1,0,0,0,0,0,0,0,0,'Undercity Mage - Linked - Create timed event 2'),
(18971,0,5,6,59,0,100,512,2,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - Timed event 2 - Set home to spawn'),
(18971,0,6,0,61,0,100,512,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - Linked - Evade to spawn marker');

-- Route fix: the mages' base id2 ran EVADE (24) on respawn instead of STOP_COMBAT
-- (27) like the ground units. After the teleport to the path start, that EVADE
-- pulled them back toward their plateau spawn while the escort was starting, so
-- they wandered off-route (climbing terrain) and the salute/evade-home chain never
-- completed -> REACHED_HOME never fired -> they stayed passive and never fought.
-- Align them with the ground units so they march cleanly and activate on arrival.
UPDATE `smart_scripts`
SET `action_type` = 27, `action_param1` = 0
WHERE `source_type` = 0
  AND `entryorguid` IN (18949, 18971)
  AND `id` = 2
  AND `action_type` = 24;


-- Rebuild formations by ROLE/ROW: each unit type occupies the marker row matching
-- its terrain tier (plateau mages/commanders, ramp archers, mid casters, front melee),
-- pairing 1 unit -> 1 distinct marker so no two units stack on the same marker.
SET @FORMATION_FLAGS := 515; -- FOLLOW_LEADER + mutual assist

DROP TEMPORARY TABLE IF EXISTS `tmp_dp_assign`;
DROP TEMPORARY TABLE IF EXISTS `tmp_dp_used`;

CREATE TEMPORARY TABLE `tmp_dp_assign` AS
WITH `mk` AS (
    SELECT `guid`, `position_x` AS x, `position_y` AS y, `position_z` AS z,
           CASE WHEN `position_x` <= -250 THEN 'A' ELSE 'H' END AS side,
           CASE WHEN `position_z` >= 52 THEN 'plat'
                WHEN `position_z` >= 44 THEN 'ramp'
                WHEN `position_y` >= 1096 THEN 'front'
                ELSE 'mid' END AS band
    FROM `creature`
    WHERE `map` = 530 AND `id` = 19179
      AND `position_x` BETWEEN -280 AND -220 AND `position_y` BETWEEN 1065 AND 1100
), `platrk` AS (
    SELECT `guid`, x, side,
           ROW_NUMBER() OVER (PARTITION BY side ORDER BY y) AS prn
    FROM `mk` WHERE band = 'plat'
), `mkrole` AS (
    SELECT `guid`, x, side, CASE WHEN prn = 1 THEN 'cmd' ELSE 'mage' END AS role FROM `platrk`
    UNION ALL
    SELECT `guid`, x, side, band FROM `mk` WHERE band IN ('ramp','front','mid')
), `mkn` AS (
    SELECT `guid`, side, role, ROW_NUMBER() OVER (PARTITION BY side, role ORDER BY x) AS rn FROM `mkrole`
), `un` AS (
    SELECT `guid`, `id`, `position_x` AS x,
           CASE WHEN `position_x` <= -250 THEN 'A' ELSE 'H' END AS side,
           CASE `id`
                WHEN 18948 THEN 'front' WHEN 18986 THEN 'mid' WHEN 18965 THEN 'ramp'
                WHEN 18949 THEN 'mage'  WHEN 18966 THEN 'cmd'
                WHEN 18950 THEN 'front' WHEN 18972 THEN 'mid' WHEN 18970 THEN 'ramp'
                WHEN 18971 THEN 'mage'  WHEN 18969 THEN 'cmd' END AS role
    FROM `creature`
    WHERE `map` = 530
      AND `id` IN (18948,18986,18965,18949,18966,18950,18972,18970,18971,18969)
      AND `position_x` BETWEEN -290 AND -210 AND `position_y` BETWEEN 1065 AND 1105
), `unflt` AS (
    -- drop the lone boundary grunt on the Alliance side (no Horde-melee marker there)
    SELECT * FROM `un` WHERE NOT (`id` = 18950 AND side = 'A')
), `unn` AS (
    SELECT `guid`, side, role, ROW_NUMBER() OVER (PARTITION BY side, role ORDER BY x) AS rn FROM `unflt`
)
SELECT u.`guid` AS `member_guid`, m.`guid` AS `marker_guid`
FROM `unn` u
JOIN `mkn` m ON u.side = m.side AND u.role = m.role AND u.rn = m.rn;

-- Markers that actually receive a unit (used as formation leaders).
CREATE TEMPORARY TABLE `tmp_dp_used` AS
SELECT DISTINCT `marker_guid` FROM `tmp_dp_assign`;

-- Clear any existing formation rows for these army units and markers.
DELETE FROM `creature_formations`
WHERE `memberGUID` IN (
    SELECT `guid` FROM `creature`
    WHERE `map` = 530
      AND `id` IN (18948,18949,18950,18965,18966,18969,18970,18971,18972,18986)
      AND `position_x` BETWEEN -290 AND -210 AND `position_y` BETWEEN 1065 AND 1105
);

DELETE FROM `creature_formations`
WHERE `leaderGUID` IN (
    SELECT `guid` FROM `creature`
    WHERE `map` = 530 AND `id` = 19179
      AND `position_x` BETWEEN -280 AND -220 AND `position_y` BETWEEN 1065 AND 1100
);

-- Leader self-rows (a formation only activates when its leader is present as a member).
INSERT INTO `creature_formations`
(`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`)
SELECT `marker_guid`, `marker_guid`, 0, 0, @FORMATION_FLAGS, 0, 0 FROM `tmp_dp_used`;

-- Member rows: each unit pinned (dist 0) onto its own role-matched marker.
INSERT INTO `creature_formations`
(`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`)
SELECT `marker_guid`, `member_guid`, 0, 0, @FORMATION_FLAGS, 0, 0 FROM `tmp_dp_assign`;

DROP TEMPORARY TABLE IF EXISTS `tmp_dp_assign`;
DROP TEMPORARY TABLE IF EXISTS `tmp_dp_used`;

-- March passive; activate on final battalion marker.
-- Marchers (ground + mages) activate on REACHED_HOME after they evade-walk to
-- their own marker. The two commanders do NOT march (their WP is a single point
-- at their own spawn, so ESCORT_REACHED never fired and they stayed passive);
-- instead arm a timed event on respawn that flips them aggressive ~15s in, in
-- step with the demon wave engagement.
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `id` IN (98, 99, 100, 101, 102);

-- Drop the commanders' pointless 1-point WP start and clear any prior id=100.
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18966, 18969)
  AND `id` IN (12, 100);

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18948,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Respawn - Set Passive while marching'),
(18949,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Respawn - Set Passive while marching'),
(18950,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Respawn - Set Passive while marching'),
(18965,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Respawn - Set Passive while marching'),
(18966,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius - On Respawn - Set Passive while marching'),
(18969,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm - On Respawn - Set Passive while marching'),
(18970,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Respawn - Set Passive while marching'),
(18971,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Respawn - Set Passive while marching'),
(18972,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Respawn - Set Passive while marching'),
(18986,0,98,0,11,0,100,512,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Respawn - Set Passive while marching'),

(18948,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On reached home marker - Activate combat'),
(18986,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On reached home marker - Activate combat'),
(18965,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On reached home marker - Activate combat'),
(18949,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On reached home marker - Activate combat'),
(18966,0,99,0,11,0,100,512,0,0,0,0,0,0,67,9,15000,15000,0,0,100,1,0,0,0,0,0,0,0,0,'Justinius - On Respawn - Arm activation timer (no march)'),
(18950,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On reached home marker - Activate combat'),
(18972,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On reached home marker - Activate combat'),
(18970,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On reached home marker - Activate combat'),
(18971,0,99,0,21,0,100,0,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On reached home marker - Activate combat'),
(18969,0,99,0,11,0,100,512,0,0,0,0,0,0,67,9,15000,15000,0,0,100,1,0,0,0,0,0,0,0,0,'Melgromm - On Respawn - Arm activation timer (no march)'),
(18966,0,100,0,59,0,100,512,9,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius - Activation timer 9 - Set aggressive'),
(18969,0,100,0,59,0,100,512,9,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm - Activation timer 9 - Set aggressive'),

-- Enter a "combat-ready" event phase (1) at the moment each unit activates, so the
-- out-of-combat engage pulse below only runs after arrival (never during the march).
(18948,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On reached home - Enter combat-ready phase'),
(18986,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On reached home - Enter combat-ready phase'),
(18965,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On reached home - Enter combat-ready phase'),
(18949,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On reached home - Enter combat-ready phase'),
(18950,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On reached home - Enter combat-ready phase'),
(18972,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On reached home - Enter combat-ready phase'),
(18970,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On reached home - Enter combat-ready phase'),
(18971,0,100,0,21,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On reached home - Enter combat-ready phase'),
(18966,0,101,0,59,0,100,512,9,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius - Activation timer 9 - Enter combat-ready phase'),
(18969,0,101,0,59,0,100,512,9,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm - Activation timer 9 - Enter combat-ready phase'),

-- Out-of-combat engage pulse (phase 1 only): once activated, acquire the nearest
-- hostile within a SHORT radius and charge it. Kept short so the army holds the
-- line near the stairs and lets the demons close the distance, instead of running
-- forward to pull far demons (and the Pit Lord). Melee/casters scan 15y, mages 22y.
(18948,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Stormwind Soldier - Combat-ready - Engage nearest enemy (hold line)'),
(18986,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Ironforge Paladin - Combat-ready - Engage nearest enemy (hold line)'),
(18965,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Darnassian Archer - Combat-ready - Engage nearest enemy (hold line)'),
(18949,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,22,0,0,0,0,0,0,0,'Stormwind Mage - Combat-ready - Engage nearest enemy (hold line)'),
(18950,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Orgrimmar Grunt - Combat-ready - Engage nearest enemy (hold line)'),
(18972,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Orgrimmar Shaman - Combat-ready - Engage nearest enemy (hold line)'),
(18970,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Darkspear Axe Thrower - Combat-ready - Engage nearest enemy (hold line)'),
(18971,0,101,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,22,0,0,0,0,0,0,0,'Undercity Mage - Combat-ready - Engage nearest enemy (hold line)'),
(18966,0,102,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Justinius - Combat-ready - Engage nearest enemy (hold line)'),
(18969,0,102,0,1,1,100,0,1000,1500,1200,1800,0,0,49,0,0,0,0,0,0,25,15,0,0,0,0,0,0,0,'Melgromm - Combat-ready - Engage nearest enemy (hold line)');

-- Mages: keep ally-support radius and retarget scan modest so they do not chase
-- distant demons forward.
UPDATE `smart_scripts`
SET `action_param1` = 90
WHERE `source_type` = 0
  AND `entryorguid` IN (18949, 18971)
  AND `id` = 44
  AND `action_type` = 39;

UPDATE `smart_scripts`
SET `target_param1` = 25
WHERE `source_type` = 0
  AND `entryorguid` IN (18949, 18971)
  AND `id` = 71
  AND `action_type` = 49
  AND `target_type` = 25;

-- In-combat retarget pulse: keep the closest-enemy scan local (25y) for the whole
-- army so units stay on the demons reaching the stairs instead of running out to
-- the farthest target and dragging the line into the Pit Lord.
UPDATE `smart_scripts`
SET `target_param1` = 25
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18950, 18965, 18966, 18969, 18970, 18972, 18986)
  AND `id` = 71
  AND `action_type` = 49
  AND `target_type` = 25;

-- Keep the mages at range: they were running into melee between casts. Their cast
-- rows had castFlags=0, so the AI used the default (melee) chase distance and the
-- retarget pulse (ATTACK_START) chased each new target to melee. Flag the primary
-- spell (Fireball 33417) as SMARTCAST_MAIN_SPELL (0x400) so the creature's chase
-- distance is set to that spell's max range on spawn, and add SMARTCAST_COMBAT_MOVE
-- (0x40) to both combat spells so a successful cast holds position (only moving on
-- out-of-range / OOM / LOS). AttackStart() then chases only to _attackDistance
-- (spell range), not melee.
UPDATE `smart_scripts`
SET `action_param2` = 1088 -- SMARTCAST_COMBAT_MOVE | SMARTCAST_MAIN_SPELL
WHERE `source_type` = 0
  AND `entryorguid` IN (18949, 18971)
  AND `id` = 10
  AND `action_type` = 11
  AND `action_param1` = 33417;

UPDATE `smart_scripts`
SET `action_param2` = 64 -- SMARTCAST_COMBAT_MOVE
WHERE `source_type` = 0
  AND `entryorguid` IN (18949, 18971)
  AND `id` = 11
  AND `action_type` = 11
  AND `action_param1` = 33419;

-- Full ability sets for the two commanders (Justinius the Harbinger / Melgromm Highmountain).
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18966, 18969)
  AND `id` IN (74, 75, 76, 77, 78);

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
-- Justinius the Harbinger (Paladin): Consecration, Flash of Light, Greater Blessing of Might, Divine Shield.
(18966,0,74,0,0,0,100,0,7000,11000,12000,18000,0,0,11,20922,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Justinius the Harbinger - In Combat - Cast Consecration (Rank 3)'),
(18966,0,75,0,2,0,100,0,1,45,8000,14000,0,0,11,37254,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - At 45% HP - Cast Flash of Light'),
(18966,0,76,0,4,0,100,1,0,0,0,0,0,0,11,29381,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Aggro - Cast Greater Blessing of Might'),
(18966,0,77,0,2,0,100,0,1,15,60000,60000,0,0,11,13874,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - At 15% HP - Cast Divine Shield'),
-- Keep allies buffed even while idle/out of combat: re-cast Greater Blessing of
-- Might every 30s. 29381 uses TARGET_UNIT_CASTER_AREA_PARTY, so casting on self
-- radiates the buff to nearby same-faction allies. event_type 1 = UPDATE_OOC.
(18966,0,78,0,1,0,100,0,2000,2000,30000,30000,0,0,11,29381,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - Out of Combat - Buff allies (Greater Blessing of Might)'),
-- Melgromm Highmountain (Shaman): Chain Heal, Magma Flow Totem.
(18969,0,74,0,2,0,100,0,1,50,7000,12000,0,0,11,33642,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - At 50% HP - Cast Chain Heal'),
(18969,0,75,0,0,0,100,0,9000,14000,25000,31000,0,0,11,33560,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - In Combat - Cast Magma Flow Totem');

-- Totem passive spells. The summon spells (33560/33570) only create the totem
-- creature; the buff/effect comes from the totem auto-casting its own passive on
-- summon (Totem::InitSummon casts creature_template_spell index 0). These two
-- totems had NO creature_template_spell row, so they spawned inert and did nothing
-- ("the totem not buffing nearby allies"). Give them their authentic passive:
--   19225 Strength of the Storm Totem -> 33571 (party % stat buff, radiates to
--          nearby allies that share the totem's faction; the totem inherits its
--          summoner Melgromm's faction via Minion::InitStats).
--   19222 Magma Flow Totem            -> 33561 (periodic fire damage to enemies).
DELETE FROM `creature_template_spell`
WHERE `CreatureID` IN (19222, 19225) AND `Index` = 0;

INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(19225, 0, 33571, NULL),
(19222, 0, 33561, NULL);

DELETE FROM `conditions`
WHERE (`SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 18966 AND `SourceGroup` = 75)
   OR (`SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 33559 AND `SourceGroup` IN (1, 2, 3));

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


UPDATE `creature`
SET `map` = 530,
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
WHERE `guid` = 68311 AND `id` = 19005;

UPDATE `creature`
SET `map` = 530,
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
WHERE `guid` = 68312 AND `id` = 19005;

UPDATE `creature`
SET `map` = 530,
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
WHERE `guid` = 68313 AND `id` = 19005;

UPDATE `creature`
SET `map` = 530,
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
WHERE `guid` = 68314 AND `id` = 19005;

-- Keep the four existing GUID SAI packages wired to the right timed scripts.
UPDATE `smart_scripts` SET `action_param2` = 68311
WHERE `entryorguid` = -68311 AND `source_type` = 0 AND `id` = 5 AND `action_type` = 53;
UPDATE `smart_scripts` SET `action_param1` = 1900500
WHERE `entryorguid` = -68311 AND `source_type` = 0 AND `id` = 4 AND `action_type` = 80;

UPDATE `smart_scripts` SET `action_param2` = 68312
WHERE `entryorguid` = -68312 AND `source_type` = 0 AND `id` = 5 AND `action_type` = 53;
UPDATE `smart_scripts` SET `action_param1` = 1900501
WHERE `entryorguid` = -68312 AND `source_type` = 0 AND `id` = 4 AND `action_type` = 80;

UPDATE `smart_scripts` SET `action_param2` = 68313
WHERE `entryorguid` = -68313 AND `source_type` = 0 AND `id` = 5 AND `action_type` = 53;
UPDATE `smart_scripts` SET `action_param1` = 1900502
WHERE `entryorguid` = -68313 AND `source_type` = 0 AND `id` = 4 AND `action_type` = 80;

UPDATE `smart_scripts` SET `action_param2` = 68314
WHERE `entryorguid` = -68314 AND `source_type` = 0 AND `id` = 5 AND `action_type` = 53;
UPDATE `smart_scripts` SET `action_param1` = 1900503
WHERE `entryorguid` = -68314 AND `source_type` = 0 AND `id` = 4 AND `action_type` = 80;

-- Non-overlapping Fel Soldier summon points around each restored gate.
UPDATE `smart_scripts`
SET `target_x` = -298.00, `target_y` = 1529.00, `target_z` = 37.92391, `target_o` = 0.18216586
WHERE `entryorguid` = 1900500 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -307.00, `target_y` = 1530.00, `target_z` = 37.92391, `target_o` = 0.18216586
WHERE `entryorguid` = 1900500 AND `source_type` = 9 AND `id` = 2 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -297.80, `target_y` = 1520.70, `target_z` = 37.92391, `target_o` = 0.18216586
WHERE `entryorguid` = 1900500 AND `source_type` = 9 AND `id` = 4 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -307.40, `target_y` = 1519.90, `target_z` = 37.92391, `target_o` = 0.18216586
WHERE `entryorguid` = 1900500 AND `source_type` = 9 AND `id` = 6 AND `action_type` = 12;

UPDATE `smart_scripts`
SET `target_x` = -142.00, `target_y` = 1514.90, `target_z` = 33.62471, `target_o` = 3.0842154
WHERE `entryorguid` = 1900501 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -151.10, `target_y` = 1515.40, `target_z` = 33.62471, `target_o` = 3.0842154
WHERE `entryorguid` = 1900501 AND `source_type` = 9 AND `id` = 2 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -141.80, `target_y` = 1506.00, `target_z` = 33.62471, `target_o` = 3.0842154
WHERE `entryorguid` = 1900501 AND `source_type` = 9 AND `id` = 4 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -151.40, `target_y` = 1505.20, `target_z` = 33.62471, `target_o` = 3.0842154
WHERE `entryorguid` = 1900501 AND `source_type` = 9 AND `id` = 6 AND `action_type` = 12;

UPDATE `smart_scripts`
SET `target_x` = -80.00, `target_y` = 1886.00, `target_z` = 74.695015, `target_o` = 2.5140123
WHERE `entryorguid` = 1900502 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -89.20, `target_y` = 1886.50, `target_z` = 74.695015, `target_o` = 2.5140123
WHERE `entryorguid` = 1900502 AND `source_type` = 9 AND `id` = 2 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -79.80, `target_y` = 1877.70, `target_z` = 74.695015, `target_o` = 2.5140123
WHERE `entryorguid` = 1900502 AND `source_type` = 9 AND `id` = 4 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -89.60, `target_y` = 1876.90, `target_z` = 74.695015, `target_o` = 2.5140123
WHERE `entryorguid` = 1900502 AND `source_type` = 9 AND `id` = 6 AND `action_type` = 12;

UPDATE `smart_scripts`
SET `target_x` = -414.70, `target_y` = 1851.20, `target_z` = 81.09361, `target_o` = 1.7246842
WHERE `entryorguid` = 1900503 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -424.30, `target_y` = 1851.80, `target_z` = 81.09361, `target_o` = 1.7246842
WHERE `entryorguid` = 1900503 AND `source_type` = 9 AND `id` = 2 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -414.40, `target_y` = 1842.50, `target_z` = 81.09361, `target_o` = 1.7246842
WHERE `entryorguid` = 1900503 AND `source_type` = 9 AND `id` = 4 AND `action_type` = 12;
UPDATE `smart_scripts`
SET `target_x` = -425.00, `target_y` = 1841.70, `target_z` = 81.09361, `target_o` = 1.7246842
WHERE `entryorguid` = 1900503 AND `source_type` = 9 AND `id` = 6 AND `action_type` = 12;

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


-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- Let Dark Portal army NPCs play their normal death/corpse flow.
-- The previous On Death -> Respawn Self SmartAI action made them vanish instantly.
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `event_type` = 6
  AND `action_type` = 70;

UPDATE `creature`
SET `spawntimesecs` = 0
WHERE `map` = 530
  AND `id` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986);

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND `id` = 103;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18948,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Respawn - Set corpse delay to 10s'),
(18949,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Respawn - Set corpse delay to 10s'),
(18950,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Respawn - Set corpse delay to 10s'),
(18965,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Respawn - Set corpse delay to 10s'),
(18966,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Respawn - Set corpse delay to 10s'),
(18969,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - On Respawn - Set corpse delay to 10s'),
(18970,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Respawn - Set corpse delay to 10s'),
(18971,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Respawn - Set corpse delay to 10s'),
(18972,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Respawn - Set corpse delay to 10s'),
(18986,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Respawn - Set corpse delay to 10s');


