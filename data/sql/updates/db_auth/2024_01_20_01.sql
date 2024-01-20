--
UPDATE `updates` SET `state`='ARCHIVED' WHERE `state`='RELEASED';
DELETE FROM `updates` WHERE `state` = 'ARCHIVED';
