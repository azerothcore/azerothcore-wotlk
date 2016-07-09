#ifndef AZTH_PLG_MGR_H
#define	AZTH_PLG_MGR_H

#include "ScriptMgr.h"

class AzerothPlugins : public ScriptObject
{
    protected:

        AzerothPlugins(const char* name);

    public:
        //Test function to show usage
        virtual void onTest() { }
};

class AzthPlgMgr {
private:
    AzthPlgMgr();
    ~AzthPlgMgr();
public: /* singleton init */

    static AzthPlgMgr* instance() {
        static AzthPlgMgr instance;
        return &instance;
    }

    void Initialization();
};

#define sAzthPlg AzthPlgMgr::instance()

#endif	/* AZTH_PLG_MGR_H */

