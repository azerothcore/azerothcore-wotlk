-- DB update 2022_08_21_18 -> 2022_08_21_19
--

-- Immune to Taunt
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|256 WHERE `entry`=15509;

