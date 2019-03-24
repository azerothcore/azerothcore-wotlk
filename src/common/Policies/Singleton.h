/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_SINGLETON_H
#define ACORE_SINGLETON_H

/**
 * @brief class Singleton
 */

#include "CreationPolicy.h"
#include "ThreadingModel.h"
#include "ObjectLifeTime.h"

namespace ACORE
{
    template
    <
        typename T,
        class ThreadingModel = ACORE::SingleThreaded<T>,
        class CreatePolicy = ACORE::OperatorNew<T>,
        class LifeTimePolicy = ACORE::ObjectLifeTime<T>
        >
    class Singleton
    {
        public:

            static T& Instance();

        protected:

            Singleton()
            {
            }

        private:

            // Prohibited actions...this does not prevent hijacking.
            Singleton(const Singleton&);
            Singleton& operator=(const Singleton&);

            // Singleton Helpers
            static void DestroySingleton();

            // data structure
            typedef typename ThreadingModel::Lock Guard;
            static T* si_instance;
            static bool si_destroyed;
    };

    template<typename T, class ThreadingModel, class CreatePolicy, class LifeTimePolicy>
    T* Singleton<T, ThreadingModel, CreatePolicy, LifeTimePolicy>::si_instance = nullptr;

    template<typename T, class ThreadingModel, class CreatePolicy, class LifeTimePolicy>
    bool Singleton<T, ThreadingModel, CreatePolicy, LifeTimePolicy>::si_destroyed = false;

    template<typename T, class ThreadingModel, class CreatePolicy, class LifeTimePolicy>
    T& ACORE::Singleton<T, ThreadingModel, CreatePolicy, LifeTimePolicy>::Instance()
    {
        if (!si_instance)
        {
            // double-checked Locking pattern
            Guard();

            if (!si_instance)
            {
                if (si_destroyed)
                {
                    si_destroyed = false;
                    LifeTimePolicy::OnDeadReference();
                }

                si_instance = CreatePolicy::Create();
                LifeTimePolicy::ScheduleCall(&DestroySingleton);
            }
        }

        return *si_instance;
    }

    template<typename T, class ThreadingModel, class CreatePolicy, class LifeTimePolicy>
    void ACORE::Singleton<T, ThreadingModel, CreatePolicy, LifeTimePolicy>::DestroySingleton()
    {
        CreatePolicy::Destroy(si_instance);
        si_instance = nullptr;
        si_destroyed = true;
    }
}

#define INSTANTIATE_SINGLETON_1(TYPE) \
    template class ACORE::Singleton<TYPE, ACORE::SingleThreaded<TYPE>, ACORE::OperatorNew<TYPE>, ACORE::ObjectLifeTime<TYPE> >;

#define INSTANTIATE_SINGLETON_2(TYPE, THREADINGMODEL) \
    template class ACORE::Singleton<TYPE, THREADINGMODEL, ACORE::OperatorNew<TYPE>, ACORE::ObjectLifeTime<TYPE> >;

#define INSTANTIATE_SINGLETON_3(TYPE, THREADINGMODEL, CREATIONPOLICY ) \
    template class ACORE::Singleton<TYPE, THREADINGMODEL, CREATIONPOLICY, ACORE::ObjectLifeTime<TYPE> >;

#define INSTANTIATE_SINGLETON_4(TYPE, THREADINGMODEL, CREATIONPOLICY, OBJECTLIFETIME) \
    template class ACORE::Singleton<TYPE, THREADINGMODEL, CREATIONPOLICY, OBJECTLIFETIME >;

#endif