drop table if exists acore_world.`archetype	`;
CREATE TABLE acore_world.`archetype` (
  `allowableClass` int NOT NULL default '-1',
  `level` tinyint NOT NULL,
  `role` tinyint DEFAULT NULL,
  `id` int NOT NULL,
  `isSpell` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

INSERT INTO acore_world.archetype (allowableClass,`level`,`role`,id,isSpell) VALUES
	 (1106,1,0,500546,0),
	 (1131,1,0,600604,0),
	 (1488,1,0,600608,0),
	 (1059,1,0,600702,0),
	 (4,1,0,700821,0);


DELETE FROM acore_world.spell_script_names where spell_id in (500546, 600608);
INSERT INTO acore_world.spell_script_names (spell_id, ScriptName) VALUES(500546, 'spell_arch_mana_battery');
INSERT INTO acore_world.spell_script_names (spell_id, ScriptName) VALUES(600608, 'spell_arch_wild_magic');
