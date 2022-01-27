INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643309943188748904');

-- update current loot to 100% per wowhead
UPDATE `gameobject_loot_template` SET `Chance`='100' WHERE  `Entry`=11524 AND `Item`=11614;
UPDATE `gameobject_loot_template` SET `Chance`='100' WHERE  `Entry`=11525 AND `Item`=11615;
UPDATE `gameobject_loot_template` SET `Chance`='100' WHERE  `Entry`=13721 AND `Item`=12827;
UPDATE `gameobject_loot_template` SET `Chance`='100' WHERE  `Entry`=13722 AND `Item`=12830;

-- delete and insert for rerun locking the loot to skill id requirement for loot
-- none currently exist in acdb
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=4 AND `SourceGroup`IN ( 173232, 173234, 176325, 176327);
INSERT INTO `conditions` SET 
    `SourceTypeOrReferenceId`=4, -- gameobject loot template
    `SourceGroup`=176327, -- gameobject Blacksmithing Plans
    `SourceEntry`=12830, -- item id Plans Coruption
    `SourceId`=0,
    `ElseGroup`=0,
    `ConditionTypeOrReference`=7, -- CONDITION_SKILL
    `ConditionTarget`=0, -- player
    `ConditionValue1`=164, -- SKILL ID Black smith
    `ConditionValue2`=285, -- Skill level
    `ConditionValue3`=0, -- always 0
    `NegativeCondition`=0,
    `ErrorTextId`=0,
    `ScriptName`='',
    `Comment`="Blacksmithing Plans - Plans Coruption while having Black Smith skill 285";
	
INSERT INTO `conditions` SET 
    `SourceTypeOrReferenceId`=4, -- gameobject loot template
    `SourceGroup`=176325, -- gameobject Blacksmithing Plans
    `SourceEntry`=12827, -- item id Plans Serenity
    `SourceId`=0,
    `ElseGroup`=0,
    `ConditionTypeOrReference`=7, -- CONDITION_SKILL
    `ConditionTarget`=0, -- player
    `ConditionValue1`=164, -- SKILL ID Black smith
    `ConditionValue2`=285, -- Skill level
    `ConditionValue3`=0, -- always 0
    `NegativeCondition`=0,
    `ErrorTextId`=0,
    `ScriptName`='',
    `Comment`="Blacksmithing Plans - Plans Serenity while having Black Smith skill 285";
	
INSERT INTO `conditions` SET 
    `SourceTypeOrReferenceId`=4, -- gameobject loot template
    `SourceGroup`=173232, -- gameobject Blacksmithing Plans
    `SourceEntry`=11614, -- item id Plans Dark Iron Mail
    `SourceId`=0,
    `ElseGroup`=0,
    `ConditionTypeOrReference`=7, -- CONDITION_SKILL
    `ConditionTarget`=0, -- player
    `ConditionValue1`=164, -- SKILL ID Black smith
    `ConditionValue2`=285, -- Skill level
    `ConditionValue3`=0, -- always 0
    `NegativeCondition`=0,
    `ErrorTextId`=0,
    `ScriptName`='',
    `Comment`="Blacksmithing Plans - Plans Dark Iron Mail while having Black Smith skill 285";
		
INSERT INTO `conditions` SET 
    `SourceTypeOrReferenceId`=4, -- gameobject loot template
    `SourceGroup`=173234, -- gameobject Blacksmithing Plans
    `SourceEntry`=11615, -- item id Plans Dark Iron Shoulder
    `SourceId`=0,
    `ElseGroup`=0,
    `ConditionTypeOrReference`=7, -- CONDITION_SKILL
    `ConditionTarget`=0, -- player
    `ConditionValue1`=164, -- SKILL ID Black smith
    `ConditionValue2`=285, -- Skill level
    `ConditionValue3`=0, -- always 0
    `NegativeCondition`=0,
    `ErrorTextId`=0,
    `ScriptName`='',
    `Comment`="Blacksmithing Plans - Plans Dark Iron Shoulder while having Black Smith skill 285";
