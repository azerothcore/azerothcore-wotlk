-- fix Santa handing out empty gifts
-- before: ungrouped at roughly 25%, can be empty and also multiple hits
-- after: grouped ad exactly 25%, never empty, always one hit only
-- Smokywood Pastures Gift Pack (17727)
UPDATE `item_loot_template` SET `Chance` = 0, `GroupId` = 1 WHERE (`Entry` = 17727) AND (`Item` IN (785, 2318, 2840, 2996));
