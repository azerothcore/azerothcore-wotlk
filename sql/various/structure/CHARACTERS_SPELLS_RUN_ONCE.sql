ALTER TABLE character_spell DROP COLUMN `active`;
ALTER TABLE character_spell DROP COLUMN `disabled`;
ALTER TABLE character_spell ADD `specMask` tinyint(3) unsigned NOT NULL DEFAULT 255;

TRUNCATE TABLE character_talent;
TRUNCATE TABLE character_aura;
ALTER TABLE character_talent CHANGE `spec` `specMask` tinyint(3) unsigned NOT NULL DEFAULT 0;

UPDATE characters SET speccount=1 WHERE speccount=0;

