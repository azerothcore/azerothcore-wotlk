INSERT INTO version_db_world (`sql_rev`) VALUES ('1518285097709086000');

-- Evilpriest #0001
-- Removed MECHANIC_INTERRUPT flag from Lady Malande/High Nethermancer Zerevor (Black Temple) 

UPDATE `creature_template` SET `mechanic_immune_mask` = '617299839' WHERE (`entry`='22951');
UPDATE `creature_template` SET `mechanic_immune_mask` = '617299839' WHERE (`entry`='22950')
