-- Delete from Naxxramas References (was alongside recipes)
DELETE FROM `reference_loot_template` WHERE `Entry` = 35081 AND `Item` = 34052;

-- Delete Small Dream Shard from loose creatures
DELETE FROM `creature_loot_template` WHERE `Entry` IN (24791, 25686) AND `Item` = 34053 AND `Reference` = 0;
