INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648289846118024900');

-- Fix selectable doors
UPDATE `gameobject_template_addon` SET `faction` = 114, `flags` = `flags`|32 WHERE `entry` IN (179117, 179365);
UPDATE `gameobject_template_addon` SET `flags` = `flags`|4 WHERE `entry` = 179115;

-- Fix Blackwing technicians spawn time
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `id1` = 13996;
