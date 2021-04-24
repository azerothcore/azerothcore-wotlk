INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619236551391059700');

ALTER TABLE `npc_trainer`
	ADD COLUMN `ReqSpell` INT NOT NULL DEFAULT 0 AFTER `ReqSkillRank`;

-- 	Dragonscale Leatherworking
UPDATE `npc_trainer` SET `ReqSpell` = 10656 WHERE `SpellID` IN (35575, 35576, 35577, 35580, 35582, 35584, 36076, 36079, 10619, 10650, 24654, 24655);

-- Elemental Leatherworking
UPDATE `npc_trainer` SET `ReqSpell` = 10658 WHERE `SpellID` IN (10630, 10632, 35589, 35590, 35591, 36074, 36077);

-- Tribal Leatherworking
UPDATE `npc_trainer` SET `ReqSpell` = 10660 WHERE `SpellID` IN (10621, 10647, 35585, 35587, 35588, 36075, 36078);
