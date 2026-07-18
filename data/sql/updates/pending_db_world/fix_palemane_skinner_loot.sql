-- Remove high-level food drops from Palemane Skinner (Issue #26372)
DELETE FROM `creature_loot_template` WHERE `entry`=2950 AND `item` IN (787, 2070, 3771, 4536, 4540, 4599, 4604);