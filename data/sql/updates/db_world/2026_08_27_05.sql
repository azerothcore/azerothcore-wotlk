-- DB update 2026_08_27_04 -> 2026_08_27_05
--
-- SAY_SLAY_1
UPDATE `creature_text` SET `Sound`=13465 WHERE `CreatureID`=26687 AND `GroupID`=1 AND `ID`=0;

-- SAY_SLAY_2
UPDATE `creature_text` SET `Sound`=13466 WHERE `CreatureID`=26687 AND `GroupID`=1 AND `ID`=1;
