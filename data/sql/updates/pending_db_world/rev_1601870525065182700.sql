INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601981411342865100');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

-- These are added from the script now
DELETE FROM `creature` WHERE `guid` IN (137507,137508);

UPDATE `creature_template` SET `InhabitType`=4 WHERE  `entry`=33779;

UPDATE `creature` SET `phaseMask`=1 WHERE  `guid`=137509;

-- These are added from the script now
DELETE FROM `creature` where `id` = 33620;
UPDATE `creature_template` SET `ScriptName`='npc_goran_steelbreaker' WHERE  `entry`=33622;

-- These are added from the script now
DELETE FROM `creature` where `guid` IN (136525,136528);

-- Remove the modelid from Brann Bronzebeard radio, this modelid is not consistent with Brann's modelid
UPDATE `creature_template` SET `modelid1` = 0 WHERE `entry` IN (34054); -- 26353 old modelid

-- Add the script to the 48310 id spell
DELETE FROM `spell_script_names` WHERE `spell_id`=48310;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (48310, 'spell_transitus_shield_beam');