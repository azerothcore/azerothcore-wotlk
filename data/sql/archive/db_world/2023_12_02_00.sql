-- DB update 2023_11_30_00 -> 2023_12_02_00
--
UPDATE `command` SET `help`='Syntax: .additem Optional(playerName/playerGUID) #itemID/[#itemName]/#itemLink #itemCount\r\nAdds the specified item to you, the selected character or the specifed character name/GUID.\r\nIf #itemCount is negative, you will remove #itemID.' WHERE `name`='additem';
