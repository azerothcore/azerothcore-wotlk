-- DB update 2026_08_20_01 -> 2026_08_20_02
-- Un'Goro Soil (3761) required the Orgrimmar breadcrumb (936), making the Thunder Bluff (3762)
-- and Undercity (3784) ones dead ends. All three are already linked via BreadcrumbForQuestId.
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 3761;
