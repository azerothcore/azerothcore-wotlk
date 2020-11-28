#ifndef AZEROTHCORE_SINGLETONMGR_H
#define AZEROTHCORE_SINGLETONMGR_H

#include "Log.h"

class SingletonMgr
{
private:
    SingletonMgr() {}
    ~SingletonMgr() {}
    SingletonMgr(SingletonMgr const&) = delete;
    SingletonMgr(SingletonMgr&&) = delete;
    SingletonMgr& operator=(SingletonMgr const&) = delete;
    SingletonMgr& operator=(SingletonMgr&&) = delete;

    // TODO: do the same with all other singletons (sWhatever::)
    ILog* log = new Log();
public:
    static SingletonMgr* instance()
    {
        static SingletonMgr instance;
        return &instance;
    }

    ILog *getLog() const { return log; }

    // setters are meant to be used ONLY for testing purposes
    void setLog(ILog *newLog) { log = newLog; }
};

#define sLog SingletonMgr::instance()->getLog()

#endif //AZEROTHCORE_SINGLETONMGR_H
