INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623675094427536149');

-- Enables fear, bleed, horror effects
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~(16|16384|8388608) WHERE `entry` = 4952;
-- Disables death grip
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|32 WHERE `entry` = 4952;

-- Disables no_parry
UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~(2) WHERE `entry` = 4952;
-- Disables weapon skill gains
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|262144 WHERE `entry` = 4952;

UPDATE `creature_template` SET `ScriptName` = 'npc_training_dummy' WHERE `entry` = 4952;
