INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587062218041221300');

DELETE FROM `acore_string` WHERE `entry` IN (30081,30082);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(30081, "%s does not have itemID = %i, thus cannot be removed."),
(30082, "%s does not have that many of itemID = %i, thus none were removed.");

UPDATE `command` SET `help` = "Syntax: .additem #itemID/[#itemName]/#itemLink #itemCount\r\nAdds the specified item to you or the selected character.\nIf #itemCount is negative, you will remove #itemID." WHERE `name` = "additem";
