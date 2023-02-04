-- DB update 2022_12_06_32 -> 2022_12_06_33
-- Delete independent Tamed Sporebat. Should be spawned by the summoner instead.
DELETE FROM `creature` WHERE `id1`=18201 AND `guid` IN (64977,64978,64979,64980,64981,64982,64983,64984,64985,64986,64987,64988,64989,64990,64991,64992,64993);
