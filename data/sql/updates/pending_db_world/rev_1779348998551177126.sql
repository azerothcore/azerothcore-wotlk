--
-- Allow Warlock Soul Shards to stack up to 10.

UPDATE `item_template` SET `stackable` = 10 WHERE `entry` = 6265;
