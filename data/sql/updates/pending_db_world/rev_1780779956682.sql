-- Earthgrab is a hostile root and should reveal stealthed targets.
UPDATE `spell_custom_attr` SET `attributes` = `attributes` & ~64 WHERE `spell_id` = 64695;
