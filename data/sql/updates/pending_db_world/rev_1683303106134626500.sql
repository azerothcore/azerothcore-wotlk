--
-- Remove ability from creature that doesn't exist
DELETE FROM `creature_template_spell` WHERE  `CreatureID`=601 AND `Index`=0;
