/*Based on Boss Announcer by DecrypteD
Refactored by JAGPH TeaM
*/
#include "Config.h"
#include "Player.h"
#include "Creature.h"
#include "World.h"


class pvpelite_announcer : public PlayerScript
{
public:
    pvpelite_announcer() : PlayerScript("pvpelite_announcer") {}

    void OnPlayerKilledByCreature(Creature* killer, Player* killed)
    {
        if (sConfigMgr->GetOption("KilledByCreature.Announcer", true))
        {
            if (killer->isElite())
            {
                std::string plr = killed->GetName();
                std::string creature_n = killer->GetName();
                std::string tag_colour = "7bbef7";
                std::string plr_colour = "7bbef7";
                std::string creature_colour = "ff0000";
                std::ostringstream stream;
                stream << "|CFF" << tag_colour <<
                    "|r|cff" << plr_colour << " " << plr <<
                    "|r killed by the elite |CFF" << creature_colour << "" << creature_n << "|r " "creature" << "!";
                sWorld->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
            }
        }

        if (killer->isWorldBoss())
        {
            std::string plr = killed->GetName();
            std::string creature_n = killer->GetName();
            std::string tag_colour = "7bbef7";
            std::string plr_colour = "7bbef7";
            std::string creature_colour = "ff0000";
            std::ostringstream stream;
            stream << "|CFF" << tag_colour <<
                "|r|cff" << plr_colour << " " << plr <<
                "|r killed by the legendary |CFF" << creature_colour << "" << creature_n << "|r " "world boss" << "!";
            sWorld->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
        }

        if (killer->IsDungeonBoss())
        {
            std::string plr = killed->GetName();
            std::string creature_n = killer->GetName();
            std::string tag_colour = "7bbef7";
            std::string plr_colour = "7bbef7";
            std::string creature_colour = "ff0000";
            std::ostringstream stream;
            stream << "|CFF" << tag_colour <<
                "|r|cff" << plr_colour << " " << plr <<
                "|r killed by the mighty |CFF" << creature_colour << "" << creature_n << "|r " "dungeon boss" << "!";
            sWorld->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
        }
    }

    void OnPVPKill(Player* killer, Player* killed)
    {
        if (sConfigMgr->GetOption("PvPKill.Announcer", true))
        {
            if (killer->IsPlayer())
            {
                std::string plr = killed->GetName();
                std::string creature_n = killer->GetName();
                std::string tag_colour = "7bbef7";
                std::string plr_colour = "7bbef7";
                std::string creature_colour = "ff0000";
                std::ostringstream stream;
                stream << "|CFF" << tag_colour <<
                    "|r|cff" << plr_colour << " " << plr <<
                    "|r killed by |CFF" << creature_colour << "" << creature_n << "|r " "player" << "!";
                sWorld->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
            }
        }
    }
};

void AddSC_pvpelite_announcer()
{
    new pvpelite_announcer;
}
