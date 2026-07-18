-- DB update 2026_06_24_00 -> 2026_07_18_00
-- petition_sign kept its (petitionguid, playerguid) primary key when the
-- petition_id schema stopped writing petitionguid: every row inserts with
-- petitionguid = 0, so the key collapses to (0, playerguid) and a character
-- can never hold more than one signature row overall (later signs fail
-- silently with a duplicate key on the async insert).
-- Re-key on (petition_id, playerguid) and drop the signature rows orphaned
-- by the type-filtered deletes that no longer match (`type` is not written
-- by the insert either).
DELETE `ps` FROM `petition_sign` `ps` LEFT JOIN `petition` `p` ON `p`.`petition_id` = `ps`.`petition_id` WHERE `p`.`petition_id` IS NULL;
ALTER TABLE `petition_sign` DROP PRIMARY KEY, ADD PRIMARY KEY (`petition_id`, `playerguid`), DROP INDEX `idx_petition_id_player`;
