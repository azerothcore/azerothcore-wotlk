/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

class PlayerCommand
{
public:
    static bool Learn(ChatHandler* handler, Player* targetPlayer, uint32 spell, char const* all);
    static bool UnLearn(ChatHandler* handler, Player* targetPlayer, uint32 spell, char const* all);
};
