-- DB update 2025_07_29_01 -> 2025_07_29_02
-- improved shadow bolt into spell crit debuff
DELETE FROM `spell_group` WHERE `id` = 1010 AND `spell_id` IN (17800);
INSERT INTO `spell_group` VALUES (1010, 17800, 0);

-- curse of weakness and spore cloud into low armor% debuff, remove curse of recklessness
-- combine low armor% and attack power debuff because of curse of weakness
-- add vindication and demoralizing screech
DELETE FROM `spell_group` WHERE `id` = 1004 AND `spell_id` IN (702, 50274, 16231, 99, 1160, 67, 24423);
INSERT INTO `spell_group` VALUES (1004, 702, 0), (1004, 50274, 0), (1004, 99, 0), (1004, 1160, 0), (1004, 67, 0), (1004, 24423, 0);

-- rename
UPDATE `spell_group_stack_rules` SET `description` = 'Group of minor Armor reducing, hit increase and AP reducing debuffs, effect exclusive' WHERE `group_id` = 1004;

-- remove old ap debuff group
DELETE FROM `spell_group` WHERE `id` = 1017;
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1017;

-- stampede into bleed debuff
DELETE FROM `spell_group` WHERE `id` = 1008 AND `spell_id` IN (57386);
INSERT INTO `spell_group` VALUES (1008, 57386, 0);

-- poison spit, lava breath into spell haste debuff
DELETE FROM `spell_group` WHERE `id` = 1022 AND `spell_id` IN (35387, 58604);
INSERT INTO `spell_group` VALUES (1022, 35387, 0), (1022, 58604, 0);

-- master poisoner into crit taken debuff (untested)
DELETE FROM `spell_group` WHERE `id` = 1013 AND `spell_id` IN (45176);
INSERT INTO `spell_group` VALUES (1013, 45176, 0);

-- physical damage taken group with savage combat and blood frenzy
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1024;
INSERT INTO `spell_group_stack_rules` VALUES (1024, 17, 'Group of physical damage taken increasing debuffs');

DELETE FROM `spell_group` WHERE `id` = 1024 AND `spell_id` IN (30069, 58684);
INSERT INTO `spell_group` VALUES (1024, 30069, 0), (1024, 58684, 0);
