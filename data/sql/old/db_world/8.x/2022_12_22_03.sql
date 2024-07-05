-- DB update 2022_12_22_02 -> 2022_12_22_03
--
-- Xerintha Ravenoak vendor timers repaired
UPDATE `npc_vendor` SET `incrtime`=300 WHERE `entry`=20916 AND `item`=31674 AND `ExtendedCost`=0;
UPDATE `npc_vendor` SET `incrtime`=600 WHERE `entry`=20916 AND `item`=31675 AND `ExtendedCost`=0;
