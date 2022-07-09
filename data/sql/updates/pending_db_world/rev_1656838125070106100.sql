--
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|4 WHERE `entry`=30403;
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|512 WHERE `entryorguid`=3040300 AND `source_type`=9;
