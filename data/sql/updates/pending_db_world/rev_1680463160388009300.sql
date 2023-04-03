-- Remove old/deprecated bytes2 flags.
UPDATE `creature_addon` SET `bytes2` = 1 WHERE `bytes2` IN (257,733,4092,4097,301993985,318771201,285216769,234885121);
UPDATE `creature_addon` SET `bytes2` = 0 WHERE `bytes2` IN (256,4096);
UPDATE `creature_addon` SET `bytes2` = 2 WHERE `bytes2` IN (258,4098);

UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE `bytes2` IN (133121,10241,2305,2049,69,3);
UPDATE `creature_template_addon` SET `bytes2` = 0 WHERE `bytes2` = 65536;

-- Creature where neither of the values in creature_addon were used.
DELETE FROM `creature_addon` WHERE `guid` IN (75829,77583,77606,77607,82379,73192,80419,81738,82004,32943);

-- Incorrect mob spawns (wrong zone/area/sniffed as a pet (with spirit bond))
-- Blackwind Sabercat
DELETE FROM `creature` WHERE (`guid` = 75829 AND `id1` = 21723);
-- Scorpid Bonecrawler
DELETE FROM `creature` WHERE (`guid` = 77583 AND `id1` = 22100);
-- Elder Springpaw
DELETE FROM `creature` WHERE (`guid` = 82379 AND `id1` = 15652);
-- Scalewing Serpent
DELETE FROM `creature` WHERE (`guid` = 73192 AND `id1` = 20749);
-- Stunetusk Boar
DELETE FROM `creature` WHERE (`guid` = 80419 AND `id1` = 113);


-- Hatecrest Warrior defensive stance, Grimtotem Raider berserk stance, handled by SAI
UPDATE `creature_addon` SET `auras` = '' WHERE `guid` IN (51476,50009);
