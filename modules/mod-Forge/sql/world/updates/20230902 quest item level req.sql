update item_template it 
inner join quest_template qt on it.entry = qt.RewardItem4
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 4);

update item_template it 
inner join quest_template qt on it.entry = qt.RewardItem3
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 4);

update item_template it 
inner join quest_template qt on it.entry = qt.RewardItem2
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 4);

update item_template it 
inner join quest_template qt on it.entry = qt.RewardItem1
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 4);

update item_template it 
inner join quest_template qt on it.entry = qt.RewardChoiceItemID1
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 4);

update item_template it 
inner join quest_template qt on it.entry = qt.RewardChoiceItemID2
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 4);

update item_template it 
inner join quest_template qt on it.entry = qt.RewardChoiceItemID3
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 4);

update item_template it 
inner join quest_template qt on it.entry = qt.RewardChoiceItemID4
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 4);

update item_template it 
inner join quest_template qt on it.entry = qt.RewardChoiceItemID4
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 5);

update item_template it 
inner join quest_template qt on it.entry = qt.RewardChoiceItemID4
set it.RequiredLevel = qt.MinLevel
where it.RequiredLevel = 0 and (it.class = 2 or it.class = 6);