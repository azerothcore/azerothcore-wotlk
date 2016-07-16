#include "ScriptMgr.h"
#include "Chat.h"
#include "Language.h"
#include "server/game/CustomRates.h"
#include "Player.h"

 // [TODO] fix and re-enable
float CustomRates::GetRateFromDB(const Player *player, CharacterDatabaseStatements statement) {
    PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(statement);
    stmt->setUInt32(0, player->GetGUID());
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (result)
        return (*result)[0].GetFloat();

    return -1;
}

void CustomRates::SaveRateToDB(const Player *player, float rate, bool update, CharacterDatabaseStatements uStmt, CharacterDatabaseStatements iStmt) {
    if (update) {
        PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(uStmt);
        stmt->setFloat(0, rate);
        stmt->setUInt32(1, player->GetGUID());
        CharacterDatabase.Execute(stmt);
    } else {
        PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(iStmt);
        stmt->setUInt32(0, player->GetGUID());
        stmt->setUInt32(1, rate);
        CharacterDatabase.Execute(stmt);
    }
}

void CustomRates::DeleteRateFromDB(uint64 guid, CharacterDatabaseStatements statement) {
    PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(statement);
    stmt->setUInt32(0, guid);
    CharacterDatabase.Execute(stmt);
}

float CustomRates::GetXpRateFromDB(const Player *player) {
    return GetRateFromDB(player, CHAR_SEL_INDIVIDUAL_XP_RATE);
}

void CustomRates::SaveXpRateToDB(const Player *player, float rate) {
    float rateFromDB = CustomRates::GetXpRateFromDB(player);
    bool update = true;

    if (rateFromDB == -1)
        update = false;

    SaveRateToDB(player, rate, update, CHAR_UPD_INDIVIDUAL_XP_RATE, CHAR_INS_INDIVIDUAL_XP_RATE);
}
