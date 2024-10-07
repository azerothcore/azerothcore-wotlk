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
#define SPELL_Teach_Learn_Talent_Specialization_Switches 63680
#define SPELL_Learn_a_Second_Talent_Specialization 63624

static const std::unordered_set<std::string> knownSpecs = {
     "Discipline", "Holy", "Shadow", "Protection", "Retribution", "Fury", "Arms", "Arcane", "Fire", "Frost", "Affliction", "Demonology", "Destruction",
     "Elemental", "Enhancement", "Restoration", "Ballance", "Feral", "Marksmanship", "Beastmastery", "Survival", "Assassination", "Combat", "Subtlety",
     "Blood", "Unholy"
 };

enum templateSpells
{
    PLATE_MAIL = 750,
    MAIL = 8737
};

enum WeaponProficiencies
{
    BLOCK = 107,
    BOWS = 264,
    CROSSBOWS = 5011,
    DAGGERS = 1180,
    FIST_WEAPONS = 15590,
    GUNS = 266,
    ONE_H_AXES = 196,
    ONE_H_MACES = 198,
    ONE_H_SWORDS = 201,
    POLEARMS = 200,
    SHOOT = 5019,
    STAVES = 227,
    TWO_H_AXES = 197,
    TWO_H_MACES = 199,
    TWO_H_SWORDS = 202,
    WANDS = 5009,
    THROW_WAR = 2567
};

struct TalentTemplate
{
    std::string    playerClass;
    std::string    playerSpec;
    uint32         talentId;
};

struct GlyphTemplate
{
    std::string    playerClass;
    std::string    playerSpec;
    uint8          slot;
    uint32         glyph;
};

struct HumanGearTemplate
{
    std::string    playerClass;
    std::string    playerSpec;
    uint8          pos;
    uint32         itemEntry;
    uint32         enchant;
    uint32         socket1;
    uint32         socket2;
    uint32         socket3;
    uint32         bonusEnchant;
    uint32         prismaticEnchant;
};

struct AllianceGearTemplate
{
    std::string    playerClass;
    std::string    playerSpec;
    uint8          pos;
    uint32         itemEntry;
    uint32         enchant;
    uint32         socket1;
    uint32         socket2;
    uint32         socket3;
    uint32         bonusEnchant;
    uint32         prismaticEnchant;
};

struct HordeGearTemplate
{
    std::string    playerClass;
    std::string    playerSpec;
    uint8          pos;
    uint32         itemEntry;
    uint32         enchant;
    uint32         socket1;
    uint32         socket2;
    uint32         socket3;
    uint32         bonusEnchant;
    uint32         prismaticEnchant;
};

typedef std::vector<HumanGearTemplate*> HumanGearContainer;
typedef std::vector<AllianceGearTemplate*> AllianceGearContainer;
typedef std::vector<HordeGearTemplate*> HordeGearContainer;

typedef std::vector<TalentTemplate*> TalentContainer;
typedef std::vector<GlyphTemplate*> GlyphContainer;

class sTemplateNPC
{
public:
    static sTemplateNPC* instance()
    {
        static sTemplateNPC* instance = new sTemplateNPC();
        return instance;
    }
    void LoadTalentsContainer();
    void LoadGlyphsContainer();

    void LoadHumanGearContainer();
    void LoadAllianceGearContainer();
    void LoadHordeGearContainer();

    void ApplyGlyph(Player* player, uint8 slot, uint32 glyphID);
    void RemoveAllGlyphs(Player* player);
    void ApplyBonus(Player* player, Item* item, EnchantmentSlot slot, uint32 bonusEntry);

    bool OverwriteTemplate(Player* /*player*/, std::string& /*playerSpecStr*/);
    void ExtractGearTemplateToDB(Player* /*player*/, std::string& /*playerSpecStr*/);
    void ExtractTalentTemplateToDB(Player* /*player*/, std::string& /*playerSpecStr*/);
    void ExtractGlyphsTemplateToDB(Player* /*player*/, std::string& /*playerSpecStr*/);
    bool CanEquipTemplate(Player* /*player*/, std::string& /*playerSpecStr*/);

    void GetSpecAction(Player* /*player*/, int /*action*/);
    void GetMainMenu(Player* /*player*/, Creature *);
    void TemplateNpcWelcome(Player* /*player*/, Creature* /*creature*/);
    bool TemplateExistsCheck(Player* /*player*/, std::string /*playerSpecStr*/);
    bool CheckPlayerIsNaked(Player* /*player*/);
    bool ApplyGear(Player* player, std::string playerSpecStr);
    bool ApplyTalentsAndGlyphs(Player* player, std::string playerSpecStr);
    void LearnWeaponSkills(Player* player);
    void EquipFullTemplateGear(Player* player, std::string playerSpecStr);
    bool CheckSpendTalents(Player* player);
    void LearnTemplateTalents(Player* player, std::string sTalentsSpec);

    std::string GetClassString(Player* /*player*/);
    std::string sTalentsSpec;

    void LearnTemplateGlyphs(Player* /*player*/, std::string sTalentsSpec);
    void EquipTemplateGear(Player* /*player*/, std::string sTalentsSpec);

    void LearnPlateMailSpells(Player* /*player*/);

    GlyphContainer m_GlyphContainer;
    TalentContainer m_TalentContainer;

    HumanGearContainer m_HumanGearContainer;
    AllianceGearContainer m_AllianceGearContainer;
    HordeGearContainer m_HordeGearContainer;
};
#define sTemplateNpcMgr sTemplateNPC::instance()
#endif