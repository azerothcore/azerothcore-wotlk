-- DB update 2022_09_03_03 -> 2022_09_03_04
--
UPDATE `creature_template` SET `type_flags`=`type_flags`|0x00001000 WHERE `entry` IN (15471,15473);
