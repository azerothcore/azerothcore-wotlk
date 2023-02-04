-- DB update 2022_10_07_00 -> 2022_10_07_01
--
-- Drop rate improvements over 1144 itterations:
-- ITEM Captain Kelisendra's Lost Rutters (21776) = Already Correct 10%
-- Other quest ITEMs Grimscale Murloc Head (21757), Captain Kelisendra's Cargo (21771) appear to be about 45% rate (it is possible the casters are higher rate, but unproven within margin of error)
UPDATE `creature_loot_template` SET `Chance`='45' WHERE  `Item`=21757;
UPDATE `creature_loot_template` SET `Chance`='45' WHERE  `Item`=21771;
