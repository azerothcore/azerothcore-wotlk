-- DB update 2026_02_25_10 -> 2026_02_25_11
--
UPDATE `gameobject_template_addon` SET `flags` = 16 WHERE (`entry` IN (185115, 185117, 185118));
