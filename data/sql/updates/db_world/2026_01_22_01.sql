-- DB update 2026_01_22_00 -> 2026_01_22_01
-- PrevQuestID from 12822 to 18221, A Flawless Plan requires Opening the Backdoor, not Know No Fear
UPDATE `quest_template_addon` SET `PrevQuestID` = 12821 WHERE `ID` = 12823;

-- Remove phase shifts in Garm and Garm's Rise for Know No Fear
DELETE FROM `spell_area`
WHERE `Quest_start` = 12822
  AND `quest_start_status` = 74;

-- Add phase shift in Garm and Garm's Rise after turning in Opening the Backdoor
DELETE FROM `spell_area` WHERE `Quest_start` = 12821 AND `Spell` = 54635;
INSERT INTO `spell_area`
(
  `Spell`,
  `Area`,
  `Quest_start`,
  `Quest_end`,
  `Aura_spell`,
  `Racemask`,
  `Gender`,
  `Autocast`,
  `Quest_start_status`,
  `Quest_end_status`
)
VALUES
(54635, 4421, 12821, 0, 0, 0, 2, 1, 64, 0),
(54635, 4461, 12821, 0, 0, 0, 2, 1, 64, 0);
