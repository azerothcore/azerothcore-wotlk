-- mod-branding Etch (#31): the premium, BoP cost resource "Essence" (§16.1/§16.2 -- the reserved third
-- resource type, now realized). Entry 190002 sits in the §16.4 reserved band, after Material (190000) and
-- Fragment (190001). bonding = 1 (Bind-on-Pickup) keeps the Etch cost a strictly personal grind, matched
-- to the BoP Etched item. "Essence" is a placeholder name. DELETE-before-INSERT, InnoDB-backed table.

DELETE FROM `item_template` WHERE `entry` = 190002;
INSERT INTO `item_template` (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `BuyPrice`, `SellPrice`, `InventoryType`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `stackable`, `bonding`, `Material`) VALUES
    (190002, 7, 5, 'Branding Essence', 41111, 4, 0, 1, 0, 0, 0, 0, 0, 1000, 1, 4);
