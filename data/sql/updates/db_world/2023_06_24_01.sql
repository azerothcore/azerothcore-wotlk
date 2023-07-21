-- DB update 2023_06_24_00 -> 2023_06_24_01
-- Add extra flag 33554432 to several skeleton creatures in Auchenai Crypts to avoid chain pulling
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE (`entry` IN (18700, 20317, 18521, 20315, 18524, 20298));
