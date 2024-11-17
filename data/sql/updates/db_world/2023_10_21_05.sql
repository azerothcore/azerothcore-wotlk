-- DB update 2023_10_21_04 -> 2023_10_21_05
--
ALTER TABLE `spell_cooldown_overrides`
	ADD COLUMN `Comment` TEXT;

UPDATE `spell_cooldown_overrides` SET `Comment`='Karazhan Chest - Heroism' WHERE `Id`=37471;
UPDATE `spell_cooldown_overrides` SET `Comment`='Karazhan Chest - Bloodlust' WHERE `Id`=37472;
UPDATE `spell_cooldown_overrides` SET `Comment`='Fel Reaver Sentinel - Turbo Boost' WHERE `Id`=37920;
UPDATE `spell_cooldown_overrides` SET `Comment`='Fel Reaver Sentinel - World Breaker' WHERE `Id`=38006;
UPDATE `spell_cooldown_overrides` SET `Comment`='Fel Reaver Sentinel - Sonic Boom' WHERE `Id`=38052;
UPDATE `spell_cooldown_overrides` SET `Comment`='Fel Reaver Sentinel - Destroy Deathforged Infernal' WHERE `Id`=38055;
