-- fix first aid trainer
UPDATE `creature_template` SET `npcflag` = 209 WHERE `entry` IN (18990,18991) And `npcflag` = 208; 
