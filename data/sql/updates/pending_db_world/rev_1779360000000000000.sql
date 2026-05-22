-- Add Rosy and Bag of the Black Rose upgrades.

SET @BAG_26 := 900102;
SET @BAG_28 := 900120;
SET @BAG_30 := 900121;
SET @BAG_32 := 900122;
SET @BAG_34 := 900123;
SET @BAG_36 := 900124;
SET @UPGRADE_28 := 900130;
SET @UPGRADE_30 := 900131;
SET @UPGRADE_32 := 900132;
SET @UPGRADE_34 := 900133;
SET @UPGRADE_36 := 900134;
SET @ROSY := 900140;
SET @CGUID := 900150;

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `ContainerSlots`, `bonding`,
     `Material`, `VerifiedBuild`)
VALUES
    (@BAG_28, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 28, 1,
     8, 0),
    (@BAG_30, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 30, 1,
     8, 0),
    (@BAG_32, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 32, 1,
     8, 0),
    (@BAG_34, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 34, 1,
     8, 0),
    (@BAG_36, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 36, 1,
     8, 0);

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `spellid_1`,
     `spelltrigger_1`, `spellcooldown_1`, `bonding`, `description`,
     `Material`, `ScriptName`, `VerifiedBuild`)
VALUES
    (@UPGRADE_28, 12, 0, -1, 'Black Rose Bag Upgrade I',
     8861, 1, 64, 1, 500, 0,
     0, -1, -1, 20,
     20, 1, 1, 74903,
     0, 1000, 1, 'Upgrades an empty 26-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_30, 12, 0, -1, 'Black Rose Bag Upgrade II',
     8861, 1, 64, 1, 50000, 0,
     0, -1, -1, 20,
     20, 1, 1, 74903,
     0, 1000, 1, 'Upgrades an empty 28-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_32, 12, 0, -1, 'Black Rose Bag Upgrade III',
     8861, 1, 64, 1, 500000, 0,
     0, -1, -1, 20,
     20, 1, 1, 74903,
     0, 1000, 1, 'Upgrades an empty 30-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_34, 12, 0, -1, 'Black Rose Bag Upgrade IV',
     8861, 1, 64, 1, 5000000, 0,
     0, -1, -1, 20,
     20, 1, 1, 74903,
     0, 1000, 1, 'Upgrades an empty 32-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_36, 12, 0, -1, 'Black Rose Bag Upgrade V',
     8861, 1, 64, 1, 500000000, 0,
     0, -1, -1, 20,
     20, 1, 1, 74903,
     0, 1000, 1, 'Upgrades an empty 34-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0);

REPLACE INTO `creature_template`
    (`entry`, `name`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`,
     `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`,
     `detection_range`, `rank`, `DamageModifier`, `BaseAttackTime`,
     `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
     `unit_flags`, `unit_flags2`, `type`, `MovementType`, `HoverHeight`,
     `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RegenHealth`,
     `VerifiedBuild`)
VALUES
    (@ROSY, 'Rosy', 20, 20, 0, 35, 128,
     1, 1.14286, 1, 1,
     20, 0, 1, 2000,
     2000, 1, 1, 1,
     0, 2048, 7, 0, 1,
     1, 1, 1, 1,
     0);

REPLACE INTO `creature_template_model`
    (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`,
     `Probability`, `VerifiedBuild`)
VALUES
    (@ROSY, 0, 617, 1, 1, 0);

REPLACE INTO `creature`
    (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`,
     `position_x`, `position_y`, `position_z`, `orientation`,
     `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`,
     `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`,
     `CreateObject`, `Comment`)
VALUES
    (@CGUID + 0, @ROSY, 1, 1, 1, 0,
     1567.5, -4395.4, 7.36, 3.316,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Orgrimmar'),
    (@CGUID + 1, @ROSY, 0, 1, 1, 0,
     1555, 247.2, -43.1, 6.269,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Undercity'),
    (@CGUID + 2, @ROSY, 1, 1, 1, 0,
     -1253.3, 68.2, 127.5, 0.747,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Thunder Bluff'),
    (@CGUID + 3, @ROSY, 530, 1, 1, 0,
     9404.1, -7260.5, 14.19, 3.94,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Silvermoon'),
    (@CGUID + 4, @ROSY, 0, 1, 1, 0,
     -8874.1, 599.2, 93.5, 4.6,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Stormwind'),
    (@CGUID + 5, @ROSY, 1, 1, 1, 0,
     9949.6, 2492.9, 1317.1, 4.72,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Darnassus'),
    (@CGUID + 6, @ROSY, 0, 1, 1, 0,
     -4912.3, -975.1, 501.5, 2.09,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Ironforge'),
    (@CGUID + 7, @ROSY, 530, 1, 1, 0,
     -4005.1, -11844.8, 0.175, 4.693,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Exodar');

REPLACE INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`,
     `VerifiedBuild`)
VALUES
    (@ROSY, 1, @UPGRADE_28, 0, 0, 0, 0),
    (@ROSY, 2, @UPGRADE_30, 0, 0, 0, 0),
    (@ROSY, 3, @UPGRADE_32, 0, 0, 0, 0),
    (@ROSY, 4, @UPGRADE_34, 0, 0, 0, 0),
    (@ROSY, 5, @UPGRADE_36, 0, 0, 0, 0);

REPLACE INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
     `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
     `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
     `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
    (23, @ROSY, @UPGRADE_28, 0,
     0, 2, 0,
     @BAG_26, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade I if the player has the 26-slot bag'),
    (23, @ROSY, @UPGRADE_30, 0,
     0, 2, 0,
     @BAG_28, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade II if the player has the 28-slot bag'),
    (23, @ROSY, @UPGRADE_32, 0,
     0, 2, 0,
     @BAG_30, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade III if the player has the 30-slot bag'),
    (23, @ROSY, @UPGRADE_34, 0,
     0, 2, 0,
     @BAG_32, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade IV if the player has the 32-slot bag'),
    (23, @ROSY, @UPGRADE_36, 0,
     0, 2, 0,
     @BAG_34, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade V if the player has the 34-slot bag');
