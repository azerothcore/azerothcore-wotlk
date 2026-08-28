-- Sets no XP flag for "Blockade Cannon" and "Blockade Pirate" from the quest "Break the Blockade"
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 64 WHERE `entry` IN (23771, 23755);
