INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626707176333165500');

# This sets all guards, royal guards and special NPCs in capitals to level 60 values
# Special NPCs: Scout Stronghand etc are patrolling NPCs that have 80 values, Marcus Jonathan is at the entrance of Stormwind, the last 3 were added in TBC.
# Orgrimmar Grunt, Bluffwatcher, Silvermoon City Guardian, Arcane Guardian, Stormwind City Guard, Ironforge Guard, , Darnassus Sentinel, Sentinel Stillbough, Exodar Peacekeeper
UPDATE `creature_template` SET `minlevel` = 55,`maxlevel` = 55,`HealthModifier` = 1 WHERE `entry` IN (3296, 3084, 16222, 18103, 68, 5595, 4262, 36481, 16733);

# Kor'kron Elite, Royal Dreadguard, Royal Guard, Kor'kron Overseer, Honor Guard, Stormwind Royal Guard, Shield of Velen
UPDATE `creature_template` SET `minlevel` = 60,`maxlevel` = 60,`HealthModifier` = 1.2259 WHERE `entry` IN (14304, 13839, 20672,  1756, 20674);

# Special NPCs: Scout Stronghand, Officer Brady, Officer Jaxon, Huntress Skymane, Dark Ranger Anya, Dark Ranger Cyndia
UPDATE `creature_template` SET `minlevel` = 60,`maxlevel` = 60, `HealthModifier` = 1.83885  WHERE `entry` IN (14375, 14439, 14423, 14378, 36225, 36226);

# General Marcus Jonathan
UPDATE `creature_template` SET `minlevel` = 62,`maxlevel` = 62, `HealthModifier` = 10 WHERE `entry` = 466;

# Liedel the Just, Halduron Brightwing, Grand Magister Rommath
UPDATE `creature_template` SET `minlevel` = 62,`maxlevel` = 62 WHERE `entry` IN (34986, 16801, 16800);

