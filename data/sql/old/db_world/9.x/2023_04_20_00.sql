-- DB update 2023_04_19_34 -> 2023_04_20_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE `entry` IN (16523, 16594, 17083, 17420, 17694, 16507, 17462, 18404, 17993, 18421, 19486, 18422, 19557, 19505); -- Botanica & SHH
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE `entry` IN (20567, 20576, 20577, 20587, 20591, 20593, 20595, 21548, 21549, 21555, 21570, 21571, 21572, 21577); -- Botanica & SHH Heroics
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE `entry` = 13996; -- Blackwing Technician
UPDATE `creature_template` SET `flags_extra` = `flags_extra`&~33554432 WHERE `entry` = 12460; -- Blackwing Adds
UPDATE `creature_template` SET `flags_extra` = `flags_extra`&~33554432 WHERE `entry` = 11380; -- Jin'do the Hexxer
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE `entry` IN (14825, 14882, 14883); -- Jin'do the Hexxer Adds
