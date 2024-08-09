-- Set RequiredNpcOrGo1 of quest 6661 Deeprun Rat Roundup to 13017
UPDATE `quest_template` SET `RequiredNpcOrGo1`=13017 WHERE `ID`=6661;

-- Set quest credit to unit 13017 in 'Deeprun Rat - On Spellhit - Quest Credit'
UPDATE `smart_scripts` SET `action_param1`=13017 WHERE `entryorguid`=13016 AND `source_type`=0 AND `id`=2 AND `link`=3;
