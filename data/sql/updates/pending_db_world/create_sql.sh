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

DELETE FROM `quest_offer_reward` WHERE (`ID` = 1507);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(1507, 0, 0, 0, 0, 0, 0, 0, 0, 'Hm... $N. You are still new to your path, but I sense the possibility for greatness in you.$B$BYou were born with gifts, $N. See that they do not go to waste.', 12340);
