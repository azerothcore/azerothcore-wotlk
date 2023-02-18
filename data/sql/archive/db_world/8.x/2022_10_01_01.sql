-- DB update 2022_10_01_00 -> 2022_10_01_01
--

DELETE FROM `npc_vendor` WHERE `entry` = 24495 AND `item` IN (37737, 37599) AND `ExtendedCost` = 2276;
