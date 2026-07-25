-- Issue #26442: Vaelen the Flayed (Icecrown, entry 30056), a chained-up captive NPC, joins the
-- fight whenever a hostile mob is pulled near him. His own faction (2050) has HostileMask=0 and
-- no listed enemies - he can never actually be hostile by faction rules - but his default
-- reactstate (REACT_AGGRESSIVE, never overridden) is enough for him to assist against anything
-- fighting nearby regardless of his own faction's hostility.
--
-- UNIT_FLAG_IMMUNE_TO_NPC (0x200) blocks him as a valid attack/assist target for and against
-- NPCs at the engine level (Unit::_IsValidAttackTarget/_IsValidAssistTarget), which is the
-- precise fix for this symptom - already confirmed working live (see PR #26766, same issue,
-- same fix, not merged yet). His spawn row's unit_flags is 0, which ObjectMgr::ChooseCreatureFlags
-- treats as "no override, inherit from creature_template" (not "force to zero"), so updating the
-- template value below applies to this spawn.
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|512 WHERE `entry` = 30056;

-- Optional, belt-and-suspenders addition - not required for the fix above to work, kept as a
-- second layer in case a future quest/script change ever alters his reactstate: also stop him
-- from actively choosing to engage on his own (SMART_ACTION_SET_REACT_STATE, passive), reapplied
-- on every reset so combat can't leave him stuck aggressive.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30056 AND `source_type` = 0 AND `id` = 1 AND `link` = 0;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `action_type`, `action_param1`, `target_type`, `comment`)
VALUES
    (30056, 0, 1, 0, 25, 0, 100, 0, 8, 0, 1, 'Vaelen the Flayed - On Reset - Set Reactstate Passive (defense in depth)');
