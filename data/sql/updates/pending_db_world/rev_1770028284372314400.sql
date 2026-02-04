-- Removes "Warsong Report" and "Battered Junkbox" (yes remove itself from itself) from "Battered Junkbox"
DELETE FROM `item_loot_template` WHERE `Entry` = 16882 AND `Item` IN (16746, 16882);
