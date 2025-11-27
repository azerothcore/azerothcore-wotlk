-- Following the same rule as the herbs, ores and fishing for the everfrost to be visible by all possible.
UPDATE `gameobject` SET `phaseMask` = 255 WHERE `id` = 193997;

-- Sets all Herbs spawn time to be 1 hour (as they are currently not pooled).
-- Goldclover, Tiger Lily, Talandra's Rose, Lichbloom, Icethorn, Frozen Herb (190173, 190174 and 190175), Adder's Tongue and Frost Lotus (currently can be farmed in an instance for free.)
UPDATE `gameobject` SET `spawntimesecs` = 3600 WHERE `id` IN (189973, 190169, 190170, 190171, 190172, 190173, 190174, 190175, 191019, 190176) AND `SpawnMask` != 3;

-- Sets all Ore Veins spawn time to be 1 hour (as they are currently not pooled).
-- Colbat Deposit, Rich Cobalt Deposit, Sranoite Depoist, Rich Saronite Deposit, Titatinum Vein and Pure Sarotine Depoist
UPDATE `gameobject` SET `spawntimesecs` = 3600 WHERE `id` IN (189980, 189981, 189978, 189979, 191133, 195036) AND `SpawnMask` != 3;
