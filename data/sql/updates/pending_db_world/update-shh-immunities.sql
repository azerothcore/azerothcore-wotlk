-- 
-- setting them to 0 first, so I can later do the bitmask operation
-- all of these were originally 1
-- for heroics only houndmaster was 67601, rest was 1
UPDATE `creature_template` SET `mechanic_immune_mask` = 0 WHERE `entry` IN (16507, 16700, 17465, 17670, 17671, 20593, 20589, 20583, 20588, 20584, 20582, 20590, 20587, 20586); -- setting to 0

UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|64|128|1024|2048|4096|8192|65536|8388608|536870912 WHERE `entry` IN (17671, 20584); -- full cc
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|1024|65536 WHERE `entry` IN (17465, 20583); -- MC/charm, snare and poly
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|65536 WHERE `entry` IN (16700, 20589); -- poly
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|536870912 WHERE `entry` IN (16507, 20593); -- sap
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|65536 WHERE `entry` = 20588; -- houndmaster HC only immune to poly
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1 WHERE `entry` IN (20588, 20584, 20582, 20586, 20587, 20589, 20590, 20593); -- HC only houndmaster, champion, brawler, gladiator, heathen, legionnaire, reaver and sentry MC immune
