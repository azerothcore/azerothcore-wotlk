/* QUEST :
 https://wowgaming.altervista.org/aowow/?quest=13662

give 25 reputation then complete quest

quest is Repeatable

 *************/

UPDATE quest_template SET RewardFactionOverride1 = 2500 WHERE ID = 13662;
UPDATE quest_template SET flags = 1 WHERE ID = 13662;
