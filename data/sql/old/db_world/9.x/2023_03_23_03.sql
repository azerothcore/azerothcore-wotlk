-- DB update 2023_03_23_02 -> 2023_03_23_03
-- (AC ONLY) SMART_ACTION_SET_GO_STATE -> SMART_ACTION_GO_SET_GO_STATE
UPDATE `smart_scripts` SET `action_type` = 118 WHERE `action_type` = 202;
