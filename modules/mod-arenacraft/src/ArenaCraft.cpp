#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"

#define SPELL_Teach_Learn_Talent_Specialization_Switches 63680
#define SPELL_Learn_a_Second_Talent_Specialization 63624

enum Hunter_Talents
{
    Wyvern_Sting = 19386,
    Explosive_Shot = 53301,
    Counter_Attack = 19306,
    Aimed_Shot = 19434,
    Black_Arrow = 3674
};

enum Death_Kight_Talents
{
    Heart_Strike = 55050,
    Frost_Strike = 49143,
    Howling_Blast = 49184,
    Scourge_Strike = 55090,
    Corpse_Explosion = 49158
};

enum Warrior_Talents
{
    Mortal_Strike = 12294,
    Devastate = 20243
};

enum Paladin_Talents
{
    Holy_Shield = 20925,
    Avengers_Shield = 31935,
    Holy_Shock = 20473,
    Blessing_of_Sanctuary = 20911,
    Greater_Blessing_of_Sanctuary = 25899
};

enum Mage_Talents
{
    Pyroblast = 11366,
    Ice_Barrier = 11426,
    Living_Bomb = 44457,
    Dragons_Breath = 31661,
    Blast_Wave = 11113,
    Arcane_Barrage = 44425
};

enum Warlock_Talents
{
    Shadowburn = 17877,
    Shadowfury = 30283,
    Unstable_Affliction = 30108,
    Chaos_Bolt = 50796,
    Haunt = 48181,
    Dark_Pact = 18220
};

enum Rogue_Talents
{
    Hemorrhage = 16511,
    Mutilate = 1329
};

enum Priest_Talents
{
    Vampiric_Touch = 34914,
    Penance = 47540,
    Lightwell = 724,
    Desperate_Prayer = 19236,
    Circle_of_Healing = 34861,
    Mind_Flay = 15407
};

enum Shaman_Talents
{
    Riptide = 61295,
    Earth_Shield = 974,
    Totem_of_Wrath = 30706,
    Thunderstorm = 51490
};

enum Druid_Talents
{
    Typhoon = 50516,
    Starfall = 48505,
    Wild_Growth = 48438,
    Insect_Swarm = 5570,
    Mangle_Cat = 33876,
    Mangle_Bear = 33878
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

enum ARMOR_TYPES
{
    PLATE_MAIL = 750,
    MAIL = 8737
};

static void LearnPlateMailSpells(Player *player)
{
    switch (player->getClass())
    {
    case CLASS_WARRIOR:
    case CLASS_PALADIN:
    case CLASS_DEATH_KNIGHT:
        if (!player->HasSpell(PLATE_MAIL))
        {
            player->learnSpell(PLATE_MAIL);
        }
        break;
    case CLASS_SHAMAN:
    case CLASS_HUNTER:
        if (!player->HasSpell(MAIL))
        {
            player->learnSpell(MAIL);
        }
        break;
    default:
        break;
    }
}

static void LearnWeaponSkills(Player *player)
{
    using ClassToWeapons = std::unordered_map<uint8, std::vector<WeaponProficiencies>>;
    static ClassToWeapons classToWeaponLookup = {
        {CLASS_WARRIOR, {
                            THROW_WAR,
                            TWO_H_SWORDS,
                            TWO_H_MACES,
                            TWO_H_AXES,
                            STAVES,
                            POLEARMS,
                            ONE_H_SWORDS,
                            ONE_H_MACES,
                            ONE_H_AXES,
                            GUNS,
                            FIST_WEAPONS,
                            DAGGERS,
                            CROSSBOWS,
                            BOWS,
                            BLOCK,
                        }},
        {CLASS_PRIEST, {
                           WANDS,
                           STAVES,
                           SHOOT,
                           ONE_H_MACES,
                           DAGGERS,
                       }},
        {CLASS_PALADIN, {
                            TWO_H_SWORDS,
                            TWO_H_MACES,
                            TWO_H_AXES,
                            POLEARMS,
                            ONE_H_SWORDS,
                            ONE_H_MACES,
                            ONE_H_AXES,
                            BLOCK,
                        }},
        {CLASS_ROGUE, {
                          ONE_H_SWORDS,
                          ONE_H_MACES,
                          ONE_H_AXES,
                          GUNS,
                          FIST_WEAPONS,
                          DAGGERS,
                          CROSSBOWS,
                          BOWS,
                      }},
        {CLASS_DEATH_KNIGHT, {
                                 TWO_H_SWORDS,
                                 TWO_H_MACES,
                                 TWO_H_AXES,
                                 POLEARMS,
                                 ONE_H_SWORDS,
                                 ONE_H_MACES,
                                 ONE_H_AXES,
                             }},
        {CLASS_MAGE, {
                         WANDS,
                         STAVES,
                         SHOOT,
                         ONE_H_SWORDS,
                         DAGGERS,
                     }},

        {CLASS_SHAMAN, {
                           TWO_H_MACES,
                           TWO_H_AXES,
                           STAVES,
                           ONE_H_MACES,
                           ONE_H_AXES,
                           FIST_WEAPONS,
                           DAGGERS,
                           BLOCK,
                       }},
        {CLASS_HUNTER, {
                           THROW_WAR,
                           TWO_H_SWORDS,
                           TWO_H_AXES,
                           STAVES,
                           POLEARMS,
                           ONE_H_SWORDS,
                           ONE_H_AXES,
                           GUNS,
                           FIST_WEAPONS,
                           DAGGERS,
                           CROSSBOWS,
                           BOWS,
                       }},
        {CLASS_DRUID, {
                          TWO_H_MACES,
                          STAVES,
                          POLEARMS,
                          ONE_H_MACES,
                          FIST_WEAPONS,
                          DAGGERS,
                      }},
        {CLASS_WARLOCK, {
                            WANDS,
                            STAVES,
                            SHOOT,
                            ONE_H_SWORDS,
                            DAGGERS,
                        }}};
    auto playerClassWepSkills = classToWeaponLookup.find(player->getClass())->second;
    for (auto playerClassWepSkill : playerClassWepSkills)
    {
        if (player->HasSpell(playerClassWepSkill))
            continue;
        player->learnSpell(playerClassWepSkill);
    }
    player->UpdateSkillsToMaxSkillsForLevel();
}


class ArenaCraftPlayerScripts : public PlayerScript
{
public:
    ArenaCraftPlayerScripts() : PlayerScript("ArenaCraftPlayerScripts") {}

    void OnFirstLogin(Player *player) override
    {
        // heartstone
        WorldLocation loc(4116.0, 3065.0, 339.50, 4.9);
        player->SetHomebind(loc, 3738);
        player->AddItem(6948, 1);

        // chicken mount
        player->learnSpell(65917);

        player->CastSpell(player, SPELL_Teach_Learn_Talent_Specialization_Switches, player->GetGUID());
        player->CastSpell(player, SPELL_Learn_a_Second_Talent_Specialization, player->GetGUID());

        LearnWeaponSkills(player);
        LearnPlateMailSpells(player);

    }
};

void AddArenaCraftScripts()
{
    new ArenaCraftPlayerScripts();
}
