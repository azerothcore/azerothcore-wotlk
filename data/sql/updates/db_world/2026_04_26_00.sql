-- DB update 2026_04_25_04 -> 2026_04_26_00
DELETE FROM `smart_scripts`
WHERE `entryorguid` IN (2397400, 2397401, 2397402, 2397403)
  AND `source_type` = 9
  AND `id` = 1;
