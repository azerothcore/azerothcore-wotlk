-- DB update 2022_07_12_00 -> 2022_07_12_01
--
/* Maintenance on ZG Entranceway mobs part 1 Unpooled */

/* these paths do not exist, the creatures do tho and belong where they end up without the pathing */
DELETE FROM `creature_addon` WHERE `guid` IN (49116, 49117, 49119);
DELETE FROM `waypoint_data` WHERE `id` IN (491160, 491170, 491190);
UPDATE `creature` SET `MovementType`=0 WHERE `guid` IN (49116, 49117, 49119);

-- Below comments are research notes

/* Trolls in front in Huts Can be Priests or Axe Throwers, outside huts are Axe Throwers */
UPDATE `creature` SET `id2`=11350 WHERE  `guid`=49115;
UPDATE `creature` SET `id2`=11350 WHERE  `guid`=49742;

/* All paired snakes can be either type, but there are some complexities on bigger packs.  Adder/Adder is slightly less common than the other combos, except when it's not.  Leaving it 50/50 is prolly fine on all 2 packs. */
UPDATE `creature` SET `id1`=11371 WHERE `guid` IN (49739, 49740, 49091, 49090, 49089, 49088);
UPDATE `creature` SET `id2`=11372 WHERE `guid` IN (49739, 49740, 49091, 49090, 49089, 49088);

/* (3) Bridge Entrance Patrol seen Axe/Priest and Axe/Axe */
UPDATE `creature` SET `id2`=11350 WHERE  `guid`=49752;
