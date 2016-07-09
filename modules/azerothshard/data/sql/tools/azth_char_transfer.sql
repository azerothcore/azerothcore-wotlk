# Clean old account_transfer character data ( keeping other information about the transfer )

UPDATE account_transfer SET cDump = "CLEANED", cItemRow = "CLEANED" WHERE date_created < '2015-08-15 00:00:00' AND cStatus <> 0;


# sometime, after accepting a transfer, the ajax can be fail for various 
# reasons stucking the characters in porting account.
# following query can be used to "fix" characters affected by this error

UPDATE azth_1_chars.characters AS a RIGHT JOIN (
SELECT guid,cAccount FROM azth_auth.account_transfer WHERE
/* conditions must follow this order for best performances */
guid IN (SELECT guid FROM azth_1_chars.characters WHERE account = 523)
AND cStatus = 1
) AS b
ON a.guid=b.GUID SET a.account=b.cAccount;

