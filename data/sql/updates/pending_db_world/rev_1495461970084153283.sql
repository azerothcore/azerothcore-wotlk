INSERT INTO version_db_world (`sql_rev`) VALUES ('1495461970084153283');

-- set Warbear Matriarch (NPC 29918) AI to PetAI
UPDATE `creature_template` SET `AIName`= 'PetAI', `mindmg`=1360, `maxdmg`=1840, `dmg_multiplier`=1 WHERE `entry`= 29918;

