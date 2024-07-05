-- DB update 2023_03_04_12 -> 2023_03_04_13
-- Too many friendly NPCs dealing damage can interfere with quest objective for killing Socrethar (Quest Credit is self-cast)
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|2097152 WHERE (`entry` = 20132);
