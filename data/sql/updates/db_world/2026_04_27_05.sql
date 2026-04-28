-- DB update 2026_04_27_04 -> 2026_04_27_05
--
-- Low-level heroic Death Knights: do not auto-cast Blood Presence on first login
-- (starter spellbook is handled in core: Obliterate + passives only).

DELETE FROM `playercreateinfo_cast_spell`
WHERE `classMask` = 32 AND `spell` = 48266;
