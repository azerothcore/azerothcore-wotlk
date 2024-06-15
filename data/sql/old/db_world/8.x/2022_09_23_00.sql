-- DB update 2022_09_22_01 -> 2022_09_23_00
ALTER TABLE `skilllineability_dbc`
    CHANGE `MinSkillLineRank` `ExcludeRace` INT NOT NULL DEFAULT 0,
    CHANGE `SupercededBySpell` `ExcludeClass` INT NOT NULL DEFAULT 0,
    CHANGE `AcquireMethod` `MinSkillLineRank` INT NOT NULL DEFAULT 0,
    CHANGE `TrivialSkillLineRankHigh` `SupercededBySpell` INT NOT NULL DEFAULT 0,
    CHANGE `TrivialSkillLineRankLow` `AcquireMethod` INT NOT NULL DEFAULT 0, 
    CHANGE `CharacterPoints_1` `TrivialSkillLineRankHigh` INT NOT NULL DEFAULT 0,
    CHANGE `CharacterPoints_2` `TrivialSkillLineRankLow` INT NOT NULL DEFAULT 0,
    CHANGE `TradeSkillCategoryID` `CharacterPoints_1` INT NOT NULL DEFAULT 0,
    ADD COLUMN `CharacterPoints_2` INT NOT NULL DEFAULT 0 AFTER `CharacterPoints_1`;
