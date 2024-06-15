ALTER TABLE world_db_version CHANGE COLUMN 2016_08_14_02 2016_08_19_00 BIT;

/*
Issue: Not work quest id 11543 #93
Missing SAI for the correct execution of quest

Create SAI for ending quest
*/

UPDATE creature_template SET AIName="SmartAI" WHERE entry IN (25090,25091,25092); 
DELETE FROM smart_scripts WHERE entryorguid IN (25090,25091,25092) AND source_type=0; 
INSERT INTO smart_scripts VALUES 
(25090,0,0,0,8,0,100,0,45115,0,0,0,33,25090,0,0,0,0,0,7,0,0,0,0,0,0,0,"Sin'Loren - On spellhit 45115 - Kill Credit"), 
(25091,0,0,0,8,0,100,0,45115,0,0,0,33,25091,0,0,0,0,0,7,0,0,0,0,0,0,0,"Bloodoath - On spellhit 45115 - Kill Credit"), 
(25092,0,0,0,8,0,100,0,45115,0,0,0,33,25092,0,0,0,0,0,7,0,0,0,0,0,0,0,"Dawnchaser - On spellhit 45115 - Kill Credit"); 

/*
Backup for next DELETE query
INSERT INTO conditions VALUES
(15,9143,0,0,0,9,0,11542,0,0,0,0,0,,"Show gossip option if player has quest 11542 but not complete"),
(15,9143,0,0,1,9,0,11543,0,0,0,0,0,,"Show gossip option if player has quest 11543 but not complete");
*/

DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9143;
