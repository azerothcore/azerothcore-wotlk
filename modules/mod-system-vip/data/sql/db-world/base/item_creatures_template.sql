-- === VIP item + creatures SQL (merged & cleaned) ===
-- Backup your DB before running.

START TRANSACTION;

-- Optional performance hints (uncomment if doing large imports)
-- /*!40000 ALTER TABLE `item_template` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `creature_template` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `creature_template_model` DISABLE KEYS */;

-- Remove any previous entries (safe idempotent cleanup)
DELETE FROM `item_template` WHERE `entry` = 44824;
DELETE FROM `creature_template` WHERE `entry` = 100001;
DELETE FROM `creature_template_model` WHERE `CreatureID` = 100001;
DELETE FROM `creature_template` WHERE `entry` = 100043;
DELETE FROM `creature_template_model` WHERE `CreatureID` = 100043;

-- Insert VIP item (clean SET-style insert)
INSERT INTO `item_template` SET
  `entry` = 44824,
  `class` = 15,
  `subclass` = 2,
  `SoundOverrideSubclass` = -1,
  `name` = 'Invocar Mascota Vip',
  `displayid` = 15798,
  `Quality` = 5,
  `Flags` = 0,
  `FlagsExtra` = 0,
  `BuyCount` = 1,
  `BuyPrice` = 0,
  `SellPrice` = 0,
  `InventoryType` = 0,
  `AllowableClass` = -1,
  `AllowableRace` = -1,
  `ItemLevel` = 0,
  `RequiredLevel` = 0,
  -- minimal field set (unused numeric fields left at defaults in DB)
  `armor` = 0,
  `delay` = 1000,
  `spellid_1` = 73835,
  `spelltrigger_1` = 0,
  `spellcharges_1` = 0,
  `spellppmRate_1` = 0,
  `spellcooldown_1` = -1,
  `spellcategory_1` = 0,
  `spellcategorycooldown_1` = -1,
  `bonding` = 0,
  `description` = '|cff0BF917Use: Summons your VIP pet, it has many benefits for you.|r',
  `Material` = 4,
  `sheath` = 0,
  `ScriptName` = 'SystemVipPocket',
  `VerifiedBuild` = 1;

-- Insert creature_template (100001) - Vip Vendor
INSERT INTO `creature_template` SET
  `entry` = 100001,
  `name` = 'Elemental',
  `subname` = 'Vip Vendor',
  `gossip_menu_id` = 0,
  `minlevel` = 80,
  `maxlevel` = 80,
  `exp` = 0,
  `faction` = 35,
  `npcflag` = 1,
  `speed_walk` = 1,
  `speed_run` = 1.14286,
  `detection_range` = 20,
  `scale` = 1,
  `unit_class` = 1,
  `ScriptName` = 'SystemVipVendor';

-- Creature model(s) for 100001
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
VALUES ('100001','0','1070','1.5','1',NULL);

-- Insert creature_template (100043) - Pet Vip
INSERT INTO `creature_template` SET
  `entry` = 100043,
  `name` = 'Pet Vip',
  `gossip_menu_id` = 0,
  `minlevel` = 1,
  `maxlevel` = 2,
  `exp` = 0,
  `faction` = 35,
  `npcflag` = 1,
  `speed_walk` = 1,
  `speed_run` = 1.42857,
  `detection_range` = 20,
  `scale` = 1,
  `unit_class` = 1,
  `movementId` = 144,
  `ScriptName` = 'SystemVipPet';

-- Creature model(s) for 100043 (multiple display variations)
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
  ('100043','0','14546','1','1','12340'),
  ('100043','1','14547','1','1','12340'),
  ('100043','2','14551','1','1','12340'),
  ('100043','3','14549','1','1','12340');

-- Optional performance hints (re-enable if disabled above)
-- /*!40000 ALTER TABLE `item_template` ENABLE KEYS */;
-- /*!40000 ALTER TABLE `creature_template` ENABLE KEYS */;
-- /*!40000 ALTER TABLE `creature_template_model` ENABLE KEYS */;

COMMIT;
