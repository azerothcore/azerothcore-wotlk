-- Remove old/deprecated bytes2 flags.
UPDATE `creature_addon` SET `bytes2` = 1 WHERE `bytes2` IN (4092,4096,4097,256,257,301993985,318771201,285216769);
UPDATE `creature_addon` SET `bytes2` = 0 WHERE `bytes2` IN (733,141313,234885121,251662337);
UPDATE `creature_addon` SET `bytes2` = 2 WHERE `bytes2` IN (258,4098);

-- Elder Springpaw, Scorpid Bonecrawler & Blackwind Sabercat wrong spawns.
DELETE FROM `creature_addon` WHERE `guid` IN (75829,77583,77606,77607,82379);
DELETE FROM `creature` WHERE `guid` IN (75829,77583,82379);

-- Hatecrest Warrior defensive stance, handled by SAI
UPDATE `creature_addon` SET `auras` = NULL WHERE `guid` = 51476;
