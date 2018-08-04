#ifndef SOLO_3V3_H
#define SOLO_3V3_H

// SOLO_3V3_TALENTS found in: TalentTab.dbc -> TalentTabID

// Warrior, Rogue, Deathknight etc.
const uint32 SOLO_3V3_TALENTS_MELEE[] =
{
    383, // PaladinProtection
    163, // WarriorProtection
    161,
    182,
    398,
    164,
    181,
    263,
    281,
    399,
    183,
    381,
    400,
    0 // End
};

// Mage, Hunter, Warlock etc.
const uint32 SOLO_3V3_TALENTS_RANGE[] =
{
    81,
    261,
    283,
    302,
    361,
    41,
    303,
    363,
    61,
    203,
    301,
    362,
    0 // End
};

const uint32 SOLO_3V3_TALENTS_HEAL[] =
{
    201, // PriestDiscipline
    202, // PriestHoly
    382, // PaladinHoly
    262, // ShamanRestoration
    282, // DruidRestoration
    0 // End
};

enum Solo3v3TalentCat
{
    MELEE = 0,
    RANGE,
    HEALER,
    MAX_TALENT_CAT
};

// Returns MELEE, RANGE or HEALER (depends on talent builds)
static Solo3v3TalentCat GetTalentCatForSolo3v3(Player* player)
{
    if (!player)
        return MELEE;

    uint32 count[MAX_TALENT_CAT];
    for (int i = 0; i < MAX_TALENT_CAT; i++)
        count[i] = 0;

    for (uint32 talentId = 0; talentId < sTalentStore.GetNumRows(); ++talentId)
    {
        TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);

        if (!talentInfo)
            continue;

        for (int8 rank = MAX_TALENT_RANK-1; rank >= 0; --rank)
        {
            if (talentInfo->RankID[rank] == 0)
                continue;
                        
            if (player->HasTalent(talentInfo->RankID[rank], player->GetActiveSpec()))
            {
                for (int8 i = 0; SOLO_3V3_TALENTS_MELEE[i] != 0; i++)
                    if (SOLO_3V3_TALENTS_MELEE[i] == talentInfo->TalentTab)
                        count[MELEE] += rank + 1;

				for (int8 i = 0; SOLO_3V3_TALENTS_RANGE[i] != 0; i++)
					if (SOLO_3V3_TALENTS_RANGE[i] == talentInfo->TalentTab)
						count[RANGE] += rank + 1;

                for (int8 i = 0; SOLO_3V3_TALENTS_HEAL[i] != 0; i++)
                    if (SOLO_3V3_TALENTS_HEAL[i] == talentInfo->TalentTab)
                        count[HEALER] += rank + 1;
            }
        }
    }


    uint32 prevCount = 0;
    Solo3v3TalentCat talCat = MELEE; // Default MELEE (if no talent points set)
    for (int i = 0; i < MAX_TALENT_CAT; i++)
    {
        if (count[i] > prevCount)
        {
            talCat = (Solo3v3TalentCat)i;
            prevCount = count[i];
        }
    }

    return talCat;
}

#endif