/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include <OpenSSLCrypto.h>
#include <openssl/crypto.h>
#include <ace/Thread_Mutex.h>
#include <vector>
#include <ace/Thread.h>

std::vector<ACE_Thread_Mutex*> cryptoLocks;

static void lockingCallback(int mode, int type, const char* /*file*/, int /*line*/)
{
    if (mode & CRYPTO_LOCK)
        cryptoLocks[type]->acquire();
    else
        cryptoLocks[type]->release();
}

static void threadIdCallback(CRYPTO_THREADID * id)
{
/// ACE_thread_t turns out to be a struct under Mac OS.
#ifndef __APPLE__
    CRYPTO_THREADID_set_numeric(id, ACE_Thread::self());
#else
    CRYPTO_THREADID_set_pointer(id, ACE_Thread::self());
#endif
}

void OpenSSLCrypto::threadsSetup()
{
    cryptoLocks.resize(CRYPTO_num_locks());
    for(int i = 0 ; i < CRYPTO_num_locks(); ++i)
    {
        cryptoLocks[i] = new ACE_Thread_Mutex();
    }
    CRYPTO_THREADID_set_callback(threadIdCallback);
    CRYPTO_set_locking_callback(lockingCallback);
}

void OpenSSLCrypto::threadsCleanup()
{
    CRYPTO_set_locking_callback(NULL);
    CRYPTO_THREADID_set_callback(NULL);
    for(int i = 0 ; i < CRYPTO_num_locks(); ++i)
    {
        delete cryptoLocks[i];
    }
    cryptoLocks.resize(0);
}