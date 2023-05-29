-- DB update 2022_08_01_14 -> 2022_08_01_15
--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 25654 AND `spell_effect` = 6608;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(25654, 6608, 1, 'Hive\'Zara Tail Lasher: On Tail Lash - Apply Dropped Weapon');

UPDATE `smart_scripts` SET `event_param3`=10900, `event_param4`=23100 WHERE `entryorguid`=15336 AND `source_type`=0 AND `id`=4 AND `link`=0;
