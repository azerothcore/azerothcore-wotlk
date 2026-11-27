-- DB update 2026_11_26_00 -> 2026_11_27_00
--
UPDATE `character_spell_cooldown` SET `category` = 0 WHERE `category` IS NULL;
ALTER TABLE `character_spell_cooldown`
    CHANGE COLUMN `category` `categoryId` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `time`,
    ADD COLUMN `categoryEnd` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `categoryId`,
    DROP COLUMN `needSend`;
UPDATE `character_spell_cooldown` SET `categoryEnd` = `time` WHERE `categoryId` <> 0;

UPDATE `pet_spell_cooldown` SET `category` = 0 WHERE `category` IS NULL;
ALTER TABLE `pet_spell_cooldown`
    CHANGE COLUMN `category` `categoryId` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `time`,
    ADD COLUMN `categoryEnd` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `categoryId`;
UPDATE `pet_spell_cooldown` SET `categoryEnd` = `time` WHERE `categoryId` <> 0;
