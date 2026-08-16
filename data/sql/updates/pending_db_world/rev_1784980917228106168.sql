UPDATE `creature_template` SET `minlevel` = 17, `maxlevel` = 17, `HealthModifier` = 2.507772, `type_flags` = 0, `unit_flags` = 8 WHERE `entry` = 2673;
UPDATE `creature_template` SET `minlevel` = 37, `maxlevel` = 37, `HealthModifier` = 2.281436, `type_flags` = 0, `unit_flags` = 8 WHERE `entry` = 2674;
UPDATE `creature_template` SET `minlevel` = 55, `maxlevel` = 55, `HealthModifier` = 2.0, `type_flags` = 0, `unit_flags` = 8 WHERE `entry` = 12426;

-- Mirror Image: adjust HealthModifier to match sniff (from 4023HP to 4203 HP)
UPDATE `creature_template` SET `HealthModifier` = 0.416964 WHERE `entry` = 31216;
