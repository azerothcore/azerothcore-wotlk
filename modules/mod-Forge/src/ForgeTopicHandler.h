#include <string>
#include "Player.h"

class ForgeTopicHandler
{
public:
    ForgeTopicHandler(const std::string&);
    ForgeTopicHandler(ForgeTopic);
    virtual void HandleMessage(ForgeAddonMessage&) {};
    std::string HandlesTopic;
};
