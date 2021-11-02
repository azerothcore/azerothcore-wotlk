INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635460529340435632');

-- Fix quest for beached turtles Darkshore
UPDATE `gameobject_queststarter` SET `quest`=4728 WHERE `id`=175226;
UPDATE `gameobject_queststarter` SET `quest`=4730 WHERE `id`=175227;
UPDATE `gameobject_queststarter` SET `quest`=4733 WHERE `id`=175230;
UPDATE `gameobject_queststarter` SET `quest`=4723 WHERE `id`=175233;
UPDATE `gameobject_queststarter` SET `quest`=4722 WHERE `id`=176190;
UPDATE `gameobject_queststarter` SET `quest`=4732 WHERE `id`=176191;
UPDATE `gameobject_queststarter` SET `quest`=4727 WHERE `id`=176196;
UPDATE `gameobject_queststarter` SET `quest`=4725 WHERE `id`=176197;
UPDATE `gameobject_queststarter` SET `quest`=4731 WHERE `id`=176198;
