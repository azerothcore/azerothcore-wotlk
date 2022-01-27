INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643309943188748904');

-- delete and insert for rerun for gameobject loot of blacksmithing plans
-- none currently exist in acdb
DELETE FROM `gameobject_loot_template` WHERE `Entry`=173232;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(173232, 12830, 0, 30, 0, 1, 0, 1, 1, 'Blacksmithing Plans - Plans Coruption'),
(173232, 12827, 0, 28, 0, 1, 0, 1, 1, 'Blacksmithing Plans - Plans Serenity'),
(173232, 11614, 0, 22, 0, 1, 0, 1, 1, 'Blacksmithing Plans - Plans Dark Iron Mail'),
(173232, 11615, 0, 8, 0, 1, 0, 1, 1, 'Blacksmithing Plans - Plans Dark Iron Shoulder');

-- delete and insert for rerun locking the loot to skill id requirement for loot
-- none currently exist in acdb
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=4 AND `SourceGroup`=173232;
INSERT INTO `conditions` SET 
    `SourceTypeOrReferenceId`=4, -- gameobject loot template
    `SourceGroup`=173232, -- gameobject Blacksmithing Plans
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
    `SourceGroup`=173232, -- gameobject Blacksmithing Plans
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
    `SourceGroup`=173232, -- gameobject Blacksmithing Plans
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