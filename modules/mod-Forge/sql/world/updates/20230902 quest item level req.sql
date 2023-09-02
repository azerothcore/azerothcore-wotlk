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