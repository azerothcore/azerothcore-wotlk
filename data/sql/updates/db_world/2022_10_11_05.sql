-- DB update 2022_10_11_04 -> 2022_10_11_05
-- Springpaw Stalker 213/445  Elder Springpaw 112/238 drop rate of Springpaw Pelt (~47.5% 325/683)
UPDATE `creature_loot_template` SET `Chance`='45' WHERE  `Item`=20772;
