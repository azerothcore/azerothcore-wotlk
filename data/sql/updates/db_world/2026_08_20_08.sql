-- DB update 2026_08_20_07 -> 2026_08_20_08
-- Algalon the Observer (Ulduar 10-man) loot pool structure fix
-- Splits the single 15-item pool of reference 34134 into 3 pools of 5, one item drawn from each,
-- and lowers the referring row to 1x so the chest yields 3 gear items per kill instead of 2.
-- Source: azerothcore/azerothcore-wotlk#26314, chromiecraft/chromiecraft#9757 (22 recorded kills)

-- Gift of the Observer 10-man chest: process reference 34134 once (3 pools x 1 = 3 items)
UPDATE `gameobject_loot_template` SET `MinCount`=1, `MaxCount`=1 WHERE `Entry`=27030 AND `Item`=1 AND `Reference`=34134;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34134 AND `Item`=46037; -- Shoulderplates of the Celestial Watch
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34134 AND `Item`=46038; -- Dark Matter
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34134 AND `Item`=46039; -- Breastplate of the Timeless
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34134 AND `Item`=46040; -- Strength of the Heavens
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34134 AND `Item`=46041; -- Starfall Girdle

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34134 AND `Item`=46042; -- Drape of the Messenger
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34134 AND `Item`=46043; -- Gloves of the Endless Dark
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34134 AND `Item`=46044; -- Observer's Mantle
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34134 AND `Item`=46045; -- Pulsar Gloves
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34134 AND `Item`=46046; -- Nebula Band

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34134 AND `Item`=46047; -- Pendant of the Somber Witness
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34134 AND `Item`=46048; -- Band of Lights
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34134 AND `Item`=46049; -- Zodiac Leggings
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34134 AND `Item`=46050; -- Starlight Treads
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34134 AND `Item`=46051; -- Meteorite Crystal
