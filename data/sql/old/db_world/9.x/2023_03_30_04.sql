-- DB update 2023_03_30_03 -> 2023_03_30_04
DELETE FROM reference_loot_template WHERE (`Entry` = 4110) AND (`Item` IN (30520, 30986));
