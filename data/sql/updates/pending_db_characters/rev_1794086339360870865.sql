--
-- The cooldown of a spell granted by a use-spell item enchantment belongs to the item entry that grants it, so
-- two different items granting that spell can hold its cooldown at the same time.
-- `character_spell_cooldown` therefore has to key a row by the item as well as by the spell.
-- Reversal: delete the rows sharing (guid, spell), then
-- ALTER TABLE `character_spell_cooldown` DROP PRIMARY KEY, ADD PRIMARY KEY (`guid`, `spell`);
--
ALTER TABLE `character_spell_cooldown` DROP PRIMARY KEY, ADD PRIMARY KEY (`guid`, `spell`, `item`);
