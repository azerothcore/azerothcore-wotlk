-- DB update 2022_07_25_06 -> 2022_07_25_07

-- Ossirian immune to Taunt
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|256 WHERE `entry`=15339;

-- Sand Vortex UNIT_FLAG_NOT_SELECTABLE
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE `entry`=15428;
