#!/usr/bin/env bash

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   date='gdate'
else
   date='date'
fi

CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )";

rev=$( $date +%s%N );
filename=rev_"$rev".sql

echo "INSERT INTO \`version_db_world\` (\`sql_rev\`) VALUES ('"$rev"');" > "$CUR_PATH/$filename" && echo "File created: $filename";

DELETE FROM `gameobject_loot_template` WHERE `Entry`=18092 AND `Item`=2835;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (18092, 2835, 0, 88, 0, 1, 0, 1, 6, NULL);

DELETE FROM `gameobject_loot_template` WHERE `Entry`=1502 AND `Item`=2835;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (1502, 2835, 0, 80, 0, 1, 0, 1, 11, NULL);

DELETE FROM `gameobject_loot_template` WHERE `Entry`=1735 AND `Item`=2835;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (1735, 2835, 0, 80, 0, 1, 0, 1, 6, NULL);

DELETE FROM `gameobject_loot_template` WHERE `Entry`=2626 AND `Item`=2835;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (2626, 2835, 0, 80, 0, 1, 0, 1, 6, NULL);
