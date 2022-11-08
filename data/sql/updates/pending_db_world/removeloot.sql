-- Remove Syndicate emblems from Battered Junkbox and Worn Junkbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 16882 or `Entry` = 16883) AND (`Item` IN (17124));
