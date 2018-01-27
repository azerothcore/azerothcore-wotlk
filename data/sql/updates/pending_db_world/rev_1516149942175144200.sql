INSERT INTO version_db_world (`sql_rev`) VALUES ('1516149942175144200');

-- Useless loot
DELETE FROM `creature_loot_template` WHERE `entry` IN (1, 1175);
-- Conditions for lootid 1, useless
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 1;

-- Attumen the Huntsman - Fix condition on item 23809
UPDATE `conditions` SET `SourceGroup` = 16152 WHERE `SourceGroup` = 15550 AND `SourceEntry` = 23809;

-- Conditions that aren't referenced and, still, aren't correct.
DELETE FROM `conditions` WHERE `SourceGroup` = 21060 AND `SourceEntry` = 23612;
DELETE FROM `conditions` WHERE `SourceGroup` = 21061 AND `SourceEntry` = 23612;
