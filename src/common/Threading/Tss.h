/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef TSS_H
#define TSS_H

#include <thread>
#include <atomic>

namespace acore
{
    namespace detail
    {
        // We can't filter out rvalue_references at the same level as
        // references or we get ambiguities from msvc
        template <typename T>
        struct add_reference_impl
        {
            typedef T& type;
        };

        namespace thread
        {
            typedef void(*cleanup_func_t)(void*);
            typedef void(*cleanup_caller_t)(cleanup_func_t, void*);
        }

        ACORE_THREAD_DECL void set_tss_data(void const* key,detail::thread::cleanup_caller_t caller,detail::thread::cleanup_func_t func,void* tss_data,bool cleanup_existing);
        ACORE_THREAD_DECL void* get_tss_data(void const* key);
    }

    template <class T> struct add_reference
    {
        typedef typename acore::detail::add_reference_impl<T>::type type;
    };

    template <class T> struct add_reference<T&>
    {
        typedef T& type;
    };

    class noncopyable
    {
        protected:
            noncopyable() {}
            ~noncopyable() {}
        private:  // emphasize the following members are private
            noncopyable( const noncopyable& );
            const noncopyable& operator=( const noncopyable& );
    };

    template <typename T>
    class thread_specific_ptr
    {
    private:
        thread_specific_ptr(thread_specific_ptr&);
        thread_specific_ptr& operator=(thread_specific_ptr&);

        typedef void(*original_cleanup_func_t)(T*);

        static void default_deleter(T* data)
        {
            delete data;
        }

        static void cleanup_caller(detail::thread::cleanup_func_t cleanup_function,void* data)
        {
            reinterpret_cast<original_cleanup_func_t>(cleanup_function)(static_cast<T*>(data));
        }


        detail::thread::cleanup_func_t cleanup;

    public:
        typedef T element_type;

        thread_specific_ptr():
            cleanup(reinterpret_cast<detail::thread::cleanup_func_t>(&default_deleter))
        {}
        explicit thread_specific_ptr(void (*func_)(T*))
          : cleanup(reinterpret_cast<detail::thread::cleanup_func_t>(func_))
        {}
        ~thread_specific_ptr()
        {
            detail::set_tss_data(this,0,0,0,true);
        }

        T* get() const
        {
            return static_cast<T*>(detail::get_tss_data(this));
        }
        T* operator->() const
        {
            return get();
        }
        typename add_reference<T>::type operator*() const
        {
            return *get();
        }
        T* release()
        {
            T* const temp=get();
            detail::set_tss_data(this,0,0,0,false);
            return temp;
        }
        void reset(T* new_value=0)
        {
            T* const current_value=get();
            if(current_value!=new_value)
            {
                detail::set_tss_data(this,&cleanup_caller,cleanup,new_value,true);
            }
        }
    };

// these full specialisations are always required:
template <> struct add_reference<void> { typedef void type; };
}
#endif
