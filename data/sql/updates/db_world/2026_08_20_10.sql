-- DB update 2026_08_20_09 -> 2026_08_20_10
--
-- Algalon the Observer (Ulduar 25-man) loot pool structure
-- Splits the single 16-item gear pool into the three pools evidenced by recorded retail kills,
-- so each kill yields exactly one item from each pool instead of three draws from one pool.
-- Issue: azerothcore/azerothcore-wotlk#26353

-- Gift of the Observer 25-man (3 pools: 5+6+5)
UPDATE `gameobject_loot_template` SET `MinCount`=1, `MaxCount`=1
    WHERE `Entry`=26974 AND `Item`=1 AND `Reference`=12023;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=12023 AND `Item`=45570; -- Skyforge Crossbow
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=12023 AND `Item`=45587; -- Bulwark of Algalon
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=12023 AND `Item`=45594; -- Legplates of the Endless Void
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=12023 AND `Item`=45599; -- Sabatons of Lifeless Night
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=12023 AND `Item`=45607; -- Fang of Oblivion

-- Pool B (6 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=12023 AND `Item`=45609; -- Comet's Trail
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=12023 AND `Item`=45610; -- Boundless Gaze
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=12023 AND `Item`=45611; -- Solar Bindings
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=12023 AND `Item`=45617; -- Cosmos
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=12023 AND `Item`=45619; -- Starwatcher's Binding
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=12023 AND `Item`=45620; -- Starshard Edge

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=12023 AND `Item`=45612; -- Constellus
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=12023 AND `Item`=45613; -- Dreambinder
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=12023 AND `Item`=45615; -- Planewalker Treads
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=12023 AND `Item`=45616; -- Star-beaded Clutch
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=12023 AND `Item`=45665; -- Pharos Gloves
