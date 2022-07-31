--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 25654 AND `spell_effect` = 6608;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(25654, 6608, 1, 'Hive\'Zara Tail Lasher: On Tail Lash - Apply Dropped Weapon');
