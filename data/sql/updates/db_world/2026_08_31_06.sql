-- DB update 2026_08_31_05 -> 2026_08_31_06
--
-- Ulduar: Salvaged Chopper - swap "Grab Pyrite" (67372) for "Eject Passenger" (67393)
-- while the rear seat is occupied.
-- 34045 (25-man) inherits ScriptName from its difficulty_entry_1 parent 33062.
UPDATE `creature_template` SET `ScriptName`='npc_salvaged_chopper' WHERE `entry`=33062;
