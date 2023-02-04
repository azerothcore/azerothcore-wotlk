-- DB update 2022_11_03_08 -> 2022_11_04_00
--
SET @FACTION_BOTH := 6;
UPDATE `areatrigger_tavern` SET `faction` = @FACTION_BOTH WHERE `id` = 862;
