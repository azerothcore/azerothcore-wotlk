-- DB update 2023_02_27_02 -> 2023_02_27_03
--

UPDATE `creature_template` SET `unit_flags`=`unit_flags`|536871680, `unit_flags2`=`unit_flags2`|2048 WHERE `entry` = 18035;

UPDATE `creature_template_addon` SET `bytes1` = 0, `bytes2` = 0, `auras` = '29266' WHERE `Entry` = 18035;
