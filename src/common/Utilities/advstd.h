/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _ACORE_ADV_STD_H_
#define _ACORE_ADV_STD_H_

#include <cstddef>
#include <type_traits>

// this namespace holds implementations of upcoming stdlib features that our c++ version doesn't have yet
namespace advstd
{
    // C++20 advstd::remove_cvref_t
    template <class T>
    using remove_cvref_t = std::remove_cv_t<std::remove_reference_t<T>>;

    // C++20 std::type_identity
    template <typename T>
    struct type_identity
    {
        using type = T;
    };

    // C++20 std::type_identity_t
    template <typename T>
    using type_identity_t = typename type_identity<T>::type;
}

#endif // _ADV_STD_H_
