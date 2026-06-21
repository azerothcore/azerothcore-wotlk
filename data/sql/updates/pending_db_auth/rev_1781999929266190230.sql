-- Mastery account-unlock layer (design slice 6, §14).
-- Account-scoped so it gates expression on whichever account currently owns a character (anti-P2W).
-- One of the two dual keys: effective only when paired with an earned character_mastery level.
CREATE TABLE IF NOT EXISTS `account_mastery`
(
    `account` INT UNSIGNED NOT NULL COMMENT 'Account id',
    `mastery_id` TINYINT UNSIGNED NOT NULL COMMENT 'MasterySystem enum value (0=Gathering,1=Crafting)',
    `unlocked` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '1 if the account has unlocked this mastery',
    `unlocked_at` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix time the mastery was unlocked',
    PRIMARY KEY (`account`, `mastery_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
