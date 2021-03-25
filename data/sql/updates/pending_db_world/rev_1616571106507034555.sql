INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616571106507034555');

-- Remove MECHANIC_SLOW_ATTACK mask
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask` &~128 WHERE `entry` IN
(639, -- Edwin VanCleef
643,  -- Sneed
645,  -- Cookie
646,  -- Mr. Smite
647,  -- Captain Greenskin
642); -- Sneed's Shredder
