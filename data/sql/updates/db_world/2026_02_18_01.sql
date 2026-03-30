-- DB update 2026_02_18_00 -> 2026_02_18_01
-- QAston Proc System - Base spell_proc entries
-- Port from TrinityCore QAston proc system commits

-- Add DisableEffectsMask column to spell_proc table if it doesn't exist
SET @column_exists = (SELECT 1 FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'spell_proc' AND `COLUMN_NAME` = 'DisableEffectsMask' LIMIT 1);
SET @sql = IF(@column_exists IS NULL, 'ALTER TABLE `spell_proc` ADD COLUMN `DisableEffectsMask` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `AttributesMask`', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Charge drop on spell cast
DELETE FROM `spell_proc` WHERE `SpellId` IN (17941, 18820, 22008, 28200, 32216, 34477, 34936, 44401, 48108, 51124, 54741, 57761, 64823);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(17941,   0,  5, 0x00000001, 0x00000000, 0x00000000,   65536, 0x1, 0x1,     0, 0x0,  0,   0,      0, 1), -- Shadow Trance
(18820,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x7, 0x1,     0, 0x0,  0,   0,      0, 1), -- Insight
(22008,   0,  3, 0x61400035, 0x00000000, 0x00000000,   69632, 0x5, 0x1,     0, 0x0,  0,   0,      0, 1), -- Netherwind Focus
(28200,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x3, 0x1,     0, 0x0,  0,   0,      0, 6), -- Ascendance
(32216,   0,  4, 0x00000000, 0x00000100, 0x00000000,      16, 0x1, 0x4,     0, 0x0,  0,   0,      0, 1), -- Victorious (drop charge on Victory rush cast)
(34477,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x5, 0x2,     0, 0x0,  0,   0,      0, 1), -- Misdirection
(34936,   0,  5, 0x00000001, 0x00000040, 0x00000000,   65536, 0x1, 0x1,     0, 0x8,  0,   0,      0, 1), -- Backlash
(44401,   0,  3, 0x00000800, 0x00000000, 0x00000000,    4096, 0x5, 0x1,     0, 0x8,  0,   0,      0, 1), -- Missile Barrage
(48108,   0,  3, 0x00400000, 0x00000000, 0x00000000,   65536, 0x1, 0x1,     0, 0x8,  0,   0,      0, 1), -- Hot Streak
(51124,   0, 15, 0x00000002, 0x00000006, 0x00000000,   65552, 0x1, 0x2,     0, 0x8,  0,   0,      0, 1), -- Killing Machine
(54741,   0,  3, 0x00000004, 0x00000000, 0x00000000,   65536, 0x5, 0x1,     0, 0x0,  0,   0,      0, 1), -- Firestarter
(57761,   0,  3, 0x00000001, 0x00001000, 0x00000000,   65536, 0x1, 0x1,     0, 0x8,  0,   0,      0, 1), -- Fireball!
(64823,   0,  7, 0x00000004, 0x00000000, 0x00000000,   65536, 0x1, 0x1,     0, 0x0,  0,   0,      0, 1); -- Elune's Wrath
-- Port procs from spell_proc_event table
DELETE FROM `spell_proc` WHERE `SpellId` IN (-974, -1463, -10400, -11119, -11185, -12834, -13983, -14156, -15337, -16180, -18094, -18213, -20234, -20335, -27243, -29441, -29723, -29834, -30293, -30675, -31244, -31571, -31656, -31785, -31871, -31876, -34497, -34914, -44404, -44445, -44546, -46913, -46951, -47569, -48539, -48979, -49015, -49018, -49182, -49188, -49208, -49217, -49467, -51459, -51474, -51525, -51556, -51625, -51627, -51664, -53178, -53228, -53290, -53380, -53501, -53569, -53695, -54639, -54747, -59088, -61680, -62764, -63156, -63373, -64127, -65661, 1719, 11129, 12536, 15286, 16246, 16864, 16870, 17619, 20185, 20186, 22007, 24658, 24932, 26169, 26467, 28716, 28719, 28744, 28789, 28809, 28823, 28845, 28847, 28849, 29601, 32863, 36123, 38252, 39367, 44141, 70388, 30823, 31801, 32409, 33757, 37288, 37295, 37381, 37377, 39437, 37168, 37594, 38164, 39372, 40438, 40442, 40463, 40470, 40971, 42770, 45057, 46916, 47383, 71162, 71165, 49005, 49028, 49194, 49222, 49796, 51209, 51528, 51529, 51530, 51531, 51532, 51698, 51700, 51701, 52420, 52437, 53601, 53646, 53736, 54274, 54276, 54277, 54748, 54754, 54815, 54821, 54832, 54845, 54909, 54937, 54939, 55198, 55440, 55677, 56218, 56372, 56374, 56375, 56800, 57870, 58375, 58642, 58677, 58877, 59906, 59915, 37447, 61062, 61257, 62259, 62600, 62606, 63279, 63280, 63320, 64890, 64928, 65032, 67228, 69755, 69739, 69762, 70723, 70664, 70770, 70805, 70808, 70817, 70844, 70672, 72455, 72832, 72833, 71756, 72782, 72783, 72784, 71406, 71545, 71880, 71892, 71519, 71562, 71564, 71634, 71640, 71761, 71770, 72176, 75475, 75481);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-974,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x2,  0,   0,   3000, 0), -- Earth Shield
(-1463,   0,  3, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,  1024, 0x0,  0,   0,      0, 0), -- Mana Shield
(-10400,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Flametongue Weapon (Passive)
(-11119,  4,  3, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Ignite
(-11185,  0,  3, 0x00000080, 0x00000000, 0x00000000,   65536, 0x1, 0x2,     0, 0x2,  0,   0,      0, 0), -- Improved Blizzard
(-12834,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Deep Wounds Aura
(-13983,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    24, 0x0,  0,   0,   1000, 0), -- Setup
(-14156,  0,  8, 0x003E0000, 0x00000009, 0x00000000,       0, 0x0, 0x4,     0, 0x0,  0,   0,      0, 0), -- Ruthlessness
(-15337,  0,  6, 0x00802000, 0x00000002, 0x00000000,       0, 0x1, 0x2,     2, 0x2,  0,   0,      0, 0), -- Improved Spirit Tap
(-16180,  0, 11, 0x000001C0, 0x00000000, 0x00000010,       0, 0x2, 0x2,     2, 0x0,  0,   0,      0, 0), -- Improved Water Shield
(-18094,  0,  5, 0x0000000A, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Nightfall
(-18213, 32,  5, 0x00004000, 0x00000000, 0x00000000,       2, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Improved Drain Soul
(-20234,  0, 10, 0x00008000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Lay on Hands
(-20335,  0, 10, 0x00800000, 0x00000000, 0x00000000,      16, 0x5, 0x2,     0, 0x0,  0, 100,      0, 0), -- Heart of the Crusader
(-27243,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Seed of corruption (Warlock)
(-29441,  0,  3, 0x00000000, 0x00000000, 0x00000000,       0, 0x7, 0x0,     8, 0x0,  0,   0,   1000, 0), -- Magic Absorption
(-29723,  0,  4, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Sudden Death
(-29834,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x5, 0x0,     0, 0x0,  0,   0,      0, 0), -- Second Wind (Warrior talent)
(-30293,  0,  5, 0x00000181, 0x008200C0, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Soul Leech
(-30675,  0, 11, 0x00000003, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Lightning Overload
(-31244,  0,  8, 0x003A0000, 0x00000009, 0x00000000,       0, 0x5, 0x2, 11196, 0x0,  0,   0,      0, 0), -- Quick Recovery
(-31571,  0,  3, 0x00000000, 0x00000022, 0x00000008,   16384, 0x7, 0x4,     0, 0x0,  0,   0,      0, 0), -- Arcane Potency
(-31656,  4,  3, 0x08000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Empowered Fire
(-31785,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x0,     0, 0x0,  0,   0,      0, 0), -- Spiritual Attunement
(-31871,  0, 10, 0x00000010, 0x00000000, 0x00000000,   16384, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Divine Purpose
(-31876,  0, 10, 0x00800000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Judgements of the Wise
(-34497,  0,  9, 0x00060800, 0x00800001, 0x00000201,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Thrill of the Hunt
(-34914,  0,  6, 0x00002000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Vampiric Touch
(-44404,  0,  3, 0x20000021, 0x00009000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Missile Barrage
(-44445,  0,  3, 0x00000013, 0x00011000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Hot Streak
(-44546,  0,  3, 0x000002E0, 0x00001000, 0x00000000,   69632, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Brain Freeze
(-46913,  0,  4, 0x00000040, 0x00000404, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Bloodsurge
(-46951,  0,  4, 0x00000400, 0x00000040, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Sword and Board
(-47569,  0,  6, 0x00004000, 0x00000000, 0x00000000,   16384, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Shadowform
(-48539,  0,  7, 0x00000010, 0x04000000, 0x00000000,  262144, 0x2, 0x0,     0, 0x0,  0,   0,      0, 0), -- Revitalize
(-48979,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,      0, 0), -- Butchery
(-49015,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,      0, 0), -- Vendetta
(-49018,  0, 15, 0x01400000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Sudden Doom
(-49182,  0, 15, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Blade Barrier
(-49188,  0, 15, 0x00000000, 0x00020000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Rime
(-49208,  0, 15, 0x00400000, 0x00010000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Reaping
(-49217,  0, 15, 0x00000000, 0x00000000, 0x00000002,       0, 0x0, 0x0,     0, 0x0,  0,   0,   1000, 0), -- Wandering Plague
(-49467,  0, 15, 0x00000010, 0x00020000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Death Rune Mastery
(-51459,  0,  0, 0x00000000, 0x00000000, 0x00000000,       4, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Necrosis
(-51474,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Astral Shift
(-51525,  0, 11, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0 ,0x0,  0,   0,      0, 0), -- Static Shock
(-51556,  0, 11, 0x000000C0, 0x00000000, 0x00000010,       0, 0x2, 0x2,     2, 0x0,  0,   0,      0, 0), -- Ancestral Awakening
(-51625,  0,  8, 0x1000A000, 0x00000000, 0x00000000,       0, 0x5, 0x2,     0, 0x0,  0,   0,      0, 0), -- Deadly Brew
(-51627,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,   112, 0x0,  0,   0,      0, 0), -- Turn the Tables
(-51664,  0,  8, 0x00020000, 0x00000008, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Cut to the Chase
(-53178,  0,  9, 0x00000000, 0x10000000, 0x00000000,   65536, 0x4, 0x2,     0, 0x0,  0, 100,      0, 0), -- Guard Dog
(-53228,  0,  9, 0x00000020, 0x01000000, 0x00000000,       0, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Rapid Recuperation
(-53290,  0,  9, 0x00000800, 0x00000001, 0x00000200,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Hunting Party
(-53380,  0, 10, 0x00800000, 0x00028000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Righteous Vengeance
(-53501,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     2, 0x0,  0,   0,      0, 0), -- Sheath of Light
(-53569,  0, 10, 0x40200000, 0x00010000, 0x00000000,       0, 0x3, 0x2,     0, 0x0,  0,   0,      0, 0), -- Infusion of Light
(-53695,  0, 10, 0x00800000, 0x00000000, 0x00000008,      16, 0x5, 0x2,     0, 0x2,  0,   0,      0, 0), -- Judgements of the Just
(-54639,  0, 15, 0x00400000, 0x00010000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Blood of the North
(-54747,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Burning Determination
(-59088,  0,  4, 0x00000000, 0x00000002, 0x00000000,    1024, 0x4, 0x4,     0, 0x0,  0,   0,      0, 0), -- Improved Spell Reflection
(-61680,  0,  9, 0x00000000, 0x10000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Culling the Herd
(-62764,  0,  9, 0x00000000, 0x10000000, 0x00000000,   65536, 0x4, 0x2,     0, 0x0,  0, 100,      0, 0), -- Silverback
(-63156,  0,  5, 0x00000001, 0x000000C0, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Decimation
(-63373,  0, 11, 0x80000000, 0x00000000, 0x00000000,   65536, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Frozen Power
(-64127,  0,  6, 0x00000001, 0x00000001, 0x00000000,       0, 0x6, 0x2,     0, 0x0,  0,   0,      0, 0), -- Body and Soul
(-65661,  0, 15, 0x00400011, 0x20020004, 0x00000000,      16, 0x1, 0x2,     0, 0x0,  0, 100,      0, 0), -- Threat of Thassarian

(1719,    0,  4, 0x2E600444, 0x00404745, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Recklessness
(11129,   4,  3, 0x08C00017, 0x00031048, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Combustion
(12536,   0,  3, 0x20C21AF7, 0x00029040, 0x00000000,       0, 0x0, 0x1,     0, 0x4,  0,   0,      0, 0), -- Clearcasting (Mage)
(15286,  32,  6, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Vampiric Embrace
(16246,   0, 11, 0x981001C3, 0x00001400, 0x00000010,       0, 0x0, 0x1,     0, 0x4,  0,   0,      0, 0), -- Clearcasting (Shaman)
(16864,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0, 3.5,  0,      0, 0), -- Omen of Clarity
(16870,   0,  7, 0x00E3BBFF, 0x079007D3, 0x00040400,       0, 0x0, 0x1,     0, 0x4,  0,   0,      0, 0), -- Clearcasting (Druid)
(17619,   0, 13, 0x00000000, 0x00000000, 0x00000000,   32768, 0x7, 0x0,     0, 0x0,  0,   0,      0, 0), -- Alchemist's Stone
(20185,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0, 15,   0,      0, 0), -- Judgement of Light
(20186,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0, 15,   0,      0, 0), -- Judgement of Wisdom
(22007,   0,  3, 0x00200021, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Netherwind Focus
(24658,   0,  0, 0x00000000, 0x00000000, 0x00000000,   87376, 0x7, 0x2,     0, 0x0,  0,   0,      0, 0), -- Unstable Power
(24932,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Leader of the Pack
(26169,   0,  6, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Oracle Healing Bonus
(26467,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Persistent Shield
(28716,   0,  7, 0x00000010, 0x00000000, 0x00000000,  262144, 0x2, 0x0,     0, 0x0,  0,   0,      0, 0), -- Rejuvenation - Dreamwalker Raiment 2pc
(28719,   0,  7, 0x00000020, 0x00000000, 0x00000000,       0, 0x2, 0x2,     2, 0x0,  0,   0,      0, 0), -- Healing Touch - Dreamwalker Raiment 8 pc
(28744,   0,  7, 0x00000040, 0x00000000, 0x00000000,  278528, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Regrowth - Dreamwalker Raiment 6pc
(28789,   0, 10, 0xC0000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Holy Power
(28809,   0,  6, 0x00001000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     2, 0x0,  0,   0,      0, 0), -- Greater Heal - Vestments of Faith 4pc
(28823,   0, 11, 0x000000C0, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Totemic Power
(28845,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Cheat Death
(28847,   0,  7, 0x00000020, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Healing Touch Refund
(28849,   0, 11, 0x00000080, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Lesser Heealing Wave
(29601,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x4,  0,   0,      0, 0), -- Enlightenment

(32863,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Seed of Corruption (Monster)
(36123,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Seed of Corruption (Monster)
(38252,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Seed of Corruption (Monster)
(39367,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Seed of Corruption (Monster)
(44141,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Seed of Corruption (Monster)
(70388,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Seed of Corruption (Monster)

(30823,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0, 18,   0,      0, 0), -- Shamanistic Rage (AC #17499)
(31801,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x2,  0,   0,      0, 0), -- Seal of Vengeance
(32409,   0,  0, 0x00000000, 0x00002000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Shadow Word: Death - do not require honor target
(33757,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,   3000, 0), -- Windfury Weapon (Passive)
(37288,   0,  7, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Mana Restore - Malorne Raiment 2pc
(37295,   0,  7, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Mana Restore - Malorne Regalia 2pc
(37381,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Pet Healing

(37377,  32,  5, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Shadowflame
(39437,   4,  5, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Shadowflame Hellfire and RoF

(37168,   0,  8, 0x003E0000, 0x00000009, 0x00000000,       0, 0x0, 0x4,     0, 0x0,  0,   0,      0, 0), -- Finisher Combo
(37594,   0,  6, 0x00001000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Greater Heal Refund
(38164,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Unyielding Knights
(39372,  48,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Frozen Shadoweave
(40438,   0,  6, 0x00008040, 0x00000000, 0x00000000,       0, 0x3, 0x0,     0, 0x0,  0,   0,      0, 0), -- Priest Tier 6 Trinket
(40442,   0,  7, 0x00000014, 0x00000440, 0x00000000,       0, 0x7, 0x1,     0, 0x0,  0,   0,      0, 0), -- Druid Tier 6 Trinket
(40463,   0, 11, 0x00000081, 0x00000010, 0x00000000,       0, 0x3, 0x2,     0, 0x0,  0,   0,      0, 0), -- Shaman Tier 6 Trinket
(40470,   0, 10, 0xC0800000, 0x00000000, 0x00000000,       0, 0x3, 0x2,     0, 0x0,  0,   0,      0, 0), -- Paladin Tier 6 Trinket
(40971,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Bonus Healing (Crystal Spire of Karabor)
(42770,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x5, 0x0,     0, 0x0,  0,   0,      0, 0), -- Second Wind (NPC aura)
(45057,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  30000, 0), -- Evasive Maneuvers
(46916,   0,  4, 0x00200000, 0x00000000, 0x00000000,       0, 0x0, 0x4,     0, 0x0,  0,   0,      0, 0), -- Slam! (Bloodsurge proc)

(47383,   0,  5, 0x00000000, 0x000000C0, 0x00000000,       0, 0x0, 0x1,     0, 0x8,  0,   0,      0, 0), -- Molten Core
(71162,   0,  5, 0x00000000, 0x000000C0, 0x00000000,       0, 0x0, 0x1,     0, 0x8,  0,   0,      0, 0), -- Molten Core
(71165,   0,  5, 0x00000000, 0x000000C0, 0x00000000,       0, 0x0, 0x1,     0, 0x8,  0,   0,      0, 0), -- Molten Core

(49005,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Mark of Blood
(49028,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x5, 0x2,     0, 0x0,  0,   0,      0, 0), -- Dancing Rune Weapon
(49194,   0, 15, 0x00000000, 0x00000000, 0x00000001,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Unholy Blight
(49222,   0,  0, 0x00000000, 0x00000000, 0x00000000,  139944, 0x0, 0x0,     0, 0x0,  0,   0,   2000, 0), -- Bone Shield
(49796,   0, 15, 0x00000002, 0x00020006, 0x00000000,       0, 0x0, 0x1,     0, 0x8,  0,   0,      0, 0), -- Deathchill
(51209,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Hungering Cold

(51528,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  4,   0,      0, 0), -- Maelstrom Weapon (Rank 1)
(51529,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  8,   0,      0, 0), -- Maelstrom Weapon (Rank 2)
(51530,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0, 12,   0,      0, 0), -- Maelstrom Weapon (Rank 3)
(51531,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0, 16,   0,      0, 0), -- Maelstrom Weapon (Rank 4)
(51532,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0, 20,   0,      0, 0), -- Maelstrom Weapon (Rank 5)

(51698,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x3, 0x2,     2, 0x0,  0,  33,      0, 0), -- Honor Among Thieves (Rank 1)
(51700,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x3, 0x2,     2, 0x0,  0,  66,      0, 0), -- Honor Among Thieves (Rank 2)
(51701,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x3, 0x2,     2, 0x0,  0, 100,      0, 0), -- Honor Among Thieves (Rank 3)

(52420,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  30000, 0), -- Deflection
(52437,   1,  4, 0x20000000, 0x00000000, 0x00000000,      16, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Sudden Death proc
(53601,   0,  0, 0x00000000, 0x00000000, 0x00000000, 1048576, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Sacred Shield
(53646,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Demonic Pact
(53736,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x2,  0,   0,      0, 0), -- Seal of Corruption

(54274,   0,  5, 0x00000165, 0x000310C0, 0x00000000,       0, 0x0, 0x1,     0, 0x8,  0,   0,      0, 0), -- Backdraft
(54276,   0,  5, 0x00000165, 0x000310C0, 0x00000000,       0, 0x0, 0x1,     0, 0x8,  0,   0,      0, 0), -- Backdraft
(54277,   0,  5, 0x00000165, 0x000310C0, 0x00000000,       0, 0x0, 0x1,     0, 0x8,  0,   0,      0, 0), -- Backdraft

(54748,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,   259, 0x0,  0,   0,      0, 0), -- Burning Determination proc
(54754,   0,  7, 0x00000010, 0x00000000, 0x00000000,       0, 0x2, 0x0,     0, 0x0,  0,   0,      0, 0), -- Glyph of Rejuvenation
(54815,   0,  7, 0x00008000, 0x00000000, 0x00000000,      16, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Shred
(54821,   0,  7, 0x00001000, 0x00000000, 0x00000000,      16, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Rake
(54832,   0,  7, 0x00000000, 0x00001000, 0x00000000,   16384, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Innervate
(54845,   0,  7, 0x00000004, 0x00000000, 0x00000000,   65536, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Starfire
(54909,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Demonic Pact
(54937,   0, 10, 0x80000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Holy Light
(54939,   0, 10, 0x00008000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Divinity
(55198,   0, 11, 0x000001C0, 0x00000000, 0x00000000,   16384, 0x2, 0x2,     2, 0x0,  0,   0,      0, 3), -- Tidal Force
(55440,   0, 11, 0x00000040, 0x00000000, 0x00000000,       0, 0x2, 0x1,     0, 0x0,  0,   0,      0, 0), -- Glyph of Healing Wave
(55677,   0,  6, 0x00000000, 0x00000001, 0x00000000,       0, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Dispel Magic
(56218,   0,  5, 0x00000002, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Glyph of Corruption
(56372,   0,  3, 0x00000000, 0x00000080, 0x00000000,   16384, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Ice Block
(56374,   0,  3, 0x00000000, 0x00004000, 0x00000008,   16384, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Icy Veins
(56375,   0,  3, 0x01000000, 0x00000000, 0x00000000,   65536, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Polymorph
(56800,   0,  8, 0x00000004, 0x00000000, 0x00000000,      16, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Backstab
(57870,   0,  9, 0x00800000, 0x00000000, 0x00000000,  262144, 0x2, 0x0,     0, 0x0,  0,   0,      0, 0), -- Glyph of Mend Pet
(58375,   0,  4, 0x00000000, 0x00000200, 0x00000000,      16, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Blocking
(58642,   0, 15, 0x00000000, 0x08000000, 0x00000000,      16, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Scourge Strike
(58677,   0, 15, 0x00002000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x2,  0,   0,      0, 0), -- Glyph of Death's Embrace
(58877,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Spirit Hunt
(59906,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,      0, 0), -- Swift Hand of Justice
(59915,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Discerning Eye of the Beast

(37447,   0,  3, 0x00000000, 0x00000100, 0x00000000,   16384, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Mana Gems
(61062,   0,  3, 0x00000000, 0x00000100, 0x00000000,   16384, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Mana Gems

(61257,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x5, 0x0,     0, 0x0,  0,   0,      0, 0), -- Runic Power Back on Snare/Root
(62259,   0, 15, 0x02000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,      0, 0), -- Glyph of Death Grip
(62600,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Savage Defense (Passive)
(62606,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  1027, 0x0,  0,   0,      0, 0), -- Savage Defense
(63279,   0, 11, 0x00000000, 0x00000400, 0x00000000,       0, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Earth Shield
(63280,   0, 11, 0x20000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Totem of Wrath
(63320,   0,  5, 0x80040000, 0x00000000, 0x00008000,    1024, 0x7, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Life Tap
(64890,   0, 10, 0x00000000, 0x00010000, 0x00000000,       0, 0x2, 0x2,     2, 0x0,  0,   0,      0, 0), -- Item - Paladin T8 Holy 2P Bonus
(64928,   0, 11, 0x00000001, 0x00000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Item - Shaman T8 Elemental 4P Bonus
(65032,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- 321-Boombot Aura - do not require experience target
(67228,   0, 11, 0x00000000, 0x00001000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Shaman T9 Elemental 4P Bonus (Lava Burst)
(69755,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x7, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Purified Shard of the Scale
(69739,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x7, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Shiny Shard of the Scale
(69762,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Unchained Magic
(70723,   0,  7, 0x00000005, 0x00000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Item - Druid T10 Balance 4P Bonus
(70664,   0,  7, 0x00000010, 0x00000000, 0x00000000,       0, 0x2, 0x0,     0, 0x0,  0,   0,      0, 0), -- Druid T10 Restoration 4P Bonus (Rejuvenation)
(70770,   0,  6, 0x00000800, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Priest T10 Healer 2P Bonus
(70805,   0,  8, 0x00000000, 0x00020000, 0x00000000,       0, 0x4, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Rogue T10 2P Bonus
(70808,   0, 11, 0x00000100, 0x00000000, 0x00000000,       0, 0x2, 0x2,     2, 0x0,  0,   0,      0, 0), -- Item - Shaman T10 Restoration 4P Bonus
(70817,   0, 11, 0x00000000, 0x00001000, 0x00000000,   65536, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Shaman T10 Elemental 4P Bonus
(70844,   0,  4, 0x00000100, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Warrior T10 Protection 4P Bonus

(70672,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Gaseous Bloat
(72455,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Gaseous Bloat
(72832,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Gaseous Bloat
(72833,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Gaseous Bloat

(71756,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Ball of Flames Proc
(72782,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Ball of Flames Proc
(72783,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Ball of Flames Proc
(72784,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Ball of Flames Proc

(71406,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,  50,      0, 0), -- Anger Capacitor
(71545,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,  50,      0, 0), -- Anger Capacitor

(71880,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  1,   0,      0, 0), -- Item - Icecrown 25 Normal Dagger Proc
(71892,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  1,   0,      0, 0), -- Item - Icecrown 25 Heroic Dagger Proc

(71519,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0, 105000, 0), -- Deathbringer's Will
(71562,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0, 105000, 0), -- Deathbringer's Will (Heroic)
(71564, 126,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x3, 0x2,     2, 0x0,  0,   0,      0, 5), -- Deadly Precision
(71634,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  30000, 0), -- Item - Icecrown 25 Normal Tank Trinket 1
(71640,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  30000, 0), -- Item - Icecrown 25 Heroic Tank Trinket 1
(71761,   3,  0, 0x00000000, 0x00100000, 0x00000000,       0, 0x5, 0x2,   256, 0x0,  0,   0,      0, 0), -- Deep Freeze Immunity State
(71770,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Ooze Spell Tank Protection
(72176,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Blood Beast's Blood Link
(75475,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  45000, 0), -- Item - Chamber of Aspects 25 Tank Trinket
(75481,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  45000, 0); -- Item - Chamber of Aspects 25 Heroic Tank Trinket

-- Add spellscripts to spells previously on giant switches in Unit.cpp
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_rog_t10_2p_bonus';
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_sha_flametongue_weapon','spell_mage_imp_blizzard','spell_warr_deep_wounds_aura','spell_rog_setup','spell_pri_improved_spirit_tap','spell_sha_imp_water_shield','spell_warl_improved_drain_soul','spell_pal_improved_lay_of_hands','spell_pal_heart_of_the_crusader','spell_warl_seed_of_corruption_dummy','spell_mage_magic_absorption','spell_warr_extra_proc','spell_warr_second_wind','spell_warl_soul_leech','spell_sha_lightning_overload','spell_rog_quick_recovery','spell_mage_arcane_potency','spell_mage_empowered_fire','spell_pal_spiritual_attunement','spell_pal_divine_purpose','spell_pal_judgements_of_the_wise','spell_hun_thrill_of_the_hunt','spell_mage_missile_barrage','spell_mage_hot_streak','spell_warr_sword_and_board','spell_pri_imp_shadowform','spell_dk_butchery','spell_item_unstable_power','spell_item_restless_strength','spell_dru_leader_of_the_pack','spell_pri_aq_3p_bonus','spell_item_persistent_shield','spell_dru_revitalize','spell_dk_death_rune','spell_dk_scent_of_blood_trigger','spell_dk_vendetta','spell_dk_sudden_doom','spell_dk_blade_barrier','spell_dk_rime','spell_dk_wandering_plague','spell_sha_astral_shift_aura','spell_dk_necrosis','spell_sha_static_shock','spell_sha_maelstrom_weapon','spell_sha_ancestral_awakening','spell_rog_deadly_brew','spell_rog_turn_the_tables','spell_rog_cut_to_the_chase','spell_pet_guard_dog','spell_hun_rapid_recuperation_trigger','spell_hun_hunting_party','spell_pal_righteous_vengeance','spell_pal_sheath_of_light','spell_pal_infusion_of_light','spell_pal_judgements_of_the_just','spell_mage_burning_determination','spell_warr_improved_spell_reflection','spell_pet_culling_the_herd','spell_pet_silverback','spell_warl_decimation','spell_sha_frozen_power','spell_pri_body_and_soul','spell_dk_threat_of_thassarian','spell_warl_seduction','spell_mage_combustion','spell_pri_vampiric_embrace','spell_dru_omen_of_clarity','spell_item_alchemists_stone','spell_pal_judgement_of_light_heal','spell_pal_judgement_of_wisdom_mana','spell_twisted_reflection','spell_dru_t3_2p_bonus','spell_dru_t3_8p_bonus','spell_dru_t3_6p_bonus','spell_pal_t3_6p_bonus','spell_pri_t3_4p_bonus','spell_sha_t3_6p_bonus','spell_warr_t3_prot_8p_bonus','spell_item_healing_touch_refund','spell_item_totem_of_flowing_water','spell_item_pendant_of_the_violet_eye','spell_sha_shamanistic_rage','spell_pal_seal_of_vengeance','spell_warl_seed_of_corruption_generic','spell_mark_of_malice','spell_item_mark_of_conquest','spell_sha_windfury_weapon','spell_dru_t4_2p_bonus','spell_pri_t5_heal_2p_bonus','spell_anetheron_vampiric_aura','spell_item_frozen_shadoweave','spell_item_aura_of_madness','spell_pri_item_t6_trinket','spell_dru_item_t6_trinket','spell_sha_item_t6_trinket','spell_pal_item_t6_trinket','spell_item_crystal_spire_of_karabor','spell_item_dementia','spell_item_pet_healing','spell_warl_t4_2p_bonus_shadow','spell_warl_t4_2p_bonus_fire','spell_mage_gen_extra_effects','spell_uk_second_wind','spell_item_commendation_of_kaelthas','spell_item_sunwell_exalted_caster_neck','spell_item_sunwell_exalted_melee_neck','spell_item_sunwell_exalted_tank_neck','spell_item_sunwell_exalted_healer_neck','spell_warl_glyph_of_corruption_nightfall','spell_dk_mark_of_blood','spell_dk_dancing_rune_weapon','spell_dk_unholy_blight','spell_dk_hungering_cold','spell_item_soul_harvesters_charm','spell_rog_turn_the_tables_proc','spell_pal_sacred_shield_dummy','spell_warl_demonic_pact','spell_pal_seal_of_corruption','spell_dru_glyph_of_rejuvenation','spell_dru_glyph_of_shred','spell_dru_glyph_of_rake','spell_dru_glyph_of_innervate','spell_dru_glyph_of_starfire_dummy','spell_pal_glyph_of_holy_light_dummy','spell_pal_glyph_of_divinity','spell_sha_tidal_force_dummy','spell_sha_glyph_of_healing_wave','spell_pri_glyph_of_dispel_magic','spell_mage_glyph_of_ice_block','spell_mage_glyph_of_icy_veins','spell_mage_glyph_of_polymorph','spell_rog_glyph_of_backstab','spell_hun_glyph_of_mend_pet','spell_pri_shadowfiend_death','spell_warr_glyph_of_blocking','spell_dk_glyph_of_scourge_strike','spell_sha_spirit_hunt','spell_hun_kill_command_pet','spell_item_swift_hand_justice_dummy','spell_item_discerning_eye_beast_dummy','spell_mage_imp_mana_gems','spell_gen_vampiric_touch','spell_dk_pvp_4p_bonus','spell_dk_glyph_of_death_grip','spell_dru_savage_defense','spell_sha_glyph_of_earth_shield','spell_sha_glyph_of_totem_of_wrath','spell_warl_glyph_of_life_tap','spell_pal_t8_2p_bonus','spell_sha_t8_elemental_4p_bonus','spell_xt002_321_boombot_aura','spell_sha_t9_elemental_4p_bonus','spell_item_purified_shard_of_the_scale','spell_item_shiny_shard_of_the_scale','spell_dru_t10_balance_4p_bonus','spell_dru_t10_restoration_4p_bonus_dummy','spell_pri_t10_heal_2p_bonus','spell_sha_t10_restoration_4p_bonus','spell_sha_t10_elemental_4p_bonus','spell_warr_item_t10_prot_4p_bonus','spell_item_tiny_abomination_in_a_jar','spell_item_tiny_abomination_in_a_jar_hero','spell_item_deadly_precision_dummy','spell_item_deadly_precision','spell_item_heartpierce','spell_item_heartpierce_hero','spell_item_deathbringers_will_normal','spell_item_deathbringers_will_heroic','spell_item_corpse_tongue_coin','spell_item_corpse_tongue_coin_heroic','spell_putricide_ooze_tank_protection','spell_deathbringer_blood_beast_blood_link','spell_item_petrified_twilight_scale','spell_item_petrified_twilight_scale_heroic','spell_pri_blessed_recovery','spell_mage_blazing_speed','spell_hun_piercing_shots','spell_pal_illumination','spell_rog_overkill','spell_dru_maim_interrupt','spell_gen_petrified_bark','spell_gen_earth_shield_toc','spell_gen_retaliation_toc','spell_gen_overlords_brand','spell_gen_overlords_brand_dot','spell_gen_vampiric_might','spell_gen_mirrored_soul','spell_gen_black_bow_of_the_betrayer','spell_dk_glyph_of_scourge_strike_script');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-10400, 'spell_sha_flametongue_weapon'),
(-11185, 'spell_mage_imp_blizzard'),
(-12834, 'spell_warr_deep_wounds_aura'),
(-13983, 'spell_rog_setup'),
(-15337, 'spell_pri_improved_spirit_tap'),
(-16180, 'spell_sha_imp_water_shield'),
(-18213, 'spell_warl_improved_drain_soul'),
(-20234, 'spell_pal_improved_lay_of_hands'),
(-20335, 'spell_pal_heart_of_the_crusader'),
(-27243, 'spell_warl_seed_of_corruption_dummy'),
(-29441, 'spell_mage_magic_absorption'),

(-29723, 'spell_warr_extra_proc'),
(-46913, 'spell_warr_extra_proc'),

(-29834, 'spell_warr_second_wind'),
(-30293, 'spell_warl_soul_leech'),
(-30675, 'spell_sha_lightning_overload'),
(-31244, 'spell_rog_quick_recovery'),
(-31571, 'spell_mage_arcane_potency'),
(-31656, 'spell_mage_empowered_fire'),
(-31785, 'spell_pal_spiritual_attunement'),
(-31871, 'spell_pal_divine_purpose'),
(-31876, 'spell_pal_judgements_of_the_wise'),
(-34497, 'spell_hun_thrill_of_the_hunt'),
(-44404, 'spell_mage_missile_barrage'),
(-44445, 'spell_mage_hot_streak'),
(-46951, 'spell_warr_sword_and_board'),
(-47569, 'spell_pri_imp_shadowform'),
(-48979, 'spell_dk_butchery'),
(-48539, 'spell_dru_revitalize'),

(-49208, 'spell_dk_death_rune'),
(-49467, 'spell_dk_death_rune'),
(-54639, 'spell_dk_death_rune'),

(-49004, 'spell_dk_scent_of_blood_trigger'),
(-49015, 'spell_dk_vendetta'),
(-49018, 'spell_dk_sudden_doom'),
(-49182, 'spell_dk_blade_barrier'),
(-49188, 'spell_dk_rime'),
(50526, 'spell_dk_wandering_plague'),  -- Damage spell, not talent aura
(-51474, 'spell_sha_astral_shift_aura'),
(-51459, 'spell_dk_necrosis'),
(-51525, 'spell_sha_static_shock'),
(-51556, 'spell_sha_ancestral_awakening'),
(-51625, 'spell_rog_deadly_brew'),
(-51627, 'spell_rog_turn_the_tables'),
(-51664, 'spell_rog_cut_to_the_chase'),
(-53178, 'spell_pet_guard_dog'),
(-53228, 'spell_hun_rapid_recuperation_trigger'),
(-53290, 'spell_hun_hunting_party'),
(-53380, 'spell_pal_righteous_vengeance'),
(-53501, 'spell_pal_sheath_of_light'),
(-53569, 'spell_pal_infusion_of_light'),
(-53695, 'spell_pal_judgements_of_the_just'),
(-54747, 'spell_mage_burning_determination'),
(-59088, 'spell_warr_improved_spell_reflection'),
(-61680, 'spell_pet_culling_the_herd'),
(-62764, 'spell_pet_silverback'),
(-63156, 'spell_warl_decimation'),
(-63373, 'spell_sha_frozen_power'),
(-27811, 'spell_pri_blessed_recovery'),
(-31641, 'spell_mage_blazing_speed'),
(-53234, 'spell_hun_piercing_shots'),
(-20234, 'spell_pal_illumination'),
(58428,  'spell_rog_overkill'),
(44835,  'spell_dru_maim_interrupt'),
(62337,  'spell_gen_petrified_bark'),
(62933,  'spell_gen_petrified_bark'),
(67534,  'spell_gen_earth_shield_toc'),
(65932,  'spell_gen_retaliation_toc'),
(69172,  'spell_gen_overlords_brand'),
(69173,  'spell_gen_overlords_brand_dot'),
(70674,  'spell_gen_vampiric_might'),
(69023,  'spell_gen_mirrored_soul'),
(27522,  'spell_gen_black_bow_of_the_betrayer'),
(40336,  'spell_gen_black_bow_of_the_betrayer'),
(46939,  'spell_gen_black_bow_of_the_betrayer'),
(-64127, 'spell_pri_body_and_soul'),
(-65661, 'spell_dk_threat_of_thassarian'),
(6358,   'spell_warl_seduction'),
(11129,  'spell_mage_combustion'),
(15286,  'spell_pri_vampiric_embrace'),
(16864,  'spell_dru_omen_of_clarity'),
(17619,  'spell_item_alchemists_stone'),
(20185,  'spell_pal_judgement_of_light_heal'),
(20186,  'spell_pal_judgement_of_wisdom_mana'),
(21063,  'spell_twisted_reflection'),
(24658,  'spell_item_unstable_power'),
(24661,  'spell_item_restless_strength'),
(24932,  'spell_dru_leader_of_the_pack'),
(26169,  'spell_pri_aq_3p_bonus'),
(26467,  'spell_item_persistent_shield'),
(28716,  'spell_dru_t3_2p_bonus'),
(28719,  'spell_dru_t3_8p_bonus'),
(28744,  'spell_dru_t3_6p_bonus'),
(28789,  'spell_pal_t3_6p_bonus'),
(28809,  'spell_pri_t3_4p_bonus'),
(28823,  'spell_sha_t3_6p_bonus'),
(28845,  'spell_warr_t3_prot_8p_bonus'),
(28847,  'spell_item_healing_touch_refund'),
(28849,  'spell_item_totem_of_flowing_water'),
(29601,  'spell_item_pendant_of_the_violet_eye'),
(30823,  'spell_sha_shamanistic_rage'),
(31801,  'spell_pal_seal_of_vengeance'),

(32863,  'spell_warl_seed_of_corruption_generic'),
(36123,  'spell_warl_seed_of_corruption_generic'),
(38252,  'spell_warl_seed_of_corruption_generic'),
(39367,  'spell_warl_seed_of_corruption_generic'),
(44141,  'spell_warl_seed_of_corruption_generic'),
(70388,  'spell_warl_seed_of_corruption_generic'),

(33493,  'spell_mark_of_malice'),
(33510,  'spell_item_mark_of_conquest'),
(33757,  'spell_sha_windfury_weapon'),
(37288,  'spell_dru_t4_2p_bonus'),
(37295,  'spell_dru_t4_2p_bonus'),
(37594,  'spell_pri_t5_heal_2p_bonus'),
(38196,  'spell_anetheron_vampiric_aura'),
(39372,  'spell_item_frozen_shadoweave'),
(39446,  'spell_item_aura_of_madness'),
(40438,  'spell_pri_item_t6_trinket'),
(40442,  'spell_dru_item_t6_trinket'),
(40463,  'spell_sha_item_t6_trinket'),
(40470,  'spell_pal_item_t6_trinket'),
(40971,  'spell_item_crystal_spire_of_karabor'),
(41404,  'spell_item_dementia'),

(37381,  'spell_item_pet_healing'),

(37377,  'spell_warl_t4_2p_bonus_shadow'),
(39437,  'spell_warl_t4_2p_bonus_fire'),
(42770,  'spell_uk_second_wind'),

(44401,  'spell_mage_gen_extra_effects'),
(48108,  'spell_mage_gen_extra_effects'),
(57761,  'spell_mage_gen_extra_effects'),
(45057,  'spell_item_commendation_of_kaelthas'),
(45481,  'spell_item_sunwell_exalted_caster_neck'),
(45482,  'spell_item_sunwell_exalted_melee_neck'),
(45483,  'spell_item_sunwell_exalted_tank_neck'),
(45484,  'spell_item_sunwell_exalted_healer_neck'),

(-18094, 'spell_warl_glyph_of_corruption_nightfall'),
(56218,  'spell_warl_glyph_of_corruption_nightfall'),

(49005,  'spell_dk_mark_of_blood'),
(49028,  'spell_dk_dancing_rune_weapon'),
(49194,  'spell_dk_unholy_blight'),
(51209,  'spell_dk_hungering_cold'),
(52420,  'spell_item_soul_harvesters_charm'),

(52910,  'spell_rog_turn_the_tables_proc'),
(52914,  'spell_rog_turn_the_tables_proc'),
(52915,  'spell_rog_turn_the_tables_proc'),

(53601,  'spell_pal_sacred_shield_dummy'),

(53646,  'spell_warl_demonic_pact'),
(54909,  'spell_warl_demonic_pact'),

(53736,  'spell_pal_seal_of_corruption'),
(53817,  'spell_sha_maelstrom_weapon'),
(54748,  'spell_mage_burning_determination'),
(54754,  'spell_dru_glyph_of_rejuvenation'),
(54815,  'spell_dru_glyph_of_shred'),
(54821,  'spell_dru_glyph_of_rake'),
(54832,  'spell_dru_glyph_of_innervate'),
(54845,  'spell_dru_glyph_of_starfire_dummy'),
(54937,  'spell_pal_glyph_of_holy_light_dummy'),
(54939,  'spell_pal_glyph_of_divinity'),
(55198,  'spell_sha_tidal_force_dummy'),
(55440,  'spell_sha_glyph_of_healing_wave'),
(55677,  'spell_pri_glyph_of_dispel_magic'),
(56372,  'spell_mage_glyph_of_ice_block'),
(56374,  'spell_mage_glyph_of_icy_veins'),
(56375,  'spell_mage_glyph_of_polymorph'),
(56800,  'spell_rog_glyph_of_backstab'),
(57870,  'spell_hun_glyph_of_mend_pet'),
(57989,  'spell_pri_shadowfiend_death'),
(58375,  'spell_warr_glyph_of_blocking'),
(58642,  'spell_dk_glyph_of_scourge_strike'),
(69961,  'spell_dk_glyph_of_scourge_strike_script'),
(58877,  'spell_sha_spirit_hunt'),
(58914,  'spell_hun_kill_command_pet'),
(59906,  'spell_item_swift_hand_justice_dummy'),
(59915,  'spell_item_discerning_eye_beast_dummy'),

(37447,  'spell_mage_imp_mana_gems'),
(61062,  'spell_mage_imp_mana_gems'),

(52723,  'spell_gen_vampiric_touch'),
(60501,  'spell_gen_vampiric_touch'),
(61257,  'spell_dk_pvp_4p_bonus'),
(62259,  'spell_dk_glyph_of_death_grip'),
(62600,  'spell_dru_savage_defense'),
(63279,  'spell_sha_glyph_of_earth_shield'),
(63280,  'spell_sha_glyph_of_totem_of_wrath'),
(63320,  'spell_warl_glyph_of_life_tap'),
(64890,  'spell_pal_t8_2p_bonus'),
(64928,  'spell_sha_t8_elemental_4p_bonus'),
(65032,  'spell_xt002_321_boombot_aura'),
(67228,  'spell_sha_t9_elemental_4p_bonus'),
(69755,  'spell_item_purified_shard_of_the_scale'),
(69739,  'spell_item_shiny_shard_of_the_scale'),
(70723,  'spell_dru_t10_balance_4p_bonus'),
(70664,  'spell_dru_t10_restoration_4p_bonus_dummy'),
(70770,  'spell_pri_t10_heal_2p_bonus'),
(70808,  'spell_sha_t10_restoration_4p_bonus'),
(70817,  'spell_sha_t10_elemental_4p_bonus'),
(70844,  'spell_warr_item_t10_prot_4p_bonus'),

(71406,  'spell_item_tiny_abomination_in_a_jar'),
(71545,  'spell_item_tiny_abomination_in_a_jar_hero'),

(71563,  'spell_item_deadly_precision_dummy'),
(71564,  'spell_item_deadly_precision'),

(71880,  'spell_item_heartpierce'),
(71892,  'spell_item_heartpierce_hero'),

(71519,  'spell_item_deathbringers_will_normal'),
(71562,  'spell_item_deathbringers_will_heroic'),

(71634,  'spell_item_corpse_tongue_coin'),
(71640,  'spell_item_corpse_tongue_coin_heroic'),

(71770,  'spell_putricide_ooze_tank_protection'),
(72176,  'spell_deathbringer_blood_beast_blood_link'),

(75475,  'spell_item_petrified_twilight_scale'),
(75481,  'spell_item_petrified_twilight_scale_heroic');

-- Non scripted auras from `spell_proc_event`
DELETE FROM `spell_proc` WHERE `SpellId` IN (-66799, -63730, -61846, -58872, -57878, -57470, -56636, -56342, -55666, -53709, -53671, -53551, -53527, -53486, -53256, -53234, -53221, -53215, -52795, -52127, -51940, -51692, -51672, -51634, -51562, -51523, -51521, -50880, -49223, -49219, -49149, -49027, -49004, -48988, -48516, -48506, -48496, -48483, -47580, -47516, -47509, -47263, -47258, -47245, -47201, -47195, -46945, -46867, -46854, -45234, -44557, -44449, -44442, -41635, -35541, -35100, -34950, -34935, -34753, -34500, -33881, -33191, -33150, -33142, -33076, -32385, -31833, -31569, -31124, -30881, -30701, -30299, -30160, -29593, -29074, -27811, -20925, -20500, -20210, -20177, -20049, -19572, -19184, -18119, -18096, -17793, -17106, -16958, -16952, -16880, -16487, -16257, -16256, -16176, -14892, -14531, -14186, -13754, -13165, -12966, -12319, -12311, -12298, -12289, -12281, -11255, -11213, -11180, -11095, -9799, -9452, -5952, -324, 6346, 7383, 7434, 8178, 9782, 9784, 12169, 12322, 12999, 13000, 13001, 13002, 13163, 15088, 15128, 15277, 15346, 15600, 16164, 16550, 16620, 16624, 17364, 17495, 20128, 20131, 20132, 20164, 20165, 20166, 20375, 20705, 20784, 20911, 21185, 21882, 21890, 22618, 22648, 23547, 23548, 23551, 23552, 23572, 23578, 23581, 23686, 23688, 23689, 23721, 23920, 24353, 24389, 24905, 25050, 25669, 25899, 26107, 26119, 26128, 26135, 26480, 26605, 27419, 27498, 27521, 27656, 27774, 27787, 28305, 28752, 28802, 28812, 28816, 29150, 29385, 29455, 29501, 29624, 29625, 29626, 29632, 29633, 29634, 29635, 29636, 29637, 29977, 30003, 30937, 31394, 31794, 31904, 32587, 32642, 32734, 32748, 32776, 32777, 32837, 32844, 32885, 33089, 33127, 33297, 33299, 33510, 33648, 33719, 33746, 33759, 33953, 34074, 34080, 34138, 34139, 34258, 34262, 34320, 34355, 34584, 34586, 34598, 34749, 34774, 34783, 34827, 35077, 35080, 35083, 35086, 35121, 36032, 36096, 36111, 36541, 37165, 37170, 37173, 37189, 37193, 37195, 37197, 37213, 37214, 37227, 37237, 37247, 37379, 37384, 37443, 37514, 37516, 37519, 37523, 37528, 37536, 37568, 37600, 37601, 37603, 37655, 37657, 38026, 38031, 38290, 38299, 38326, 38327, 38334, 38347, 38350, 38394, 38857, 39027, 39442, 39443, 39530, 39958, 40407, 40444, 40458, 40475, 40478, 40482, 40485, 40899, 41034, 41260, 41262, 41381, 41393, 41434, 41469, 41989, 42083, 42135, 42136, 42368, 42370, 43443, 43726, 43728, 43737, 43739, 43741, 43745, 43748, 43750, 43819, 44543, 44545, 45054, 45354, 45355, 45469, 45481, 45482, 45483, 45484, 46025, 46092, 46098, 46569, 46662, 46832, 46910, 46911, 47981, 48833, 48835, 48837, 49592, 49622, 50240, 50421, 50781, 51123, 51127, 51128, 51129, 51130, 51346, 51349, 51352, 51359, 51414, 51915, 52020, 52423, 52898, 53386, 53397, 54278, 54646, 54695, 54707, 54738, 54808, 54838, 54841, 54925, 55380, 55381, 55640, 55680, 55681, 55689, 55747, 55768, 55776, 56249, 56355, 56364, 56451, 56816, 56817, 56821, 56841, 57345, 57352, 57907, 57989, 58357, 58364, 58372, 58386, 58442, 58444, 58616, 58620, 58626, 58901, 59176, 59327, 59345, 59630, 59725, 60061, 60063, 60066, 60132, 60170, 60172, 60176, 60221, 60301, 60306, 60317, 60436, 60442, 60473, 60482, 60487, 60490, 60493, 60503, 60519, 60524, 60529, 60537, 60564, 60571, 60572, 60573, 60574, 60575, 60710, 60717, 60719, 60722, 60724, 60726, 60770, 60818, 60826, 61188, 61324, 61356, 61618, 61848, 62114, 62115, 62147, 62459, 63086, 63108, 63251, 63310, 63335, 63611, 64343, 64411, 64415, 64440, 64571, 64714, 64738, 64742, 64752, 64786, 64792, 64824, 64860, 64867, 64882, 64908, 64912, 64914, 64938, 64952, 64955, 64964, 64976, 64999, 65002, 65005, 65007, 65013, 65020, 65025, 66808, 67115, 67151, 67209, 67353, 67356, 67361, 67363, 67365, 67379, 67381, 67384, 67386, 67389, 67392, 67653, 67667, 67670, 67672, 67698, 67702, 67712, 67752, 67758, 67771, 68051, 68160, 70188, 70652, 70727, 70730, 70748, 70756, 70761, 70803, 70807, 70811, 70830, 70841, 70854, 71174, 71176, 71178, 71186, 71191, 71194, 71198, 71214, 71217, 71226, 71228, 71402, 71404, 71540, 71585, 71602, 71606, 71611, 71637, 71642, 71645, 71903, 72413, 72417, 72419, 74396, 75455, 75457, 75465, 75474);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-66799,  0, 15, 0x00400000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Desolation
(-63730,  0,  6, 0x00000800, 0x00000004, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Serendipity
(-61846,  0,  0, 0x00000000, 0x00000000, 0x00000000,      64, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Aspect of the Dragonhawk
(-58872,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  8259, 0x0,  0,   0,      0, 0), -- Damage Shield
(-57878,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    16, 0x0,  0,   0,      0, 0), -- Natural Reaction
(-57470,  0,  6, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  15000, 0), -- Renewed Hope
(-56636,  0,  4, 0x00000020, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   6000, 0), -- Taste for Blood
(-56342,  0,  9, 0x00000018, 0x08000000, 0x00024000,       0, 0x0, 0x0,     0, 0x2,  0,   0,      0, 0), -- Lock and Load
(-55666,  0, 15, 0x00000001, 0x08000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Desecration
(-53709,  2, 10, 0x00004000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Shield of the Templar
(-53671,  0, 10, 0x00800000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Judgements of the Pure
(-53551,  0, 10, 0x00001000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Sacred Cleansing
(-53527,  1, 10, 0x00000000, 0x00000000, 0x00000004,    1024, 0x0, 0x2,     1, 0x0,  0, 100,      0, 0), -- Divine Guardian
(-53486,  0, 10, 0x00800000, 0x00028000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- The Art of War
(-53256,  0,  9, 0x00000800, 0x00800001, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Cobra Strikes
(-53234,  0,  9, 0x00020000, 0x00000001, 0x00000001,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Piercing Shots
(-53221,  0,  9, 0x00000000, 0x00000001, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Steady Shot
(-53215,  0,  9, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Wild Quiver
(-52795,  0,  6, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Borrowed Time
(-52127,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   3000, 0), -- Water Shield
(-51940,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,  20,      0, 0), -- Earthliving Weapon (Passive)
(-51692,  0,  8, 0x00000204, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Waylay
(-51672,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    16, 0x0,  0,   0,   1000, 0), -- Unfair Advantage
(-51634,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Focused Attacks
(-51562,  0, 11, 0x00000100, 0x00000000, 0x00000010,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Tidal Waves
(-51523,  0, 11, 0x00000000, 0x00000001, 0x00000000,   65536, 0x0, 0x2,     0, 0x0,  0,  50,      0, 0), -- Earthen Power
(-51521,  0, 11, 0x00000000, 0x01000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Stormstrike
(-50880,  0, 15, 0x00000000, 0x04000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Icy Talons
(-49223,  0, 15, 0x00000011, 0x08020000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Dirge
(-49219,  0,  0, 0x00000000, 0x00000000, 0x00000000,       4, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Blood-Caked Blade
(-49149,  0, 15, 0x00000006, 0x00020002, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Chill of the Grave
(-49027,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  20000, 0), -- Bloodworms
(-49004,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    51, 0x0,  0,   0,      0, 0), -- Scent of Blood
(-48988,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Bloody Vengeance
(-48516,  0,  7, 0x00000005, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Eclipse
(-48506,  0,  7, 0x00000005, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Earth and Moon
(-48496,  0,  7, 0x00000060, 0x02000002, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Living Seed
(-48483,  0,  7, 0x00008800, 0x00000440, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Infected Wounds
(-47580,  0,  6, 0x00000000, 0x00000000, 0x00000040,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Pain and Suffering
(-47516,  0,  6, 0x00001800, 0x00010000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Grace
(-47509,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Divine Aegis
(-47263, 32,  5, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  20000, 0), -- Torture
(-47258,  0,  5, 0x00000000, 0x00800000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Backdraft
(-47245,  0,  5, 0x00000002, 0x00000000, 0x00000000,  262144, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Molten Core
(-47201,  0,  5, 0x00004009, 0x00040000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Everlasting Affliction
(-47195,  0,  5, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Eradication
(-46945,  0,  4, 0x00000000, 0x00010000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Safeguard
(-46867,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Wrecking Crew
(-46854,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Trauma
(-45234,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Focused Will
(-44557,  0,  3, 0x00000020, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Enduring Winter
(-44449,  0,  3, 0x20E21277, 0x00019048, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Burnout
(-44442,  0,  3, 0x00800000, 0x00000040, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,   1000, 0), -- Firestarter
(-41635,  0,  0, 0x00000000, 0x00000000, 0x00000000,  664232, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Prayer of Mending
(-35541,  0,  0, 0x00000000, 0x00000000, 0x00000000, 8388608, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Combat Potency
(-35100,  0,  9, 0x00001000, 0x00000000, 0x00000001,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Concussive Barrage
(-34950,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Go for the Throat
(-34935,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   8000, 0), -- Backlash
(-34753,  0,  6, 0x00001800, 0x00000004, 0x00001000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Holy Concentration
(-34500,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Expose Weakness
(-33881,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Natural Perfection
(-33191,  0,  6, 0x00008000, 0x00000400, 0x00000040,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Misery
(-33150,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Surge of Light
(-33142,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Blessed Resilience
(-33076,  0,  0, 0x00000000, 0x00000000, 0x00000000,  664232, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Prayer of Mending
(-32385,  0,  5, 0x00000001, 0x00040000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Shadow Embrace
(-31833,  0, 10, 0x80000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Light's Grace
(-31569,  0,  3, 0x00010000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Blink
(-31124,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Blade Twisting
(-30881,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,  30000, 0), -- Nature's Guardian
(-30701, 28,  0, 0x00000000, 0x00000000, 0x00000000,  664232, 0x0, 0x0,     0, 0x0,  0, 100,      0, 0), -- Elemental Absorption
(-30299,126,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Nether Protection
(-30160,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Elemental Devastation
(-29593,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,   112, 0x0,  0,   0,      0, 0), -- Improved Defensive Stance
(-29074, 20,  3, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Master of Elements
(-27811,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     2, 0x0,  0,   0,      0, 0), -- Blessed Recovery
(-20925,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Holy Shield
(-20500,  0,  4, 0x10000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Berserker Rage
(-20210,  0, 10, 0xC0000000, 0x00010000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Illumination
(-20177,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Reckoning
(-20049,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Vengeance
(-19572,  0,  9, 0x00800000, 0x00000000, 0x00000000,  262144, 0x2, 0x0,     0, 0x0,  0,   0,      0, 0), -- Improved Mend Pet
(-19184,  0,  9, 0x00000010, 0x00002000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Entrapment
(-18119,  0,  5, 0x00000000, 0x00800000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Aftermath
(-18096,  0,  5, 0x00000100, 0x00800000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Pyroclasm
(-17793,  0,  5, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Shadow Bolt
(-17106,  0,  7, 0x00080000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Intensity
(-16958,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Primal Fury
(-16952,  0,  7, 0x00039000, 0x00000400, 0x00040000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Blood Frenzy
(-16880, 72,  7, 0x00000067, 0x03800002, 0x00000000,       0, 0x0, 0x3,     2, 0x0,  0,   0,      0, 0), -- Nature's Grace
(-16487,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     2, 0x0,  0,   0,      0, 0), -- Blood Craze
(-16257,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Flurry
(-16256,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Flurry
(-16176,  0, 11, 0x000001C0, 0x00000000, 0x00000010,       0, 0x2, 0x2,     2, 0x0,  0,   0,      0, 0), -- Ancestral Healing
(-14892,  0,  6, 0x10001E00, 0x00010004, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Inspiration
(-14531,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     2, 0x0,  0,   0,      0, 0), -- Martyrdom
(-14186,  0,  8, 0x40800508, 0x00000006, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Seal Fate
(-13754,  0,  8, 0x00000010, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Kick
(-13165,  0,  0, 0x00000000, 0x00000000, 0x00000000,      64, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Aspect of the Hawk
(-12966,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Flurry
(-12319,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Flurry
(-12311,  0,  4, 0x00000800, 0x00000001, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Gag Order
(-12298,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,   112, 0x0,  0,   0,      0, 0), -- Shield Specialization
(-12289,  0,  4, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Hamstring
(-12281,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,   6000, 0), -- Sword Specialization
(-11255,  0,  3, 0x00004000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Counterspell
(-11213,  0,  3, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Arcane Concentration
(-11180, 16,  3, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Winter's Chill
(-11095,  0,  3, 0x00000010, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Scorch
(-9799,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     2, 0x0,  0,   0,      0, 0), -- Eye for an Eye
(-9452,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  3,   0,      0, 0), -- Vindication
(-5952,   0,  8, 0x00000000, 0x00000001, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Throwing Specialization
(-324,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,   3000, 0), -- Lightning Shield
(6346,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,   256, 0x0,  0,   0,      0, 0), -- Fear Ward
(7383,    1,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,   256, 0x0,  0,   0,      0, 0), -- Water Bubble
(7434,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Fate Rune of Unsurpassed Vigor
(8178,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Grounding Totem Effect
(9782,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Mithril Shield Spike
(9784,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Iron Shield Spike
(12169,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Shield Block
(12322,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  3,   0,      0, 0), -- Unbridled Wrath
(12999,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  6,   0,      0, 0), -- Unbridled Wrath
(13000,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  9,   0,      0, 0), -- Unbridled Wrath
(13001,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0, 12,   0,      0, 0), -- Unbridled Wrath
(13002,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0, 15,   0,      0, 0), -- Unbridled Wrath
(13163,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    16, 0x0,  0,   0,      0, 0), -- Aspect of the Monkey
(15088,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Flurry
(15128,   4,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Mark of Flames
(15277,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Seal of Reckoning
(15346,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,      0, 0), -- Seal of Reckoning
(15600,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  1,   0,      0, 0), -- Hand of Justice
(16164,  28,  0, 0x00000000, 0x00000000, 0x00000000,   65536, 0x0, 0x1,     2, 0x0,  0,   0,      0, 0), -- Elemental Focus (CAST phase for travel-time spells)
(16550,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Bonespike
(16620,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  30000, 0), -- Proc Self Invulnerability
(16624,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Thorium Shield Spike
(17364,   8,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Stormstrike
(17495,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Crest of Retribution
(20128,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Redoubt
(20131,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Redoubt
(20132,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Redoubt
(20164,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  5,   0,      0, 0), -- Seal of Justice
(20165,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0, 20,   0,      0, 0), -- Seal of Light
(20166,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0, 12,   0,      0, 0), -- Seal of Wisdom
(20375,   1,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,   1000, 0), -- Seal of Command
(20705,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Power Shield 500
(20784,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Tamed Pet Passive 07 (DND)
(21185,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,  10000, 0), -- Spinal Reaper
(21882,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Judgement Smite
(21890,   0,  4, 0x2A764EEF, 0x0000036C, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Warrior's Wrath
(22618,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Force Reactive Disk
(22648,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Call of Eskhandar
(23547,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    32, 0x0,  0,   0,      0, 0), -- Parry
(23548,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Parry
(23551,   0, 11, 0x000000C0, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Lightning Shield
(23552,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   3000, 0), -- Lightning Shield
(23572,   0, 11, 0x000000C0, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Mana Surge
(23578,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  2,   0,      0, 0), -- Expose Weakness
(23581,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  2,   0,      0, 0), -- Bloodfang
(23686,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  2,   0,      0, 0), -- Lightning Strike
(23688,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Aura of the Blue Dragon
(23689,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  4,   0,      0, 0), -- Heroism
(23721,   0,  9, 0x00000800, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Arcane Infused
(23920,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  2048, 0x0,  0,   0,      0, 0), -- Spell Reflection
(24353,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Primal Instinct
(24389,   4,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Chaos Fire
(24905,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0, 15,   0,      0, 0), -- Moonkin Form (Passive)
(25050,   4,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Mark of Flames
(25669,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  1,   0,      0, 0), -- Decapitate
(25899,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,   112, 0x0,  0,   0,      0, 0), -- Greater Blessing of Sanctuary
(26107,   0,  7, 0x00800000, 0x10000080, 0x00000000,       0, 0x0, 0x2,   116, 0x0,  0,   0,      0, 0), -- Symbols of Unending Life Finisher Bonus
(26119,   0, 10, 0x90100003, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Stormcaller Spelldamage Bonus
(26128,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     8, 0x0,  0,   0,      0, 0), -- Enigma Resist Bonus
(26135,   0, 10, 0x00800000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x2,  0,   0,      0, 0), -- Battlegear of Eternal Justice
(26480,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0, 10,   0,      0, 0), -- Badge of the Swarmguard (AC #16777)
(26605,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     2, 0x2,  0,   0,      0, 0), -- Bloodcrown
(27419,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  3,   0,      0, 0), -- Warrior's Resolve
(27498,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  3,   0,      0, 0), -- Crusader's Wrath
(27521,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  15000, 0), -- Mana Restore
(27656,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Flame Lash
(27774,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- The Furious Storm
(27787,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  1,   0,      0, 0), -- Rogue Armor Energize (AC #11048)
(28305,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Mana Leech
(28752,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Adrenaline Rush
(28802,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Epiphany
(28812,   0,  8, 0x02000006, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Head Rush
(28816,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  3,   0,      0, 0), -- Invigorate
(29150,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Electric Discharge
(29385,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  7,   0,   1000, 0), -- Seal of Command
(29455,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Felsteel Shield Spike
(29501,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Frost Arrow
(29624,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Searing Arrow
(29625,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Flaming Cannonball
(29626,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Shadow Bolt
(29632,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Shadow Shot
(29633,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Fire Blast
(29634,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Quill Shot
(29635,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Flaming Shell
(29636,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Venom Shot
(29637,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Keeper's Sting
(29977,   4,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Combustion
(30003,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  2048, 0x0,  0,   0,      0, 0), -- Sheen of Zanza
(30937,  32,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Mark of Shadow
(31394,  32,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Mark of Shadow
(31794,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Focused Mind
(31904,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Holy Shield
(32587,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Shield Block
(32642,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Spore Cloud
(32734,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   3000, 0), -- Earth Shield
(32748,   0,  8, 0x00000000, 0x00000001, 0x00000000,     320, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Deadly Throw Interrupt
(32776,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Redoubt
(32777,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Holy Shield
(32837,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Spell Focus Trigger
(32844,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  2,   0,      0, 0), -- Lesser Heroism
(32885,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     2, 0x0,  0,   0,      0, 0), -- Infuriate
(33089,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Vigilance of the Colossus
(33127,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  7,   0,   1000, 0), -- Seal of Command
(33297,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Spell Haste Trinket
(33299,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Coilfang Slave Pens Lvl 70 Boss3a Caster Trinket
(33510,   0,  0, 0x00000000, 0x00000000, 0x00000000,     340, 0x0, 0x2,     0, 0x0,  0,  15,  25000, 0), -- Health Restore (AC #16551)
(33648,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Reflection of Torment
(33719,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  2048, 0x0,  0,   0,      0, 0), -- Perfect Spell Reflection
(33746,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,  10000, 0), -- Essence Infused Mushroom
(33759,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,  10000, 0), -- Power Infused Mushroom
(33953,   0,  0, 0x00000000, 0x00000000, 0x00000000,   17408, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Essence of Life
(34074,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Aspect of the Viper
(34080,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    32, 0x0,  0,   0,      0, 0), -- Riposte Stance
(34138,   0, 11, 0x00000080, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Totem of the Third Wind
(34139,   0, 10, 0x40000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Libram of Justice
(34258,   0, 10, 0x00800000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x2,  0,   0,      0, 0), -- Justice
(34262,   0, 10, 0x00800000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x2,  0,   0,      0, 0), -- Mercy
(34320,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Call of the Nexus
(34355,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   3000, 0), -- Poison Shield
(34584,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  30000, 0), -- Love Struck
(34586,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,1.5,   0,      0, 0), -- Romulo's Poison
(34598,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Karazhan Caster Robe
(34749,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     8, 0x2,  0,   0,      0, 0), -- Recurring Power
(34774,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,1.5,   0,  20000, 0), -- Magtheridon Melee Trinket
(34783,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  2048, 0x0,  0,   0,      0, 0), -- Spell Reflection
(34827,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   3000, 0), -- Water Shield
(35077,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,  55000, 0), -- Band of the Eternal Defender
(35080,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  1,   0,  55000, 0), -- Band of the Eternal Champion
(35083,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  55000, 0), -- Band of the Eternal Sage
(35086,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  55000, 0), -- Band of the Eternal Restorer
(35121,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Nether Power
(36032,   0,  3, 0x00001000, 0x00008000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Arcane Blast
(36096,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  2048, 0x0,  0,   0,      0, 0), -- Spell Reflection
(36111,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- World Breaker
(36541,   4,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x2,  0,   0,      0, 0), -- Curse of Burning Shadows
(37165,   0,  8, 0x00200400, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Haste
(37170,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  1,   0,      0, 0), -- Free Finisher Chance
(37173,   0,  8, 0x2CBC0598, 0x00000106, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  25000, 0), -- Armor Penetration
(37189,   0, 10, 0xC0000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  60000, 0), -- Recuced Holy Light Cast Time
(37193,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Infused Shield
(37195,   0, 10, 0x00800000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x2,  0,   0,      0, 0), -- Judgement Group Heal
(37197,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Spell Damage
(37213,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Mana Cost Reduction
(37214,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Energized
(37227,   0, 11, 0x000001C0, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  60000, 0), -- Improved Healing Wave
(37237,   0, 11, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Lightning Bolt Discount
(37247,   8,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Regain Mana
(37379,  32,  5, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Flameshadow
(37384,   0,  5, 0x00000001, 0x00000040, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Corruption and Immolate
(37443,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Crit Bonus Damage
(37514,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    32, 0x0,  0,   0,      0, 0), -- Blade Turning
(37516,   0,  4, 0x00000400, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Revenge Bonus
(37519,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,    48, 0x0,  0,   0,      0, 0), -- Rage Bonus
(37523,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Reinforced Shield
(37528,   0,  4, 0x00000004, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Overpower Bonus
(37536,   0,  4, 0x00010000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Improved Battle Shout
(37568,   0,  6, 0x00000800, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Greater Heal Discount
(37600,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Offensive Discount
(37601,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Relentlessness
(37603,   0,  6, 0x00008000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Shadow Word Pain Damage
(37655,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  60000, 0), -- Bonus Mana Regen
(37657,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,   2500, 0), -- Lightning Capacitor
(38026,   1,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,   256, 0x0,  0,   0,      0, 0), -- Viscous Shield
(38031,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Shield Block
(38290,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,1.6,   0,      0, 0), -- Santos' Blessing
(38299,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  12000, 0), -- HoTs on Heals
(38326,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Crit Threat Reduction Melee
(38327,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0,  0,   0,      0, 0), -- Crit Threat Reduction Spell
(38334,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  60000, 0), -- Proc Mana Regen
(38347,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Crit Proc Spell Damage
(38350,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Crit Proc Heal
(38394,   0,  5, 0x00000006, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Dot Heals
(38857,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Spell Ground
(39027,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   3000, 0), -- Poison Shield
(39442,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     1, 0x0,  0,   0,      0, 0), -- Aura of Wrath
(39443,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Aura of Wrath
(39530,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Focus
(39958,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,0.7,   0,  40000, 0), -- Skyfire Swiftness
(40407,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  6,   0,      0, 0), -- Illidan Tank Shield (AC Mangos legacy)
(40444,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Black Temple Tank Trinket
(40458,   0,  4, 0x02000000, 0x00000601, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Warrior Tier 6 Trinket
(40475,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  3,   0,      0, 0), -- Black Temple Melee Trinket
(40478,   0,  5, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Warlock Tier 6 Trinket
(40482,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Mage Tier 6 Trinket
(40485,   0,  9, 0x00000000, 0x00000001, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Hunter Tier 6 Trinket
(40899,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  1,   0,      0, 0), -- Felfire Proc
(41034, 126,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  1024, 0x0,  0,   0,      0, 0), -- Spell Absorption
(41260,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,  10000, 0), -- Aviana's Purpose
(41262,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,  10000, 0), -- Aviana's Will
(41381,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,   256, 0x0,  0,   0,      0, 0), -- Shell of Life
(41393,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,    32, 0x0,  0,   0,      0, 0), -- Riposte
(41434,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  2,   0,  45000, 0), -- The Twin Blades of Azzinoth
(41469,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  7,   0,   1000, 0), -- Seal of Command
(41989,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,1.5,   0,      0, 0), -- Fists of Fury (AC #21454)
(42083,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Fury of the Crashing Waves
(42135,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  90000, 0), -- Lesser Rune of Warding
(42136,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  90000, 0), -- Greater Rune of Warding
(42368,   0, 10, 0x40000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Merciless Libram of Justice
(42370,   0, 11, 0x00000080, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Merciless Totem of the Third WInd
(43443,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  2048, 0x0,  0,   0,      0, 0), -- Spell Reflection
(43726,   0, 10, 0x40000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Vengeful Libram of Justice
(43728,   0, 11, 0x00000080, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Vengeful Totem of Third WInd
(43737,   0,  7, 0x00000000, 0x00000440, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  10000, 0), -- Primal Instinct
(43739,   0,  7, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Lunar Grace
(43741,   0, 10, 0x80000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Light's Grace
(43745,   0, 10, 0x00000000, 0x00000200, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Crusader's Command
(43748,   0, 11, 0x90100000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Elemental Strength
(43750,   0, 11, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Energized
(43819,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Lucidity
(44543,   0,  3, 0x00100220, 0x00001000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   7,      0, 0), -- Fingers of Frost
(44545,   0,  3, 0x00100220, 0x00001000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,  15,      0, 0), -- Fingers of Frost
(45054,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  15000, 0), -- Augment Pain
(45354,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Sunwell Dungeon Melee Trinket
(45355,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - T7 Melee Trinket Base
(45469,   0, 15, 0x00000010, 0x00000000, 0x00000000,      16, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Death Strike
(45481,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Sunwell Exalted Caster Neck
(45482,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Sunwell Exalted Melee Neck
(45483,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Sunwell Exalted Tank Neck
(45484,   0,  0, 0x00000000, 0x00000000, 0x00000000,   16384, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Sunwell Exalted Healer Neck
(46025,  32,  6, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Blackout
(46092,   0, 10, 0x40000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Brutal Libram of Justice
(46098,   0, 11, 0x00000080, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Brutal Totem of Third WInd
(46569,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Sunwell Exalted Caster Neck
(46662,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  20000, 0), -- Deathfrost
(46832,   0,  7, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Moonkin Starfire Bonus
(46910,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,5.5,   0,      0, 0), -- Furious Attacks
(46911,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,7.5,   0,      0, 0), -- Furious Attacks
(47981,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  2048, 0x0,  0,   0,      0, 0), -- Spell Reflection
(48833,   0,  7, 0x00000000, 0x00000440, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Primal Instinct
(48835,   0, 10, 0x00800000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x2,  0,   0,      0, 0), -- Justice
(48837,   0, 11, 0x90100000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Elemental Tenacity
(49592,   0,  0, 0x00000000, 0x00000000, 0x00000000, 8528552, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Temporal Rift
(49622,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  60000, 0), -- Bonus Mana Regen
(50240,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    16, 0x0,  0,   0,      0, 0), -- Evasive Maneuvers
(50421,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Scent of Blood
(50781,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,   6000, 0), -- Fate Rune of Primal Energy
(51123,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  1,   0,      0, 0), -- Killing Machine
(51127,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  2,   0,      0, 0), -- Killing Machine
(51128,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  4,   0,      0, 0), -- Killing Machine
(51129,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  6,   0,      0, 0), -- Killing Machine
(51130,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  8,   0,      0, 0), -- Killing Machine
(51346,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,  10000, 0), -- Venture Company Beatdown!
(51349,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,  10000, 0), -- Venture Company Beatdown
(51352,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,  10000, 0), -- Venture Company Beatdown!
(51359,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1,  0,   0,  10000, 0), -- Venture Company Beatdown
(51414,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,  45000, 0), -- Venomous Breath Aura
(51915,   0,  0, 0x00000000, 0x00000000, 0x00000000,16777216, 0x0, 0x0,     0, 0x0,  0, 100, 600000, 0), -- Undying Resolve
(52020,   0,  7, 0x00008000, 0x00100000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Snap and Snarl
(52423,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    32, 0x0,  0,   0,      0, 0), -- Retaliation
(52898,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     2, 0x0,  0,   0,      0, 0), -- Spell Damping
(53386,   0, 15, 0x82127F27, 0x000001BF, 0x00000000,       0, 0x1, 0x2,     0, 0x2,  0,   0,      0, 0), -- Cinderglacier
(53397,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Invigoration
(54278,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Empowered Imp
(54646,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Focus Magic
(54695,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Death Knight's Anguish Base
(54707,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  60000, 0), -- Sonic Awareness (DND)
(54738,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Star of Light
(54808,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,  60000, 0), -- Sonic Shield
(54838,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Purified Spirit
(54841,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,   2500, 0), -- Thunder Capacitor
(54925,   2, 10, 0x00000000, 0x00000200, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Seal of Command
(55380,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  40000, 0), -- Skyflare Swiftness (Thundering Skyflare Diamond)
(55381,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  15000, 0), -- Mana Restore
(55640,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Lightweave Embroidery
(55680,   0,  6, 0x00000200, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Prayer of Healing
(55681,   0,  6, 0x00008000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Shadow Word: Pain
(55689,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Glyph of Shadow
(55747,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Argent Fury
(55768,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Darkglow Embroidery
(55776,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Swordguard Embroidery
(56249,   0,  5, 0x00000000, 0x00000000, 0x00000400,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Felhunter
(56355,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    64, 0x0,  0,   0,      0, 0), -- Titanium Shield Spike
(56364,   0,  3, 0x00000000, 0x01000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Remove Curse
(56451,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   3000, 0), -- Earth Shield
(56816,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    48, 0x0,  0,   0,      0, 0), -- Rune Strike
(56817,   0, 15, 0x00000000, 0x20000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Rune strike proc (SERVERSIDE)
(56821,   0,  8, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Glyph of Sinister Strike
(56841,   0,  9, 0x00000800, 0x00000000, 0x00000000,     256, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Arcane Shot
(57345,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Darkmoon Card: Greatness
(57352,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Darkmoon Card: Death
(57907,   0,  7, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Increased Spirit
(57989,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Shadowfiend Death
(58357,   0,  4, 0x00000040, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Glyph of Heroic Strike
(58364,   0,  4, 0x00000400, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Revenge
(58372,   0,  4, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Hamstring
(58386,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,    32, 0x0,  0,   0,      0, 0), -- Glyph of Overpower
(58442,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  15000, 0), -- Airy Pale Ale
(58444,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,   5000, 0), -- Worg Tooth Oatmeal Stout
(58616,   0, 15, 0x01000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Heart Strike
(58620,   0, 15, 0x00000004, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Chains of Ice
(58626,   0, 15, 0x02000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Death Grip
(58901,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Tears of Anguish
(59176,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     2, 0x0,  0,   0,      0, 0), -- Spell Damping
(59327,   0, 15, 0x08000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Rune Tap
(59345,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Chagrin
(59630,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  35000, 0), -- Black Magic
(59725,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,  2048, 0x0,  0,   0,      0, 0), -- Spell Reflection
(60061,   0,  0, 0x00000000, 0x00000000, 0x00000000,  294912, 0x2, 0x0,     0, 0x0,  0,   0,  45000, 0), -- Flow of Time
(60063,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Now is the Time!
(60066,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Rage of the Unraveller
(60132,   0, 15, 0x00000010, 0x08020000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Oblit/Scourge Strike Runic Power Up
(60170,   0,  5, 0x00000006, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Corruption Triggers Crit
(60172,   0,  5, 0x00040000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Life Tap Bonus Spirit
(60176,   0,  4, 0x00000020, 0x00000010, 0x00000000,  262144, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Bleed Cost Reduction
(60221,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  45000, 0), -- Essence of Gossamer
(60301,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Meteorite Whetstone
(60306,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Vestige of Haldor
(60317,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Signet of Edward the Odd
(60436,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Grim Toll
(60442,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Bandit's Insignia
(60473,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Forge Ember
(60482,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Pendulum of Telluric Currents
(60487,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,  15000, 0), -- Extract of Necromatic Power
(60490,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Embrace of the Spider
(60493,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Dying Curse
(60503,   1,  4, 0x00000004, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Taste for Blood
(60519,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x3, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Spark of Life
(60524,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Majestic Dragon Figurine
(60529,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Forethought Talisman
(60537,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Soul of the Dead
(60564,   0, 11, 0x90100000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Savage Gladiator's Totem of Survival
(60571,   0, 11, 0x90100000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Hateful Gladiator's Totem of Survival
(60572,   0, 11, 0x90100000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Deadly Gladiator's Totem of Survival
(60573,   0, 11, 0x90100000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- LK Arena 4 Gladiator's Totem of Survival
(60574,   0, 11, 0x90100000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- LK Arena 5 Gladiator's Totem of Survival
(60575,   0, 11, 0x90100000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- LK Arena 6 Gladiator's Totem of Survival
(60710,   0,  7, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Savage Gladiator's Idol of Steadfastness
(60717,   0,  7, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Hateful Gladiator's Idol of Steadfastness
(60719,   0,  7, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Deadly Gladiator's Idol of Steadfastness
(60722,   0,  7, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- LK Arena 4 Gladiator's Idol of Steadfastness
(60724,   0,  7, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- LK Arena 5 Gladiator's Idol of Steadfastness
(60726,   0,  7, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- LK Arena 6 Gladiator's Idol of Steadfastness
(60770,   0, 11, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Totem of the Elemental Plane
(60818,   0, 10, 0x00000000, 0x00000200, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Libram of Reciprocation
(60826,   0, 15, 0x01400000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Sigil of Haunted Dreams
(61188,   0,  5, 0x00000004, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Chaotic Mind
(61324,   0, 10, 0x00000000, 0x00020000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Justice
(61356,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  90000, 0), -- Invigorating Earthsiege Diamond Passive
(61618,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Tentacles
(61848,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    16, 0x0,  0,   0,      0, 0), -- Aspect of the Dragonhawk
(62114,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Flow of Knowledge
(62115,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Strength of the Titans
(62147,   0, 15, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Icy Touch Defense Increase
(62459,   0, 15, 0x00000004, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Chains of Ice Frost Rune Refresh
(63086,   0,  9, 0x00000000, 0x00000000, 0x00010000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Raptor Strike
(63108,   0,  5, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Siphon Life
(63251,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Glory of the Jouster
(63310,   0,  5, 0x00000000, 0x00010000, 0x00000000,   65536, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Shadowflame
(63335,   0, 15, 0x00000000, 0x00000002, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Glyph of Howling Blast
(63611,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x1,  0,   0,      0, 0), -- Improved Blood Presence
(64343,   0,  3, 0x00000002, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Impact
(64411,   0,  0, 0x00000000, 0x00000000, 0x00000000,  279552, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Blessing of Ancient Kings
(64415,   0,  0, 0x00000000, 0x00000000, 0x00000000,  279552, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Val'anyr Hammer of Ancient Kings - Equip Effect
(64440,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    32, 0x0,  0,   0,  20000, 0), -- Blade Warding
(64571,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,  10000, 0), -- Blood Draining
(64714,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Flame of the Heavens
(64738,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Show of Faith
(64742,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Pandora's Plea
(64752,   0,  7, 0x00001000, 0x00000100, 0x00200000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Druid T8 Feral 2P Bonus
(64786,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Comet's Trail
(64792,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Blood of the Old God
(64824,   0,  7, 0x00200000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Druid T8 Balance 4P Bonus
(64860,   0,  9, 0x00000000, 0x00000001, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Hunter T8 4P Bonus
(64867,   0,  3, 0x20000021, 0x00001000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Mage T8 2P Bonus
(64882,   0, 10, 0x00000000, 0x00100000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Paladin T8 Protection 4P Bonus
(64908,   0,  6, 0x00002000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Priest T8 Shadow 4P Bonus
(64912,   0,  6, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Priest T8 Healer 4P Bonus
(64914,   0,  8, 0x00010000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Rogue T8 2P Bonus
(64938,   0,  4, 0x00200040, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,      0, 0), -- Item - Warrior T8 Melee 2P Bonus
(64952,   0,  7, 0x00000000, 0x00000440, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Druid T8 Feral Relic
(64955,   0, 10, 0x00000000, 0x00000040, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Paladin T8 Protection Relic
(64964,   0, 15, 0x00000000, 0x20000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Death Knight T8 Tank Relic
(64976,   0,  4, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Juggernaut
(64999,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x4,  0,   0,      0, 0), -- Meteoric Inspiration
(65002,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Bonus Mana Regen
(65005,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x1,     0, 0x0,  0,   0,  45000, 0), -- Alacrity of the Elements
(65007,   0,  0, 0x00000000, 0x00000000, 0x00000000,   81920, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Eye of the Broodmother
(65013,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Pyrite Infusion
(65020,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Mjolnir Runestone
(65025,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Dark Matter
(66808,   0,  0, 0x00000000, 0x00000000, 0x00000000,       4, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Meteor Fists
(67115,   0, 15, 0x01400000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Death Knight T9 Melee 2P Bonus
(67151,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Hunter T9 4P Bonus (Steady Shot)
(67209,   1,  8, 0x00100000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Rogue T9 2P Bonus (Rupture)
(67353,   0,  7, 0x00008000, 0x00100500, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Druid T9 Feral Relic (Lacerate, Swipe, Mangle, and Shred)
(67356,   8,  7, 0x00000010, 0x00000000, 0x00000000,       0, 0x2, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Druid T9 Restoration Relic (Rejuvenation)
(67361,   0,  7, 0x00000002, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Druid T9 Balance Relic (Moonfire)
(67363,   0, 10, 0x80000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  10000, 0), -- Item - Paladin T9 Holy Relic (Judgement)
(67365,   0, 10, 0x00000000, 0x00000800, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,   6000, 0), -- Item - Paladin T9 Retribution Relic (Seal of Vengeance)
(67379,   0, 10, 0x00000000, 0x00040000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Paladin T9 Protection Relic (Hammer of The Righteous)
(67381,   0, 15, 0x00000000, 0x20000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  10000, 0), -- Item - Death Knight T9 Tank Relic (Rune Strike)
(67384,   0, 15, 0x00000010, 0x08020000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,  80,  10000, 0), -- Item - Death Knight T9 Melee Relic (Rune Strike)
(67386,   0, 11, 0x00000001, 0x00000000, 0x00000000,   65536, 0x0, 0x1,     0, 0x0,  0,   0,   6000, 0), -- Item - Shaman T9 Elemental Relic (Lightning Bolt)
(67389,   0, 11, 0x00000100, 0x00000000, 0x00000000,   16384, 0x0, 0x1,     0, 0x0,  0,   0,   8000, 0), -- Item - Shaman T9 Restoration Relic (Chain Heal)
(67392,   0, 11, 0x00000000, 0x00000000, 0x00000004,      16, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Shaman T9 Enhancement Relic (Lava Lash)
(67653,   0,  0, 0x00000000, 0x00000000, 0x00000000, 4194344, 0x1, 0x0,     0, 0x0,  0,   0,  45000, 0), -- Coliseum 5 Tank Trinket
(67667,   0,  0, 0x00000000, 0x00000000, 0x00000000,   16384, 0x2, 0x1,     0, 0x0,  0,   0,  45000, 0), -- Coliseum 5 Healer Trinket
(67670,   0,  0, 0x00000000, 0x00000000, 0x00000000,   65536, 0x1, 0x1,     0, 0x0,  0,   0,  45000, 0), -- Coliseum 5 CasterTrinket
(67672,   0,  0, 0x00000000, 0x00000000, 0x00000000, 8388948, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Coliseum 5 Melee Trinket
(67698,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Item - Coliseum 25 Normal Healer Trinket
(67702,   1,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Coliseum 25 Normal Melee Trinket
(67712,   0,  0, 0x00000000, 0x00000000, 0x00000000,   69632, 0x0, 0x2,     2, 0x0,  0,   0,   2000, 0), -- Item - Coliseum 25 Normal Caster Trinket
(67752,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Item - Coliseum 25 Heroic Healer Trinket
(67758,   0,  0, 0x00000000, 0x00000000, 0x00000000,   69632, 0x0, 0x2,     2, 0x0,  0,   0,   2000, 0), -- Item - Coliseum 25 Heroic Caster Trinket
(67771,   1,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Coliseum 25 Heroic Melee Trinket
(68051,   1,  4, 0x00000004, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Overpower Ready!
(68160,   0,  0, 0x00000000, 0x00000000, 0x00000000,       4, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Meteor Fists
(70188,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,    16, 0x0,  0,   0,      0, 0), -- Cloak of Darkness
(70652,   0, 15, 0x00000008, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Death Knight T10 Tank 4P Bonus
(70727,   0,  9, 0x00000001, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Hunter T10 2P Bonus
(70730,   0,  9, 0x00004000, 0x00001000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Hunter T10 4P Bonus
(70748,   0,  3, 0x00000000, 0x00200000, 0x00000000,    1024, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Mage T10 4P Bonus
(70756,   0, 10, 0x00000000, 0x00010000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Paladin T10 Holy 4P Bonus
(70761,   0, 10, 0x00000000, 0x00000000, 0x00000001,    1024, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Paladin T10 Protection 4P Bonus
(70803,   0,  8, 0x003E0000, 0x00000008, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Rogue T10 4P Bonus
(70807,   0, 11, 0x00000000, 0x00000000, 0x00000010,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Shaman T10 Restoration 2P Bonus
(70811,   0, 11, 0x00000003, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Shaman T10 Elemental 2P Bonus
(70830,   0, 11, 0x00000000, 0x00020000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Shaman T10 Enhancement 2P Bonus
(70841,   0,  5, 0x00000004, 0x00000100, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Warlock T10 4P Bonus
(70854,   0,  4, 0x00000000, 0x00000010, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Warrior T10 Melee 2P Bonus
(71174,   1,  7, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Druid T10 Feral Relic (Rake and Lacerate)
(71176,   0,  7, 0x00200002, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Druid T10 Balance Relic (Moonfire and Insect Swarm)
(71178,   0,  7, 0x00000010, 0x00000000, 0x00000000,       0, 0x2, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Druid T10 Restoration Relic (Rejuvenation)
(71186,   0, 10, 0x00000000, 0x00008000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Paladin T10 Retribution Relic (Crusader Strike)
(71191,   0, 10, 0x00000000, 0x00010000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Paladin T10 Holy Relic (Holy Shock)
(71194,   0, 10, 0x00000000, 0x00100000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Paladin T10 Protection Relic (Shield of Righteousness)
(71198,   4, 11, 0x10000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0,  0,   0,      0, 0), -- Item - Shaman T10 Elemental Relic (Shocks)
(71214,   0, 11, 0x00000000, 0x00000010, 0x00000000,      16, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Shaman T10 Enhancement Relic (Stormstrike)
(71217,   0, 11, 0x00000000, 0x00000000, 0x00000010,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Shaman T10 Restoration Relic (Riptide)
(71226,   0, 15, 0x00000010, 0x08020000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Death Knight T10 DPS Relic (Obliterate, Scourge Strike, Death Strike)
(71228,   0, 15, 0x00000000, 0x20000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,      0, 0), -- Item - Death Knight T10 Tank Relic (Runestrike)
(71402,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Icecrown 10 Normal Melee Trinket
(71404,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     2, 0x0,  0,   0,  45000, 0), -- Item - Icecrown Dungeon Melee Trinket
(71540,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Icecrown 10 Heroic Melee Trinket
(71585,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0,  0,   0,  45000, 0), -- Item - Icecrown 25 Emblem Healer Trinket
(71602,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x1,     0, 0x0,  0,   0,  45000, 0), -- Item - Icecrown 25 Normal Caster Trinket 1 Base
(71606,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0, 100000, 0), -- Item - Icecrown 25 Normal Caster Trinket 2
(71611,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Icecrown 25 Normal Healer Trinket 2
(71637,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0,  0,   0, 100000, 0), -- Item - Icecrown 25 Heroic Caster Trinket 2
(71642,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Icecrown 25 Heroic Healer Trinket 2
(71645,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x1,     0, 0x0,  0,   0,  45000, 0), -- Item - Icecrown 25 Heroic Caster Trinket 1 Base
(71903,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0, 12,   0,      0, 0), -- Item - Shadowmourne Legendary
(72413,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,  10,  60000, 0), -- Item - Icecrown Reputation Ring Melee
(72417,   0,  0, 0x00000000, 0x00000000, 0x00000000,  327680, 0x0, 0x2,     0, 0x0,  0,   0,  60000, 0), -- Item - Icecrown Reputation Ring Caster Trigger
(72419,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  60000, 0), -- Item - Icecrown Reputation Ring Healer Trigger
(74396,  84,  3, 0x28E212F7, 0x00119048, 0x00000000,   65536, 0x0, 0x1,     0, 0x0,  0,   0,      0, 0), -- Fingers of Frost
(75455,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Chamber of Aspects 25 Melee Trinket
(75457,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0,  0,   0,  45000, 0), -- Item - Chamber of Aspects 25 Heroic Melee Trinket
(75465,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x1,     0, 0x0,  0,   0,  45000, 0), -- Item - Chamber of Aspects 25 Nuker Trinket
(75474,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x1,     0, 0x0,  0,   0,  45000, 0); -- Item - Chamber of Aspects 25 Heroic Nuker Trinket

-- Spell script names for DK proc handlers
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_dk_butchery', 'spell_dk_mark_of_blood', 'spell_dk_unholy_blight', 'spell_dk_vendetta', 'spell_dk_necrosis', 'spell_dk_runic_power_back_on_snare_root');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-48979, 'spell_dk_butchery'),              -- Butchery (all ranks)
(49005, 'spell_dk_mark_of_blood'),          -- Mark of Blood
(49194, 'spell_dk_unholy_blight'),          -- Unholy Blight
(50154, 'spell_dk_vendetta'),               -- Vendetta
(-51459, 'spell_dk_necrosis'),              -- Necrosis (all ranks)
(61257, 'spell_dk_runic_power_back_on_snare_root'); -- Runic Power Back on Snare/Root

-- Spell script names for Druid proc handlers
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_dru_glyph_of_innervate', 'spell_dru_glyph_of_rake', 'spell_dru_leader_of_the_pack', 'spell_dru_glyph_of_rejuvenation', 'spell_dru_eclipse');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(54832, 'spell_dru_glyph_of_innervate'),    -- Glyph of Innervate
(54821, 'spell_dru_glyph_of_rake'),         -- Glyph of Rake
(24932, 'spell_dru_leader_of_the_pack'),    -- Leader of the Pack
(54754, 'spell_dru_glyph_of_rejuvenation'), -- Glyph of Rejuvenation
(-48516, 'spell_dru_eclipse');              -- Eclipse (all ranks)

-- Spell script names for Rogue proc handlers
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_rog_glyph_of_backstab', 'spell_rog_master_of_subtlety', 'spell_rog_cut_to_the_chase', 'spell_rog_deadly_brew', 'spell_rog_quick_recovery');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56800, 'spell_rog_glyph_of_backstab'),     -- Glyph of Backstab
(31666, 'spell_rog_master_of_subtlety'),    -- Master of Subtlety (periodic tracker)
(-35541, 'spell_rog_cut_to_the_chase'),     -- Cut to the Chase (all ranks)
(-51625, 'spell_rog_deadly_brew'),          -- Deadly Brew (all ranks)
(-31244, 'spell_rog_quick_recovery');       -- Quick Recovery (all ranks)

-- Spell script names for Hunter proc handlers
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_hun_thrill_of_the_hunt', 'spell_hun_hunting_party', 'spell_hun_rapid_recuperation', 'spell_hun_glyph_of_mend_pet');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-34497, 'spell_hun_thrill_of_the_hunt'),   -- Thrill of the Hunt (all ranks)
(-53290, 'spell_hun_hunting_party'),        -- Hunting Party (all ranks)
(53228, 'spell_hun_rapid_recuperation'),    -- Rapid Recuperation Rank 1
(53232, 'spell_hun_rapid_recuperation'),    -- Rapid Recuperation Rank 2
(57870, 'spell_hun_glyph_of_mend_pet');     -- Glyph of Mend Pet

-- Spell script names for Paladin proc handlers
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_pal_judgements_of_the_wise', 'spell_pal_righteous_vengeance', 'spell_pal_sheath_of_light', 'spell_pal_judgement_of_light_heal', 'spell_pal_judgement_of_wisdom_mana', 'spell_pal_spiritual_attunement', 'spell_pal_glyph_of_holy_light_proc');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-31876, 'spell_pal_judgements_of_the_wise'),  -- Judgements of the Wise (all ranks)
(-53380, 'spell_pal_righteous_vengeance'),     -- Righteous Vengeance (all ranks)
(-53501, 'spell_pal_sheath_of_light'),         -- Sheath of Light (all ranks)
(20185, 'spell_pal_judgement_of_light_heal'),  -- Judgement of Light (debuff)
(20186, 'spell_pal_judgement_of_wisdom_mana'), -- Judgement of Wisdom (debuff)
(31785, 'spell_pal_spiritual_attunement'),     -- Spiritual Attunement Rank 1
(33776, 'spell_pal_spiritual_attunement'),     -- Spiritual Attunement Rank 2
(54937, 'spell_pal_glyph_of_holy_light_proc'); -- Glyph of Holy Light

-- Spell script names for Shaman proc handlers
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_sha_glyph_of_healing_wave', 'spell_sha_spirit_hunt', 'spell_sha_frozen_power', 'spell_sha_lightning_overload', 'spell_sha_ancestral_awakening');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(55440, 'spell_sha_glyph_of_healing_wave'),    -- Glyph of Healing Wave
(58877, 'spell_sha_spirit_hunt'),              -- Spirit Hunt
(-63373, 'spell_sha_frozen_power'),            -- Frozen Power (all ranks)
(-30675, 'spell_sha_lightning_overload'),      -- Lightning Overload (all ranks)
(-51474, 'spell_sha_ancestral_awakening');     -- Ancestral Awakening (all ranks)

-- Spell script names for Priest proc handlers
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_pri_vampiric_embrace', 'spell_pri_glyph_of_dispel_magic', 'spell_pri_body_and_soul', 'spell_pri_improved_shadowform');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(15286, 'spell_pri_vampiric_embrace'),         -- Vampiric Embrace
(55677, 'spell_pri_glyph_of_dispel_magic'),    -- Glyph of Dispel Magic
(-64127, 'spell_pri_body_and_soul'),           -- Body and Soul (all ranks)
(47569, 'spell_pri_improved_shadowform'),      -- Improved Shadowform Rank 1
(47570, 'spell_pri_improved_shadowform');      -- Improved Shadowform Rank 2

-- Spell script names for Warlock proc handlers
-- Note: Nightfall uses -18094 with 'spell_warl_glyph_of_corruption_nightfall' (covers all ranks)
-- Glyph of Corruption (56218) also uses same script via RegisterSpellScriptWithArgs

-- ============================================================================
-- Phase 2: Migrate spell_proc_event entries with non-default values to spell_proc
-- These 68 entries have procFlags, ppmRate, customChance, or Cooldown set
-- ============================================================================

-- First delete any existing entries that might conflict
DELETE FROM `spell_proc` WHERE `SpellId` IN (
    -31641, -16689, 4524, 9452, 15257, 15331, 15332, 16372, 21747,
    24256, 26016, 27539, 27997, 28460, 29307, 31221, 31222, 31223, 33511,
    33522, 35399, 37565, 38319, 40303, 42760, 43730, 43983, 44546, 44548,
    44549, 44835, 45278, 45396, 45398, 45444, 46102, 49027, 49542, 49543,
    50871, 52881, 54404, 55610, 55717, 56845, 57351, 58426, 59887, 59888,
    59889, 59890, 59891, 60617, 62337, 64764, 64936, 66865, 66889,
    67530, 70871, 71567, 71604, 72256, 72673, 72674, 72675
);

-- Insert migrated entries from spell_proc_event
-- Schema: SpellId, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2,
--         ProcFlags, SpellTypeMask, SpellPhaseMask, HitMask, AttributesMask, ProcsPerMinute, Chance, Cooldown, Charges
DELETE FROM `spell_proc` WHERE `SpellId` IN (-31641,-16689,4524,9452);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
-- Blazing Speed (Mage) - procFlags=680 (TAKEN_MELEE_AUTO_ATTACK|TAKEN_DAMAGE)
(-31641,  0, 0, 0x00000000, 0x00000000, 0x00000000,     680, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Shadow Weaving (Priest) - Cooldown=1000
(-16689,  0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0,  1000, 0),
-- -16086 removed - TC doesn't have this entry, let DBC defaults handle it
-- Cure Ailments (Pet) - procFlags=1048576 (TAKEN_SPELL_MAGIC_DMG_CLASS)
(4524,    0, 0, 0x00000000, 0x00000000, 0x00000000, 1048576, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Duelist's Riposte - ppmRate=3.0
(9452,    0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 3,   0,     0, 0),
-- Shadow Weaving Rank 1 - procFlags=327680 (DONE_SPELL_MAGIC_DMG_CLASS), customChance=33
(15257,   0, 0, 0x00000000, 0x00000000, 0x00000000,  327680, 0x0, 0x0, 0, 0x0, 0,  33,     0, 0),
-- Shadow Weaving Rank 2 - procFlags=327680, customChance=66
(15331,   0, 0, 0x00000000, 0x00000000, 0x00000000,  327680, 0x0, 0x0, 0, 0x0, 0,  66,     0, 0),
-- Shadow Weaving Rank 3 - procFlags=327680, customChance=100
(15332,   0, 0, 0x00000000, 0x00000000, 0x00000000,  327680, 0x0, 0x0, 0, 0x0, 0, 100,     0, 0),
-- Ancestral Fortitude (Shaman) - procFlags=131072, customChance=100
(16372,   0, 0, 0x00000000, 0x00000000, 0x00000000,  131072, 0x0, 0x0, 0, 0x0, 0, 100,     0, 0),
-- Lawbringer - procFlags=20, ppmRate=20.0, Cooldown=50000 (AC #10402)
(21747,   0, 0, 0x00000000, 0x00000000, 0x00000000,      20, 0x0, 0x0, 0, 0x0,20,   0, 50000, 0),
-- Blessing of the Claw - Cooldown=240000 (4 min)
(24256,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0,240000, 0),
-- Thorn Shield - ppmRate=2.0
(26016,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 2,   0,     0, 0),
-- Thick Chitin - Cooldown=10000
(27539,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 10000, 0),
-- Bloodgorged - Cooldown=50000
(27997,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 50000, 0),
-- Monstrous Vitality - Cooldown=5000
(28460,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0,  5000, 0),
-- Arcane Power (Boss) - procFlags=4, customChance=100
(29307,   0, 0, 0x00000000, 0x00000000, 0x00000000,       4, 0x0, 0x0, 0, 0x0, 0, 100,     0, 0),
-- NOTE: Master of Subtlety spell_proc entries removed - TC uses script on 31666 (periodic tracker) instead of talent proc
-- If this causes regressions, uncomment these entries:
-- (31221,   0, 0, 0x00000000, 0x00000000, 0x00000000,    1024, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0), -- Master of Subtlety Rank 1
-- (31222,   0, 0, 0x00000000, 0x00000000, 0x00000000,    1024, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0), -- Master of Subtlety Rank 2
-- (31223,   0, 0, 0x00000000, 0x00000000, 0x00000000,    1024, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0), -- Master of Subtlety Rank 3
-- Zandalarian Hero Charm - Cooldown=17000
(33511,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 17000, 0),
-- Idol of the Raven Goddess - Cooldown=25000
(33522,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 25000, 0),
-- Inspiration (Priest) - procFlags=131072
(35399,   0, 0, 0x00000000, 0x00000000, 0x00000000,  131072, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Blessing of the Onyx Serpent - procFlags=16384
(37565,   0, 0, 0x00000000, 0x00000000, 0x00000000,   16384, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Thundering Rage - Cooldown=50000
(38319,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 50000, 0),
-- Ashtongue Talisman of Acumen - Cooldown=1000
(40303,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0,  1000, 0),
-- Focused Assault - procFlags=245966, customChance=20
(42760,   0, 0, 0x00000000, 0x00000000, 0x00000000,  245966, 0x0, 0x0, 0, 0x0, 0,  20,     0, 0),
-- Spirit Wolf - Cooldown=8000
(43730,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0,  8000, 0),
-- Enchant Cloak - Steelweave - procFlags=81920, customChance=100, Cooldown=600
(43983,   0, 0, 0x00000000, 0x00000000, 0x00000000,   81920, 0x0, 0x0, 0, 0x0, 0, 100,   600, 0),
-- Brain Freeze Rank 1 - procFlags=69632, customChance=5, Cooldown=3000
(44546,   0, 0, 0x00000000, 0x00000000, 0x00000000,   69632, 0x0, 0x0, 0, 0x0, 0,   5,  3000, 0),
-- Brain Freeze Rank 2 - procFlags=69632, customChance=10, Cooldown=3000
(44548,   0, 0, 0x00000000, 0x00000000, 0x00000000,   69632, 0x0, 0x0, 0, 0x0, 0,  10,  3000, 0),
-- Brain Freeze Rank 3 - procFlags=69632, customChance=15, Cooldown=3000
(44549,   0, 0, 0x00000000, 0x00000000, 0x00000000,   69632, 0x0, 0x0, 0, 0x0, 0,  15,  3000, 0),
-- Maim Interrupt - procFlags=16
(44835,   0, 0, 0x00000000, 0x00000000, 0x00000000,      16, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Improved Water Shield - procFlags=82944
(45278,   0, 0, 0x00000000, 0x00000000, 0x00000000,   82944, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Blessed Book of Nagrand - Cooldown=45000
(45396,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 45000, 0),
-- Memento of Tyrande - Cooldown=45000
(45398,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 45000, 0),
-- Tome of the Lightbringer - Cooldown=45000
(45444,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 45000, 0),
-- Forked Lightning - procFlags=81920
(46102,   0, 0, 0x00000000, 0x00000000, 0x00000000,   81920, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Wandering Plague Rank 1 - customChance=3, Cooldown=20000
(49027,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   3, 20000, 0),
-- Wandering Plague Rank 2 - customChance=6, Cooldown=20000
(49542,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   6, 20000, 0),
-- Wandering Plague Rank 3 - customChance=9, Cooldown=20000
(49543,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   9, 20000, 0),
-- Divine Storm - customChance=100
(50871,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0, 100,     0, 0),
-- Blade Warding - Cooldown=12000
(52881,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 12000, 0),
-- Rapid Killing - customChance=100
(54404,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0, 100,     0, 0),
-- Imp Devotion - procFlags=4096
(55610,   0, 0, 0x00000000, 0x00000000, 0x00000000,    4096, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Berserking - Cooldown=5000
(55717,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0,  5000, 0),
-- Glyph of Scourge Strike - procFlags=2097152
(56845,   0, 0, 0x00000000, 0x00000000, 0x00000000, 2097152, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Fel Vitality - procFlags=1782780
(57351,   0, 0, 0x00000000, 0x00000000, 0x00000000, 1782780, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Overkill - procFlags=1024
(58426,   0, 0, 0x00000000, 0x00000000, 0x00000000,    1024, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Frostfire Orb Rank 1 - procFlags=87040
(59887,   0, 0, 0x00000000, 0x00000000, 0x00000000,   87040, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Frostfire Orb Rank 2 - procFlags=87040
(59888,   0, 0, 0x00000000, 0x00000000, 0x00000000,   87040, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Frostfire Orb Rank 3 - procFlags=87040
(59889,   0, 0, 0x00000000, 0x00000000, 0x00000000,   87040, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Frostfire Orb Rank 4 - procFlags=87040
(59890,   0, 0, 0x00000000, 0x00000000, 0x00000000,   87040, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Frostfire Orb Rank 5 - procFlags=87040
(59891,   0, 0, 0x00000000, 0x00000000, 0x00000000,   87040, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Rage of Thassarian - customChance=100
(60617,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0, 100,     0, 0),
-- Petrified Bark (Normal) - procFlags=40
(62337,   0, 0, 0x00000000, 0x00000000, 0x00000000,      40, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- 62933 removed - TC doesn't have this entry, let DBC defaults handle it
-- Dying Curse - Cooldown=50000
(64764,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0, 50000, 0),
-- Glyph of Scourge Strike - procFlags=69632, customChance=100
(64936,   0, 0, 0x00000000, 0x00000000, 0x00000000,   69632, 0x0, 0x0, 0, 0x0, 0, 100,     0, 0),
-- Talisman of the Forsaken City - customChance=35, Cooldown=3000
(66865,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,  35,  3000, 0),
-- Mana Shield - procFlags=4, customChance=100
(66889,   0, 0, 0x00000000, 0x00000000, 0x00000000,       4, 0x0, 0x0, 0, 0x0, 0, 100,     0, 0),
-- Thorns - procFlags=40, Cooldown=5000
(67530,   0, 0, 0x00000000, 0x00000000, 0x00000000,      40, 0x0, 0x0, 0, 0x0, 0,   0,  5000, 0),
-- Devious Minds - procFlags=69972, customChance=100
(70871,   0, 0, 0x00000000, 0x00000000, 0x00000000,   69972, 0x0, 0x0, 0, 0x0, 0, 100,     0, 0),
-- Mutated Plague - Cooldown=250
(71567,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0,   0,   250, 0),
-- Deathbringer's Will Normal - customChance=100, Cooldown=10000
(71604,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0, 100, 10000, 0),
-- Crimson Scourge - procFlags=4
(72256,   0, 0, 0x00000000, 0x00000000, 0x00000000,       4, 0x0, 0x0, 0, 0x0, 0,   0,     0, 0),
-- Deathbringer's Will Heroic 1 - customChance=100, Cooldown=10000
(72673,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0, 100, 10000, 0),
-- Deathbringer's Will Heroic 2 - customChance=100, Cooldown=10000
(72674,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0, 100, 10000, 0),
-- Deathbringer's Will Heroic 3 - customChance=100, Cooldown=10000
(72675,   0, 0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0, 0, 0x0, 0, 100, 10000, 0);

-- Additional spell_proc entries from TrinityCore (missing in AzerothCore)
-- These entries provide refined proc configuration from TC's spell_proc table
DELETE FROM `spell_proc` WHERE `SpellId` IN (-59887,-53583,-51682,-49200,-47230,-31226,-30482,-16689,-14143,-12317,-11103,-7302,-7001,-1120,-588,-168,4341,5118,12043,12328,13159,13234,16166,17116,17670,18708,20911,21084,23591,32065,35321,36659,37604,38363,39215,40816,41350,45092,48504,50871,50908,53257,53515,53651,53817,57529,57531,58501,60617,63057,63849,70656,70904,71567,71571,71573,71865,71868,71993,72059,75490,75495);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
-- Negative SpellId entries (applies to all spell ranks)
(-59887,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0, 0, 0,   0,     0, 0), -- Frostfire Orb (all ranks)
(-53583,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0, 0, 0,   0,     0, 0), -- Swift Retribution (all ranks)
(-51682,  0,  8, 0x00000000, 0x00080000, 0x00000000,       0, 0x4, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Rogue Deadly Brew (all ranks)
(-49200,126,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x2, 0, 0,   0,     0, 0), -- Dispersion (all ranks)
(-47230,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Fel Synergy (all ranks)
(-31226,  0,  8, 0x00000000, 0x00080000, 0x00000000,       0, 0x5, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Rogue Deadly Poison (all ranks)
(-30482,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,  1027, 0x2, 0, 0,   0,     0, 0), -- Molten Shields (all ranks)
(-16689,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0, 0, 0,   0,  1000, 0), -- Nature's Grasp (all ranks)
(-14143,  0,  8, 0x47046286, 0x00200000, 0x00000000,       0, 0x1, 0x2,     0, 0x8, 0, 0,   0,     0, 0), -- Rogue Relentless Strikes (all ranks)
(-12317,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0, 0, 0,   0,     0, 0), -- Enrage (all ranks)
(-11103,  0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x0, 0, 0,   0,     0, 0), -- World in Flames (all ranks)
(-7302,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,  1027, 0x2, 0, 0,   0,     0, 0), -- Frost Armor (all ranks)
(-7001,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x2, 0, 0,   0,     0, 0), -- Lightwell Renew (all ranks)
(-1120,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x1, 3, 0,   0,     0, 0), -- Drain Soul (all ranks)
(-588,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x0, 0, 0,   0,     0, 0), -- Inner Fire (all ranks)
(-168,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,  1027, 0x2, 0, 0,   0,     0, 0), -- Frost Armor (all ranks)
-- Positive SpellId entries (specific spells)
(4341,    0,  0, 0x00000000, 0x00000000, 0x00000000,    4096, 0x1, 0x1,     0, 0x0, 0, 0,   0,     0, 0), -- Flame Buffet
(5118,    0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x2, 0, 0,   0,     0, 0), -- Aspect of the Cheetah
(12043,   0,  3, 0x61400035, 0x00001000, 0x00000000,       0, 0x7, 0x1,     0, 0x8, 0, 0,   0,     0, 0), -- Presence of Mind
(12328,   0,  4, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Sweeping Strikes
(13159,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x2, 0, 0,   0,     0, 0), -- Aspect of the Pack
(13234,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,  1027, 0x2, 0, 0,   0,     0, 0), -- Magic Resistance
(16166,   0, 11, 0x00000003, 0x00001000, 0x00000000,       0, 0x7, 0x1,     0, 0x8, 0, 0,   0,     0, 0), -- Elemental Mastery
(17116,   0,  7, 0x10000861, 0x02000020, 0x00008000,       0, 0x7, 0x1,     0, 0x8, 0, 0,   0,     0, 0), -- Nature's Swiftness
(17670,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0, 1, 0,   0,     0, 0), -- Argent Dawn Commission
(18708,   0,  5, 0x20000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x8, 0, 0,   0,     0, 0), -- Fel Domination
(20911,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,   112, 0x0, 0, 0,   0,     0, 0), -- Blessing of Sanctuary
(21084,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Seal of Righteousness
(23591,   0, 10, 0x00800000, 0x00000000, 0x00000000,      16, 0x0, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Reckoning
(32065,   0,  0, 0x00000000, 0x00000000, 0x00000000,  524288, 0x1, 0x0,     0, 0x0, 0, 0,   0,     0, 0), -- Fungal Decay
(35321,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x0,     0, 0x0, 0, 0,   0,     0, 0), -- Gust of Wind
(36659,   0,  0, 0x00000000, 0x00000000, 0x00000000,  524288, 0x1, 0x0,     0, 0x0, 0, 0,   0,     0, 0), -- Tail Lash
(37604,   0,  6, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0, 0, 0,   0,     0, 0), -- Primal Blessing
(38363,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x0,     0, 0x0, 0, 0,   0,     0, 0), -- Gust of Wind
(39215,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x0,     0, 0x0, 0, 0,   0,     0, 0), -- Gust of Wind
(40816,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x2,     0, 0x0, 0, 0,   0,  7000, 0), -- Saber Lash
(41350,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Aura of Desire
(45092,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0, 0, 0,   0,     0, 0), -- Faction, Spar Buddy
(48504,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,     0, 0x2, 0, 0,   0,     0, 0), -- Living Seed
(50871,   0,  9, 0x00000000, 0x40000000, 0x00000000,       0, 0x1, 0x2,     2, 0x0, 0, 0,   0,     0, 0), -- Brutal Gladiator's War Edge
(50908,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0, 2, 0,   0,  4000, 0), -- Serpent-Coil Braid
(53257,   0,  9, 0x00000000, 0x10000000, 0x00000000,      16, 0x1, 0x2,     2, 0x8, 0, 0,   0,     0, 0), -- Cobra Strikes
(53515,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x3, 0x2,     0, 0x0, 0, 0,   0,     0, 0), -- Divine Aegis
(53651,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x0,     0, 0x2, 0, 0,   0,     0, 0), -- Beacon of Light
(53817,   0, 11, 0x000001C3, 0x00008000, 0x00000000,       0, 0x0, 0x1,     0, 0x8, 0, 0,   0,     0, 0), -- Maelstrom Weapon
(57529,   0,  3, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0, 0, 0,   0,     0, 0), -- Arcane Potency (Rank 1 trigger)
(57531,   0,  3, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0, 0, 0,   0,     0, 0), -- Arcane Potency (Rank 2 trigger)
(58501,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0, 4, 0,   0, 30000, 0), -- Soul Fire (TC)
(63057,   0,  7, 0x00000000, 0x00040000, 0x00000000,   16384, 0x0, 0x2,     0, 0x0, 0, 0,   0,     0, 0), -- Nourish
(63849,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x0,     0, 0x0, 2, 0,   0,     0, 0), -- Hand of Salvation
(70656,   0, 15, 0x00000000, 0x00000000, 0x00000000,       0, 0x0, 0x1,     0, 0x0, 0, 0,   0,     0, 0), -- Blood Strike (trigger)
(70904,   0,  6, 0x00000000, 0x00000000, 0x00000800,    2048, 0x4, 0x0,     0, 0x0, 0, 0,   0,  1000, 0), -- Shadow Word: Pain (trigger)
(71571,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Gutripper (Normal)
(71573,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Gutripper (Heroic)
(71865,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Unbound Plague
(71868,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Unbound Plague (Heroic)
(71993,   0,  0, 0x00000000, 0x00000000, 0x00000000,       4, 0x0, 0x0, 12287, 0x0, 0, 0,   0,  3000, 0), -- Deathwhisper Necromancer
(72059,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x1, 0x0,  1027, 0x2, 0, 0,   0,     0, 0), -- Frost Damage Immunity
(75490,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x2, 0, 0,   0,     0, 0), -- Frostfire Orb
(75495,   0,  0, 0x00000000, 0x00000000, 0x00000000,       0, 0x2, 0x2,     0, 0x2, 0, 0,   0,     0, 0); -- Frostfire Orb

-- Sync spell_proc values from TrinityCore
-- SpellFamilyName, SpellFamilyMask, SchoolMask differences
UPDATE `spell_proc` SET `SpellFamilyName`=3, `SpellFamilyMask0`=0, `SpellFamilyMask1`=34, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=-31571;
UPDATE `spell_proc` SET `SpellFamilyName`=0, `SpellFamilyMask0`=0, `SpellFamilyMask1`=0, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=-29441;
UPDATE `spell_proc` SET `SpellFamilyName`=8, `SpellFamilyMask0`=1107296782, `SpellFamilyMask1`=2, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=-14186;
UPDATE `spell_proc` SET `SpellFamilyName`=8, `SpellFamilyMask0`=1191182854, `SpellFamilyMask1`=2097152, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=-14143;
UPDATE `spell_proc` SET `SpellFamilyName`=6, `SpellFamilyMask0`=41984016, `SpellFamilyMask1`=9218, `SpellFamilyMask2`=8, `SchoolMask`=32 WHERE `SpellId`=15286;
UPDATE `spell_proc` SET `SpellFamilyName`=7, `SpellFamilyMask0`=268436065, `SpellFamilyMask1`=33554464, `SpellFamilyMask2`=32768, `SchoolMask`=0 WHERE `SpellId`=17116;
UPDATE `spell_proc` SET `SpellFamilyName`=0, `SpellFamilyMask0`=2416967683, `SpellFamilyMask1`=0, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=26119;
UPDATE `spell_proc` SET `SpellFamilyName`=3, `SpellFamilyMask0`=0, `SpellFamilyMask1`=0, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=44401;
UPDATE `spell_proc` SET `SpellFamilyName`=5, `SpellFamilyMask0`=357, `SpellFamilyMask1`=131264, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=54274;
UPDATE `spell_proc` SET `SpellFamilyName`=5, `SpellFamilyMask0`=357, `SpellFamilyMask1`=131264, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=54276;
UPDATE `spell_proc` SET `SpellFamilyName`=5, `SpellFamilyMask0`=357, `SpellFamilyMask1`=131264, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=54277;
UPDATE `spell_proc` SET `SpellFamilyName`=3, `SpellFamilyMask0`=0, `SpellFamilyMask1`=16384, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=56374;
UPDATE `spell_proc` SET `SpellFamilyName`=0, `SpellFamilyMask0`=0, `SpellFamilyMask1`=0, `SpellFamilyMask2`=0, `SchoolMask`=4 WHERE `SpellId`=71756;
UPDATE `spell_proc` SET `SpellFamilyName`=3, `SpellFamilyMask0`=0, `SpellFamilyMask1`=1048576, `SpellFamilyMask2`=0, `SchoolMask`=0 WHERE `SpellId`=71761;
UPDATE `spell_proc` SET `SpellFamilyName`=0, `SpellFamilyMask0`=0, `SpellFamilyMask1`=0, `SpellFamilyMask2`=0, `SchoolMask`=4 WHERE `SpellId`=72782;
UPDATE `spell_proc` SET `SpellFamilyName`=0, `SpellFamilyMask0`=0, `SpellFamilyMask1`=0, `SpellFamilyMask2`=0, `SchoolMask`=4 WHERE `SpellId`=72783;
UPDATE `spell_proc` SET `SpellFamilyName`=0, `SpellFamilyMask0`=0, `SpellFamilyMask1`=0, `SpellFamilyMask2`=0, `SchoolMask`=4 WHERE `SpellId`=72784;

-- SpellTypeMask, SpellPhaseMask, AttributesMask, Cooldown, HitMask, ProcFlags, Chance sync from TrinityCore
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=100, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-63730;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=64, `Chance`=0 WHERE `SpellId`=-61846;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=8259, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-58872;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=16, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-57878;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=5800, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-56636;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=4, `AttributesMask`=2, `Cooldown`=22000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-56342;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=100, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-54639;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-53569;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-53486;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-53380;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-53290;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=2, `Cooldown`=3500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-52127;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-51940;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-51634;
UPDATE `spell_proc` SET `SpellTypeMask`=5, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-51625;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-51521;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-50880;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-49217;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=100, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-49208;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-49182;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=20000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-49027;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-48988;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=262144, `Chance`=0 WHERE `SpellId`=-48539;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-47516;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-47509;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=262144, `Chance`=0 WHERE `SpellId`=-47245;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-47195;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-46867;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-46854;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-45234;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=6000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-44557;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=8, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-44449;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-41635;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-34950;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=8000, `HitMask`=1027, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-34935;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=1, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-34753;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-34500;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-33881;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=6000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-33150;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-33142;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-31656;
UPDATE `spell_proc` SET `SpellTypeMask`=7, `SpellPhaseMask`=4, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=16384, `Chance`=0 WHERE `SpellId`=-31571;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=664232, `Chance`=100 WHERE `SpellId`=-30701;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=500, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-30160;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-29723;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=8, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-29074;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-20049;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=262144, `Chance`=0 WHERE `SpellId`=-19572;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=4, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-19184;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=6000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-18094;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-16958;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-16257;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-16256;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-14892;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=500, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-14186;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=64, `Chance`=0 WHERE `SpellId`=-13165;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-12319;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-11213;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=3, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-11180;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=8, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-10400;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=2, `Cooldown`=3500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-974;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=2, `Cooldown`=3500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=-324;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=8, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=1719;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=256, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=7383;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=6000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=7434;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=12, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=12536;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=20000, `HitMask`=16, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=13163;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=5000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=15088;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=15286;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=128, `Cooldown`=2000, `HitMask`=0, `ProcFlags`=0, `Chance`=2 WHERE `SpellId`=15600;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=500, `HitMask`=2, `ProcFlags`=65536, `Chance`=0 WHERE `SpellId`=16164;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=12, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=16246;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=30000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=16620;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=12, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=16870;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=17364;
UPDATE `spell_proc` SET `SpellTypeMask`=7, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=34816, `Chance`=0 WHERE `SpellId`=17619;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=1, `AttributesMask`=8, `Cooldown`=0, `HitMask`=0, `ProcFlags`=65536, `Chance`=0 WHERE `SpellId`=17941;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=20164;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=20165;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=20166;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=20375;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=20784;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=1000, `HitMask`=64, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=22618;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=120000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=22648;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=3500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=23552;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=1000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=23572;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=23578;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=23581;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=23686;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=23689;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=24353;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=25669;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=16, `Chance`=0 WHERE `SpellId`=26135;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0, `ProcsPerMinute`=10 WHERE `SpellId`=26480; -- `AC` #16777
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=27656;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=27774;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=262144, `Chance`=0 WHERE `SpellId`=28716;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=28752;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=28845;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29150;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29501;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29624;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29625;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29626;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29632;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29633;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29634;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29635;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29636;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=29637;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0, `ProcsPerMinute`=18 WHERE `SpellId`=30823; -- `AC` #17499
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=3500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=32734;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=35000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=32837;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=32844;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=33297;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=25000, `HitMask`=0, `ProcFlags`=340, `Chance`=15 WHERE `SpellId`=33510;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=33648;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=279552, `Chance`=0 WHERE `SpellId`=33953;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=34074;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=34320;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=3500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=34355;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=34584;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=34586;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=34598;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=20000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=34774;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=4000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=34827;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=60000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=35077;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=60000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=35080;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=60000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=35083;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=60000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=35086;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=35121;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=36111;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=37170;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=30000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=37173;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=37213;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=40000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=37247;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=37381;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=37600;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=37603;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=37655;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=2500, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=37657;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=256, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=38026;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=120000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=38164;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=38290;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=15000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=38299;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=38334;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=38350;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=38394;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=3500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=39027;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=1, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=39442;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=39443;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=40000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=39958;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=40438;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=40475;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=40478;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=40482;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=8000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=40899;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=15000, `HitMask`=32, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=41393;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=41434;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=41989;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=42083;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=90000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=42135;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=90000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=42136;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=10000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=43748;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=30000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=43750;
UPDATE `spell_proc` SET `SpellTypeMask`=5, `SpellPhaseMask`=1, `AttributesMask`=8, `Cooldown`=0, `HitMask`=0, `ProcFlags`=69632, `Chance`=0 WHERE `SpellId`=44401;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=7 WHERE `SpellId`=44543;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=15 WHERE `SpellId`=44545;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=15000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=45054;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=30000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=45057;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=45354;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=45355;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=45481;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=45482;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=45483;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=16384, `Chance`=0 WHERE `SpellId`=45484;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=46569;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=25000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=46662;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=15000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=46832;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=4, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=46916;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=10000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=48833;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=10000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=48837;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=2000, `HitMask`=0, `ProcFlags`=139944, `Chance`=0 WHERE `SpellId`=49222;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=8528552, `Chance`=0 WHERE `SpellId`=49592;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=49622;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=4, `AttributesMask`=8, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=49796;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=4, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=50240;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=4, `AttributesMask`=8, `Cooldown`=0, `HitMask`=0, `ProcFlags`=65552, `Chance`=0 WHERE `SpellId`=51124;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=4, `AttributesMask`=0, `Cooldown`=1000, `HitMask`=2, `ProcFlags`=0, `Chance`=33 WHERE `SpellId`=51698;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=4, `AttributesMask`=0, `Cooldown`=1000, `HitMask`=2, `ProcFlags`=0, `Chance`=66 WHERE `SpellId`=51700;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=4, `AttributesMask`=0, `Cooldown`=1000, `HitMask`=2, `ProcFlags`=0, `Chance`=100 WHERE `SpellId`=51701;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=10000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=52020;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=30000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=52420;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=32, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=52423;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=4, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=16, `Chance`=0 WHERE `SpellId`=52437;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=6000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=52898;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=53397;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=5000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=53646;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=54278;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=54646;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=54695;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=54707;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=54754;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=54808;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=2500, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=54841;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=54909;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=40000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=55380;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=55440;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=60000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=55640;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=55689;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=55747;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=55000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=55776;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=6000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=56218;
UPDATE `spell_proc` SET `SpellTypeMask`=4, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=2049, `ProcFlags`=65536, `Chance`=0 WHERE `SpellId`=56375;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=3500, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=56451;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=500, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=56821;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=57345;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=57351;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=262144, `Chance`=0 WHERE `SpellId`=57870;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=57907;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=30000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=58442;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=5000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=58444;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=58901;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=6000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=59176;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=59345;
UPDATE `spell_proc` SET `SpellTypeMask`=5, `SpellPhaseMask`=1, `AttributesMask`=2, `Cooldown`=35000, `HitMask`=0, `ProcFlags`=69648, `Chance`=0 WHERE `SpellId`=59630;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=294912, `Chance`=0 WHERE `SpellId`=60061;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60066;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60170;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=262144, `Chance`=0 WHERE `SpellId`=60176;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60221;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60301;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60306;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60317;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60436;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60442;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60473;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=15000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60487;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60519;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60529;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=30000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60770;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=60826;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=61188;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=61356;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=61618;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=62114;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=62115;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=63251;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=63280;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=279552, `Chance`=0 WHERE `SpellId`=64411;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=279552, `Chance`=0 WHERE `SpellId`=64415;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=32, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64440;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64738;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=15000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64752;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64786;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64792;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64824;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64860;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64867;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64890;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=64914;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=65002;
UPDATE `spell_proc` SET `SpellTypeMask`=3, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=81920, `Chance`=0 WHERE `SpellId`=65007;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=65013;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=65020;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=65025;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67151;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=15000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67209;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=8000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67353;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=5000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67356;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=6000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67361;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=8000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67363;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=8000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67365;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=9000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67379;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=9000, `HitMask`=0, `ProcFlags`=16, `Chance`=0 WHERE `SpellId`=67392;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67653;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=8388948, `Chance`=0 WHERE `SpellId`=67672;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67702;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=2000, `HitMask`=2, `ProcFlags`=69632, `Chance`=0 WHERE `SpellId`=67712;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=2000, `HitMask`=2, `ProcFlags`=69632, `Chance`=0 WHERE `SpellId`=67758;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=67771;
UPDATE `spell_proc` SET `SpellTypeMask`=7, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=69739;
UPDATE `spell_proc` SET `SpellTypeMask`=7, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=69755;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=256, `Cooldown`=100, `HitMask`=0, `ProcFlags`=87040, `Chance`=0 WHERE `SpellId`=69762;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=3000, `HitMask`=16, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=70188;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=70664;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=12287, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=70672;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=70727;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=70730;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=4, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=70803;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=70811;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=70841;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=70854;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71174;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71176;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71178;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71198;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71402;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=2, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71404;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=50 WHERE `SpellId`=71406;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71540;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=50 WHERE `SpellId`=71545;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71585;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=65536, `Chance`=0 WHERE `SpellId`=71602;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=100000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71606;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=30000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71634;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=100000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71637;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=30000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71640;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=65536, `Chance`=0 WHERE `SpellId`=71645;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71756;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=3000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71770;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=71903;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=60000, `HitMask`=0, `ProcFlags`=0, `Chance`=10 WHERE `SpellId`=72413;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=60000, `HitMask`=0, `ProcFlags`=327680, `Chance`=0 WHERE `SpellId`=72417;
UPDATE `spell_proc` SET `SpellTypeMask`=2, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=60000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=72419;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=12287, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=72455;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=72782;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=72783;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=2, `Cooldown`=0, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=72784;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=12287, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=72832;
UPDATE `spell_proc` SET `SpellTypeMask`=0, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=0, `HitMask`=12287, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=72833;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=75455;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=2, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=75457;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=75465;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=1, `AttributesMask`=0, `Cooldown`=50000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=75474;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=75475;
UPDATE `spell_proc` SET `SpellTypeMask`=1, `SpellPhaseMask`=0, `AttributesMask`=0, `Cooldown`=45000, `HitMask`=0, `ProcFlags`=0, `Chance`=0 WHERE `SpellId`=75481;

-- Missing TC spell_proc entries
DELETE FROM `spell_proc` WHERE `SpellId` IN (60617, 71567);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(60617, 0, 0, 0, 0, 0, 0, 0, 0, 32, 0, 0, 0, 0, 0, 0), -- Unknown (proc on absorb)
(71567, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 250, 0); -- ICC buff (heal proc)

-- Fix duplicate entries (remove positive when negative already covers all ranks)
DELETE FROM `spell_proc` WHERE `SpellId` IN (9452, 44546, 49027, 59887);

-- Delete AC-specific entries that don't exist in TC's spell_proc (they cause warnings and aren't needed)
DELETE FROM `spell_proc` WHERE `SpellId` IN (-16086, 62933);

-- Delete AC-specific legacy entries that don't exist in TC's spell_proc
-- These have invalid ProcFlags/SpellPhaseMask combinations and cause warnings
DELETE FROM `spell_proc` WHERE `SpellId` IN (
    16086,  -- Piercing Howl (rank handling)
    15257, 15331, 15332,  -- Priest Shadow Weaving (handled by AuraScript)
    21747,  -- Raptorslayer
    24256,  -- Judgement of Crusader
    27997,  -- Spell Vulnerability
    28460,  -- Mojo Madness
    31221, 31222, 31223,  -- Master of Subtlety
    33511, 33522,  -- Concussion/Daze
    37565,  -- Magma Shield
    38319,  -- Mojo Madness
    40303,  -- Thrash
    42760,  -- Dark Transformation
    43730,  -- Stormchops
    43983,  -- Fiery Payback
    44835,  -- Maim Interrupt
    45278,  -- Chaos Bolt
    45396, 45398,  -- Blackout
    45444,  -- Totem of Ancestral Guidance
    46102,  -- Living Flame
    54404,  -- Demonic Immolation
    55610,  -- Improved Icy Talons
    55717,  -- Venom
    56845,  -- Glyph of Seal of Command
    58426,  -- Overkill
    59888, 59889, 59890, 59891,  -- Borrowed Time ranks
    64936,  -- Flame Leviathan Residue
    70871   -- Essence of the Blood Queen
);

-- Fix additional duplicate entries
DELETE FROM `spell_proc` WHERE `SpellId` IN (26016, 44548, 44549, 49542, 49543);

-- Fix spell_script_names bindings for proc system
-- Remove 44401 from spell_mage_gen_extra_effects (TC uses separate handler)
DELETE FROM `spell_script_names` WHERE `spell_id` = 44401 AND `ScriptName` = 'spell_mage_gen_extra_effects';

-- Fix Savage Defense binding (script is for 62606 absorb buff, not 62600 passive)
DELETE FROM `spell_script_names` WHERE `spell_id` = 62600 AND `ScriptName` = 'spell_dru_savage_defense';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (62606, 'spell_dru_savage_defense');

-- Fix Ancestral Awakening binding (was incorrectly bound to -51474 Astral Shift, should be -51556 Ancestral Awakening)
DELETE FROM `spell_script_names` WHERE `spell_id` = -51474 AND `ScriptName` = 'spell_sha_ancestral_awakening';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-51556, 'spell_sha_ancestral_awakening');

-- Remove obsolete reload spell_proc_event command (replaced by spell_proc)
DELETE FROM `command` WHERE `name` = 'reload spell_proc_event';

-- Fingers of Frost - register script for charge consumption buff (74396)
DELETE FROM `spell_script_names` WHERE `spell_id` = 74396 AND `ScriptName` = 'spell_mage_fingers_of_frost';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(74396, 'spell_mage_fingers_of_frost');

-- Remove non-existent Fingers of Frost script entries
-- spell_mage_fingers_of_frost_proc and spell_mage_fingers_of_frost_proc_aura don't exist in code
-- The proc system now handles charge consumption via PrepareProcToTrigger
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_mage_fingers_of_frost_proc';
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_mage_fingers_of_frost_proc_aura';

-- Sheath of Light: procs on critical heals (from TrinityCore)
-- ProcFlags=0 uses DBC flags, SpellTypeMask=2 (HEAL), SpellPhaseMask=2 (HIT), HitMask=2 (CRITICAL)
DELETE FROM `spell_proc` WHERE `SpellId` = -53501;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-53501, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0);

-- Fix Cut to the Chase spell_script_names (was incorrectly registered to Combat Potency -35541)
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_rog_cut_to_the_chase';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-51664, 'spell_rog_cut_to_the_chase');

-- Fix Decimation DisableEffectsMask (was 0, should be 2 to disable EFFECT_1 from proccing)
UPDATE `spell_proc` SET `DisableEffectsMask` = 2 WHERE `SpellId` = -63156;

-- Vendetta: add missing spell_script_names entry (from TrinityCore)
DELETE FROM `spell_script_names` WHERE `spell_id` = -49015 AND `ScriptName` = 'spell_dk_vendetta';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-49015, 'spell_dk_vendetta');

-- Remove duplicate spell_dk_runic_power_back_on_snare_root (TC only has spell_dk_pvp_4p_bonus for 61257)
DELETE FROM `spell_script_names` WHERE `spell_id` = 61257 AND `ScriptName` = 'spell_dk_runic_power_back_on_snare_root';

-- Lightning Shield: add missing spell_script_names entry
DELETE FROM `spell_script_names` WHERE `spell_id` = -324 AND `ScriptName` = 'spell_sha_lightning_shield';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-324, 'spell_sha_lightning_shield');

-- Nightfall (Glyph of Corruption): add missing spell_script_names entry
DELETE FROM `spell_script_names` WHERE `spell_id` = 56218 AND `ScriptName` = 'spell_warl_nightfall';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (56218, 'spell_warl_nightfall');

-- Drop obsolete spell_proc_event table (replaced by spell_proc)
DROP TABLE IF EXISTS `spell_proc_event`;

-- Darkmoon Card: Greatness - Register script to handle proc based on highest stat
DELETE FROM `spell_script_names` WHERE `spell_id` = 57345;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(57345, 'spell_item_darkmoon_card_greatness');

-- Death's Choice / Death's Verdict - Register script to handle proc based on highest stat (Str vs Agi)
DELETE FROM `spell_script_names` WHERE `spell_id` IN (67702, 67771);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(67702, 'spell_item_death_choice'),
(67771, 'spell_item_death_choice');

-- Soul Preserver - Register script to handle proc based on class
DELETE FROM `spell_script_names` WHERE `spell_id` = 60510;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(60510, 'spell_item_soul_preserver');

-- Amani Charm of the Witch Doctor - Register script to handle heal proc
DELETE FROM `spell_script_names` WHERE `spell_id` = 43820;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43820, 'spell_item_charm_witch_doctor');

-- Lifegiving Gem - Gift of Life spell
DELETE FROM `spell_script_names` WHERE `spell_id` = 23725;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(23725, 'spell_item_lifegiving_gem');

-- Mana Drain - proc script for mana drain items
DELETE FROM `spell_script_names` WHERE `spell_id` IN (27522, 40336);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(27522, 'spell_item_mana_drain'),
(40336, 'spell_item_mana_drain');

-- Gnomish Mind Control Cap
DELETE FROM `spell_script_names` WHERE `spell_id` = 13180;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(13180, 'spell_item_mind_control_cap');

-- Hourglass Sand
DELETE FROM `spell_script_names` WHERE `spell_id` = 30536;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30536, 'spell_item_hourglass_sand');

-- Ultrasafe Transporter: Toshley's Station
DELETE FROM `spell_script_names` WHERE `spell_id` = 36941;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(36941, 'spell_item_ultrasafe_transporter');

-- Power Circle (Mage T5 Set Bonus)
DELETE FROM `spell_script_names` WHERE `spell_id` = 45043;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45043, 'spell_item_power_circle');

-- Thrallmar's Favor / Honor Hold's Favor
DELETE FROM `spell_script_names` WHERE `spell_id` IN (32096, 32098);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(32096, 'spell_item_thrallmar_and_honor_hold_favor'),
(32098, 'spell_item_thrallmar_and_honor_hold_favor');

-- Drums of Forgotten Kings
DELETE FROM `spell_script_names` WHERE `spell_id` = 69378;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(69378, 'spell_item_drums_of_forgotten_kings');

-- Drums of the Wild
DELETE FROM `spell_script_names` WHERE `spell_id` = 69381;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(69381, 'spell_item_drums_of_the_wild');

-- Darkmoon Card: Illusion
DELETE FROM `spell_script_names` WHERE `spell_id` = 57350;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(57350, 'spell_item_darkmoon_card_illusion');

-- Mad Alchemist's Potion
DELETE FROM `spell_script_names` WHERE `spell_id` = 28374;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(28374, 'spell_item_mad_alchemists_potion');

-- Decahedral Dwarven Dice
DELETE FROM `spell_script_names` WHERE `spell_id` = 47770;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(47770, 'spell_item_decahedral_dwarven_dice');

-- Arena Drink - modifies drink mana regen behavior in arenas
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_arena_drink';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(430, 'spell_gen_arena_drink'),
(431, 'spell_gen_arena_drink'),
(432, 'spell_gen_arena_drink'),
(1133, 'spell_gen_arena_drink'),
(1135, 'spell_gen_arena_drink'),
(1137, 'spell_gen_arena_drink'),
(10250, 'spell_gen_arena_drink'),
(22734, 'spell_gen_arena_drink'),
(27089, 'spell_gen_arena_drink'),
(34291, 'spell_gen_arena_drink'),
(43182, 'spell_gen_arena_drink'),
(43183, 'spell_gen_arena_drink'),
(46755, 'spell_gen_arena_drink'),
(49472, 'spell_gen_arena_drink'),
(57073, 'spell_gen_arena_drink'),
(61830, 'spell_gen_arena_drink'),
(72623, 'spell_gen_arena_drink');

-- Remove scripts with DBC mismatches (spell effects don't match AC's DBC)
DELETE FROM `spell_script_names` WHERE `ScriptName` IN (
'spell_item_nitro_boosts',
'spell_item_nitro_boosts_backfire',
'spell_item_harm_prevention_belt',
'spell_item_dire_brew',
'spell_item_dimensional_ripper_everlook',
'spell_item_red_rider_air_rifle',
'spell_item_runic_healing_injector',
'spell_item_taunt_flag_targeting',
'spell_item_extract_gas',
'spell_item_disco_ball_listening_to_music_periodic',
'spell_item_disco_ball_listening_to_music_check',
'spell_item_disco_ball_listening_to_music_parent'
);
