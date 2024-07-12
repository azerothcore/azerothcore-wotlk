UPDATE `creature_template`   SET `speed_walk`     = 1.2                                        WHERE `entry`     IN (17895, 17897, 17898, 17899, 17905, 17916); -- Swim speed = 4.72221994400024414, flight speed = 7
UPDATE `creature_template`   SET `speed_walk`     = 1.6                                        WHERE `entry`     IN (17906, 17907, 17908);
UPDATE `creature_template`   SET `speed_run`      = 1.428571428571429                          WHERE `entry`     IN (17895, 17897, 17898, 17899, 17905, 17916);
UPDATE `creature_template`   SET `speed_run`      = 1.714285714285714                          WHERE `entry`     IN (17906, 17908);
UPDATE `creature_template`   SET `speed_run`      = 2.571428571428571                          WHERE `entry`     =  17907;
UPDATE `creature_template`   SET `BaseAttackTime` = 2000                                       WHERE `entry`     IN (17895, 17897, 17898, 17899, 17905, 17906, 17907, 17908, 17916);
UPDATE `creature_model_info` SET `BoundingRadius` = 0.524999976158142089, `CombatReach` = 15   WHERE `DisplayID` =  16919;
UPDATE `creature_model_info` SET `BoundingRadius` = 0.520500004291534423, `CombatReach` = 2.25 WHERE `DisplayID` =  17321;
UPDATE `creature_model_info` SET `BoundingRadius` = 0.458999991416931152, `CombatReach` = 2.25 WHERE `DisplayID` =  17537;
