-- Quest 21 (Skirmish at Echo Ridge): frFR objectives text says 8 Kobold Workers, the requirement is 12.
UPDATE `quest_template_locale` SET `Objectives` = REPLACE(`Objectives`, 'Tuez 8 Travailleurs kobolds', 'Tuez 12 Travailleurs kobolds') WHERE `ID` = 21 AND `locale` = 'frFR';
