-- DB update 2022_10_17_02 -> 2022_10_18_00
UPDATE `item_template` SET `Flags`=`Flags`&~2048 WHERE `entry` = 17962;
