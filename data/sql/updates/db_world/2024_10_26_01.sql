-- DB update 2024_10_26_00 -> 2024_10_26_01
DELETE FROM creature_loot_template 
WHERE reference IN (1011415, 1011516) 
AND entry IN (3276, 3277);
