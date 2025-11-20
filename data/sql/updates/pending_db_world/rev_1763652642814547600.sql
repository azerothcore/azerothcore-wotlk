--
UPDATE `creature_addon` SET `bytes2` = 1, `auras` = '31261' WHERE `guid` IN (114372, 114373, 114381);
UPDATE `creature` SET `unit_flags` = `unit_flags`|256|512|536870912, `VerifiedBuild` = 64502 WHERE `guid` IN (114372, 114373, 114381) AND `id1` = 30148;
