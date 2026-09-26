-- DB update 2026_08_20_02 -> 2026_08_20_03
-- Stillpine Ancestor Vark must address the player so that $n is resolved.
UPDATE `smart_scripts` SET `target_type` = 7 WHERE `entryorguid` = 1741000 AND `source_type` = 9 AND `id` = 4;
