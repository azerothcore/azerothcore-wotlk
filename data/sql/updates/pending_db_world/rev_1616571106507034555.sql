INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616571106507034555');

-- Remove MECHANIC_SLOW_ATTACK mask
UPDATE `creature_template` SET `mechanic_immune_mask`=608908883 WHERE `entry` IN
(639, -- Edwin VanCleef
643,  -- Sneed
645,  -- Cookie
646,  -- Mr. Smite
647); -- Captain Greenskin
UPDATE `creature_template` SET `mechanic_immune_mask`=608925267 WHERE `entry`=642; -- Sneed's Shredder
