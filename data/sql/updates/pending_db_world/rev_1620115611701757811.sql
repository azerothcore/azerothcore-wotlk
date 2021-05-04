INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620115611701757811');

-- Copper Vein
UPDATE `gameobject_loot_template` SET `MaxCount`=7 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND Item = 2835; -- Rough Stone
UPDATE `gameobject_loot_template` SET `MinCount`=2 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND Item = 2835; -- Rough Stone
UPDATE `gameobject_loot_template` SET `Chance`=40 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND Item = 2835; -- Rough Stone
UPDATE `gameobject_loot_template` SET `MinCount`=2 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND Item = 2770; -- Copper Ore
UPDATE `gameobject_loot_template` SET `MaxCount`=4 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND Item = 2770; -- Copper Ore

-- Tin Vein
UPDATE `gameobject_loot_template` SET `MaxCount`=7 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND Item = 2836; -- Coarse Stone
UPDATE `gameobject_loot_template` SET `MinCount`=2 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND Item = 2836; -- Coarse Stone
UPDATE `gameobject_loot_template` SET `Chance`=40 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND Item = 2836; -- Coarse Stone
UPDATE `gameobject_loot_template` SET `MinCount`=2 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND Item = 2771; -- Tin Ore
UPDATE `gameobject_loot_template` SET `MaxCount`=4 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND Item = 2771; -- Tin Ore

-- Iron Deposit
UPDATE `gameobject_loot_template` SET `Chance`=40 WHERE Entry = 1505 AND Item = 2838; -- Heavy Stone
UPDATE `gameobject_loot_template` SET `MinCount`=3 WHERE Entry = 1505 AND Item = 2838; -- Heavy Stone
UPDATE `gameobject_loot_template` SET `MaxCount`=9 WHERE Entry = 1505 AND Item = 2838; -- Heavy Stone
UPDATE `gameobject_loot_template` SET `GroupId`=1 WHERE Entry = 1505 AND Item = 2838; -- Heavy Stone

-- Mithril Deposit
UPDATE `gameobject_loot_template` SET `MinCount`=2 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND Item = 3858; -- Mithril Ore
UPDATE `gameobject_loot_template` SET `MaxCount`=4 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND Item = 3858; -- Mithril Ore
UPDATE `gameobject_loot_template` SET `MinCount`=3 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND Item = 7912; -- Solid Stone
UPDATE `gameobject_loot_template` SET `MaxCount`=12 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND Item = 7912; -- Solid Stone
UPDATE `gameobject_loot_template` SET `Chance`=40 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND Item = 7912; -- Solid Stone

-- Hakkari Thorium Vein
UPDATE `gameobject_loot_template` SET `GroupId`=1 WHERE Entry = 17241 AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `GroupId`=1 WHERE Entry = 17241 AND Item = 1; -- Reference Tables
UPDATE `gameobject_loot_template` SET `Chance`=40 WHERE Entry = 17241 AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`=3 WHERE Entry = 17241 AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MaxCount`=9 WHERE Entry = 17241 AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`=2 WHERE Entry = 17241 AND Item = 19774; -- Souldarite
UPDATE `gameobject_loot_template` SET `MaxCount`=4 WHERE Entry = 17241 AND Item = 19774; -- Souldarite
UPDATE `gameobject_loot_template` SET `MinCount`=2 WHERE Entry = 17241 AND Item = 10620; -- Thorium Ore
UPDATE `gameobject_loot_template` SET `MaxCount`=4 WHERE Entry = 17241 AND Item = 10620; -- Thorium Ore

-- Small Thorium Veins
UPDATE `gameobject_loot_template` SET `GroupId`=1 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `GroupId`=1 WHERE Entry = 13960 AND Item = 11513; -- Tainted Vitriol
UPDATE `gameobject_loot_template` SET `GroupId`=1 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND Item = 1; -- Reference Tables
UPDATE `gameobject_loot_template` SET `Chance`=40 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`=3 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MaxCount`=9 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`=2 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND Item = 10620; -- Thorium Ore
UPDATE `gameobject_loot_template` SET `MaxCount`=4 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND Item = 10620; -- Thorium Ore

-- Rich Thorium Vein
UPDATE `gameobject_loot_template` SET `GroupId`=1 WHERE Entry = 12883 AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `GroupId`=1 WHERE Entry = 12883 AND Item = 1; -- Reference Tables
UPDATE `gameobject_loot_template` SET `Chance`=40 WHERE Entry = 12883 AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`=4 WHERE Entry = 12883 AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MaxCount`=12 WHERE Entry = 12883 AND Item = 12365; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`=3 WHERE Entry = 12883 AND Item = 19774; -- Thorium Ore
UPDATE `gameobject_loot_template` SET `MaxCount`=5 WHERE Entry = 12883 AND Item = 19774; -- Thorium Ore

