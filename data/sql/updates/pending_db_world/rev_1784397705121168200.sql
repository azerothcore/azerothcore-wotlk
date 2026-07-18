-- Algalon the Observer: melee damage retuned to match Wrath Classic log data
-- and original-era on-plate values (~27k MH / ~15k OH per second on 25-man)
UPDATE `creature_template` SET `DamageModifier` = 190 WHERE `entry` = 32871;
UPDATE `creature_template` SET `DamageModifier` = 285 WHERE `entry` = 33070;
