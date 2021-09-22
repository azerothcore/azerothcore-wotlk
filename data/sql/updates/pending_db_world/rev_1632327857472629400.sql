INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632327857472629400');

DELETE FROM `creature_loot_template` WHERE `Entry` = 8891 AND `Item` IN (24086, 774, 818, 1206, 1210, 1529, 1705, 2449, 3356, 3357, 3820, 5498, 5500);

# Note: This reference_loot_template entry has multiple (1000+) different mobs referencing it.
# Checked a couple of the mobs (On Wowhead) and found that it varied whether they dropped the item (Citrine)
# Those that did had it in their individual table
DELETE FROM `reference_loot_template` WHERE `Entry` = 24036 AND `Item` = 3864;
