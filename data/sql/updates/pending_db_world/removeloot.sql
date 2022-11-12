-- Remove Syndicate emblems from Battered Junkbox and Worn Junkbox
DELETE FROM `item_loot_template` WHERE `Entry` in (16882, 16883) AND (`Item` IN (17124));
