-- DB update 2026_04_27_05 -> 2026_04_27_06
--
-- Low-level heroic DK action bar: replace Obliterate with Plague Strike
-- in character creation action defaults.

UPDATE `playercreateinfo_action`
SET `action` = 45462
WHERE `class` = 6
  AND `button` = 1
  AND `action` = 49020;
