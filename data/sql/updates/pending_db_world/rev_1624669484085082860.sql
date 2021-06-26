INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624669484085082860');

-- Despawn the summoned creatures/corpses 5 minutes after being killed instead of 1 minute after not being in combat.
UPDATE  `creature_summon_groups` SET `summonType`=6, `summonTime`=300000 WHERE `summonerId` IN (21118, 21119, 21120, 21121);
