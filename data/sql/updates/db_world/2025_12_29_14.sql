-- DB update 2025_12_29_13 -> 2025_12_29_14
--
-- Update to rehash for reapply
-- Truesilver gauntlets require skill 225, not 245
UPDATE `trainer_spell` SET `ReqSkillRank`=225 WHERE `TrainerId`=124 AND `SpellId`=9954;

-- Woo Ping polearm training requires level 20
UPDATE `trainer_spell` SET `ReqLevel`=20 WHERE `TrainerId`=53 AND `SpellId`=200;

-- Guvan should train priest spells past level 6
UPDATE `creature_default_trainer` SET `TrainerId`=11 WHERE `CreatureId`=16502;

-- Portal to Theramore and Stonard should be trainable at 35
UPDATE `trainer_spell` SET `ReqLevel`=35 WHERE `TrainerId` IN (28, 29) AND `SpellId` IN (49361, 49360);

-- Add missing ReqAbility1 for some Gnomish and Goblin Engineering spells
UPDATE `trainer_spell` SET `ReqAbility1`=20219 WHERE `SpellId` IN (12759, 12895, 12897, 12899, 12902, 12903, 12905, 12906, 12907, 30568, 30570);
UPDATE `trainer_spell` SET `ReqAbility1`=20222 WHERE `SpellId` IN (8895, 12715, 12717, 12718, 12754, 12755, 12758, 12760, 12908, 30558, 30560);

-- Shattrath Bookshelves should not train Northrend recipes
UPDATE `creature_default_trainer` SET `TrainerId`=58  WHERE `CreatureId`=33609;
UPDATE `creature_default_trainer` SET `TrainerId`=66  WHERE `CreatureId`=33608;
UPDATE `creature_default_trainer` SET `TrainerId`=70  WHERE `CreatureId`=33616;
UPDATE `creature_default_trainer` SET `TrainerId`=112  WHERE `CreatureId`=33614;
UPDATE `creature_default_trainer` SET `TrainerId`=79  WHERE `CreatureId`=33617;
UPDATE `creature_default_trainer` SET `TrainerId`=120  WHERE `CreatureId`=33615;
UPDATE `creature_default_trainer` SET `TrainerId`=95  WHERE `CreatureId`=33610;
UPDATE `creature_default_trainer` SET `TrainerId`=91  WHERE `CreatureId`=33612;
UPDATE `creature_default_trainer` SET `TrainerId`=62  WHERE `CreatureId`=33611;
UPDATE `creature_default_trainer` SET `TrainerId`=73  WHERE `CreatureId`=33613;
UPDATE `creature_default_trainer` SET `TrainerId`=101  WHERE `CreatureId`=33618;
UPDATE `creature_default_trainer` SET `TrainerId`=77 WHERE `CreatureId`=33619;
UPDATE `creature_default_trainer` SET `TrainerId`=99 WHERE `CreatureId`=33623;
UPDATE `creature_default_trainer` SET `TrainerId`=83 WHERE `CreatureId`=33621;

-- Hamanar Shattrath Jewelcrafting trainer should not be able to learn grand master jewelcrafter.
UPDATE `creature_default_trainer` SET `TrainerId`=112 WHERE `CreatureId`=19063;

-- make Flying Carpet available from TBC Tailoring trainers
DELETE FROM `trainer_spell` WHERE `TrainerId`=73 AND `SpellId` = 60969;
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(73, 60969, 105000, 197, 300, 34090, 0, 0, 0, 0);
