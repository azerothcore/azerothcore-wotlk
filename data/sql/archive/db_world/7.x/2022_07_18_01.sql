-- DB update 2022_07_18_00 -> 2022_07_18_01
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |64 WHERE (`entry` = 10161);
