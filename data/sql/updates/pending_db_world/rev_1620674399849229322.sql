INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620674399849229322');
UPDATE `item_template` SET `minMoneyLoot`=50, `maxMoneyLoot`=100 WHERE `entry`=20708; -- Tightly Sealed Trunk
UPDATE `item_template` SET `minMoneyLoot`=100, `maxMoneyLoot`=200 WHERE `entry` IN (
21113, -- Watertight Trunk
21150, -- Iron Bound Trunk
21228); -- Mithril Bound Trunk
