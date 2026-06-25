-- DB update 2024_12_07_03 -> 2024_12_07_04
-- improve spawns positions of 180867 `Greater Moonlight Spell Focus`
-- sync these with sniffed spawns of creature 15897 `Large Spotlight`
UPDATE `gameobject` SET `position_x` = 1642.070556640625, `position_y` = 239.8388671875, `position_z` = 62.67490386962890625 WHERE `guid` = 241003 AND `id` = 180867;
UPDATE `gameobject` SET `position_x` = 10150.49609375, `position_y` = 2602.14306640625, `position_z` = 1330.908447265625 WHERE `guid` = 241002 AND `id` = 180867;
UPDATE `gameobject` SET `position_x` = -4017.510986328125, `position_y` = -11837.7255859375, `position_z` = 0.159306332468986511 WHERE `guid` = 241009 AND `id` = 180867;
UPDATE `gameobject` SET `position_x` = 9479.2578125, `position_y` = -7295.2119140625, `position_z` = 14.40949821472167968 WHERE `guid` = 241008 AND `id` = 180867;
UPDATE `gameobject` SET `position_x` = 5821.92236328125, `position_y` = 642.78399658203125, `position_z` = 648.1099853515625 WHERE `guid` = 241007 AND `id` = 180867;
UPDATE `gameobject` SET `position_y` = -2247.21533203125 WHERE `guid` = 241012 AND `id` = 180867;
