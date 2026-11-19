-- DB update 2026_10_16_00 -> 2026_10_16_01
-- Alterac Valley generals and captains: BattlegroundAV::HandleKillUnit already rewards the whole team
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (11946, 11947, 11948, 11949);
