#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"

class UseSkillBook : public ItemScript
{
public:
    UseSkillBook() : ItemScript("UseSkillBook")
    {

    }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& targets) override
    {
        return false;
    }
};
