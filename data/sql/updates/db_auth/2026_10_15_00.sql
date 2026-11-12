-- DB update 2026_09_27_00 -> 2026_10_15_00
--
ALTER TABLE `account` MODIFY `locale` varchar(4) NOT NULL DEFAULT 'enUS';

UPDATE `account` SET `locale` = CASE `locale`
    WHEN '1' THEN 'koKR'
    WHEN '2' THEN 'frFR'
    WHEN '3' THEN 'deDE'
    WHEN '4' THEN 'zhCN'
    WHEN '5' THEN 'zhTW'
    WHEN '6' THEN 'esES'
    WHEN '7' THEN 'esMX'
    WHEN '8' THEN 'ruRU'
    ELSE 'enUS'
END WHERE `locale` IN ('0', '1', '2', '3', '4', '5', '6', '7', '8');
