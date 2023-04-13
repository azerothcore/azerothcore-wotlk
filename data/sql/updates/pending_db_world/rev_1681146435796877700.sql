-- Reset Scourgelord Tyrannus 
UPDATE `creature_template` SET `flags_extra` = `flags_extra` &~ 2147483648 WHERE `entry` IN (36658);
