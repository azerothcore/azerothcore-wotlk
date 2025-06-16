-- Set Distract immunity to Molten War Golem
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask` | (8|64|1024) WHERE `entry` = 8908;
