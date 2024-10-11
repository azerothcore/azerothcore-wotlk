-- DB update 2022_12_22_12 -> 2022_12_22_13
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE (`entry` = 21095);
