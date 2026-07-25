-- Guardian summons now honour creature_template.DamageModifier (previously ignored).
-- These guardians get their weapon damage from hand-tuned formulas in Guardian::InitStatsForLevel,
-- so their template modifier must stay neutral to avoid double-scaling.
-- 15352 = Greater Earth Elemental, 19833 = Venomous Snake, 19921 = Viper
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` IN (15352, 19833, 19921);
