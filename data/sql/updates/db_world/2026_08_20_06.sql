-- DB update 2026_08_20_05 -> 2026_08_20_06
--
-- Malygos (Eye of Eternity 25-man) loot pool structure
-- Splits the single 20-item gear pool of reference 34175 into the four pools evidenced by
-- recorded retail kills (23 kills), so each kill yields exactly one item from each pool
-- instead of four draws from one pool.
-- Issue: azerothcore/azerothcore-wotlk#26272

-- Alexstrasza's Gift 25-man (4 pools: 5+5+5+5)
UPDATE `gameobject_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=26097 AND `Item`=1 AND `Reference`=34175;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34175 AND `Item`=40531; -- Mark of Norgannon
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34175 AND `Item`=40539; -- Chestguard of the Recluse
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34175 AND `Item`=40541; -- Frosted Adroit Handguards
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34175 AND `Item`=40543; -- Blue Aspect Helm
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34175 AND `Item`=40549; -- Boots of the Renewed Flight

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34175 AND `Item`=40194; -- Blanketing Robes of Snow
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34175 AND `Item`=40555; -- Mantle of Dissemination
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34175 AND `Item`=40558; -- Arcanic Tramplers
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34175 AND `Item`=40560; -- Leggings of the Wanton Spellcaster
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34175 AND `Item`=40561; -- Leash of Heedless Magic

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34175 AND `Item`=40532; -- Living Ice Crystals
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34175 AND `Item`=40562; -- Hood of Rationality
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34175 AND `Item`=40564; -- Winter Spectacle Gloves
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34175 AND `Item`=40566; -- Unravelling Strands of Sanity
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34175 AND `Item`=40588; -- Tunic of the Artifact Guardian

-- Pool D (5 items)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34175 AND `Item`=40589; -- Legplates of Sovereignty
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34175 AND `Item`=40590; -- Elevated Lair Pauldrons
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34175 AND `Item`=40591; -- Melancholy Sabatons
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34175 AND `Item`=40592; -- Boots of Healing Energies
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34175 AND `Item`=40594; -- Spaulders of Catatonia
