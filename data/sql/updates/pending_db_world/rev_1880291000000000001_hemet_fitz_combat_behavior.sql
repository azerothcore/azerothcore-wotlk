-- Hemet Nesingwary (18180) and Shado 'Fitz' Farstrider (18200): combat behavior.
--
-- Hemet:
--   On AGGRO, sets run mode (id=12 chain), disables combat movement (id=21), and
--   runs to pos1 (-1456.9974, 6334.6616, 37.247917, id=26). On arrival at pos1,
--   fires Shoot via MOVEMENTINFORM (id=27) then moves to pos2
--   (-1434.5112, 6337.4365, 39.557323, id=23). Casts Shoot every 20 s in combat
--   (id=13). After the pre-hunt RP speech (id=11 -> id=24) he walks to an
--   observation point before combat starts (id=25). On KILL, re-engages the nearest
--   Talbuk Stag within 100 yd (id=19). RangeAttackTime=60000 prevents the NPC ranged
--   auto-attack from firing on top of the SmartAI Shoot timer.
--
-- Fitz:
--   Melee only (rifle sheathed per his emote). RangeAttackTime=999999 disables ranged
--   auto-attack. His combat-entry animation script (1820000) is preserved (id=0).
--   On KILL, re-engages the nearest Talbuk Stag within 100 yd (id=5). Scans OOC
--   every 3-5 s and attacks the nearest Talbuk Stag within 20 yd (id=6). In combat,
--   re-acquires the nearest Talbuk Stag every 2-4 s so he does not stand idle if his
--   current target is killed by Hemet before he can reach it (id=7).
--
-- Talbuk Stag (17130):
--   On AGGRO, switches target to the nearest Fitz (18200) within 100 yd so Fitz
--   enters combat (id=2).
--
-- NOTE: Harold Lane's closing line is triggered by Hemet's EVADE event via action
-- list 1818001 -- see rev_1880291000000000000 for that change.

-- ============================================================
-- creature_template: adjust ranged auto-attack timers
-- ============================================================
UPDATE `creature_template` SET `RangeAttackTime` = 60000  WHERE `entry` = 18180;
UPDATE `creature_template` SET `RangeAttackTime` = 999999 WHERE `entry` = 18200;

-- ============================================================
-- Hemet Nesingwary (18180): update pre-existing rows
-- ============================================================

-- id=11: after RP speech script fires, chain into walk-to-observation-spot (link 0 -> 24)
UPDATE `smart_scripts` SET `link` = 24
    WHERE `entryorguid` = 18180 AND `source_type` = 0 AND `id` = 11;

-- id=12: on AGGRO, become SET_RUN=1 and chain into AGGRO positioning (link -> 21)
UPDATE `smart_scripts` SET
    `link` = 21, `action_type` = 20, `action_param1` = 1, `action_param2` = 0,
    `target_type` = 1, `target_param1` = 0, `target_param2` = 0
    WHERE `entryorguid` = 18180 AND `source_type` = 0 AND `id` = 12;

-- ============================================================
-- Hemet Nesingwary (18180): new rows
-- ============================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18180 AND `source_type` = 0
    AND `id` IN (13, 19, 20, 21, 23, 24, 25, 26, 27);
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`,
     `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`,
     `comment`)
VALUES
-- id=13: in combat, cast Shoot every 20 s
(18180, 0, 13, 0,
 0, 0, 100, 0,
 20000, 20000, 20000, 20000, 0, 0,
 11, 32168, 64, 0, 0, 0, 0,
 2, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - In Combat - Cast Shoot'),
-- id=19: on kill, re-engage nearest remaining talbuk
(18180, 0, 19, 0,
 6, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 49, 0, 0, 0, 0, 0, 0,
 19, 17130, 100, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - On Kill - Attack Nearest Talbuk Stag'),
-- id=20: in combat, periodically re-acquire nearest talbuk as target
(18180, 0, 20, 0,
 0, 0, 100, 0,
 2000, 2000, 4000, 4000, 0, 0,
 49, 0, 0, 0, 0, 0, 0,
 19, 17130, 100, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - In Combat - Chase Nearest Talbuk Stag'),
-- id=21: AGGRO chain - disable combat movement, then link to move-to-pos1 (id=26)
(18180, 0, 21, 26,
 61, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 21, 0, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - Linked - Disable Combat Movement'),
-- id=23: MOVEMENTINFORM chain - after shooting at pos1, move to pos2
(18180, 0, 23, 0,
 61, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 69, 2, 0, 0, 0, 0, 0,
 8, 0, 0, 0, 0,
 -1440.0641, 6333.6704, 38.994766, 5.864311,
 'Hemet Nesingwary - Linked - Move To Shooting Position 2'),
-- id=24: RP walk chain - set walk mode before moving to observation spot
(18180, 0, 24, 25,
 61, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 20, 0, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - Linked - Set Walk'),
-- id=25: RP walk chain - move to pre-combat observation spot
(18180, 0, 25, 0,
 61, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 69, 0, 0, 0, 0, 0, 0,
 8, 0, 0, 0, 0,
 -1456.322, 6334.2466, 37.27738, 0.008995052,
 'Hemet Nesingwary - Linked - Move To RP Observation Spot'),
-- id=26: AGGRO chain - run to shooting position 1
(18180, 0, 26, 0,
 61, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 69, 1, 0, 0, 0, 0, 0,
 8, 0, 0, 0, 0,
 -1456.9974, 6334.6616, 37.247917, 6.0313787,
 'Hemet Nesingwary - Linked - Move To Shooting Position 1'),
-- id=27: on arriving at pos1 (MOVEMENTINFORM pointId=1), cast Shoot then chain to id=23
(18180, 0, 27, 23,
 34, 0, 100, 0,
 0, 1, 0, 0, 0, 0,
 11, 32168, 64, 0, 0, 0, 0,
 2, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - On Point 1 Reached - Cast Shoot');

-- ============================================================
-- Talbuk Stag (17130): on AGGRO switch target to nearest Fitz
-- ============================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` = 17130 AND `source_type` = 0 AND `id` = 2;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`,
     `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`,
     `comment`)
VALUES
(17130, 0, 2, 0,
 4, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 49, 0, 0, 0, 0, 0, 0,
 19, 18200, 100, 0, 0,
 0, 0, 0, 0,
 'Talbuk Stag - On Aggro - Attack Nearest Fitz');

-- ============================================================
-- Cleanup: remove unused action list rows
-- ============================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1713000 AND `source_type` = 9 AND `id` = 3;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1820001 AND `source_type` = 9;

-- ============================================================
-- Shado 'Fitz' Farstrider (18200): melee only, kill re-engage, OOC assist
-- ============================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18200 AND `source_type` = 0 AND `id` IN (0, 4, 5, 6, 7);
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`,
     `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`,
     `comment`)
VALUES
-- id=0: combat-entry animation (draw weapon) - same as original, re-inserted for idempotency
(18200, 0, 0, 0,
 38, 0, 100, 512,
 1, 3, 0, 0, 0, 0,
 80, 1820000, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Shado Fitz Farstrider - On Data 1-3 Set - Run Script'),
-- id=5: on kill, re-engage nearest remaining talbuk
(18200, 0, 5, 0,
 6, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 49, 0, 0, 0, 0, 0, 0,
 19, 17130, 100, 0, 0,
 0, 0, 0, 0,
 'Shado Fitz Farstrider - On Kill - Attack Nearest Talbuk Stag'),
-- id=6: OOC periodic scan, attack nearest talbuk within 20 yd
(18200, 0, 6, 0,
 1, 0, 100, 0,
 3000, 5000, 3000, 5000, 0, 0,
 49, 0, 0, 0, 0, 0, 0,
 19, 17130, 20, 0, 0,
 0, 0, 0, 0,
 'Shado Fitz Farstrider - OOC - Attack Nearest Talbuk Stag Within 20 yd'),
-- id=7: in combat, re-acquire nearest talbuk every 2-4 s (handles case where
-- current target is killed by Hemet before Fitz can finish it)
(18200, 0, 7, 0,
 0, 0, 100, 0,
 2000, 2000, 4000, 4000, 0, 0,
 49, 0, 0, 0, 0, 0, 0,
 19, 17130, 100, 0, 0,
 0, 0, 0, 0,
 'Shado Fitz Farstrider - In Combat - Chase Nearest Talbuk Stag');
