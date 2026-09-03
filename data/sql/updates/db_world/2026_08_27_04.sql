-- DB update 2026_08_27_03 -> 2026_08_27_04
-- Gortok Palehoof (Utgarde Pinnacle) aggro line plays no voice sound
-- creature_text row (CreatureID 26687, GroupID 0, ID 0, SAY_AGGRO) has Sound=0.
-- Verified against SoundEntries.dbc: ID 13464 = "A_UP_Gortok_Aggro" / UP_Gortok_Aggro.wav
-- under Sound\Creature\GortokPalehoof, matching this creature and text.
-- Source: azerothcore/azerothcore-wotlk#27231, chromiecraft/chromiecraft#10039

UPDATE `creature_text` SET `Sound`=13464 WHERE `CreatureID`=26687 AND `GroupID`=0 AND `ID`=0;
