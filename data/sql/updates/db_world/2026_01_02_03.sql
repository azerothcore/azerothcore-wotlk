-- DB update 2026_01_02_02 -> 2026_01_02_03
-- Changes from 2 hours (7200) to 15 minute (900 seconds) respawn for "Battered Footlocker"(179486), "Battered Footlocker" (179488)  and "Battered Footlocker" (179490)
UPDATE `gameobject` SET `spawntimesecs` = 900 WHERE `id` IN (179486, 179488, 179490);
