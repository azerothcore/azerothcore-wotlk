-- DB update 2022_11_12_15 -> 2022_11_13_00
-- Remove Syndicate emblems from Battered Junkbox and Worn Junkbox
DELETE FROM `item_loot_template` WHERE `Entry` IN (16882, 16883) AND (`Item` IN (17124));
