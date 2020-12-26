INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609009225243254400');

UPDATE `gameobject` SET `spawntimesecs` = 2 WHERE `id` IN
(20691,  -- Cozzle's Footlocker
 20925,  -- Captain's Footlocker
181110,  -- Soaked Tome
181133,  -- Rathis Tomber's Supplies
181238,  -- Dented Chest
181239,  -- Worn Chest
182011,  -- Crate of Ingots
182804,  -- Mysteries of the Light
183050,  -- The Saga of Terokk
187980); -- First Aid Supplies

-- Night Elf Plans: An'daroth, An'owyn, Scrying on the Sin'dorei
UPDATE `gameobject` SET `spawntimesecs` = 5 WHERE `id` IN (181138,181139,181140);
-- Sealed Box (Investigate Tuurem), Dawn Runner Cargo/Warped Crates
UPDATE `gameobject` SET `spawntimesecs` = 60 WHERE `id` IN (182542,181626);

