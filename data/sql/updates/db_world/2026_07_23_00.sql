-- DB update 2026_07_22_14 -> 2026_07_23_00
-- Flag 'The Lich King' (28765) whisper controller in the Scarlet Enclave as a trigger creature so it is invisible to players
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|128 WHERE `entry` = 28765;
