-- DB update 2025_11_27_02 -> 2025_11_27_03
-- Sets all Everfrost Gameobjects to be able to seen in phase 1, 2, 4, 8 and 12
UPDATE `gameobject` SET `phaseMask` = 15 WHERE `id` = 193997;
