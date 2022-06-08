-- Adjust drop rate of Ritual salve to 72% (based by a sniffer with 325 kills)
UPDATE `creature_loot_template` SET `Chance` = 72 WHERE `Entry` = 2953 AND `Item` = 6634;
