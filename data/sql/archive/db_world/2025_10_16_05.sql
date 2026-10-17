-- DB update 2025_10_16_04 -> 2025_10_16_05

-- Fire Immunity (Unbound Firestorm N/H)
UPDATE `creature_template` SET `spell_school_immune_mask` = `spell_school_immune_mask` |4 WHERE (`entry` IN (28584, 30983));

-- Nature Immunity (Slag H, Storming Vortex N/H, Cyclone H)
UPDATE `creature_template` SET `spell_school_immune_mask` = `spell_school_immune_mask` |8 WHERE (`entry` IN (28547, 30970, 30979, 30965));
