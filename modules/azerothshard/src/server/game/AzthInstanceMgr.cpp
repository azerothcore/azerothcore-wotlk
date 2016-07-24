#include "AzthInstanceMgr.h"

 AzthInstanceMgr::AzthInstanceMgr(InstanceSave* is) {
     this->levelMax = 0;
     this->is = is;
 }

 void AzthInstanceMgr::saveToDb() {
     CharacterDatabase.PExecute("UPDATE instance SET levelPg = %u WHERE id = %u", this->levelMax, this->is->GetInstanceId());
 }

