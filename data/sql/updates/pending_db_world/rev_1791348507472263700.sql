-- Alterac Valley generals and captains: BattlegroundAV::HandleKillUnit already rewards the whole team
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (11946, 11947, 11948, 11949);
