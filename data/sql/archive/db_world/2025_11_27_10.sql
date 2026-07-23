-- DB update 2025_11_27_09 -> 2025_11_27_10
-- Sets all Herbs spawn time to be 15 minutes  (as they are currently not pooled).
-- Goldclover, Tiger Lily, Talandra's Rose, Lichbloom, Icethorn, Frozen Herb (190173, 190174 and 190175), Adder's Tongue and Frost Lotus (currently can be farmed in an instance for free.)
UPDATE `gameobject` SET `spawntimesecs` = 900 WHERE `id` IN (189973, 190169, 190170, 190171, 190172, 190173, 190174, 190175, 191019, 190176) AND `SpawnMask` != 3;

-- Sets all Ore Veins spawn time to be 15 minutes (as they are currently not pooled).
-- Colbat Deposit, Rich Cobalt Deposit, Sranoite Depoist, Rich Saronite Deposit, Titatinum Vein and Pure Sarotine Depoist
UPDATE `gameobject` SET `spawntimesecs` = 900 WHERE `id` IN (189980, 189981, 189978, 189979, 191133, 195036) AND `SpawnMask` != 3;
