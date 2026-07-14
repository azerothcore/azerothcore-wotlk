-- DB update 2026_07_11_00 -> 2026_07_12_00
DELETE FROM `gameobject_template` WHERE `entry` = 301337;
DELETE FROM `gameobject_template_addon` WHERE `entry` = 301337;
DELETE FROM `gameobject_template_locale` WHERE `entry` = 301337;
