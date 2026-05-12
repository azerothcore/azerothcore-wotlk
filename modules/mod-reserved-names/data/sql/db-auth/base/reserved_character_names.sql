-- Reserved character names table (lives in acore_auth so it survives a
-- acore_characters wipe).
--
-- Populated before wipe with:
--   INSERT INTO acore_auth.reserved_character_names (name, account_id, original_guid, race, class, gender)
--   SELECT name, account, guid, race, class, gender
--   FROM acore_characters.characters
--   WHERE level >= 60
--   ON DUPLICATE KEY UPDATE
--     account_id    = VALUES(account_id),
--     original_guid = VALUES(original_guid),
--     race          = VALUES(race),
--     class         = VALUES(class),
--     gender        = VALUES(gender);

CREATE TABLE IF NOT EXISTS `reserved_character_names` (
  `name`          VARCHAR(12)      NOT NULL,
  `account_id`    INT UNSIGNED     NOT NULL,
  `original_guid` INT UNSIGNED     NULL,
  `race`          TINYINT UNSIGNED NULL,
  `class`         TINYINT UNSIGNED NULL,
  `gender`        TINYINT UNSIGNED NULL,
  `reserved_at`   TIMESTAMP        DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
