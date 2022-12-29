--
DELETE FROM `creature_loot_template` WHERE `Entry` IN (18088, 18340, 18044, 18046, 18086, 18087, 18089, 19946, 19947, 20089, 20088) AND (`Item` IN (24280));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18088, 24280, 0, 100, 1, 1, 0, 1, 1, 'Bloodscale Enchantress - Naga Claws'),
(20088, 24280, 0, 100, 1, 1, 0, 1, 1, 'Bloodscale Overseer - Naga Claws'),
(18089, 24280, 0, 100, 1, 1, 0, 1, 1, 'Bloodscale Slavedriver - Naga Claws'),
(20089, 24280, 0, 100, 1, 1, 0, 1, 1, 'Bloodscale Wavecaller - Naga Claws'),
(18087, 24280, 0, 100, 1, 1, 0, 1, 1, 'Darkcrest Siren - Naga Claws'),
(19946, 24280, 0, 100, 1, 1, 0, 1, 1, 'Darkcrest Slaver - Naga Claws'),
(19947, 24280, 0, 100, 1, 1, 0, 1, 1, 'Darkcrest Sorceress - Naga Claws'),
(18086, 24280, 0, 100, 1, 1, 0, 1, 1, 'Darkcrest Taskmaster - Naga Claws'),
(18046, 24280, 0, 100, 1, 1, 0, 1, 1, 'Rajah Haghazed - Naga Claws'),
(18044, 24280, 0, 100, 1, 1, 0, 1, 1, 'Rajis Fyashe - Naga Claws'),
(18340, 24280, 0, 100, 1, 1, 0, 1, 1, 'Steam Pump Overseer - Naga Claws');
