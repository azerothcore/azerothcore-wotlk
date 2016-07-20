
-- Event start
REPLACE INTO game_event VALUES(7, '2015-02-16 01:01:00', '2020-12-31 06:00:00', 525600, 27360, 327, 'Lunar Festival', 0);

-- Proto fixes
UPDATE creature_template SET AIName="SmartAI" WHERE entry=15895;
DELETE FROM smart_scripts WHERE entryorguid IN(15895) AND source_type=0;
INSERT INTO smart_scripts VALUES(15895, 0, 0, 0, 62, 0, 100, 0, 6918, 1, 0, 0, 11, 26375, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast Spell On gossip");
UPDATE gossip_menu_option SET id=1 WHERE menu_id=6918 AND id=0;

-- Spawn fixes
UPDATE creature SET position_z=335.5 WHERE id=15603;

-- Greater Moonlight
DELETE FROM gameobject WHERE id=180867;
REPLACE INTO gameobject VALUES (241000, 180867, 0, 1, 1, -4663, -956, 500, 4.93299, 0, 0, 0.624974, -0.780646, 300, 0, 1, 0);
REPLACE INTO gameobject VALUES (241001, 180867, 1, 1, 1, 7581.01, -2225.35, 472.64, 1.80877, 0, 0, 0.786045, 0.618169, 300, 0, 1, 0);
REPLACE INTO gameobject VALUES (241002, 180867, 1, 1, 1, 10148.4, 2600.6, 1330.83, 1.43674, 0, 0, 0.658158, 0.75288, 300, 0, 1, 0);
REPLACE INTO gameobject VALUES (241003, 180867, 0, 1, 1, 1647, 243, 62, 3.08161, 0, 0, 0.99955, 0.0299868, 300, 0, 1, 0);
REPLACE INTO gameobject VALUES (241004, 180867, 1, 1, 1, 1983, -4255, 32, 3.4316, 0, 0, 0.989505, -0.144496, 300, 0, 1, 0);
REPLACE INTO gameobject VALUES (241005, 180867, 1, 1, 1, -1031, -230, 160, 5.52695, 0, 0, 0.369172, -0.929361, 300, 0, 1, 0);
REPLACE INTO gameobject VALUES (241006, 180867, 0, 1, 1, -8748.9, 1074.2, 90.5, 4.97556, 0, 0, 0.608217, -0.793771, 300, 0, 1, 0);
REPLACE INTO gameobject VALUES (241007, 180867, 571, 1, 1, 5787.11, 637.776, 647.874, 0.537298, 0, 0, 0.265429, 0.96413, 300, 0, 1, 0);
REPLACE INTO gameobject VALUES (241008, 180867, 530, 1, 1, 9478.25, -7298.36, 14.3593, 0.871978, 0, 0, 0.422307, 0.906453, 300, 0, 1, 0);
REPLACE INTO gameobject VALUES (241009, 180867, 530, 1, 1, -4008.01, -11839.2, 0.175498, 4.57102, 0, 0, 0.755281, -0.655401, 300, 0, 1, 0);
REPLACE INTO game_event_gameobject VALUES(7, 241000),(7, 241001),(7, 241002),(7, 241003),(7, 241004),(7, 241005),(7, 241006),(7, 241007),(7, 241008),(7, 241009);

-- Omen
DELETE FROM spell_scripts WHERE id=26393;
REPLACE INTO creature_template VALUES (15467, 0, 0, 0, 0, 0, 15879, 0, 0, 0, 'Omen', '', NULL, 0, 83, 83, 2, 14, 0, 1.2, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 3, 44, 15467, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 400, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 617299803, 0, 'npc_omen', 12340);
REPLACE INTO creature_template VALUES (15902, 0, 0, 0, 0, 0, 15880, 0, 0, 0, 'Giant Spotlight', '', NULL, 0, 1, 1, 0, 35, 0, 1.2, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_giant_spotlight', 12340);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(26393);
INSERT INTO conditions VALUES(13, 3, 26393, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Elunes Blessing');
INSERT INTO conditions VALUES(13, 3, 26393, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Elunes Blessing');
DELETE FROM spell_linked_spell WHERE spell_trigger=26393;
INSERT INTO spell_linked_spell VALUES(26393, 26394, 1, "Elune's Blessing");
