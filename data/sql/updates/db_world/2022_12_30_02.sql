-- DB update 2022_12_30_01 -> 2022_12_30_02
DELETE FROM `creature` WHERE `guid` IN (66458, 66459) AND `id1` = 18470;
