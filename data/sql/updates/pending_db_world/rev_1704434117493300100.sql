-- Update Orgrimmar Grunt directions for barber Shop
-- these had VerifiedBuild 18019 (Mists of Pandoria) before and were therefore incorrect for 3.3.5a

-- column `VerifiedBuild` was smallint and the new value 52237 didn't fit
ALTER TABLE `broadcast_text` MODIFY COLUMN `VerifiedBuild` INT;

UPDATE `broadcast_text` SET `MaleText` = 'The barber is in the Cleft of Shadow.', `FemaleText` = 'The barber is in the Cleft of Shadow.', `VerifiedBuild` = 52237 WHERE `ID` = 31559;
