-- Add Norah Rose quest giver and Black Rose starter rewards.

SET @QUEST_ALLIANCE := 900100;
SET @QUEST_HORDE := 900101;
SET @BAG := 900102;
SET @NORAH_HORDE := 900103;
SET @NORAH_ALLIANCE := 900104;
SET @CGUID := 900110;

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `ContainerSlots`, `bonding`,
     `Material`, `VerifiedBuild`)
VALUES
    (@BAG, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 26, 1,
     8, 0);

REPLACE INTO `creature_template`
    (`entry`, `name`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`,
     `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`,
     `detection_range`, `rank`, `DamageModifier`, `BaseAttackTime`,
     `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
     `unit_flags`, `unit_flags2`, `type`, `MovementType`, `HoverHeight`,
     `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RegenHealth`,
     `VerifiedBuild`)
VALUES
    (@NORAH_HORDE, 'Norah Rose', 20, 20, 0, 35, 2,
     1, 1.14286, 1, 1,
     20, 0, 1, 2000,
     2000, 1, 1, 1,
     0, 2048, 7, 0, 1,
     1, 1, 1, 1,
     0),
    (@NORAH_ALLIANCE, 'Norah Rose', 20, 20, 0, 35, 2,
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
    (@NORAH_HORDE, 0, 16695, 1, 1, 0),
    (@NORAH_ALLIANCE, 0, 14615, 1, 1, 0);

REPLACE INTO `creature`
    (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`,
     `position_x`, `position_y`, `position_z`, `orientation`,
     `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`,
     `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`,
     `CreateObject`, `Comment`)
VALUES
    (@CGUID + 0, @NORAH_HORDE, 1, 1, 1, 0,
     1566.3, -4396.58, 7.36, 3.316,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Orgrimmar'),
    (@CGUID + 1, @NORAH_HORDE, 0, 1, 1, 0,
     1553.8, 246, -43.1, 6.269,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Undercity'),
    (@CGUID + 2, @NORAH_HORDE, 1, 1, 1, 0,
     -1254.5, 67, 127.5, 0.747,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Thunder Bluff'),
    (@CGUID + 3, @NORAH_HORDE, 530, 1, 1, 0,
     9402.9, -7261.7, 14.19, 3.94,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Silvermoon'),
    (@CGUID + 4, @NORAH_ALLIANCE, 0, 1, 1, 0,
     -8875.28, 598, 93.5, 4.6,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Stormwind'),
    (@CGUID + 5, @NORAH_ALLIANCE, 1, 1, 1, 0,
     9948.4, 2491.7, 1317.1, 4.72,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Darnassus'),
    (@CGUID + 6, @NORAH_ALLIANCE, 0, 1, 1, 0,
     -4913.5, -976.3, 501.5, 2.09,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Ironforge'),
    (@CGUID + 7, @NORAH_ALLIANCE, 530, 1, 1, 0,
     -4006.3, -11846, 0.175, 4.693,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Exodar');

REPLACE INTO `quest_template`
    (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `RewardXPDifficulty`,
     `RewardMoney`, `RewardMoneyDifficulty`, `RewardItem1`, `RewardAmount1`,
     `RewardItem2`, `RewardAmount2`, `AllowableRaces`, `LogTitle`,
     `LogDescription`, `QuestDescription`, `QuestCompletionLog`,
     `VerifiedBuild`)
VALUES
    (@QUEST_ALLIANCE, 2, 20, 20, 1,
     50000, 0, @BAG, 1,
     44223, 1, 1101, 'The Black Rose',
     'Speak with Norah Rose to receive the Black Rose''s gift.',
     'The Black Rose has watched your steps with interest, $N. You have '
     'reached the point where the road opens before you.$B$BIf you are ready, '
     'accept this token of our regard: a satchel marked with the black rose, '
     'and a set of reins to carry you farther than your own feet alone.',
     'Return to Norah Rose.', 0),
    (@QUEST_HORDE, 2, 20, 20, 1,
     50000, 0, @BAG, 1,
     44224, 1, 690, 'The Black Rose',
     'Speak with Norah Rose to receive the Black Rose''s gift.',
     'The Black Rose has watched your steps with interest, $N. You have '
     'reached the point where the road opens before you.$B$BIf you are ready, '
     'accept this token of our regard: a satchel marked with the black rose, '
     'and a set of reins to carry you farther than your own feet alone.',
     'Return to Norah Rose.', 0);

REPLACE INTO `quest_template_addon` (`ID`, `SpecialFlags`)
VALUES
    (@QUEST_ALLIANCE, 0),
    (@QUEST_HORDE, 0);

REPLACE INTO `quest_request_items`
    (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`,
     `VerifiedBuild`)
VALUES
    (@QUEST_ALLIANCE, 1, 0,
     'Are you ready to accept the Black Rose''s gift?', 0),
    (@QUEST_HORDE, 1, 0,
     'Are you ready to accept the Black Rose''s gift?', 0);

REPLACE INTO `quest_offer_reward`
    (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`,
     `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`,
     `VerifiedBuild`)
VALUES
    (@QUEST_ALLIANCE, 1, 0, 0, 0, 0,
     0, 0, 0,
     'Carry the Black Rose with you, $N. May it mark the beginning of a '
     'longer road and a swifter ride.', 0),
    (@QUEST_HORDE, 1, 0, 0, 0, 0,
     0, 0, 0,
     'Carry the Black Rose with you, $N. May it mark the beginning of a '
     'longer road and a swifter ride.', 0);

REPLACE INTO `creature_queststarter` (`id`, `quest`)
VALUES
    (@NORAH_ALLIANCE, @QUEST_ALLIANCE),
    (@NORAH_HORDE, @QUEST_HORDE);

REPLACE INTO `creature_questender` (`id`, `quest`)
VALUES
    (@NORAH_ALLIANCE, @QUEST_ALLIANCE),
    (@NORAH_HORDE, @QUEST_HORDE);
