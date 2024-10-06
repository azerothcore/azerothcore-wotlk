--
UPDATE `broadcast_text_locale`
SET
    `FemaleText` = REGEXP_REPLACE(`MaleText`, '\\$g([^:]+):([^;]+);', '$2'),
    `MaleText` = REGEXP_REPLACE(`MaleText`, '\\$g([^:]+):([^;]+);', '$1')
WHERE
    `locale` IN ('esES', 'esMX') AND `MaleText` LIKE '%$g%';
