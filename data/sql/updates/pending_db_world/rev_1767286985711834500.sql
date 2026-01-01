-- Changes from 2 hours (7200) to 15 minute (900 seconds) respawn for "Battered Footlocker"(179486) and "Battered Footlocke" (179488) 
UPDATE `gameobject` SET `spawntimesecs` = 900 WHERE `id` IN (179486, 179488); 
