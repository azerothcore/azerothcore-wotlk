-- Freya: Detonating Lasher (32918/33399) CC-able like TC/retail (was -273).
UPDATE `creature_template` SET `CreatureImmunitiesId` = 0 WHERE `entry` IN (32918, 33399);
