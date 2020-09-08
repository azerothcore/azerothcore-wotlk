/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#ifndef ACORE_THREADINGMODEL_H
#define ACORE_THREADINGMODEL_H

/**
 * @class ThreadingModel<T>
 *
 */

#include "Define.h"

namespace acore
{
    template<typename MUTEX>
    class GeneralLock
    {
        public:

            GeneralLock(MUTEX& m)
                : i_mutex(m)
            {
                i_mutex.lock();
            }

            ~GeneralLock()
            {
                i_mutex.unlock();
            }

        private:

            GeneralLock(const GeneralLock&);
            GeneralLock& operator=(const GeneralLock&);
            MUTEX& i_mutex;
    };

    template<class T>
    class SingleThreaded
    {
        public:

            struct Lock                                     // empty object
            {
                Lock()
                {
                }
                Lock(const T&)
                {
                }

                Lock(const SingleThreaded<T>&)              // for single threaded we ignore this
                {
                }
            };
    };

    template<class T, class MUTEX>
    class ObjectLevelLockable
    {
        public:

            ObjectLevelLockable()
                : i_mtx()
            {
            }

            friend class Lock;

            class Lock
            {
                public:

                    Lock(ObjectLevelLockable<T, MUTEX>& host)
                        : i_lock(host.i_mtx)
                    {
                    }

                private:

                    GeneralLock<MUTEX> i_lock;
            };

        private:

            // prevent the compiler creating a copy construct
            ObjectLevelLockable(const ObjectLevelLockable<T, MUTEX>&);
            ObjectLevelLockable<T, MUTEX>& operator=(const ObjectLevelLockable<T, MUTEX>&);

            MUTEX i_mtx;
    };

    template<class T, class MUTEX>
    class ClassLevelLockable
    {
        public:

            ClassLevelLockable()
            {
            }

            friend class Lock;

            class Lock
            {
                public:

                    Lock(const T& /*host*/)
                    {
                        ClassLevelLockable<T, MUTEX>::si_mtx.lock();
                    }

                    Lock(const ClassLevelLockable<T, MUTEX>&)
                    {
                        ClassLevelLockable<T, MUTEX>::si_mtx.lock();
                    }

                    Lock()
                    {
                        ClassLevelLockable<T, MUTEX>::si_mtx.lock();
                    }

                    ~Lock()
                    {
                        ClassLevelLockable<T, MUTEX>::si_mtx.unlock();
                    }
            };

        private:

            static MUTEX si_mtx;
    };
}

template<class T, class MUTEX> MUTEX acore::ClassLevelLockable<T, MUTEX>::si_mtx;

#define INSTANTIATE_CLASS_MUTEX(CTYPE, MUTEX) \
    template class acore::ClassLevelLockable<CTYPE, MUTEX>

#endif
