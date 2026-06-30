-- DB update 2026_05_31_01 by GuillermoVT
-- Fix: Hemet Nesingwary (NPC 18180) incorrectly aggros Talbuk Stag and gets stuck
-- Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/26019
--
-- Root cause: The ESCORT_START action (type 53, event id=1) sets Hemet's react state
-- to AGGRESSIVE (action_param6 = 2) for the entire escort path. Combined with his
-- faction 495 (a hunting faction with hostile flags) applied at WP2, this causes him
-- to auto-aggro any wild Talbuk Stag that wanders into range. When combat starts
-- with a wild Talbuk (not the scripted one summoned at WP3), the Shoot spell fails
-- at melee range, leaving Hemet stuck in combat and unable to advance on his path.
-- On Talbuk respawn the cycle repeats indefinitely.
--
-- Fix: Change react state from AGGRESSIVE (2) to PASSIVE (0).
-- The actual combat with the scripted Talbuk is initiated explicitly by the
-- CALL_TIMED_ACTIONLIST (action 80) → timed actionlist 1820000, which calls
-- ATTACK_START on the summoned creature. Passive react state does not interfere
-- with that scripted combat sequence.

UPDATE `smart_scripts` SET `action_param6` = 0
WHERE `entryorguid` = 18180
  AND `source_type` = 0
  AND `id` = 1
  AND `event_type` = 11
  AND `action_type` = 53
  AND `action_param6` = 2;
