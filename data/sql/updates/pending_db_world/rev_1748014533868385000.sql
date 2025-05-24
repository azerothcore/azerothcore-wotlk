-- From: Syntax: .guild rank [$CharacterName] #Rank Set for player $CharacterName (or selected) rank #Rank in a guild.
UPDATE `command` SET `help` = "Syntax: .guild rank [$CharacterName] #RankNumber\r\n\r\nSet for player $CharacterName (or selected) rank #Rank in a guild. Ranks value are numeric, 0 = Guild Master, 1 = Officer, etc..." WHERE `name` LIKE "guild rank";
