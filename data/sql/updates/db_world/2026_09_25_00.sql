-- DB update 2026_09_24_11 -> 2026_09_25_00
-- --------------------------------------------------------------------------------------------
-- Acherus: The Ebon Hold (Eastern Plaguelands, map 609)
-- Olrun the Battlecaller (Entry 29047, GUID 128739)
-- Use flying anim tier to enable Olrum wing movement when stopped for gossip/quest intereaction
-- -------------------------------------------
UPDATE `creature_addon` SET `bytes1` = 50331648 WHERE (`guid` = 128739);
