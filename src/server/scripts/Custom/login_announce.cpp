     
    #include "ScriptPCH.h"
     
    class announce_login : public PlayerScript
    {
    public:
        announce_login() : PlayerScript("announce_login") { }
     
        void OnLogin(Player* player)
        {
            if (player->GetTeamId() == TEAM_ALLIANCE)
                    {
                std::ostringstream ss;
                            ss << "|CFFFE8A0EПриветствуем нового игрока|r: |CFFE55BB0" << player->GetName() << "|r|CFFFE8A0E Фракция|r:" "|CFF0042FF Альянс |r";
                sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA)); // set max mana
                player->SetPower(POWER_ENERGY, player->GetMaxPower(POWER_ENERGY)); //set max rogue/druid enery go on login!
                player->SetPower(POWER_RAGE, player->GetMaxPower(POWER_RAGE)); //set max warrior rage on login!
                player->SetPower(POWER_RUNIC_POWER, player->GetMaxPower(POWER_RUNIC_POWER));  //set max runic power on Death Knight on login!
                player->SetFullHealth(); // set max health on login on game !
                    }
                    else
                    {
                std::ostringstream ss;
                            ss << "|CFFFE8A0EПриветствуем нового игрока|r: |CFFE55BB0" << player->GetName() << "|r|CFFFE8A0E Фракция|r:" "|CFFFF0303 Орда |r" ;
                sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA)); // set max mana
                player->SetPower(POWER_ENERGY, player->GetMaxPower(POWER_ENERGY)); //set max rogue/druid enery go on login!
                player->SetPower(POWER_RAGE, player->GetMaxPower(POWER_RAGE)); //set max warrior rage on login!
                player->SetPower(POWER_RUNIC_POWER, player->GetMaxPower(POWER_RUNIC_POWER));  //set max runic power on Death Knight on login!
                player->SetFullHealth(); // set max health on login on game !
                    }
            }
    };
     
    void AddSC_announce_login()
    {
        new announce_login;
    }  
