-- DB update 2025_09_06_03 -> 2025_09_06_04

-- Arzeth the Merciless (Charm, Fear, Root, Snare, Banish, Horror)
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` |1|16|64|1024|131072|8388608 WHERE (`entry` = 19354);

-- Illidari Dreadlord (Charm, Fear, Snare)
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` |1|16|1024 WHERE (`entry` = 21166);

-- Wrath Master (Charm, Snare)
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` |1|1024 WHERE (`entry` = 19005);

-- Arazzius the Cruel (Charm, Fear, Root, Snare, Stun, Freeze, Polymorph, Banish)
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` |1|16|64|1024|2048|4096|65536|131072 WHERE (`entry` = 19191);
