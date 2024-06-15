-- DB update 2022_12_28_01 -> 2022_12_28_02
-- Fix translations of quest 456 to say 4 kills instead of 3
UPDATE `quest_template_locale` SET `Objectives`='Mata a 4 sables de la noche y 4 jabalíes cardo jóvenes.' WHERE `ID`=456 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `Objectives`='Tuez 4 Jeunes sabres-de-nuit et 4 Jeunes sangliers des chardons.' WHERE `ID`=456 AND `locale`='frFR';
UPDATE `quest_template_locale` SET `Objectives`='Tötet 4 junge Nachtsäbler sowie 4 junge Disteleber.' WHERE `ID`=456 AND `locale`='deDE';
