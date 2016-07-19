#ifndef AZTHINSTANCEMGR_H
#define AZTHINSTANCEMGR_H

#include "InstanceSaveMgr.h"

class AzthInstanceMgr {
    public:
        explicit AzthInstanceMgr(InstanceSave* is);
        ~AzthInstanceMgr();

        void saveToDb();

        InstanceSave* is;
        uint8 levelMax;
};
#endif
