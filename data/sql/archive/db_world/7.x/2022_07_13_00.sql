-- DB update 2022_07_12_01 -> 2022_07_13_00
--

UPDATE `creature_template` SET `exp`=0, `ManaModifier`=1 WHERE `entry`=11657;
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|512 WHERE `entry`=11677;
UPDATE `creature_template` SET `minlevel`=53, `maxlevel`=54 WHERE `entry`=11600;
UPDATE `creature_template` SET `lootid`=0,`mingold`=0, `maxgold`=0 WHERE `entry` IN (10987,11600,11602,11604,11605,10982,11603);

