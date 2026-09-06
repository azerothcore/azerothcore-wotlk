-- DB update 2025_12_27_05 -> 2025_12_28_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|67108864 WHERE (`entry` IN (23953, 30748));
