-- DB update 2026_09_18_00 -> 2026_09_20_00
-- Freya's Gift pays one emblem plus one per Elder left alive to empower her, so the encounter
-- pays four either way once the Elders killed early are counted. On top of that the chests kept
-- a second, pre-3.3 emblem reference, which paid up to four more: with one Elder alive the
-- 25-man chest handed out six emblems, twice what full hard mode pays.
DELETE FROM `gameobject_loot_template` WHERE `Entry` IN (26959, 26960, 26961, 26962, 27078, 27079, 27080, 27081) AND `Reference` = 34349;

-- The remaining rows already scale one to three; only the three-Elder chests are short.
-- Chest by Elders left alive: 26961/26959/27080/27078 for 10-man, 26962/26960/27081/27079 for 25-man.
UPDATE `gameobject_loot_template` SET `MinCount` = 4, `MaxCount` = 4 WHERE `Entry` IN (27078, 27079) AND `Item` = 47241;
