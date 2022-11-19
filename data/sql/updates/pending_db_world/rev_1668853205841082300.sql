--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (35475,35476,35477,35478) AND `spell_effect`=51120;
INSERT INTO `spell_linked_spell` VALUES
(35475,51120,1,'Drums of War - Tinnitus'),
(35476,51120,1,'Drums of Battle - Tinnitus'),
(35477,51120,1,'Drums of Speed - Tinnitus'),
(35478,51120,1,'Drums of War - Tinnitus');
