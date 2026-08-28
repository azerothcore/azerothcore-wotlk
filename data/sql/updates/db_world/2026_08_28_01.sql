-- DB update 2026_08_28_00 -> 2026_08_28_01
-- Guardian of Yogg-Saron: the 25-man Shadow Nova (65209) entry-targeted effect must hit other
-- Guardians (33136) like its 10-man variant (62714) does since 2026_08_03_03. Its condition still
-- targeted Sara (33134), dealing her a second 25k per Guardian on top of the dedicated 65719 nova.
UPDATE `conditions` SET `ConditionValue2` = 33136 WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 2) AND (`SourceEntry` = 65209) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 33134) AND (`ConditionValue3` = 0);

-- Sara is friendly in phase 1 and thus never in combat, so out-of-combat regen undoes the
-- Guardians' Shadow Nova damage. Disable health regen like Yogg-Saron (33288); the script
-- restores her to full health on reset and on the phase 2 transformation instead.
UPDATE `creature_template` SET `RegenHealth` = 0 WHERE `entry` IN (33134, 34332);
