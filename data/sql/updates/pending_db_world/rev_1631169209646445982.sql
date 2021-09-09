INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631169209646445982');

-- Removed the skinning loot of Rock Worm (NPC 11788), Rock Borer (NPC 11787) and Vile Larva (NPC 12218)
UPDATE `creature_template` SET `skinloot` = 0 WHERE (`entry` IN (11788, 11787, 12218));

