INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620435208642994700');

-- es.classic.wowhead.com/npc=6910/revelosh
UPDATE `creature_loot_template` SET `Chance`=41 WHERE `Entry`=6910 AND `Item`=7741;
UPDATE `creature_loot_template` SET `Chance`=23 WHERE `Entry`=6910 AND `Item` IN (9387,9389);
UPDATE `creature_loot_template` SET `Chance`=21 WHERE `Entry`=6910 AND `Item` IN (9390,9388);
UPDATE `creature_loot_template` SET `Chance`=13 WHERE `Entry`=6910 AND `Item`=4306;
UPDATE `creature_loot_template` SET `Chance`=2 WHERE `Entry`=6910 AND `Item`=3771;

