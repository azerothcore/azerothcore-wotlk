-- DB update 2026_05_28_00 -> 2026_05_30_00
-- Hellfire Channelers formation: groupAI = 3 (MEMBER_ASSIST_LEADER | LEADER_ASSIST_MEMBER), pack-aggro only. Wipe handling lives in the instance script's hard reset.
DELETE FROM `creature_formations` WHERE `leaderGUID`=90978;
INSERT INTO `creature_formations`
(`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`)
VALUES
(90978, 90978, 0, 0, 3, 0, 0),
(90978, 90979, 0, 0, 3, 0, 0),
(90978, 90980, 0, 0, 3, 0, 0),
(90978, 90981, 0, 0, 3, 0, 0),
(90978, 90982, 0, 0, 3, 0, 0);

-- Hellfire Channeler SAI: drop id=6. Death tracking moved to the instance script (OnUnitDeath).
DELETE FROM `smart_scripts` WHERE `entryorguid`=17256 AND `source_type`=0 AND `id`=6;
