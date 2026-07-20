-- Re-key channels_rights from channel name to channelId
ALTER TABLE `channels_rights` ADD COLUMN `channelId` INT UNSIGNED NOT NULL DEFAULT 0 FIRST;

-- Map existing rows to their stored channel. If the same channel name exists
-- for both teams, the rights are assigned to the first matching channel.
UPDATE `channels_rights` `cr`
JOIN `channels` `c` ON `c`.`name` = `cr`.`name`
SET `cr`.`channelId` = `c`.`channelId`;

-- Drop rights that could not be mapped to a stored channel
DELETE FROM `channels_rights` WHERE `channelId` = 0;

ALTER TABLE `channels_rights`
  DROP PRIMARY KEY,
  DROP COLUMN `name`,
  ADD PRIMARY KEY (`channelId`);
