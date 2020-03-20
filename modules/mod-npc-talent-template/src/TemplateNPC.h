#ifndef TALENT_FUNCTIONS_H
#define TALENT_FUNCTIONS_H

#include "Define.h"
#include "Player.h"
#include "Item.h"
#include "DBCStores.h"
#include "Log.h"
#include "DatabaseEnv.h"
#include "WorldSession.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "GossipDef.h"
#include "Creature.h"
#include "ObjectMgr.h"

#define SPELL_Amani_War_Bear 43688
#define SPELL_Artisan_Riding 34091
#define SPELL_Cold_Weather_Flying 54197

struct TalentTemplate
{
    std::string playerClass;
    std::string playerSpec;
    uint32 talentId;
};

struct GlyphTemplate
{
    std::string playerClass;
    std::string playerSpec;
    uint8 slot;
    uint32 glyph;
};

struct HumanGearTemplate
{
    std::string playerClass;
    std::string playerSpec;
    uint8 pos;
    uint32 itemEntry;
    uint32 enchant;
    uint32 socket1;
    uint32 socket2;
    uint32 socket3;
    uint32 bonusEnchant;
    uint32 prismaticEnchant;
};

struct AllianceGearTemplate
{
    std::string playerClass;
    std::string playerSpec;
    uint8 pos;
    uint32 itemEntry;
    uint32 enchant;
    uint32 socket1;
    uint32 socket2;
    uint32 socket3;
    uint32 bonusEnchant;
    uint32 prismaticEnchant;
};

struct HordeGearTemplate
{
    std::string playerClass;
    std::string playerSpec;
    uint8 pos;
    uint32 itemEntry;
    uint32 enchant;
    uint32 socket1;
    uint32 socket2;
    uint32 socket3;
    uint32 bonusEnchant;
    uint32 prismaticEnchant;
};

enum TemplateType
{
    TYPE_HUMAN,
    TYPE_ALLIANCE,
    TYPE_HORDE
};

typedef std::vector<AllianceGearTemplate*> AllianceGearContainer;
typedef std::vector<HordeGearTemplate*> HordeGearContainer;
typedef std::vector<HumanGearTemplate*> HumanGearContainer;

typedef std::vector<TalentTemplate *> TalentContainer;
typedef std::vector<GlyphTemplate *> GlyphContainer;

class sTemplateNPC
{
public:
    static sTemplateNPC *instance()
    {
        static sTemplateNPC *instance = new sTemplateNPC();
        return instance;
    }
    void LoadTalentsContainer();
    void LoadGlyphsContainer();

    void LoadHumanGearContainer();
    void LoadAllianceGearContainer();
    void LoadHordeGearContainer();

    void ApplyGlyph(Player *player, uint8 slot, uint32 glyphID);
    void RemoveAllGlyphs(Player *player);
    void ApplyBonus(Player *player, Item *item, EnchantmentSlot slot, uint32 bonusEntry);
    void PurgeTemplate(Player *player, std::string &playerSpecStr, TemplateType type);
    void ExtractGearTemplateToDB(Player * /*player*/, std::string & /*playerSpecStr*/, TemplateType /*templateType*/);
    bool CanEquipTemplate(Player * /*player*/, std::string & /*playerSpecStr*/);
    void CopyGear(Player* target, Player* src);

    std::string GetClassString(Player * /*player*/);
    std::string sTalentsSpec;

    void EquipTemplateGear(Player * /*player*/);

    GlyphContainer m_GlyphContainer;
    TalentContainer m_TalentContainer;

    HumanGearContainer m_HumanGearContainer;
    AllianceGearContainer m_AllianceGearContainer;
    HordeGearContainer m_HordeGearContainer;
};
#define sTemplateNpcMgr sTemplateNPC::instance()
#endif
