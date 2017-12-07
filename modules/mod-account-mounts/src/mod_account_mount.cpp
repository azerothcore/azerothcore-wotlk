#include "Config.h"

class AccountMounts : public PlayerScript
{
    static const bool limitrace = false; // This set to true will only learn mounts from chars on the same team, do what you want.
public:
    AccountMounts() : PlayerScript("AccountMounts") { }

    void OnLogin(Player* pPlayer)
    {
        if (sConfigMgr->GetBoolDefault("Account.Mounts.Enable", true))
        {
            if (sConfigMgr->GetBoolDefault("Account.Mounts.Announce", true))
            {
                ChatHandler(pPlayer->GetSession()).SendSysMessage("This server is running the |cff4CFF00AccountMounts |rmodule.");
            }
            std::vector<uint32> Guids;
            uint32 playerGUID = pPlayer->GetGUID();
            QueryResult result1 = CharacterDatabase.PQuery("SELECT guid, race FROM characters WHERE account = %u", playerGUID);
            if (!result1)
                return;

            do
            {
                Field* fields = result1->Fetch();
    
                uint32 guid = fields[0].GetUInt32();
                uint32 race = fields[1].GetUInt8();

                if ((Player::TeamIdForRace(race) == Player::TeamIdForRace(pPlayer->getRace())) || !limitrace)
                    Guids.push_back(result1->Fetch()[0].GetUInt32());

            } while (result1->NextRow());

            std::vector<uint32> Spells;

            for (auto& i : Guids)
            {
                QueryResult result2 = CharacterDatabase.PQuery("SELECT spell FROM character_spell WHERE guid = %u", i);
                if (!result2)
                    continue;

                do
                {
                    Spells.push_back(result2->Fetch()[0].GetUInt32());
                } while (result2->NextRow());
            }

            for (auto& i : Spells)
            {
                auto sSpell = sSpellStore.LookupEntry(i);
                if (sSpell->Effect[0] == SPELL_EFFECT_APPLY_AURA && sSpell->EffectApplyAuraName[0] == SPELL_AURA_MOUNTED)
					pPlayer->learnSpell(sSpell->Id);
            }
        }
	}
};

class AccountMountsWorld : public WorldScript
{
public:
	AccountMountsWorld() : WorldScript("AccountMountsWorld") { }

	void OnBeforeConfigLoad(bool reload) override
	{
		if (!reload) {
			std::string conf_path = _CONF_DIR;
			std::string cfg_file = conf_path + "Settings/modules/mod_account_mount.conf";
#ifdef WIN32
			cfg_file = "Settings/modules/mod_account_mount.conf";
#endif
			std::string cfg_def_file = cfg_file + ".dist";
			sConfigMgr->LoadMore(cfg_def_file.c_str());

			sConfigMgr->LoadMore(cfg_file.c_str());
		}
	}
};

void AddAccountMountsScripts()
{
    new AccountMountsWorld;
    new AccountMounts;
}