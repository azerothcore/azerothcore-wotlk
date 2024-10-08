#include "RequestChat.h"
#include "../ChatTransmitter.h"

namespace ModChatTransmitter::Requests
{
    Chat::Chat(Player* player, uint32 type, std::string& msg)
      : guildId(ChatTransmitter::Instance().GetDiscordGuildId()),
        player(player),
        text(msg),
        type(type)
    {
        AreaTableEntry const* area = sAreaTableStore.LookupEntry(player->GetZoneId());
        zone = area ? area->area_name[LocaleConstant::LOCALE_enUS] : "";
    }

    Chat& Chat::operator=(const Chat& other)
    {
        player = other.player;
        text = other.text;
        type = other.type;
        zone = other.zone;

        return *this;
    }

    std::string Chat::GetContents()
    {
        nlohmann::json jsonObj;
        jsonObj["message"] = "localChat";
        nlohmann::to_json(jsonObj["data"], *this);
        return nlohmann::to_string(jsonObj);
    }
}
