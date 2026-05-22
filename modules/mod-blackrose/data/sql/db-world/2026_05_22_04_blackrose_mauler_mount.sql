-- Black Rose Mauler mount reward.

SET @QUEST_ALLIANCE := 900100;
SET @QUEST_HORDE := 900101;
SET @BLACK_ROSE_MAULER_REINS := 900106;
SET @BLACK_ROSE_MAULER_MOUNT := 900903;
SET @BLACK_ROSE_MAULER_DISPLAY_ID := 0;

REPLACE INTO `spell_dbc`
    (`ID`, `Attributes`, `CastingTimeIndex`, `DurationIndex`, `RangeIndex`,
     `Effect_1`, `EffectDieSides_1`, `EffectBasePoints_1`,
     `ImplicitTargetA_1`, `EffectAura_1`, `EffectMiscValue_1`,
     `SpellIconID`, `ActiveIconID`, `Name_Lang_enUS`, `Name_Lang_Mask`,
     `Description_Lang_enUS`, `Description_Lang_Mask`,
     `AuraDescription_Lang_enUS`, `AuraDescription_Lang_Mask`, `SchoolMask`)
VALUES
    (@BLACK_ROSE_MAULER_MOUNT, 0, 1, 21, 1,
     6, 1, 59,
     1, 78, @BLACK_ROSE_MAULER_DISPLAY_ID,
     0, 0, 'Black Rose Mauler', 1,
     'Summons and dismisses a rideable Black Rose Mauler.', 1,
     'Mounted.', 1, 1);

REPLACE INTO `skilllineability_dbc`
    (`ID`, `SkillLine`, `Spell`, `RaceMask`, `ClassMask`, `ExcludeRace`,
     `ExcludeClass`, `MinSkillLineRank`, `SupercededBySpell`, `AcquireMethod`,
     `TrivialSkillLineRankHigh`, `TrivialSkillLineRankLow`,
     `CharacterPoints_1`, `CharacterPoints_2`)
VALUES
    (@BLACK_ROSE_MAULER_MOUNT, 777, @BLACK_ROSE_MAULER_MOUNT, 0, 0, 0,
     0, 0, 0, 0,
     0, 0,
     0, 0);

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `maxcount`,
     `stackable`, `spellid_1`, `spelltrigger_1`, `spellcooldown_1`,
     `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`,
     `spelltrigger_2`, `spellcooldown_2`, `bonding`, `description`,
     `Material`, `RequiredDisenchantSkill`, `VerifiedBuild`)
VALUES
    (@BLACK_ROSE_MAULER_REINS, 15, 5, -1, 'Reins of the Black Rose Mauler',
     23606, 4, 1, 0, 0,
     0, -1, -1, 20,
     20, 762, 75, 1,
     1, 55884, 0, -1,
     330, 3000, @BLACK_ROSE_MAULER_MOUNT,
     6, 0, 1, 'Teaches you how to summon this mount.',
     -1, -1, 0);

UPDATE `quest_template` SET `RewardItem2` = @BLACK_ROSE_MAULER_REINS WHERE `ID` IN (@QUEST_ALLIANCE, @QUEST_HORDE);
