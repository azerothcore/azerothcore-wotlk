-- INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620498329028793558');

-- Missing Reference Tables in STV
UPDATE `creature_loot_template` SET `Reference` = 24723, `Comment` = 'Ana''thek the Cruel - (ReferenceTable)' WHERE `Entry`= 1059 AND `Item` = 24723;
UPDATE `creature_loot_template` SET `Reference` = 24722, `Comment` = 'Gan''zulah - (ReferenceTable)' WHERE `Entry`= 1061 AND `Item` = 24723;
UPDATE `creature_loot_template` SET `Reference` = 24723, `Comment` = 'Nezzliok the Dire - (ReferenceTable)' WHERE `Entry`= 1062 AND `Item` = 24723;
UPDATE `creature_loot_template` SET `Reference` = 24736, `Comment` = 'Nezzliok the Dire - (ReferenceTable)' WHERE `Entry`= 1062 AND `Item` = 24736;

