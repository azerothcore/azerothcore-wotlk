-- mod-nostrum-starter: custom starter bag item
--
-- Entry 900100: Nostrum Starter Bag
-- Clone of Large Knapsack (1725) with:
--   - Custom name
--   - BuyPrice / SellPrice = 0
--   - Flags |= ITEM_FLAG_NO_SELL_PRICE (262144) to block vendor selling
--   - bonding = 1 (Binds when picked up)

DELETE FROM item_template WHERE entry = 900100;

CREATE TEMPORARY TABLE _tmp_nostrum_bag SELECT * FROM item_template WHERE entry = 1725;
UPDATE _tmp_nostrum_bag SET
    entry     = 900100,
    name      = 'Nostrum Starter Bag',
    BuyPrice  = 0,
    SellPrice = 0,
    Flags     = 262144,
    bonding   = 1;
INSERT INTO item_template SELECT * FROM _tmp_nostrum_bag;
DROP TEMPORARY TABLE _tmp_nostrum_bag;

-- Large Knapsack (1725): make soulbound so starter bags cannot be traded
UPDATE item_template SET bonding = 1 WHERE entry = 1725;
