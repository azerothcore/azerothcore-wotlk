--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x00200000 WHERE `entry` IN (29618,29619);
UPDATE `smart_scripts` SET `target_type`=23 WHERE `entryorguid`=29475 AND `source_type`=0 AND `id` IN (2,3);
