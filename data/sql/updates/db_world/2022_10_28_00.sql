-- DB update 2022_10_26_01 -> 2022_10_28_00
--

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|256 WHERE entry IN (
15517, -- Ouro
15275, -- Emperor Vek'nilash
15276); -- Emperor Vek'lor

