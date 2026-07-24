-- Feral Defender melee was calibrated for physical school mitigated by armor,
-- but it deals shadow damage and Feral Essence multiplies it by up to 5.
UPDATE `creature_template` SET `DamageModifier` = 2.6 WHERE `entry` = 34035;
UPDATE `creature_template` SET `DamageModifier` = 5.2 WHERE `entry` = 34171;
