-- Hodir despawns on evade and respawns with his helpers; boss_hodir restores the shattered Rare Cache at that point
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x80000000 WHERE `entry` IN (32845, 32846);
