-- --------------------------------------------------------------------------------------------
-- Acherus: The Ebon Hold (Eastern Plaguelands, map 609)
-- Olrun the Battlecaller (Entry 29047, GUID 128739)
-- Use flying anim tier so she keeps flapping when stopped for gossip/quest interaction
-- -------------------------------------------
UPDATE `creature_addon` SET `bytes1` = 50331648 WHERE (`guid` = 128739);
