--
-- Magtheridon's Lair: group the 5 Hellfire Channelers in a single formation.
-- groupAI = 11 (0x00B) combines:
--   0x001 MEMBER_ASSIST_LEADER - members aggro when the leader is engaged
--   0x002 LEADER_ASSIST_MEMBER - leader aggros when any member is engaged
--                                (fans out to the other members via 0x001)
--   0x008 RESPAWN_ON_EVADE     - dead members respawn when a surviving member evades
-- EVADE_TOGETHER (0x004) is intentionally NOT set: in CreatureGroup::MemberEvaded
-- the EVADE_TOGETHER branch short-circuits on dead members and skips the
-- respawn path, so a partial wipe (e.g. 3/5 killed) would leave the corpses
-- on the ground. Without that flag, each surviving Channeler evades on its
-- own when its target list empties, and each evade triggers RESPAWN_ON_EVADE
-- to bring the dead members back. This replaces the previous reliance on
-- the minion system, which caused dead Channelers to be resurrected when
-- Magtheridon's combat state oscillated between IN_COMBAT and NONE.
--
DELETE FROM `creature_formations` WHERE `leaderGUID`=90978;
INSERT INTO `creature_formations`
(`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`)
VALUES
(90978, 90978, 0, 0, 11, 0, 0),
(90978, 90979, 0, 0, 11, 0, 0),
(90978, 90980, 0, 0, 11, 0, 0),
(90978, 90981, 0, 0, 11, 0, 0),
(90978, 90982, 0, 0, 11, 0, 0);

--
-- On evade:
--  * id=9 notifies the instance script so it can force-reset Magtheridon
--    (otherwise his _channelersKilled counter would stay stale across
--    pulls; Magtheridon is held in combat by SetInCombatWithZone() and
--    his own EnterEvadeMode does not always fire).
--  * id=10 strips the Soul Transfer (30531) auras stacked on the surviving
--    Channelers from each ally that died during the previous pull.
--    Without this, on a partial wipe (e.g. 3/5 killed) the survivors
--    return to spawn with permanent damage/health buffs.
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=17256 AND `source_type`=0 AND `id` IN (9, 10);
INSERT INTO `smart_scripts`
(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
 `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,
 `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
 `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,
 `target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(17256, 0, 9,  0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 34, 10,    0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
 'Hellfire Channeler - On Evade - Set Instance Data 10 to 0'),
(17256, 0, 10, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 28, 30531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
'Hellfire Channeler - On Evade - Remove Aura \'Soul Transfer\'');
