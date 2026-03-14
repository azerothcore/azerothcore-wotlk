//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_NODE_HPP
#define FK_YAML_NODE_HPP

#include <algorithm>
#include <cstdint>
#include <cstring>
#include <initializer_list>
#include <map>
#include <memory>
#include <string>
#include <type_traits>
#include <vector>

// #include <fkYAML/detail/macros/define_macros.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_MACROS_DEFINE_MACROS_HPP
#define FK_YAML_DETAIL_MACROS_DEFINE_MACROS_HPP

// #include <fkYAML/detail/macros/version_macros.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

// Check version definitions if already defined.
#if defined(FK_YAML_MAJOR_VERSION) && defined(FK_YAML_MINOR_VERSION) && defined(FK_YAML_PATCH_VERSION)
#if FK_YAML_MAJOR_VERSION != 0 || FK_YAML_MINOR_VERSION != 4 || FK_YAML_PATCH_VERSION != 2
#warning Already included a different version of the fkYAML library!
#else
// define macros to skip defining macros down below.
#define FK_YAML_VERCHECK_SUCCEEDED
#endif
#endif

#ifndef FK_YAML_VERCHECK_SUCCEEDED

#define FK_YAML_MAJOR_VERSION 0
#define FK_YAML_MINOR_VERSION 4
#define FK_YAML_PATCH_VERSION 2

#define FK_YAML_NAMESPACE_VERSION_CONCAT_IMPL(major, minor, patch) v##major##_##minor##_##patch

#define FK_YAML_NAMESPACE_VERSION_CONCAT(major, minor, patch) FK_YAML_NAMESPACE_VERSION_CONCAT_IMPL(major, minor, patch)

#define FK_YAML_NAMESPACE_VERSION                                                                                      \
    FK_YAML_NAMESPACE_VERSION_CONCAT(FK_YAML_MAJOR_VERSION, FK_YAML_MINOR_VERSION, FK_YAML_PATCH_VERSION)

#define FK_YAML_NAMESPACE_BEGIN                                                                                        \
    namespace fkyaml {                                                                                                 \
    inline namespace FK_YAML_NAMESPACE_VERSION {

#define FK_YAML_NAMESPACE_END                                                                                          \
    } /* inline namespace FK_YAML_NAMESPACE_VERSION */                                                                 \
    } // namespace fkyaml

#define FK_YAML_DETAIL_NAMESPACE_BEGIN                                                                                 \
    FK_YAML_NAMESPACE_BEGIN                                                                                            \
    namespace detail {

#define FK_YAML_DETAIL_NAMESPACE_END                                                                                   \
    } /* namespace detail */                                                                                           \
    FK_YAML_NAMESPACE_END

#endif // !defined(FK_YAML_VERCHECK_SUCCEEDED)

// #include <fkYAML/detail/macros/cpp_config_macros.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_MACROS_CPP_CONFIG_MACROS_HPP
#define FK_YAML_DETAIL_MACROS_CPP_CONFIG_MACROS_HPP

// This file is assumed to be included only by version_macros.hpp file.
// To avoid redundant inclusion, do not include version_macros.hpp file as the other files do.

// With the MSVC compilers, the value of __cplusplus is by default always "199611L"(C++98).
// To avoid that, the library instead references _MSVC_LANG which is always set a correct value.
// See https://devblogs.microsoft.com/cppblog/msvc-now-correctly-reports-__cplusplus/ for more details.
#if defined(_MSVC_LANG) && !defined(__clang__)
#define FK_YAML_CPLUSPLUS _MSVC_LANG
#else
#define FK_YAML_CPLUSPLUS __cplusplus
#endif

// C++ language standard detection
// Skip detection if the definitions listed below already exist.
#if !defined(FK_YAML_HAS_CXX_23) && !defined(FK_YAML_HAS_CXX_20) && !defined(FK_YAML_HAS_CXX_17) &&                    \
    !defined(FK_YAML_HAS_CXX_14) && !defined(FK_YAML_CXX_11)
#if FK_YAML_CPLUSPLUS >= 202302L
#define FK_YAML_HAS_CXX_23
#define FK_YAML_HAS_CXX_20
#define FK_YAML_HAS_CXX_17
#define FK_YAML_HAS_CXX_14
#elif FK_YAML_CPLUSPLUS >= 202002L
#define FK_YAML_HAS_CXX_20
#define FK_YAML_HAS_CXX_17
#define FK_YAML_HAS_CXX_14
#elif FK_YAML_CPLUSPLUS >= 201703L
#define FK_YAML_HAS_CXX_17
#define FK_YAML_HAS_CXX_14
#elif FK_YAML_CPLUSPLUS >= 201402L
#define FK_YAML_HAS_CXX_14
#endif

// C++11 is the minimum required version of the fkYAML library.
#define FK_YAML_HAS_CXX_11
#endif

// switch usage of the deprecated attribute. [[deprecated]] is available since C++14.
#if defined(FK_YAML_HAS_CXX_14)
#define FK_YAML_DEPRECATED(msg) [[deprecated(msg)]]
#else
#if defined(_MSC_VER)
#define FK_YAML_DEPRECATED(msg) __declspec(deprecated(msg))
#elif defined(__GNUC__) || defined(__clang__)
#define FK_YAML_DEPRECATED(msg) __attribute__((deprecated(msg)))
#else
#define FK_YAML_DEPRECATED(msg)
#endif
#endif

// switch usage of inline variables which have been available since C++17.
#if defined(FK_YAML_HAS_CXX_17)
#define FK_YAML_INLINE_VAR inline
#else
#define FK_YAML_INLINE_VAR
#endif

// switch usage of constexpr keyword depending on active C++ standard.
#if defined(FK_YAML_HAS_CXX_17)
#define FK_YAML_CXX17_CONSTEXPR constexpr
#else
#define FK_YAML_CXX17_CONSTEXPR
#endif

// Detect __has_* macros.
// The following macros replace redundant `defined(__has_*) && __has_*(...)`.

#ifdef __has_include
#define FK_YAML_HAS_INCLUDE(header) __has_include(header)
#else
#define FK_YAML_HAS_INCLUDE(header) (0)
#endif

#ifdef __has_builtin
#define FK_YAML_HAS_BUILTIN(builtin) __has_builtin(builtin)
#else
#define FK_YAML_HAS_BUILTIN(builtin) (0)
#endif

#ifdef __has_cpp_attribute
#define FK_YAML_HAS_CPP_ATTRIBUTE(attr) __has_cpp_attribute(attr)
#else
#define FK_YAML_HAS_CPP_ATTRIBUTE(attr) (0)
#endif

#ifdef __has_feature
#define FK_YAML_HAS_FEATURE(feat) __has_feature(feat)
#else
#define FK_YAML_HAS_FEATURE(feat) (0)
#endif

// switch usage of the no_sanitize attribute only when Clang sanitizer is active.
#if defined(__clang__) && FK_YAML_HAS_FEATURE(address_sanitizer)
#define FK_YAML_NO_SANITIZE(...) __attribute__((no_sanitize(__VA_ARGS__)))
#else
#define FK_YAML_NO_SANITIZE(...)
#endif

#if FK_YAML_HAS_INCLUDE(<version>)
// <version> is available since C++20
#include <version>
#endif

//
// C++ feature detections
//

// switch usages of the std::to_chars()/std::from_chars() functions which have been available since C++17.
#if defined(FK_YAML_HAS_CXX_17) && defined(__cpp_lib_to_chars) && __cpp_lib_to_chars >= 201611L
#define FK_YAML_HAS_TO_CHARS (1)
#else
#define FK_YAML_HAS_TO_CHARS (0)
#endif

// switch usage of char8_t which has been available since C++20.
#if defined(FK_YAML_HAS_CXX_20) && defined(__cpp_char8_t) && __cpp_char8_t >= 201811L
#define FK_YAML_HAS_CHAR8_T (1)
#else
#define FK_YAML_HAS_CHAR8_T (0)
#endif

//
// utility macros
//

// switch usage of [[likely]] C++ attribute which has been available since C++20.
#if defined(FK_YAML_HAS_CXX_20) && FK_YAML_HAS_CPP_ATTRIBUTE(likely) >= 201803L
#define FK_YAML_LIKELY(expr) (!!(expr)) [[likely]]
#elif FK_YAML_HAS_BUILTIN(__builtin_expect)
#define FK_YAML_LIKELY(expr) (__builtin_expect(!!(expr), 1))
#else
#define FK_YAML_LIKELY(expr) (!!(expr))
#endif

// switch usage of [[unlikely]] C++ attribute which has been available since C++20.
#if defined(FK_YAML_HAS_CXX_20) && FK_YAML_HAS_CPP_ATTRIBUTE(unlikely) >= 201803L
#define FK_YAML_UNLIKELY(expr) (!!(expr)) [[unlikely]]
#elif FK_YAML_HAS_BUILTIN(__builtin_expect)
#define FK_YAML_UNLIKELY(expr) (__builtin_expect(!!(expr), 0))
#else
#define FK_YAML_UNLIKELY(expr) (!!(expr))
#endif

#endif /* FK_YAML_DETAIL_MACROS_CPP_CONFIG_MACROS_HPP */


#endif /* FK_YAML_DETAIL_MACROS_DEFINE_MACROS_HPP */

// #include <fkYAML/detail/assert.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_ASSERT_HPP
#define FK_YAML_DETAIL_ASSERT_HPP

// if FK_YAML_ASSERT is not user-defined. apply the default assert impl.
#ifndef FK_YAML_ASSERT
#ifndef NDEBUG
#include <cassert>
#define FK_YAML_ASSERT(x) assert(x)
#else
#define FK_YAML_ASSERT(x)
#endif
#endif

#endif /* FK_YAML_DETAIL_ASSERT_HPP */

// #include <fkYAML/detail/document_metainfo.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_DOCUMENT_METAINFO_HPP
#define FK_YAML_DETAIL_DOCUMENT_METAINFO_HPP

#include <string>
#include <map>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/node_traits.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_META_NODE_TRAITS_HPP
#define FK_YAML_DETAIL_META_NODE_TRAITS_HPP

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/detect.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_META_DETECT_HPP
#define FK_YAML_DETAIL_META_DETECT_HPP

#include <iterator>
#include <type_traits>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_META_STL_SUPPLEMENT_HPP
#define FK_YAML_DETAIL_META_STL_SUPPLEMENT_HPP

#include <cstddef>
#include <type_traits>

// #include <fkYAML/detail/macros/define_macros.hpp>


#ifdef FK_YAML_HAS_CXX_14
#include <utility>
#endif

FK_YAML_DETAIL_NAMESPACE_BEGIN

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//   For contributors:
//     This file is for supplementing future C++ STL implementations to utilize some useful features
//     implemented in C++14 or better.
//     This file is needed to keep the fkYAML library requirement to C++11.
//     **DO NOT** implement features which are not included any version of STL in this file.
//     Such implementations must be in the type_traits.hpp file.
/////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef FK_YAML_HAS_CXX_14

/// @brief An alias template for std::add_pointer::type with C++11.
/// @note std::add_pointer_t is available since C++14.
/// @sa https://en.cppreference.com/w/cpp/types/add_pointer
/// @tparam T A type to be added a pointer.
template <typename T>
using add_pointer_t = typename std::add_pointer<T>::type;

/// @brief An alias template for std::enable_if::type with C++11.
/// @note std::enable_if_t is available since C++14.
/// @sa https://en.cppreference.com/w/cpp/types/enable_if
/// @tparam Condition A condition tested at compile time.
/// @tparam T The type defined only if Condition is true.
template <bool Condition, typename T = void>
using enable_if_t = typename std::enable_if<Condition, T>::type;

/// @brief A simple implementation to use std::is_null_pointer with C++11.
/// @note std::is_null_pointer is available since C++14.
/// @sa https://en.cppreference.com/w/cpp/types/is_null_pointer
/// @tparam T The type to be checked if it's equal to std::nullptr_t.
template <typename T>
struct is_null_pointer : std::is_same<std::nullptr_t, typename std::remove_cv<T>::type> {};

/// @brief An alias template for std::remove_cv::type with C++11.
/// @note std::remove_cv_t is available since C++14.
/// @sa https://en.cppreference.com/w/cpp/types/remove_cv
/// @tparam T A type from which const-volatile qualifiers are removed.
template <typename T>
using remove_cv_t = typename std::remove_cv<T>::type;

/// @brief An alias template for std::remove_pointer::type with C++11.
/// @note std::remove_pointer_t is available since C++14.
/// @sa https://en.cppreference.com/w/cpp/types/remove_pointer
/// @tparam T A type from which a pointer is removed.
template <typename T>
using remove_pointer_t = typename std::remove_pointer<T>::type;

/// @brief An alias template for std::remove_reference::type with C++11.
/// @note std::remove_reference_t is available since C++14.
/// @sa https://en.cppreference.com/w/cpp/types/remove_reference
/// @tparam T A type from which a reference is removed.
template <typename T>
using remove_reference_t = typename std::remove_reference<T>::type;

template <typename T, T... I>
struct integer_sequence {
    using value_type = T;
    static constexpr std::size_t size() noexcept {
        return sizeof...(I);
    }
};

#if !FK_YAML_HAS_BUILTIN(__make_integer_seq) && !FK_YAML_HAS_BUILTIN(__integer_pack)

namespace make_int_seq_impl {

template <typename IntSeq0, typename IntSeq1>
struct merger;

template <typename T, T... Ints0, T... Ints1>
struct merger<integer_sequence<T, Ints0...>, integer_sequence<T, Ints1...>> {
    using type = integer_sequence<T, Ints0..., (sizeof...(Ints0) + Ints1)...>;
};

template <typename T, std::size_t Num>
struct generator {
    using type =
        typename merger<typename generator<T, Num / 2>::type, typename generator<T, Num - Num / 2>::type>::type;
};

template <typename T>
struct generator<T, 0> {
    using type = integer_sequence<T>;
};

template <typename T>
struct generator<T, 1> {
    using type = integer_sequence<T, 0>;
};

} // namespace make_int_seq_impl

#endif

template <typename T, T Num>
using make_integer_sequence
#if FK_YAML_HAS_BUILTIN(__make_integer_seq)
    // clang defines built-in __make_integer_seq to generate an integer sequence.
    = __make_integer_seq<integer_sequence, T, Num>;
#elif FK_YAML_HAS_BUILTIN(__integer_pack)
    // GCC or other compilers may implement built-in __integer_pack to generate an
    // integer sequence.
    = integer_sequence<T, __integer_pack(Num)...>;
#else
    // fallback to the library implementation of make_integer_sequence.
    = typename make_int_seq_impl::generator<T, Num>::type;
#endif

template <std::size_t... Idx>
using index_sequence = integer_sequence<std::size_t, Idx...>;

template <std::size_t Num>
using make_index_sequence = make_integer_sequence<std::size_t, Num>;

template <typename... Types>
using index_sequence_for = make_index_sequence<sizeof...(Types)>;

#else // !defined(FK_YAML_HAS_CXX_14)

using std::add_pointer_t;
using std::enable_if_t;
using std::index_sequence;
using std::index_sequence_for;
using std::integer_sequence;
using std::is_null_pointer;
using std::make_index_sequence;
using std::make_integer_sequence;
using std::remove_cv_t;
using std::remove_pointer_t;
using std::remove_reference_t;

#endif // !defined(FK_YAML_HAS_CXX_14)

#ifndef FK_YAML_HAS_CXX_17

/// @brief A simple implementation to use std::bool_constant with C++11/C++14.
/// @tparam Val
template <bool Val>
using bool_constant = std::integral_constant<bool, Val>;

/// @brief A simple implementation to use std::void_t with C++11/C++14.
/// @note
/// std::conjunction is available since C++17.
/// This is applied when no traits are specified as inputs.
/// @sa https://en.cppreference.com/w/cpp/types/conjunction
/// @tparam Traits Type traits to be checked if their ::value are all true.
template <typename... Traits>
struct conjunction : std::true_type {};

/// @brief A partial specialization of conjunction if only one Trait is given.
/// @tparam Trait Type trait to be checked if its ::value is true.
template <typename Trait>
struct conjunction<Trait> : Trait {};

/// @brief A partial specialization of conjunction if more than one traits are given.
/// @tparam First The first type trait to be checked if its ::value is true.
/// @tparam Rest The rest of traits passed as another conjunction template arguments if First::value is true.
template <typename First, typename... Rest>
struct conjunction<First, Rest...> : std::conditional<First::value, conjunction<Rest...>, First>::type {};

/// @brief A simple implementation to use std::disjunction with C++11/C++14.
/// @note
/// std::disjunction is available since C++17.
/// This is applied when no traits are specified as inputs.
/// @sa https://en.cppreference.com/w/cpp/types/disjunction
/// @tparam Traits Type traits to be checked if at least one of their ::value is true.
template <typename... Traits>
struct disjunction : std::false_type {};

/// @brief A partial specialization of disjunction if only one Trait is given.
/// @tparam Trait Type trait to be checked if its ::value is true.
template <typename Trait>
struct disjunction<Trait> : Trait {};

/// @brief A partial specialization of disjunction if more than one traits are given.
/// @tparam First The first type trait to be checked if its ::value is true.
/// @tparam Rest The rest of traits passed as another conjunction template arguments if First::value is false.
template <typename First, typename... Rest>
struct disjunction<First, Rest...> : std::conditional<First::value, First, disjunction<Rest...>>::type {};

/// @brief A simple implementation to use std::negation with C++11/C++14.
/// @note std::negation is available since C++17.
/// @sa https://en.cppreference.com/w/cpp/types/negation
/// @tparam Trait Type trait whose ::value is negated.
template <typename Trait>
struct negation : std::integral_constant<bool, !Trait::value> {};

/// @brief A helper for void_t.
/// @tparam Types Any types to be transformed to void type.
template <typename... Types>
struct make_void {
    using type = void;
};

/// @brief A simple implementation to use std::void_t with C++11/C++14.
/// @note std::void_t is available since C++17.
/// @sa https://en.cppreference.com/w/cpp/types/void_t
/// @tparam Types Any types to be transformed to void type.
template <typename... Types>
using void_t = typename make_void<Types...>::type;

#else // !defined(FK_YAML_HAS_CXX_17)

using std::bool_constant;
using std::conjunction;
using std::disjunction;
using std::negation;
using std::void_t;

#endif // !defined(FK_YAML_HAS_CXX_17)

#ifndef FK_YAML_HAS_CXX_20

/// @brief A simple implementation to use std::remove_cvref_t with C++11/C++14/C++17.
/// @note std::remove_cvref & std::remove_cvref_t are available since C++20.
/// @sa https://en.cppreference.com/w/cpp/types/remove_cvref
/// @tparam T A type from which cv-qualifiers and reference are removed.
template <typename T>
using remove_cvref_t = typename std::remove_cv<typename std::remove_reference<T>::type>::type;

#else

using std::remove_cvref_t;

#endif

/// @brief A wrapper function to call std::unreachable() (since C++23) or similar compiler specific extensions.
/// @note This function is implemented only for better code optimization against dead code and thus excluded from
/// coverage report.
// LCOV_EXCL_START
[[noreturn]] inline void unreachable() {
    // use compiler specific extensions if possible.
    // undefined behavior should be raised by an empty function with noreturn attribute.

#if defined(FK_YAML_HAS_CXX_23) || (defined(__cpp_lib_unreachable) && __cpp_lib_unreachable >= 202202L)
    std::unreachable();
#elif defined(_MSC_VER) && !defined(__clang__) // MSVC
    __assume(false);
#else
    __builtin_unreachable();
#endif
}
// LCOV_EXCL_STOP

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_META_STL_SUPPLEMENT_HPP */


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief A dummy struct to represent detection failure.
struct nonesuch {
    nonesuch() = delete;
    ~nonesuch() = delete;
    nonesuch(const nonesuch&) = delete;
    nonesuch(nonesuch&&) = delete;
    nonesuch& operator=(const nonesuch&) = delete;
    nonesuch& operator=(nonesuch&&) = delete;
};

/// @brief namespace to implement detector type traits
namespace detector_impl {

/// @brief A helper for general type detection.
/// @tparam Default A type to represent detection failure.
/// @tparam AlwaysVoid This must be void type.
/// @tparam Op A type for desired operation type.
/// @tparam Args Argument types passed to desired operation.
template <typename Default, typename AlwaysVoid, template <typename...> class Op, typename... Args>
struct detector : std::false_type {
    /// @brief A type which represents detection failure.
    using type = Default;
};

/// @brief A partial specialization of detector if desired operation type is found.
/// @tparam Default A type to represent detection failure.
/// @tparam Op A type for desired operation type.
/// @tparam Args Argument types passed to desired operation.
template <typename Default, template <typename...> class Op, typename... Args>
struct detector<Default, void_t<Op<Args...>>, Op, Args...> : std::true_type {
    /// @brief A detected type.
    using type = Op<Args...>;
};

} // namespace detector_impl

/// @brief Type traits to detect Op operation with Args argument types
/// @tparam Op A desired operation type.
/// @tparam Args Argument types passed to desired operation.
template <template <typename...> class Op, typename... Args>
using is_detected = detector_impl::detector<nonesuch, void, Op, Args...>;

/// @brief Type traits to represent a detected type.
/// @tparam Op A type for desired operation type.
/// @tparam Args Argument types passed to desired operation.
template <template <typename...> class Op, typename... Args>
using detected_t = typename detector_impl::detector<nonesuch, void, Op, Args...>::type;

/// @brief Type traits to check if Expected and a detected type are exactly the same.
/// @tparam Expected An expected detection result type.
/// @tparam Op A type for desired operation.
/// @tparam Args Argument types passed to desired operation.
template <typename Expected, template <typename...> class Op, typename... Args>
using is_detected_exact = std::is_same<Expected, detected_t<Op, Args...>>;

/// @brief namespace for member type detections of aliases and functions.
namespace detect {

/// @brief The type which represents `iterator` member type.
/// @tparam T A target type.
template <typename T>
using iterator_t = typename T::iterator;

/// @brief The type which represents `key_type` member type.
/// @tparam T A target type.
template <typename T>
using key_type_t = typename T::key_type;

/// @brief The type which represents `mapped_type` member type.
/// @tparam T A target type.
template <typename T>
using mapped_type_t = typename T::mapped_type;

/// @brief The type which represents `value_type` member type.
/// @tparam T A target type.
template <typename T>
using value_type_t = typename T::value_type;

/// @brief The type which represents `difference_type` member type.
/// @tparam T A target type.
template <typename T>
using difference_type_t = typename T::difference_type;

/// @brief The type which represents `pointer` member type.
/// @tparam T A target type.
template <typename T>
using pointer_t = typename T::pointer;

/// @brief The type which represents `reference` member type.
/// @tparam T A target type.
template <typename T>
using reference_t = typename T::reference;

/// @brief The type which represents `iterator_category` member type.
/// @tparam T A target type.
template <typename T>
using iterator_category_t = typename T::iterator_category;

/// @brief The type which represents `container_type` member type.
/// @tparam T A target type.
template <typename T>
using container_type_t = typename T::container_type;

/// @brief The type which represents emplace member function.
/// @tparam T A target type.
template <typename T, typename... Args>
using emplace_fn_t = decltype(std::declval<T>().emplace(std::declval<Args>()...));

/// @brief The type which represents reserve member function.
/// @tparam T A target type.
template <typename T>
using reserve_fn_t = decltype(std::declval<T>().reserve(std::declval<typename remove_cvref_t<T>::size_type>()));

/// @brief Type traits to check if T has `iterator` member type.
/// @tparam T A target type.
template <typename T>
using has_iterator = is_detected<iterator_t, remove_cvref_t<T>>;

/// @brief Type traits to check if T has `key_type` member type.
/// @tparam T A target type.
template <typename T>
using has_key_type = is_detected<key_type_t, remove_cvref_t<T>>;

/// @brief Type traits to check if T has `mapped_type` member type.
/// @tparam T A target type.
template <typename T>
using has_mapped_type = is_detected<mapped_type_t, remove_cvref_t<T>>;

/// @brief Type traits to check if T has `value_type` member type.
/// @tparam T A target type.
template <typename T>
using has_value_type = is_detected<value_type_t, remove_cvref_t<T>>;

/// @brief Type traits to check if T is a std::iterator_traits like type.
/// @tparam T A target type.
template <typename T>
struct is_iterator_traits : conjunction<
                                is_detected<difference_type_t, remove_cvref_t<T>>, has_value_type<remove_cvref_t<T>>,
                                is_detected<pointer_t, remove_cvref_t<T>>, is_detected<reference_t, remove_cvref_t<T>>,
                                is_detected<iterator_category_t, remove_cvref_t<T>>> {};

/// @brief Type traits to check if T has `container_type` member type.
/// @tparam T A target type.
template <typename T>
using has_container_type = is_detected<container_type_t, remove_cvref_t<T>>;

/// @brief Type traits to check if T has reserve member function.
/// @tparam T A target type.
template <typename T>
using has_reserve = is_detected<reserve_fn_t, T>;

// fallback to these STL functions.
using std::begin;
using std::end;

/// @brief Type traits to check if begin/end functions can be called on a T object.
/// @tparam T A target type.
template <typename T, typename = void>
struct has_begin_end : std::false_type {};

/// @brief Type traits to check if begin/end functions can be called on a T object.
/// @tparam T A target type.
template <typename T>
struct has_begin_end<T, void_t<decltype(begin(std::declval<T>()), end(std::declval<T>()))>> : std::true_type {};

} // namespace detect

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_META_DETECT_HPP */

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/meta/type_traits.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_META_TYPE_TRAITS_HPP
#define FK_YAML_DETAIL_META_TYPE_TRAITS_HPP

#include <iterator>
#include <type_traits>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Type trait to check if T and U are comparable types.
/// @tparam Comparator An object type to compare T and U objects.
/// @tparam T A type for comparison.
/// @tparam U The other type for comparison.
/// @tparam typename Placeholder for determining T and U are comparable types.
template <typename Comparator, typename T, typename U, typename = void>
struct is_comparable : std::false_type {};

/// @brief A partial specialization of is_comparable if T and U are comparable types.
/// @tparam Comparator An object type to compare T and U objects.
/// @tparam T A type for comparison.
/// @tparam U The other type for comparison.
template <typename Comparator, typename T, typename U>
struct is_comparable<
    Comparator, T, U,
    void_t<
        decltype(std::declval<Comparator>()(std::declval<T>(), std::declval<U>())),
        decltype(std::declval<Comparator>()(std::declval<U>(), std::declval<T>()))>> : std::true_type {};

/// @brief Type trait to check if KeyType can be used as key type.
/// @tparam Comparator An object type to compare T and U objects.
/// @tparam ObjectKeyType The original key type.
/// @tparam KeyType A type to be used as key type.
template <typename Comparator, typename ObjectKeyType, typename KeyType>
using is_usable_as_key_type = is_comparable<Comparator, ObjectKeyType, KeyType>;

/// @brief Type trait to check if T is of non-boolean integral types.
/// @tparam T A type to be checked.
template <typename T>
using is_non_bool_integral = conjunction<std::is_integral<T>, negation<std::is_same<bool, T>>>;

/// @brief Type traits to check if T is a complete type.
/// @tparam T A type to be checked if a complete type.
/// @tparam typename N/A
template <typename T, typename = void>
struct is_complete_type : std::false_type {};

/// @brief A partial specialization of is_complete_type if T is a complete type.
/// @tparam T
template <typename T>
struct is_complete_type<T, decltype(void(sizeof(T)))> : std::true_type {};

/// @brief A utility alias to test if the value type of `ItrType` is `T`.
/// @tparam ItrType An iterator type.
/// @tparam T The target iterator value type.
template <typename ItrType, typename T>
using is_iterator_of = std::is_same<remove_cv_t<typename std::iterator_traits<ItrType>::value_type>, T>;

/// @brief A utility struct to generate static constant instance.
/// @tparam T A target type for the resulting static constant instance.
template <typename T>
struct static_const {
    static FK_YAML_INLINE_VAR constexpr T value {}; // NOLINT(readability-identifier-naming)
};

#ifndef FK_YAML_HAS_CXX_17
/// @brief A instantiation of static_const::value instance.
/// @note This is required if inline variables are not available. C++11-14 do not provide such a feature yet.
/// @tparam T A target type for the resulting static constant instance.
template <typename T>
constexpr T static_const<T>::value;
#endif

/// @brief A helper structure for tag dispatch.
/// @tparam T A tag type.
template <typename T>
struct type_tag {
    /// @brief A tagged type.
    using type = T;
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_META_TYPE_TRAITS_HPP */

// #include <fkYAML/fkyaml_fwd.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_FKYAML_FWD_HPP
#define FK_YAML_FKYAML_FWD_HPP

#include <cstdint>
#include <map>
#include <string>
#include <vector>

// #include <fkYAML/detail/macros/version_macros.hpp>


FK_YAML_NAMESPACE_BEGIN

/// @brief An ADL friendly converter between basic_node objects and native data objects.
/// @tparam ValueType A target data type.
/// @sa https://fktn-k.github.io/fkYAML/api/node_value_converter/
template <typename ValueType, typename = void>
class node_value_converter;

/// @brief A class to store value of YAML nodes.
/// @sa https://fktn-k.github.io/fkYAML/api/basic_node/
template <
    template <typename, typename...> class SequenceType = std::vector,
    template <typename, typename, typename...> class MappingType = std::map, typename BooleanType = bool,
    typename IntegerType = std::int64_t, typename FloatNumberType = double, typename StringType = std::string,
    template <typename, typename = void> class ConverterType = node_value_converter>
class basic_node;

/// @brief default YAML node value container.
/// @sa https://fktn-k.github.io/fkYAML/api/basic_node/node/
using node = basic_node<>;

/// @brief A minimal map-like container which preserves insertion order.
/// @tparam Key A type for keys.
/// @tparam Value A type for values.
/// @tparam IgnoredCompare A placeholder for key comparison. This will be ignored.
/// @tparam Allocator A class for allocators.
/// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
template <typename Key, typename Value, typename IgnoredCompare, typename Allocator>
class ordered_map;

FK_YAML_NAMESPACE_END

#endif /* FK_YAML_FKYAML_FWD_HPP */


FK_YAML_DETAIL_NAMESPACE_BEGIN

/////////////////////////////
//   is_basic_node traits
/////////////////////////////

/// @brief Actual implementation of the is_basic_node type traits struct.
/// @tparam T A class to be checked if it's a basic_node template class instance type.
template <typename T>
struct is_basic_node_impl : std::false_type {};

/// @brief A partial specialization of is_basic_node_impl for basic_node template class.
/// @tparam SequenceType A type for sequence node value containers.
/// @tparam MappingType A type for mapping node value containers.
/// @tparam BooleanType A type for boolean node values.
/// @tparam IntegerType A type for integer node values.
/// @tparam FloatNumberType A type for float number node values.
/// @tparam StringType A type for string node values.
/// @tparam Converter A type for node-value converter
template <
    template <typename, typename...> class SequenceType, template <typename, typename, typename...> class MappingType,
    typename BooleanType, typename IntegerType, typename FloatNumberType, typename StringType,
    template <typename, typename> class Converter>
struct is_basic_node_impl<
    basic_node<SequenceType, MappingType, BooleanType, IntegerType, FloatNumberType, StringType, Converter>>
    : std::true_type {};

/// @brief A struct to check the template parameter class is a basic_node template class instance type.
/// @tparam T A class to be checked if it's a basic_node template class instance type.
template <typename T>
struct is_basic_node : is_basic_node_impl<remove_cvref_t<T>> {};

///////////////////////////////////
//   is_node_ref_storage traits
///////////////////////////////////

// forward declaration for node_ref_storage<...>
template <typename>
class node_ref_storage;

/// @brief A struct to check the template parameter class is a kind of node_ref_storage_template class.
/// @tparam T A type to be checked if it's a kind of node_ref_storage template class.
template <typename T>
struct is_node_ref_storage : std::false_type {};

/// @brief A partial specialization for node_ref_storage template class.
/// @tparam T A template parameter type of node_ref_storage template class.
template <typename T>
struct is_node_ref_storage<node_ref_storage<T>> : std::true_type {};

///////////////////////////////////////////////////////
//   basic_node conversion API representative types
///////////////////////////////////////////////////////

/// @brief A type represent from_node function.
/// @tparam T A type which provides from_node function.
/// @tparam Args Argument types passed to from_node function.
template <typename T, typename... Args>
using from_node_function_t = decltype(T::from_node(std::declval<Args>()...));

/// @brief A type which represent to_node function.
/// @tparam T A type which provides to_node function.
/// @tparam Args Argument types passed to to_node function.
template <typename T, typename... Args>
using to_node_function_t = decltype(T::to_node(std::declval<Args>()...));

///////////////////////////////////////////////////
//   basic_node conversion API detection traits
///////////////////////////////////////////////////

/// @brief Type traits to check if T is a compatible type for BasicNodeType in terms of from_node function.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A target type passed to from_node function.
/// @tparam typename N/A
template <typename BasicNodeType, typename T, typename = void>
struct has_from_node : std::false_type {};

/// @brief A partial specialization of has_from_node if T is not a basic_node template instance type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A target type passed to from_node function.
template <typename BasicNodeType, typename T>
struct has_from_node<BasicNodeType, T, enable_if_t<negation<is_basic_node<T>>::value>> {
    using converter = typename BasicNodeType::template value_converter_type<T, void>;

    // NOLINTNEXTLINE(readability-identifier-naming)
    static constexpr bool value =
        is_detected_exact<void, from_node_function_t, converter, const BasicNodeType&, T&>::value;
};

/// @brief Type traits to check if T is a compatible type for BasicNodeType in terms of to_node function.
/// @warning Do not pass basic_node type as BasicNodeType to avoid infinite type instantiation.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A target type passed to to_node function.
/// @tparam typename N/A
template <typename BasicNodeType, typename T, typename = void>
struct has_to_node : std::false_type {};

/// @brief A partial specialization of has_to_node if T is not a basic_node template instance type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A target type passed to to_node function.
template <typename BasicNodeType, typename T>
struct has_to_node<BasicNodeType, T, enable_if_t<negation<is_basic_node<T>>::value>> {
    using converter = typename BasicNodeType::template value_converter_type<T, void>;

    // NOLINTNEXTLINE(readability-identifier-naming)
    static constexpr bool value = is_detected_exact<void, to_node_function_t, converter, BasicNodeType&, T>::value;
};

///////////////////////////////////////
//   is_node_compatible_type traits
///////////////////////////////////////

/// @brief Type traits implementation of is_node_compatible_type to check if CompatibleType is a compatible type for
/// BasicNodeType.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam CompatibleType A target type for compatibility check.
/// @tparam typename N/A
template <typename BasicNodeType, typename CompatibleType, typename = void>
struct is_node_compatible_type_impl : std::false_type {};

/// @brief A partial specialization of is_node_compatible_type_impl if CompatibleType is a complete type and is
/// compatible for BasicNodeType.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam CompatibleType A target type for compatibility check.
template <typename BasicNodeType, typename CompatibleType>
struct is_node_compatible_type_impl<
    BasicNodeType, CompatibleType,
    enable_if_t<conjunction<is_complete_type<CompatibleType>, has_to_node<BasicNodeType, CompatibleType>>::value>>
    : std::true_type {};

/// @brief Type traits to check if CompatibleType is a compatible type for BasicNodeType.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam CompatibleType A target type for compatibility check.
template <typename BasicNodeType, typename CompatibleType>
struct is_node_compatible_type : is_node_compatible_type_impl<BasicNodeType, CompatibleType> {};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_META_NODE_TRAITS_HPP */

// #include <fkYAML/yaml_version_type.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_YAML_VERSION_TYPE_HPP
#define FK_YAML_YAML_VERSION_TYPE_HPP

#include <cstdint>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>


FK_YAML_NAMESPACE_BEGIN

enum class yaml_version_type : std::uint8_t {
    VERSION_1_1, //!< YAML version 1.1
    VERSION_1_2, //!< YAML version 1.2
};

inline const char* to_string(yaml_version_type t) noexcept {
    switch (t) {
    case yaml_version_type::VERSION_1_1:
        return "VERSION_1_1";
    case yaml_version_type::VERSION_1_2:
        return "VERSION_1_2";
    default:                   // LCOV_EXCL_LINE
        detail::unreachable(); // LCOV_EXCL_LINE
    }
}

FK_YAML_NAMESPACE_END

#endif /* FK_YAML_YAML_VERSION_TYPE_HPP */


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief The set of directives for a YAML document.
template <typename BasicNodeType, typename = enable_if_t<is_basic_node<BasicNodeType>::value>>
struct document_metainfo {
    /// The YAML version used for the YAML document.
    yaml_version_type version {yaml_version_type::VERSION_1_2};
    /// Whether the YAML version has been specified.
    bool is_version_specified {false};
    /// The prefix of the primary handle.
    std::string primary_handle_prefix;
    /// The prefix of the secondary handle.
    std::string secondary_handle_prefix;
    /// The map of handle-prefix pairs.
    std::map<std::string /*handle*/, std::string /*prefix*/> named_handle_map;
    /// The map of anchor node which allows for key duplication.
    std::multimap<std::string /*anchor name*/, BasicNodeType> anchor_table {};
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_DOCUMENT_METAINFO_HPP */

// #include <fkYAML/detail/exception_safe_allocation.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_EXCEPTION_SAFE_ALLOCATION_HPP
#define FK_YAML_DETAIL_EXCEPTION_SAFE_ALLOCATION_HPP

#include <memory>
#include <utility>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/assert.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Helper struct which ensures destruction/deallocation of heap-allocated objects.
/// @tparam ObjT Object type.
/// @tparam AllocTraits Allocator traits type for the object.
template <typename ObjT, typename AllocTraits>
struct tidy_guard {
    tidy_guard() = delete;

    /// @brief Construct a tidy_guard with a pointer to the object.
    /// @param p_obj
    tidy_guard(ObjT* p_obj) noexcept
        : p_obj(p_obj) {
    }

    // move-only
    tidy_guard(const tidy_guard&) = delete;
    tidy_guard& operator=(const tidy_guard&) = delete;

    /// @brief Move constructs a tidy_guard object.
    tidy_guard(tidy_guard&&) = default;

    /// @brief Move assigns a tidy_guard object.
    /// @return Reference to this tidy_guard object.
    tidy_guard& operator=(tidy_guard&&) = default;

    /// @brief Destroys this tidy_guard object. Destruction/deallocation happen if the pointer is not null.
    ~tidy_guard() {
        if FK_YAML_UNLIKELY (p_obj != nullptr) {
            typename AllocTraits::allocator_type alloc {};
            AllocTraits::destroy(alloc, p_obj);
            AllocTraits::deallocate(alloc, p_obj, 1);
            p_obj = nullptr;
        }
    }

    /// @brief Get the pointer to the object.
    /// @return The pointer to the object.
    ObjT* get() const noexcept {
        return p_obj;
    }

    /// @brief Checks if the pointer is not null.
    explicit operator bool() const noexcept {
        return p_obj != nullptr;
    }

    /// @brief Releases the pointer to the object. No destruction/deallocation happen after this function gets called.
    /// @return The pointer to the object.
    ObjT* release() noexcept {
        ObjT* ret = p_obj;
        p_obj = nullptr;
        return ret;
    }

    /// @brief The pointer to the object.
    ObjT* p_obj {nullptr};
};

/// @brief Allocates and constructs an `ObjT` object with given arguments.
/// @tparam ObjT The object type.
/// @tparam ...Args The argument types.
/// @param ...args The arguments for construction.
/// @return An address of allocated memory on the heap.
template <typename ObjT, typename... Args>
inline ObjT* create_object(Args&&... args) {
    using alloc_type = std::allocator<ObjT>;
    using alloc_traits_type = std::allocator_traits<alloc_type>;

    alloc_type alloc {};
    tidy_guard<ObjT, alloc_traits_type> tg {alloc_traits_type::allocate(alloc, 1)};
    alloc_traits_type::construct(alloc, tg.get(), std::forward<Args>(args)...);

    FK_YAML_ASSERT(tg);
    return tg.release();
}

/// @brief Destroys and deallocates an `ObjT` object.
/// @tparam ObjT The object type.
/// @param p_obj A pointer to the object.
template <typename ObjT>
inline void destroy_object(ObjT* p_obj) {
    FK_YAML_ASSERT(p_obj != nullptr);
    std::allocator<ObjT> alloc;
    std::allocator_traits<decltype(alloc)>::destroy(alloc, p_obj);
    std::allocator_traits<decltype(alloc)>::deallocate(alloc, p_obj, 1);
}

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_EXCEPTION_SAFE_ALLOCATION_HPP */

// #include <fkYAML/detail/input/deserializer.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_INPUT_DESERIALIZER_HPP
#define FK_YAML_DETAIL_INPUT_DESERIALIZER_HPP

#include <algorithm>
#include <deque>
#include <vector>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/document_metainfo.hpp>

// #include <fkYAML/detail/input/lexical_analyzer.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_INPUT_LEXICAL_ANALYZER_HPP
#define FK_YAML_DETAIL_INPUT_LEXICAL_ANALYZER_HPP

#include <algorithm>
#include <cctype>
#include <cstdlib>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/assert.hpp>

// #include <fkYAML/detail/encodings/uri_encoding.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_ENCODINGS_URI_ENCODING_HPP
#define FK_YAML_DETAIL_ENCODINGS_URI_ENCODING_HPP

#include <cctype>
#include <string>

// #include <fkYAML/detail/macros/define_macros.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief A class which handles URI encodings.
class uri_encoding {
public:
    /// @brief Validates the encoding of the given character sequence.
    /// @param begin An iterator to the first element of the character sequence.
    /// @param end An iterator to the past-the-end element of the character sequence.
    /// @return true if all the characters are valid, false otherwise.
    static bool validate(const char* begin, const char* end) noexcept {
        if (begin == end) {
            return true;
        }

        const char* current = begin;

        for (; current != end; ++current) {
            if (*current == '%') {
                const bool are_valid_octets = validate_octets(++current, end);
                if (!are_valid_octets) {
                    return false;
                }

                continue;
            }

            const bool is_allowed_character = validate_character(*current);
            if (!is_allowed_character) {
                return false;
            }
        }

        return true;
    }

private:
    /// @brief Validates the given octets.
    /// @param begin An iterator to the first octet.
    /// @param end An iterator to the past-the-end element of the whole character sequence.
    /// @return true if the octets are valid, false otherwise.
    static bool validate_octets(const char*& begin, const char*& end) {
        for (int i = 0; i < 2; i++, ++begin) {
            if (begin == end) {
                return false;
            }

            // Normalize a character for a-f/A-F comparison
            const int octet = std::tolower(*begin);

            if ('0' <= octet && octet <= '9') {
                continue;
            }

            if ('a' <= octet && octet <= 'f') {
                continue;
            }

            return false;
        }

        return true;
    }

    /// @brief Verify if the given character is allowed as a URI character.
    /// @param c The target character.
    /// @return true if the given character is allowed as a URI character, false otherwise.
    static bool validate_character(const char c) {
        // Check if the current character is one of reserved/unreserved characters which are allowed for
        // use. See the following links for details:
        // * reserved characters:   https://datatracker.ietf.org/doc/html/rfc3986#section-2.2
        // * unreserved characters: https://datatracker.ietf.org/doc/html/rfc3986#section-2.3

        switch (c) {
        // reserved characters (gen-delims)
        case ':':
        case '/':
        case '?':
        case '#':
        case '[':
        case ']':
        case '@':
        // reserved characters (sub-delims)
        case '!':
        case '$':
        case '&':
        case '\'':
        case '(':
        case ')':
        case '*':
        case '+':
        case ',':
        case ';':
        case '=':
        // unreserved characters
        case '-':
        case '.':
        case '_':
        case '~':
            return true;
        default:
            // alphabets and numbers are also allowed.
            return static_cast<bool>(std::isalnum(c));
        }
    }
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_ENCODINGS_URI_ENCODING_HPP */

// #include <fkYAML/detail/encodings/utf_encodings.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_ENCODINGS_UTF_ENCODINGS_HPP
#define FK_YAML_DETAIL_ENCODINGS_UTF_ENCODINGS_HPP

#include <array>
#include <cstdint>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/exception.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_EXCEPTION_HPP
#define FK_YAML_EXCEPTION_HPP

#include <array>
#include <initializer_list>
#include <stdexcept>
#include <string>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/string_formatter.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_STRING_FORMATTER_HPP
#define FK_YAML_DETAIL_STRING_FORMATTER_HPP

#include <cstdarg>
#include <cstdio>
#include <memory>
#include <string>

// #include <fkYAML/detail/macros/define_macros.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

// NOLINTNEXTLINE(cert-dcl50-cpp)
inline std::string format(const char* fmt, ...) {
    // NOLINTBEGIN(cppcoreguidelines-pro-bounds-array-to-pointer-decay,hicpp-no-array-decay)
    va_list vl;
    va_start(vl, fmt);
    int size = std::vsnprintf(nullptr, 0, fmt, vl);
    va_end(vl);

    // LCOV_EXCL_START
    if (size < 0) {
        return "";
    }
    // LCOV_EXCL_STOP

    const std::unique_ptr<char[]> buffer {new char[size + 1] {}};

    va_start(vl, fmt);
    size = std::vsnprintf(buffer.get(), size + 1, fmt, vl);
    va_end(vl);
    // NOLINTEND(cppcoreguidelines-pro-bounds-array-to-pointer-decay,hicpp-no-array-decay)

    return {buffer.get(), static_cast<std::size_t>(size)};
}

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_STRING_FORMATTER_HPP */

// #include <fkYAML/detail/types/node_t.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_TYPES_NODE_T_HPP
#define FK_YAML_DETAIL_TYPES_NODE_T_HPP

#include <cstdint>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/node_type.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_NODE_TYPE_HPP
#define FK_YAML_NODE_TYPE_HPP

#include <cstdint>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>


FK_YAML_NAMESPACE_BEGIN

enum class node_type : std::uint8_t {
    SEQUENCE,    //!< sequence value type
    MAPPING,     //!< mapping value type
    NULL_OBJECT, //!< null value type
    BOOLEAN,     //!< boolean value type
    INTEGER,     //!< integer value type
    FLOAT,       //!< float point value type
    STRING,      //!< string value type
};

inline const char* to_string(node_type t) noexcept {
    switch (t) {
    case node_type::SEQUENCE:
        return "SEQUENCE";
    case node_type::MAPPING:
        return "MAPPING";
    case node_type::NULL_OBJECT:
        return "NULL_OBJECT";
    case node_type::BOOLEAN:
        return "BOOLEAN";
    case node_type::INTEGER:
        return "INTEGER";
    case node_type::FLOAT:
        return "FLOAT";
    case node_type::STRING:
        return "STRING";
    default:                   // LCOV_EXCL_LINE
        detail::unreachable(); // LCOV_EXCL_LINE
    }
}

FK_YAML_NAMESPACE_END

#endif /* FK_YAML_NODE_TYPE_HPP */


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Definition of node value types.
enum class node_t : std::uint8_t {
    SEQUENCE,     //!< sequence value type
    MAPPING,      //!< mapping value type
    NULL_OBJECT,  //!< null value type
    BOOLEAN,      //!< boolean value type
    INTEGER,      //!< integer value type
    FLOAT_NUMBER, //!< float number value type
    STRING,       //!< string value type
};

inline const char* to_string(node_t t) noexcept {
    switch (t) {
    case node_t::SEQUENCE:
        return "sequence";
    case node_t::MAPPING:
        return "mapping";
    case node_t::NULL_OBJECT:
        return "null";
    case node_t::BOOLEAN:
        return "boolean";
    case node_t::INTEGER:
        return "integer";
    case node_t::FLOAT_NUMBER:
        return "float";
    case node_t::STRING:
        return "string";
    default:                   // LCOV_EXCL_LINE
        detail::unreachable(); // LCOV_EXCL_LINE
    }
}

inline node_t convert_from_node_type(node_type t) {
    switch (t) {
    case node_type::SEQUENCE:
        return node_t::SEQUENCE;
    case node_type::MAPPING:
        return node_t::MAPPING;
    case node_type::NULL_OBJECT:
        return node_t::NULL_OBJECT;
    case node_type::BOOLEAN:
        return node_t::BOOLEAN;
    case node_type::INTEGER:
        return node_t::INTEGER;
    case node_type::FLOAT:
        return node_t::FLOAT_NUMBER;
    case node_type::STRING:
        return node_t::STRING;
    default:                   // LCOV_EXCL_LINE
        detail::unreachable(); // LCOV_EXCL_LINE
    }
}

inline node_type convert_to_node_type(node_t t) {
    switch (t) {
    case node_t::SEQUENCE:
        return node_type::SEQUENCE;
    case node_t::MAPPING:
        return node_type::MAPPING;
    case node_t::NULL_OBJECT:
        return node_type::NULL_OBJECT;
    case node_t::BOOLEAN:
        return node_type::BOOLEAN;
    case node_t::INTEGER:
        return node_type::INTEGER;
    case node_t::FLOAT_NUMBER:
        return node_type::FLOAT;
    case node_t::STRING:
        return node_type::STRING;
    default:                   // LCOV_EXCL_LINE
        detail::unreachable(); // LCOV_EXCL_LINE
    }
}

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_TYPES_NODE_T_HPP */


FK_YAML_NAMESPACE_BEGIN

/// @brief A base exception class used in fkYAML library.
/// @sa https://fktn-k.github.io/fkYAML/api/exception/
class exception : public std::exception {
public:
    /// @brief Construct a new exception object without any error messages.
    /// @sa https://fktn-k.github.io/fkYAML/api/exception/constructor/
    exception() = default;

    /// @brief Construct a new exception object with an error message.
    /// @param[in] msg An error message.
    /// @sa https://fktn-k.github.io/fkYAML/api/exception/constructor/
    explicit exception(const char* msg) noexcept {
        if (msg) {
            m_error_msg = msg;
        }
    }

public:
    /// @brief Returns an error message internally held. If nothing, a non-null, empty string will be returned.
    /// @return An error message internally held. The message might be empty.
    /// @sa https://fktn-k.github.io/fkYAML/api/exception/what/
    const char* what() const noexcept override {
        return m_error_msg.c_str();
    }

private:
    /// An error message holder.
    std::string m_error_msg;
};

/// @brief An exception class indicating an encoding error.
/// @sa https://fktn-k.github.io/fkYAML/api/exception/invalid_encoding/
class invalid_encoding : public exception {
public:
    /// @brief Construct a new invalid_encoding object for UTF-8 related errors.
    /// @param msg An error message.
    /// @param u8 The UTF-8 character bytes.
    explicit invalid_encoding(const char* msg, const std::initializer_list<uint8_t>& u8) noexcept
        : exception(generate_error_message(msg, u8).c_str()) {
    }

    /// @brief Construct a new invalid_encoding object for UTF-16 related errors.
    /// @param msg An error message.
    /// @param u16_h The first UTF-16 encoded element used for the UTF-8 encoding.
    /// @param u16_l The second UTF-16 encoded element used for the UTF-8 encoding.
    explicit invalid_encoding(const char* msg, std::array<char16_t, 2> u16) noexcept
        : exception(generate_error_message(msg, u16).c_str()) {
    }

    /// @brief Construct a new invalid_encoding object for UTF-32 related errors.
    /// @param msg An error message.
    /// @param u32 The UTF-32 encoded element used for the UTF-8 encoding.
    explicit invalid_encoding(const char* msg, char32_t u32) noexcept
        : exception(generate_error_message(msg, u32).c_str()) {
    }

private:
    static std::string generate_error_message(const char* msg, const std::initializer_list<uint8_t>& u8) noexcept {
        const auto* itr = u8.begin();
        const auto* end_itr = u8.end();
        std::string formatted = detail::format("invalid_encoding: %s in=[ 0x%02x", msg, *itr++);
        while (itr != end_itr) {
            formatted += detail::format(", 0x%02x", *itr++);
        }
        formatted += " ]";
        return formatted;
    }

    /// @brief Generate an error message from the given parameters for the UTF-16 encoding.
    /// @param msg An error message.
    /// @param h The first UTF-16 encoded element used for the UTF-8 encoding.
    /// @param l The second UTF-16 encoded element used for the UTF-8 encoding.
    /// @return A generated error message.
    static std::string generate_error_message(const char* msg, std::array<char16_t, 2> u16) noexcept {
        // uint16_t is large enough for UTF-16 encoded elements.
        return detail::format(
            "invalid_encoding: %s in=[ 0x%04x, 0x%04x ]",
            msg,
            static_cast<uint16_t>(u16[0]),
            static_cast<uint16_t>(u16[1]));
    }

    /// @brief Generate an error message from the given parameters for the UTF-32 encoding.
    /// @param msg An error message.
    /// @param u32 The UTF-32 encoded element used for the UTF-8 encoding.
    /// @return A generated error message.
    static std::string generate_error_message(const char* msg, char32_t u32) noexcept {
        // uint32_t is large enough for UTF-32 encoded elements.
        return detail::format("invalid_encoding: %s in=0x%08x", msg, static_cast<uint32_t>(u32));
    }
};

/// @brief An exception class indicating an error in parsing.
/// @sa https://fktn-k.github.io/fkYAML/api/exception/parse_error/
class parse_error : public exception {
public:
    /// @brief Constructs a new parse_error object with an error message and counts of lines and columns at the error.
    /// @param[in] msg An error message.
    /// @param[in] lines Count of lines.
    /// @param[in] cols_in_line Count of columns.
    explicit parse_error(const char* msg, uint32_t lines, uint32_t cols_in_line) noexcept
        : exception(generate_error_message(msg, lines, cols_in_line).c_str()) {
    }

private:
    static std::string generate_error_message(const char* msg, uint32_t lines, uint32_t cols_in_line) noexcept {
        return detail::format("parse_error: %s (at line %u, column %u)", msg, lines, cols_in_line);
    }
};

/// @brief An exception class indicating an invalid type conversion.
/// @sa https://fktn-k.github.io/fkYAML/api/exception/type_error/
class type_error : public exception {
public:
    /// @brief Construct a new type_error object with an error message and a node type.
    /// @param[in] msg An error message.
    /// @param[in] type The type of a source node value.
    explicit type_error(const char* msg, node_type type) noexcept
        : exception(generate_error_message(msg, type).c_str()) {
    }

    /// @brief Construct a new type_error object with an error message and a node type.
    /// @deprecated Use type_error(const char*, node_type) constructor. (since 0.3.12).
    /// @param[in] msg An error message.
    /// @param[in] type The type of a source node value.
    FK_YAML_DEPRECATED("Since 0.3.12; Use explicit type_error(const char*, node_type)")
    explicit type_error(const char* msg, detail::node_t type) noexcept
        : type_error(msg, detail::convert_to_node_type(type)) {
    }

private:
    /// @brief Generate an error message from given parameters.
    /// @param msg An error message.
    /// @param type The type of a source node value.
    /// @return A generated error message.
    static std::string generate_error_message(const char* msg, node_type type) noexcept {
        return detail::format("type_error: %s type=%s", msg, to_string(type));
    }
};

/// @brief An exception class indicating an out-of-range error.
/// @sa https://fktn-k.github.io/fkYAML/api/exception/out_of_range/
class out_of_range : public exception {
public:
    /// @brief Construct a new out_of_range object with an invalid index value.
    /// @param[in] index An invalid index value.
    explicit out_of_range(int index) noexcept
        : exception(generate_error_message(index).c_str()) {
    }

    /// @brief Construct a new out_of_range object with invalid key contents.
    /// @param[in] key Invalid key contents
    explicit out_of_range(const char* key) noexcept
        : exception(generate_error_message(key).c_str()) {
    }

private:
    static std::string generate_error_message(int index) noexcept {
        return detail::format("out_of_range: index %d is out of range", index);
    }

    static std::string generate_error_message(const char* key) noexcept {
        return detail::format("out_of_range: key \'%s\' is not found.", key);
    }
};

/// @brief An exception class indicating an invalid tag.
/// @sa https://fktn-k.github.io/fkYAML/api/exception/invalid_tag/
class invalid_tag : public exception {
public:
    /// @brief Constructs a new invalid_tag object with an error message and invalid tag contents.
    /// @param[in] msg An error message.
    /// @param[in] tag Invalid tag contents.
    explicit invalid_tag(const char* msg, const char* tag)
        : exception(generate_error_message(msg, tag).c_str()) {
    }

private:
    static std::string generate_error_message(const char* msg, const char* tag) noexcept {
        return detail::format("invalid_tag: %s tag=%s", msg, tag);
    }
};

FK_YAML_NAMESPACE_END

#endif /* FK_YAML_EXCEPTION_HPP */


FK_YAML_DETAIL_NAMESPACE_BEGIN

/////////////////////////
//   UTF-8 Encoding   ///
/////////////////////////

/// @brief A class which handles UTF-8 encodings.
namespace utf8 {

/// @brief Query the number of UTF-8 character bytes with the first byte.
/// @param first_byte The first byte of a UTF-8 character.
/// @return The number of UTF-8 character bytes.
inline uint32_t get_num_bytes(uint8_t first_byte) {
    // The first byte starts with 0b0XXX'XXXX -> 1-byte character
    if FK_YAML_LIKELY (first_byte < 0x80) {
        return 1;
    }
    // The first byte starts with 0b110X'XXXX -> 2-byte character
    if ((first_byte & 0xE0) == 0xC0) {
        return 2;
    }
    // The first byte starts with 0b1110'XXXX -> 3-byte character
    if ((first_byte & 0xF0) == 0xE0) {
        return 3;
    }
    // The first byte starts with 0b1111'0XXX -> 4-byte character
    if ((first_byte & 0xF8) == 0xF0) {
        return 4;
    }

    // The first byte starts with 0b10XX'XXXX or 0b1111'1XXX -> invalid
    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first_byte});
}

/// @brief Checks if `byte` is a valid 1-byte UTF-8 character.
/// @param[in] byte The byte value.
/// @return true if `byte` is a valid 1-byte UTF-8 character, false otherwise.
inline bool validate(uint8_t byte) noexcept {
    // U+0000..U+007F
    return byte <= 0x7Fu;
}

/// @brief Checks if the given bytes are a valid 2-byte UTF-8 character.
/// @param[in] byte0 The first byte value.
/// @param[in] byte1 The second byte value.
/// @return true if the given bytes a valid 3-byte UTF-8 character, false otherwise.
inline bool validate(uint8_t byte0, uint8_t byte1) noexcept {
    // U+0080..U+07FF
    //   1st Byte: 0xC2..0xDF
    //   2nd Byte: 0x80..0xBF
    if FK_YAML_LIKELY (0xC2u <= byte0 && byte0 <= 0xDFu) {
        if FK_YAML_LIKELY (0x80u <= byte1 && byte1 <= 0xBFu) {
            return true;
        }
    }

    // The rest of byte combinations are invalid.
    return false;
}

/// @brief Checks if the given bytes are a valid 3-byte UTF-8 character.
/// @param[in] byte0 The first byte value.
/// @param[in] byte1 The second byte value.
/// @param[in] byte2 The third byte value.
/// @return true if the given bytes a valid 2-byte UTF-8 character, false otherwise.
inline bool validate(uint8_t byte0, uint8_t byte1, uint8_t byte2) noexcept {
    // U+1000..U+CFFF:
    //   1st Byte: 0xE0..0xEC
    //   2nd Byte: 0x80..0xBF
    //   3rd Byte: 0x80..0xBF
    if (0xE0u <= byte0 && byte0 <= 0xECu) {
        if FK_YAML_LIKELY (0x80u <= byte1 && byte1 <= 0xBFu) {
            if FK_YAML_LIKELY (0x80u <= byte2 && byte2 <= 0xBFu) {
                return true;
            }
        }
        return false;
    }

    // U+D000..U+D7FF:
    //   1st Byte: 0xED
    //   2nd Byte: 0x80..0x9F
    //   3rd Byte: 0x80..0xBF
    if (byte0 == 0xEDu) {
        if FK_YAML_LIKELY (0x80u <= byte1 && byte1 <= 0x9Fu) {
            if FK_YAML_LIKELY (0x80u <= byte2 && byte2 <= 0xBFu) {
                return true;
            }
        }
        return false;
    }

    // U+E000..U+FFFF:
    //   1st Byte: 0xEE..0xEF
    //   2nd Byte: 0x80..0xBF
    //   3rd Byte: 0x80..0xBF
    if FK_YAML_LIKELY (byte0 == 0xEEu || byte0 == 0xEFu) {
        if FK_YAML_LIKELY (0x80u <= byte1 && byte1 <= 0xBFu) {
            if FK_YAML_LIKELY (0x80u <= byte2 && byte2 <= 0xBFu) {
                return true;
            }
        }
    }

    // The rest of byte combinations are invalid.
    return false;
}

/// @brief Checks if the given bytes are a valid 4-byte UTF-8 character.
/// @param[in] byte0 The first byte value.
/// @param[in] byte1 The second byte value.
/// @param[in] byte2 The third byte value.
/// @param[in] byte3 The fourth byte value.
/// @return true if the given bytes a valid 4-byte UTF-8 character, false otherwise.
inline bool validate(uint8_t byte0, uint8_t byte1, uint8_t byte2, uint8_t byte3) noexcept {
    // U+10000..U+3FFFF:
    //   1st Byte: 0xF0
    //   2nd Byte: 0x90..0xBF
    //   3rd Byte: 0x80..0xBF
    //   4th Byte: 0x80..0xBF
    if (byte0 == 0xF0u) {
        if FK_YAML_LIKELY (0x90u <= byte1 && byte1 <= 0xBFu) {
            if FK_YAML_LIKELY (0x80u <= byte2 && byte2 <= 0xBFu) {
                if FK_YAML_LIKELY (0x80u <= byte3 && byte3 <= 0xBFu) {
                    return true;
                }
            }
        }
        return false;
    }

    // U+40000..U+FFFFF:
    //   1st Byte: 0xF1..0xF3
    //   2nd Byte: 0x80..0xBF
    //   3rd Byte: 0x80..0xBF
    //   4th Byte: 0x80..0xBF
    if (0xF1u <= byte0 && byte0 <= 0xF3u) {
        if FK_YAML_LIKELY (0x80u <= byte1 && byte1 <= 0xBFu) {
            if FK_YAML_LIKELY (0x80u <= byte2 && byte2 <= 0xBFu) {
                if FK_YAML_LIKELY (0x80u <= byte3 && byte3 <= 0xBFu) {
                    return true;
                }
            }
        }
        return false;
    }

    // U+100000..U+10FFFF:
    //   1st Byte: 0xF4
    //   2nd Byte: 0x80..0x8F
    //   3rd Byte: 0x80..0xBF
    //   4th Byte: 0x80..0xBF
    if FK_YAML_LIKELY (byte0 == 0xF4u) {
        if FK_YAML_LIKELY (0x80u <= byte1 && byte1 <= 0x8Fu) {
            if FK_YAML_LIKELY (0x80u <= byte2 && byte2 <= 0xBFu) {
                if FK_YAML_LIKELY (0x80u <= byte3 && byte3 <= 0xBFu) {
                    return true;
                }
            }
        }
    }

    // The rest of byte combinations are invalid.
    return false;
}

/// @brief Converts UTF-16 encoded characters to UTF-8 encoded bytes.
/// @param[in] utf16 UTF-16 encoded character(s).
/// @param[out] utf8 UTF-8 encoded bytes.
/// @param[out] consumed_size The number of UTF-16 encoded characters used for the conversion.
/// @param[out] encoded_size The size of UTF-encoded bytes.
inline void from_utf16(
    std::array<char16_t, 2> utf16, std::array<uint8_t, 4>& utf8, uint32_t& consumed_size, uint32_t& encoded_size) {
    const auto first = utf16[0];
    const auto second = utf16[1];
    if (first < 0x80u) {
        utf8[0] = static_cast<uint8_t>(first & 0x7Fu);
        consumed_size = 1;
        encoded_size = 1;
    }
    else if (first <= 0x7FFu) {
        const auto utf8_chunk = static_cast<uint16_t>(0xC080u | ((first & 0x07C0u) << 2) | (first & 0x3Fu));
        utf8[0] = static_cast<uint8_t>(utf8_chunk >> 8);
        utf8[1] = static_cast<uint8_t>(utf8_chunk);
        consumed_size = 1;
        encoded_size = 2;
    }
    else if (first < 0xD800u || 0xE000u <= first) {
        const auto utf8_chunk =
            static_cast<uint32_t>(0xE08080u | ((first & 0xF000u) << 4) | ((first & 0x0FC0u) << 2) | (first & 0x3Fu));
        utf8[0] = static_cast<uint8_t>(utf8_chunk >> 16);
        utf8[1] = static_cast<uint8_t>(utf8_chunk >> 8);
        utf8[2] = static_cast<uint8_t>(utf8_chunk);
        consumed_size = 1;
        encoded_size = 3;
    }
    else if (first <= 0xDBFFu && 0xDC00u <= second && second <= 0xDFFFu) {
        // surrogate pair
        const uint32_t code_point = 0x10000u + ((first & 0x03FFu) << 10) + (second & 0x03FFu);
        const auto utf8_chunk = static_cast<uint32_t>(
            0xF0808080u | ((code_point & 0x1C0000u) << 6) | ((code_point & 0x03F000u) << 4) |
            ((code_point & 0x0FC0u) << 2) | (code_point & 0x3Fu));
        utf8[0] = static_cast<uint8_t>(utf8_chunk >> 24);
        utf8[1] = static_cast<uint8_t>(utf8_chunk >> 16);
        utf8[2] = static_cast<uint8_t>(utf8_chunk >> 8);
        utf8[3] = static_cast<uint8_t>(utf8_chunk);
        consumed_size = 2;
        encoded_size = 4;
    }
    else {
        throw invalid_encoding("Invalid UTF-16 encoding detected.", utf16);
    }
}

/// @brief Converts a UTF-32 encoded character to UTF-8 encoded bytes.
/// @param[in] utf32 A UTF-32 encoded character.
/// @param[out] utf8 UTF-8 encoded bytes.
/// @param[in] encoded_size The size of UTF-encoded bytes.
inline void from_utf32(const char32_t utf32, std::array<uint8_t, 4>& utf8, uint32_t& encoded_size) {
    if (utf32 < 0x80u) {
        utf8[0] = static_cast<uint8_t>(utf32 & 0x007F);
        encoded_size = 1;
    }
    else if (utf32 <= 0x7FFu) {
        const auto utf8_chunk = static_cast<uint16_t>(0xC080u | ((utf32 & 0x07C0u) << 2) | (utf32 & 0x3Fu));
        utf8[0] = static_cast<uint8_t>(utf8_chunk >> 8);
        utf8[1] = static_cast<uint8_t>(utf8_chunk);
        encoded_size = 2;
    }
    else if (utf32 <= 0xFFFFu) {
        const auto utf8_chunk =
            static_cast<uint32_t>(0xE08080u | ((utf32 & 0xF000u) << 4) | ((utf32 & 0x0FC0u) << 2) | (utf32 & 0x3F));
        utf8[0] = static_cast<uint8_t>(utf8_chunk >> 16);
        utf8[1] = static_cast<uint8_t>(utf8_chunk >> 8);
        utf8[2] = static_cast<uint8_t>(utf8_chunk);
        encoded_size = 3;
    }
    else if (utf32 <= 0x10FFFFu) {
        const auto utf8_chunk = static_cast<uint32_t>(
            0xF0808080u | ((utf32 & 0x1C0000u) << 6) | ((utf32 & 0x03F000u) << 4) | ((utf32 & 0x0FC0u) << 2) |
            (utf32 & 0x3Fu));
        utf8[0] = static_cast<uint8_t>(utf8_chunk >> 24);
        utf8[1] = static_cast<uint8_t>(utf8_chunk >> 16);
        utf8[2] = static_cast<uint8_t>(utf8_chunk >> 8);
        utf8[3] = static_cast<uint8_t>(utf8_chunk);
        encoded_size = 4;
    }
    else {
        throw invalid_encoding("Invalid UTF-32 encoding detected.", utf32);
    }
}

} // namespace utf8

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_ENCODINGS_UTF_ENCODINGS_HPP */

// #include <fkYAML/detail/input/block_scalar_header.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_INPUT_BLOCK_SCALAR_HEADER_HPP
#define FK_YAML_DETAIL_INPUT_BLOCK_SCALAR_HEADER_HPP

#include <cstdint>

// #include <fkYAML/detail/macros/define_macros.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Definition of chomping indicator types.
enum class chomping_indicator_t : std::uint8_t {
    STRIP, //!< excludes final line breaks and trailing empty lines indicated by `-`.
    CLIP,  //!< preserves final line breaks but excludes trailing empty lines. no indicator means this type.
    KEEP,  //!< preserves final line breaks and trailing empty lines indicated by `+`.
};

/// @brief Block scalar header information.
struct block_scalar_header {
    /// Chomping indicator type.
    chomping_indicator_t chomp {chomping_indicator_t::CLIP};
    /// Content indentation level of a block scalar.
    uint32_t indent {0};
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_INPUT_BLOCK_SCALAR_HEADER_HPP */

// #include <fkYAML/detail/input/position_tracker.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_INPUT_POSITION_TRACKER_HPP
#define FK_YAML_DETAIL_INPUT_POSITION_TRACKER_HPP

#include <algorithm>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/str_view.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_STR_VIEW_HPP
#define FK_YAML_DETAIL_STR_VIEW_HPP

#include <limits>
#include <string>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/meta/type_traits.hpp>

// #include <fkYAML/exception.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Non owning view into constant character sequence.
/// @note
/// This class is a minimal implementation of std::basic_string_view which has been available since C++17
/// but pretty useful and efficient for referencing/investigating character sequences.
/// @warning
/// This class intentionally omits a lot of value checks to improve efficiency. Necessary checks should be
/// made before calling this class' APIs for safety.
/// @tparam CharT Character type
/// @tparam Traits Character traits type which defaults to std::char_traits<CharT>.
template <typename CharT, typename Traits = std::char_traits<CharT>>
class basic_str_view {
    static_assert(!std::is_array<CharT>::value, "CharT must not be an array type.");
    static_assert(
        std::is_trivial<CharT>::value && std::is_standard_layout<CharT>::value,
        "CharT must be a trivial, standard layout type.");
    static_assert(
        std::is_same<CharT, typename Traits::char_type>::value, "CharT & Traits::char_type must be the same type.");

public:
    /// Character traits type.
    using traits_type = Traits;
    /// Character type.
    using value_type = CharT;
    /// Pointer type to a character.
    using pointer = value_type*;
    /// Constant pointer type to a character.
    using const_pointer = const value_type*;
    /// Reference type to a character.
    using reference = value_type&;
    /// Constant reference type to a character.
    using const_reference = const value_type&;
    /// Constant iterator type to a character.
    using const_iterator = const value_type*;
    /// Iterator type to a character.
    /// (Always constant since this class isn't meant to provide any mutating features.)
    using iterator = const_iterator;
    /// Constant reverse iterator type to a character.
    using const_reverse_iterator = std::reverse_iterator<const_iterator>;
    /// Reverse iterator type to a character.
    /// (Always constant since this class isn't meant to provide any mutating features.)
    using reverse_iterator = const_reverse_iterator;
    /// Size type for character sequence sizes.
    using size_type = std::size_t;
    /// Difference type for distances between characters.
    using difference_type = std::ptrdiff_t;

    /// Invalid position value.
    static constexpr size_type npos = static_cast<size_type>(-1);

    /// Constructs a basic_str_view object.
    constexpr basic_str_view() noexcept = default;

    /// Destroys a basic_str_view object.
    ~basic_str_view() noexcept = default;

    /// @brief Copy constructs a basic_str_view object.
    /// @param _ A basic_str_view object to copy from.
    constexpr basic_str_view(const basic_str_view&) noexcept = default;

    /// @brief Move constructs a basic_str_view object.
    /// @param _ A basic_str_view object to move from.
    constexpr basic_str_view(basic_str_view&&) noexcept = default;

    /// @brief Constructs a basic_str_view object from a pointer to a character sequence.
    /// @note std::char_traits::length() is constexpr from C++17.
    /// @param p_str A pointer to a character sequence. (Must be null-terminated, or an undefined behavior.)
    template <
        typename CharPtrT,
        enable_if_t<
            conjunction<
                negation<std::is_array<CharPtrT>>, std::is_pointer<CharPtrT>,
                disjunction<std::is_same<CharPtrT, value_type*>, std::is_same<CharPtrT, const value_type*>>>::value,
            int> = 0>
    FK_YAML_CXX17_CONSTEXPR basic_str_view(CharPtrT p_str) noexcept
        : m_len(traits_type::length(p_str)),
          mp_str(p_str) {
    }

    /// @brief Constructs a basic_str_view object from a C-style char array.
    /// @note
    /// This constructor assumes the last element is the null character ('\0'). If that's not desirable, consider using
    /// one of the other overloads.
    /// @tparam N The size of a C-style char array.
    /// @param str A C-style char array. (Must be null-terminated)
    template <std::size_t N>
    constexpr basic_str_view(const value_type (&str)[N]) noexcept
        : m_len(N - 1),
          mp_str(&str[0]) {
    }

    /// @brief Construction from a null pointer is forbidden.
    basic_str_view(std::nullptr_t) = delete;

    /// @brief Constructs a basic_str_view object from a pointer to a character sequence and its size.
    /// @param p_str A pointer to a character sequence. (May or may not be null-terminated.)
    /// @param len The length of a character sequence.
    constexpr basic_str_view(const value_type* p_str, size_type len) noexcept
        : m_len(len),
          mp_str(p_str) {
    }

    /// @brief Constructs a basic_str_view object from compatible begin/end iterators
    /// @tparam ItrType Iterator type to a character.
    /// @param first The iterator to the first element of a character sequence.
    /// @param last The iterator to the past-the-end of a character sequence.
    template <
        typename ItrType,
        enable_if_t<
            conjunction<
                is_iterator_of<ItrType, CharT>,
                std::is_base_of<
                    std::random_access_iterator_tag, typename std::iterator_traits<ItrType>::iterator_category>>::value,
            int> = 0>
    basic_str_view(ItrType first, ItrType last) noexcept
        : m_len(last - first),
          mp_str(&*first) {
    }

    /// @brief Constructs a basic_str_view object from a compatible std::basic_string object.
    /// @param str A compatible character sequence container.
    basic_str_view(const std::basic_string<CharT>& str) noexcept
        : m_len(str.length()),
          mp_str(str.data()) {
    }

    /// @brief Copy assignment operator for this basic_str_view class.
    /// @param _ A basic_str_view object to copy from.
    /// @return Reference to this basic_str_view object.
    basic_str_view& operator=(const basic_str_view&) noexcept = default;

    /// @brief Move assignment operator for this basic_str_view class.
    /// @param _ A basic_str_view object to move from.
    /// @return Reference to this basic_str_view object.
    basic_str_view& operator=(basic_str_view&&) noexcept = default;

    /// @brief Get the iterator to the first element. (Always constant)
    /// @return The iterator to the first element.
    const_iterator begin() const noexcept {
        return mp_str;
    }

    /// @brief Get the iterator to the past-the-end element. (Always constant)
    /// @return The iterator to the past-the-end element.
    const_iterator end() const noexcept {
        return mp_str + m_len;
    }

    /// @brief Get the iterator to the first element. (Always constant)
    /// @return The iterator to the first element.
    const_iterator cbegin() const noexcept {
        return mp_str;
    }

    /// @brief Get the iterator to the past-the-end element. (Always constant)
    /// @return The iterator to the past-the-end element.
    const_iterator cend() const noexcept {
        return mp_str + m_len;
    }

    /// @brief Get the iterator to the first element in the reverse order. (Always constant)
    /// @return The iterator to the first element in the reverse order.
    const_reverse_iterator rbegin() const noexcept {
        return const_reverse_iterator(end());
    }

    /// @brief Get the iterator to the past-the-end element in the reverse order. (Always constant)
    /// @return The iterator to the past-the-end element in the reverse order.
    const_reverse_iterator rend() const noexcept {
        return const_reverse_iterator(begin());
    }

    /// @brief Get the iterator to the first element in the reverse order. (Always constant)
    /// @return The iterator to the first element in the reverse order.
    const_reverse_iterator crbegin() const noexcept {
        return const_reverse_iterator(end());
    }

    /// @brief Get the iterator to the past-the-end element in the reverse order. (Always constant)
    /// @return The iterator to the past-the-end element in the reverse order.
    const_reverse_iterator crend() const noexcept {
        return const_reverse_iterator(begin());
    }

    /// @brief Get the size of the referenced character sequence.
    /// @return The size of the referenced character sequence.
    size_type size() const noexcept {
        return m_len;
    }

    /// @brief Get the size of the referenced character sequence.
    /// @return The size of the referenced character sequence.
    size_type length() const noexcept {
        return m_len;
    }

    /// @brief Get the maximum number of the character sequence size.
    /// @return The maximum number of the character sequence size.
    constexpr size_type max_size() const noexcept {
        return static_cast<size_type>(std::numeric_limits<difference_type>::max());
    }

    /// @brief Checks if the referenced character sequence is empty.
    /// @return true if empty, false otherwise.
    bool empty() const noexcept {
        return m_len == 0;
    }

    /// @brief Get the element at the given position.
    /// @param pos The position of the target element.
    /// @return The element at the given position.
    const_reference operator[](size_type pos) const noexcept {
        return *(mp_str + pos);
    }

    /// @brief Get the element at the given position with bounds checks.
    /// @warning Throws an fkyaml::out_of_range exception if the position exceeds the character sequence size.
    /// @param pos The position of the target element.
    /// @return The element at the given position.
    const_reference at(size_type pos) const {
        if FK_YAML_UNLIKELY (pos >= m_len) {
            throw fkyaml::out_of_range(static_cast<int>(pos));
        }
        return *(mp_str + pos);
    }

    /// @brief Get the first element.
    /// @return The first element.
    const_reference front() const noexcept {
        return *mp_str;
    }

    /// @brief Get the last element.
    /// @return The last element.
    const_reference back() const {
        return *(mp_str + m_len - 1);
    }

    /// @brief Get the pointer to the raw data of referenced character sequence.
    /// @return The pointer to the raw data of referenced character sequence.
    const_pointer data() const noexcept {
        return mp_str;
    }

    /// @brief Moves the beginning position by `n` elements.
    /// @param n The number of elements by which to move the beginning position.
    void remove_prefix(size_type n) noexcept {
        mp_str += n;
        m_len -= n;
    }

    /// @brief Shrinks the referenced character sequence from the last by `n` elements.
    /// @param n The number of elements by which to shrink the sequence from the last.
    void remove_suffix(size_type n) noexcept {
        m_len -= n;
    }

    /// @brief Swaps data with the given basic_str_view object.
    /// @param other A basic_str_view object to swap data with.
    void swap(basic_str_view& other) noexcept {
        auto tmp = *this;
        *this = other;
        other = tmp;
    }

    /// @brief Copys the referenced character sequence values from `pos` by `n` size.
    /// @warning Throws an fkyaml::out_of_range exception if the given `pos` is bigger than the length.
    /// @param p_str The pointer to a character sequence buffer for output.
    /// @param n The number of elements to write into `p_str`.
    /// @param pos The offset of the beginning position to copy values.
    /// @return The number of elements to be written into `p_str`.
    size_type copy(CharT* p_str, size_type n, size_type pos = 0) const {
        if FK_YAML_UNLIKELY (pos > m_len) {
            throw fkyaml::out_of_range(static_cast<int>(pos));
        }
        const size_type rlen = std::min(n, m_len - pos);
        traits_type::copy(p_str, mp_str + pos, rlen);
        return rlen;
    }

    /// @brief Constructs a sub basic_str_view object from `pos` by `n` size.
    /// @warning Throws an fkyaml::out_of_range exception if the given `pos` is bigger than the length.
    /// @param pos The offset of the beginning position.
    /// @param n The number of elements to the end of a new sub basic_str_view object.
    /// @return A newly created sub basic_str_view object.
    basic_str_view substr(size_type pos = 0, size_type n = npos) const {
        if FK_YAML_UNLIKELY (pos > m_len) {
            throw fkyaml::out_of_range(static_cast<int>(pos));
        }
        const size_type rlen = std::min(n, m_len - pos);
        return basic_str_view(mp_str + pos, rlen);
    }

    /// @brief Compares the referenced character sequence values with the given basic_str_view object.
    /// @param sv The basic_str_view object to compare with.
    /// @return The lexicographical comparison result. The values are same as std::strncmp().
    int compare(basic_str_view sv) const noexcept {
        const size_type rlen = std::min(m_len, sv.m_len);
        int ret = traits_type::compare(mp_str, sv.mp_str, rlen);

        if (ret == 0) {
            using int_limits = std::numeric_limits<int>;
            const difference_type diff =
                m_len > sv.m_len ? m_len - sv.m_len
                                 : static_cast<difference_type>(-1) * static_cast<difference_type>(sv.m_len - m_len);

            if (diff > int_limits::max()) {
                ret = int_limits::max();
            }
            else if (diff < int_limits::min()) {
                ret = int_limits::min();
            }
            else {
                ret = static_cast<int>(diff);
            }
        }

        return ret;
    }

    /// @brief Compares the referenced character sequence values from `pos1` by `n1` characters with `sv`.
    /// @param pos1 The offset of the beginning element.
    /// @param n1 The length of character sequence used for comparison.
    /// @param sv A basic_str_view object to compare with.
    /// @return The lexicographical comparison result. The values are same as std::strncmp().
    int compare(size_type pos1, size_type n1, basic_str_view sv) const {
        return substr(pos1, n1).compare(sv);
    }

    /// @brief Compares the referenced character sequence value from `pos1` by `n1` characters with `sv` from `pos2` by
    /// `n2` characters.
    /// @param pos1 The offset of the beginning element in this character sequence.
    /// @param n1 The length of this character sequence used for comparison.
    /// @param sv A basic_str_view object to compare with.
    /// @param pos2 The offset of the beginning element in `sv`.
    /// @param n2 The length of `sv` used for comparison.
    /// @return The lexicographical comparison result. The values are same as std::strncmp().
    int compare(size_type pos1, size_type n1, basic_str_view sv, size_type pos2, size_type n2) const {
        return substr(pos1, n1).compare(sv.substr(pos2, n2));
    }

    /// @brief Compares the referenced character sequence with `s` character sequence.
    /// @param s The pointer to a character sequence to compare with.
    /// @return The lexicographical comparison result. The values are same as std::strncmp().
    int compare(const CharT* s) const {
        return compare(basic_str_view(s));
    }

    /// @brief Compares the referenced character sequence from `pos1` by `n1` characters with `s` character sequence.
    /// @param pos1 The offset of the beginning element in this character sequence.
    /// @param n1 The length of this character sequence used fo comparison.
    /// @param s The pointer to a character sequence to compare with.
    /// @return The lexicographical comparison result. The values are same as std::strncmp().
    int compare(size_type pos1, size_type n1, const CharT* s) const {
        return substr(pos1, n1).compare(basic_str_view(s));
    }

    /// @brief Compares the referenced character sequence from `pos1` by `n1` characters with `s` character sequence by
    /// `n2` characters.
    /// @param pos1 The offset of the beginning element in this character sequence.
    /// @param n1 The length of this character sequence used fo comparison.
    /// @param s The pointer to a character sequence to compare with.
    /// @param n2 The length of `s` used fo comparison.
    /// @return
    int compare(size_type pos1, size_type n1, const CharT* s, size_type n2) const {
        return substr(pos1, n1).compare(basic_str_view(s, n2));
    }

    /// @brief Checks if this character sequence starts with `sv` characters.
    /// @param sv The character sequence to compare with.
    /// @return true if the character sequence starts with `sv` characters, false otherwise.
    bool starts_with(basic_str_view sv) const {
        return substr(0, sv.size()) == sv;
    }

    /// @brief Checks if this character sequence starts with `c` character.
    /// @param c The character to compare with.
    /// @return true if the character sequence starts with `c` character, false otherwise.
    bool starts_with(CharT c) const noexcept {
        return !empty() && traits_type::eq(front(), c);
    }

    /// @brief Checks if this character sequence starts with `s` characters.
    /// @param s The character sequence to compare with.
    /// @return true if the character sequence starts with `s` characters, false otherwise.
    bool starts_with(const CharT* s) const {
        return starts_with(basic_str_view(s));
    }

    /// @brief Checks if this character sequence ends with `sv` characters.
    /// @param sv The character sequence to compare with.
    /// @return true if the character sequence ends with `sv` characters, false otherwise.
    bool ends_with(basic_str_view sv) const noexcept {
        const size_type size = m_len;
        const size_type sv_size = sv.size();
        return size >= sv_size && traits_type::compare(end() - sv_size, sv.data(), sv_size) == 0;
    }

    /// @brief Checks if this character sequence ends with `c` character.
    /// @param c The character to compare with.
    /// @return true if the character sequence ends with `c` character, false otherwise.
    bool ends_with(CharT c) const noexcept {
        return !empty() && traits_type::eq(back(), c);
    }

    /// @brief Checks if this character sequence ends with `s` characters.
    /// @param s The character sequence to compare with.
    /// @return true if the character sequence ends with `s` characters, false otherwise.
    bool ends_with(const CharT* s) const noexcept {
        return ends_with(basic_str_view(s));
    }

    /// @brief Checks if this character sequence contains `sv` characters.
    /// @param sv The character sequence to compare with.
    /// @return true if the character sequence contains `sv` characters, false otherwise.
    bool contains(basic_str_view sv) const noexcept {
        return find(sv) != npos;
    }

    /// @brief Checks if this character sequence contains `c` character.
    /// @param c The character to compare with.
    /// @return true if the character sequence contains `c` character, false otherwise.
    bool contains(CharT c) const noexcept {
        return find(c) != npos;
    }

    /// @brief Checks if this character sequence contains `s` characters.
    /// @param s The character sequence to compare with.
    /// @return true if the character sequence contains `s` characters, false otherwise.
    bool contains(const CharT* s) const noexcept {
        return find(s) != npos;
    }

    /// @brief Finds the beginning position of `sv` characters in this referenced character sequence.
    /// @param sv The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `sv` characters, `npos` otherwise.
    size_type find(basic_str_view sv, size_type pos = 0) const noexcept {
        return find(sv.mp_str, pos, sv.m_len);
    }

    /// @brief Finds the beginning position of `c` character in this referenced character sequence.
    /// @param sv The character to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `c` character, `npos` otherwise.
    size_type find(CharT c, size_type pos = 0) const noexcept {
        size_type ret = npos;

        if FK_YAML_LIKELY (pos < m_len) {
            const size_type n = m_len - pos;
            const CharT* p_found = traits_type::find(mp_str + pos, n, c);
            if (p_found) {
                ret = p_found - mp_str;
            }
        }

        return ret;
    }

    /// @brief Finds the beginning position of `s` character sequence by `n` characters in this referenced character
    /// sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @param n The length of `s` character sequence used for comparison.
    /// @return The beginning position of `s` characters, `npos` otherwise.
    size_type find(const CharT* s, size_type pos, size_type n) const noexcept {
        if FK_YAML_UNLIKELY (n == 0) {
            return pos <= m_len ? pos : npos;
        }

        if FK_YAML_UNLIKELY (pos >= m_len) {
            return npos;
        }

        CharT s0 = s[0];
        const CharT* p_first = mp_str + pos;
        const CharT* p_last = mp_str + m_len;
        size_type len = m_len - pos;

        while (len >= n) {
            // find the first occurrence of s0
            p_first = traits_type::find(p_first, len - n + 1, s0);
            if (!p_first) {
                return npos;
            }

            // compare the full strings from the first occurrence of s0
            if (traits_type::compare(p_first, s, n) == 0) {
                return p_first - mp_str;
            }

            len = p_last - (++p_first);
        }

        return npos;
    }

    /// @brief Finds the beginning position of `s` character sequence in this referenced character sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `s` characters, `npos` otherwise.
    size_type find(const CharT* s, size_type pos = 0) const noexcept {
        return find(basic_str_view(s), pos);
    }

    /// @brief Retrospectively finds the beginning position of `sv` characters in this referenced character sequence.
    /// @param sv The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `sv` characters, `npos` otherwise.
    size_type rfind(basic_str_view sv, size_type pos = npos) const noexcept {
        return rfind(sv.mp_str, pos, sv.m_len);
    }

    /// @brief Retrospectively finds the beginning position of `c` character in this referenced character sequence.
    /// @param sv The character to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `c` character, `npos` otherwise.
    size_type rfind(CharT c, size_type pos = npos) const noexcept {
        if FK_YAML_UNLIKELY (m_len == 0) {
            return npos;
        }

        const size_type idx = std::min(m_len - 1, pos);

        for (size_type i = 0; i <= idx; i++) {
            if (traits_type::eq(mp_str[idx - i], c)) {
                return idx - i;
            }
        }

        return npos;
    }

    /// @brief Retrospectively finds the beginning position of `s` character sequence by `n` characters in this
    /// referenced character sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @param n The length of `s` character sequence used for comparison.
    /// @return The beginning position of `s` characters, `npos` otherwise.
    size_type rfind(const CharT* s, size_type pos, size_type n) const noexcept {
        if FK_YAML_LIKELY (n <= m_len) {
            pos = std::min(m_len - n, pos) + 1;

            do {
                if (traits_type::compare(mp_str + --pos, s, n) == 0) {
                    return pos;
                }
            } while (pos > 0);
        }

        return npos;
    }

    /// @brief Retrospectively finds the beginning position of `s` character sequence in this referenced character
    /// sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `s` characters, `npos` otherwise.
    size_type rfind(const CharT* s, size_type pos = npos) const noexcept {
        return rfind(basic_str_view(s), pos);
    }

    /// @brief Finds the first occurrence of `sv` character sequence in this referenced character sequence.
    /// @param sv The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `sv` characters, `npos` otherwise.
    size_type find_first_of(basic_str_view sv, size_type pos = 0) const noexcept {
        return find_first_of(sv.mp_str, pos, sv.m_len);
    }

    /// @brief Finds the first occurrence of `c` character in this referenced character sequence.
    /// @param c The character to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `c` character, `npos` otherwise.
    size_type find_first_of(CharT c, size_type pos = 0) const noexcept {
        return find(c, pos);
    }

    /// @brief Finds the first occurrence of `s` character sequence by `n` characters in this referenced character
    /// sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @param n The length of `s` character sequence used for comparison.
    /// @return The beginning position of `s` characters, `npos` otherwise.
    size_type find_first_of(const CharT* s, size_type pos, size_type n) const noexcept {
        if FK_YAML_UNLIKELY (n == 0) {
            return npos;
        }

        for (size_type idx = pos; idx < m_len; ++idx) {
            const CharT* p_found = traits_type::find(s, n, mp_str[idx]);
            if (p_found) {
                return idx;
            }
        }

        return npos;
    }

    /// @brief Finds the first occurrence of `s` character sequence in this referenced character sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `s` characters, `npos` otherwise.
    size_type find_first_of(const CharT* s, size_type pos = 0) const noexcept {
        return find_first_of(basic_str_view(s), pos);
    }

    /// @brief Finds the last occurrence of `sv` character sequence in this referenced character sequence.
    /// @param sv The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `sv` characters, `npos` otherwise.
    size_type find_last_of(basic_str_view sv, size_type pos = npos) const noexcept {
        return find_last_of(sv.mp_str, pos, sv.m_len);
    }

    /// @brief Finds the last occurrence of `c` character in this referenced character sequence.
    /// @param c The character to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `c` character, `npos` otherwise.
    size_type find_last_of(CharT c, size_type pos = npos) const noexcept {
        return rfind(c, pos);
    }

    /// @brief Finds the last occurrence of `s` character sequence by `n` characters in this referenced character
    /// sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @param n The length of `s` character sequence used for comparison.
    /// @return The beginning position of `s` characters, `npos` otherwise.
    size_type find_last_of(const CharT* s, size_type pos, size_type n) const noexcept {
        if FK_YAML_LIKELY (n <= m_len) {
            pos = std::min(m_len - n - 1, pos);

            do {
                const CharT* p_found = traits_type::find(s, n, mp_str[pos]);
                if (p_found) {
                    return pos;
                }
            } while (pos-- != 0);
        }

        return npos;
    }

    /// @brief Finds the last occurrence of `s` character sequence in this referenced character sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of `s` characters, `npos` otherwise.
    size_type find_last_of(const CharT* s, size_type pos = npos) const noexcept {
        return find_last_of(basic_str_view(s), pos);
    }

    /// @brief Finds the first absence of `sv` character sequence in this referenced character sequence.
    /// @param sv The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of non `sv` characters, `npos` otherwise.
    size_type find_first_not_of(basic_str_view sv, size_type pos = 0) const noexcept {
        return find_first_not_of(sv.mp_str, pos, sv.m_len);
    }

    /// @brief Finds the first absence of `c` character in this referenced character sequence.
    /// @param c The character to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of non `c` character, `npos` otherwise.
    size_type find_first_not_of(CharT c, size_type pos = 0) const noexcept {
        for (; pos < m_len; ++pos) {
            if (!traits_type::eq(mp_str[pos], c)) {
                return pos;
            }
        }

        return npos;
    }

    /// @brief Finds the first absence of `s` character sequence by `n` characters in this referenced character
    /// sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @param n The length of `s` character sequence used for comparison.
    /// @return The beginning position of non `s` characters, `npos` otherwise.
    size_type find_first_not_of(const CharT* s, size_type pos, size_type n) const noexcept {
        for (; pos < m_len; ++pos) {
            const CharT* p_found = traits_type::find(s, n, mp_str[pos]);
            if (!p_found) {
                return pos;
            }
        }

        return npos;
    }

    /// @brief Finds the first absence of `s` character sequence in this referenced character sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of non `s` characters, `npos` otherwise.
    size_type find_first_not_of(const CharT* s, size_type pos = 0) const noexcept {
        return find_first_not_of(basic_str_view(s), pos);
    }

    /// @brief Finds the last absence of `sv` character sequence in this referenced character sequence.
    /// @param sv The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of non `sv` characters, `npos` otherwise.
    size_type find_last_not_of(basic_str_view sv, size_type pos = npos) const noexcept {
        return find_last_not_of(sv.mp_str, pos, sv.m_len);
    }

    /// @brief Finds the last absence of `c` character in this referenced character sequence.
    /// @param c The character to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of non `c` character, `npos` otherwise.
    size_type find_last_not_of(CharT c, size_type pos = npos) const noexcept {
        if FK_YAML_LIKELY (m_len > 0) {
            pos = std::min(m_len, pos);

            do {
                if (!traits_type::eq(mp_str[--pos], c)) {
                    return pos;
                }
            } while (pos > 0);
        }

        return npos;
    }

    /// @brief Finds the last absence of `s` character sequence by `n` characters in this referenced character
    /// sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @param n The length of `s` character sequence used for comparison.
    /// @return The beginning position of non `s` characters, `npos` otherwise.
    size_type find_last_not_of(const CharT* s, size_type pos, size_type n) const noexcept {
        if FK_YAML_UNLIKELY (n <= m_len) {
            pos = std::min(m_len - n, pos) + 1;

            do {
                const CharT* p_found = traits_type::find(s, n, mp_str[--pos]);
                if (!p_found) {
                    return pos;
                }
            } while (pos > 0);
        }

        return npos;
    }

    /// @brief Finds the last absence of `s` character sequence in this referenced character sequence.
    /// @param s The character sequence to compare with.
    /// @param pos The offset of the search beginning position in this referenced character sequence.
    /// @return The beginning position of non `s` characters, `npos` otherwise.
    size_type find_last_not_of(const CharT* s, size_type pos = npos) const noexcept {
        return find_last_not_of(basic_str_view(s), pos);
    }

private:
    size_type m_len {0};
    const value_type* mp_str {nullptr};
};

// Prior to C++17, a static constexpr class member needs an out-of-class definition.
#ifndef FK_YAML_HAS_CXX_17

template <typename CharT, typename Traits>
constexpr typename basic_str_view<CharT, Traits>::size_type basic_str_view<CharT, Traits>::npos;

#endif // !defined(FK_YAML_HAS_CXX_17)

/// @brief An equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A basic_str_view object to compare with.
/// @return true if the two objects are the same, false otherwise.
template <typename CharT, typename Traits>
inline bool operator==(basic_str_view<CharT, Traits> lhs, basic_str_view<CharT, Traits> rhs) noexcept {
    // Comparing the lengths first will omit unnecessary value comparison in compare().
    return lhs.size() == rhs.size() && lhs.compare(rhs) == 0;
}

/// @brief An equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A basic_string object to compare with.
/// @return true if the two objects are the same, false otherwise.
template <typename CharT, typename Traits>
inline bool operator==(basic_str_view<CharT, Traits> lhs, const std::basic_string<CharT, Traits>& rhs) noexcept {
    return lhs == basic_str_view<CharT, Traits>(rhs);
}

/// @brief An equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_string object for comparison.
/// @param rhs A basic_str_view object to compare with.
/// @return true if the two objects are the same, false otherwise.
template <typename CharT, typename Traits>
inline bool operator==(const std::basic_string<CharT, Traits>& lhs, basic_str_view<CharT, Traits> rhs) noexcept {
    return basic_str_view<CharT, Traits>(lhs) == rhs;
}

/// @brief An equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @tparam N The length of the character array.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A character array to compare with.
/// @return true if the two objects are the same, false otherwise.
template <typename CharT, typename Traits, std::size_t N>
inline bool operator==(basic_str_view<CharT, Traits> lhs, const CharT (&rhs)[N]) noexcept {
    // assume `rhs` is null terminated
    return lhs == basic_str_view<CharT, Traits>(rhs);
}

/// @brief An equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @tparam N The length of the character array.
/// @param rhs A character array for comparison.
/// @param lhs A basic_str_view object to compare with.
/// @return true if the two objects are the same, false otherwise.
template <typename CharT, typename Traits, std::size_t N>
inline bool operator==(const CharT (&lhs)[N], basic_str_view<CharT, Traits> rhs) noexcept {
    // assume `lhs` is null terminated
    return basic_str_view<CharT, Traits>(lhs) == rhs;
}

/// @brief An not-equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A basic_str_view object to compare with.
/// @return true if the two objects are different, false otherwise.
template <typename CharT, typename Traits>
inline bool operator!=(basic_str_view<CharT, Traits> lhs, basic_str_view<CharT, Traits> rhs) noexcept {
    return !(lhs == rhs);
}

/// @brief An not-equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A basic_string object to compare with.
/// @return true if the two objects are different, false otherwise.
template <typename CharT, typename Traits>
inline bool operator!=(basic_str_view<CharT, Traits> lhs, const std::basic_string<CharT, Traits>& rhs) noexcept {
    return !(lhs == basic_str_view<CharT, Traits>(rhs));
}

/// @brief An not-equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_string object for comparison.
/// @param rhs A basic_str_view object to compare with.
/// @return true if the two objects are different, false otherwise.
template <typename CharT, typename Traits>
inline bool operator!=(const std::basic_string<CharT, Traits>& lhs, basic_str_view<CharT, Traits> rhs) noexcept {
    return !(basic_str_view<CharT, Traits>(lhs) == rhs);
}

/// @brief An not-equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @tparam N The length of the character array.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A character array to compare with.
/// @return true if the two objects are different, false otherwise.
template <typename CharT, typename Traits, std::size_t N>
inline bool operator!=(basic_str_view<CharT, Traits> lhs, const CharT (&rhs)[N]) noexcept {
    // assume `rhs` is null terminated.
    return !(lhs == basic_str_view<CharT, Traits>(rhs, N - 1));
}

/// @brief An not-equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @tparam N The length of the character array.
/// @param rhs A character array for comparison.
/// @param lhs A basic_str_view object to compare with.
/// @return true if the two objects are different, false otherwise.
template <typename CharT, typename Traits, std::size_t N>
inline bool operator!=(const CharT (&lhs)[N], basic_str_view<CharT, Traits> rhs) noexcept {
    // assume `lhs` is null terminate
    return !(basic_str_view<CharT, Traits>(lhs, N - 1) == rhs);
}

/// @brief An less-than operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A basic_str_view object to compare with.
/// @return true if `lhs` is less than `rhs`, false otherwise.
template <typename CharT, typename Traits>
inline bool operator<(basic_str_view<CharT, Traits> lhs, basic_str_view<CharT, Traits> rhs) noexcept {
    return lhs.compare(rhs) < 0;
}

/// @brief An less-than-or-equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A basic_str_view object to compare with.
/// @return true if `lhs` is less than or equal to `rhs`, false otherwise.
template <typename CharT, typename Traits>
inline bool operator<=(basic_str_view<CharT, Traits> lhs, basic_str_view<CharT, Traits> rhs) noexcept {
    return lhs.compare(rhs) <= 0;
}

/// @brief An greater-than operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A basic_str_view object to compare with.
/// @return true if `lhs` is greater than `rhs`, false otherwise.
template <typename CharT, typename Traits>
inline bool operator>(basic_str_view<CharT, Traits> lhs, basic_str_view<CharT, Traits> rhs) noexcept {
    return lhs.compare(rhs) > 0;
}

/// @brief An greater-than-or-equal-to operator of the basic_str_view class.
/// @tparam CharT Character type
/// @tparam Traits Character traits type.
/// @param lhs A basic_str_view object for comparison.
/// @param rhs A basic_str_view object to compare with.
/// @return true if `lhs` is greater than or equal to `rhs`, false otherwise.
template <typename CharT, typename Traits>
inline bool operator>=(basic_str_view<CharT, Traits> lhs, basic_str_view<CharT, Traits> rhs) noexcept {
    return lhs.compare(rhs) >= 0;
}

/// @brief Insertion operator of the basic_str_view class.
/// @tparam CharT Character type.
/// @tparam Traits Character traits type.
/// @param os An output stream object.
/// @param sv A basic_str_view object.
/// @return Reference to the output stream object `os`.
template <typename CharT, typename Traits>
inline std::basic_ostream<CharT, Traits>& operator<<(
    std::basic_ostream<CharT, Traits>& os, basic_str_view<CharT, Traits> sv) {
    return os.write(sv.data(), static_cast<std::streamsize>(sv.size()));
}

/// @brief view into `char` sequence.
using str_view = basic_str_view<char>;

#if FK_YAML_HAS_CHAR8_T
/// @brief view into `char8_t` sequence.
using u8str_view = basic_str_view<char8_t>;
#endif

/// @brief view into `char16_t` sequence.
using u16str_view = basic_str_view<char16_t>;

/// @brief view into `char32_t` sequence.
using u32str_view = basic_str_view<char32_t>;

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_STR_VIEW_HPP */


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief A position tracker of the target buffer.
class position_tracker {
public:
    void set_target_buffer(str_view buffer) noexcept {
        m_begin = m_last = buffer.begin();
        m_end = buffer.end();
    }

    /// @brief Update the set of the current position information.
    /// @note This function doesn't support cases where cur_pos has moved backward from the last call.
    /// @param cur_pos The iterator to the current element of the buffer.
    void update_position(const char* p_current) {
        const auto diff = static_cast<uint32_t>(p_current - m_last);
        if (diff == 0) {
            return;
        }

        m_cur_pos += diff;
        const uint32_t prev_lines_read = m_lines_read;
        m_lines_read += static_cast<uint32_t>(std::count(m_last, p_current, '\n'));
        m_last = p_current;

        if (prev_lines_read == m_lines_read) {
            m_cur_pos_in_line += diff;
            return;
        }

        uint32_t count = 0;
        const char* p_begin = m_begin;
        while (--p_current != p_begin) {
            if (*p_current == '\n') {
                break;
            }
            count++;
        }
        m_cur_pos_in_line = count;
    }

    uint32_t get_cur_pos() const noexcept {
        return m_cur_pos;
    }

    /// @brief Get the current position in the current line.
    /// @return uint32_t The current position in the current line.
    uint32_t get_cur_pos_in_line() const noexcept {
        return m_cur_pos_in_line;
    }

    /// @brief Get the number of lines which have already been read.
    /// @return uint32_t The number of lines which have already been read.
    uint32_t get_lines_read() const noexcept {
        return m_lines_read;
    }

private:
    /// The iterator to the beginning element in the target buffer.
    const char* m_begin {};
    /// The iterator to the past-the-end element in the target buffer.
    const char* m_end {};
    /// The iterator to the last updated element in the target buffer.
    const char* m_last {};
    /// The current position from the beginning of an input buffer.
    uint32_t m_cur_pos {0};
    /// The current position in the current line.
    uint32_t m_cur_pos_in_line {0};
    /// The number of lines which have already been read.
    uint32_t m_lines_read {0};
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_INPUT_POSITION_TRACKER_HPP */

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/str_view.hpp>

// #include <fkYAML/detail/types/lexical_token_t.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_TYPES_LEXICAL_TOKEN_T_HPP
#define FK_YAML_DETAIL_TYPES_LEXICAL_TOKEN_T_HPP

#include <cstdint>

// #include <fkYAML/detail/macros/define_macros.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Definition of lexical token types.
enum class lexical_token_t : std::uint8_t {
    END_OF_BUFFER,         //!< the end of input buffer.
    EXPLICIT_KEY_PREFIX,   //!< the character for explicit mapping key prefix `?`.
    KEY_SEPARATOR,         //!< the key separator `:`
    VALUE_SEPARATOR,       //!< the value separator `,`
    ANCHOR_PREFIX,         //!< the character for anchor prefix `&`
    ALIAS_PREFIX,          //!< the character for alias prefix `*`
    YAML_VER_DIRECTIVE,    //!< a YAML version directive found. use get_yaml_version() to get a value.
    TAG_DIRECTIVE,         //!< a TAG directive found. use GetTagInfo() to get the tag information.
    TAG_PREFIX,            //!< the character for tag prefix `!`
    INVALID_DIRECTIVE,     //!< an invalid directive found. do not try to get the value.
    SEQUENCE_BLOCK_PREFIX, //!< the character for sequence block prefix `- `
    SEQUENCE_FLOW_BEGIN,   //!< the character for sequence flow begin `[`
    SEQUENCE_FLOW_END,     //!< the character for sequence flow end `]`
    MAPPING_FLOW_BEGIN,    //!< the character for mapping begin `{`
    MAPPING_FLOW_END,      //!< the character for mapping end `}`
    PLAIN_SCALAR,          //!< plain (unquoted) scalars
    SINGLE_QUOTED_SCALAR,  //!< single-quoted scalars
    DOUBLE_QUOTED_SCALAR,  //!< double-quoted scalars
    BLOCK_LITERAL_SCALAR,  //!< block literal style scalars
    BLOCK_FOLDED_SCALAR,   //!< block folded style scalars
    END_OF_DIRECTIVES,     //!< the end of declaration of directives specified by `---`.
    END_OF_DOCUMENT,       //!< the end of a YAML document specified by `...`.
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_TYPES_LEXICAL_TOKEN_T_HPP */

// #include <fkYAML/exception.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Lexical token information
struct lexical_token {
    lexical_token() = default;

    lexical_token(lexical_token_t t, str_view s) noexcept
        : type(t),
          str(s) {
    }

    lexical_token(lexical_token_t t) noexcept
        : type(t) {
    }

    lexical_token(const lexical_token&) = default;
    lexical_token& operator=(const lexical_token&) = default;
    lexical_token(lexical_token&&) = default;
    lexical_token& operator=(lexical_token&&) = default;
    ~lexical_token() = default;

    /// Lexical token type.
    lexical_token_t type {lexical_token_t::END_OF_BUFFER};
    /// Lexical token contents.
    str_view str;
};

/// @brief A class which lexically analyzes YAML formatted inputs.
class lexical_analyzer {
    // whether the current context is flow(1) or block(0)
    static constexpr uint32_t flow_context_bit = 1u << 0u;
    // whether the current document part is directive(1) or content(0)
    static constexpr uint32_t document_directive_bit = 1u << 1u;

public:
    /// @brief Construct a new lexical_analyzer object.
    /// @param input_buffer An input buffer.
    explicit lexical_analyzer(str_view input_buffer) noexcept
        : m_begin_itr(input_buffer.begin()),
          m_cur_itr(input_buffer.begin()),
          m_end_itr(input_buffer.end()) {
        m_pos_tracker.set_target_buffer(input_buffer);
    }

    /// @brief Get the next lexical token by scanning the left of the input buffer.
    /// @return lexical_token The next lexical token.
    lexical_token get_next_token() {
        skip_white_spaces_and_newline_codes();

        m_token_begin_itr = m_cur_itr;
        m_pos_tracker.update_position(m_cur_itr);
        m_last_token_begin_pos = m_pos_tracker.get_cur_pos_in_line();
        m_last_token_begin_line = m_pos_tracker.get_lines_read();

        if (m_cur_itr == m_end_itr) {
            return {lexical_token_t::END_OF_BUFFER};
        }

        switch (*m_cur_itr) {
        case '?':
            if (++m_cur_itr == m_end_itr) {
                return {lexical_token_t::PLAIN_SCALAR, {m_token_begin_itr, 1}};
            }

            if (*m_cur_itr == ' ') {
                return {lexical_token_t::EXPLICIT_KEY_PREFIX};
            }
            break;
        case ':': // key separator
            if (++m_cur_itr == m_end_itr) {
                return {lexical_token_t::KEY_SEPARATOR};
            }

            switch (*m_cur_itr) {
            case ' ':
            case '\t':
            case '\n':
                return {lexical_token_t::KEY_SEPARATOR};
            default:
                if ((m_state & flow_context_bit) == 0) {
                    // in a block context
                    break;
                }

                switch (*m_cur_itr) {
                case ',':
                case '[':
                case ']':
                case '{':
                case '}':
                    // Flow indicators are not "safe" to be followed in a flow context.
                    // See https://yaml.org/spec/1.2.2/#733-plain-style for more details.
                    return {lexical_token_t::KEY_SEPARATOR};
                default:
                    // At least '{' or '[' must precedes this token.
                    FK_YAML_ASSERT(m_token_begin_itr != m_begin_itr);

                    // if a key inside a flow mapping is JSON-like (surrounded by indicators, see below), YAML allows
                    // the following value to be specified adjacent to the ":" mapping value indicator.
                    // ```yaml
                    // # the following flow mapping entries are all valid.
                    // {
                    //   "foo":true,
                    //   'bar':false,          # 'bar' is actually not JSON but allowed in YAML
                    //                         # since its surrounded by the single quotes.
                    //   {[1,2,3]:null}:"baz"
                    // }
                    // ```
                    switch (*(m_token_begin_itr - 1)) {
                    case '\'':
                    case '\"':
                    case ']':
                    case '}':
                        return {lexical_token_t::KEY_SEPARATOR};
                    default:
                        break;
                    }
                    break;
                }
                break;
            }
            break;
        case ',': // value separator
            ++m_cur_itr;
            return {lexical_token_t::VALUE_SEPARATOR};
        case '&': // anchor prefix
            return {lexical_token_t::ANCHOR_PREFIX, extract_anchor_name()};
        case '*': // alias prefix
            return {lexical_token_t::ALIAS_PREFIX, extract_anchor_name()};
        case '!': // tag prefix
            return {lexical_token_t::TAG_PREFIX, extract_tag_name()};
        case '#': // comment prefix
            scan_comment();
            return get_next_token();
        case '%': // directive prefix
            if (m_state & document_directive_bit) {
                return {scan_directive()};
            }
            // The '%' character can be safely used as the first character in document contents.
            // See https://yaml.org/spec/1.2.2/#912-document-markers for more details.
            break;
        case '-': {
            switch (*(m_cur_itr + 1)) {
            case ' ':
            case '\t':
            case '\n':
                // Move a cursor to the beginning of the next token.
                m_cur_itr += 2;
                return {lexical_token_t::SEQUENCE_BLOCK_PREFIX};
            default:
                break;
            }

            if (m_pos_tracker.get_cur_pos_in_line() == 0) {
                if ((m_end_itr - m_cur_itr) > 2) {
                    const bool is_dir_end = std::equal(m_token_begin_itr, m_cur_itr + 3, "---");
                    if (is_dir_end) {
                        m_cur_itr += 3;
                        return {lexical_token_t::END_OF_DIRECTIVES};
                    }
                }
            }

            break;
        }
        case '[': // sequence flow begin
            ++m_cur_itr;
            return {lexical_token_t::SEQUENCE_FLOW_BEGIN};
        case ']': // sequence flow end
            ++m_cur_itr;
            return {lexical_token_t::SEQUENCE_FLOW_END};
        case '{': // mapping flow begin
            ++m_cur_itr;
            return {lexical_token_t::MAPPING_FLOW_BEGIN};
        case '}': // mapping flow end
            ++m_cur_itr;
            return {lexical_token_t::MAPPING_FLOW_END};
        case '@':
            emit_error("Any token cannot start with at(@). It is a reserved indicator for YAML.");
        case '`':
            emit_error("Any token cannot start with grave accent(`). It is a reserved indicator for YAML.");
        case '\"':
            ++m_token_begin_itr;
            return {lexical_token_t::DOUBLE_QUOTED_SCALAR, determine_double_quoted_scalar_range()};
        case '\'':
            ++m_token_begin_itr;
            return {lexical_token_t::SINGLE_QUOTED_SCALAR, determine_single_quoted_scalar_range()};
        case '.': {
            if (m_pos_tracker.get_cur_pos_in_line() == 0) {
                const auto rem_size = m_end_itr - m_cur_itr;
                if FK_YAML_LIKELY (rem_size > 2) {
                    const bool is_doc_end = std::equal(m_cur_itr, m_cur_itr + 3, "...");
                    if (is_doc_end) {
                        if (rem_size > 3) {
                            switch (*(m_cur_itr + 3)) {
                            case ' ':
                            case '\t':
                            case '\n':
                                m_cur_itr += 4;
                                break;
                            default:
                                // See https://yaml.org/spec/1.2.2/#912-document-markers for more details.
                                emit_error("The document end marker \"...\" must not be followed by non-ws char.");
                            }
                        }
                        else {
                            m_cur_itr += 3;
                        }
                        return {lexical_token_t::END_OF_DOCUMENT};
                    }
                }
            }
            break;
        }
        case '|':
        case '>': {
            const str_view sv {m_token_begin_itr, m_end_itr};
            const std::size_t header_end_pos = sv.find('\n');
            FK_YAML_ASSERT(header_end_pos != str_view::npos);
            const uint32_t base_indent = get_current_indent_level(&sv[header_end_pos]);

            const lexical_token_t type = *m_token_begin_itr == '|' ? lexical_token_t::BLOCK_LITERAL_SCALAR
                                                                   : lexical_token_t::BLOCK_FOLDED_SCALAR;
            const str_view header_line = sv.substr(1, header_end_pos - 1);
            m_block_scalar_header = convert_to_block_scalar_header(header_line);

            m_token_begin_itr = sv.begin() + (header_end_pos + 1);

            return {
                type,
                determine_block_scalar_content_range(
                    base_indent, m_block_scalar_header.indent, m_block_scalar_header.indent)};
        }
        default:
            break;
        }

        return {lexical_token_t::PLAIN_SCALAR, determine_plain_scalar_range()};
    }

    /// @brief Get the beginning position of a last token.
    /// @return uint32_t The beginning position of a last token.
    uint32_t get_last_token_begin_pos() const noexcept {
        return m_last_token_begin_pos;
    }

    /// @brief Get the number of lines already processed.
    /// @return uint32_t The number of lines already processed.
    uint32_t get_lines_processed() const noexcept {
        return m_last_token_begin_line;
    }

    /// @brief Get the YAML version specification.
    /// @return str_view A YAML version specification.
    str_view get_yaml_version() const noexcept {
        return m_yaml_version;
    }

    /// @brief Get the YAML tag handle defined in the TAG directive.
    /// @return str_view A tag handle.
    str_view get_tag_handle() const noexcept {
        return m_tag_handle;
    }

    /// @brief Get the YAML tag prefix defined in the TAG directive.
    /// @return str_view A tag prefix.
    str_view get_tag_prefix() const noexcept {
        return m_tag_prefix;
    }

    /// @brief Get block scalar header information.
    /// @return block_scalar_header Block scalar header information.
    block_scalar_header get_block_scalar_header() const noexcept {
        return m_block_scalar_header;
    }

    /// @brief Toggles the context state between flow and block.
    /// @param is_flow_context true: flow context, false: block context
    void set_context_state(bool is_flow_context) noexcept {
        m_state &= ~flow_context_bit;
        if (is_flow_context) {
            m_state |= flow_context_bit;
        }
    }

    /// @brief Toggles the document state between directive and content.
    /// @param is_directive true: directive, false: content
    void set_document_state(bool is_directive) noexcept {
        m_state &= ~document_directive_bit;
        if (is_directive) {
            m_state |= document_directive_bit;
        }
    }

private:
    uint32_t get_current_indent_level(const char* p_line_end) {
        // get the beginning position of the current line.
        std::size_t line_begin_pos = str_view(m_begin_itr, p_line_end - 1).find_last_of('\n');
        if (line_begin_pos == str_view::npos) {
            line_begin_pos = 0;
        }
        else {
            ++line_begin_pos;
        }
        const char* p_line_begin = m_begin_itr + line_begin_pos;
        const char* cur_itr = p_line_begin;

        // get the indentation of the current line.
        uint32_t indent = 0;
        bool indent_found = false;
        // 0: none, 1: block seq item, 2: explicit map key, 3: explicit map value
        uint32_t context = 0;
        while (cur_itr != p_line_end && !indent_found) {
            switch (*cur_itr) {
            case ' ':
                ++indent;
                ++cur_itr;
                break;
            case '-':
                switch (*(cur_itr + 1)) {
                case ' ':
                case '\t':
                    indent += 2;
                    cur_itr += 2;
                    context = 1;
                    break;
                default:
                    indent_found = true;
                    break;
                }
                break;
            case '?':
                if (*(cur_itr + 1) == ' ') {
                    indent += 2;
                    cur_itr += 2;
                    context = 2;
                    break;
                }

                indent_found = true;
                break;
            case ':':
                switch (*(cur_itr + 1)) {
                case ' ':
                case '\t':
                    indent += 2;
                    cur_itr += 2;
                    context = 3;
                    break;
                default:
                    indent_found = true;
                    break;
                }
                break;
            default:
                indent_found = true;
                break;
            }
        }

        // If "- ", "? " and/or ": " occur in the first line of this plain scalar content.
        if (context > 0) {
            // Check if the first line contains the key separator ": ".
            // If so, the indent value remains the current one.
            // Otherwise, the indent value is changed based on the last ocurrence of the above 3.
            // In any case, multiline plain scalar content must be indented more than the indent value.
            const str_view line_content_part {p_line_begin + indent, p_line_end};
            std::size_t key_sep_pos = line_content_part.find(": ");
            if (key_sep_pos == str_view::npos) {
                key_sep_pos = line_content_part.find(":\t");
            }

            if (key_sep_pos == str_view::npos) {
                constexpr char targets[] = "-?:";
                FK_YAML_ASSERT(context - 1 < sizeof(targets));
                // NOLINTNEXTLINE(cppcoreguidelines-pro-bounds-constant-array-index)
                const char target_char = targets[context - 1];

                // Find the position of the last ocuurence of "- ", "? " or ": ".
                const str_view line_indent_part {p_line_begin, indent};
                const std::size_t block_seq_item_begin_pos = line_indent_part.find_last_of(target_char);
                FK_YAML_ASSERT(block_seq_item_begin_pos != str_view::npos);
                indent = static_cast<uint32_t>(block_seq_item_begin_pos);
            }
        }

        return indent;
    }

    /// @brief Skip until a newline code or a null character is found.
    void scan_comment() {
        FK_YAML_ASSERT(*m_cur_itr == '#');
        if FK_YAML_LIKELY (m_cur_itr != m_begin_itr) {
            switch (*(m_cur_itr - 1)) {
            case ' ':
            case '\t':
            case '\n':
                break;
            default:
                emit_error("Comment must not begin right after non-break characters");
            }
        }
        skip_until_line_end();
    }

    /// @brief Scan directives starting with the prefix '%'
    /// @note Currently, only %YAML directive is supported. If not, returns invalid or throws an exception.
    /// @return lexical_token_t The lexical token type for directives.
    lexical_token_t scan_directive() {
        FK_YAML_ASSERT(*m_cur_itr == '%');

        m_token_begin_itr = ++m_cur_itr;

        bool ends_loop = false;
        while (!ends_loop && m_cur_itr != m_end_itr) {
            switch (*m_cur_itr) {
            case ' ':
            case '\t':
                ends_loop = true;
                break;
            case '\n':
                skip_until_line_end();
                return lexical_token_t::INVALID_DIRECTIVE;
            default:
                ++m_cur_itr;
                break;
            }
        }

        const str_view dir_name(m_token_begin_itr, m_cur_itr);

        if (dir_name == "TAG") {
            if FK_YAML_UNLIKELY (!ends_loop) {
                emit_error("There must be at least one white space between \"%TAG\" and tag info.");
            }
            skip_white_spaces();
            return scan_tag_directive();
        }

        if (dir_name == "YAML") {
            if FK_YAML_UNLIKELY (!ends_loop) {
                emit_error("There must be at least one white space between \"%YAML\" and version.");
            }
            skip_white_spaces();
            return scan_yaml_version_directive();
        }

        skip_until_line_end();
        return lexical_token_t::INVALID_DIRECTIVE;
    }

    /// @brief Scan a YAML tag directive.
    /// @return lexical_token_t The lexical token type for YAML tag directives.
    lexical_token_t scan_tag_directive() {
        m_token_begin_itr = m_cur_itr;

        //
        // extract a tag handle
        //

        if FK_YAML_UNLIKELY (*m_cur_itr != '!') {
            emit_error("Tag handle must start with \'!\'.");
        }

        if FK_YAML_UNLIKELY (++m_cur_itr == m_end_itr) {
            emit_error("invalid TAG directive is found.");
        }

        switch (*m_cur_itr) {
        case ' ':
        case '\t':
            // primary handle (!)
            break;
        case '!':
            if FK_YAML_UNLIKELY (++m_cur_itr == m_end_itr) {
                emit_error("invalid TAG directive is found.");
            }
            if FK_YAML_UNLIKELY (*m_cur_itr != ' ' && *m_cur_itr != '\t') {
                emit_error("invalid tag handle is found.");
            }
            break;
        default: {
            bool ends_loop = false;
            do {
                switch (*m_cur_itr) {
                case ' ':
                case '\t':
                    emit_error("invalid tag handle is found.");
                case '!': {
                    if (m_cur_itr + 1 == m_end_itr) {
                        ends_loop = true;
                        break;
                    }
                    const char next = *(m_cur_itr + 1);
                    if FK_YAML_UNLIKELY (next != ' ' && next != '\t') {
                        emit_error("invalid tag handle is found.");
                    }
                    ends_loop = true;
                    break;
                }
                case '-':
                    break;
                default:
                    if FK_YAML_UNLIKELY (!isalnum(*m_cur_itr)) {
                        // See https://yaml.org/spec/1.2.2/#rule-c-named-tag-handle for more details.
                        emit_error("named handle can contain only numbers(0-9), alphabets(A-Z,a-z) and hyphens(-).");
                    }
                    break;
                }

                if FK_YAML_UNLIKELY (++m_cur_itr == m_end_itr) {
                    emit_error("invalid TAG directive is found.");
                }
            } while (!ends_loop);
            break;
        }
        }

        m_tag_handle = str_view {m_token_begin_itr, m_cur_itr};

        skip_white_spaces();

        //
        // extract a tag prefix.
        //

        m_token_begin_itr = m_cur_itr;
        const char* p_tag_prefix_begin = m_cur_itr;
        switch (*m_cur_itr) {
        // a tag prefix must not start with flow indicators to avoid ambiguity.
        // See https://yaml.org/spec/1.2.2/#rule-ns-global-tag-prefix for more details.
        case ',':
        case '[':
        case ']':
        case '{':
        case '}':
            emit_error("tag prefix must not start with flow indicators (\',\', [], {}).");
        default:
            break;
        }

        // extract the rest of a tag prefix.
        bool ends_loop = false;
        do {
            switch (*m_cur_itr) {
            case ' ':
            case '\t':
            case '\n':
                ends_loop = true;
                break;
            default:
                break;
            }
        } while (!ends_loop && ++m_cur_itr != m_end_itr);

        const bool is_valid = uri_encoding::validate(p_tag_prefix_begin, m_cur_itr);
        if FK_YAML_UNLIKELY (!is_valid) {
            emit_error("invalid URI character is found in a tag prefix.");
        }

        m_tag_prefix = str_view {p_tag_prefix_begin, m_cur_itr};

        return lexical_token_t::TAG_DIRECTIVE;
    }

    /// @brief Scan a YAML version directive.
    /// @note Only 1.1 and 1.2 are supported. If not, throws an exception.
    /// @return lexical_token_t The lexical token type for YAML version directives.
    lexical_token_t scan_yaml_version_directive() {
        m_token_begin_itr = m_cur_itr;

        bool ends_loop = false;
        while (!ends_loop && m_cur_itr != m_end_itr) {
            switch (*m_cur_itr) {
            case ' ':
            case '\t':
            case '\n':
                ends_loop = true;
                break;
            default:
                ++m_cur_itr;
                break;
            }
        }

        m_yaml_version = str_view {m_token_begin_itr, m_cur_itr};

        if FK_YAML_UNLIKELY (m_yaml_version.compare("1.1") != 0 && m_yaml_version.compare("1.2") != 0) {
            emit_error("Only 1.1 and 1.2 can be specified as the YAML version.");
        }

        return lexical_token_t::YAML_VER_DIRECTIVE;
    }

    /// @brief Extracts an anchor name from the input.
    /// @return The extracted anchor name.
    str_view extract_anchor_name() {
        FK_YAML_ASSERT(*m_cur_itr == '&' || *m_cur_itr == '*');

        m_token_begin_itr = ++m_cur_itr;

        bool ends_loop = false;
        for (; m_cur_itr != m_end_itr; ++m_cur_itr) {
            switch (*m_cur_itr) {
            // anchor name must not contain white spaces, newline codes and flow indicators.
            // See https://yaml.org/spec/1.2.2/#692-node-anchors for more details.
            case ' ':
            case '\t':
            case '\n':
            case '{':
            case '}':
            case '[':
            case ']':
            case ',':
                ends_loop = true;
                break;
            default:
                break;
            }

            if (ends_loop) {
                break;
            }
        }

        if FK_YAML_UNLIKELY (m_token_begin_itr == m_cur_itr) {
            emit_error("anchor name must not be empty.");
        }

        return {m_token_begin_itr, m_cur_itr};
    }

    /// @brief Extracts a tag name from the input.
    /// @return A tag name.
    str_view extract_tag_name() {
        FK_YAML_ASSERT(*m_cur_itr == '!');

        if (++m_cur_itr == m_end_itr) {
            // Just "!" is a non-specific tag.
            return {m_token_begin_itr, m_end_itr};
        }

        bool is_verbatim = false;
        bool allows_another_tag_prefix = false;

        switch (*m_cur_itr) {
        case ' ':
        case '\n':
            // Just "!" is a non-specific tag.
            return {m_token_begin_itr, m_cur_itr};
        case '!':
            // Secondary tag handles (!!suffix)
            break;
        case '<':
            // Verbatim tags (!<TAG>)
            is_verbatim = true;
            ++m_cur_itr;
            break;
        default:
            // Either local tags (!suffix) or named handles (!tag!suffix)
            allows_another_tag_prefix = true;
            break;
        }

        bool is_named_handle = false;
        bool ends_loop = false;
        do {
            if (++m_cur_itr == m_end_itr) {
                break;
            }

            switch (*m_cur_itr) {
            // Tag names must not contain spaces or newline codes.
            case ' ':
            case '\t':
            case '\n':
                ends_loop = true;
                break;
            case '!':
                if FK_YAML_UNLIKELY (!allows_another_tag_prefix) {
                    emit_error("invalid tag prefix (!) is found.");
                }

                is_named_handle = true;
                // tag prefix must not appear three times.
                allows_another_tag_prefix = false;
                break;
            default:
                break;
            }
        } while (!ends_loop);

        str_view tag_name {m_token_begin_itr, m_cur_itr};

        if (is_verbatim) {
            const char last = tag_name.back();
            if FK_YAML_UNLIKELY (last != '>') {
                emit_error("verbatim tag (!<TAG>) must be ended with \'>\'.");
            }

            // only the `TAG` part of the `!<TAG>` for URI validation.
            const str_view tag_body = tag_name.substr(2, tag_name.size() - 3);
            if FK_YAML_UNLIKELY (tag_body.empty()) {
                emit_error("verbatim tag(!<TAG>) must not be empty.");
            }

            const bool is_valid_uri = uri_encoding::validate(tag_body.begin(), tag_body.end());
            if FK_YAML_UNLIKELY (!is_valid_uri) {
                emit_error("invalid URI character is found in a verbatim tag.");
            }

            return tag_name;
        }

        if (is_named_handle) {
            const char last = tag_name.back();
            if FK_YAML_UNLIKELY (last == '!') {
                // Tag shorthand must be followed by a non-empty suffix.
                // See the "Tag Shorthands" section in https://yaml.org/spec/1.2.2/#691-node-tags.
                emit_error("named handle has no suffix.");
            }
        }

        // get the position of last tag prefix character (!) to extract body of tag shorthands.
        // tag shorthand is either primary(!tag), secondary(!!tag) or named(!handle!tag).
        const std::size_t last_tag_prefix_pos = tag_name.find_last_of('!');
        FK_YAML_ASSERT(last_tag_prefix_pos != str_view::npos);

        const str_view tag_uri = tag_name.substr(last_tag_prefix_pos + 1);
        const bool is_valid_uri = uri_encoding::validate(tag_uri.begin(), tag_uri.end());
        if FK_YAML_UNLIKELY (!is_valid_uri) {
            emit_error("Invalid URI character is found in a named tag handle.");
        }

        // Tag shorthands cannot contain flow indicators({}[],).
        // See the "Tag Shorthands" section in https://yaml.org/spec/1.2.2/#691-node-tags.
        const std::size_t invalid_char_pos = tag_uri.find_first_of("{}[],");
        if (invalid_char_pos != str_view::npos) {
            emit_error("Tag shorthand cannot contain flow indicators({}[],).");
        }

        return tag_name;
    }

    /// @brief Determines the range of single quoted scalar by scanning remaining input buffer contents.
    /// @return A single quoted scalar.
    str_view determine_single_quoted_scalar_range() {
        const str_view sv {m_token_begin_itr, m_end_itr};

        std::size_t pos = sv.find('\'');
        while (pos != str_view::npos) {
            FK_YAML_ASSERT(pos < sv.size());
            if FK_YAML_LIKELY (pos == sv.size() - 1 || sv[pos + 1] != '\'') {
                // closing single quote is found.
                m_cur_itr = m_token_begin_itr + (pos + 1);
                str_view single_quoted_scalar {m_token_begin_itr, pos};
                check_scalar_content(single_quoted_scalar);
                return single_quoted_scalar;
            }

            // If single quotation marks are repeated twice in a single quoted scalar, they are considered as an
            // escaped single quotation mark. Skip the second one which would otherwise be detected as a closing
            // single quotation mark in the next loop.
            pos = sv.find('\'', pos + 2);
        }

        m_cur_itr = m_end_itr; // update for error information
        emit_error("Invalid end of input buffer in a single-quoted scalar token.");
    }

    /// @brief Determines the range of double quoted scalar by scanning remaining input buffer contents.
    /// @return A double quoted scalar.
    str_view determine_double_quoted_scalar_range() {
        const str_view sv {m_token_begin_itr, m_end_itr};

        std::size_t pos = sv.find('\"');
        while (pos != str_view::npos) {
            FK_YAML_ASSERT(pos < sv.size());

            bool is_closed = true;
            if FK_YAML_LIKELY (pos > 0) {
                // Double quotation marks can be escaped by a preceding backslash and the number of backslashes matters
                // to determine if the found double quotation mark is escaped since the backslash itself can also be
                // escaped:
                // * odd number of backslashes  -> double quotation mark IS escaped (e.g., "\\\"")
                // * even number of backslashes -> double quotation mark IS NOT escaped (e.g., "\\"")
                uint32_t backslash_counts = 0;
                const char* p = m_token_begin_itr + (pos - 1);
                do {
                    if (*p-- != '\\') {
                        break;
                    }
                    ++backslash_counts;
                } while (p != m_token_begin_itr);
                is_closed = ((backslash_counts & 1u) == 0); // true: even, false: odd
            }

            if (is_closed) {
                // closing double quote is found.
                m_cur_itr = m_token_begin_itr + (pos + 1);
                str_view double_quoted_scalar {m_token_begin_itr, pos};
                check_scalar_content(double_quoted_scalar);
                return double_quoted_scalar;
            }

            pos = sv.find('\"', pos + 1);
        }

        m_cur_itr = m_end_itr; // update for error information
        emit_error("Invalid end of input buffer in a double-quoted scalar token.");
    }

    /// @brief Determines the range of plain scalar by scanning remaining input buffer contents.
    /// @return A plain scalar.
    str_view determine_plain_scalar_range() {
        const str_view sv {m_token_begin_itr, m_end_itr};

        // flow indicators are checked only within a flow context.
        const str_view filter = (m_state & flow_context_bit) ? "\t\n :{}[]," : "\t\n :";
        std::size_t pos = sv.find_first_of(filter);
        if FK_YAML_UNLIKELY (pos == str_view::npos) {
            check_scalar_content(sv);
            m_cur_itr = m_end_itr;
            return sv;
        }

        bool ends_loop = false;
        uint32_t indent = std::numeric_limits<uint32_t>::max();
        do {
            FK_YAML_ASSERT(pos < sv.size());
            switch (sv[pos]) {
            case '\n': {
                if (indent == std::numeric_limits<uint32_t>::max()) {
                    indent = get_current_indent_level(&sv[pos]);
                }

                constexpr str_view space_filter {" \t\n"};
                const std::size_t non_space_pos = sv.find_first_not_of(space_filter, pos);
                const std::size_t last_newline_pos = sv.find_last_of('\n', non_space_pos);
                FK_YAML_ASSERT(last_newline_pos != str_view::npos);

                if (non_space_pos == str_view::npos || non_space_pos - last_newline_pos - 1 <= indent) {
                    ends_loop = true;
                    break;
                }

                pos = non_space_pos;
                break;
            }
            case ' ':
            case '\t':
                if FK_YAML_UNLIKELY (pos == sv.size() - 1) {
                    // trim trailing space.
                    ends_loop = true;
                    break;
                }

                // Allow a space in a plain scalar only if the space is surrounded by non-space characters, but not
                // followed by the comment prefix " #".
                // Also, flow indicators are not allowed to be followed after a space in a flow context.
                // See https://yaml.org/spec/1.2.2/#733-plain-style for more details.
                switch (sv[pos + 1]) {
                case ' ':
                case '\t':
                case '\n':
                case '#':
                    ends_loop = true;
                    break;
                case ':':
                    // " :" is permitted in a plain style string token, but not when followed by a space.
                    ends_loop = (pos < sv.size() - 2) && (sv[pos + 2] == ' ');
                    break;
                case '{':
                case '}':
                case '[':
                case ']':
                case ',':
                    ends_loop = (m_state & flow_context_bit);
                    break;
                default:
                    break;
                }
                break;
            case ':':
                if FK_YAML_LIKELY (pos + 1 < sv.size()) {
                    switch (sv[pos + 1]) {
                    case ' ':
                    case '\t':
                    case '\n':
                        ends_loop = true;
                        break;
                    default:
                        break;
                    }
                }
                break;
            case '{':
            case '}':
            case '[':
            case ']':
            case ',':
                // This check is enabled only in a flow context.
                ends_loop = true;
                break;
            default:                   // LCOV_EXCL_LINE
                detail::unreachable(); // LCOV_EXCL_LINE
            }

            if (ends_loop) {
                break;
            }

            pos = sv.find_first_of(filter, pos + 1);
        } while (pos != str_view::npos);

        str_view plain_scalar = sv.substr(0, pos);
        check_scalar_content(plain_scalar);
        m_cur_itr = plain_scalar.end();
        return plain_scalar;
    }

    /// @brief Scan a block style string token either in the literal or folded style.
    /// @param base_indent The base indent level of the block scalar.
    /// @param indicated_indent The indicated indent level in the block scalar header. 0 means it's not indicated.
    /// @param token Storage for the scanned block scalar range.
    /// @return The content indentation level of the block scalar.
    str_view determine_block_scalar_content_range(
        uint32_t base_indent, uint32_t indicated_indent, uint32_t& content_indent) {
        const str_view sv {m_token_begin_itr, m_end_itr};
        const std::size_t remain_input_len = sv.size();

        // Handle leading all-space lines.
        uint32_t cur_indent = 0;
        uint32_t max_leading_indent = 0;
        const char* cur_itr = m_token_begin_itr;
        bool stop_increment = false;

        while (cur_itr != m_end_itr) {
            switch (*cur_itr++) {
            case ' ':
                if FK_YAML_LIKELY (!stop_increment) {
                    ++cur_indent;
                }
                continue;
            case '\t':
                // Tabs are not counted as an indent character but still part of an empty line.
                // See https://yaml.org/spec/1.2.2/#rule-s-indent and https://yaml.org/spec/1.2.2/#64-empty-lines.
                stop_increment = true;
                continue;
            case '\n':
                max_leading_indent = std::max(cur_indent, max_leading_indent);
                cur_indent = 0;
                stop_increment = false;
                continue;
            default:
                break;
            }
            break;
        }

        // all the block scalar contents are empty lines, and no subsequent token exists.
        if FK_YAML_UNLIKELY (cur_itr == m_end_itr) {
            // Without the following iterator update, lexer cannot reach the end of input buffer and causes infinite
            // loops from the next loop. (https://github.com/fktn-k/fkYAML/pull/410)
            m_cur_itr = m_end_itr;

            // If there's no non-empty line, the content indentation level is equal to the number of spaces on the
            // longest line. https://yaml.org/spec/1.2.2/#8111-block-indentation-indicator
            content_indent =
                indicated_indent == 0 ? std::max(cur_indent, max_leading_indent) : base_indent + indicated_indent;
            return sv;
        }

        // Any leading empty line must not contain more spaces than the first non-empty line.
        if FK_YAML_UNLIKELY (cur_indent < max_leading_indent) {
            emit_error("Any leading empty line must not be more indented than the first non-empty line.");
        }

        if (indicated_indent == 0) {
            FK_YAML_ASSERT(base_indent < cur_indent);
            indicated_indent = cur_indent - base_indent;
        }
        else if FK_YAML_UNLIKELY (cur_indent < base_indent + indicated_indent) {
            emit_error("The first non-empty line in the block scalar is less indented.");
        }

        std::size_t last_newline_pos = sv.find('\n', cur_itr - m_token_begin_itr + 1);
        if (last_newline_pos == str_view::npos) {
            last_newline_pos = remain_input_len;
        }

        content_indent = base_indent + indicated_indent;
        while (last_newline_pos < remain_input_len) {
            std::size_t cur_line_end_pos = sv.find('\n', last_newline_pos + 1);
            if (cur_line_end_pos == str_view::npos) {
                cur_line_end_pos = remain_input_len;
            }

            const std::size_t cur_line_content_begin_pos = sv.find_first_not_of(' ', last_newline_pos + 1);
            if (cur_line_content_begin_pos == str_view::npos) {
                last_newline_pos = cur_line_end_pos;
                continue;
            }

            FK_YAML_ASSERT(last_newline_pos < cur_line_content_begin_pos);
            cur_indent = static_cast<uint32_t>(cur_line_content_begin_pos - last_newline_pos - 1);
            if (cur_indent < content_indent && sv[cur_line_content_begin_pos] != '\n') {
                if FK_YAML_UNLIKELY (cur_indent > base_indent) {
                    // This path assumes an input like the following:
                    // ```yaml
                    // foo: |
                    //   text
                    //  invalid # this line is less indented than the content indent level (2)
                    //          # but more indented than the base indent level (0)
                    // ```
                    // In such cases, the less indented line cannot be the start of the next token.
                    emit_error("A content line of the block scalar is less indented.");
                }

                // Interpret less indented non-space characters as the start of the next token.
                break;
            }

            last_newline_pos = cur_line_end_pos;
        }

        // include last newline character if not all characters have been consumed yet.
        if (last_newline_pos < remain_input_len) {
            ++last_newline_pos;
        }

        m_cur_itr = m_token_begin_itr + last_newline_pos;
        return sv.substr(0, last_newline_pos);
    }

    /// @brief Checks if the given scalar contains no unescaped control characters.
    /// @param scalar Scalar contents.
    void check_scalar_content(const str_view& scalar) const {
        const char* p_current = scalar.begin();
        const char* p_end = scalar.end();

        while (p_current != p_end) {
            const uint32_t num_bytes = utf8::get_num_bytes(static_cast<uint8_t>(*p_current));
            if (num_bytes > 1) {
                // Multibyte characters are already checked in the input_adapter module.
                p_current += num_bytes;
                continue;
            }

            switch (*p_current++) {
            // 0x00(NULL) has already been handled above.
            case 0x01:
                emit_error("Control character U+0001 (SOH) must be escaped to \\u0001.");
            case 0x02:
                emit_error("Control character U+0002 (STX) must be escaped to \\u0002.");
            case 0x03:
                emit_error("Control character U+0003 (ETX) must be escaped to \\u0003.");
            case 0x04:
                emit_error("Control character U+0004 (EOT) must be escaped to \\u0004.");
            case 0x05:
                emit_error("Control character U+0005 (ENQ) must be escaped to \\u0005.");
            case 0x06:
                emit_error("Control character U+0006 (ACK) must be escaped to \\u0006.");
            case 0x07:
                emit_error("Control character U+0007 (BEL) must be escaped to \\a or \\u0007.");
            case 0x08:
                emit_error("Control character U+0008 (BS) must be escaped to \\b or \\u0008.");
            case 0x09: // HT
                // horizontal tabs (\t) are safe to use without escaping.
                break;
            // 0x0A(LF) has already been handled above.
            case 0x0B:
                emit_error("Control character U+000B (VT) must be escaped to \\v or \\u000B.");
            case 0x0C:
                emit_error("Control character U+000C (FF) must be escaped to \\f or \\u000C.");
            // 0x0D(CR) has already been handled above.
            case 0x0E:
                emit_error("Control character U+000E (SO) must be escaped to \\u000E.");
            case 0x0F:
                emit_error("Control character U+000F (SI) must be escaped to \\u000F.");
            case 0x10:
                emit_error("Control character U+0010 (DLE) must be escaped to \\u0010.");
            case 0x11:
                emit_error("Control character U+0011 (DC1) must be escaped to \\u0011.");
            case 0x12:
                emit_error("Control character U+0012 (DC2) must be escaped to \\u0012.");
            case 0x13:
                emit_error("Control character U+0013 (DC3) must be escaped to \\u0013.");
            case 0x14:
                emit_error("Control character U+0014 (DC4) must be escaped to \\u0014.");
            case 0x15:
                emit_error("Control character U+0015 (NAK) must be escaped to \\u0015.");
            case 0x16:
                emit_error("Control character U+0016 (SYN) must be escaped to \\u0016.");
            case 0x17:
                emit_error("Control character U+0017 (ETB) must be escaped to \\u0017.");
            case 0x18:
                emit_error("Control character U+0018 (CAN) must be escaped to \\u0018.");
            case 0x19:
                emit_error("Control character U+0019 (EM) must be escaped to \\u0019.");
            case 0x1A:
                emit_error("Control character U+001A (SUB) must be escaped to \\u001A.");
            case 0x1B:
                emit_error("Control character U+001B (ESC) must be escaped to \\e or \\u001B.");
            case 0x1C:
                emit_error("Control character U+001C (FS) must be escaped to \\u001C.");
            case 0x1D:
                emit_error("Control character U+001D (GS) must be escaped to \\u001D.");
            case 0x1E:
                emit_error("Control character U+001E (RS) must be escaped to \\u001E.");
            case 0x1F:
                emit_error("Control character U+001F (US) must be escaped to \\u001F.");
            default:
                break;
            }
        }
    }

    /// @brief Gets the metadata of a following block style string scalar.
    /// @param chomp_type A variable to store the retrieved chomping style type.
    /// @param indent A variable to store the retrieved indent size.
    /// @return Block scalar header information converted from the header line.
    block_scalar_header convert_to_block_scalar_header(str_view line) {
        constexpr str_view comment_prefix {" #"};
        const std::size_t comment_begin_pos = line.find(comment_prefix);
        if (comment_begin_pos != str_view::npos) {
            line = line.substr(0, comment_begin_pos);
        }

        if (line.empty()) {
            return {};
        }

        block_scalar_header header {};
        for (const char c : line) {
            switch (c) {
            case '-':
                if FK_YAML_UNLIKELY (header.chomp != chomping_indicator_t::CLIP) {
                    emit_error("Too many block chomping indicators specified.");
                }
                header.chomp = chomping_indicator_t::STRIP;
                break;
            case '+':
                if FK_YAML_UNLIKELY (header.chomp != chomping_indicator_t::CLIP) {
                    emit_error("Too many block chomping indicators specified.");
                }
                header.chomp = chomping_indicator_t::KEEP;
                break;
            case '0':
                emit_error("An indentation level for a block scalar cannot be 0.");
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
                if FK_YAML_UNLIKELY (header.indent > 0) {
                    emit_error("Invalid indentation level for a block scalar. It must be between 1 and 9.");
                }
                header.indent = static_cast<uint32_t>(c - '0');
                break;
            case ' ':
            case '\t':
                break;
            default:
                emit_error("Invalid character found in a block scalar header.");
            }
        }

        return header;
    }

    /// @brief Skip white spaces (half-width spaces and tabs) from the current position.
    void skip_white_spaces() {
        m_cur_itr = std::find_if_not(m_cur_itr, m_end_itr, [](char c) { return (c == ' ' || c == '\t'); });
    }

    /// @brief Skip white spaces and newline codes (CR/LF) from the current position.
    void skip_white_spaces_and_newline_codes() {
        if (m_cur_itr != m_end_itr) {
            m_cur_itr = std::find_if_not(m_cur_itr, m_end_itr, [](char c) {
                switch (c) {
                case ' ':
                case '\t':
                case '\n':
                    return true;
                default:
                    return false;
                }
            });
        }
    }

    /// @brief Skip the rest in the current line.
    void skip_until_line_end() {
        while (m_cur_itr != m_end_itr) {
            switch (*m_cur_itr) {
            case '\n':
                ++m_cur_itr;
                return;
            default:
                ++m_cur_itr;
                break;
            }
        }
    }

    /// @brief Emits an error with the given message.
    /// @param msg A message for the resulting error.
    [[noreturn]] void emit_error(const char* msg) const {
        m_pos_tracker.update_position(m_cur_itr);
        throw fkyaml::parse_error(msg, m_pos_tracker.get_lines_read(), m_pos_tracker.get_cur_pos_in_line());
    }

private:
    /// The iterator to the first element in the input buffer.
    const char* m_begin_itr {};
    /// The iterator to the current character in the input buffer.
    const char* m_cur_itr {};
    /// The iterator to the beginning of the current token.
    const char* m_token_begin_itr {};
    /// The iterator to the past-the-end element in the input buffer.
    const char* m_end_itr {};
    /// The current position tracker of the input buffer.
    mutable position_tracker m_pos_tracker {};
    /// The last yaml version.
    str_view m_yaml_version;
    /// The last tag handle.
    str_view m_tag_handle;
    /// The last tag prefix.
    str_view m_tag_prefix;
    /// The last block scalar header.
    block_scalar_header m_block_scalar_header {};
    /// The beginning position of the last lexical token. (zero origin)
    uint32_t m_last_token_begin_pos {0};
    /// The beginning line of the last lexical token. (zero origin)
    uint32_t m_last_token_begin_line {0};
    /// The current depth of flow context.
    uint32_t m_state {0};
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_INPUT_LEXICAL_ANALYZER_HPP */

// #include <fkYAML/detail/input/scalar_parser.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_INPUT_SCALAR_PARSER_HPP
#define FK_YAML_DETAIL_INPUT_SCALAR_PARSER_HPP

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/assert.hpp>

// #include <fkYAML/detail/conversions/scalar_conv.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

// **NOTE FOR LIBRARY DEVELOPERS**:
// Implementations in this header file are intentionally optimized for conversions between YAML scalars and native C++
// types. So, some implementations don't follow the conversions in the standard C++ functions. For example, octals must
// begin with "0o" (not "0"), which is specified in the YAML spec 1.2.

#ifndef FK_YAML_CONVERSIONS_SCALAR_CONV_HPP
#define FK_YAML_CONVERSIONS_SCALAR_CONV_HPP

#include <cmath>
#include <cstdint>
#include <cstring>
#include <limits>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/type_traits.hpp>


#if FK_YAML_HAS_TO_CHARS
// Prefer std::to_chars() and std::from_chars() functions if available.
#include <charconv>
#else
// Fallback to legacy string conversion functions otherwise.
#include <string> // std::stof(), std::stod(), std::stold()
#endif

FK_YAML_DETAIL_NAMESPACE_BEGIN

//////////////////////////
//   conv_limits_base   //
//////////////////////////

/// @brief A structure which provides limits for conversions between scalars and integers.
/// @note This structure contains common limits in both signed and unsigned integers.
/// @tparam NumBytes The number of bytes for the integer type.
template <std::size_t NumBytes>
struct conv_limits_base {};

/// @brief The specialization of conv_limits_base for 1 byte integers, e.g., int8_t, uint8_t.
template <>
struct conv_limits_base<1u> {
    /// max characters for octals (0o377) without the prefix part.
    static constexpr std::size_t max_chars_oct = 3;
    /// max characters for hexadecimals (0xFF) without the prefix part.
    static constexpr std::size_t max_chars_hex = 2;

    /// @brief Check if the given octals are safely converted into 1 byte integer.
    /// @param octs The pointer to octal characters
    /// @param len The length of octal characters
    /// @return true is safely convertible, false otherwise.
    static bool check_if_octs_safe(const char* octs, std::size_t len) noexcept {
        return (len < max_chars_oct) || (len == max_chars_oct && octs[0] <= '3');
    }

    /// @brief Check if the given hexadecimals are safely converted into 1 byte integer.
    /// @param octs The pointer to hexadecimal characters
    /// @param len The length of hexadecimal characters
    /// @return true is safely convertible, false otherwise.
    static bool check_if_hexs_safe(const char* /*unused*/, std::size_t len) noexcept {
        return len <= max_chars_hex;
    }
};

/// @brief The specialization of conv_limits_base for 2 byte integers, e.g., int16_t, uint16_t.
template <>
struct conv_limits_base<2u> {
    /// max characters for octals (0o177777) without the prefix part.
    static constexpr std::size_t max_chars_oct = 6;
    /// max characters for hexadecimals (0xFFFF) without the prefix part.
    static constexpr std::size_t max_chars_hex = 4;

    /// @brief Check if the given octals are safely converted into 2 byte integer.
    /// @param octs The pointer to octal characters
    /// @param len The length of octal characters
    /// @return true is safely convertible, false otherwise.
    static bool check_if_octs_safe(const char* octs, std::size_t len) noexcept {
        return (len < max_chars_oct) || (len == max_chars_oct && octs[0] <= '1');
    }

    /// @brief Check if the given hexadecimals are safely converted into 2 byte integer.
    /// @param octs The pointer to hexadecimal characters
    /// @param len The length of hexadecimal characters
    /// @return true is safely convertible, false otherwise.
    static bool check_if_hexs_safe(const char* /*unused*/, std::size_t len) noexcept {
        return len <= max_chars_hex;
    }
};

/// @brief The specialization of conv_limits_base for 4 byte integers, e.g., int32_t, uint32_t.
template <>
struct conv_limits_base<4u> {
    /// max characters for octals (0o37777777777) without the prefix part.
    static constexpr std::size_t max_chars_oct = 11;
    /// max characters for hexadecimals (0xFFFFFFFF) without the prefix part.
    static constexpr std::size_t max_chars_hex = 8;

    /// @brief Check if the given octals are safely converted into 4 byte integer.
    /// @param octs The pointer to octal characters
    /// @param len The length of octal characters
    /// @return true is safely convertible, false otherwise.
    static bool check_if_octs_safe(const char* octs, std::size_t len) noexcept {
        return (len < max_chars_oct) || (len == max_chars_oct && octs[0] <= '3');
    }

    /// @brief Check if the given hexadecimals are safely converted into 4 byte integer.
    /// @param octs The pointer to hexadecimal characters
    /// @param len The length of hexadecimal characters
    /// @return true is safely convertible, false otherwise.
    static bool check_if_hexs_safe(const char* /*unused*/, std::size_t len) noexcept {
        return len <= max_chars_hex;
    }
};

/// @brief The specialization of conv_limits_base for 8 byte integers, e.g., int64_t, uint64_t.
template <>
struct conv_limits_base<8u> {
    /// max characters for octals (0o1777777777777777777777) without the prefix part.
    static constexpr std::size_t max_chars_oct = 22;
    /// max characters for hexadecimals (0xFFFFFFFFFFFFFFFF) without the prefix part.
    static constexpr std::size_t max_chars_hex = 16;

    /// @brief Check if the given octals are safely converted into 8 byte integer.
    /// @param octs The pointer to octal characters
    /// @param len The length of octal characters
    /// @return true is safely convertible, false otherwise.
    static bool check_if_octs_safe(const char* octs, std::size_t len) noexcept {
        return (len < max_chars_oct) || (len == max_chars_oct && octs[0] <= '1');
    }

    /// @brief Check if the given hexadecimals are safely converted into 8 byte integer.
    /// @param octs The pointer to hexadecimal characters
    /// @param len The length of hexadecimal characters
    /// @return true is safely convertible, false otherwise.
    static bool check_if_hexs_safe(const char* /*unused*/, std::size_t len) noexcept {
        return len <= max_chars_hex;
    }
};

/////////////////////
//   conv_limits   //
/////////////////////

/// @brief A structure which provides limits for conversions between scalars and integers.
/// @note This structure contains limits which differs based on signedness.
/// @tparam NumBytes The number of bytes for the integer type.
/// @tparam IsSigned Whether an integer is signed or unsigned
template <std::size_t NumBytes, bool IsSigned>
struct conv_limits {};

/// @brief The specialization of conv_limits for 1 byte signed integers, e.g., int8_t.
template <>
struct conv_limits<1u, true> : conv_limits_base<1u> {
    /// with or without sign.
    static constexpr bool is_signed = true;

    /// max characters for decimals (-128..127) without sign.
    static constexpr std::size_t max_chars_dec = 3;

    /// string representation of max decimal value.
    static const char* max_value_chars_dec() noexcept {
        // Making this function a static constexpr variable, a link error happens.
        // Although the issue has been fixed since C++17, this workaround is necessary to let this functionality work
        // with C++11 (the library's default C++ standard version).
        // The same thing is applied to similar functions in the other specializations.

        static constexpr char max_value_chars[] = "127";
        return &max_value_chars[0];
    }

    /// string representation of min decimal value without sign.
    static const char* min_value_chars_dec() noexcept {
        static constexpr char min_value_chars[] = "128";
        return &min_value_chars[0];
    }
};

/// @brief The specialization of conv_limits for 1 byte unsigned integers, e.g., uint8_t.
template <>
struct conv_limits<1u, false> : conv_limits_base<1u> {
    /// with or without sign.
    static constexpr bool is_signed = false;

    /// max characters for decimals (0..255) without sign.
    static constexpr std::size_t max_chars_dec = 3;

    /// string representation of max decimal value.
    static const char* max_value_chars_dec() noexcept {
        static constexpr char max_value_chars[] = "255";
        return &max_value_chars[0];
    }

    /// string representation of min decimal value.
    static const char* min_value_chars_dec() noexcept {
        static constexpr char min_value_chars[] = "0";
        return &min_value_chars[0];
    }
};

/// @brief The specialization of conv_limits for 2 byte signed integers, e.g., int16_t.
template <>
struct conv_limits<2u, true> : conv_limits_base<2u> {
    /// with or without sign.
    static constexpr bool is_signed = true;

    /// max characters for decimals (-32768..32767) without sign.
    static constexpr std::size_t max_chars_dec = 5;

    /// string representation of max decimal value.
    static const char* max_value_chars_dec() noexcept {
        static constexpr char max_value_chars[] = "32767";
        return &max_value_chars[0];
    }

    /// string representation of min decimal value without sign.
    static const char* min_value_chars_dec() noexcept {
        static constexpr char min_value_chars[] = "32768";
        return &min_value_chars[0];
    }
};

/// @brief The specialization of conv_limits for 2 byte unsigned integers, e.g., uint16_t.
template <>
struct conv_limits<2u, false> : conv_limits_base<2u> {
    /// with or without sign.
    static constexpr bool is_signed = false;

    /// max characters for decimals (0..65535) without sign.
    static constexpr std::size_t max_chars_dec = 5;

    /// string representation of max decimal value.
    static const char* max_value_chars_dec() noexcept {
        static constexpr char max_value_chars[] = "65535";
        return &max_value_chars[0];
    }

    /// string representation of min decimal value.
    static const char* min_value_chars_dec() noexcept {
        static constexpr char min_value_chars[] = "0";
        return &min_value_chars[0];
    }
};

/// @brief The specialization of conv_limits for 4 byte signed integers, e.g., int32_t.
template <>
struct conv_limits<4u, true> : conv_limits_base<4u> {
    /// with or without sign.
    static constexpr bool is_signed = true;

    /// max characters for decimals (-2147483648..2147483647) without sign.
    static constexpr std::size_t max_chars_dec = 10;

    /// string representation of max decimal value.
    static const char* max_value_chars_dec() noexcept {
        static constexpr char max_value_chars[] = "2147483647";
        return &max_value_chars[0];
    }

    /// string representation of min decimal value without sign.
    static const char* min_value_chars_dec() noexcept {
        static constexpr char min_value_chars[] = "2147483648";
        return &min_value_chars[0];
    }
};

/// @brief The specialization of conv_limits for 4 byte unsigned integers, e.g., uint32_t.
template <>
struct conv_limits<4u, false> : conv_limits_base<4u> {
    /// with or without sign.
    static constexpr bool is_signed = false;

    /// max characters for decimals (0..4294967295) without sign.
    static constexpr std::size_t max_chars_dec = 10;

    /// string representation of max decimal value.
    static const char* max_value_chars_dec() noexcept {
        static constexpr char max_value_chars[] = "4294967295";
        return &max_value_chars[0];
    }

    /// string representation of min decimal value.
    static const char* min_value_chars_dec() noexcept {
        static constexpr char min_value_chars[] = "0";
        return &min_value_chars[0];
    }
};

/// @brief The specialization of conv_limits for 8 byte signed integers, e.g., int64_t.
template <>
struct conv_limits<8u, true> : conv_limits_base<8u> {
    /// with or without sign.
    static constexpr bool is_signed = true;

    /// max characters for decimals (-9223372036854775808..9223372036854775807) without sign.
    static constexpr std::size_t max_chars_dec = 19;

    /// string representation of max decimal value.
    static const char* max_value_chars_dec() noexcept {
        static constexpr char max_value_chars[] = "9223372036854775807";
        return &max_value_chars[0];
    }

    /// string representation of min decimal value without sign.
    static const char* min_value_chars_dec() noexcept {
        static constexpr char min_value_chars[] = "9223372036854775808";
        return &min_value_chars[0];
    }
};

/// @brief The specialization of conv_limits for 8 byte unsigned integers, e.g., uint64_t.
template <>
struct conv_limits<8u, false> : conv_limits_base<8u> {
    /// with or without sign.
    static constexpr bool is_signed = false;

    /// max characters for decimals (0..18446744073709551615) without sign.
    static constexpr std::size_t max_chars_dec = 20;

    /// string representation of max decimal value.
    static const char* max_value_chars_dec() noexcept {
        static constexpr char max_value_chars[] = "18446744073709551615";
        return &max_value_chars[0];
    }

    /// string representation of min decimal value.
    static const char* min_value_chars_dec() noexcept {
        static constexpr char min_value_chars[] = "0";
        return &min_value_chars[0];
    }
};

//////////////////////////
//   scalar <--> null   //
//////////////////////////

/// @brief Converts a scalar into a null value
/// @tparam CharItr Type of char iterators. Its value type must be `char` (maybe cv-qualified).
/// @param begin The iterator to the first element of the scalar.
/// @param end The iterator to the past-the-end element of the scalar.
/// @param /*unused*/ The null value holder (unused since it can only have `nullptr`)
/// @return true if the conversion completes successfully, false otherwise.
template <typename CharItr>
inline bool aton(CharItr begin, CharItr end, std::nullptr_t& /*unused*/) noexcept {
    static_assert(is_iterator_of<CharItr, char>::value, "aton() accepts iterators for char type");

    if FK_YAML_UNLIKELY (begin == end) {
        return false;
    }

    const auto len = static_cast<uint32_t>(std::distance(begin, end));

    // This path is the most probable case, so check it first.
    if FK_YAML_LIKELY (len == 4) {
        const char* p_begin = &*begin;
        return (std::strncmp(p_begin, "null", 4) == 0) || (std::strncmp(p_begin, "Null", 4) == 0) ||
               (std::strncmp(p_begin, "NULL", 4) == 0);
    }

    if (len == 1) {
        return *begin == '~';
    }

    return false;
}

/////////////////////////////
//   scalar <--> boolean   //
/////////////////////////////

/// @brief Converts a scalar into a boolean value
/// @tparam CharItr The type of char iterators. Its value type must be `char` (maybe cv-qualified).
/// @tparam BoolType The output boolean type.
/// @param begin The iterator to the first element of the scalar.
/// @param end The iterator to the past-the-end element of the scalar.
/// @param boolean The boolean value holder.
/// @return true if the conversion completes successfully, false otherwise.
template <typename CharItr, typename BoolType>
inline bool atob(CharItr begin, CharItr end, BoolType& boolean) noexcept {
    static_assert(is_iterator_of<CharItr, char>::value, "atob() accepts iterators for char type");

    if FK_YAML_UNLIKELY (begin == end) {
        return false;
    }

    const auto len = static_cast<uint32_t>(std::distance(begin, end));
    const char* p_begin = &*begin;

    if (len == 4) {
        const bool is_true = (std::strncmp(p_begin, "true", 4) == 0) || (std::strncmp(p_begin, "True", 4) == 0) ||
                             (std::strncmp(p_begin, "TRUE", 4) == 0);

        if FK_YAML_LIKELY (is_true) {
            boolean = static_cast<BoolType>(true);
        }
        return is_true;
    }

    if (len == 5) {
        const bool is_false = (std::strncmp(p_begin, "false", 5) == 0) || (std::strncmp(p_begin, "False", 5) == 0) ||
                              (std::strncmp(p_begin, "FALSE", 5) == 0);

        if FK_YAML_LIKELY (is_false) {
            boolean = static_cast<BoolType>(false);
        }
        return is_false;
    }

    return false;
}

/////////////////////////////
//   scalar <--> integer   //
/////////////////////////////

//
// scalar --> decimals
//

/// @brief Converts a scalar into decimals. This is common implementation for both signed/unsigned integer types.
/// @warning
/// This function does NOT care about overflows if IntType is unsigned. The source string value must be validated
/// beforehand by calling either atoi_dec_pos() or atoi_dec_neg() functions.
/// Furthermore, `p_begin` and `p_end` must NOT be null. Validate them before calling this function.
/// @tparam IntType The output integer type. It can be either signed or unsigned.
/// @param p_begin The pointer to the first element of the scalar.
/// @param p_end The pointer to the past-the-end element of the scalar.
/// @param i The output integer value holder.
/// @return true if the conversion completes successfully, false otherwise.
template <typename IntType>
inline bool atoi_dec_unchecked(const char* p_begin, const char* p_end, IntType& i) noexcept {
    static_assert(
        is_non_bool_integral<IntType>::value,
        "atoi_dec_unchecked() accepts non-boolean integral types as an output type");

    i = 0;
    do {
        const char c = *p_begin;
        if FK_YAML_UNLIKELY (c < '0' || '9' < c) {
            return false;
        }
        // Overflow is intentional when the IntType is signed.
        i = i * static_cast<IntType>(10) + static_cast<IntType>(c - '0');
    } while (++p_begin != p_end);

    return true;
}

/// @brief Converts a scalar into positive decimals. This function executes bounds check to avoid overflow.
/// @warning `p_begin` and `p_end` must not be null. Validate them before calling this function.
/// @tparam IntType The output integer type. It can be either signed or unsigned.
/// @param p_begin The pointer to the first element of the scalar.
/// @param p_end The pointer to the past-the-end element of the scalar.
/// @param i The output integer value holder.
/// @return true if the conversion completes successfully, false otherwise.
template <typename IntType>
inline bool atoi_dec_pos(const char* p_begin, const char* p_end, IntType& i) noexcept {
    static_assert(
        is_non_bool_integral<IntType>::value, "atoi_dec_pos() accepts non-boolean integral types as an output type");

    if FK_YAML_UNLIKELY (p_begin == p_end) {
        return false;
    }

    using conv_limits_type = conv_limits<sizeof(IntType), std::is_signed<IntType>::value>;

    const auto len = static_cast<std::size_t>(p_end - p_begin);
    if FK_YAML_UNLIKELY (len > conv_limits_type::max_chars_dec) {
        // Overflow will happen.
        return false;
    }

    if (len == conv_limits_type::max_chars_dec) {
        const char* p_max_value_chars_dec = conv_limits_type::max_value_chars_dec();

        for (std::size_t idx = 0; idx < conv_limits_type::max_chars_dec; idx++) {
            if (p_begin[idx] < p_max_value_chars_dec[idx]) {
                // No need to check the lower digits. Overflow will no longer happen.
                break;
            }

            if FK_YAML_UNLIKELY (p_begin[idx] > p_max_value_chars_dec[idx]) {
                // Overflow will happen.
                return false;
            }
        }
    }

    return atoi_dec_unchecked(p_begin, p_end, i);
}

/// @brief Converts a scalar into negative decimals. This function executes bounds check to avoid underflow.
/// @warning `p_begin` and `p_end` must not be null. Validate them before calling this function.
/// @tparam IntType The output integer type. It must be signed.
/// @param p_begin The pointer to the first element of the scalar.
/// @param p_end The pointer to the past-the-end element of the scalar.
/// @param i The output integer value holder.
/// @return true if the conversion completes successfully, false otherwise.
template <typename IntType>
inline bool atoi_dec_neg(const char* p_begin, const char* p_end, IntType& i) noexcept {
    static_assert(
        is_non_bool_integral<IntType>::value, "atoi_dec_neg() accepts non-boolean integral types as an output type");

    if FK_YAML_UNLIKELY (p_begin == p_end) {
        return false;
    }

    using conv_limits_type = conv_limits<sizeof(IntType), std::is_signed<IntType>::value>;

    const auto len = static_cast<std::size_t>(p_end - p_begin);
    if FK_YAML_UNLIKELY (len > conv_limits_type::max_chars_dec) {
        // Underflow will happen.
        return false;
    }

    if (len == conv_limits_type::max_chars_dec) {
        const char* p_min_value_chars_dec = conv_limits_type::min_value_chars_dec();

        for (std::size_t idx = 0; idx < conv_limits_type::max_chars_dec; idx++) {
            if (p_begin[idx] < p_min_value_chars_dec[idx]) {
                // No need to check the lower digits. Underflow will no longer happen.
                break;
            }

            if FK_YAML_UNLIKELY (p_begin[idx] > p_min_value_chars_dec[idx]) {
                // Underflow will happen.
                return false;
            }
        }
    }

    return atoi_dec_unchecked(p_begin, p_end, i);
}

//
// scalar --> octals
//

/// @brief Converts a scalar into octals. This function executes bounds check to avoid overflow.
/// @warning `p_begin` and `p_end` must not be null. Validate them before calling this function.
/// @tparam IntType The output integer type. It can be either signed or unsigned.
/// @param p_begin The pointer to the first element of the scalar.
/// @param p_end The pointer to the past-the-end element of the scalar.
/// @param i The output integer value holder.
/// @return true if the conversion completes successfully, false otherwise.
template <typename IntType>
inline bool atoi_oct(const char* p_begin, const char* p_end, IntType& i) noexcept {
    static_assert(
        is_non_bool_integral<IntType>::value, "atoi_oct() accepts non-boolean integral types as an output type");

    if FK_YAML_UNLIKELY (p_begin == p_end) {
        return false;
    }

    using conv_limits_type = conv_limits<sizeof(IntType), std::is_signed<IntType>::value>;

    const auto len = static_cast<std::size_t>(p_end - p_begin);
    if FK_YAML_UNLIKELY (!conv_limits_type::check_if_octs_safe(p_begin, len)) {
        return false;
    }

    i = 0;
    do {
        const char c = *p_begin;
        if FK_YAML_UNLIKELY (c < '0' || '7' < c) {
            return false;
        }
        i = i * static_cast<IntType>(8) + static_cast<IntType>(c - '0');
    } while (++p_begin != p_end);

    return true;
}

//
// scalar --> hexadecimals
//

/// @brief Converts a scalar into hexadecimals. This function executes bounds check to avoid overflow.
/// @warning `p_begin` and `p_end` must not be null. Validate them before calling this function.
/// @tparam IntType The output integer type. It can be either signed or unsigned.
/// @param p_begin The pointer to the first element of the scalar.
/// @param p_end The pointer to the past-the-end element of the scalar.
/// @param i The output integer value holder.
/// @return true if the conversion completes successfully, false otherwise.
template <typename IntType>
inline bool atoi_hex(const char* p_begin, const char* p_end, IntType& i) noexcept {
    static_assert(
        is_non_bool_integral<IntType>::value, "atoi_hex() accepts non-boolean integral types as an output type");

    if FK_YAML_UNLIKELY (p_begin == p_end) {
        return false;
    }

    using conv_limits_type = conv_limits<sizeof(IntType), std::is_signed<IntType>::value>;

    const auto len = static_cast<std::size_t>(p_end - p_begin);
    if FK_YAML_UNLIKELY (!conv_limits_type::check_if_hexs_safe(p_begin, len)) {
        return false;
    }

    i = 0;
    do {
        // NOLINTBEGIN(bugprone-misplaced-widening-cast)
        const char c = *p_begin;
        IntType ci = 0;
        if ('0' <= c && c <= '9') {
            ci = static_cast<IntType>(c - '0');
        }
        else if ('A' <= c && c <= 'F') {
            ci = static_cast<IntType>(c - 'A' + 10);
        }
        else if ('a' <= c && c <= 'f') {
            ci = static_cast<IntType>(c - 'a' + 10);
        }
        else {
            return false;
        }
        i = i * static_cast<IntType>(16) + ci;
        // NOLINTEND(bugprone-misplaced-widening-cast)
    } while (++p_begin != p_end);

    return true;
}

//
// atoi() & itoa()
//

/// @brief Converts a scalar into integers. This function executes bounds check to avoid overflow/underflow.
/// @tparam CharItr The type of char iterators. Its value type must be char (maybe cv-qualified).
/// @tparam IntType The output integer type. It can be either signed or unsigned.
/// @param begin The iterator to the first element of the scalar.
/// @param end The iterator to the past-the-end element of the scalar.
/// @param i The output integer value holder.
/// @return true if the conversion completes successfully, false otherwise.
template <typename CharItr, typename IntType>
inline bool atoi(CharItr begin, CharItr end, IntType& i) noexcept {
    static_assert(is_iterator_of<CharItr, char>::value, "atoi() accepts iterators for char type");
    static_assert(is_non_bool_integral<IntType>::value, "atoi() accepts non-boolean integral types as an output type");

    if FK_YAML_UNLIKELY (begin == end) {
        return false;
    }

    const auto len = static_cast<uint32_t>(std::distance(begin, end));
    const char* p_begin = &*begin;
    const char* p_end = p_begin + len;

    const char first = *begin;
    if (first == '+') {
        return atoi_dec_pos(p_begin + 1, p_end, i);
    }

    if (first == '-') {
        if (!std::numeric_limits<IntType>::is_signed) {
            return false;
        }

        const bool success = atoi_dec_neg(p_begin + 1, p_end, i);
        if (success) {
            i *= static_cast<IntType>(-1);
        }

        return success;
    }

    if (first != '0') {
        return atoi_dec_pos(p_begin, p_end, i);
    }

    if (p_begin + 1 != p_end) {
        switch (*(p_begin + 1)) {
        case 'o':
            return atoi_oct(p_begin + 2, p_end, i);
        case 'x':
            return atoi_hex(p_begin + 2, p_end, i);
        default:
            // The YAML spec doesn't allow decimals starting with 0.
            return false;
        }
    }

    i = 0;
    return true;
}

///////////////////////////
//   scalar <--> float   //
///////////////////////////

/// @brief Set an infinite `float` value based on the given signedness.
/// @param f The output `float` value holder.
/// @param sign Whether the infinite value should be positive or negative.
inline void set_infinity(float& f, const float sign) noexcept {
    f = std::numeric_limits<float>::infinity() * sign;
}

/// @brief Set an infinite `double` value based on the given signedness.
/// @param f The output `double` value holder.
/// @param sign Whether the infinite value should be positive or negative.
inline void set_infinity(double& f, const double sign) noexcept {
    f = std::numeric_limits<double>::infinity() * sign;
}

/// @brief Set a NaN `float` value.
/// @param f The output `float` value holder.
inline void set_nan(float& f) noexcept {
    f = std::nanf("");
}

/// @brief Set a NaN `double` value.
/// @param f The output `double` value holder.
inline void set_nan(double& f) noexcept {
    f = std::nan("");
}

#if FK_YAML_HAS_TO_CHARS

/// @brief Converts a scalar into a floating point value.
/// @warning `p_begin` and `p_end` must not be null. Validate them before calling this function.
/// @param p_begin The pointer to the first element of the scalar.
/// @param p_end The pointer to the past-the-end element of the scalar.
/// @param f The output floating point value holder.
/// @return true if the conversion completes successfully, false otherwise.
template <typename FloatType>
inline bool atof_impl(const char* p_begin, const char* p_end, FloatType& f) noexcept {
    static_assert(std::is_floating_point_v<FloatType>, "atof_impl() accepts floating point types as an output type");
    if (auto [ptr, ec] = std::from_chars(p_begin, p_end, f); ec == std::errc {}) {
        return ptr == p_end;
    }
    return false;
}

#else

/// @brief Converts a scalar into a `float` value.
/// @warning `p_begin` and `p_end` must not be null. Validate them before calling this function.
/// @param p_begin The pointer to the first element of the scalar.
/// @param p_end The pointer to the past-the-end element of the scalar.
/// @param f The output `float` value holder.
/// @return true if the conversion completes successfully, false otherwise.
inline bool atof_impl(const char* p_begin, const char* p_end, float& f) {
    std::size_t idx = 0;
    f = std::stof(std::string(p_begin, p_end), &idx);
    return idx == static_cast<std::size_t>(p_end - p_begin);
}

/// @brief Converts a scalar into a `double` value.
/// @warning `p_begin` and `p_end` must not be null. Validate them before calling this function.
/// @param p_begin The pointer to the first element of the scalar.
/// @param p_end The pointer to the past-the-end element of the scalar.
/// @param f The output `double` value holder.
/// @return true if the conversion completes successfully, false otherwise.
inline bool atof_impl(const char* p_begin, const char* p_end, double& f) {
    std::size_t idx = 0;
    f = std::stod(std::string(p_begin, p_end), &idx);
    return idx == static_cast<std::size_t>(p_end - p_begin);
}

#endif // FK_YAML_HAS_TO_CHARS

/// @brief Converts a scalar into a floating point value.
/// @tparam CharItr The type of char iterators. Its value type must be char (maybe cv-qualified).
/// @tparam FloatType The output floating point value type.
/// @param begin The iterator to the first element of the scalar.
/// @param end The iterator to the past-the-end element of the scalar.
/// @param f The output floating point value holder.
/// @return true if the conversion completes successfully, false otherwise.
template <typename CharItr, typename FloatType>
inline bool atof(CharItr begin, CharItr end, FloatType& f) noexcept(noexcept(atof_impl(&*begin, &*begin, f))) {
    static_assert(is_iterator_of<CharItr, char>::value, "atof() accepts iterators for char type");
    static_assert(std::is_floating_point<FloatType>::value, "atof() accepts floating point types as an output type");

    if FK_YAML_UNLIKELY (begin == end) {
        return false;
    }

    const auto len = static_cast<uint32_t>(std::distance(begin, end));
    const char* p_begin = &*begin;
    const char* p_end = p_begin + len;

    if (*p_begin == '-' || *p_begin == '+') {
        if (len == 5) {
            const char* p_from_second = p_begin + 1;
            const bool is_inf = (std::strncmp(p_from_second, ".inf", 4) == 0) ||
                                (std::strncmp(p_from_second, ".Inf", 4) == 0) ||
                                (std::strncmp(p_from_second, ".INF", 4) == 0);
            if (is_inf) {
                set_infinity(f, *p_begin == '-' ? static_cast<FloatType>(-1.) : static_cast<FloatType>(1.));
                return true;
            }
        }

        if (*p_begin == '+') {
            // Skip the positive sign since it's sometimes not recognized as part of float value.
            ++p_begin;
        }
    }
    else if (len == 4) {
        const bool is_inf = (std::strncmp(p_begin, ".inf", 4) == 0) || (std::strncmp(p_begin, ".Inf", 4) == 0) ||
                            (std::strncmp(p_begin, ".INF", 4) == 0);
        if (is_inf) {
            set_infinity(f, static_cast<FloatType>(1.));
            return true;
        }

        const bool is_nan = (std::strncmp(p_begin, ".nan", 4) == 0) || (std::strncmp(p_begin, ".NaN", 4) == 0) ||
                            (std::strncmp(p_begin, ".NAN", 4) == 0);
        if (is_nan) {
            set_nan(f);
            return true;
        }
    }

#if FK_YAML_HAS_TO_CHARS
    return atof_impl(p_begin, p_end, f);
#else
    bool success = false;
    try {
        success = atof_impl(p_begin, p_end, f);
    }
    catch (const std::exception& /*unused*/) {
        success = false;
    }

    return success;
#endif
}

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_CONVERSIONS_SCALAR_CONV_HPP */

// #include <fkYAML/detail/encodings/yaml_escaper.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_ENCODINGS_YAML_ESCAPER_HPP
#define FK_YAML_DETAIL_ENCODINGS_YAML_ESCAPER_HPP

#include <string>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/assert.hpp>

// #include <fkYAML/detail/encodings/utf_encodings.hpp>

// #include <fkYAML/exception.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

class yaml_escaper {
    using iterator = ::std::string::const_iterator;

public:
    static bool unescape(const char*& begin, const char* end, std::string& buff) {
        FK_YAML_ASSERT(*begin == '\\' && std::distance(begin, end) > 0);
        bool ret = true;

        switch (*++begin) {
        case 'a':
            buff.push_back('\a');
            break;
        case 'b':
            buff.push_back('\b');
            break;
        case 't':
        case '\t':
            buff.push_back('\t');
            break;
        case 'n':
            buff.push_back('\n');
            break;
        case 'v':
            buff.push_back('\v');
            break;
        case 'f':
            buff.push_back('\f');
            break;
        case 'r':
            buff.push_back('\r');
            break;
        case 'e':
            buff.push_back(static_cast<char>(0x1B));
            break;
        case ' ':
            buff.push_back(' ');
            break;
        case '\"':
            buff.push_back('\"');
            break;
        case '/':
            buff.push_back('/');
            break;
        case '\\':
            buff.push_back('\\');
            break;
        case 'N': // next line
            unescape_escaped_unicode(0x85u, buff);
            break;
        case '_': // non-breaking space
            unescape_escaped_unicode(0xA0u, buff);
            break;
        case 'L': // line separator
            unescape_escaped_unicode(0x2028u, buff);
            break;
        case 'P': // paragraph separator
            unescape_escaped_unicode(0x2029u, buff);
            break;
        case 'x': {
            char32_t codepoint {0};
            ret = extract_codepoint(begin, end, 1, codepoint);
            if FK_YAML_LIKELY (ret) {
                unescape_escaped_unicode(codepoint, buff);
            }
            break;
        }
        case 'u': {
            char32_t codepoint {0};
            ret = extract_codepoint(begin, end, 2, codepoint);
            if FK_YAML_LIKELY (ret) {
                unescape_escaped_unicode(codepoint, buff);
            }
            break;
        }
        case 'U': {
            char32_t codepoint {0};
            ret = extract_codepoint(begin, end, 4, codepoint);
            if FK_YAML_LIKELY (ret) {
                unescape_escaped_unicode(codepoint, buff);
            }
            break;
        }
        default:
            // Unsupported escape sequence is found in a string token.
            ret = false;
            break;
        }

        return ret;
    }

    static ::std::string escape(const char* begin, const char* end, bool& is_escaped) {
        ::std::string escaped {};
        escaped.reserve(std::distance(begin, end));
        for (; begin != end; ++begin) {
            switch (*begin) {
            case 0x01:
                escaped += "\\u0001";
                is_escaped = true;
                break;
            case 0x02:
                escaped += "\\u0002";
                is_escaped = true;
                break;
            case 0x03:
                escaped += "\\u0003";
                is_escaped = true;
                break;
            case 0x04:
                escaped += "\\u0004";
                is_escaped = true;
                break;
            case 0x05:
                escaped += "\\u0005";
                is_escaped = true;
                break;
            case 0x06:
                escaped += "\\u0006";
                is_escaped = true;
                break;
            case '\a':
                escaped += "\\a";
                is_escaped = true;
                break;
            case '\b':
                escaped += "\\b";
                is_escaped = true;
                break;
            case '\t':
                escaped += "\\t";
                is_escaped = true;
                break;
            case '\n':
                escaped += "\\n";
                is_escaped = true;
                break;
            case '\v':
                escaped += "\\v";
                is_escaped = true;
                break;
            case '\f':
                escaped += "\\f";
                is_escaped = true;
                break;
            case '\r':
                escaped += "\\r";
                is_escaped = true;
                break;
            case 0x0E:
                escaped += "\\u000E";
                is_escaped = true;
                break;
            case 0x0F:
                escaped += "\\u000F";
                is_escaped = true;
                break;
            case 0x10:
                escaped += "\\u0010";
                is_escaped = true;
                break;
            case 0x11:
                escaped += "\\u0011";
                is_escaped = true;
                break;
            case 0x12:
                escaped += "\\u0012";
                is_escaped = true;
                break;
            case 0x13:
                escaped += "\\u0013";
                is_escaped = true;
                break;
            case 0x14:
                escaped += "\\u0014";
                is_escaped = true;
                break;
            case 0x15:
                escaped += "\\u0015";
                is_escaped = true;
                break;
            case 0x16:
                escaped += "\\u0016";
                is_escaped = true;
                break;
            case 0x17:
                escaped += "\\u0017";
                is_escaped = true;
                break;
            case 0x18:
                escaped += "\\u0018";
                is_escaped = true;
                break;
            case 0x19:
                escaped += "\\u0019";
                is_escaped = true;
                break;
            case 0x1A:
                escaped += "\\u001A";
                is_escaped = true;
                break;
            case 0x1B:
                escaped += "\\e";
                is_escaped = true;
                break;
            case 0x1C:
                escaped += "\\u001C";
                is_escaped = true;
                break;
            case 0x1D:
                escaped += "\\u001D";
                is_escaped = true;
                break;
            case 0x1E:
                escaped += "\\u001E";
                is_escaped = true;
                break;
            case 0x1F:
                escaped += "\\u001F";
                is_escaped = true;
                break;
            case '\"':
                escaped += "\\\"";
                is_escaped = true;
                break;
            case '\\':
                escaped += "\\\\";
                is_escaped = true;
                break;
            default:
                const std::ptrdiff_t diff = static_cast<int>(std::distance(begin, end));
                if (diff > 1) {
                    if (*begin == static_cast<char>(0xC2u) && *(begin + 1) == static_cast<char>(0x85u)) {
                        escaped += "\\N";
                        std::advance(begin, 1);
                        is_escaped = true;
                        break;
                    }
                    if (*begin == static_cast<char>(0xC2u) && *(begin + 1) == static_cast<char>(0xA0u)) {
                        escaped += "\\_";
                        std::advance(begin, 1);
                        is_escaped = true;
                        break;
                    }

                    if (diff > 2) {
                        if (*begin == static_cast<char>(0xE2u) && *(begin + 1) == static_cast<char>(0x80u) &&
                            *(begin + 2) == static_cast<char>(0xA8u)) {
                            escaped += "\\L";
                            std::advance(begin, 2);
                            is_escaped = true;
                            break;
                        }
                        if (*begin == static_cast<char>(0xE2u) && *(begin + 1) == static_cast<char>(0x80u) &&
                            *(begin + 2) == static_cast<char>(0xA9u)) {
                            escaped += "\\P";
                            std::advance(begin, 2);
                            is_escaped = true;
                            break;
                        }
                    }
                }
                escaped += *begin;
                break;
            }
        }
        return escaped;
    } // LCOV_EXCL_LINE

private:
    static bool convert_hexchar_to_byte(char source, uint8_t& byte) {
        if ('0' <= source && source <= '9') {
            // NOLINTNEXTLINE(bugprone-narrowing-conversions,cppcoreguidelines-narrowing-conversions)
            byte = static_cast<uint8_t>(source - '0');
            return true;
        }

        if ('A' <= source && source <= 'F') {
            // NOLINTNEXTLINE(bugprone-narrowing-conversions,cppcoreguidelines-narrowing-conversions)
            byte = static_cast<uint8_t>(source - 'A' + 10);
            return true;
        }

        if ('a' <= source && source <= 'f') {
            // NOLINTNEXTLINE(bugprone-narrowing-conversions,cppcoreguidelines-narrowing-conversions)
            byte = static_cast<uint8_t>(source - 'a' + 10);
            return true;
        }

        // The given character is not hexadecimal.
        return false;
    }

    static bool extract_codepoint(const char*& begin, const char* end, int bytes_to_read, char32_t& codepoint) {
        const bool has_enough_room = static_cast<int>(std::distance(begin, end)) >= (bytes_to_read - 1);
        if (!has_enough_room) {
            return false;
        }

        const int read_size = bytes_to_read * 2;
        uint8_t byte {0};
        codepoint = 0;

        for (int i = read_size - 1; i >= 0; i--) {
            const bool is_valid = convert_hexchar_to_byte(*++begin, byte);
            if (!is_valid) {
                return false;
            }
            // NOLINTNEXTLINE(bugprone-narrowing-conversions,cppcoreguidelines-narrowing-conversions)
            codepoint |= static_cast<char32_t>(byte << (4 * i));
        }

        return true;
    }

    static void unescape_escaped_unicode(char32_t codepoint, std::string& buff) {
        // the inner curly braces are necessary to build with older compilers.
        std::array<uint8_t, 4> encode_buff {{}};
        uint32_t encoded_size {0};
        utf8::from_utf32(codepoint, encode_buff, encoded_size);
        buff.append(reinterpret_cast<char*>(encode_buff.data()), encoded_size);
    }
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_ENCODINGS_YAML_ESCAPER_HPP */

// #include <fkYAML/detail/input/block_scalar_header.hpp>

// #include <fkYAML/detail/input/scalar_scanner.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_INPUT_SCALAR_SCANNER_HPP
#define FK_YAML_DETAIL_INPUT_SCALAR_SCANNER_HPP

#include <cstring>
#include <string>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/assert.hpp>

// #include <fkYAML/node_type.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief The class which detects a scalar value type by scanning contents.
class scalar_scanner {
public:
    /// @brief Detects a scalar value type by scanning the contents ranged by the given iterators.
    /// @param begin The iterator to the first element of the scalar.
    /// @param end The iterator to the past-the-end element of the scalar.
    /// @return A detected scalar value type.
    static node_type scan(const char* begin, const char* end) noexcept {
        if (begin == end) {
            return node_type::STRING;
        }

        const auto len = static_cast<uint32_t>(std::distance(begin, end));
        if (len > 5) {
            return scan_possible_number_token(begin, len);
        }

        const char* p_begin = &*begin;

        switch (len) {
        case 1:
            if (*p_begin == '~') {
                return node_type::NULL_OBJECT;
            }
            break;
        case 4:
            switch (*p_begin) {
            case 'n':
                // no possible case of begin a number otherwise.
                return (std::strncmp(p_begin + 1, "ull", 3) == 0) ? node_type::NULL_OBJECT : node_type::STRING;
            case 'N':
                // no possible case of begin a number otherwise.
                return ((std::strncmp(p_begin + 1, "ull", 3) == 0) || (std::strncmp(p_begin + 1, "ULL", 3) == 0))
                           ? node_type::NULL_OBJECT
                           : node_type::STRING;
            case 't':
                // no possible case of being a number otherwise.
                return (std::strncmp(p_begin + 1, "rue", 3) == 0) ? node_type::BOOLEAN : node_type::STRING;
            case 'T':
                // no possible case of being a number otherwise.
                return ((std::strncmp(p_begin + 1, "rue", 3) == 0) || (std::strncmp(p_begin + 1, "RUE", 3) == 0))
                           ? node_type::BOOLEAN
                           : node_type::STRING;
            case '.': {
                const char* p_from_second = p_begin + 1;
                const bool is_inf_or_nan_scalar =
                    (std::strncmp(p_from_second, "inf", 3) == 0) || (std::strncmp(p_from_second, "Inf", 3) == 0) ||
                    (std::strncmp(p_from_second, "INF", 3) == 0) || (std::strncmp(p_from_second, "nan", 3) == 0) ||
                    (std::strncmp(p_from_second, "NaN", 3) == 0) || (std::strncmp(p_from_second, "NAN", 3) == 0);
                if (is_inf_or_nan_scalar) {
                    return node_type::FLOAT;
                }
                // maybe a number.
                break;
            }
            default:
                break;
            }
            break;
        case 5:
            switch (*p_begin) {
            case 'f':
                // no possible case of being a number otherwise.
                return (std::strncmp(p_begin + 1, "alse", 4) == 0) ? node_type::BOOLEAN : node_type::STRING;
            case 'F':
                // no possible case of being a number otherwise.
                return ((std::strncmp(p_begin + 1, "alse", 4) == 0) || (std::strncmp(p_begin + 1, "ALSE", 4) == 0))
                           ? node_type::BOOLEAN
                           : node_type::STRING;
            case '+':
            case '-':
                if (*(p_begin + 1) == '.') {
                    const char* p_from_third = p_begin + 2;
                    const bool is_min_inf = (std::strncmp(p_from_third, "inf", 3) == 0) ||
                                            (std::strncmp(p_from_third, "Inf", 3) == 0) ||
                                            (std::strncmp(p_from_third, "INF", 3) == 0);
                    if (is_min_inf) {
                        return node_type::FLOAT;
                    }
                }
                // maybe a number.
                break;
            default:
                break;
            }
            break;
        default:
            break;
        }

        return scan_possible_number_token(begin, len);
    }

private:
    /// @brief Detects a scalar value type from the contents (possibly an integer or a floating-point value).
    /// @param itr The iterator to the first element of the scalar.
    /// @param len The length of the scalar contents.
    /// @return A detected scalar value type.
    static node_type scan_possible_number_token(const char* itr, uint32_t len) noexcept {
        FK_YAML_ASSERT(len > 0);

        switch (*itr) {
        case '-':
            return (len > 1) ? scan_negative_number(++itr, --len) : node_type::STRING;
        case '+':
            return (len > 1) ? scan_decimal_number(++itr, --len) : node_type::STRING;
        case '.':
            // some integer(s) required after the decimal point as a floating point value.
            return (len > 1) ? scan_after_decimal_point(++itr, --len) : node_type::STRING;
        case '0':
            return (len > 1) ? scan_after_zero_at_first(++itr, --len) : node_type::INTEGER;
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
            return (len > 1) ? scan_decimal_number(++itr, --len) : node_type::INTEGER;
        default:
            return node_type::STRING;
        }
    }

    /// @brief Detects a scalar value type by scanning the contents right after the negative sign.
    /// @param itr The iterator to the past-the-negative-sign element of the scalar.
    /// @param len The length of the scalar contents left unscanned.
    /// @return A detected scalar value type.
    static node_type scan_negative_number(const char* itr, uint32_t len) noexcept {
        FK_YAML_ASSERT(len > 0);

        if (is_digit(*itr)) {
            return (len > 1) ? scan_decimal_number(++itr, --len) : node_type::INTEGER;
        }

        if (*itr == '.') {
            // some integer(s) required after "-." as a floating point value.
            return (len > 1) ? scan_after_decimal_point(++itr, --len) : node_type::STRING;
        }

        return node_type::STRING;
    }

    /// @brief Detects a scalar value type by scanning the contents right after the beginning 0.
    /// @param itr The iterator to the past-the-zero element of the scalar.
    /// @param len The length of the scalar left unscanned.
    /// @return A detected scalar value type.
    static node_type scan_after_zero_at_first(const char* itr, uint32_t len) noexcept {
        FK_YAML_ASSERT(len > 0);

        if (is_digit(*itr)) {
            // a token consisting of the beginning '0' and some following numbers, e.g., `0123`, is not an integer
            // according to https://yaml.org/spec/1.2.2/#10213-integer.
            return node_type::STRING;
        }

        switch (*itr) {
        case '.':
            // 0 can be omitted after `0.`.
            return (len > 1) ? scan_after_decimal_point(++itr, --len) : node_type::FLOAT;
        case 'e':
        case 'E':
            // some integer(s) required after the exponent sign as a floating point value.
            return (len > 1) ? scan_after_exponent(++itr, --len) : node_type::STRING;
        case 'o':
            return (len > 1) ? scan_octal_number(++itr, --len) : node_type::STRING;
        case 'x':
            return (len > 1) ? scan_hexadecimal_number(++itr, --len) : node_type::STRING;
        default:
            return node_type::STRING;
        }
    }

    /// @brief Detects a scalar value type by scanning the contents part starting with a decimal.
    /// @param itr The iterator to the beginning decimal element of the scalar.
    /// @param len The length of the scalar left unscanned.
    /// @return A detected scalar value type.
    static node_type scan_decimal_number(const char* itr, uint32_t len) noexcept {
        FK_YAML_ASSERT(len > 0);

        if (is_digit(*itr)) {
            return (len > 1) ? scan_decimal_number(++itr, --len) : node_type::INTEGER;
        }

        switch (*itr) {
        case '.': {
            // 0 can be omitted after the decimal point
            return (len > 1) ? scan_after_decimal_point(++itr, --len) : node_type::FLOAT;
        }
        case 'e':
        case 'E':
            // some integer(s) required after the exponent
            return (len > 1) ? scan_after_exponent(++itr, --len) : node_type::STRING;
        default:
            return node_type::STRING;
        }
    }

    /// @brief Detects a scalar value type by scanning the contents right after a decimal point.
    /// @param itr The iterator to the past-the-decimal-point element of the scalar.
    /// @param len The length of the scalar left unscanned.
    /// @return A detected scalar value type.
    static node_type scan_after_decimal_point(const char* itr, uint32_t len) noexcept {
        FK_YAML_ASSERT(len > 0);

        for (uint32_t i = 0; i < len; i++) {
            const char c = *itr++;

            if (is_digit(c)) {
                continue;
            }

            if (c == 'e' || c == 'E') {
                if (i == len - 1) {
                    // some integer(s) required after the exponent
                    return node_type::STRING;
                }
                return scan_after_exponent(itr, len - i - 1);
            }

            return node_type::STRING;
        }

        return node_type::FLOAT;
    }

    /// @brief Detects a scalar value type by scanning the contents right after the exponent prefix ("e" or "E").
    /// @param itr The iterator to the past-the-exponent-prefix element of the scalar.
    /// @param len The length of the scalar left unscanned.
    /// @return A detected scalar value type.
    static node_type scan_after_exponent(const char* itr, uint32_t len) noexcept {
        FK_YAML_ASSERT(len > 0);

        const char c = *itr;
        if (c == '+' || c == '-') {
            if (len == 1) {
                // some integer(s) required after the sign.
                return node_type::STRING;
            }
            ++itr;
            --len;
        }

        for (uint32_t i = 0; i < len; i++) {
            if (!is_digit(*itr++)) {
                return node_type::STRING;
            }
        }

        return node_type::FLOAT;
    }

    /// @brief Detects a scalar value type by scanning the contents assuming octal numbers.
    /// @param itr The iterator to the octal-number element of the scalar.
    /// @param len The length of the scalar left unscanned.
    /// @return A detected scalar value type.
    static node_type scan_octal_number(const char* itr, uint32_t len) noexcept {
        FK_YAML_ASSERT(len > 0);

        switch (*itr) {
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
            return (len > 1) ? scan_octal_number(++itr, --len) : node_type::INTEGER;
        default:
            return node_type::STRING;
        }
    }

    /// @brief Detects a scalar value type by scanning the contents assuming hexadecimal numbers.
    /// @param itr The iterator to the hexadecimal-number element of the scalar.
    /// @param len The length of the scalar left unscanned.
    /// @return A detected scalar value type.
    static node_type scan_hexadecimal_number(const char* itr, uint32_t len) noexcept {
        FK_YAML_ASSERT(len > 0);

        if (is_xdigit(*itr)) {
            return (len > 1) ? scan_hexadecimal_number(++itr, --len) : node_type::INTEGER;
        }
        return node_type::STRING;
    }

    /// @brief Check if the given character is a digit.
    /// @note This function is needed to avoid assertion failures in `std::isdigit()` especially when compiled with
    /// MSVC.
    /// @param c A character to be checked.
    /// @return true if the given character is a digit, false otherwise.
    static bool is_digit(char c) {
        return ('0' <= c && c <= '9');
    }

    /// @brief Check if the given character is a hex-digit.
    /// @note This function is needed to avoid assertion failures in `std::isxdigit()` especially when compiled with
    /// MSVC.
    /// @param c A character to be checked.
    /// @return true if the given character is a hex-digit, false otherwise.
    static bool is_xdigit(char c) {
        return (('0' <= c && c <= '9') || ('A' <= c && c <= 'F') || ('a' <= c && c <= 'f'));
    }
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_INPUT_SCALAR_SCANNER_HPP */

// #include <fkYAML/detail/input/tag_t.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_INPUT_TAG_T_HPP
#define FK_YAML_DETAIL_INPUT_TAG_T_HPP

#include <cstdint>

// #include <fkYAML/detail/macros/define_macros.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Definition of YAML tag types.
enum class tag_t : std::uint8_t {
    NONE,            //!< Represents a non-specific tag "?".
    NON_SPECIFIC,    //!< Represents a non-specific tag "!".
    CUSTOM_TAG,      //!< Represents a custom tag
    SEQUENCE,        //!< Represents a sequence tag.
    MAPPING,         //!< Represents a mapping tag.
    NULL_VALUE,      //!< Represents a null value tag.
    BOOLEAN,         //!< Represents a boolean tag.
    INTEGER,         //!< Represents an integer type
    FLOATING_NUMBER, //!< Represents a floating point number tag.
    STRING,          //!< Represents a string tag.
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_INPUT_TAG_T_HPP */

// #include <fkYAML/detail/meta/node_traits.hpp>

// #include <fkYAML/detail/str_view.hpp>

// #include <fkYAML/detail/types/lexical_token_t.hpp>

// #include <fkYAML/exception.hpp>

// #include <fkYAML/node_type.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief A parser for YAML scalars.
/// @tparam BasicNodeType A type of the container for parsed YAML scalars.
template <typename BasicNodeType>
class scalar_parser {
    static_assert(is_basic_node<BasicNodeType>::value, "scalar_parser only accepts basic_node<...>");

public:
    using basic_node_type = BasicNodeType;

private:
    /** A type for boolean node values. */
    using boolean_type = typename basic_node_type::boolean_type;
    /** A type for integer node values. */
    using integer_type = typename basic_node_type::integer_type;
    /** A type for floating point node values. */
    using float_number_type = typename basic_node_type::float_number_type;
    /** A type for string node values. */
    using string_type = typename basic_node_type::string_type;

public:
    /// @brief Constructs a new scalar_parser object.
    /// @param line Current line.
    /// @param indent Current indentation.
    scalar_parser(uint32_t line, uint32_t indent) noexcept
        : m_line(line),
          m_indent(indent) {
    }

    /// @brief Destroys a scalar_parser object.
    ~scalar_parser() noexcept = default;

    // std::string's copy constructor/assignment operator may throw a exception.
    scalar_parser(const scalar_parser&) = default;
    scalar_parser& operator=(const scalar_parser&) = default;

    scalar_parser(scalar_parser&&) noexcept = default;
    scalar_parser& operator=(scalar_parser&&) noexcept(std::is_nothrow_move_assignable<std::string>::value) = default;

    /// @brief Parses a token into a flow scalar (either plain, single quoted or double quoted)
    /// @param lex_type Lexical token type for the scalar.
    /// @param tag_type Tag type for the scalar.
    /// @param token Scalar contents.
    /// @return Parsed YAML flow scalar object.
    basic_node_type parse_flow(lexical_token_t lex_type, tag_t tag_type, str_view token) {
        FK_YAML_ASSERT(
            lex_type == lexical_token_t::PLAIN_SCALAR || lex_type == lexical_token_t::SINGLE_QUOTED_SCALAR ||
            lex_type == lexical_token_t::DOUBLE_QUOTED_SCALAR);
        FK_YAML_ASSERT(tag_type != tag_t::SEQUENCE && tag_type != tag_t::MAPPING);

        token = parse_flow_scalar_token(lex_type, token);
        const node_type value_type = decide_value_type(lex_type, tag_type, token);
        return create_scalar_node(value_type, tag_type, token);
    }

    /// @brief Parses a token into a block scalar (either literal or folded)
    /// @param lex_type Lexical token type for the scalar.
    /// @param tag_type Tag type for the scalar.
    /// @param token Scalar contents.
    /// @param header Block scalar header information.
    /// @return Parsed YAML block scalar object.
    basic_node_type parse_block(
        lexical_token_t lex_type, tag_t tag_type, str_view token, const block_scalar_header& header) {
        FK_YAML_ASSERT(
            lex_type == lexical_token_t::BLOCK_LITERAL_SCALAR || lex_type == lexical_token_t::BLOCK_FOLDED_SCALAR);
        FK_YAML_ASSERT(tag_type != tag_t::SEQUENCE && tag_type != tag_t::MAPPING);

        if (lex_type == lexical_token_t::BLOCK_LITERAL_SCALAR) {
            token = parse_block_literal_scalar(token, header);
        }
        else {
            token = parse_block_folded_scalar(token, header);
        }

        const node_type value_type = decide_value_type(lex_type, tag_type, token);
        return create_scalar_node(value_type, tag_type, token);
    }

private:
    /// @brief Parses a token into a flow scalar contents.
    /// @param lex_type Lexical token type for the scalar.
    /// @param token Scalar contents.
    /// @return View into the parsed scalar contents.
    str_view parse_flow_scalar_token(lexical_token_t lex_type, str_view token) {
        switch (lex_type) {
        case lexical_token_t::PLAIN_SCALAR:
            token = parse_plain_scalar(token);
            break;
        case lexical_token_t::SINGLE_QUOTED_SCALAR:
            token = parse_single_quoted_scalar(token);
            break;
        case lexical_token_t::DOUBLE_QUOTED_SCALAR:
            token = parse_double_quoted_scalar(token);
            break;
        default:           // LCOV_EXCL_LINE
            unreachable(); // LCOV_EXCL_LINE
        }

        return token;
    }

    /// @brief Parses plain scalar contents.
    /// @param token Scalar contents.
    /// @return View into the parsed scalar contents.
    str_view parse_plain_scalar(str_view token) noexcept {
        // plain scalars cannot be empty.
        FK_YAML_ASSERT(!token.empty());

        std::size_t newline_pos = token.find('\n');
        if (newline_pos == str_view::npos) {
            return token;
        }

        m_use_owned_buffer = true;

        if (m_buffer.capacity() < token.size()) {
            m_buffer.reserve(token.size());
        }

        do {
            process_line_folding(token, newline_pos);
            newline_pos = token.find('\n');
        } while (newline_pos != str_view::npos);

        m_buffer.append(token.begin(), token.size());

        return {m_buffer};
    }

    /// @brief Parses single quoted scalar contents.
    /// @param token Scalar contents.
    /// @return View into the parsed scalar contents.
    str_view parse_single_quoted_scalar(str_view token) noexcept {
        if (token.empty()) {
            return token;
        }

        constexpr str_view filter {"\'\n"};
        std::size_t pos = token.find_first_of(filter);
        if (pos == str_view::npos) {
            return token;
        }

        m_use_owned_buffer = true;

        if (m_buffer.capacity() < token.size()) {
            m_buffer.reserve(token.size());
        }

        do {
            FK_YAML_ASSERT(pos < token.size());
            FK_YAML_ASSERT(token[pos] == '\'' || token[pos] == '\n');

            if (token[pos] == '\'') {
                // unescape escaped single quote. ('' -> ')
                FK_YAML_ASSERT(pos + 1 < token.size());
                m_buffer.append(token.begin(), token.begin() + (pos + 1));
                token.remove_prefix(pos + 2); // move next to the escaped single quote.
            }
            else {
                process_line_folding(token, pos);
            }

            pos = token.find_first_of(filter);
        } while (pos != str_view::npos);

        if (!token.empty()) {
            m_buffer.append(token.begin(), token.size());
        }

        return {m_buffer};
    }

    /// @brief Parses double quoted scalar contents.
    /// @param token Scalar contents.
    /// @return View into the parsed scalar contents.
    str_view parse_double_quoted_scalar(str_view token) {
        if (token.empty()) {
            return token;
        }

        constexpr str_view filter {"\\\n"};
        std::size_t pos = token.find_first_of(filter);
        if (pos == str_view::npos) {
            return token;
        }

        m_use_owned_buffer = true;

        if (m_buffer.capacity() < token.size()) {
            m_buffer.reserve(token.size());
        }

        do {
            FK_YAML_ASSERT(pos < token.size());
            FK_YAML_ASSERT(token[pos] == '\\' || token[pos] == '\n');

            if (token[pos] == '\\') {
                FK_YAML_ASSERT(pos + 1 < token.size());
                m_buffer.append(token.begin(), token.begin() + pos);

                if (token[pos + 1] != '\n') {
                    token.remove_prefix(pos);
                    const char* p_escape_begin = token.begin();
                    const bool is_valid_escaping = yaml_escaper::unescape(p_escape_begin, token.end(), m_buffer);
                    if FK_YAML_UNLIKELY (!is_valid_escaping) {
                        throw parse_error(
                            "Unsupported escape sequence is found in a double quoted scalar.", m_line, m_indent);
                    }

                    // `p_escape_begin` points to the last element of the escape sequence.
                    token.remove_prefix((p_escape_begin - token.begin()) + 1);
                }
                else {
                    std::size_t non_space_pos = token.find_first_not_of(" \t", pos + 2);
                    if (non_space_pos == str_view::npos) {
                        non_space_pos = token.size();
                    }
                    token.remove_prefix(non_space_pos);
                }
            }
            else {
                process_line_folding(token, pos);
            }

            pos = token.find_first_of(filter);
        } while (pos != str_view::npos);

        if (!token.empty()) {
            m_buffer.append(token.begin(), token.size());
        }

        return {m_buffer};
    }

    /// @brief Parses block literal scalar contents.
    /// @param token Scalar contents.
    /// @param header Block scalar header information.
    /// @return View into the parsed scalar contents.
    str_view parse_block_literal_scalar(str_view token, const block_scalar_header& header) {
        if FK_YAML_UNLIKELY (token.empty()) {
            return token;
        }

        m_use_owned_buffer = true;
        m_buffer.reserve(token.size());

        std::size_t cur_line_begin_pos = 0;
        do {
            bool has_newline_at_end = true;
            std::size_t cur_line_end_pos = token.find('\n', cur_line_begin_pos);
            if (cur_line_end_pos == str_view::npos) {
                has_newline_at_end = false;
                cur_line_end_pos = token.size();
            }

            const std::size_t line_size = cur_line_end_pos - cur_line_begin_pos;
            const str_view line = token.substr(cur_line_begin_pos, line_size);

            if (line.size() > header.indent) {
                m_buffer.append(line.begin() + header.indent, line.end());
            }

            if (!has_newline_at_end) {
                break;
            }

            m_buffer.push_back('\n');
            cur_line_begin_pos = cur_line_end_pos + 1;
        } while (cur_line_begin_pos < token.size());

        process_chomping(header.chomp);

        return {m_buffer};
    }

    /// @brief Parses block folded scalar contents.
    /// @param token Scalar contents.
    /// @param header Block scalar header information.
    /// @return View into the parsed scalar contents.
    str_view parse_block_folded_scalar(str_view token, const block_scalar_header& header) {
        if FK_YAML_UNLIKELY (token.empty()) {
            return token;
        }

        m_use_owned_buffer = true;
        m_buffer.reserve(token.size());

        constexpr str_view white_space_filter {" \t"};

        std::size_t cur_line_begin_pos = 0;
        bool has_newline_at_end = true;
        bool can_be_folded = false;
        do {
            std::size_t cur_line_end_pos = token.find('\n', cur_line_begin_pos);
            if (cur_line_end_pos == str_view::npos) {
                has_newline_at_end = false;
                cur_line_end_pos = token.size();
            }

            const std::size_t line_size = cur_line_end_pos - cur_line_begin_pos;
            const str_view line = token.substr(cur_line_begin_pos, line_size);
            const bool is_empty = line.find_first_not_of(white_space_filter) == str_view::npos;

            if (line.size() <= header.indent) {
                // A less-indented line is turned into a newline.
                m_buffer.push_back('\n');
                can_be_folded = false;
            }
            else if (is_empty) {
                // more-indented empty lines are not folded.
                m_buffer.push_back('\n');
                m_buffer.append(line.begin() + header.indent, line.end());
                m_buffer.push_back('\n');
            }
            else {
                const std::size_t non_space_pos = line.find_first_not_of(white_space_filter);
                const bool is_more_indented = (non_space_pos != str_view::npos) && (non_space_pos > header.indent);

                if (can_be_folded) {
                    if (is_more_indented) {
                        // The content line right before more-indented lines is not folded.
                        m_buffer.push_back('\n');
                    }
                    else {
                        m_buffer.push_back(' ');
                    }

                    can_be_folded = false;
                }

                m_buffer.append(line.begin() + header.indent, line.end());

                if (is_more_indented && has_newline_at_end) {
                    // more-indented lines are not folded.
                    m_buffer.push_back('\n');
                }
                else {
                    can_be_folded = true;
                }
            }

            if (!has_newline_at_end) {
                break;
            }

            cur_line_begin_pos = cur_line_end_pos + 1;
        } while (cur_line_begin_pos < token.size());

        if (has_newline_at_end && can_be_folded) {
            // The final content line break are not folded.
            m_buffer.push_back('\n');
        }

        process_chomping(header.chomp);

        return {m_buffer};
    }

    /// @brief Discards final content line break and trailing empty lines depending on the given chomping type.
    /// @param chomp Chomping method type.
    void process_chomping(chomping_indicator_t chomp) {
        switch (chomp) {
        case chomping_indicator_t::STRIP: {
            const std::size_t content_end_pos = m_buffer.find_last_not_of('\n');
            if (content_end_pos == std::string::npos) {
                // if the scalar has no content line, all lines are considered as trailing empty lines.
                m_buffer.clear();
                break;
            }

            if (content_end_pos == m_buffer.size() - 1) {
                // no last content line break nor trailing empty lines.
                break;
            }

            // remove the last content line break and all trailing empty lines.
            m_buffer.erase(content_end_pos + 1);

            break;
        }
        case chomping_indicator_t::CLIP: {
            const std::size_t content_end_pos = m_buffer.find_last_not_of('\n');
            if (content_end_pos == std::string::npos) {
                // if the scalar has no content line, all lines are considered as trailing empty lines.
                m_buffer.clear();
                break;
            }

            if (content_end_pos == m_buffer.size() - 1) {
                // no trailing empty lines
                break;
            }

            // remove all trailing empty lines.
            m_buffer.erase(content_end_pos + 2);

            break;
        }
        case chomping_indicator_t::KEEP:
            break;
        }
    }

    /// @brief Applies line folding to flow scalar contents.
    /// @param token Flow scalar contents.
    /// @param newline_pos Position of the target newline code.
    void process_line_folding(str_view& token, std::size_t newline_pos) noexcept {
        // discard trailing white spaces which precedes the line break in the current line.
        const std::size_t last_non_space_pos = token.substr(0, newline_pos + 1).find_last_not_of(" \t");
        if (last_non_space_pos == str_view::npos) {
            m_buffer.append(token.begin(), newline_pos);
        }
        else {
            m_buffer.append(token.begin(), last_non_space_pos + 1);
        }
        token.remove_prefix(newline_pos + 1); // move next to the LF

        uint32_t empty_line_counts = 0;
        do {
            const std::size_t non_space_pos = token.find_first_not_of(" \t");
            if (non_space_pos == str_view::npos) {
                // Line folding ignores trailing spaces.
                token.remove_prefix(token.size());
                break;
            }
            if (token[non_space_pos] != '\n') {
                token.remove_prefix(non_space_pos);
                break;
            }

            token.remove_prefix(non_space_pos + 1);
            ++empty_line_counts;
        } while (true);

        if (empty_line_counts > 0) {
            m_buffer.append(empty_line_counts, '\n');
        }
        else {
            m_buffer.push_back(' ');
        }
    }

    /// @brief Decides scalar value type based on the lexical/tag types and scalar contents.
    /// @param lex_type Lexical token type for the scalar.
    /// @param tag_type Tag type for the scalar.
    /// @param token Scalar contents.
    /// @return Scalar value type.
    node_type decide_value_type(lexical_token_t lex_type, tag_t tag_type, str_view token) const noexcept {
        node_type value_type {node_type::STRING};
        if (lex_type == lexical_token_t::PLAIN_SCALAR) {
            value_type = scalar_scanner::scan(token.begin(), token.end());
        }

        switch (tag_type) {
        case tag_t::NULL_VALUE:
            value_type = node_type::NULL_OBJECT;
            break;
        case tag_t::BOOLEAN:
            value_type = node_type::BOOLEAN;
            break;
        case tag_t::INTEGER:
            value_type = node_type::INTEGER;
            break;
        case tag_t::FLOATING_NUMBER:
            value_type = node_type::FLOAT;
            break;
        case tag_t::STRING:
        case tag_t::NON_SPECIFIC:
            // scalars with the non-specific tag is resolved to a string tag.
            // See the "Non-Specific Tags" section in https://yaml.org/spec/1.2.2/#691-node-tags.
            value_type = node_type::STRING;
            break;
        case tag_t::NONE:
        case tag_t::CUSTOM_TAG:
        default:
            break;
        }

        return value_type;
    }

    /// @brief Creates YAML scalar object based on the value type and contents.
    /// @param type Scalar value type.
    /// @param token Scalar contents.
    /// @return A YAML scalar object.
    basic_node_type create_scalar_node(node_type val_type, tag_t tag_type, str_view token) {
        switch (val_type) {
        case node_type::NULL_OBJECT: {
            std::nullptr_t null = nullptr;
            const bool converted = detail::aton(token.begin(), token.end(), null);
            if FK_YAML_UNLIKELY (!converted) {
                throw parse_error("Failed to convert a scalar to a null.", m_line, m_indent);
            }
            // The default basic_node object is a null scalar node.
            return basic_node_type {};
        }
        case node_type::BOOLEAN: {
            auto boolean = static_cast<boolean_type>(false);
            const bool converted = detail::atob(token.begin(), token.end(), boolean);
            if FK_YAML_UNLIKELY (!converted) {
                throw parse_error("Failed to convert a scalar to a boolean.", m_line, m_indent);
            }
            return basic_node_type(boolean);
        }
        case node_type::INTEGER: {
            integer_type integer = 0;
            const bool converted = detail::atoi(token.begin(), token.end(), integer);
            if FK_YAML_LIKELY (converted) {
                return basic_node_type(integer);
            }
            if FK_YAML_UNLIKELY (tag_type == tag_t::INTEGER) {
                throw parse_error("Failed to convert a scalar to an integer.", m_line, m_indent);
            }

            // conversion error from a scalar which is not tagged with !!int is recovered by treating it as a string
            // scalar. See https://github.com/fktn-k/fkYAML/issues/428.
            return basic_node_type(string_type(token.begin(), token.end()));
        }
        case node_type::FLOAT: {
            float_number_type float_val = 0;
            const bool converted = detail::atof(token.begin(), token.end(), float_val);
            if FK_YAML_LIKELY (converted) {
                return basic_node_type(float_val);
            }
            if FK_YAML_UNLIKELY (tag_type == tag_t::FLOATING_NUMBER) {
                throw parse_error("Failed to convert a scalar to a floating point value", m_line, m_indent);
            }

            // conversion error from a scalar which is not tagged with !!float is recovered by treating it as a string
            // scalar. See https://github.com/fktn-k/fkYAML/issues/428.
            return basic_node_type(string_type(token.begin(), token.end()));
        }
        case node_type::STRING:
            if (!m_use_owned_buffer) {
                return basic_node_type(string_type(token.begin(), token.end()));
            }
            m_use_owned_buffer = false;
            return basic_node_type(std::move(m_buffer));
        default:                   // LCOV_EXCL_LINE
            detail::unreachable(); // LCOV_EXCL_LINE
        }
    }

    /// Current line
    uint32_t m_line {0};
    /// Current indentation for the scalar
    uint32_t m_indent {0};
    /// Whether the parsed contents are stored in an owned buffer.
    bool m_use_owned_buffer {false};
    /// Owned buffer storage for parsing. This buffer is used when scalar contents need mutation.
    std::string m_buffer;
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_INPUT_SCALAR_PARSER_HPP */

// #include <fkYAML/detail/input/tag_resolver.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_INPUT_TAG_RESOLVER_HPP
#define FK_YAML_DETAIL_INPUT_TAG_RESOLVER_HPP

#include <memory>
#include <string>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/assert.hpp>

// #include <fkYAML/detail/document_metainfo.hpp>

// #include <fkYAML/detail/input/tag_t.hpp>

// #include <fkYAML/detail/meta/node_traits.hpp>

// #include <fkYAML/detail/str_view.hpp>

// #include <fkYAML/exception.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

static constexpr str_view default_primary_handle_prefix {"!"};
static constexpr str_view default_secondary_handle_prefix {"tag:yaml.org,2002:"};

template <typename BasicNodeType>
class tag_resolver {
    static_assert(is_basic_node<BasicNodeType>::value, "tag_resolver only accepts basic_node<...>.");
    using doc_metainfo_type = document_metainfo<BasicNodeType>;

public:
    /// @brief Resolve the input tag name into an expanded tag name prepended with a registered prefix.
    /// @param tag The input tag name.
    /// @return The type of a node deduced from the given tag name.
    static tag_t resolve_tag(const str_view tag, const std::shared_ptr<doc_metainfo_type>& directives) {
        const std::string normalized = normalize_tag_name(tag, directives);
        return convert_to_tag_type(normalized);
    }

private:
    static std::string normalize_tag_name(const str_view tag, const std::shared_ptr<doc_metainfo_type>& directives) {
        if FK_YAML_UNLIKELY (tag.empty()) {
            throw invalid_tag("tag must not be empty.", "");
        }
        if FK_YAML_UNLIKELY (tag[0] != '!') {
            throw invalid_tag("tag must start with \'!\'", std::string(tag.begin(), tag.end()).c_str());
        }

        if (tag.size() == 1) {
            // Non-specific tag ("!") will be interpreted as one of the following:
            //   * tag:yaml.org,2002:seq
            //   * tag:yaml.org,2002:map
            //   * tag:yaml.org,2002:str
            // See the "Non-Specific Tags" section in https://yaml.org/spec/1.2.2/#691-node-tags.
            // The interpretation cannot take place here because the input lacks the corresponding value.
            return {tag.begin(), tag.end()};
        }

        std::string normalized {"!<"};
        switch (tag[1]) {
        case '!': {
            // handle a secondary tag handle (!!suffix -> !<[secondary][suffix]>)
            const bool is_null_or_empty = !directives || directives->secondary_handle_prefix.empty();
            if (is_null_or_empty) {
                normalized.append(default_secondary_handle_prefix.begin(), default_secondary_handle_prefix.end());
            }
            else {
                normalized += directives->secondary_handle_prefix;
            }

            const str_view body = tag.substr(2);
            normalized.append(body.begin(), body.end());
            break;
        }
        case '<':
            if (tag[2] == '!') {
                const bool is_null_or_empty = !directives || directives->primary_handle_prefix.empty();
                if (is_null_or_empty) {
                    normalized.append(default_primary_handle_prefix.begin(), default_primary_handle_prefix.end());
                }
                else {
                    normalized += directives->primary_handle_prefix;
                }

                const str_view body = tag.substr(3);
                return normalized.append(body.begin(), body.end());
            }

            // verbatim tags must be delivered as-is to the application.
            // See https://yaml.org/spec/1.2.2/#691-node-tags for more details.
            return {tag.begin(), tag.end()};
        default: {
            const std::size_t tag_end_pos = tag.find_first_of('!', 1);

            // handle a named handle (!tag!suffix -> !<[tag][suffix]>)
            if (tag_end_pos != std::string::npos) {
                // there must be a non-empty suffix. (already checked by the lexer.)
                FK_YAML_ASSERT(tag_end_pos < tag.size() - 1);

                const bool is_null_or_empty = !directives || directives->named_handle_map.empty();
                if FK_YAML_UNLIKELY (is_null_or_empty) {
                    throw invalid_tag(
                        "named handle has not been registered.", std::string(tag.begin(), tag.end()).c_str());
                }

                // find the extracted named handle in the map.
                const str_view named_handle = tag.substr(0, tag_end_pos + 1);
                auto named_handle_itr = directives->named_handle_map.find({named_handle.begin(), named_handle.end()});
                auto end_itr = directives->named_handle_map.end();
                if FK_YAML_UNLIKELY (named_handle_itr == end_itr) {
                    throw invalid_tag(
                        "named handle has not been registered.", std::string(tag.begin(), tag.end()).c_str());
                }

                // The YAML spec prohibits expanding the percent-encoded characters (%xx -> a UTF-8 byte).
                // So no conversion takes place.
                // See https://yaml.org/spec/1.2.2/#56-miscellaneous-characters for more details.

                normalized += named_handle_itr->second;
                const str_view body = tag.substr(tag_end_pos + 1);
                normalized.append(body.begin(), body.end());
                break;
            }

            // handle a primary tag handle (!suffix -> !<[primary][suffix]>)
            const bool is_null_or_empty = !directives || directives->primary_handle_prefix.empty();
            if (is_null_or_empty) {
                normalized.append(default_primary_handle_prefix.begin(), default_primary_handle_prefix.end());
            }
            else {
                normalized += directives->primary_handle_prefix;
            }

            const str_view body = tag.substr(1);
            normalized.append(body.begin(), body.end());
            break;
        }
        }

        normalized += ">";
        return normalized;
    }

    static tag_t convert_to_tag_type(const std::string& normalized) {
        if (normalized == "!") {
            return tag_t::NON_SPECIFIC;
        }

        if (normalized.size() < 24 /* size of !<tag:yaml.org,2002:xxx */) {
            return tag_t::CUSTOM_TAG;
        }
        if (normalized.rfind("!<tag:yaml.org,2002:", 0) == std::string::npos) {
            return tag_t::CUSTOM_TAG;
        }

        if (normalized == "!<tag:yaml.org,2002:seq>") {
            return tag_t::SEQUENCE;
        }
        if (normalized == "!<tag:yaml.org,2002:map>") {
            return tag_t::MAPPING;
        }
        if (normalized == "!<tag:yaml.org,2002:null>") {
            return tag_t::NULL_VALUE;
        }
        if (normalized == "!<tag:yaml.org,2002:bool>") {
            return tag_t::BOOLEAN;
        }
        if (normalized == "!<tag:yaml.org,2002:int>") {
            return tag_t::INTEGER;
        }
        if (normalized == "!<tag:yaml.org,2002:float>") {
            return tag_t::FLOATING_NUMBER;
        }
        if (normalized == "!<tag:yaml.org,2002:str>") {
            return tag_t::STRING;
        }

        return tag_t::CUSTOM_TAG;
    }
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_INPUT_TAG_RESOLVER_HPP */

// #include <fkYAML/detail/meta/input_adapter_traits.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_META_INPUT_ADAPTER_TRAITS_HPP
#define FK_YAML_DETAIL_META_INPUT_ADAPTER_TRAITS_HPP

#include <type_traits>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/detect.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

///////////////////////////////////////////
//   Input Adapter API detection traits
///////////////////////////////////////////

/// @brief A type which represents get_buffer_view function.
/// @tparam T A target type.
template <typename T>
using get_buffer_view_fn_t = decltype(std::declval<T>().get_buffer_view());

/// @brief Type traits to check if InputAdapterType has get_buffer_view member function.
/// @tparam InputAdapterType An input adapter type to check if it has get_buffer_view function.
/// @tparam typename N/A
template <typename InputAdapterType>
using has_get_buffer_view = is_detected<get_buffer_view_fn_t, InputAdapterType>;

////////////////////////////////
//   is_input_adapter traits
////////////////////////////////

/// @brief Type traits to check if T is an input adapter type.
/// @tparam T A target type.
/// @tparam typename N/A
template <typename T, typename = void>
struct is_input_adapter : std::false_type {};

/// @brief A partial specialization of is_input_adapter if T is an input adapter type.
/// @tparam InputAdapterType
template <typename InputAdapterType>
struct is_input_adapter<InputAdapterType, enable_if_t<has_get_buffer_view<InputAdapterType>::value>> : std::true_type {
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_META_INPUT_ADAPTER_TRAITS_HPP */

// #include <fkYAML/detail/meta/node_traits.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/node_attrs.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_NODE_ATTRS_HPP
#define FK_YAML_DETAIL_NODE_ATTRS_HPP

#include <cstdint>
#include <limits>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/node_type.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief The type for node attribute bits.
using node_attr_t = uint32_t;

/// @brief The namespace to define bit masks for node attribute bits.
namespace node_attr_mask {

/// The bit mask for node value type bits.
constexpr node_attr_t value = 0x0000FFFFu;
/// The bit mask for node style type bits. (bits are not yet defined.)
constexpr node_attr_t style = 0x00FF0000u;
/// The bit mask for node property related bits.
constexpr node_attr_t props = 0xFF000000u;
/// The bit mask for anchor/alias node type bits.
constexpr node_attr_t anchoring = 0x03000000u;
/// The bit mask for anchor offset value bits.
constexpr node_attr_t anchor_offset = 0xFC000000u;
/// The bit mask for all the bits for node attributes.
constexpr node_attr_t all = std::numeric_limits<node_attr_t>::max();

} // namespace node_attr_mask

/// @brief The namespace to define bits for node attributes.
namespace node_attr_bits {

/// The sequence node bit.
constexpr node_attr_t seq_bit = 1u << 0;
/// The mapping node bit.
constexpr node_attr_t map_bit = 1u << 1;
/// The null scalar node bit.
constexpr node_attr_t null_bit = 1u << 2;
/// The boolean scalar node bit.
constexpr node_attr_t bool_bit = 1u << 3;
/// The integer scalar node bit.
constexpr node_attr_t int_bit = 1u << 4;
/// The floating point scalar node bit.
constexpr node_attr_t float_bit = 1u << 5;
/// The string scalar node bit.
constexpr node_attr_t string_bit = 1u << 6;

/// A utility bit set to filter scalar node bits.
constexpr node_attr_t scalar_bits = null_bit | bool_bit | int_bit | float_bit | string_bit;

/// The anchor node bit.
constexpr node_attr_t anchor_bit = 0x01000000u;
/// The alias node bit.
constexpr node_attr_t alias_bit = 0x02000000u;

/// A utility bit set for initialization.
constexpr node_attr_t default_bits = null_bit;

/// @brief Converts a node_type value to a node_attr_t value.
/// @param t A type of node value.
/// @return The associated node value bit.
inline node_attr_t from_node_type(node_type t) noexcept {
    switch (t) {
    case node_type::SEQUENCE:
        return seq_bit;
    case node_type::MAPPING:
        return map_bit;
    case node_type::NULL_OBJECT:
        return null_bit;
    case node_type::BOOLEAN:
        return bool_bit;
    case node_type::INTEGER:
        return int_bit;
    case node_type::FLOAT:
        return float_bit;
    case node_type::STRING:
        return string_bit;
    default:                        // LCOV_EXCL_LINE
        return node_attr_mask::all; // LCOV_EXCL_LINE
    }
}

/// @brief Converts a node_attr_t value to a node_type value.
/// @param bits node attribute bits
/// @return An associated node value type with the given node value bit.
inline node_type to_node_type(node_attr_t bits) noexcept {
    switch (bits & node_attr_mask::value) {
    case seq_bit:
        return node_type::SEQUENCE;
    case map_bit:
        return node_type::MAPPING;
    case null_bit:
        return node_type::NULL_OBJECT;
    case bool_bit:
        return node_type::BOOLEAN;
    case int_bit:
        return node_type::INTEGER;
    case float_bit:
        return node_type::FLOAT;
    case string_bit:
        return node_type::STRING;
    default:                   // LCOV_EXCL_LINE
        detail::unreachable(); // LCOV_EXCL_LINE
    }
}

/// @brief Get an anchor offset used to reference an anchor node from the given attribute bits.
/// @param attrs node attribute bits
/// @return An anchor offset value.
inline uint32_t get_anchor_offset(node_attr_t attrs) noexcept {
    return (attrs & node_attr_mask::anchor_offset) >> 26;
}

/// @brief Set an anchor offset value to the appropriate bits.
/// @param offset An anchor offset value.
/// @param attrs node attribute bit set into which the offset value is written.
inline void set_anchor_offset(uint32_t offset, node_attr_t& attrs) noexcept {
    attrs &= ~node_attr_mask::anchor_offset;
    attrs |= (offset & 0x3Fu) << 26;
}

} // namespace node_attr_bits

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_NODE_ATTRS_HPP */

// #include <fkYAML/detail/node_property.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_NODE_PROPERTY_HPP
#define FK_YAML_DETAIL_NODE_PROPERTY_HPP

#include <string>

// #include <fkYAML/detail/macros/define_macros.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

struct node_property {
    /// The tag name property.
    std::string tag {}; // NOLINT(readability-redundant-member-init) necessary for older compilers
    /// The anchor name property.
    std::string anchor {}; // NOLINT(readability-redundant-member-init) necessary for older compilers
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_NODE_PROPERTY_HPP */

// #include <fkYAML/detail/types/lexical_token_t.hpp>

// #include <fkYAML/exception.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief A class which provides the feature of deserializing YAML documents.
/// @tparam BasicNodeType A type of the container for deserialized YAML values.
template <typename BasicNodeType>
class basic_deserializer {
    static_assert(is_basic_node<BasicNodeType>::value, "basic_deserializer only accepts basic_node<...>");

    /** A type for the target basic_node. */
    using basic_node_type = BasicNodeType;
    /** A type for the lexical analyzer. */
    using lexer_type = lexical_analyzer;
    /** A type for the document metainfo. */
    using doc_metainfo_type = document_metainfo<basic_node_type>;
    /** A type for the tag resolver. */
    using tag_resolver_type = tag_resolver<basic_node_type>;
    /** A type for the scalar parser. */
    using scalar_parser_type = scalar_parser<basic_node_type>;
    /** A type for sequence node value containers. */
    using sequence_type = typename basic_node_type::sequence_type;
    /** A type for mapping node value containers. */
    using mapping_type = typename basic_node_type::mapping_type;

    /// @brief Definition of state types of parse contexts.
    enum class context_state_t : std::uint8_t {
        BLOCK_MAPPING,                //!< The underlying node is a block mapping.
        BLOCK_MAPPING_EXPLICIT_KEY,   //!< The underlying node is an explicit block mapping key.
        BLOCK_MAPPING_EXPLICIT_VALUE, //!< The underlying node is an explicit block mapping value.
        MAPPING_VALUE,                //!< The underlying node is a block mapping value.
        BLOCK_SEQUENCE,               //!< The underlying node is a block sequence.
        BLOCK_SEQUENCE_ENTRY,         //!< The underlying node is a block sequence entry.
        FLOW_SEQUENCE,                //!< The underlying node is a flow sequence.
        FLOW_SEQUENCE_KEY,            //!< The underlying node is a flow sequence as a key.
        FLOW_MAPPING,                 //!< The underlying node is a flow mapping.
        FLOW_MAPPING_KEY,             //!< The underlying node is a flow mapping as a key.
    };

    /// @brief Context information set for parsing.
    struct parse_context {
        /// @brief Construct a new parse_context object.
        parse_context() = default;

        /// @brief Construct a new parse_context object with non-default values for each parameter.
        /// @param line The current line. (count from zero)
        /// @param indent The indentation width in the current line. (count from zero)
        /// @param state The parse context type.
        /// @param p_node The underlying node associated to this context.
        parse_context(uint32_t line, uint32_t indent, context_state_t state, basic_node_type* p_node) noexcept
            : line(line),
              indent(indent),
              state(state),
              p_node(p_node) {
        }

        parse_context(const parse_context&) noexcept = default;
        parse_context& operator=(const parse_context&) noexcept = default;
        parse_context(parse_context&&) noexcept = default;
        parse_context& operator=(parse_context&&) noexcept = default;

        ~parse_context() {
            switch (state) {
            case context_state_t::BLOCK_MAPPING_EXPLICIT_KEY:
            case context_state_t::FLOW_SEQUENCE_KEY:
            case context_state_t::FLOW_MAPPING_KEY:
                delete p_node;
                p_node = nullptr;
                break;
            default:
                break;
            }
        }

        /// The current line. (count from zero)
        uint32_t line {0};
        /// The indentation width in the current line. (count from zero)
        uint32_t indent {0};
        /// The parse context type.
        context_state_t state {context_state_t::BLOCK_MAPPING};
        /// The pointer to the associated node to this context.
        basic_node_type* p_node {nullptr};
    };

    /// @brief Definitions of state types for expected flow token hints.
    enum class flow_token_state_t : std::uint8_t {
        NEEDS_VALUE_OR_SUFFIX,     //!< Either value or flow suffix (`]` or `}`)
        NEEDS_SEPARATOR_OR_SUFFIX, //!< Either separator (`,`) or flow suffix (`]` or `}`)
    };

public:
    /// @brief Construct a new basic_deserializer object.
    basic_deserializer() = default;

public:
    /// @brief Deserialize a single YAML document into a YAML node.
    /// @note
    /// If the input consists of multiple YAML documents, this function only parses the first.
    /// If the input may have multiple YAML documents all of which must be parsed into nodes,
    /// prefer the `deserialize_docs()` function.
    /// @tparam InputAdapterType The type of an input adapter object.
    /// @param input_adapter An input adapter object for the input source buffer.
    /// @return basic_node_type A root YAML node deserialized from the source string.
    template <typename InputAdapterType, enable_if_t<is_input_adapter<InputAdapterType>::value, int> = 0>
    basic_node_type deserialize(InputAdapterType&& input_adapter) { // NOLINT(cppcoreguidelines-missing-std-forward)
        const str_view input_view = input_adapter.get_buffer_view();
        lexer_type lexer(input_view);

        lexical_token_t type {lexical_token_t::END_OF_BUFFER};
        return deserialize_document(lexer, type);
    }

    /// @brief Deserialize multiple YAML documents into YAML nodes.
    /// @tparam InputAdapterType The type of an adapter object.
    /// @param input_adapter An input adapter object for the input source buffer.
    /// @return std::vector<basic_node_type> Root YAML nodes for deserialized YAML documents.
    template <typename InputAdapterType, enable_if_t<is_input_adapter<InputAdapterType>::value, int> = 0>
    // NOLINTNEXTLINE(cppcoreguidelines-missing-std-forward)
    std::vector<basic_node_type> deserialize_docs(InputAdapterType&& input_adapter) {
        const str_view input_view = input_adapter.get_buffer_view();
        lexer_type lexer(input_view);

        std::vector<basic_node_type> nodes {};
        lexical_token_t type {lexical_token_t::END_OF_BUFFER};

        do {
            nodes.emplace_back(deserialize_document(lexer, type));
        } while (type != lexical_token_t::END_OF_BUFFER);

        return nodes;
    } // LCOV_EXCL_LINE

private:
    /// @brief Deserialize a YAML document into a YAML node.
    /// @param lexer The lexical analyzer to be used.
    /// @param last_type The variable to store the last lexical token type.
    /// @return basic_node_type A root YAML node deserialized from the YAML document.
    basic_node_type deserialize_document(lexer_type& lexer, lexical_token_t& last_type) {
        lexical_token token {};

        basic_node_type root;
        mp_current_node = &root;
        mp_meta = root.mp_meta;

        // parse directives first.
        deserialize_directives(lexer, token);

        // parse node properties for root node if any
        uint32_t line = lexer.get_lines_processed();
        uint32_t indent = lexer.get_last_token_begin_pos();
        const bool found_props = deserialize_node_properties(lexer, token, line, indent);

        switch (token.type) {
        case lexical_token_t::SEQUENCE_BLOCK_PREFIX: {
            root = basic_node_type::sequence({basic_node_type()});
            apply_directive_set(root);
            if (found_props) {
                // If node properties are found before the block sequence entry prefix, the properties belong to the
                // root sequence node.
                apply_node_properties(root);
            }

            parse_context context(
                lexer.get_lines_processed(), lexer.get_last_token_begin_pos(), context_state_t::BLOCK_SEQUENCE, &root);
            m_context_stack.emplace_back(context);

            mp_current_node = &(root.as_seq().back());
            apply_directive_set(*mp_current_node);
            context.state = context_state_t::BLOCK_SEQUENCE_ENTRY;
            context.p_node = mp_current_node;
            m_context_stack.emplace_back(std::move(context));

            token = lexer.get_next_token();
            line = lexer.get_lines_processed();
            indent = lexer.get_last_token_begin_pos();
            break;
        }
        case lexical_token_t::SEQUENCE_FLOW_BEGIN:
            ++m_flow_context_depth;
            lexer.set_context_state(true);
            root = basic_node_type::sequence();
            apply_directive_set(root);
            apply_node_properties(root);
            m_context_stack.emplace_back(
                lexer.get_lines_processed(), lexer.get_last_token_begin_pos(), context_state_t::FLOW_SEQUENCE, &root);
            token = lexer.get_next_token();
            line = lexer.get_lines_processed();
            indent = lexer.get_last_token_begin_pos();
            break;
        case lexical_token_t::MAPPING_FLOW_BEGIN:
            ++m_flow_context_depth;
            lexer.set_context_state(true);
            root = basic_node_type::mapping();
            apply_directive_set(root);
            apply_node_properties(root);
            m_context_stack.emplace_back(
                lexer.get_lines_processed(), lexer.get_last_token_begin_pos(), context_state_t::FLOW_MAPPING, &root);
            token = lexer.get_next_token();
            line = lexer.get_lines_processed();
            indent = lexer.get_last_token_begin_pos();
            break;
        case lexical_token_t::EXPLICIT_KEY_PREFIX: {
            // If the explicit key prefix (? ) is detected here, the root node of current document must be a mapping.
            // Also, tag and anchor if any are associated to the root mapping node.
            // No get_next_token() call here to handle the token event in the deserialize_node() function.
            root = basic_node_type::mapping();
            apply_directive_set(root);
            apply_node_properties(root);
            parse_context context(
                lexer.get_lines_processed(), lexer.get_last_token_begin_pos(), context_state_t::BLOCK_MAPPING, &root);
            m_context_stack.emplace_back(std::move(context));
            line = lexer.get_lines_processed();
            indent = lexer.get_last_token_begin_pos();
            break;
        }
        case lexical_token_t::BLOCK_LITERAL_SCALAR:
        case lexical_token_t::BLOCK_FOLDED_SCALAR:
            // If a block scalar token is detected here, current document contains single scalar.
            // Do nothing here since the token is handled in the deserialize_node() function.
            break;
        case lexical_token_t::PLAIN_SCALAR:
        case lexical_token_t::SINGLE_QUOTED_SCALAR:
        case lexical_token_t::DOUBLE_QUOTED_SCALAR:
        case lexical_token_t::ALIAS_PREFIX:
            // Defer handling the above token events until the next call on the deserialize_scalar() function since the
            // meaning depends on subsequent events.
            if (found_props && line < lexer.get_lines_processed()) {
                // If node properties and a followed node are on the different line, the properties belong to the root
                // node.
                if (m_needs_anchor_impl) {
                    m_root_anchor_name = m_anchor_name;
                    m_needs_anchor_impl = false;
                    m_anchor_name = {};
                }

                if (m_needs_tag_impl) {
                    m_root_tag_name = m_tag_name;
                    m_needs_tag_impl = false;
                    m_tag_name = {};
                }

                line = lexer.get_lines_processed();
                indent = lexer.get_last_token_begin_pos();
            }
            break;
        default:
            // Do nothing since current document has no contents.
            break;
        }

        // parse YAML nodes recursively
        deserialize_node(lexer, token, line, indent, last_type);
        FK_YAML_ASSERT(
            last_type == lexical_token_t::END_OF_BUFFER || last_type == lexical_token_t::END_OF_DIRECTIVES ||
            last_type == lexical_token_t::END_OF_DOCUMENT);

        // reset parameters for the next call.
        mp_current_node = nullptr;
        mp_meta.reset();
        m_needs_tag_impl = false;
        m_needs_anchor_impl = false;
        m_flow_context_depth = 0;
        m_flow_token_state = flow_token_state_t::NEEDS_VALUE_OR_SUFFIX;
        m_context_stack.clear();

        return root;
    }

    /// @brief Deserializes the YAML directives if specified.
    /// @param lexer The lexical analyzer to be used.
    /// @param last_token Storage for last lexical token type.
    void deserialize_directives(lexer_type& lexer, lexical_token& last_token) {
        bool lacks_end_of_directives_marker = false;
        lexer.set_document_state(true);

        for (;;) {
            const lexical_token token = lexer.get_next_token();

            switch (token.type) {
            case lexical_token_t::YAML_VER_DIRECTIVE:
                if FK_YAML_UNLIKELY (mp_meta->is_version_specified) {
                    throw parse_error(
                        "YAML version cannot be specified more than once.",
                        lexer.get_lines_processed(),
                        lexer.get_last_token_begin_pos());
                }

                mp_meta->version = convert_yaml_version(lexer.get_yaml_version());
                mp_meta->is_version_specified = true;
                lacks_end_of_directives_marker = true;
                break;
            case lexical_token_t::TAG_DIRECTIVE: {
                const str_view tag_handle_view = lexer.get_tag_handle();
                switch (tag_handle_view.size()) {
                case 1 /* ! */: {
                    const bool is_already_specified = !mp_meta->primary_handle_prefix.empty();
                    if FK_YAML_UNLIKELY (is_already_specified) {
                        throw parse_error(
                            "Primary handle cannot be specified more than once.",
                            lexer.get_lines_processed(),
                            lexer.get_last_token_begin_pos());
                    }
                    const str_view tag_prefix = lexer.get_tag_prefix();
                    mp_meta->primary_handle_prefix.assign(tag_prefix.begin(), tag_prefix.end());
                    lacks_end_of_directives_marker = true;
                    break;
                }
                case 2 /* !! */: {
                    const bool is_already_specified = !mp_meta->secondary_handle_prefix.empty();
                    if FK_YAML_UNLIKELY (is_already_specified) {
                        throw parse_error(
                            "Secondary handle cannot be specified more than once.",
                            lexer.get_lines_processed(),
                            lexer.get_last_token_begin_pos());
                    }
                    const str_view tag_prefix = lexer.get_tag_prefix();
                    mp_meta->secondary_handle_prefix.assign(tag_prefix.begin(), tag_prefix.end());
                    lacks_end_of_directives_marker = true;
                    break;
                }
                default /* !<handle>! */: {
                    std::string tag_handle(tag_handle_view.begin(), tag_handle_view.end());
                    const str_view tag_prefix_view = lexer.get_tag_prefix();
                    std::string tag_prefix(tag_prefix_view.begin(), tag_prefix_view.end());
                    const bool is_already_specified =
                        !(mp_meta->named_handle_map.emplace(std::move(tag_handle), std::move(tag_prefix)).second);
                    if FK_YAML_UNLIKELY (is_already_specified) {
                        throw parse_error(
                            "The same named handle cannot be specified more than once.",
                            lexer.get_lines_processed(),
                            lexer.get_last_token_begin_pos());
                    }
                    lacks_end_of_directives_marker = true;
                    break;
                }
                }
                break;
            }
            case lexical_token_t::INVALID_DIRECTIVE:
                // TODO: should output a warning log. Currently just ignore this case.
                break;
            case lexical_token_t::END_OF_DIRECTIVES:
                lacks_end_of_directives_marker = false;
                break;
            default:
                if FK_YAML_UNLIKELY (lacks_end_of_directives_marker) {
                    throw parse_error(
                        "The end of directives marker (---) is missing after directives.",
                        lexer.get_lines_processed(),
                        lexer.get_last_token_begin_pos());
                }
                // end the parsing of directives if the other tokens are found.
                last_token = token;
                lexer.set_document_state(false);
                return;
            }
        }
    }

    /// @brief Deserializes the YAML nodes recursively.
    /// @param lexer The lexical analyzer to be used.
    /// @param first_type The first lexical token.
    /// @param last_type Storage for last lexical token type.
    void deserialize_node(
        lexer_type& lexer, const lexical_token& first_token, uint32_t first_line, uint32_t first_indent,
        lexical_token_t& last_type) {
        lexical_token token = first_token;
        uint32_t line = first_line;
        uint32_t indent = first_indent;

        do {
            switch (token.type) {
            case lexical_token_t::EXPLICIT_KEY_PREFIX: {
                const bool needs_to_move_back = indent == 0 || indent < m_context_stack.back().indent;
                if (needs_to_move_back) {
                    pop_to_parent_node(line, indent, [indent](const parse_context& c) {
                        return c.state == context_state_t::BLOCK_MAPPING && indent == c.indent;
                    });
                }

                switch (m_context_stack.back().state) {
                case context_state_t::MAPPING_VALUE:
                case context_state_t::BLOCK_MAPPING_EXPLICIT_KEY:
                case context_state_t::BLOCK_MAPPING_EXPLICIT_VALUE:
                case context_state_t::BLOCK_SEQUENCE_ENTRY:
                    // This path is needed in case the input contains nested explicit keys.
                    // ```yaml
                    // foo:
                    //   ? ? foo
                    //     : bar
                    //   : ? baz
                    //     : - ? qux
                    //         : 123
                    // ```
                    *mp_current_node = basic_node_type::mapping();
                    apply_directive_set(*mp_current_node);
                    m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_MAPPING, mp_current_node);
                    break;
                default:
                    break;
                }

                token = lexer.get_next_token();
                if (token.type == lexical_token_t::SEQUENCE_BLOCK_PREFIX) {
                    // heap-allocated node will be freed in handling the corresponding KEY_SEPARATOR event
                    auto* p_node = new basic_node_type(node_type::SEQUENCE);
                    m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_MAPPING_EXPLICIT_KEY, p_node);

                    apply_directive_set(*p_node);
                    parse_context context(
                        lexer.get_lines_processed(),
                        lexer.get_last_token_begin_pos(),
                        context_state_t::BLOCK_SEQUENCE,
                        p_node);
                    m_context_stack.emplace_back(context);

                    p_node->as_seq().emplace_back(basic_node_type());
                    mp_current_node = &(p_node->as_seq().back());
                    apply_directive_set(*mp_current_node);
                    context.state = context_state_t::BLOCK_SEQUENCE_ENTRY;
                    context.p_node = mp_current_node;
                    m_context_stack.emplace_back(std::move(context));

                    break;
                }

                // heap-allocated node will be freed in handling the corresponding KEY_SEPARATOR event
                m_context_stack.emplace_back(
                    line, indent, context_state_t::BLOCK_MAPPING_EXPLICIT_KEY, new basic_node_type());
                mp_current_node = m_context_stack.back().p_node;
                apply_directive_set(*mp_current_node);
                indent = lexer.get_last_token_begin_pos();
                line = lexer.get_lines_processed();

                continue;
            }
            case lexical_token_t::KEY_SEPARATOR: {
                FK_YAML_ASSERT(!m_context_stack.empty());
                if FK_YAML_UNLIKELY (m_context_stack.back().state == context_state_t::BLOCK_SEQUENCE_ENTRY) {
                    // empty mapping keys are not supported.
                    // ```yaml
                    // - : foo
                    // ```
                    throw parse_error("sequence key should not be empty.", line, indent);
                }

                if (m_flow_context_depth > 0) {
                    break;
                }

                // hold the line count of the key separator for later use.
                const uint32_t old_indent = indent;
                const uint32_t old_line = line;

                token = lexer.get_next_token();
                line = lexer.get_lines_processed();
                indent = lexer.get_last_token_begin_pos();

                const bool found_props = deserialize_node_properties(lexer, token, line, indent);
                if (found_props && line == lexer.get_lines_processed()) {
                    // defer applying node properties for the subsequent node on the same line.
                    continue;
                }

                line = lexer.get_lines_processed();
                indent = lexer.get_last_token_begin_pos();

                const bool is_implicit_same_line =
                    (line == old_line) && (m_context_stack.empty() || old_indent > m_context_stack.back().indent);
                if (is_implicit_same_line) {
                    // a key separator for an implicit key with its value on the same line.
                    continue;
                }

                if (line > old_line) {
                    if (m_needs_tag_impl) {
                        const tag_t tag_type = tag_resolver_type::resolve_tag(m_tag_name, mp_meta);
                        if (tag_type == tag_t::MAPPING || tag_type == tag_t::CUSTOM_TAG) {
                            // set YAML node properties here to distinguish them from those for the first key node
                            // as shown in the following snippet:
                            //
                            // ```yaml
                            // foo: !!map
                            //   !!str 123: true
                            //   ^
                            //   this !!str tag overwrites the preceding !!map tag.
                            // ```
                            *mp_current_node = basic_node_type::mapping();
                            apply_directive_set(*mp_current_node);
                            apply_node_properties(*mp_current_node);
                            m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_MAPPING, mp_current_node);
                            continue;
                        }
                    }

                    if (token.type == lexical_token_t::SEQUENCE_BLOCK_PREFIX) {
                        // a key separator preceding block sequence entries
                        *mp_current_node = basic_node_type::sequence({basic_node_type()});
                        apply_directive_set(*mp_current_node);
                        apply_node_properties(*mp_current_node);
                        auto& cur_context = m_context_stack.back();
                        cur_context.line = line;
                        cur_context.indent = indent;
                        cur_context.state = context_state_t::BLOCK_SEQUENCE;

                        mp_current_node = &(mp_current_node->as_seq().back());
                        apply_directive_set(*mp_current_node);
                        parse_context entry_context = cur_context;
                        entry_context.state = context_state_t::BLOCK_SEQUENCE_ENTRY;
                        entry_context.p_node = mp_current_node;
                        m_context_stack.emplace_back(std::move(entry_context));

                        token = lexer.get_next_token();
                        line = lexer.get_lines_processed();
                        indent = lexer.get_last_token_begin_pos();

                        const bool has_props = deserialize_node_properties(lexer, token, line, indent);
                        if (has_props) {
                            const uint32_t line_after_props = lexer.get_lines_processed();
                            if (line == line_after_props) {
                                // Skip updating the current indent to avoid stacking a wrong indentation.
                                //
                                // ```yaml
                                // &foo bar: baz
                                // ^
                                // the correct indent width for the "bar" node key.
                                // ```
                                continue;
                            }

                            // if node properties and the followed node are on different lines (i.e., the properties are
                            // for a container node), the application and the line advancement must happen here.
                            // Otherwise, a false indent error will be emitted. See
                            // https://github.com/fktn-k/fkYAML/issues/368 for more details.
                            line = line_after_props;
                            indent = lexer.get_last_token_begin_pos();
                            *mp_current_node = basic_node_type::mapping();
                            m_context_stack.emplace_back(
                                line_after_props, indent, context_state_t::BLOCK_MAPPING, mp_current_node);
                            apply_directive_set(*mp_current_node);
                            apply_node_properties(*mp_current_node);
                        }

                        continue;
                    }

                    if (indent <= m_context_stack.back().indent) {
                        FK_YAML_ASSERT(m_context_stack.back().state == context_state_t::MAPPING_VALUE);

                        // Mapping values can be omitted and are considered to be null.
                        // ```yaml
                        // foo:
                        // bar:
                        //   baz:
                        // qux:
                        // # -> {foo: null, bar: {baz: null}, qux: null}
                        // ```
                        pop_to_parent_node(line, indent, [indent](const parse_context& c) {
                            return (c.state == context_state_t::BLOCK_MAPPING) && (indent == c.indent);
                        });
                    }

                    // defer checking the existence of a key separator after the following scalar until the next
                    // deserialize_scalar() call.
                    continue;
                }

                // handle explicit mapping key separators.
                FK_YAML_ASSERT(m_context_stack.back().state == context_state_t::BLOCK_MAPPING_EXPLICIT_KEY);

                basic_node_type key_node = std::move(*m_context_stack.back().p_node);
                m_context_stack.pop_back();
                m_context_stack.back().p_node->as_map().emplace(key_node, basic_node_type());
                mp_current_node = &(m_context_stack.back().p_node->operator[](std::move(key_node)));
                m_context_stack.emplace_back(
                    old_line, old_indent, context_state_t::BLOCK_MAPPING_EXPLICIT_VALUE, mp_current_node);

                if (token.type == lexical_token_t::SEQUENCE_BLOCK_PREFIX) {
                    *mp_current_node = basic_node_type::sequence({basic_node_type()});
                    apply_directive_set(*mp_current_node);
                    apply_node_properties(*mp_current_node);
                    m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_SEQUENCE, mp_current_node);

                    mp_current_node = &(mp_current_node->as_seq().back());
                    parse_context entry_context = m_context_stack.back();
                    entry_context.state = context_state_t::BLOCK_SEQUENCE_ENTRY;
                    entry_context.p_node = mp_current_node;
                    m_context_stack.emplace_back(std::move(entry_context));
                    break;
                }

                continue;
            }
            case lexical_token_t::ANCHOR_PREFIX:
            case lexical_token_t::TAG_PREFIX:
                deserialize_node_properties(lexer, token, line, indent);
                // Skip updating the current indent to avoid stacking a wrong indentation.
                // Note that node properties for block sequences as a mapping value are processed when a
                // `lexical_token_t::KEY_SEPARATOR` token is processed.
                //
                // ```yaml
                // &foo bar: baz
                // ^
                // the correct indent width for the "bar" node key.
                // ```
                continue;
            case lexical_token_t::SEQUENCE_BLOCK_PREFIX: {
                FK_YAML_ASSERT(!m_context_stack.empty());
                const uint32_t parent_indent = m_context_stack.back().indent;
                if (indent == parent_indent) {
                    // If the previous block sequence entry is empty, just move to the parent context.
                    // ```yaml
                    // foo:
                    //   -
                    //   - bar
                    // # ^ (here)
                    // # -> {foo: [null, bar]}
                    // ```
                    pop_to_parent_node(line, indent, [](const parse_context& c) {
                        return c.state == context_state_t::BLOCK_SEQUENCE;
                    });
                }
                else if (indent < parent_indent) {
                    pop_to_parent_node(line, indent, [indent](const parse_context& c) {
                        return c.state == context_state_t::BLOCK_SEQUENCE && indent == c.indent;
                    });
                }
                else /*parent_indent < indent*/ {
                    if FK_YAML_UNLIKELY (m_context_stack.back().state == context_state_t::BLOCK_SEQUENCE) {
                        // bad indentation like the following YAML:
                        // ```yaml
                        // - "foo"
                        //   - bar
                        // # ^
                        // ```
                        throw parse_error("bad indentation of a mapping entry.", line, indent);
                    }

                    *mp_current_node = basic_node_type::sequence();
                    m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_SEQUENCE, mp_current_node);
                    apply_directive_set(*mp_current_node);
                    apply_node_properties(*mp_current_node);
                }

                auto& seq = mp_current_node->as_seq();
                seq.emplace_back(basic_node_type());
                mp_current_node = &(seq.back());
                apply_directive_set(*mp_current_node);
                m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_SEQUENCE_ENTRY, mp_current_node);
                break;
            }
            case lexical_token_t::SEQUENCE_FLOW_BEGIN:
                if (m_flow_context_depth == 0) {
                    lexer.set_context_state(true);

                    if (indent <= m_context_stack.back().indent) {
                        pop_to_parent_node(line, indent, [indent](const parse_context& c) {
                            switch (c.state) {
                            case context_state_t::BLOCK_MAPPING:
                            case context_state_t::MAPPING_VALUE:
                                return indent == c.indent;
                            default:
                                return false;
                            }
                        });
                    }
                }
                else if FK_YAML_UNLIKELY (m_flow_token_state == flow_token_state_t::NEEDS_SEPARATOR_OR_SUFFIX) {
                    throw parse_error("Flow sequence beginning is found without separated with a comma.", line, indent);
                }

                ++m_flow_context_depth;

                switch (m_context_stack.back().state) {
                case context_state_t::BLOCK_SEQUENCE:
                case context_state_t::FLOW_SEQUENCE:
                    mp_current_node->as_seq().emplace_back(basic_node_type::sequence());
                    mp_current_node = &(mp_current_node->as_seq().back());
                    m_context_stack.emplace_back(line, indent, context_state_t::FLOW_SEQUENCE, mp_current_node);
                    break;
                case context_state_t::BLOCK_MAPPING:
                case context_state_t::FLOW_MAPPING:
                    // heap-allocated node will be freed in handling the corresponding SEQUENCE_FLOW_END event.
                    m_context_stack.emplace_back(
                        line, indent, context_state_t::FLOW_SEQUENCE_KEY, new basic_node_type(node_type::SEQUENCE));
                    mp_current_node = m_context_stack.back().p_node;
                    break;
                default: {
                    *mp_current_node = basic_node_type::sequence();
                    parse_context& last_context = m_context_stack.back();
                    last_context.line = line;
                    last_context.indent = indent;
                    last_context.state = context_state_t::FLOW_SEQUENCE;
                    break;
                }
                }

                apply_directive_set(*mp_current_node);
                apply_node_properties(*mp_current_node);

                m_flow_token_state = flow_token_state_t::NEEDS_VALUE_OR_SUFFIX;
                break;
            case lexical_token_t::SEQUENCE_FLOW_END: {
                if FK_YAML_UNLIKELY (m_flow_context_depth == 0) {
                    throw parse_error("Flow sequence ending is found outside the flow context.", line, indent);
                }

                if (--m_flow_context_depth == 0) {
                    lexer.set_context_state(false);
                }

                // find the corresponding flow sequence beginning.
                auto itr = std::find_if( // LCOV_EXCL_LINE
                    m_context_stack.rbegin(),
                    m_context_stack.rend(),
                    [](const parse_context& c) {
                        switch (c.state) {
                        case context_state_t::FLOW_SEQUENCE_KEY:
                        case context_state_t::FLOW_SEQUENCE:
                            return true;
                        default:
                            return false;
                        }
                    });

                const bool is_valid = itr != m_context_stack.rend();
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw parse_error("No corresponding flow sequence beginning is found.", line, indent);
                }

                // keep the last state for later processing.
                parse_context& last_context = m_context_stack.back();
                mp_current_node = last_context.p_node;
                last_context.p_node = nullptr;
                indent = last_context.indent;
                const context_state_t state = last_context.state;
                m_context_stack.pop_back();

                // handle cases where the flow sequence is a mapping key node.

                if (!m_context_stack.empty() && state == context_state_t::FLOW_SEQUENCE_KEY) {
                    basic_node_type key_node = std::move(*mp_current_node);
                    delete mp_current_node;
                    mp_current_node = m_context_stack.back().p_node;
                    m_flow_token_state = flow_token_state_t::NEEDS_VALUE_OR_SUFFIX;

                    add_new_key(std::move(key_node), line, indent);
                    break;
                }

                token = lexer.get_next_token();
                if (token.type == lexical_token_t::KEY_SEPARATOR) {
                    basic_node_type key_node = basic_node_type::mapping();
                    apply_directive_set(key_node);
                    mp_current_node->swap(key_node);

                    m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_MAPPING, mp_current_node);
                    m_flow_token_state = flow_token_state_t::NEEDS_VALUE_OR_SUFFIX;

                    add_new_key(std::move(key_node), line, indent);
                }
                else {
                    if (!m_context_stack.empty()) {
                        mp_current_node = m_context_stack.back().p_node;
                    }
                    if (m_flow_context_depth > 0) {
                        m_flow_token_state = flow_token_state_t::NEEDS_SEPARATOR_OR_SUFFIX;
                    }
                }

                indent = lexer.get_last_token_begin_pos();
                line = lexer.get_lines_processed();
                continue;
            }
            case lexical_token_t::MAPPING_FLOW_BEGIN:
                if (m_flow_context_depth == 0) {
                    lexer.set_context_state(true);

                    if (indent <= m_context_stack.back().indent) {
                        pop_to_parent_node(line, indent, [indent](const parse_context& c) {
                            switch (c.state) {
                            case context_state_t::BLOCK_MAPPING:
                            case context_state_t::MAPPING_VALUE:
                                return indent == c.indent;
                            default:
                                return false;
                            }
                        });
                    }
                }
                else if FK_YAML_UNLIKELY (m_flow_token_state == flow_token_state_t::NEEDS_SEPARATOR_OR_SUFFIX) {
                    throw parse_error("Flow mapping beginning is found without separated with a comma.", line, indent);
                }

                ++m_flow_context_depth;

                switch (m_context_stack.back().state) {
                case context_state_t::BLOCK_SEQUENCE:
                case context_state_t::FLOW_SEQUENCE:
                    mp_current_node->as_seq().emplace_back(basic_node_type::mapping());
                    mp_current_node = &(mp_current_node->as_seq().back());
                    m_context_stack.emplace_back(line, indent, context_state_t::FLOW_MAPPING, mp_current_node);
                    break;
                case context_state_t::BLOCK_MAPPING:
                case context_state_t::FLOW_MAPPING:
                    // heap-allocated node will be freed in handling the corresponding MAPPING_FLOW_END event.
                    m_context_stack.emplace_back(
                        line, indent, context_state_t::FLOW_MAPPING_KEY, new basic_node_type(node_type::MAPPING));
                    mp_current_node = m_context_stack.back().p_node;
                    break;
                default: {
                    *mp_current_node = basic_node_type::mapping();
                    parse_context& last_context = m_context_stack.back();
                    last_context.line = line;
                    last_context.indent = indent;
                    last_context.state = context_state_t::FLOW_MAPPING;
                    break;
                }
                }

                apply_directive_set(*mp_current_node);
                apply_node_properties(*mp_current_node);

                line = lexer.get_lines_processed();
                indent = lexer.get_last_token_begin_pos();

                m_flow_token_state = flow_token_state_t::NEEDS_VALUE_OR_SUFFIX;
                break;
            case lexical_token_t::MAPPING_FLOW_END: {
                if FK_YAML_UNLIKELY (m_flow_context_depth == 0) {
                    throw parse_error("Flow mapping ending is found outside the flow context.", line, indent);
                }

                if (--m_flow_context_depth == 0) {
                    lexer.set_context_state(false);
                }

                // find the corresponding flow mapping beginning.
                auto itr = std::find_if( // LCOV_EXCL_LINE
                    m_context_stack.rbegin(),
                    m_context_stack.rend(),
                    [](const parse_context& c) {
                        switch (c.state) {
                        case context_state_t::FLOW_MAPPING_KEY:
                        case context_state_t::FLOW_MAPPING:
                            return true;
                        default:
                            return false;
                        }
                    });

                const bool is_valid = itr != m_context_stack.rend();
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw parse_error("No corresponding flow mapping beginning is found.", line, indent);
                }

                // keep the last state for later processing.
                parse_context& last_context = m_context_stack.back();
                mp_current_node = last_context.p_node;
                last_context.p_node = nullptr;
                indent = last_context.indent;
                const context_state_t state = last_context.state;
                m_context_stack.pop_back();

                // handle cases where the flow mapping is a mapping key node.

                if (!m_context_stack.empty() && state == context_state_t::FLOW_MAPPING_KEY) {
                    basic_node_type key_node = std::move(*mp_current_node);
                    delete mp_current_node;
                    mp_current_node = m_context_stack.back().p_node;
                    m_flow_token_state = flow_token_state_t::NEEDS_VALUE_OR_SUFFIX;

                    add_new_key(std::move(key_node), line, indent);
                    break;
                }

                token = lexer.get_next_token();
                if (token.type == lexical_token_t::KEY_SEPARATOR) {
                    basic_node_type key_node = basic_node_type::mapping();
                    apply_directive_set(key_node);
                    mp_current_node->swap(key_node);

                    m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_MAPPING, mp_current_node);
                    m_flow_token_state = flow_token_state_t::NEEDS_VALUE_OR_SUFFIX;

                    add_new_key(std::move(key_node), line, indent);
                }
                else {
                    if (!m_context_stack.empty()) {
                        mp_current_node = m_context_stack.back().p_node;
                    }
                    if (m_flow_context_depth > 0) {
                        m_flow_token_state = flow_token_state_t::NEEDS_SEPARATOR_OR_SUFFIX;
                    }
                }

                indent = lexer.get_last_token_begin_pos();
                line = lexer.get_lines_processed();
                continue;
            }
            case lexical_token_t::VALUE_SEPARATOR:
                FK_YAML_ASSERT(m_flow_context_depth > 0);
                if FK_YAML_UNLIKELY (m_flow_token_state != flow_token_state_t::NEEDS_SEPARATOR_OR_SUFFIX) {
                    throw parse_error("invalid value separator is found.", line, indent);
                }
                m_flow_token_state = flow_token_state_t::NEEDS_VALUE_OR_SUFFIX;
                break;
            case lexical_token_t::ALIAS_PREFIX: {
                // An alias node must not specify any properties (tag, anchor).
                // https://yaml.org/spec/1.2.2/#71-alias-nodes
                if FK_YAML_UNLIKELY (m_needs_tag_impl) {
                    throw parse_error("Tag cannot be specified to an alias node", line, indent);
                }
                if FK_YAML_UNLIKELY (m_needs_anchor_impl) {
                    throw parse_error("Anchor cannot be specified to an alias node.", line, indent);
                }

                std::string token_str = std::string(token.str.begin(), token.str.end());

                const auto anchor_counts = static_cast<uint32_t>(mp_meta->anchor_table.count(token_str));
                if FK_YAML_UNLIKELY (anchor_counts == 0) {
                    throw parse_error("The given anchor name must appear prior to the alias node.", line, indent);
                }

                basic_node_type node {};
                node.m_attrs |= detail::node_attr_bits::alias_bit;
                node.m_prop.anchor = std::move(token_str);
                detail::node_attr_bits::set_anchor_offset(anchor_counts - 1, node.m_attrs);

                apply_directive_set(node);
                apply_node_properties(node);

                deserialize_scalar(lexer, std::move(node), indent, line, token);
                continue;
            }
            case lexical_token_t::PLAIN_SCALAR:
            case lexical_token_t::SINGLE_QUOTED_SCALAR:
            case lexical_token_t::DOUBLE_QUOTED_SCALAR: {
                tag_t tag_type {tag_t::NONE};
                if (m_needs_tag_impl) {
                    tag_type = tag_resolver_type::resolve_tag(m_tag_name, mp_meta);
                }

                basic_node_type node = scalar_parser_type(line, indent).parse_flow(token.type, tag_type, token.str);
                apply_directive_set(node);
                apply_node_properties(node);

                deserialize_scalar(lexer, std::move(node), indent, line, token);
                continue;
            }
            case lexical_token_t::BLOCK_LITERAL_SCALAR:
            case lexical_token_t::BLOCK_FOLDED_SCALAR: {
                tag_t tag_type {tag_t::NONE};
                if (m_needs_tag_impl) {
                    tag_type = tag_resolver_type::resolve_tag(m_tag_name, mp_meta);
                }

                basic_node_type node =
                    scalar_parser_type(line, indent)
                        .parse_block(token.type, tag_type, token.str, lexer.get_block_scalar_header());
                apply_directive_set(node);
                apply_node_properties(node);

                deserialize_scalar(lexer, std::move(node), indent, line, token);
                continue;
            }
            // these tokens end parsing the current YAML document.
            case lexical_token_t::END_OF_BUFFER:
                // This handles an empty input.
                last_type = token.type;
                return;
            case lexical_token_t::END_OF_DIRECTIVES:
            case lexical_token_t::END_OF_DOCUMENT:
                if FK_YAML_UNLIKELY (m_flow_context_depth > 0) {
                    throw parse_error("An invalid document marker found in a flow collection", line, indent);
                }
                last_type = token.type;
                return;
            // no way to come here while lexically analyzing document contents.
            case lexical_token_t::YAML_VER_DIRECTIVE: // LCOV_EXCL_LINE
            case lexical_token_t::TAG_DIRECTIVE:      // LCOV_EXCL_LINE
            case lexical_token_t::INVALID_DIRECTIVE:  // LCOV_EXCL_LINE
                detail::unreachable();                // LCOV_EXCL_LINE
            }

            token = lexer.get_next_token();
            indent = lexer.get_last_token_begin_pos();
            line = lexer.get_lines_processed();
        } while (token.type != lexical_token_t::END_OF_BUFFER);

        last_type = token.type;
    }

    /// @brief Deserializes YAML node properties (anchor and/or tag names) if they exist
    /// @param lexer The lexical analyzer to be used.
    /// @param last_type The variable to store the last lexical token type.
    /// @param line The variable to store the line of either the first property or the last non-property token.
    /// @param indent The variable to store the indent of either the first property or the last non-property token.
    /// @return true if any property is found, false otherwise.
    bool deserialize_node_properties(lexer_type& lexer, lexical_token& last_token, uint32_t& line, uint32_t& indent) {
        m_needs_anchor_impl = m_needs_tag_impl = false;

        lexical_token token = last_token;
        bool ends_loop {false};
        do {
            if (line < lexer.get_lines_processed()) {
                break;
            }

            switch (token.type) {
            case lexical_token_t::ANCHOR_PREFIX:
                if FK_YAML_UNLIKELY (m_needs_anchor_impl) {
                    throw parse_error(
                        "anchor name cannot be specified more than once to the same node.",
                        lexer.get_lines_processed(),
                        lexer.get_last_token_begin_pos());
                }

                m_anchor_name = token.str;
                m_needs_anchor_impl = true;

                if (!m_needs_tag_impl) {
                    line = lexer.get_lines_processed();
                    indent = lexer.get_last_token_begin_pos();
                }

                token = lexer.get_next_token();
                break;
            case lexical_token_t::TAG_PREFIX: {
                if FK_YAML_UNLIKELY (m_needs_tag_impl) {
                    throw parse_error(
                        "tag name cannot be specified more than once to the same node.",
                        lexer.get_lines_processed(),
                        lexer.get_last_token_begin_pos());
                }

                m_tag_name = token.str;
                m_needs_tag_impl = true;

                if (!m_needs_anchor_impl) {
                    line = lexer.get_lines_processed();
                    indent = lexer.get_last_token_begin_pos();
                }

                token = lexer.get_next_token();
                break;
            }
            default:
                ends_loop = true;
                break;
            }
        } while (!ends_loop);

        last_token = token;
        const bool prop_specified = m_needs_anchor_impl || m_needs_tag_impl;
        if (!prop_specified) {
            line = lexer.get_lines_processed();
            indent = lexer.get_last_token_begin_pos();
        }

        return prop_specified;
    }

    /// @brief Add new key string to the current YAML node.
    /// @param key a key string to be added to the current YAML node.
    /// @param line The line where the key is found.
    /// @param indent The indentation width in the current line where the key is found.
    void add_new_key(basic_node_type&& key, const uint32_t line, const uint32_t indent) {
        if (m_flow_context_depth == 0) {
            if FK_YAML_UNLIKELY (m_context_stack.back().indent < indent) {
                // bad indentation like the following YAML:
                // ```yaml
                // foo: true
                //   baz: 123
                // # ^
                // ```
                throw parse_error("bad indentation of a mapping entry.", line, indent);
            }

            pop_to_parent_node(line, indent, [indent](const parse_context& c) {
                return (c.state == context_state_t::BLOCK_MAPPING) && (indent == c.indent);
            });
        }
        else {
            if FK_YAML_UNLIKELY (m_flow_token_state != flow_token_state_t::NEEDS_VALUE_OR_SUFFIX) {
                throw parse_error("Flow mapping entry is found without separated with a comma.", line, indent);
            }

            if (mp_current_node->is_sequence()) {
                mp_current_node->as_seq().emplace_back(basic_node_type::mapping());
                mp_current_node = &(mp_current_node->operator[](mp_current_node->size() - 1));
                m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_MAPPING, mp_current_node);
            }
        }

        auto itr = mp_current_node->as_map().emplace(std::move(key), basic_node_type());
        if FK_YAML_UNLIKELY (!itr.second) {
            throw parse_error("Detected duplication in mapping keys.", line, indent);
        }

        mp_current_node = &(itr.first->second);
        const parse_context& key_context = m_context_stack.back();
        m_context_stack.emplace_back(
            key_context.line, key_context.indent, context_state_t::MAPPING_VALUE, mp_current_node);
    }

    /// @brief Assign node value to the current node.
    /// @param node_value A rvalue basic_node_type object to be assigned to the current node.
    void assign_node_value(basic_node_type&& node_value, const uint32_t line, const uint32_t indent) {
        if (mp_current_node->is_sequence()) {
            FK_YAML_ASSERT(m_flow_context_depth > 0);

            if FK_YAML_UNLIKELY (m_flow_token_state != flow_token_state_t::NEEDS_VALUE_OR_SUFFIX) {
                // Flow sequence entries are not allowed to be empty.
                // ```yaml
                // [foo,,bar]
                // ```
                throw parse_error("flow sequence entry is found without separated with a comma.", line, indent);
            }

            mp_current_node->as_seq().emplace_back(std::move(node_value));
            m_flow_token_state = flow_token_state_t::NEEDS_SEPARATOR_OR_SUFFIX;
            return;
        }

        // a scalar node
        *mp_current_node = std::move(node_value);
        if FK_YAML_UNLIKELY (m_context_stack.empty()) {
            // single scalar document.
            return;
        }

        if FK_YAML_LIKELY (m_context_stack.back().state != context_state_t::BLOCK_MAPPING_EXPLICIT_KEY) {
            m_context_stack.pop_back();
            mp_current_node = m_context_stack.back().p_node;

            if (m_flow_context_depth > 0) {
                m_flow_token_state = flow_token_state_t::NEEDS_SEPARATOR_OR_SUFFIX;
            }
        }
    }

    /// @brief Deserialize a detected scalar node.
    /// @param lexer The lexical analyzer to be used.
    /// @param node A scalar node.
    /// @param indent The current indentation width. Can be updated in this function.
    /// @param line The number of processed lines. Can be updated in this function.
    /// @param token The storage for last lexical token.
    /// @return true if next token has already been got, false otherwise.
    void deserialize_scalar(
        lexer_type& lexer, basic_node_type&& node, uint32_t& indent, uint32_t& line, lexical_token& token) {
        token = lexer.get_next_token();
        if (mp_current_node->is_mapping()) {
            const bool is_key_sep_followed =
                (token.type == lexical_token_t::KEY_SEPARATOR) && (line == lexer.get_lines_processed());
            if FK_YAML_UNLIKELY (!is_key_sep_followed) {
                throw parse_error(
                    "The \":\" mapping value indicator must be followed after a mapping key.",
                    lexer.get_lines_processed(),
                    lexer.get_last_token_begin_pos());
            }
            add_new_key(std::move(node), line, indent);
        }
        else if (token.type == lexical_token_t::KEY_SEPARATOR) {
            if FK_YAML_UNLIKELY (line != lexer.get_lines_processed()) {
                // This path is for explicit mapping key separator like:
                // ```yaml
                //   ? foo
                //   : bar
                // # ^ this separator
                // ```
                assign_node_value(std::move(node), line, indent);
                indent = lexer.get_last_token_begin_pos();
                line = lexer.get_lines_processed();

                if (m_context_stack.back().state != context_state_t::BLOCK_MAPPING_EXPLICIT_KEY) {
                    pop_to_parent_node(line, indent, [indent](const parse_context& c) {
                        return c.state == context_state_t::BLOCK_MAPPING_EXPLICIT_KEY && indent == c.indent;
                    });
                }
                return;
            }

            if (mp_current_node->is_scalar()) {
                if FK_YAML_LIKELY (!m_context_stack.empty()) {
                    parse_context& cur_context = m_context_stack.back();
                    switch (cur_context.state) {
                    case context_state_t::BLOCK_MAPPING_EXPLICIT_KEY:
                    case context_state_t::BLOCK_MAPPING_EXPLICIT_VALUE:
                        m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_MAPPING, mp_current_node);
                        break;
                    case context_state_t::BLOCK_SEQUENCE_ENTRY:
                        if FK_YAML_UNLIKELY (cur_context.indent >= indent) {
                            // This handles combination of empty block sequence entry and block mapping entry with the
                            // same indentation level, for examples:
                            // ```yaml
                            // foo:
                            //   bar:
                            //   -         # These entries are indented
                            //   baz: 123  # with the same width.
                            // # ^^^
                            // ```
                            pop_to_parent_node(line, indent, [indent](const parse_context& c) {
                                return c.state == context_state_t::BLOCK_MAPPING && indent == c.indent;
                            });
                            add_new_key(std::move(node), line, indent);
                            indent = lexer.get_last_token_begin_pos();
                            line = lexer.get_lines_processed();
                            return;
                        }

                        m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_MAPPING, mp_current_node);
                        break;
                    default:
                        if FK_YAML_UNLIKELY (cur_context.line == line) {
                            throw parse_error("Multiple mapping keys are specified on the same line.", line, indent);
                        }
                        cur_context.line = line;
                        cur_context.indent = indent;
                        cur_context.state = context_state_t::BLOCK_MAPPING;
                        break;
                    }

                    *mp_current_node = basic_node_type::mapping();
                    apply_directive_set(*mp_current_node);
                }
                else {
                    // root mapping node

                    m_context_stack.emplace_back(line, indent, context_state_t::BLOCK_MAPPING, mp_current_node);
                    *mp_current_node = basic_node_type::mapping();
                    apply_directive_set(*mp_current_node);

                    // apply node properties if any to the root mapping node.
                    if (!m_root_anchor_name.empty()) {
                        mp_current_node->add_anchor_name(
                            std::string(m_root_anchor_name.begin(), m_root_anchor_name.end()));
                        m_root_anchor_name = {};
                    }
                    if (!m_root_tag_name.empty()) {
                        mp_current_node->add_tag_name(std::string(m_root_tag_name.begin(), m_root_tag_name.end()));
                        m_root_tag_name = {};
                    }
                }
            }
            add_new_key(std::move(node), line, indent);
        }
        else {
            assign_node_value(std::move(node), line, indent);
        }

        indent = lexer.get_last_token_begin_pos();
        line = lexer.get_lines_processed();
    }

    /// @brief Pops parent contexts to a block mapping with the given indentation.
    /// @tparam Pred Functor type to test parent contexts.
    /// @param line The current line count.
    /// @param indent The indentation level of the target parent block mapping.
    template <typename Pred>
    void pop_to_parent_node(uint32_t line, uint32_t indent, Pred&& pred) {
        FK_YAML_ASSERT(!m_context_stack.empty());

        // LCOV_EXCL_START
        auto itr = std::find_if(m_context_stack.rbegin(), m_context_stack.rend(), std::forward<Pred>(pred));
        // LCOV_EXCL_STOP
        const bool is_indent_valid = (itr != m_context_stack.rend());
        if FK_YAML_UNLIKELY (!is_indent_valid) {
            throw parse_error("Detected invalid indentation.", line, indent);
        }

        const auto pop_num = static_cast<uint32_t>(std::distance(m_context_stack.rbegin(), itr));

        // move back to the parent block mapping.
        for (uint32_t i = 0; i < pop_num; i++) {
            m_context_stack.pop_back();
        }
        mp_current_node = m_context_stack.back().p_node;
    }

    /// @brief Set YAML directive properties to the given node.
    /// @param node A basic_node_type object to be set YAML directive properties.
    void apply_directive_set(basic_node_type& node) noexcept {
        node.mp_meta = mp_meta;
    }

    /// @brief Set YAML node properties (anchor and/or tag names) to the given node.
    /// @param node A node type object to be set YAML node properties.
    void apply_node_properties(basic_node_type& node) {
        if (m_needs_anchor_impl) {
            node.add_anchor_name(std::string(m_anchor_name.begin(), m_anchor_name.end()));
            m_needs_anchor_impl = false;
            m_anchor_name = {};
        }

        if (m_needs_tag_impl) {
            node.add_tag_name(std::string(m_tag_name.begin(), m_tag_name.end()));
            m_needs_tag_impl = false;
            m_tag_name = {};
        }
    }

    /// @brief Update the target YAML version with an input string.
    /// @param version_str A YAML version string.
    yaml_version_type convert_yaml_version(str_view version_str) noexcept {
        return (version_str.compare("1.1") == 0) ? yaml_version_type::VERSION_1_1 : yaml_version_type::VERSION_1_2;
    }

private:
    /// The currently focused YAML node.
    basic_node_type* mp_current_node {nullptr};
    /// The stack of parse contexts.
    std::deque<parse_context> m_context_stack {};
    /// The current depth of flow contexts.
    uint32_t m_flow_context_depth {0};
    /// The set of YAML directives.
    std::shared_ptr<doc_metainfo_type> mp_meta {};
    /// A flag to determine the need for YAML anchor node implementation.
    bool m_needs_anchor_impl {false};
    /// A flag to determine the need for a corresponding node with the last YAML tag.
    bool m_needs_tag_impl {false};
    /// A flag to determine the need for a value separator or a flow suffix to follow.
    flow_token_state_t m_flow_token_state {flow_token_state_t::NEEDS_VALUE_OR_SUFFIX};
    /// The last YAML anchor name.
    str_view m_anchor_name;
    /// The last tag name.
    str_view m_tag_name;
    /// The root YAML anchor name. (maybe empty and unused)
    str_view m_root_anchor_name;
    /// The root tag name. (maybe empty and unused)
    str_view m_root_tag_name;
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_INPUT_DESERIALIZER_HPP */

// #include <fkYAML/detail/input/input_adapter.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_INPUT_INPUT_ADAPTER_HPP
#define FK_YAML_DETAIL_INPUT_INPUT_ADAPTER_HPP

#include <array>
#include <cstdio>
#include <cstring>
#include <deque>
#include <istream>
#include <iterator>
#include <string>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/assert.hpp>

// #include <fkYAML/detail/encodings/utf_encode_detector.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_ENCODINGS_UTF_ENCODE_DETECTOR_HPP
#define FK_YAML_DETAIL_ENCODINGS_UTF_ENCODE_DETECTOR_HPP

#include <cstdint>
#include <istream>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/encodings/utf_encode_t.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_ENCODINGS_UTF_ENCODE_T_HPP
#define FK_YAML_DETAIL_ENCODINGS_UTF_ENCODE_T_HPP

#include <cstdint>

// #include <fkYAML/detail/macros/define_macros.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Definition of Unicode encoding types
/// @note Since fkYAML doesn't treat UTF-16/UTF-32 encoded characters per byte, endians do not matter.
enum class utf_encode_t : std::uint8_t {
    UTF_8,    //!< UTF-8
    UTF_16BE, //!< UTF-16 Big Endian
    UTF_16LE, //!< UTF-16 Little Endian
    UTF_32BE, //!< UTF-32 Big Endian
    UTF_32LE, //!< UTF-32 Little Endian
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_ENCODINGS_UTF_ENCODE_T_HPP */

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/meta/type_traits.hpp>

// #include <fkYAML/exception.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Detect an encoding type for UTF-8 expected inputs.
/// @note This function doesn't support the case where the first character is null.
/// @param[in] bytes 4 bytes of an input character sequence.
/// @param[out] has_bom Whether the input contains a BOM.
/// @return A detected encoding type.
inline utf_encode_t detect_encoding_type(const std::array<uint8_t, 4>& bytes, bool& has_bom) noexcept {
    has_bom = false;

    const uint8_t byte0 = bytes[0];
    const uint8_t byte1 = bytes[1];
    const uint8_t byte2 = bytes[2];
    const uint8_t byte3 = bytes[3];

    // Check if a BOM exists.

    if (byte0 == static_cast<uint8_t>(0xEFu) && byte1 == static_cast<uint8_t>(0xBBu) &&
        byte2 == static_cast<uint8_t>(0xBFu)) {
        has_bom = true;
        return utf_encode_t::UTF_8;
    }

    if (byte0 == 0 && byte1 == 0 && byte2 == static_cast<uint8_t>(0xFEu) && byte3 == static_cast<uint8_t>(0xFFu)) {
        has_bom = true;
        return utf_encode_t::UTF_32BE;
    }

    if (byte0 == static_cast<uint8_t>(0xFFu) && byte1 == static_cast<uint8_t>(0xFEu) && byte2 == 0 && byte3 == 0) {
        has_bom = true;
        return utf_encode_t::UTF_32LE;
    }

    if (byte0 == static_cast<uint8_t>(0xFEu) && byte1 == static_cast<uint8_t>(0xFFu)) {
        has_bom = true;
        return utf_encode_t::UTF_16BE;
    }

    if (byte0 == static_cast<uint8_t>(0xFFu) && byte1 == static_cast<uint8_t>(0xFEu)) {
        has_bom = true;
        return utf_encode_t::UTF_16LE;
    }

    // Test the first character assuming it's an ASCII character.

    if (byte0 == 0 && byte1 == 0 && byte2 == 0 && 0 < byte3 && byte3 < static_cast<uint8_t>(0x80u)) {
        return utf_encode_t::UTF_32BE;
    }

    if (0 < byte0 && byte0 < static_cast<uint8_t>(0x80u) && byte1 == 0 && byte2 == 0 && byte3 == 0) {
        return utf_encode_t::UTF_32LE;
    }

    if (byte0 == 0 && 0 < byte1 && byte1 < static_cast<uint8_t>(0x80u)) {
        return utf_encode_t::UTF_16BE;
    }

    if (0 < byte0 && byte0 < static_cast<uint8_t>(0x80u) && byte1 == 0) {
        return utf_encode_t::UTF_16LE;
    }

    return utf_encode_t::UTF_8;
}

/// @brief A class which detects UTF encoding type and the existence of a BOM at the beginning.
/// @tparam ItrType Type of iterators for the input.
template <typename ItrType, typename = void>
struct utf_encode_detector {};

/// @brief The partial specialization of utf_encode_detector for char iterators.
/// @tparam ItrType An iterator type.
template <typename ItrType>
struct utf_encode_detector<ItrType, enable_if_t<is_iterator_of<ItrType, char>::value>> {
    /// @brief Detects the encoding type of the input, and consumes a BOM if it exists.
    /// @param begin The iterator to the first element of an input.
    /// @param end The iterator to the past-the end element of an input.
    /// @return A detected encoding type.
    static utf_encode_t detect(ItrType& begin, const ItrType& end) noexcept {
        if FK_YAML_UNLIKELY (begin == end) {
            return utf_encode_t::UTF_8;
        }

        // the inner curly braces are necessary for older compilers
        std::array<uint8_t, 4> bytes {{}};
        bytes.fill(0xFFu);
        auto current = begin;
        for (int i = 0; i < 4 && current != end; i++, ++current) {
            bytes[i] = static_cast<uint8_t>(*current); // NOLINT(cppcoreguidelines-pro-bounds-constant-array-index)
        }

        bool has_bom = false;
        const utf_encode_t encode_type = detect_encoding_type(bytes, has_bom);

        if (has_bom) {
            // skip reading the BOM.
            switch (encode_type) {
            case utf_encode_t::UTF_8:
                std::advance(begin, 3);
                break;
            case utf_encode_t::UTF_16BE:
            case utf_encode_t::UTF_16LE:
                std::advance(begin, 2);
                break;
            case utf_encode_t::UTF_32BE:
            case utf_encode_t::UTF_32LE:
                std::advance(begin, 4);
                break;
            }
        }

        return encode_type;
    }
};

#if FK_YAML_HAS_CHAR8_T

/// @brief The partial specialization of utf_encode_detector for char8_t iterators.
/// @tparam ItrType An iterator type.
template <typename ItrType>
struct utf_encode_detector<ItrType, enable_if_t<is_iterator_of<ItrType, char8_t>::value>> {
    /// @brief Detects the encoding type of the input, and consumes a BOM if it exists.
    /// @param begin The iterator to the first element of an input.
    /// @param end The iterator to the past-the end element of an input.
    /// @return A detected encoding type.
    static utf_encode_t detect(ItrType& begin, const ItrType& end) {
        if FK_YAML_UNLIKELY (begin == end) {
            return utf_encode_t::UTF_8;
        }

        std::array<uint8_t, 4> bytes {};
        bytes.fill(0xFFu);
        auto current = begin;
        for (int i = 0; i < 4 && current != end; i++, ++current) {
            bytes[i] = uint8_t(*current); // NOLINT(cppcoreguidelines-pro-bounds-constant-array-index)
        }

        bool has_bom = false;
        const utf_encode_t encode_type = detect_encoding_type(bytes, has_bom);

        if FK_YAML_UNLIKELY (encode_type != utf_encode_t::UTF_8) {
            throw exception("char8_t characters must be encoded in the UTF-8 format.");
        }

        if (has_bom) {
            // skip reading the BOM.
            std::advance(begin, 3);
        }

        return encode_type;
    }
};

#endif // FK_YAML_HAS_CHAR8_T

/// @brief The partial specialization of utf_encode_detector for char16_t iterators.
/// @tparam ItrType An iterator type.
template <typename ItrType>
struct utf_encode_detector<ItrType, enable_if_t<is_iterator_of<ItrType, char16_t>::value>> {
    /// @brief Detects the encoding type of the input, and consumes a BOM if it exists.
    /// @param begin The iterator to the first element of an input.
    /// @param end The iterator to the past-the end element of an input.
    /// @return A detected encoding type.
    static utf_encode_t detect(ItrType& begin, const ItrType& end) {
        if FK_YAML_UNLIKELY (begin == end) {
            return utf_encode_t::UTF_16BE;
        }

        // the inner curly braces are necessary for older compilers
        std::array<uint8_t, 4> bytes {{}};
        bytes.fill(0xFFu);
        auto current = begin;
        for (int i = 0; i < 2 && current != end; i++, ++current) {
            // NOLINTBEGIN(cppcoreguidelines-pro-bounds-constant-array-index)
            const char16_t elem = *current;
            const int idx_base = i * 2;
            bytes[idx_base] = static_cast<uint8_t>(elem >> 8);
            bytes[idx_base + 1] = static_cast<uint8_t>(elem);
            // NOLINTEND(cppcoreguidelines-pro-bounds-constant-array-index)
        }

        bool has_bom = false;
        const utf_encode_t encode_type = detect_encoding_type(bytes, has_bom);

        if FK_YAML_UNLIKELY (encode_type != utf_encode_t::UTF_16BE && encode_type != utf_encode_t::UTF_16LE) {
            throw exception("char16_t characters must be encoded in the UTF-16 format.");
        }

        if (has_bom) {
            // skip reading the BOM.
            std::advance(begin, 1);
        }

        return encode_type;
    }
};

/// @brief The partial specialization of utf_encode_detector for char32_t iterators.
/// @tparam ItrType An iterator type.
template <typename ItrType>
struct utf_encode_detector<ItrType, enable_if_t<is_iterator_of<ItrType, char32_t>::value>> {
    /// @brief Detects the encoding type of the input, and consumes a BOM if it exists.
    /// @param begin The iterator to the first element of an input.
    /// @param end The iterator to the past-the end element of an input.
    /// @return A detected encoding type.
    static utf_encode_t detect(ItrType& begin, const ItrType& end) {
        if FK_YAML_UNLIKELY (begin == end) {
            return utf_encode_t::UTF_32BE;
        }

        // the inner curly braces are necessary for older compilers
        std::array<uint8_t, 4> bytes {{}};
        const char32_t elem = *begin;
        bytes[0] = static_cast<uint8_t>(elem >> 24);
        bytes[1] = static_cast<uint8_t>(elem >> 16);
        bytes[2] = static_cast<uint8_t>(elem >> 8);
        bytes[3] = static_cast<uint8_t>(elem);

        bool has_bom = false;
        const utf_encode_t encode_type = detect_encoding_type(bytes, has_bom);

        if FK_YAML_UNLIKELY (encode_type != utf_encode_t::UTF_32BE && encode_type != utf_encode_t::UTF_32LE) {
            throw exception("char32_t characters must be encoded in the UTF-32 format.");
        }

        if (has_bom) {
            // skip reading the BOM.
            std::advance(begin, 1);
        }

        return encode_type;
    }
};

/// @brief A class which detects UTF encoding type and the existence of a BOM from the input file.
struct file_utf_encode_detector {
    /// @brief Detects the encoding type of the input, and consumes a BOM if it exists.
    /// @param p_file The input file handle.
    /// @return A detected encoding type.
    static utf_encode_t detect(std::FILE* p_file) noexcept {
        // the inner curly braces are necessary for older compilers
        std::array<uint8_t, 4> bytes {{}};
        bytes.fill(0xFFu);
        for (int i = 0; i < 4; i++) {
            char byte = 0;
            const std::size_t size = std::fread(&byte, sizeof(char), 1, p_file);
            if (size != sizeof(char)) {
                break;
            }
            bytes[i] = static_cast<uint8_t>(byte & 0xFF); // NOLINT(cppcoreguidelines-pro-bounds-constant-array-index)
        }

        bool has_bom = false;
        const utf_encode_t encode_type = detect_encoding_type(bytes, has_bom);

        // move back to the beginning if a BOM doesn't exist.
        long offset = 0; // NOLINT(google-runtime-int)
        if (has_bom) {
            switch (encode_type) {
            case utf_encode_t::UTF_8:
                offset = 3;
                break;
            case utf_encode_t::UTF_16BE:
            case utf_encode_t::UTF_16LE:
                offset = 2;
                break;
            case utf_encode_t::UTF_32BE:
            case utf_encode_t::UTF_32LE:
                offset = 4;
                break;
            }
        }
        std::fseek(p_file, offset, SEEK_SET); // NOLINT(cert-err33-c)

        return encode_type;
    }
};

/// @brief A class which detects UTF encoding type and the existence of a BOM from the input file.
struct stream_utf_encode_detector {
    /// @brief Detects the encoding type of the input, and consumes a BOM if it exists.
    /// @param p_file The input file handle.
    /// @return A detected encoding type.
    static utf_encode_t detect(std::istream& is) noexcept {
        // the inner curly braces are necessary for older compilers
        std::array<uint8_t, 4> bytes {{}};
        bytes.fill(0xFFu);
        for (int i = 0; i < 4; i++) {
            char ch = 0;
            is.read(&ch, 1);
            const std::streamsize size = is.gcount();
            if (size != 1) {
                // without this, seekg() will fail.
                is.clear();
                break;
            }
            bytes[i] = static_cast<uint8_t>(ch & 0xFF); // NOLINT(cppcoreguidelines-pro-bounds-constant-array-index)
        }

        bool has_bom = false;
        const utf_encode_t encode_type = detect_encoding_type(bytes, has_bom);

        // move back to the beginning if a BOM doesn't exist.
        std::streamoff offset = 0;
        if (has_bom) {
            switch (encode_type) {
            case utf_encode_t::UTF_8:
                offset = 3;
                break;
            case utf_encode_t::UTF_16BE:
            case utf_encode_t::UTF_16LE:
                offset = 2;
                break;
            case utf_encode_t::UTF_32BE:
            case utf_encode_t::UTF_32LE:
                offset = 4;
                break;
            }
        }
        is.seekg(offset, std::ios_base::beg);

        return encode_type;
    }
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_ENCODINGS_UTF_ENCODE_DETECTOR_HPP */

// #include <fkYAML/detail/encodings/utf_encode_t.hpp>

// #include <fkYAML/detail/encodings/utf_encodings.hpp>

// #include <fkYAML/detail/meta/input_adapter_traits.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/str_view.hpp>

// #include <fkYAML/exception.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

///////////////////////
//   input_adapter   //
///////////////////////

template <typename IterType, typename = void>
class iterator_input_adapter;

/// @brief An input adapter for iterators of type char.
/// @tparam IterType An iterator type.
template <typename IterType>
class iterator_input_adapter<IterType, enable_if_t<is_iterator_of<IterType, char>::value>> {
public:
    /// @brief Construct a new iterator_input_adapter object.
    iterator_input_adapter() = default;

    /// @brief Construct a new iterator_input_adapter object.
    /// @param begin The beginning of iterators.
    /// @param end The end of iterators.
    /// @param encode_type The encoding type for this input adapter.
    /// @param is_contiguous Whether iterators are contiguous or not.
    iterator_input_adapter(IterType begin, IterType end, utf_encode_t encode_type, bool is_contiguous) noexcept
        : m_begin(begin),
          m_end(end),
          m_encode_type(encode_type),
          m_is_contiguous(is_contiguous) {
    }

    // allow only move construct/assignment like other input adapters.
    iterator_input_adapter(const iterator_input_adapter&) = delete;
    iterator_input_adapter(iterator_input_adapter&& rhs) = default;
    iterator_input_adapter& operator=(const iterator_input_adapter&) = delete;
    iterator_input_adapter& operator=(iterator_input_adapter&&) = default;
    ~iterator_input_adapter() = default;

    /// @brief Get view into the input buffer contents.
    /// @return View into the input buffer contents.
    str_view get_buffer_view() {
        if FK_YAML_UNLIKELY (m_begin == m_end) {
            return {};
        }

        m_buffer.clear();

        switch (m_encode_type) {
        case utf_encode_t::UTF_8:
            return get_buffer_view_utf8();
        case utf_encode_t::UTF_16BE:
        case utf_encode_t::UTF_16LE:
            return get_buffer_view_utf16();
        case utf_encode_t::UTF_32BE:
        case utf_encode_t::UTF_32LE:
            return get_buffer_view_utf32();
        default:                   // LCOV_EXCL_LINE
            detail::unreachable(); // LCOV_EXCL_LINE
        }
    }

private:
    /// @brief The concrete implementation of get_buffer_view() for UTF-8 encoded inputs.
    /// @return View into the UTF-8 encoded input buffer contents.
    str_view get_buffer_view_utf8() {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_8);

        IterType current = m_begin;
        std::deque<IterType> cr_itrs {};
        while (current != m_end) {
            const auto first = static_cast<uint8_t>(*current);
            const uint32_t num_bytes = utf8::get_num_bytes(first);

            switch (num_bytes) {
            case 1:
                if FK_YAML_UNLIKELY (first == 0x0D /*CR*/) {
                    cr_itrs.emplace_back(current);
                }
                break;
            case 2: {
                const auto second = static_cast<uint8_t>(*++current);
                const bool is_valid = utf8::validate(first, second);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second});
                }
                break;
            }
            case 3: {
                const auto second = static_cast<uint8_t>(*++current);
                const auto third = static_cast<uint8_t>(*++current);
                const bool is_valid = utf8::validate(first, second, third);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second, third});
                }
                break;
            }
            case 4: {
                const auto second = static_cast<uint8_t>(*++current);
                const auto third = static_cast<uint8_t>(*++current);
                const auto fourth = static_cast<uint8_t>(*++current);
                const bool is_valid = utf8::validate(first, second, third, fourth);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second, third, fourth});
                }
                break;
            }
            default:           // LCOV_EXCL_LINE
                unreachable(); // LCOV_EXCL_LINE
            }

            ++current;
        }

        const bool is_contiguous_no_cr = cr_itrs.empty() && m_is_contiguous;
        if FK_YAML_LIKELY (is_contiguous_no_cr) {
            // The input iterators (begin, end) can be used as-is during parsing.
            FK_YAML_ASSERT(m_begin != m_end);
            return str_view {&*m_begin, static_cast<std::size_t>(std::distance(m_begin, m_end))};
        }

        m_buffer.reserve(std::distance(m_begin, m_end) - cr_itrs.size());

        current = m_begin;
        for (const auto& cr_itr : cr_itrs) {
            m_buffer.append(current, cr_itr);
            current = std::next(cr_itr);
        }
        m_buffer.append(current, m_end);

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

    /// @brief The concrete implementation of get_buffer_view() for UTF-16 encoded inputs.
    /// @return View into the UTF-8 encoded input buffer contents.
    str_view get_buffer_view_utf16() {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_16BE || m_encode_type == utf_encode_t::UTF_16LE);

        // Assume the input characters are all ASCII characters.
        // That's the most probably the case.
        m_buffer.reserve(std::distance(m_begin, m_end) / 2);

        int shift_bits[2] {0, 0};
        if (m_encode_type == utf_encode_t::UTF_16BE) {
            shift_bits[0] = 8;
        }
        else // m_encode_type == utf_encode_t::UTF_16LE
        {
            shift_bits[1] = 8;
        }

        std::array<char16_t, 2> encoded_buffer {{0, 0}};
        uint32_t encoded_buf_size {0};
        std::array<uint8_t, 4> utf8_buffer {{0, 0, 0, 0}};
        uint32_t utf8_buf_size {0};

        IterType current = m_begin;
        while (current != m_end || encoded_buf_size != 0) {
            while (current != m_end && encoded_buf_size < 2) {
                auto utf16 = static_cast<char16_t>(static_cast<uint8_t>(*current) << shift_bits[0]);
                utf16 |= static_cast<char16_t>(static_cast<uint8_t>(*++current) << shift_bits[1]);
                ++current;

                // skip appending CRs.
                if FK_YAML_LIKELY (utf16 != char16_t(0x000Du)) {
                    // NOLINTNEXTLINE(cppcoreguidelines-pro-bounds-constant-array-index)
                    encoded_buffer[encoded_buf_size++] = utf16;
                }
            }

            uint32_t consumed_size = 0;
            utf8::from_utf16(encoded_buffer, utf8_buffer, consumed_size, utf8_buf_size);

            if FK_YAML_LIKELY (consumed_size == 1) {
                encoded_buffer[0] = encoded_buffer[1];
            }
            encoded_buf_size -= consumed_size;

            m_buffer.append(reinterpret_cast<const char*>(utf8_buffer.data()), utf8_buf_size);
        }

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

    /// @brief The concrete implementation of get_buffer_view() for UTF-32 encoded inputs.
    /// @return View into the UTF-8 encoded input buffer contents.
    str_view get_buffer_view_utf32() {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_32BE || m_encode_type == utf_encode_t::UTF_32LE);

        // Assume the input characters are all ASCII characters.
        // That's the most probably the case.
        m_buffer.reserve(std::distance(m_begin, m_end) / 4);

        int shift_bits[4] {0, 0, 0, 0};
        if (m_encode_type == utf_encode_t::UTF_32BE) {
            shift_bits[0] = 24;
            shift_bits[1] = 16;
            shift_bits[2] = 8;
        }
        else // m_encode_type == utf_encode_t::UTF_32LE
        {
            shift_bits[1] = 8;
            shift_bits[2] = 16;
            shift_bits[3] = 24;
        }

        std::array<uint8_t, 4> utf8_buffer {{0, 0, 0, 0}};
        uint32_t utf8_buf_size {0};

        IterType current = m_begin;
        while (current != m_end) {
            auto utf32 = static_cast<char32_t>(*current << shift_bits[0]);
            ++current;
            utf32 |= static_cast<char32_t>(*current << shift_bits[1]);
            ++current;
            utf32 |= static_cast<char32_t>(*current << shift_bits[2]);
            ++current;
            utf32 |= static_cast<char32_t>(*current << shift_bits[3]);
            ++current;

            if FK_YAML_LIKELY (utf32 != char32_t(0x0000000Du)) {
                utf8::from_utf32(utf32, utf8_buffer, utf8_buf_size);
                m_buffer.append(reinterpret_cast<const char*>(utf8_buffer.data()), utf8_buf_size);
            }
        }

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

private:
    /// The iterator at the beginning of input.
    IterType m_begin {};
    /// The iterator at the end of input.
    IterType m_end {};
    /// The encoding type for this input adapter.
    utf_encode_t m_encode_type {utf_encode_t::UTF_8};
    /// The normalized owned buffer.
    std::string m_buffer;
    /// Whether ItrType is a contiguous iterator.
    bool m_is_contiguous {false};
};

#if FK_YAML_HAS_CHAR8_T

/// @brief An input adapter for iterators of type char8_t.
/// @tparam IterType An iterator type.
template <typename IterType>
class iterator_input_adapter<IterType, enable_if_t<is_iterator_of<IterType, char8_t>::value>> {
public:
    /// @brief Construct a new iterator_input_adapter object.
    iterator_input_adapter() = default;

    /// @brief Construct a new iterator_input_adapter object.
    /// @param begin The beginning of iterators.
    /// @param end The end of iterators.
    /// @param encode_type The encoding type for this input adapter.
    /// @param is_contiguous Whether iterators are contiguous or not.
    iterator_input_adapter(IterType begin, IterType end, utf_encode_t encode_type, bool is_contiguous) noexcept
        : m_begin(begin),
          m_end(end),
          m_encode_type(encode_type),
          m_is_contiguous(is_contiguous) {
        // char8_t characters must be encoded in the UTF-8 format.
        // See https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0482r6.html.
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_8);
    }

    // allow only move construct/assignment like other input adapters.
    iterator_input_adapter(const iterator_input_adapter&) = delete;
    iterator_input_adapter(iterator_input_adapter&& rhs) = default;
    iterator_input_adapter& operator=(const iterator_input_adapter&) = delete;
    iterator_input_adapter& operator=(iterator_input_adapter&&) = default;
    ~iterator_input_adapter() = default;

    /// @brief Get view into the input buffer contents.
    /// @return View into the input buffer contents.
    str_view get_buffer_view() {
        if FK_YAML_UNLIKELY (m_begin == m_end) {
            return {};
        }

        IterType current = m_begin;
        std::deque<IterType> cr_itrs {};
        while (current != m_end) {
            const auto first = static_cast<uint8_t>(*current);
            const uint32_t num_bytes = utf8::get_num_bytes(first);

            switch (num_bytes) {
            case 1:
                if FK_YAML_UNLIKELY (first == 0x0D /*CR*/) {
                    cr_itrs.emplace_back(current);
                }
                break;
            case 2: {
                const auto second = static_cast<uint8_t>(*++current);
                const bool is_valid = utf8::validate(first, second);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second});
                }
                break;
            }
            case 3: {
                const auto second = static_cast<uint8_t>(*++current);
                const auto third = static_cast<uint8_t>(*++current);
                const bool is_valid = utf8::validate(first, second, third);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second, third});
                }
                break;
            }
            case 4: {
                const auto second = static_cast<uint8_t>(*++current);
                const auto third = static_cast<uint8_t>(*++current);
                const auto fourth = static_cast<uint8_t>(*++current);
                const bool is_valid = utf8::validate(first, second, third, fourth);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second, third, fourth});
                }
                break;
            }
            default:           // LCOV_EXCL_LINE
                unreachable(); // LCOV_EXCL_LINE
            }

            ++current;
        }

        m_buffer.reserve(std::distance(m_begin, m_end) - cr_itrs.size());
        current = m_begin;
        for (const auto& cr_itr : cr_itrs) {
            std::transform(
                current, cr_itr, std::back_inserter(m_buffer), [](char8_t c) { return static_cast<char>(c); });
            current = std::next(cr_itr);
        }
        std::transform(current, m_end, std::back_inserter(m_buffer), [](char8_t c) { return static_cast<char>(c); });

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

private:
    /// The iterator at the beginning of input.
    IterType m_begin {};
    /// The iterator at the end of input.
    IterType m_end {};
    /// The encoding type for this input adapter.
    utf_encode_t m_encode_type {utf_encode_t::UTF_8};
    /// The normalized owned buffer.
    std::string m_buffer;
    /// Whether ItrType is a contiguous iterator.
    bool m_is_contiguous {false};
};

#endif // FK_YAML_HAS_CHAR8_T

/// @brief An input adapter for iterators of type char16_t.
/// @tparam IterType An iterator type.
template <typename IterType>
class iterator_input_adapter<IterType, enable_if_t<is_iterator_of<IterType, char16_t>::value>> {
public:
    /// @brief Construct a new iterator_input_adapter object.
    iterator_input_adapter() = default;

    /// @brief Construct a new iterator_input_adapter object.
    /// @param begin The beginning of iterators.
    /// @param end The end of iterators.
    /// @param encode_type The encoding type for this input adapter.
    /// @param is_contiguous Whether iterators are contiguous or not.
    iterator_input_adapter(IterType begin, IterType end, utf_encode_t encode_type, bool is_contiguous) noexcept
        : m_begin(begin),
          m_end(end),
          m_encode_type(encode_type),
          m_is_contiguous(is_contiguous) {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_16BE || m_encode_type == utf_encode_t::UTF_16LE);
    }

    // allow only move construct/assignment like other input adapters.
    iterator_input_adapter(const iterator_input_adapter&) = delete;
    iterator_input_adapter(iterator_input_adapter&& rhs) = default;
    iterator_input_adapter& operator=(const iterator_input_adapter&) = delete;
    iterator_input_adapter& operator=(iterator_input_adapter&&) = default;
    ~iterator_input_adapter() = default;

    /// @brief Get view into the input buffer contents.
    /// @return View into the input buffer contents.
    str_view get_buffer_view() {
        if FK_YAML_UNLIKELY (m_begin == m_end) {
            return {};
        }

        const int shift_bits = (m_encode_type == utf_encode_t::UTF_16BE) ? 0 : 8;

        std::array<char16_t, 2> encoded_buffer {{0, 0}};
        uint32_t encoded_buf_size {0};
        std::array<uint8_t, 4> utf8_buffer {{0, 0, 0, 0}};
        uint32_t utf8_buf_size {0};

        // Assume the input characters are all ASCII characters.
        // That's the most probably the case.
        m_buffer.reserve(std::distance(m_begin, m_end));

        IterType current = m_begin;
        while (current != m_end || encoded_buf_size != 0) {
            while (current != m_end && encoded_buf_size < 2) {
                char16_t utf16 = *current;
                ++current;
                utf16 = static_cast<char16_t>(((utf16 & 0x00FFu) << shift_bits) | ((utf16 & 0xFF00u) >> shift_bits));

                if FK_YAML_LIKELY (utf16 != char16_t(0x000Du)) {
                    // NOLINTNEXTLINE(cppcoreguidelines-pro-bounds-constant-array-index)
                    encoded_buffer[encoded_buf_size++] = utf16;
                }
            }

            uint32_t consumed_size = 0;
            utf8::from_utf16(encoded_buffer, utf8_buffer, consumed_size, utf8_buf_size);

            if FK_YAML_LIKELY (consumed_size == 1) {
                encoded_buffer[0] = encoded_buffer[1];
                encoded_buffer[1] = 0;
            }
            encoded_buf_size -= consumed_size;

            m_buffer.append(reinterpret_cast<const char*>(utf8_buffer.data()), utf8_buf_size);
        }

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

private:
    /// The iterator at the beginning of input.
    IterType m_begin {};
    /// The iterator at the end of input.
    IterType m_end {};
    /// The encoding type for this input adapter.
    utf_encode_t m_encode_type {utf_encode_t::UTF_16BE};
    /// The normalized owned buffer.
    std::string m_buffer;
    /// Whether ItrType is a contiguous iterator.
    bool m_is_contiguous {false};
};

/// @brief An input adapter for iterators of type char32_t.
/// @tparam IterType An iterator type.
template <typename IterType>
class iterator_input_adapter<IterType, enable_if_t<is_iterator_of<IterType, char32_t>::value>> {
public:
    /// @brief Construct a new iterator_input_adapter object.
    iterator_input_adapter() = default;

    /// @brief Construct a new iterator_input_adapter object.
    /// @param begin The beginning of iterators.
    /// @param end The end of iterators.
    /// @param encode_type The encoding type for this input adapter.
    /// @param is_contiguous Whether iterators are contiguous or not.
    iterator_input_adapter(IterType begin, IterType end, utf_encode_t encode_type, bool is_contiguous) noexcept
        : m_begin(begin),
          m_end(end),
          m_encode_type(encode_type),
          m_is_contiguous(is_contiguous) {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_32BE || m_encode_type == utf_encode_t::UTF_32LE);
    }

    // allow only move construct/assignment like other input adapters.
    iterator_input_adapter(const iterator_input_adapter&) = delete;
    iterator_input_adapter(iterator_input_adapter&& rhs) = default;
    iterator_input_adapter& operator=(const iterator_input_adapter&) = delete;
    iterator_input_adapter& operator=(iterator_input_adapter&&) = default;
    ~iterator_input_adapter() = default;

    /// @brief Get view into the input buffer contents.
    /// @return View into the input buffer contents.
    str_view get_buffer_view() {
        if FK_YAML_UNLIKELY (m_begin == m_end) {
            return {};
        }

        int shift_bits[4] {0, 0, 0, 0};
        if (m_encode_type == utf_encode_t::UTF_32LE) {
            shift_bits[0] = 24;
            shift_bits[1] = 8;
            shift_bits[2] = 8;
            shift_bits[3] = 24;
        }

        std::array<uint8_t, 4> utf8_buffer {{0, 0, 0, 0}};
        uint32_t utf8_buf_size {0};

        // Assume the input characters are all ASCII characters.
        // That's the most probably the case.
        m_buffer.reserve(std::distance(m_begin, m_end));

        IterType current = m_begin;
        while (current != m_end) {
            const char32_t tmp = *current;
            ++current;
            const auto utf32 = static_cast<char32_t>(
                ((tmp & 0xFF000000u) >> shift_bits[0]) | ((tmp & 0x00FF0000u) >> shift_bits[1]) |
                ((tmp & 0x0000FF00u) << shift_bits[2]) | ((tmp & 0x000000FFu) << shift_bits[3]));

            if FK_YAML_UNLIKELY (utf32 != static_cast<char32_t>(0x0000000Du)) {
                utf8::from_utf32(utf32, utf8_buffer, utf8_buf_size);
                m_buffer.append(reinterpret_cast<const char*>(utf8_buffer.data()), utf8_buf_size);
            }
        }

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

private:
    /// The iterator at the beginning of input.
    IterType m_begin {};
    /// The iterator at the end of input.
    IterType m_end {};
    /// The encoding type for this input adapter.
    utf_encode_t m_encode_type {utf_encode_t::UTF_32BE};
    /// The normalized owned buffer.
    std::string m_buffer;
    /// Whether ItrType is a contiguous iterator.
    bool m_is_contiguous {false};
};

/// @brief An input adapter for C-style file handles.
class file_input_adapter {
public:
    /// @brief Construct a new file_input_adapter object.
    file_input_adapter() = default;

    /// @brief Construct a new file_input_adapter object.
    /// @note
    /// This class doesn't call fopen() nor fclose().
    /// It's user's responsibility to call those functions.
    /// @param file A file handle for this adapter. (A non-null pointer is assumed.)
    /// @param encode_type The encoding type for this input adapter.
    explicit file_input_adapter(std::FILE* file, utf_encode_t encode_type) noexcept
        : m_file(file),
          m_encode_type(encode_type) {
    }

    // allow only move construct/assignment
    file_input_adapter(const file_input_adapter&) = delete;
    file_input_adapter(file_input_adapter&& rhs) = default;
    file_input_adapter& operator=(const file_input_adapter&) = delete;
    file_input_adapter& operator=(file_input_adapter&&) = default;
    ~file_input_adapter() = default;

    /// @brief Get view into the input buffer contents.
    /// @return View into the input buffer contents.
    str_view get_buffer_view() {
        switch (m_encode_type) {
        case utf_encode_t::UTF_8:
            return get_buffer_view_utf8();
        case utf_encode_t::UTF_16BE:
        case utf_encode_t::UTF_16LE:
            return get_buffer_view_utf16();
        case utf_encode_t::UTF_32BE:
        case utf_encode_t::UTF_32LE:
            return get_buffer_view_utf32();
        default:                   // LCOV_EXCL_LINE
            detail::unreachable(); // LCOV_EXCL_LINE
        }
    }

private:
    /// @brief The concrete implementation of get_buffer_view() for UTF-8 encoded inputs.
    /// @return View into the UTF-8 encoded input buffer contents.
    str_view get_buffer_view_utf8() {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_8);

        m_buffer.clear();
        char tmp_buf[256] {};
        constexpr std::size_t buf_size = sizeof(tmp_buf) / sizeof(tmp_buf[0]);
        std::size_t read_size = 0;
        while ((read_size = std::fread(&tmp_buf[0], sizeof(char), buf_size, m_file)) > 0) {
            char* p_current = &tmp_buf[0];
            char* p_end = p_current + read_size;

            // copy tmp_buf to m_buffer, dropping CRs.
            char* p_cr = p_current;
            do {
                if FK_YAML_UNLIKELY (*p_cr == '\r') {
                    m_buffer.append(p_current, p_cr);
                    p_current = p_cr + 1;
                }
                ++p_cr;
            } while (p_cr != p_end);

            m_buffer.append(p_current, p_end);
        }

        if FK_YAML_UNLIKELY (m_buffer.empty()) {
            return {};
        }

        auto current = m_buffer.begin();
        auto end = m_buffer.end();
        while (current != end) {
            const auto first = static_cast<uint8_t>(*current++);
            const uint32_t num_bytes = utf8::get_num_bytes(first);

            switch (num_bytes) {
            case 1:
                break;
            case 2: {
                const auto second = static_cast<uint8_t>(*current++);
                const bool is_valid = utf8::validate(first, second);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second});
                }
                break;
            }
            case 3: {
                const auto second = static_cast<uint8_t>(*current++);
                const auto third = static_cast<uint8_t>(*current++);
                const bool is_valid = utf8::validate(first, second, third);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second, third});
                }
                break;
            }
            case 4: {
                const auto second = static_cast<uint8_t>(*current++);
                const auto third = static_cast<uint8_t>(*current++);
                const auto fourth = static_cast<uint8_t>(*current++);
                const bool is_valid = utf8::validate(first, second, third, fourth);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second, third, fourth});
                }
                break;
            }
            default:           // LCOV_EXCL_LINE
                unreachable(); // LCOV_EXCL_LINE
            }
        }

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

    /// @brief The concrete implementation of get_buffer_view() for UTF-16 encoded inputs.
    /// @return View into the UTF-8 encoded input buffer contents.
    str_view get_buffer_view_utf16() {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_16BE || m_encode_type == utf_encode_t::UTF_16LE);

        int shift_bits[2] {0, 0};
        if (m_encode_type == utf_encode_t::UTF_16BE) {
            shift_bits[0] = 8;
        }
        else { // m_encode_type == utf_encode_t::UTF_16LE
            shift_bits[1] = 8;
        }

        char chars[2] = {0, 0};
        std::array<char16_t, 2> encoded_buffer {{0, 0}};
        uint32_t encoded_buf_size {0};
        std::array<uint8_t, 4> utf8_buffer {{0, 0, 0, 0}};
        uint32_t utf8_buf_size {0};

        while (std::feof(m_file) == 0) {
            while (encoded_buf_size < 2 && std::fread(&chars[0], sizeof(char), 2, m_file) == 2) {
                const auto utf16 = static_cast<char16_t>(
                    (static_cast<uint8_t>(chars[0]) << shift_bits[0]) |
                    (static_cast<uint8_t>(chars[1]) << shift_bits[1]));
                if FK_YAML_LIKELY (utf16 != static_cast<char16_t>(0x000Du)) {
                    // NOLINTNEXTLINE(cppcoreguidelines-pro-bounds-constant-array-index)
                    encoded_buffer[encoded_buf_size++] = utf16;
                }
            }

            uint32_t consumed_size = 0;
            utf8::from_utf16(encoded_buffer, utf8_buffer, consumed_size, utf8_buf_size);

            if FK_YAML_LIKELY (consumed_size == 1) {
                encoded_buffer[0] = encoded_buffer[1];
            }
            encoded_buf_size -= consumed_size;

            m_buffer.append(reinterpret_cast<const char*>(utf8_buffer.data()), utf8_buf_size);
        }

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

    /// @brief The concrete implementation of get_buffer_view() for UTF-32 encoded inputs.
    /// @return View into the UTF-8 encoded input buffer contents.
    str_view get_buffer_view_utf32() {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_32BE || m_encode_type == utf_encode_t::UTF_32LE);

        int shift_bits[4] {0, 0, 0, 0};
        if (m_encode_type == utf_encode_t::UTF_32BE) {
            shift_bits[0] = 24;
            shift_bits[1] = 16;
            shift_bits[2] = 8;
        }
        else { // m_encode_type == utf_encode_t::UTF_32LE
            shift_bits[1] = 8;
            shift_bits[2] = 16;
            shift_bits[3] = 24;
        }

        char chars[4] = {0, 0, 0, 0};
        std::array<uint8_t, 4> utf8_buffer {{0, 0, 0, 0}};
        uint32_t utf8_buf_size {0};

        while (std::feof(m_file) == 0) {
            const std::size_t size = std::fread(&chars[0], sizeof(char), 4, m_file);
            if (size != 4) {
                break;
            }

            const auto utf32 = static_cast<char32_t>(
                (static_cast<uint8_t>(chars[0]) << shift_bits[0]) | (static_cast<uint8_t>(chars[1]) << shift_bits[1]) |
                (static_cast<uint8_t>(chars[2]) << shift_bits[2]) | (static_cast<uint8_t>(chars[3]) << shift_bits[3]));

            if FK_YAML_LIKELY (utf32 != char32_t(0x0000000Du)) {
                utf8::from_utf32(utf32, utf8_buffer, utf8_buf_size);
                m_buffer.append(reinterpret_cast<const char*>(utf8_buffer.data()), utf8_buf_size);
            }
        }

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

private:
    /// A pointer to the input file handle.
    std::FILE* m_file {nullptr};
    /// The encoding type for this input adapter.
    utf_encode_t m_encode_type {utf_encode_t::UTF_8};
    /// The normalized owned buffer.
    std::string m_buffer;
};

/// @brief An input adapter for streams
class stream_input_adapter {
public:
    /// @brief Construct a new stream_input_adapter object.
    stream_input_adapter() = default;

    /// @brief Construct a new stream_input_adapter object.
    /// @param is A reference to the target input stream.
    /// @param encode_type The encoding type for this input adapter.
    explicit stream_input_adapter(std::istream& is, utf_encode_t encode_type) noexcept
        : m_istream(&is),
          m_encode_type(encode_type) {
    }

    // allow only move construct/assignment
    stream_input_adapter(const stream_input_adapter&) = delete;
    stream_input_adapter& operator=(const stream_input_adapter&) = delete;
    stream_input_adapter(stream_input_adapter&&) = default;
    stream_input_adapter& operator=(stream_input_adapter&&) = default;
    ~stream_input_adapter() = default;

    /// @brief Get view into the input buffer contents.
    /// @return View into the input buffer contents.
    str_view get_buffer_view() {
        switch (m_encode_type) {
        case utf_encode_t::UTF_8:
            return get_buffer_view_utf8();
        case utf_encode_t::UTF_16BE:
        case utf_encode_t::UTF_16LE:
            return get_buffer_view_utf16();
        case utf_encode_t::UTF_32BE:
        case utf_encode_t::UTF_32LE:
            return get_buffer_view_utf32();
        default:                   // LCOV_EXCL_LINE
            detail::unreachable(); // LCOV_EXCL_LINE
        }
    }

private:
    /// @brief The concrete implementation of get_buffer_view() for UTF-8 encoded inputs.
    /// @return View into the UTF-8 encoded input buffer contents.
    str_view get_buffer_view_utf8() {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_8);

        m_buffer.clear();
        char tmp_buf[256] {};
        do {
            m_istream->read(&tmp_buf[0], 256);
            const auto read_size = static_cast<std::size_t>(m_istream->gcount());
            if FK_YAML_UNLIKELY (read_size == 0) {
                break;
            }

            char* p_current = &tmp_buf[0];
            char* p_end = p_current + read_size;

            // copy tmp_buf to m_buffer, dropping CRs.
            char* p_cr = p_current;
            do {
                if FK_YAML_UNLIKELY (*p_cr == '\r') {
                    m_buffer.append(p_current, p_cr);
                    p_current = p_cr + 1;
                }
                ++p_cr;
            } while (p_cr != p_end);

            m_buffer.append(p_current, p_end);
        } while (!m_istream->eof());

        if FK_YAML_UNLIKELY (m_buffer.empty()) {
            return {};
        }

        auto current = m_buffer.begin();
        auto end = m_buffer.end();
        while (current != end) {
            const auto first = static_cast<uint8_t>(*current++);
            const uint32_t num_bytes = utf8::get_num_bytes(first);

            switch (num_bytes) {
            case 1:
                break;
            case 2: {
                const auto second = static_cast<uint8_t>(*current++);
                const bool is_valid = utf8::validate(first, second);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second});
                }
                break;
            }
            case 3: {
                const auto second = static_cast<uint8_t>(*current++);
                const auto third = static_cast<uint8_t>(*current++);
                const bool is_valid = utf8::validate(first, second, third);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second, third});
                }
                break;
            }
            case 4: {
                const auto second = static_cast<uint8_t>(*current++);
                const auto third = static_cast<uint8_t>(*current++);
                const auto fourth = static_cast<uint8_t>(*current++);
                const bool is_valid = utf8::validate(first, second, third, fourth);
                if FK_YAML_UNLIKELY (!is_valid) {
                    throw fkyaml::invalid_encoding("Invalid UTF-8 encoding.", {first, second, third, fourth});
                }
                break;
            }
            default:           // LCOV_EXCL_LINE
                unreachable(); // LCOV_EXCL_LINE
            }
        }

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

    /// @brief The concrete implementation of get_buffer_view() for UTF-16 encoded inputs.
    /// @return View into the UTF-8 encoded input buffer contents.
    str_view get_buffer_view_utf16() {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_16BE || m_encode_type == utf_encode_t::UTF_16LE);

        int shift_bits[2] {0, 0};
        if (m_encode_type == utf_encode_t::UTF_16BE) {
            shift_bits[0] = 8;
        }
        else { // m_encode_type == utf_encode_t::UTF_16LE
            shift_bits[1] = 8;
        }

        char chars[2] = {0, 0};
        std::array<char16_t, 2> encoded_buffer {{0, 0}};
        uint32_t encoded_buf_size {0};
        std::array<uint8_t, 4> utf8_buffer {{0, 0, 0, 0}};
        uint32_t utf8_buf_size {0};

        do {
            while (encoded_buf_size < 2) {
                m_istream->read(&chars[0], 2);
                const std::streamsize size = m_istream->gcount();
                if FK_YAML_UNLIKELY (size != 2) {
                    break;
                }

                const auto utf16 = static_cast<char16_t>(
                    (static_cast<uint8_t>(chars[0]) << shift_bits[0]) |
                    (static_cast<uint8_t>(chars[1]) << shift_bits[1]));

                if FK_YAML_LIKELY (utf16 != static_cast<char16_t>(0x000Du)) {
                    // NOLINTNEXTLINE(cppcoreguidelines-pro-bounds-constant-array-index)
                    encoded_buffer[encoded_buf_size++] = utf16;
                }
            }

            uint32_t consumed_size = 0;
            utf8::from_utf16(encoded_buffer, utf8_buffer, consumed_size, utf8_buf_size);

            if FK_YAML_LIKELY (consumed_size == 1) {
                encoded_buffer[0] = encoded_buffer[1];
            }
            encoded_buf_size -= consumed_size;

            m_buffer.append(reinterpret_cast<const char*>(utf8_buffer.data()), utf8_buf_size);
        } while (!m_istream->eof());

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

    /// @brief The concrete implementation of get_buffer_view() for UTF-32 encoded inputs.
    /// @return View into the UTF-8 encoded input buffer contents.
    str_view get_buffer_view_utf32() {
        FK_YAML_ASSERT(m_encode_type == utf_encode_t::UTF_32BE || m_encode_type == utf_encode_t::UTF_32LE);

        int shift_bits[4] {0, 0, 0, 0};
        if (m_encode_type == utf_encode_t::UTF_32BE) {
            shift_bits[0] = 24;
            shift_bits[1] = 16;
            shift_bits[2] = 8;
        }
        else { // m_encode_type == utf_encode_t::UTF_32LE
            shift_bits[1] = 8;
            shift_bits[2] = 16;
            shift_bits[3] = 24;
        }

        char chars[4] = {0, 0, 0, 0};
        std::array<uint8_t, 4> utf8_buffer {{0, 0, 0, 0}};
        uint32_t utf8_buf_size {0};

        do {
            m_istream->read(&chars[0], 4);
            const std::streamsize size = m_istream->gcount();
            if FK_YAML_UNLIKELY (size != 4) {
                break;
            }

            const auto utf32 = static_cast<char32_t>(
                (static_cast<uint8_t>(chars[0]) << shift_bits[0]) | (static_cast<uint8_t>(chars[1]) << shift_bits[1]) |
                (static_cast<uint8_t>(chars[2]) << shift_bits[2]) | (static_cast<uint8_t>(chars[3]) << shift_bits[3]));

            if FK_YAML_LIKELY (utf32 != char32_t(0x0000000Du)) {
                utf8::from_utf32(utf32, utf8_buffer, utf8_buf_size);
                m_buffer.append(reinterpret_cast<const char*>(utf8_buffer.data()), utf8_buf_size);
            }
        } while (!m_istream->eof());

        return str_view {m_buffer.begin(), m_buffer.end()};
    }

private:
    /// A pointer to the input stream object.
    std::istream* m_istream {nullptr};
    /// The encoding type for this input adapter.
    utf_encode_t m_encode_type {utf_encode_t::UTF_8};
    /// The normalized owned buffer.
    std::string m_buffer;
};

/////////////////////////////////
//   input_adapter providers   //
/////////////////////////////////

/// @brief A concrete factory method for iterator_input_adapter objects with iterators.
/// @tparam ItrType An iterator type.
/// @param begin The beginning of iterators.
/// @param end The end of iterators.
/// @param is_contiguous Whether iterators refer to a contiguous byte array.
/// @return An iterator_input_adapter object for the target iterator type.
template <typename ItrType>
inline iterator_input_adapter<ItrType> create_iterator_input_adapter(ItrType begin, ItrType end, bool is_contiguous) {
    const utf_encode_t encode_type = utf_encode_detector<ItrType>::detect(begin, end);
    return iterator_input_adapter<ItrType>(begin, end, encode_type, is_contiguous);
}

/// @brief A factory method for iterator_input_adapter objects with iterator values.
/// @tparam ItrType An iterator type.
/// @param begin The beginning of iterators.
/// @param end The end of iterators.
/// @return iterator_input_adapter<ItrType> An iterator_input_adapter object for the target iterator type.
template <typename ItrType>
inline iterator_input_adapter<ItrType> input_adapter(ItrType begin, ItrType end) {
    bool is_contiguous = true;
    const auto size = std::distance(begin, end);

    // Check if `begin` & `end` are contiguous iterators.
    // Getting distance between begin and (end - 1) avoids dereferencing an invalid sentinel.
    if FK_YAML_LIKELY (size > 0) {
        using char_ptr_t = remove_cvref_t<typename std::iterator_traits<ItrType>::pointer>;
        char_ptr_t p_begin = &*begin;
        char_ptr_t p_second_last = &*std::next(begin, size - 1);
        is_contiguous = (p_second_last - p_begin == size);
    }
    return create_iterator_input_adapter(begin, end, is_contiguous);
}

/// @brief A factory method for iterator_input_adapter objects with C-style arrays.
/// @tparam T A type of arrayed objects.
/// @tparam N A size of an array.
/// @return decltype(input_adapter(array, array + N)) An iterator_input_adapter object for the target array.
template <typename T, std::size_t N>
inline auto input_adapter(T (&array)[N]) -> decltype(create_iterator_input_adapter(array, array + (N - 1), true)) {
    return create_iterator_input_adapter(array, array + (N - 1), true);
}

/// @brief A namespace to implement container_input_adapter_factory for internal use.
namespace input_adapter_factory {

using std::begin;
using std::end;

/// @brief A factory of input adapters for containers.
/// @tparam ContainerType A container type.
/// @tparam typename N/A
template <typename ContainerType, typename = void>
struct container_input_adapter_factory {};

/// @brief A partial specialization of container_input_adapter_factory if begin()/end() are available for ContainerType.
/// @tparam ContainerType A container type.
template <typename ContainerType>
struct container_input_adapter_factory<
    ContainerType, void_t<decltype(begin(std::declval<ContainerType>()), end(std::declval<ContainerType>()))>> {
    /// A type for resulting input adapter object.
    using adapter_type =
        decltype(input_adapter(begin(std::declval<ContainerType>()), end(std::declval<ContainerType>())));

    /// @brief A factory method of input adapter objects for the target container objects.
    /// @param container A container-like input object.
    /// @return adapter_type An iterator_input_adapter object.
    static adapter_type create(const ContainerType& container) {
        return input_adapter(begin(container), end(container));
    }
};

} // namespace input_adapter_factory

/// @brief A factory method for iterator_input_adapter objects with containers.
/// @tparam ContainerType A container type.
/// @param container A container object.
/// @return input_adapter_factory::container_input_adapter_factory<ContainerType>::adapter_type
template <typename ContainerType>
inline typename input_adapter_factory::container_input_adapter_factory<ContainerType>::adapter_type input_adapter(
    const ContainerType& container) {
    return input_adapter_factory::container_input_adapter_factory<ContainerType>::create(container);
}

/// @brief A factory method for file_input_adapter objects with C-style file handles.
/// @param file A file handle.
/// @return file_input_adapter A file_input_adapter object.
inline file_input_adapter input_adapter(std::FILE* file) {
    if FK_YAML_UNLIKELY (!file) {
        throw fkyaml::exception("Invalid FILE object pointer.");
    }

    const utf_encode_t encode_type = file_utf_encode_detector::detect(file);
    return file_input_adapter(file, encode_type);
}

/// @brief A factory method for stream_input_adapter objects with std::istream objects.
/// @param stream An input stream.
/// @return stream_input_adapter A stream_input_adapter object.
inline stream_input_adapter input_adapter(std::istream& stream) {
    if FK_YAML_UNLIKELY (!stream.good()) {
        throw fkyaml::exception("Invalid stream.");
    }

    const utf_encode_t encode_type = stream_utf_encode_detector::detect(stream);
    return stream_input_adapter(stream, encode_type);
}

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_INPUT_INPUT_ADAPTER_HPP */

// #include <fkYAML/detail/iterator.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_ITERATOR_HPP
#define FK_YAML_DETAIL_ITERATOR_HPP

#include <cstddef>
#include <iterator>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/node_traits.hpp>

// #include <fkYAML/exception.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief The template definitions of type information used in @ref Iterator class
/// @tparam ValueType The type of iterated elements.
template <typename ValueType>
struct iterator_traits {
    /// A type of iterated elements.
    using value_type = typename ValueType::value_type;
    /// A type to represent difference between iterators.
    using difference_type = typename ValueType::difference_type;
    /// A type of an element pointer.
    using pointer = typename ValueType::pointer;
    /// A type of reference to an element.
    using reference = typename ValueType::reference;
};

/// @brief A specialization of @ref iterator_traits for constant value types.
/// @tparam ValueType The type of iterated elements.
template <typename ValueType>
struct iterator_traits<const ValueType> {
    /// A type of iterated elements.
    using value_type = typename ValueType::value_type;
    /// A type to represent difference between iterators.
    using difference_type = typename ValueType::difference_type;
    /// A type of a constant element pointer.
    using pointer = typename ValueType::const_pointer;
    /// A type of constant reference to an element.
    using reference = typename ValueType::const_reference;
};

/// @brief Definitions of iterator types for iterators internally held.
enum class iterator_t : std::uint8_t {
    SEQUENCE, //!< sequence iterator type.
    MAPPING,  //!< mapping iterator type.
};

/// @brief The actual storage for iterators internally held in iterator.
template <typename BasicNodeType>
struct iterator_holder {
    static_assert(
        is_basic_node<BasicNodeType>::value,
        "iterator_holder class only accepts a basic_node as its template parameter.");

    /// A sequence iterator object.
    typename BasicNodeType::sequence_type::iterator sequence_iterator {};
    /// A mapping iterator object.
    typename BasicNodeType::mapping_type::iterator mapping_iterator {};
};

/// @brief A class which holds iterators either of sequence or mapping type
/// @tparam ValueType The type of iterated elements.
template <typename ValueType>
class iterator {
    /// @brief The iterator type with ValueType of different const-ness.
    using other_iterator_type = typename std::conditional<
        std::is_const<ValueType>::value, iterator<typename std::remove_const<ValueType>::type>,
        iterator<const ValueType>>::type;

    friend other_iterator_type;

public:
    /// A type for iterator traits of instantiated @Iterator template class.
    using iterator_traits_type = iterator_traits<ValueType>;

    /// A type for iterator category tag.
    using iterator_category = std::bidirectional_iterator_tag;
    /// A type of iterated element.
    using value_type = typename iterator_traits_type::value_type;
    /// A type to represent differences between iterators.
    using difference_type = typename iterator_traits_type::difference_type;
    /// A type of an element pointer.
    using pointer = typename iterator_traits_type::pointer;
    /// A type of reference to an element.
    using reference = typename iterator_traits_type::reference;

    static_assert(is_basic_node<value_type>::value, "iterator class only accepts a basic_node as its value type.");

    /// @brief Constructs an iterator object.
    iterator() = default;

    /// @brief Construct a new iterator object with sequence iterator object.
    /// @param[in] itr An sequence iterator object.
    iterator(const typename value_type::sequence_type::iterator& itr) noexcept {
        m_iterator_holder.sequence_iterator = itr;
    }

    /// @brief Construct a new iterator object with mapping iterator object.
    /// @param[in] itr An mapping iterator object.
    iterator(const typename value_type::mapping_type::iterator& itr) noexcept
        : m_inner_iterator_type(iterator_t::MAPPING) {
        m_iterator_holder.mapping_iterator = itr;
    }

    /// @brief Copy constructs an iterator.
    iterator(const iterator&) = default;

    /// @brief Copy constructs an iterator from another iterator with different const-ness in ValueType.
    /// @note This copy constructor is not defined if ValueType is not const to avoid const removal from ValueType.
    /// @tparam OtherIterator The iterator type to copy from.
    /// @param other An iterator to copy from with different const-ness in ValueType.
    template <
        typename OtherIterator,
        enable_if_t<
            conjunction<std::is_same<OtherIterator, other_iterator_type>, std::is_const<ValueType>>::value, int> = 0>
    iterator(const OtherIterator& other) noexcept
        : m_inner_iterator_type(other.m_inner_iterator_type),
          m_iterator_holder(other.m_iterator_holder) {
    }

    /// @brief A copy assignment operator of the iterator class.
    iterator& operator=(const iterator&) = default;

    template <
        typename OtherIterator,
        enable_if_t<
            conjunction<std::is_same<OtherIterator, other_iterator_type>, std::is_const<ValueType>>::value, int> = 0>
    iterator& operator=(const OtherIterator& other) noexcept {
        m_inner_iterator_type = other.m_inner_iterator_type;
        m_iterator_holder = other.m_iterator_holder;
        return *this;
    }

    /// @brief Move constructs an iterator.
    iterator(iterator&&) = default;

    /// @brief A move assignment operator of the iterator class.
    iterator& operator=(iterator&&) = default;

    /// @brief Destroys an iterator.
    ~iterator() = default;

    /// @brief An arrow operator of the iterator class.
    /// @return pointer A pointer to the BasicNodeType object internally referenced by the actual iterator object.
    pointer operator->() noexcept {
        if (m_inner_iterator_type == iterator_t::SEQUENCE) {
            return &(*(m_iterator_holder.sequence_iterator));
        }

        // m_inner_iterator_type == iterator_t::MAPPING:
        return &(m_iterator_holder.mapping_iterator->second);
    }

    /// @brief A dereference operator of the iterator class.
    /// @return reference Reference to the Node object internally referenced by the actual iterator object.
    reference operator*() const noexcept {
        if (m_inner_iterator_type == iterator_t::SEQUENCE) {
            return *(m_iterator_holder.sequence_iterator);
        }

        // m_inner_iterator_type == iterator_t::MAPPING:
        return m_iterator_holder.mapping_iterator->second;
    }

    /// @brief A compound assignment operator by sum of the Iterator class.
    /// @param i The difference from this Iterator object with which it moves forward.
    /// @return Iterator& Reference to this Iterator object.
    iterator& operator+=(difference_type i) noexcept {
        switch (m_inner_iterator_type) {
        case iterator_t::SEQUENCE:
            std::advance(m_iterator_holder.sequence_iterator, i);
            break;
        case iterator_t::MAPPING:
            std::advance(m_iterator_holder.mapping_iterator, i);
            break;
        }
        return *this;
    }

    /// @brief A plus operator of the iterator class.
    /// @param i The difference from this iterator object.
    /// @return iterator An iterator object which has been added @a i.
    iterator operator+(difference_type i) const noexcept {
        auto result = *this;
        result += i;
        return result;
    }

    /// @brief An pre-increment operator of the iterator class.
    /// @return iterator& Reference to this iterator object.
    iterator& operator++() noexcept {
        switch (m_inner_iterator_type) {
        case iterator_t::SEQUENCE:
            std::advance(m_iterator_holder.sequence_iterator, 1);
            break;
        case iterator_t::MAPPING:
            std::advance(m_iterator_holder.mapping_iterator, 1);
            break;
        }
        return *this;
    }

    /// @brief A post-increment operator of the iterator class.
    /// @return iterator An iterator object which has been incremented.
    iterator operator++(int) & noexcept {
        auto result = *this;
        ++(*this);
        return result;
    }

    /// @brief A compound assignment operator by difference of the iterator class.
    /// @param i The difference from this iterator object with which it moves backward.
    /// @return iterator& Reference to this iterator object.
    iterator& operator-=(difference_type i) noexcept {
        return operator+=(-i);
    }

    /// @brief A minus operator of the iterator class.
    /// @param i The difference from this iterator object.
    /// @return iterator An iterator object from which has been subtracted @ i.
    iterator operator-(difference_type i) const noexcept {
        auto result = *this;
        result -= i;
        return result;
    }

    /// @brief A pre-decrement operator of the iterator class.
    /// @return iterator& Reference to this iterator object.
    iterator& operator--() noexcept {
        switch (m_inner_iterator_type) {
        case iterator_t::SEQUENCE:
            std::advance(m_iterator_holder.sequence_iterator, -1);
            break;
        case iterator_t::MAPPING:
            std::advance(m_iterator_holder.mapping_iterator, -1);
            break;
        }
        return *this;
    }

    /// @brief A post-decrement operator of the iterator class
    /// @return iterator An iterator object which has been decremented.
    iterator operator--(int) & noexcept {
        auto result = *this;
        --(*this);
        return result;
    }

    /// @brief An equal-to operator of the iterator class.
    /// @param rhs An iterator object to be compared with this iterator object.
    /// @return true  This iterator object is equal to the other.
    /// @return false This iterator object is not equal to the other.
    template <
        typename Iterator,
        enable_if_t<
            disjunction<std::is_same<Iterator, iterator>, std::is_same<Iterator, other_iterator_type>>::value, int> = 0>
    bool operator==(const Iterator& rhs) const {
        if FK_YAML_UNLIKELY (m_inner_iterator_type != rhs.m_inner_iterator_type) {
            throw fkyaml::exception("Cannot compare iterators of different container types.");
        }

        if (m_inner_iterator_type == iterator_t::SEQUENCE) {
            return (m_iterator_holder.sequence_iterator == rhs.m_iterator_holder.sequence_iterator);
        }

        // m_inner_iterator_type == iterator_t::MAPPING
        return (m_iterator_holder.mapping_iterator == rhs.m_iterator_holder.mapping_iterator);
    }

    /// @brief An not-equal-to operator of the iterator class.
    /// @param rhs An iterator object to be compared with this iterator object.
    /// @return true  This iterator object is not equal to the other.
    /// @return false This iterator object is equal to the other.
    template <
        typename Iterator,
        enable_if_t<
            disjunction<std::is_same<Iterator, iterator>, std::is_same<Iterator, other_iterator_type>>::value, int> = 0>
    bool operator!=(const Iterator& rhs) const {
        return !operator==(rhs);
    }

    /// @brief A less-than operator of the iterator class.
    /// @param rhs An iterator object to be compared with this iterator object.
    /// @return true  This iterator object is less than the other.
    /// @return false This iterator object is not less than the other.
    template <
        typename Iterator,
        enable_if_t<
            disjunction<std::is_same<Iterator, iterator>, std::is_same<Iterator, other_iterator_type>>::value, int> = 0>
    bool operator<(const Iterator& rhs) const {
        if FK_YAML_UNLIKELY (m_inner_iterator_type != rhs.m_inner_iterator_type) {
            throw fkyaml::exception("Cannot compare iterators of different container types.");
        }

        if FK_YAML_UNLIKELY (m_inner_iterator_type == iterator_t::MAPPING) {
            throw fkyaml::exception("Cannot compare order of iterators of the mapping container type");
        }

        return (m_iterator_holder.sequence_iterator < rhs.m_iterator_holder.sequence_iterator);
    }

    ///  @brief A less-than-or-equal-to operator of the iterator class.
    ///  @param rhs An iterator object to be compared with this iterator object.
    ///  @return true  This iterator object is either less than or equal to the other.
    ///  @return false This iterator object is neither less than nor equal to the other.
    template <
        typename Iterator,
        enable_if_t<
            disjunction<std::is_same<Iterator, iterator>, std::is_same<Iterator, other_iterator_type>>::value, int> = 0>
    bool operator<=(const Iterator& rhs) const {
        return !rhs.operator<(*this);
    }

    /// @brief A greater-than operator of the iterator class.
    /// @param rhs An iterator object to be compared with this iterator object.
    /// @return true  This iterator object is greater than the other.
    /// @return false This iterator object is not greater than the other.
    template <
        typename Iterator,
        enable_if_t<
            disjunction<std::is_same<Iterator, iterator>, std::is_same<Iterator, other_iterator_type>>::value, int> = 0>
    bool operator>(const Iterator& rhs) const {
        return !operator<=(rhs);
    }

    /// @brief A greater-than-or-equal-to operator of the iterator class.
    /// @param rhs An iterator object to be compared with this iterator object.
    /// @return true  This iterator object is either greater than or equal to the other.
    /// @return false This iterator object is neither greater than nor equal to the other.
    template <
        typename Iterator,
        enable_if_t<
            disjunction<std::is_same<Iterator, iterator>, std::is_same<Iterator, other_iterator_type>>::value, int> = 0>
    bool operator>=(const Iterator& rhs) const {
        return !operator<(rhs);
    }

public:
    /// @brief Get the type of the internal iterator implementation.
    /// @return iterator_t The type of the internal iterator implementation.
    iterator_t type() const noexcept {
        return m_inner_iterator_type;
    }

    /// @brief Get the mapping key node of the current iterator.
    /// @return The mapping key node of the current iterator.
    const typename value_type::mapping_type::key_type& key() const {
        if FK_YAML_UNLIKELY (m_inner_iterator_type == iterator_t::SEQUENCE) {
            throw fkyaml::exception("Cannot retrieve key from non-mapping iterators.");
        }

        return m_iterator_holder.mapping_iterator->first;
    }

    /// @brief Get reference to the YAML node of the current iterator.
    /// @return Reference to the YAML node of the current iterator.
    reference value() const noexcept {
        return operator*();
    }

private:
    /// A type of the internally-held iterator.
    iterator_t m_inner_iterator_type {iterator_t::SEQUENCE};
    /// A holder of actual iterators.
    iterator_holder<value_type> m_iterator_holder {};
};

/// @brief Get reference to a mapping key node.
/// @tparam ValueType The iterator value type.
/// @tparam I The element index.
/// @param i An iterator object.
/// @return Reference to a mapping key node.
template <std::size_t I, typename ValueType, enable_if_t<I == 0, int> = 0>
inline auto get(const iterator<ValueType>& i) -> decltype(i.key()) {
    return i.key();
}

/// @brief Get reference to a mapping value node.
/// @tparam ValueType The iterator value type.
/// @tparam I The element index
/// @param i An iterator object.
/// @return Reference to a mapping value node.
template <std::size_t I, typename ValueType, enable_if_t<I == 1, int> = 0>
inline auto get(const iterator<ValueType>& i) -> decltype(i.value()) {
    return i.value();
}

FK_YAML_DETAIL_NAMESPACE_END

namespace std {

#ifdef __clang__
// clang emits warnings against mixed usage of class/struct for tuple_size/tuple_element.
// see also: https://groups.google.com/a/isocpp.org/g/std-discussion/c/QC-AMb5oO1w
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmismatched-tags"
#endif

/// @brief Partial specialization of std::tuple_size for iterator class.
/// @tparam ValueType The iterator value type.
template <typename ValueType>
// NOLINTNEXTLINE(cert-dcl58-cpp)
struct tuple_size<::fkyaml::detail::iterator<ValueType>> : integral_constant<size_t, 2> {};

/// @brief Partial specialization of std::tuple_element for iterator class.
/// @tparam ValueType The iterator value type.
/// @tparam I The element index.
template <size_t I, typename ValueType>
// NOLINTNEXTLINE(cert-dcl58-cpp)
struct tuple_element<I, ::fkyaml::detail::iterator<ValueType>> {
    using type = decltype(get<I>(std::declval<::fkyaml::detail::iterator<ValueType>>()));
};

#ifdef __clang__
#pragma clang diagnostic pop
#endif

} // namespace std

#endif /* FK_YAML_DETAIL_ITERATOR_HPP */

// #include <fkYAML/detail/map_range_proxy.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_MAP_RANGE_PROXY_HPP
#define FK_YAML_DETAIL_MAP_RANGE_PROXY_HPP

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/node_traits.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief A helper iterator class which wraps a mapping iterator object.
/// @tparam Iterator The base iterator type.
template <typename Iterator>
class map_iterator_proxy {
public:
    /// @brief The type of the pointed-to elements by base iterators.
    using value_type = Iterator;

    /// @brief The type to represent difference between the pointed-to elements by base iterators.
    using difference_type = std::ptrdiff_t;

    /// @brief The type of the pointed-to element references by base iterators.
    using reference = value_type&;

    /// @brief The type of the pointed-to element pointers by base iterators.
    using pointer = value_type*;

    /// @brief The iterator category.
    using iterator_category = std::forward_iterator_tag;

    /// @brief Constructs a map_iterator_proxy object.
    map_iterator_proxy() = default;

    /// @brief Constructs a map_iterator_proxy object with an Iterator object.
    /// @param i A base iterator object.
    map_iterator_proxy(const Iterator& i) noexcept
        : m_base_iterator(i) {
    }

    /// @brief Copy constructs a map_iterator_proxy object.
    map_iterator_proxy(const map_iterator_proxy&) = default;

    /// @brief Copy assigns a map_iterator_proxy object.
    map_iterator_proxy& operator=(const map_iterator_proxy&) = default;

    /// @brief Move constructs a map_iterator_proxy object.
    map_iterator_proxy(map_iterator_proxy&&) = default;

    /// @brief Move assigns a map_iterator_proxy object.
    map_iterator_proxy& operator=(map_iterator_proxy&&) = default;

    /// @brief Destructs a map_iterator_proxy object.
    ~map_iterator_proxy() = default;

    /// @brief Get reference to the base iterator object.
    /// @return Reference to the base iterator object.
    reference operator*() noexcept {
        return m_base_iterator;
    }

    /// @brief Get pointer to the base iterator object.
    /// @return Pointer to the base iterator object.
    pointer operator->() noexcept {
        return &m_base_iterator;
    }

    /// @brief Pre-increments the base iterator object.
    /// @return Reference to this map_iterator_proxy object.
    map_iterator_proxy& operator++() noexcept {
        ++m_base_iterator;
        return *this;
    }

    /// @brief Post-increments the base iterator object.
    /// @return A map_iterator_proxy object with its base iterator incremented.
    map_iterator_proxy operator++(int) & noexcept {
        auto result = *this;
        ++(*this);
        return result;
    }

    /// @brief Check equality between map_iterator_proxy objects.
    /// @param rhs A map_iterator_proxy object to compare with.
    /// @return true if this map_iterator_proxy object is equal to `rhs`, false otherwise.
    bool operator==(const map_iterator_proxy& rhs) const noexcept {
        return m_base_iterator == rhs.m_base_iterator;
    }

    /// @brief Check inequality between map_iterator_proxy objects.
    /// @param rhs A map_iterator_proxy object to compare with.
    /// @return true if this map_iterator_proxy object is not equal to `rhs`, false otherwise.
    bool operator!=(const map_iterator_proxy& rhs) const noexcept {
        return m_base_iterator != rhs.m_base_iterator;
    }

    /// @brief Get the mapping key node pointed by the base iterator.
    /// @return Reference to the mapping key node.
    typename Iterator::reference key() const {
        return m_base_iterator.key();
    }

    /// @brief Get the mapping value node pointed by the base iterator.
    /// @return Reference to the mapping value node.
    typename Iterator::reference value() const noexcept {
        return m_base_iterator.value();
    }

private:
    /// The base iterator object.
    Iterator m_base_iterator {};
};

/// @brief A helper struct which allows accessing node iterator member functions in range-based for loops.
/// @tparam BasicNodeType A basic_node template instance type.
template <typename BasicNodeType>
class map_range_proxy {
    static_assert(
        is_basic_node<BasicNodeType>::value,
        "map_range_proxy only accepts a basic_node type as its template parameter.");

public:
    /// @brief The type of non-const iterators.
    using iterator = map_iterator_proxy<typename std::conditional<
        std::is_const<BasicNodeType>::value, typename BasicNodeType::const_iterator,
        typename BasicNodeType::iterator>::type>;

    /// @brief The type of const iterators.
    using const_iterator = map_iterator_proxy<typename BasicNodeType::const_iterator>;

    /// @brief Constructs a map_range_proxy object with a BasicNodeType object.
    /// @param map A mapping node object.
    map_range_proxy(BasicNodeType& map) noexcept
        : mp_map(&map) {
    }

    /// @brief Copy constructs a map_range_proxy object.
    map_range_proxy(const map_range_proxy&) = default;

    /// @brief Copy assigns a map_range_proxy object.
    /// @return Reference to this map_range_proxy object.
    map_range_proxy& operator=(const map_range_proxy&) = default;

    /// @brief Move constructs a map_range_proxy object.
    map_range_proxy(map_range_proxy&&) = default;

    /// @brief Move assigns a map_range_proxy object.
    /// @return Reference to this map_range_proxy object.
    map_range_proxy& operator=(map_range_proxy&&) = default;

    /// @brief Destructs a map_range_proxy object.
    ~map_range_proxy() = default;

    /// @brief Get an iterator to the first element.
    /// @return An iterator to the first element.
    iterator begin() noexcept {
        return {mp_map->begin()};
    }

    /// @brief Get a const iterator to the first element.
    /// @return A const iterator to the first element.
    const_iterator begin() const noexcept {
        return {mp_map->cbegin()};
    }

    /// @brief Get an iterator to the past-the-last element.
    /// @return An iterator to the past-the-last element.
    iterator end() noexcept {
        return {mp_map->end()};
    }

    /// @brief Get a const iterator to the past-the-last element.
    /// @return A const iterator to the past-the-last element.
    const_iterator end() const noexcept {
        return {mp_map->cend()};
    }

private:
    /// Pointer to the mapping node object. (non-null)
    BasicNodeType* mp_map {nullptr};
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_MAP_RANGE_PROXY_HPP */

// #include <fkYAML/detail/meta/node_traits.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/meta/type_traits.hpp>

// #include <fkYAML/detail/node_attrs.hpp>

// #include <fkYAML/detail/node_property.hpp>

// #include <fkYAML/detail/node_ref_storage.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_NODE_REF_STORAGE_HPP
#define FK_YAML_DETAIL_NODE_REF_STORAGE_HPP

#include <initializer_list>
#include <type_traits>
#include <utility>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/node_traits.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief A temporal storage for basic_node class objects.
/// @note This class makes it easier to handle lvalue basic_node objects in basic_node ctor with std::initializer_list.
/// @tparam BasicNodeType A basic_node template instance type.
template <typename BasicNodeType>
class node_ref_storage {
    static_assert(is_basic_node<BasicNodeType>::value, "node_ref_storage only accepts basic_node<...>");

    using node_type = BasicNodeType;

public:
    /// @brief Construct a new node ref storage object with an rvalue basic_node object.
    /// @param n An rvalue basic_node object.
    explicit node_ref_storage(node_type&& n) noexcept(std::is_nothrow_move_constructible<node_type>::value)
        : m_owned_value(std::move(n)) {
    }

    /// @brief Construct a new node ref storage object with an lvalue basic_node object.
    /// @param n An lvalue basic_node object.
    explicit node_ref_storage(const node_type& n) noexcept
        : m_value_ref(&n) {
    }

    /// @brief Construct a new node ref storage object with a std::initializer_list object.
    /// @param init A std::initializer_list object.
    node_ref_storage(std::initializer_list<node_ref_storage> init)
        : m_owned_value(init) {
    }

    /// @brief Construct a new node ref storage object with variadic template arguments
    /// @tparam Args Types of arguments to construct a basic_node object.
    /// @param args Arguments to construct a basic_node object.
    template <typename... Args, enable_if_t<std::is_constructible<node_type, Args...>::value, int> = 0>
    node_ref_storage(Args&&... args)
        : m_owned_value(std::forward<Args>(args)...) {
    }

    // allow only move construct/assignment
    node_ref_storage(const node_ref_storage&) = delete;
    node_ref_storage(node_ref_storage&&) = default;
    node_ref_storage& operator=(const node_ref_storage&) = delete;
    node_ref_storage& operator=(node_ref_storage&&) = default;

    ~node_ref_storage() = default;

public:
    /// @brief An arrow operator for node_ref_storage objects.
    /// @return const node_type* A constant pointer to a basic_node object.
    const node_type* operator->() const noexcept {
        return m_value_ref ? m_value_ref : &m_owned_value;
    }

    /// @brief Releases a basic_node object internally held.
    /// @return node_type A basic_node object internally held.
    node_type release() const noexcept {
        return m_value_ref ? *m_value_ref : std::move(m_owned_value);
    }

private:
    /// A storage for a basic_node object given with rvalue reference.
    mutable node_type m_owned_value = nullptr;
    /// A pointer to a basic_node object given with lvalue reference.
    const node_type* m_value_ref = nullptr;
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_NODE_REF_STORAGE_HPP */

// #include <fkYAML/detail/output/serializer.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_OUTPUT_SERIALIZER_HPP
#define FK_YAML_DETAIL_OUTPUT_SERIALIZER_HPP

#include <cmath>
#include <sstream>
#include <string>
#include <vector>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/conversions/to_string.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_CONVERSIONS_TO_STRING_HPP
#define FK_YAML_DETAIL_CONVERSIONS_TO_STRING_HPP

#include <cmath>
#include <limits>
#include <string>
#include <sstream>
#include <type_traits>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/meta/type_traits.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Converts a ValueType object to a string YAML token.
/// @tparam ValueType A source value type.
/// @tparam CharType The type of characters for the conversion result.
/// @param s A resulting output string.
/// @param v A source value.
template <typename ValueType, typename CharType>
inline void to_string(ValueType v, std::basic_string<CharType>& s) noexcept;

/// @brief Specialization of to_string() for null values.
/// @param s A resulting string YAML token.
/// @param (unused) nullptr
template <>
inline void to_string(std::nullptr_t /*unused*/, std::string& s) noexcept {
    s = "null";
}

/// @brief Specialization of to_string() for booleans.
/// @param s A resulting string YAML token.
/// @param v A boolean source value.
template <>
inline void to_string(bool v, std::string& s) noexcept {
    s = v ? "true" : "false";
}

/// @brief Specialization of to_string() for integers.
/// @tparam IntegerType An integer type.
/// @param s A resulting string YAML token.
/// @param i An integer source value.
template <typename IntegerType>
inline enable_if_t<is_non_bool_integral<IntegerType>::value> to_string(IntegerType v, std::string& s) noexcept {
    s = std::to_string(v);
}

/// @brief Specialization of to_string() for floating point numbers.
/// @tparam FloatType A floating point number type.
/// @param s A resulting string YAML token.
/// @param f A floating point number source value.
template <typename FloatType>
inline enable_if_t<std::is_floating_point<FloatType>::value> to_string(FloatType v, std::string& s) noexcept {
    if (std::isnan(v)) {
        s = ".nan";
        return;
    }

    if (std::isinf(v)) {
        if (v == std::numeric_limits<FloatType>::infinity()) {
            s = ".inf";
        }
        else {
            s = "-.inf";
        }
        return;
    }

    std::ostringstream oss;
    oss << v;
    s = oss.str();

    // If `v` is actually an integer and no scientific notation is used for serialization, ".0" must be appended.
    // The result would cause a roundtrip issue otherwise. https://github.com/fktn-k/fkYAML/issues/405
    const std::size_t pos = s.find_first_of(".e");
    if (pos == std::string::npos) {
        s += ".0";
    }
}

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_CONVERSIONS_TO_STRING_HPP */

// #include <fkYAML/detail/encodings/yaml_escaper.hpp>

// #include <fkYAML/detail/input/scalar_scanner.hpp>

// #include <fkYAML/detail/meta/node_traits.hpp>

// #include <fkYAML/exception.hpp>

// #include <fkYAML/node_type.hpp>

// #include <fkYAML/yaml_version_type.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief A basic implementation of serialization feature for YAML nodes.
/// @tparam BasicNodeType A BasicNode template class instantiation.
template <typename BasicNodeType>
class basic_serializer {
    static_assert(detail::is_basic_node<BasicNodeType>::value, "basic_serializer only accepts basic_node<...>");

public:
    /// @brief Construct a new basic_serializer object.
    basic_serializer() = default;

    /// @brief Serialize the given Node value.
    /// @param node A Node object to be serialized.
    /// @return std::string A serialization result of the given Node value.
    std::string serialize(const BasicNodeType& node) {
        std::string str {};
        serialize_document(node, str);
        return str;
    } // LCOV_EXCL_LINE

    std::string serialize_docs(const std::vector<BasicNodeType>& docs) {
        std::string str {};

        const auto size = static_cast<uint32_t>(docs.size());
        for (uint32_t i = 0; i < size; i++) {
            serialize_document(docs[i], str);
            if (i + 1 < size) {
                // Append the end-of-document marker for the next document.
                str += "...\n";
            }
        }

        return str;
    } // LCOV_EXCL_LINE

private:
    void serialize_document(const BasicNodeType& node, std::string& str) {
        const bool dirs_serialized = serialize_directives(node, str);

        // the root node cannot be an alias node.
        const bool root_has_props = node.is_anchor() || node.has_tag_name();

        if (root_has_props) {
            if (dirs_serialized) {
                str.back() = ' '; // replace the last LF with a white space
            }
            bool is_anchor_appended = try_append_anchor(node, false, str);
            try_append_tag(node, is_anchor_appended, str);
            str += "\n";
        }
        serialize_node(node, 0, str);
    }

    /// @brief Serialize the directives if any is applied to the node.
    /// @param node The target node.
    /// @param str A string to hold serialization result.
    /// @return bool true if any directive is serialized, false otherwise.
    bool serialize_directives(const BasicNodeType& node, std::string& str) {
        const auto& p_meta = node.mp_meta;
        bool needs_directive_end = false;

        if (p_meta->is_version_specified) {
            str += "%YAML ";
            switch (p_meta->version) {
            case yaml_version_type::VERSION_1_1:
                str += "1.1\n";
                break;
            case yaml_version_type::VERSION_1_2:
                str += "1.2\n";
                break;
            }
            needs_directive_end = true;
        }

        if (!p_meta->primary_handle_prefix.empty()) {
            str += "%TAG ! ";
            str += p_meta->primary_handle_prefix;
            str += "\n";
            needs_directive_end = true;
        }

        if (!p_meta->secondary_handle_prefix.empty()) {
            str += "%TAG !! ";
            str += p_meta->secondary_handle_prefix;
            str += "\n";
            needs_directive_end = true;
        }

        if (!p_meta->named_handle_map.empty()) {
            for (const auto& itr : p_meta->named_handle_map) {
                str += "%TAG ";
                str += itr.first;
                str += " ";
                str += itr.second;
                str += "\n";
            }
            needs_directive_end = true;
        }

        if (needs_directive_end) {
            str += "---\n";
        }

        return needs_directive_end;
    }

    /// @brief Recursively serialize each Node object.
    /// @param node A Node object to be serialized.
    /// @param cur_indent The current indent width
    /// @param str A string to hold serialization result.
    void serialize_node(const BasicNodeType& node, const uint32_t cur_indent, std::string& str) {
        switch (node.get_type()) {
        case node_type::SEQUENCE:
            if (node.size() == 0) {
                str += "[]\n";
                return;
            }
            for (const auto& seq_item : node) {
                insert_indentation(cur_indent, str);
                str += "-";

                const bool is_appended = try_append_alias(seq_item, true, str);
                if (is_appended) {
                    str += "\n";
                    continue;
                }

                try_append_anchor(seq_item, true, str);
                try_append_tag(seq_item, true, str);

                const bool is_scalar = seq_item.is_scalar();
                if (is_scalar) {
                    str += " ";
                    serialize_node(seq_item, cur_indent, str);
                    str += "\n";
                    continue;
                }

                const bool is_empty = seq_item.empty();
                if (!is_empty) {
                    str += "\n";
                    serialize_node(seq_item, cur_indent + 2, str);
                    continue;
                }

                // an empty sequence or mapping
                if (seq_item.is_sequence()) {
                    str += " []\n";
                }
                else /*seq_item.is_mapping()*/ {
                    str += " {}\n";
                }
            }
            break;
        case node_type::MAPPING:
            if (node.size() == 0) {
                str += "{}\n";
                return;
            }
            for (auto itr : node.map_items()) {
                insert_indentation(cur_indent, str);

                // serialize a mapping key node.
                const auto& key_node = itr.key();

                bool is_appended = try_append_alias(key_node, false, str);
                if (is_appended) {
                    // The trailing white space is necessary since anchor names can contain a colon (:) at its end.
                    str += " ";
                }
                else {
                    const bool is_anchor_appended = try_append_anchor(key_node, false, str);
                    const bool is_tag_appended = try_append_tag(key_node, is_anchor_appended, str);
                    if (is_anchor_appended || is_tag_appended) {
                        str += " ";
                    }

                    const bool is_container = !key_node.is_scalar();
                    if (is_container) {
                        str += "? ";
                    }
                    const auto indent = static_cast<uint32_t>(get_cur_indent(str));
                    serialize_node(key_node, indent, str);
                    if (is_container) {
                        // a newline code is already inserted in the above serialize_node() call.
                        insert_indentation(indent - 2, str);
                    }
                }

                str += ":";

                // serialize a mapping value node.
                const auto& value_node = itr.value();

                is_appended = try_append_alias(value_node, true, str);
                if (is_appended) {
                    str += "\n";
                    continue;
                }

                try_append_anchor(value_node, true, str);
                try_append_tag(value_node, true, str);

                const bool is_scalar = itr->is_scalar();
                if (is_scalar) {
                    str += " ";
                    serialize_node(value_node, cur_indent, str);
                    str += "\n";
                    continue;
                }

                const bool is_empty = itr->empty();
                if (is_empty) {
                    str += " ";
                }
                else {
                    str += "\n";
                }
                serialize_node(value_node, cur_indent + 2, str);
            }
            break;
        case node_type::NULL_OBJECT:
            to_string(nullptr, m_tmp_str_buff);
            str += m_tmp_str_buff;
            break;
        case node_type::BOOLEAN:
            to_string(node.template get_value<typename BasicNodeType::boolean_type>(), m_tmp_str_buff);
            str += m_tmp_str_buff;
            break;
        case node_type::INTEGER:
            to_string(node.template get_value<typename BasicNodeType::integer_type>(), m_tmp_str_buff);
            str += m_tmp_str_buff;
            break;
        case node_type::FLOAT:
            to_string(node.template get_value<typename BasicNodeType::float_number_type>(), m_tmp_str_buff);
            str += m_tmp_str_buff;
            break;
        case node_type::STRING: {
            bool is_escaped = false;
            auto str_val = get_string_node_value(node, is_escaped);

            if (is_escaped) {
                // There's no other token type with escapes than strings.
                // Also, escapes must be in double-quoted strings.
                str += '\"';
                str += str_val;
                str += '\"';
                break;
            }

            // The next line is intentionally excluded from the LCOV coverage target since the next line is somehow
            // misrecognized as it has a binary branch. Possibly begin() or end() has some conditional branch(es)
            // internally. Confirmed with LCOV 1.14 on Ubuntu22.04.
            const node_type type_if_plain =
                scalar_scanner::scan(str_val.c_str(), str_val.c_str() + str_val.size()); // LCOV_EXCL_LINE

            if (type_if_plain != node_type::STRING) {
                // Surround a string value with double quotes to keep semantic equality.
                // Without them, serialized values will become non-string. (e.g., "1" -> 1)
                str += '\"';
                str += str_val;
                str += '\"';
            }
            else {
                str += str_val;
            }
            break;
        }
        }
    }

    /// @brief Get the current indentation width.
    /// @param s The target string object.
    /// @return The current indentation width.
    std::size_t get_cur_indent(const std::string& s) const noexcept {
        const bool is_empty = s.empty();
        if (is_empty) {
            return 0;
        }

        const std::size_t last_lf_pos = s.rfind('\n');
        return (last_lf_pos != std::string::npos) ? s.size() - last_lf_pos - 1 : s.size();
    }

    /// @brief Insert indentation to the serialization result.
    /// @param indent The indent width to be inserted.
    /// @param str A string to hold serialization result.
    void insert_indentation(const uint32_t indent, std::string& str) const noexcept {
        if (indent == 0) {
            return;
        }

        str.append(indent - get_cur_indent(str), ' ');
    }

    /// @brief Append an anchor property if it's available. Do nothing otherwise.
    /// @param node The target node which is possibly an anchor node.
    /// @param prepends_space Whether to prepend a space before an anchor property.
    /// @param str A string to hold serialization result.
    /// @return true if an anchor property has been appended, false otherwise.
    bool try_append_anchor(const BasicNodeType& node, bool prepends_space, std::string& str) const {
        if (node.is_anchor()) {
            if (prepends_space) {
                str += " ";
            }
            str += "&" + node.get_anchor_name();
            return true;
        }
        return false;
    }

    /// @brief Append an alias property if it's available. Do nothing otherwise.
    /// @param node The target node which is possibly an alias node.
    /// @param prepends_space Whether to prepend a space before an alias property.
    /// @param str A string to hold serialization result.
    /// @return true if an alias property has been appended, false otherwise.
    bool try_append_alias(const BasicNodeType& node, bool prepends_space, std::string& str) const {
        if (node.is_alias()) {
            if (prepends_space) {
                str += " ";
            }
            str += "*" + node.get_anchor_name();
            return true;
        }
        return false;
    }

    /// @brief Append a tag name if it's available. Do nothing otherwise.
    /// @param[in] node The target node which possibly has a tag name.
    /// @param[out] str A string to hold serialization result.
    /// @return true if a tag name has been appended, false otherwise.
    bool try_append_tag(const BasicNodeType& node, bool prepends_space, std::string& str) const {
        if (node.has_tag_name()) {
            if (prepends_space) {
                str += " ";
            }
            str += node.get_tag_name();
            return true;
        }
        return false;
    }

    /// @brief Get a string value from the given node and, if necessary, escape its contents.
    /// @param[in] node The target string YAML node.
    /// @param[out] is_escaped Whether the contents of an output string has been escaped.
    /// @return The (escaped) string node value.
    typename BasicNodeType::string_type get_string_node_value(const BasicNodeType& node, bool& is_escaped) {
        FK_YAML_ASSERT(node.is_string());

        const auto& s = node.as_str();
        return yaml_escaper::escape(s.c_str(), s.c_str() + s.size(), is_escaped);
    } // LCOV_EXCL_LINE

private:
    /// A temporal buffer for conversion from a scalar to a string.
    std::string m_tmp_str_buff;
};

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_OUTPUT_SERIALIZER_HPP */

// #include <fkYAML/detail/reverse_iterator.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_REVERSE_ITERATOR_HPP
#define FK_YAML_DETAIL_REVERSE_ITERATOR_HPP

#include <iterator>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/node_traits.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief An iterator adapter class that reverses the direction of a given node iterator.
/// @tparam Iterator The base iterator type.
template <typename Iterator>
class reverse_iterator {
    static_assert(
        is_basic_node<typename Iterator::value_type>::value,
        "reverse_iterator only accepts a basic_node type as the underlying iterator's value type");

public:
    /// @brief The base iterator type.
    using iterator_type = Iterator;

    /// @brief The base iterator category.
    using iterator_category = typename Iterator::iterator_category;

    /// @brief The type of the pointed-to elements by base iterators.
    using value_type = typename Iterator::value_type;

    /// @brief The type to represent differences between the pointed-to elements by the base iterators.
    using difference_type = typename Iterator::difference_type;

    /// @brief The type of the pointed-to element pointers by base iterators.
    using pointer = typename Iterator::pointer;

    /// @brief The type of the pointed-to element references by base iterators.
    using reference = typename Iterator::reference;

    /// @brief Constructs a reverse_iterator object.
    reverse_iterator() = default;

    /// @brief Copy constructs a reverse_iterator object.
    reverse_iterator(const reverse_iterator&) = default;

    /// @brief Copy assignments a reverse_iterator object.
    reverse_iterator& operator=(const reverse_iterator&) = default;

    /// @brief Move constructs a reverse_iterator object.
    reverse_iterator(reverse_iterator&&) = default;

    /// @brief Move assignments a reverse_iterator object.
    reverse_iterator& operator=(reverse_iterator&&) = default;

    /// @brief Constructs a reverse_iterator object with an underlying iterator object.
    /// @param i A base iterator object.
    reverse_iterator(const Iterator& i) noexcept
        : m_current(i) {
    }

    /// @brief Copy constructs a reverse_iterator object with a compatible reverse_iterator object.
    /// @tparam U A compatible iterator type with Iterator.
    /// @param other A compatible reverse_iterator object.
    template <typename U, enable_if_t<negation<std::is_same<U, Iterator>>::value, int> = 0>
    reverse_iterator(const reverse_iterator<U>& other) noexcept
        : m_current(other.base()) {
    }

    /// @brief Copy assigns a reverse_iterator object with a compatible reverse_iterator object.
    /// @tparam U A compatible iterator type with Iterator.
    /// @param other A compatible reverse_iterator object.
    /// @return Reference to this reverse_iterator object.
    template <typename U, enable_if_t<negation<std::is_same<U, Iterator>>::value, int> = 0>
    reverse_iterator& operator=(const reverse_iterator<U>& other) noexcept {
        m_current = other.base();
        return *this;
    }

    /// @brief Destructs a reverse_iterator object.
    ~reverse_iterator() = default;

    /// @brief Accesses the underlying iterator object.
    /// @return The underlying iterator object.
    Iterator base() const noexcept {
        return m_current;
    }

    /// @brief Get reference to the pointed-to element.
    /// @return Reference to the pointed-to element.
    reference operator*() const noexcept {
        Iterator tmp = m_current;
        return *--tmp;
    }

    /// @brief Get pointer to the pointed-to element.
    /// @return Pointer to the pointed-to element.
    pointer operator->() const noexcept {
        return &(operator*());
    }

    /// @brief Pre-increments the underlying iterator object.
    /// @return Reference to this reverse_iterator object with its underlying iterator incremented.
    reverse_iterator& operator++() noexcept {
        --m_current;
        return *this;
    }

    /// @brief Post-increments the underlying iterator object.
    /// @return A reverse_iterator object with the underlying iterator as-is.
    reverse_iterator operator++(int) & noexcept {
        auto result = *this;
        --m_current;
        return result;
    }

    /// @brief Pre-decrements the underlying iterator object.
    /// @return Reference to this reverse_iterator with its underlying iterator decremented.
    reverse_iterator& operator--() noexcept {
        ++m_current;
        return *this;
    }

    /// @brief Post-decrements the underlying iterator object.
    /// @return A reverse_iterator object with the underlying iterator as-is.
    reverse_iterator operator--(int) & noexcept {
        auto result = *this;
        ++m_current;
        return result;
    }

    /// @brief Advances the underlying iterator object by `n`.
    /// @param n The distance by which the underlying iterator is advanced.
    /// @return A reverse_iterator object with the underlying iterator advanced by `n`.
    reverse_iterator operator+(difference_type n) const noexcept {
        return reverse_iterator(m_current - n);
    }

    /// @brief Advances the underlying iterator object by `n`.
    /// @param n The distance by which the underlying iterator is advanced.
    /// @return Reference to this reverse_iterator object with the underlying iterator advanced by `n`.
    reverse_iterator& operator+=(difference_type n) noexcept {
        m_current -= n;
        return *this;
    }

    /// @brief Decrements the underlying iterator object by `n`.
    /// @param n The distance by which the underlying iterator is decremented.
    /// @return A reverse_iterator object with the underlying iterator decremented by `n`.
    reverse_iterator operator-(difference_type n) const noexcept {
        return reverse_iterator(m_current + n);
    }

    /// @brief Decrements the underlying iterator object by `n`.
    /// @param n The distance by which the underlying iterator is decremented.
    /// @return Reference to this reverse_iterator object with the underlying iterator decremented by `n`.
    reverse_iterator& operator-=(difference_type n) noexcept {
        m_current += n;
        return *this;
    }

    /// @brief Get the mapping key node of the underlying iterator.
    /// @return The mapping key node of the underlying iterator.
    auto key() const -> decltype(std::declval<Iterator>().key()) {
        Iterator itr = --(base());
        return itr.key();
    }

    /// @brief Get reference to the underlying iterator's value.
    /// @return Reference to the underlying iterator's value.
    reference value() noexcept {
        Iterator itr = --(base());
        return *itr;
    }

private:
    ///
    Iterator m_current;
};

/// @brief Check equality between reverse_iterator objects.
/// @tparam IteratorL Base iterator type for `lhs`.
/// @tparam IteratorR Base iterator type for `rhs`.
/// @param lhs A reverse_iterator object.
/// @param rhs A reverse_iterator object.
/// @return true if the two reverse_iterator objects are equal, false otherwise.
template <typename IteratorL, typename IteratorR>
inline bool operator==(const reverse_iterator<IteratorL>& lhs, const reverse_iterator<IteratorR>& rhs) {
    return lhs.base() == rhs.base();
}

/// @brief Check inequality between reverse_iterator objects.
/// @tparam IteratorL Base iterator type for `lhs`.
/// @tparam IteratorR Base iterator type for `rhs`.
/// @param lhs A reverse_iterator object.
/// @param rhs A reverse_iterator object.
/// @return true if the two reverse_iterator objects are not equal, false otherwise.
template <typename IteratorL, typename IteratorR>
inline bool operator!=(const reverse_iterator<IteratorL>& lhs, const reverse_iterator<IteratorR>& rhs) {
    return lhs.base() != rhs.base();
}

/// @brief Check if `lhs` is less than `rhs`.
/// @tparam IteratorL Base iterator type for `lhs`.
/// @tparam IteratorR Base iterator type for `rhs`.
/// @param lhs A reverse_iterator object.
/// @param rhs A reverse_iterator object.
/// @return true if `lhs` is less than `rhs`, false otherwise.
template <typename IteratorL, typename IteratorR>
inline bool operator<(const reverse_iterator<IteratorL>& lhs, const reverse_iterator<IteratorR>& rhs) {
    return lhs.base() > rhs.base();
}

/// @brief Check if `lhs` is less than or equal to `rhs`.
/// @tparam IteratorL Base iterator type for `lhs`.
/// @tparam IteratorR Base iterator type for `rhs`.
/// @param lhs A reverse_iterator object.
/// @param rhs A reverse_iterator object.
/// @return true if `lhs` is less than or equal to `rhs`, false otherwise.
template <typename IteratorL, typename IteratorR>
inline bool operator<=(const reverse_iterator<IteratorL>& lhs, const reverse_iterator<IteratorR>& rhs) {
    return lhs.base() >= rhs.base();
}

/// @brief Check if `lhs` is greater than `rhs`.
/// @tparam IteratorL Base iterator type for `lhs`.
/// @tparam IteratorR Base iterator type for `rhs`.
/// @param lhs A reverse_iterator object.
/// @param rhs A reverse_iterator object.
/// @return true if `lhs` is greater than `rhs`, false otherwise.
template <typename IteratorL, typename IteratorR>
inline bool operator>(const reverse_iterator<IteratorL>& lhs, const reverse_iterator<IteratorR>& rhs) {
    return lhs.base() < rhs.base();
}

/// @brief Check if `lhs` is greater than or equal to `rhs`.
/// @tparam IteratorL Base iterator type for `lhs`.
/// @tparam IteratorR Base iterator type for `rhs`.
/// @param lhs A reverse_iterator object.
/// @param rhs A reverse_iterator object.
/// @return true if `lhs` is greater than or equal to `rhs`, false otherwise.
template <typename IteratorL, typename IteratorR>
inline bool operator>=(const reverse_iterator<IteratorL>& lhs, const reverse_iterator<IteratorR>& rhs) {
    return lhs.base() <= rhs.base();
}

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_REVERSE_ITERATOR_HPP */

// #include <fkYAML/detail/types/node_t.hpp>

// #include <fkYAML/detail/types/yaml_version_t.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_TYPES_YAML_VERSION_T_HPP
#define FK_YAML_DETAIL_TYPES_YAML_VERSION_T_HPP

#include <cstdint>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/yaml_version_type.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

/// @brief Definition of YAML version types.
enum class yaml_version_t : std::uint8_t {
    VER_1_1, //!< YAML version 1.1
    VER_1_2, //!< YAML version 1.2
};

inline yaml_version_t convert_from_yaml_version_type(yaml_version_type t) noexcept {
    switch (t) {
    case yaml_version_type::VERSION_1_1:
        return yaml_version_t::VER_1_1;
    case yaml_version_type::VERSION_1_2:
    default:
        return yaml_version_t::VER_1_2;
    }
}

inline yaml_version_type convert_to_yaml_version_type(yaml_version_t t) noexcept {
    switch (t) {
    case yaml_version_t::VER_1_1:
        return yaml_version_type::VERSION_1_1;
    case yaml_version_t::VER_1_2:
    default:
        return yaml_version_type::VERSION_1_2;
    }
}

FK_YAML_DETAIL_NAMESPACE_END

#endif /* FK_YAML_DETAIL_TYPES_YAML_VERSION_T_HPP */

// #include <fkYAML/exception.hpp>

// #include <fkYAML/node_type.hpp>

// #include <fkYAML/node_value_converter.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_NODE_VALUE_CONVERTER_HPP
#define FK_YAML_NODE_VALUE_CONVERTER_HPP

#include <utility>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/conversions/from_node.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_CONVERSIONS_FROM_NODE_HPP
#define FK_YAML_DETAIL_CONVERSIONS_FROM_NODE_HPP

#include <array>
#include <cmath>
#include <forward_list>
#include <limits>
#include <utility>
#include <valarray>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/node_traits.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/meta/type_traits.hpp>

// #include <fkYAML/detail/types/node_t.hpp>

// #include <fkYAML/exception.hpp>


#ifdef FK_YAML_HAS_CXX_17
#include <optional>
#endif

FK_YAML_DETAIL_NAMESPACE_BEGIN

///////////////////
//   from_node   //
///////////////////

// utility type traits and functors

/// @brief Utility traits type alias to detect constructible associative container types from a mapping node, e.g.,
/// std::map or std::unordered_map.
/// @tparam T A target type for detection.
template <typename T>
using is_constructible_mapping_type =
    conjunction<detect::has_key_type<T>, detect::has_mapped_type<T>, detect::has_value_type<T>>;

/// @brief Utility traits type alias to detect constructible container types from a sequence node, e.g., std::vector or
/// std::list.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A target type for detection.
template <typename BasicNodeType, typename T>
using is_constructible_sequence_type = conjunction<
    negation<is_basic_node<T>>, detect::has_iterator<T>, detect::is_iterator_traits<typename T::iterator>,
    detect::has_begin_end<T>, negation<std::is_same<T, typename BasicNodeType::mapping_type>>,
    negation<is_constructible_mapping_type<T>>>;

/// @brief Utility traits type alias to detect a sequence container adapter type, e.g., std::stack or std::queue.
/// @tparam T A target type for detection.
template <typename T>
using is_sequence_container_adapter = conjunction<
    negation<is_basic_node<T>>, detect::has_container_type<T>, detect::has_value_type<T>,
    negation<detect::has_key_type<T>>>;

/// @brief Helper struct for reserve() member function call switch for types which do not have reserve function.
/// @tparam ContainerType A container type.
template <typename ContainerType, typename = void>
struct call_reserve_if_available {
    /// @brief Do nothing since ContainerType does not have reserve function.
    static void call(ContainerType& /*unused*/, typename ContainerType::size_type /*unused*/) {
    }
};

/// @brief Helper struct for reserve() member function call switch for types which have reserve function.
/// @tparam ContainerType A container type.
template <typename ContainerType>
struct call_reserve_if_available<ContainerType, enable_if_t<detect::has_reserve<ContainerType>::value>> {
    /// @brief Call reserve function on the ContainerType object with a given size.
    /// @param c A container object.
    /// @param n A size to reserve.
    static void call(ContainerType& c, typename ContainerType::size_type n) {
        c.reserve(n);
    }
};

// from_node() implementations

/// @brief from_node function for C-style 1D arrays whose element type must be a basic_node template instance type or a
/// compatible type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T Element type of C-style 1D array.
/// @tparam N Size of the array.
/// @param n A basic_node object.
/// @param array An array object.
template <typename BasicNodeType, typename T, std::size_t N>
inline auto from_node(const BasicNodeType& n, T (&array)[N])
    -> decltype(n.get_value_inplace(std::declval<T&>()), void()) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value type is not sequence type.", n.get_type());
    }

    // call get_value_inplace(), not get_value(), since the storage to fill the result into is already created.
    for (std::size_t i = 0; i < N; i++) {
        n.at(i).get_value_inplace(array[i]);
    }
}

/// @brief from_node function for C-style 2D arrays whose element type must be a basic_node template instance type or a
/// compatible type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T Element type of C-style 2D array.
/// @tparam N0 Size of the outer dimension.
/// @tparam N1 Size of the inner dimension.
/// @param n A basic_node object.
/// @param array An array object.
template <typename BasicNodeType, typename T, std::size_t N0, std::size_t N1>
inline auto from_node(const BasicNodeType& n, T (&array)[N0][N1])
    -> decltype(n.get_value_inplace(std::declval<T&>()), void()) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value type is not sequence type.", n.get_type());
    }

    // call get_value_inplace(), not get_value(), since the storage to fill the result into is already created.
    for (std::size_t i0 = 0; i0 < N0; i0++) {
        for (std::size_t i1 = 0; i1 < N1; i1++) {
            n.at(i0).at(i1).get_value_inplace(array[i0][i1]);
        }
    }
}

/// @brief from_node function for C-style 2D arrays whose element type must be a basic_node template instance type or a
/// compatible type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T Element type of C-style 2D array.
/// @tparam N0 Size of the outermost dimension.
/// @tparam N1 Size of the middle dimension.
/// @tparam N2 Size of the innermost dimension.
/// @param n A basic_node object.
/// @param array An array object.
template <typename BasicNodeType, typename T, std::size_t N0, std::size_t N1, std::size_t N2>
inline auto from_node(const BasicNodeType& n, T (&array)[N0][N1][N2])
    -> decltype(n.get_value_inplace(std::declval<T&>()), void()) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value type is not sequence type.", n.get_type());
    }

    // call get_value_inplace(), not get_value(), since the storage to fill the result into is already created.
    for (std::size_t i0 = 0; i0 < N0; i0++) {
        for (std::size_t i1 = 0; i1 < N1; i1++) {
            for (std::size_t i2 = 0; i2 < N2; i2++) {
                n.at(i0).at(i1).at(i2).get_value_inplace(array[i0][i1][i2]);
            }
        }
    }
}

/// @brief from_node function for std::array objects whose element type must be a basic_node template instance type or a
/// compatible type. This function is necessary since insert function is not implemented for std::array.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T Element type of std::array.
/// @tparam N Size of std::array.
/// @param n A basic_node object.
/// @param arr A std::array object.
template <typename BasicNodeType, typename T, std::size_t N>
inline auto from_node(const BasicNodeType& n, std::array<T, N>& arr)
    -> decltype(n.get_value_inplace(std::declval<T&>()), void()) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value type is not sequence type.", n.get_type());
    }

    for (std::size_t i = 0; i < N; i++) {
        // call get_value_inplace(), not get_value(), since the storage to fill the result into is already created.
        n.at(i).get_value_inplace(arr.at(i));
    }
}

/// @brief from_node function for std::valarray objects whose element type must be a basic_node template instance type
/// or a compatible type. This function is necessary since insert function is not implemented for std::valarray.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T Element type of std::valarray.
/// @param n A basic_node object.
/// @param va A std::valarray object.
template <typename BasicNodeType, typename T>
inline auto from_node(const BasicNodeType& n, std::valarray<T>& va)
    -> decltype(n.get_value_inplace(std::declval<T&>()), void()) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value type is not sequence type.", n.get_type());
    }

    std::size_t count = n.size();
    va.resize(count);
    for (std::size_t i = 0; i < count; i++) {
        // call get_value_inplace(), not get_value(), since the storage to fill the result into is already created.
        n.at(i).get_value_inplace(va[i]);
    }
}

/// @brief from_node function for std::forward_list objects whose element type must be a basic_node template instance
/// type or a compatible type. This function is necessary since insert function is not implemented for
/// std::forward_list.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T Element type of std::forward_list.
/// @tparam Alloc Allocator type of std::forward_list.
/// @param n A basic_node object.
/// @param fl A std::forward_list object.
template <typename BasicNodeType, typename T, typename Alloc>
inline auto from_node(const BasicNodeType& n, std::forward_list<T, Alloc>& fl)
    -> decltype(n.template get_value<T>(), void()) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value is not sequence type.", n.get_type());
    }

    fl.clear();

    // std::forward_list does not have insert function.
    auto insert_pos_itr = fl.before_begin();
    for (const auto& elem : n) {
        insert_pos_itr = fl.emplace_after(insert_pos_itr, elem.template get_value<T>());
    }
}

/// @brief from_node function for container objects of only keys or values, e.g., std::vector or std::set, whose element
/// type must be a basic_node template instance type or a compatible type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam CompatSeqType A container type.
/// @param n A basic_node object.
/// @param s A container object.
template <
    typename BasicNodeType, typename CompatSeqType,
    enable_if_t<
        conjunction<
            is_basic_node<BasicNodeType>, is_constructible_sequence_type<BasicNodeType, CompatSeqType>,
            negation<std::is_constructible<typename BasicNodeType::string_type, CompatSeqType>>>::value,
        int> = 0>
inline auto from_node(const BasicNodeType& n, CompatSeqType& s)
    -> decltype(n.template get_value<typename CompatSeqType::value_type>(), void()) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value is not sequence type.", n.get_type());
    }

    s.clear();

    // call reserve function first if it's available (like std::vector).
    call_reserve_if_available<CompatSeqType>::call(s, n.size());

    // transform a sequence node into a destination type object by calling insert function.
    using std::end;
    std::transform(n.begin(), n.end(), std::inserter(s, end(s)), [](const BasicNodeType& elem) {
        return elem.template get_value<typename CompatSeqType::value_type>();
    });
}

/// @brief from_node function for sequence container adapter objects, e.g., std::stack or std::queue, whose element type
/// must be either a basic_node template instance type or a compatible type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam SeqContainerAdapter A sequence container adapter type.
/// @param n A node object.
/// @param ca A sequence container adapter object.
template <
    typename BasicNodeType, typename SeqContainerAdapter,
    enable_if_t<
        conjunction<is_basic_node<BasicNodeType>, is_sequence_container_adapter<SeqContainerAdapter>>::value, int> = 0>
inline auto from_node(const BasicNodeType& n, SeqContainerAdapter& ca)
    -> decltype(n.template get_value<typename SeqContainerAdapter::value_type>(), ca.push(std::declval<typename SeqContainerAdapter::value_type>()), void()) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value is not sequence type.", n.get_type());
    }

    // clear existing elements manually since clear function is not implemented for container adapter classes.
    while (!ca.empty()) {
        ca.pop();
    }

    for (const auto& elem : n) {
        // container adapter classes commonly have push function.
        // emplace function cannot be used in case SeqContainerAdapter::container_type is std::vector<bool> in C++11.
        ca.push(elem.template get_value<typename SeqContainerAdapter::value_type>());
    }
}

/// @brief from_node function for mappings whose key and value are of both compatible types.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam CompatibleKeyType Mapping key type compatible with BasicNodeType.
/// @tparam CompatibleValueType Mapping value type compatible with BasicNodeType.
/// @tparam Compare Comparator type for mapping keys.
/// @tparam Allocator Allocator type for destination mapping object.
/// @param n A node object.
/// @param m Mapping container object to store converted key/value objects.
template <typename BasicNodeType, typename CompatMapType, enable_if_t<is_constructible_mapping_type<CompatMapType>::value, int> = 0>
inline auto from_node(const BasicNodeType& n, CompatMapType& m)
    -> decltype(
        std::declval<const BasicNodeType&>().template get_value<typename CompatMapType::key_type>(),
        std::declval<const BasicNodeType&>().template get_value<typename CompatMapType::mapped_type>(),
        m.emplace(std::declval<typename CompatMapType::key_type>(), std::declval<typename CompatMapType::mapped_type>()),
        void()) {
    if FK_YAML_UNLIKELY (!n.is_mapping()) {
        throw type_error("The target node value type is not mapping type.", n.get_type());
    }

    m.clear();
    call_reserve_if_available<CompatMapType>::call(m, n.size());

    for (const auto& pair : n.as_map()) {
        m.emplace(
            pair.first.template get_value<typename CompatMapType::key_type>(),
            pair.second.template get_value<typename CompatMapType::mapped_type>());
    }
}

/// @brief from_node function for nullptr.
/// @tparam BasicNodeType A basic_node template instance type.
/// @param n A node object.
/// @param null Storage for a null value.
template <typename BasicNodeType, enable_if_t<is_basic_node<BasicNodeType>::value, int> = 0>
inline void from_node(const BasicNodeType& n, std::nullptr_t& null) {
    // to ensure the target node value type is null.
    if FK_YAML_UNLIKELY (!n.is_null()) {
        throw type_error("The target node value type is not null type.", n.get_type());
    }
    null = nullptr;
}

/// @brief from_node function for booleans.
/// @tparam BasicNodeType A basic_node template instance type.
/// @param n A node object.
/// @param b Storage for a boolean value.
template <typename BasicNodeType, enable_if_t<is_basic_node<BasicNodeType>::value, int> = 0>
inline void from_node(const BasicNodeType& n, bool& b) {
    switch (n.get_type()) {
    case node_type::NULL_OBJECT:
        // nullptr is converted to false just as C++ implicitly does.
        b = false;
        break;
    case node_type::BOOLEAN:
        b = static_cast<bool>(n.as_bool());
        break;
    case node_type::INTEGER:
        // true: non-zero, false: zero
        b = (n.as_int() != 0);
        break;
    case node_type::FLOAT:
        // true: non-zero, false: zero
        using float_type = typename BasicNodeType::float_number_type;
        b = (n.as_float() != static_cast<float_type>(0.));
        break;
    case node_type::SEQUENCE:
    case node_type::MAPPING:
    case node_type::STRING:
    default:
        throw type_error("The target node value type is not compatible with boolean type.", n.get_type());
    }
}

/// @brief Helper struct for node-to-int conversion.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam IntType Target integer value type (same as BasicNodeType::integer_type)
template <
    typename BasicNodeType, typename IntType, bool = std::is_same<typename BasicNodeType::integer_type, IntType>::value>
struct from_node_int_helper {
    /// @brief Convert node's integer value to the target integer type.
    /// @param n A node object.
    /// @return An integer value converted from the node's integer value.
    static IntType convert(const BasicNodeType& n) {
        return n.as_int();
    }
};

/// @brief Helper struct for node-to-int conversion if IntType is not the node's integer value type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam IntType Target integer value type (different from BasicNodeType::integer_type)
template <typename BasicNodeType, typename IntType>
struct from_node_int_helper<BasicNodeType, IntType, false> {
    /// @brief Convert node's integer value to non-uint64_t integer types.
    /// @param n A node object.
    /// @return An integer value converted from the node's integer value.
    static IntType convert(const BasicNodeType& n) {
        using node_int_type = typename BasicNodeType::integer_type;
        const node_int_type tmp_int = n.as_int();

        // under/overflow check.
        if (std::is_same<IntType, uint64_t>::value) {
            if FK_YAML_UNLIKELY (tmp_int < 0) {
                throw exception("Integer value underflow detected.");
            }
        }
        else {
            if FK_YAML_UNLIKELY (tmp_int < static_cast<node_int_type>(std::numeric_limits<IntType>::min())) {
                throw exception("Integer value underflow detected.");
            }
            if FK_YAML_UNLIKELY (static_cast<node_int_type>(std::numeric_limits<IntType>::max()) < tmp_int) {
                throw exception("Integer value overflow detected.");
            }
        }

        return static_cast<IntType>(tmp_int);
    }
};

/// @brief from_node function for integers.
/// @note If node's value is null, boolean, or float, such a value is converted into an integer internally.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam IntegerType An integer value type.
/// @param n A node object.
/// @param i Storage for an integer value.
template <
    typename BasicNodeType, typename IntegerType,
    enable_if_t<conjunction<is_basic_node<BasicNodeType>, is_non_bool_integral<IntegerType>>::value, int> = 0>
inline void from_node(const BasicNodeType& n, IntegerType& i) {
    switch (n.get_type()) {
    case node_type::NULL_OBJECT:
        // nullptr is interpreted as 0
        i = static_cast<IntegerType>(0);
        break;
    case node_type::BOOLEAN:
        i = static_cast<bool>(n.as_bool()) ? static_cast<IntegerType>(1) : static_cast<IntegerType>(0);
        break;
    case node_type::INTEGER:
        i = from_node_int_helper<BasicNodeType, IntegerType>::convert(n);
        break;
    case node_type::FLOAT: {
        // int64_t should be safe to express the integer part of possible floating point types.
        const auto tmp_int = static_cast<int64_t>(n.as_float());

        // under/overflow check.
        if (std::is_same<IntegerType, uint64_t>::value) {
            if FK_YAML_UNLIKELY (tmp_int < 0) {
                throw exception("Integer value underflow detected.");
            }
        }
        else {
            if FK_YAML_UNLIKELY (tmp_int < static_cast<int64_t>(std::numeric_limits<IntegerType>::min())) {
                throw exception("Integer value underflow detected.");
            }
            if FK_YAML_UNLIKELY (static_cast<int64_t>(std::numeric_limits<IntegerType>::max()) < tmp_int) {
                throw exception("Integer value overflow detected.");
            }
        }

        i = static_cast<IntegerType>(tmp_int);
        break;
    }
    case node_type::SEQUENCE:
    case node_type::MAPPING:
    case node_type::STRING:
    default:
        throw type_error("The target node value type is not compatible with integer type.", n.get_type());
    }
}

/// @brief Helper struct for node-to-float conversion if FloatType is the node's floating point value type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam FloatType Target floating point value type (same as the BasicNodeType::float_number_type)
template <
    typename BasicNodeType, typename FloatType,
    bool = std::is_same<typename BasicNodeType::float_number_type, FloatType>::value>
struct from_node_float_helper {
    /// @brief Convert node's floating point value to the target floating point type.
    /// @param n A node object.
    /// @return A floating point value converted from the node's floating point value.
    static FloatType convert(const BasicNodeType& n) {
        return n.as_float();
    }
};

/// @brief Helper struct for node-to-float conversion if IntType is not the node's floating point value type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam FloatType Target floating point value type (different from BasicNodeType::float_number_type)
template <typename BasicNodeType, typename FloatType>
struct from_node_float_helper<BasicNodeType, FloatType, false> {
    /// @brief Convert node's floating point value to the target floating point type.
    /// @param n A node object.
    /// @return A floating point value converted from the node's floating point value.
    static FloatType convert(const BasicNodeType& n) {
        using node_float_type = typename BasicNodeType::float_number_type;
        auto tmp_float = n.as_float();

        // check if the value is an infinite number (either positive or negative)
        if (std::isinf(tmp_float)) {
            if (tmp_float == std::numeric_limits<node_float_type>::infinity()) {
                return std::numeric_limits<FloatType>::infinity();
            }

            return static_cast<FloatType>(-1.) * std::numeric_limits<FloatType>::infinity();
        }

        // check if the value is not a number
        if (std::isnan(tmp_float)) {
            return std::numeric_limits<FloatType>::quiet_NaN();
        }

        // check if the value is expressible as FloatType.
        if FK_YAML_UNLIKELY (tmp_float < std::numeric_limits<FloatType>::lowest()) {
            throw exception("Floating point value underflow detected.");
        }
        if FK_YAML_UNLIKELY (std::numeric_limits<FloatType>::max() < tmp_float) {
            throw exception("Floating point value overflow detected.");
        }

        return static_cast<FloatType>(tmp_float);
    }
};

/// @brief from_node function for floating point values.
/// @note If node's value is null, boolean, or integer, such a value is converted into a floating point internally.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam FloatType A floating point value type.
/// @param n A node object.
/// @param f Storage for a float point value.
template <
    typename BasicNodeType, typename FloatType,
    enable_if_t<conjunction<is_basic_node<BasicNodeType>, std::is_floating_point<FloatType>>::value, int> = 0>
inline void from_node(const BasicNodeType& n, FloatType& f) {
    switch (n.get_type()) {
    case node_type::NULL_OBJECT:
        // nullptr is interpreted as 0.0
        f = static_cast<FloatType>(0.);
        break;
    case node_type::BOOLEAN:
        f = static_cast<bool>(n.as_bool()) ? static_cast<FloatType>(1.) : static_cast<FloatType>(0.);
        break;
    case node_type::INTEGER:
        f = static_cast<FloatType>(n.as_int());
        break;
    case node_type::FLOAT:
        f = from_node_float_helper<BasicNodeType, FloatType>::convert(n);
        break;
    case node_type::SEQUENCE:
    case node_type::MAPPING:
    case node_type::STRING:
    default:
        throw type_error("The target node value type is not compatible with float number type.", n.get_type());
    }
}

/// @brief from_node function for BasicNodeType::string_type objects.
/// @tparam BasicNodeType A basic_node template instance type.
/// @param n A basic_node object.
/// @param s A string node value object.
template <typename BasicNodeType, enable_if_t<is_basic_node<BasicNodeType>::value, int> = 0>
inline void from_node(const BasicNodeType& n, typename BasicNodeType::string_type& s) {
    if FK_YAML_UNLIKELY (!n.is_string()) {
        throw type_error("The target node value type is not string type.", n.get_type());
    }
    s = n.as_str();
}

/// @brief from_node function for compatible string type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam CompatibleStringType A compatible string type.
/// @param n A basic_node object.
/// @param s A compatible string object.
template <
    typename BasicNodeType, typename CompatibleStringType,
    enable_if_t<
        conjunction<
            is_basic_node<BasicNodeType>,
            negation<std::is_same<CompatibleStringType, typename BasicNodeType::string_type>>,
            disjunction<
                std::is_constructible<CompatibleStringType, const typename BasicNodeType::string_type&>,
                std::is_assignable<CompatibleStringType, const typename BasicNodeType::string_type&>>>::value,
        int> = 0>
inline void from_node(const BasicNodeType& n, CompatibleStringType& s) {
    if FK_YAML_UNLIKELY (!n.is_string()) {
        throw type_error("The target node value type is not string type.", n.get_type());
    }
    s = n.as_str();
}

/// @brief from_node function for std::pair objects whose element types must be either a basic_node template instance
/// type or a compatible type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T The first type of the std::pair.
/// @tparam U The second type of the std::pair.
/// @param n A basic_node object.
/// @param p A std::pair object.
template <typename BasicNodeType, typename T, typename U, enable_if_t<is_basic_node<BasicNodeType>::value, int> = 0>
inline auto from_node(const BasicNodeType& n, std::pair<T, U>& p)
    -> decltype(std::declval<const BasicNodeType&>().template get_value<T>(), std::declval<const BasicNodeType&>().template get_value<U>(), void()) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value type is not sequence type.", n.get_type());
    }

    // call get_value_inplace(), not get_value(), since the storage to fill the result into is already created.
    n.at(0).get_value_inplace(p.first);
    n.at(1).get_value_inplace(p.second);
}

/// @brief concrete implementation of from_node function for std::tuple objects.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam ...Types The value types of std::tuple.
/// @tparam ...Idx Index sequence values for std::tuples value types.
/// @param n A basic_node object
/// @param _ Index sequence values (unused).
/// @return A std::tuple object converted from the sequence node values.
template <typename BasicNodeType, typename... Types, std::size_t... Idx>
inline std::tuple<Types...> from_node_tuple_impl(const BasicNodeType& n, index_sequence<Idx...> /*unused*/) {
    return std::make_tuple(n.at(Idx).template get_value<Types>()...);
}

/// @brief from_node function for std::tuple objects whose value types must all be either a basic_node template instance
/// type or a compatible type
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam ...Types Value types of std::tuple.
/// @param n A basic_node object.
/// @param t A std::tuple object.
template <typename BasicNodeType, typename... Types, enable_if_t<is_basic_node<BasicNodeType>::value, int> = 0>
inline void from_node(const BasicNodeType& n, std::tuple<Types...>& t) {
    if FK_YAML_UNLIKELY (!n.is_sequence()) {
        throw type_error("The target node value type is not sequence type.", n.get_type());
    }

    // Types... must be explicitly specified; the return type would otherwise be std::tuple with no value types.
    t = from_node_tuple_impl<BasicNodeType, Types...>(n, index_sequence_for<Types...> {});
}

#ifdef FK_YAML_HAS_CXX_17

/// @brief from_node function for std::optional objects whose value type must be either a basic_node template instance
/// type or a compatible type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A value type of the std::optional.
/// @param n A basic_node object.
/// @param o A std::optional object.
template <typename BasicNodeType, typename T, enable_if_t<is_basic_node<BasicNodeType>::value, int> = 0>
inline auto from_node(const BasicNodeType& n, std::optional<T>& o) -> decltype(n.template get_value<T>(), void()) {
    try {
        o.emplace(n.template get_value<T>());
    }
    catch (const std::exception& /*unused*/) {
        // Any exception derived from std::exception is interpreted as a conversion failure in some way
        // since user-defined from_node function may throw a different object from a fkyaml::type_error.
        // and std::exception is usually the base class of user-defined exception types.
        o = std::nullopt;
    }
}

#endif // defined(FK_YAML_HAS_CXX_17)

/// @brief A function object to call from_node functions.
/// @note User-defined specialization is available by providing implementation **OUTSIDE** fkyaml namespace.
struct from_node_fn {
    /// @brief Call from_node function suitable for the given T type.
    /// @tparam BasicNodeType A basic_node template instance type.
    /// @tparam T A target value type assigned from the basic_node object.
    /// @param n A basic_node object.
    /// @param val A target object assigned from the basic_node object.
    /// @return decltype(from_node(n, std::forward<T>(val))) void by default. User can set it to some other type.
    template <typename BasicNodeType, typename T>
    auto operator()(const BasicNodeType& n, T&& val) const
        noexcept(noexcept(from_node(n, std::forward<T>(val)))) -> decltype(from_node(n, std::forward<T>(val))) {
        return from_node(n, std::forward<T>(val));
    }
};

FK_YAML_DETAIL_NAMESPACE_END

FK_YAML_NAMESPACE_BEGIN

#ifndef FK_YAML_HAS_CXX_17
// anonymous namespace to hold `from_node` functor.
// see http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/n4381.html for why it's needed.
namespace // NOLINT(cert-dcl59-cpp,fuchsia-header-anon-namespaces,google-build-namespaces)
{
#endif

/// @brief A global object to represent ADL friendly from_node functor.
// NOLINTNEXTLINE(misc-definitions-in-headers)
FK_YAML_INLINE_VAR constexpr const auto& from_node = detail::static_const<detail::from_node_fn>::value;

#ifndef FK_YAML_HAS_CXX_17
} // namespace
#endif

FK_YAML_NAMESPACE_END

#endif /* FK_YAML_DETAIL_CONVERSIONS_FROM_NODE_HPP */

// #include <fkYAML/detail/conversions/to_node.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_DETAIL_CONVERSIONS_TO_NODE_HPP
#define FK_YAML_DETAIL_CONVERSIONS_TO_NODE_HPP

#include <utility>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/exception_safe_allocation.hpp>

// #include <fkYAML/detail/meta/node_traits.hpp>

// #include <fkYAML/detail/meta/type_traits.hpp>

// #include <fkYAML/detail/meta/stl_supplement.hpp>

// #include <fkYAML/detail/node_attrs.hpp>

// #include <fkYAML/node_type.hpp>


FK_YAML_DETAIL_NAMESPACE_BEGIN

///////////////////////////////////
//   external_node_constructor   //
///////////////////////////////////

/// @brief The external constructor template for basic_node objects.
/// @note All the non-specialized instantiations results in compilation error since such instantiations are not
/// supported.
/// @warning All the specialization must call n.m_value.destroy() first in the construct function to avoid
/// memory leak.
/// @tparam node_type The resulting YAML node value type.
template <typename BasicNodeType>
struct external_node_constructor {
    template <typename... Args>
    static void sequence(BasicNodeType& n, Args&&... args) {
        destroy(n);
        n.m_attrs |= node_attr_bits::seq_bit;
        n.m_value.p_seq = create_object<typename BasicNodeType::sequence_type>(std::forward<Args>(args)...);
    }

    template <typename... Args>
    static void mapping(BasicNodeType& n, Args&&... args) {
        destroy(n);
        n.m_attrs |= node_attr_bits::map_bit;
        n.m_value.p_map = create_object<typename BasicNodeType::mapping_type>(std::forward<Args>(args)...);
    }

    static void null_scalar(BasicNodeType& n, std::nullptr_t) {
        destroy(n);
        n.m_attrs |= node_attr_bits::null_bit;
        n.m_value.p_map = nullptr;
    }

    static void boolean_scalar(BasicNodeType& n, const typename BasicNodeType::boolean_type b) {
        destroy(n);
        n.m_attrs |= node_attr_bits::bool_bit;
        n.m_value.boolean = b;
    }

    static void integer_scalar(BasicNodeType& n, const typename BasicNodeType::integer_type i) {
        destroy(n);
        n.m_attrs |= node_attr_bits::int_bit;
        n.m_value.integer = i;
    }

    static void float_scalar(BasicNodeType& n, const typename BasicNodeType::float_number_type f) {
        destroy(n);
        n.m_attrs |= node_attr_bits::float_bit;
        n.m_value.float_val = f;
    }

    template <typename... Args>
    static void string_scalar(BasicNodeType& n, Args&&... args) {
        destroy(n);
        n.m_attrs |= node_attr_bits::string_bit;
        n.m_value.p_str = create_object<typename BasicNodeType::string_type>(std::forward<Args>(args)...);
    }

private:
    static void destroy(BasicNodeType& n) {
        n.m_value.destroy(n.m_attrs & node_attr_mask::value);
        n.m_attrs &= ~node_attr_mask::value;
    }
};

/////////////////
//   to_node   //
/////////////////

/// @brief to_node function for BasicNodeType::sequence_type objects.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A sequence node value type.
/// @param n A basic_node object.
/// @param s A sequence node value object.
template <
    typename BasicNodeType, typename T,
    enable_if_t<
        conjunction<
            is_basic_node<BasicNodeType>,
            std::is_same<typename BasicNodeType::sequence_type, remove_cvref_t<T>>>::value,
        int> = 0>
inline void to_node(BasicNodeType& n, T&& s) noexcept {
    external_node_constructor<BasicNodeType>::sequence(n, std::forward<T>(s));
}

/// @brief to_node function for compatible sequence types.
/// @note This overload is enabled when
/// * both begin()/end() functions are callable on a `CompatSeqType` object
/// * CompatSeqType doesn't have `mapped_type` (mapping-like type)
/// * BasicNodeType::string_type cannot be constructed from a CompatSeqType object (string-like type)
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam CompatSeqType A container type.
/// @param n A basic_node object.
/// @param s A container object.
template <
    typename BasicNodeType, typename CompatSeqType,
    enable_if_t<
        conjunction<
            is_basic_node<BasicNodeType>,
            negation<std::is_same<typename BasicNodeType::sequence_type, remove_cvref_t<CompatSeqType>>>,
            negation<is_basic_node<CompatSeqType>>, detect::has_begin_end<CompatSeqType>,
            negation<conjunction<detect::has_key_type<CompatSeqType>, detect::has_mapped_type<CompatSeqType>>>,
            negation<std::is_constructible<typename BasicNodeType::string_type, CompatSeqType>>>::value,
        int> = 0>
// NOLINTNEXTLINE(cppcoreguidelines-missing-std-forward)
inline void to_node(BasicNodeType& n, CompatSeqType&& s) {
    using std::begin;
    using std::end;
    external_node_constructor<BasicNodeType>::sequence(n, begin(s), end(s));
}

/// @brief to_node function for std::pair objects.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T The first type of std::pair.
/// @tparam U The second type of std::pair.
/// @param n A basic_node object.
/// @param p A std::pair object.
template <typename BasicNodeType, typename T, typename U>
inline void to_node(BasicNodeType& n, const std::pair<T, U>& p) {
    n = {p.first, p.second};
}

/// @brief concrete implementation of to_node function for std::tuple objects.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam ...Types The value types of std::tuple.
/// @tparam ...Idx Index sequence values for std::tuple value types.
/// @param n A basic_node object.
/// @param t A std::tuple object.
/// @param _ An index sequence. (unused)
template <typename BasicNodeType, typename... Types, std::size_t... Idx>
inline void to_node_tuple_impl(BasicNodeType& n, const std::tuple<Types...>& t, index_sequence<Idx...> /*unused*/) {
    n = {std::get<Idx>(t)...};
}

/// @brief to_node function for std::tuple objects with no value types.
/// @note This implementation is needed since calling `to_node_tuple_impl()` with an empty tuple creates a null node.
/// @tparam BasicNodeType A basic_node template instance type.
/// @param n A basic_node object.
/// @param _ A std::tuple object. (unused)
template <typename BasicNodeType>
inline void to_node(BasicNodeType& n, const std::tuple<>& /*unused*/) {
    n = BasicNodeType::sequence();
}

/// @brief to_node function for std::tuple objects with at least one value type.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam ...FirstType The first value types of std::tuple.
/// @tparam ...RestTypes The rest value types of std::tuple. (maybe empty)
/// @param n A basic_node object.
/// @param t A std::tuple object.
template <typename BasicNodeType, typename FirstType, typename... RestTypes>
inline void to_node(BasicNodeType& n, const std::tuple<FirstType, RestTypes...>& t) {
    to_node_tuple_impl(n, t, index_sequence_for<FirstType, RestTypes...> {});
}

/// @brief to_node function for BasicNodeType::mapping_type objects.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A mapping node value type.
/// @param n A basic_node object.
/// @param m A mapping node value object.
template <
    typename BasicNodeType, typename T,
    enable_if_t<
        conjunction<
            is_basic_node<BasicNodeType>, std::is_same<typename BasicNodeType::mapping_type, remove_cvref_t<T>>>::value,
        int> = 0>
inline void to_node(BasicNodeType& n, T&& m) noexcept {
    external_node_constructor<BasicNodeType>::mapping(n, std::forward<T>(m));
}

/// @brief to_node function for compatible mapping types.
/// @note This overload is enabled when
/// * both begin()/end() functions are callable on a `CompatMapType` object
/// * CompatMapType has both `key_type` and `mapped_type`
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam CompatMapType A container type.
/// @param n A basic_node object.
/// @param m A container object.
template <
    typename BasicNodeType, typename CompatMapType,
    enable_if_t<
        conjunction<
            is_basic_node<BasicNodeType>, negation<is_basic_node<CompatMapType>>,
            negation<std::is_same<typename BasicNodeType::mapping_type, remove_cvref_t<CompatMapType>>>,
            detect::has_begin_end<CompatMapType>, detect::has_key_type<CompatMapType>,
            detect::has_mapped_type<CompatMapType>>::value,
        int> = 0>
inline void to_node(BasicNodeType& n, CompatMapType&& m) {
    external_node_constructor<BasicNodeType>::mapping(n);
    auto& map = n.as_map();
    for (const auto& pair : std::forward<CompatMapType>(m)) {
        map.emplace(pair.first, pair.second);
    }
}

/// @brief to_node function for null objects.
/// @tparam BasicNodeType A mapping node value type.
/// @tparam NullType This must be std::nullptr_t type
template <typename BasicNodeType, enable_if_t<is_basic_node<BasicNodeType>::value, int> = 0>
inline void to_node(BasicNodeType& n, std::nullptr_t /*unused*/) {
    external_node_constructor<BasicNodeType>::null_scalar(n, nullptr);
}

/// @brief to_node function for BasicNodeType::boolean_type objects.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A boolean scalar node value type.
/// @param n A basic_node object.
/// @param b A boolean scalar node value object.
template <typename BasicNodeType, enable_if_t<is_basic_node<BasicNodeType>::value, int> = 0>
inline void to_node(BasicNodeType& n, typename BasicNodeType::boolean_type b) noexcept {
    external_node_constructor<BasicNodeType>::boolean_scalar(n, b);
}

/// @brief to_node function for integers.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T An integer type.
/// @param n A basic_node object.
/// @param i An integer object.
template <
    typename BasicNodeType, typename T,
    enable_if_t<conjunction<is_basic_node<BasicNodeType>, is_non_bool_integral<T>>::value, int> = 0>
inline void to_node(BasicNodeType& n, T i) noexcept {
    external_node_constructor<BasicNodeType>::integer_scalar(n, i);
}

/// @brief to_node function for floating point numbers.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A floating point number type.
/// @param n A basic_node object.
/// @param f A floating point number object.
template <
    typename BasicNodeType, typename T,
    enable_if_t<conjunction<is_basic_node<BasicNodeType>, std::is_floating_point<T>>::value, int> = 0>
inline void to_node(BasicNodeType& n, T f) noexcept {
    external_node_constructor<BasicNodeType>::float_scalar(n, f);
}

/// @brief to_node function for compatible strings.
/// @tparam BasicNodeType A basic_node template instance type.
/// @tparam T A compatible string type.
/// @param n A basic_node object.
/// @param s A compatible string object.
template <
    typename BasicNodeType, typename T,
    enable_if_t<
        conjunction<
            is_basic_node<BasicNodeType>, negation<is_null_pointer<T>>,
            std::is_constructible<typename BasicNodeType::string_type, T>>::value,
        int> = 0>
inline void to_node(BasicNodeType& n, T&& s) {
    external_node_constructor<BasicNodeType>::string_scalar(n, std::forward<T>(s));
}

/// @brief A function object to call to_node functions.
/// @note User-defined specialization is available by providing implementation **OUTSIDE** fkyaml namespace.
struct to_node_fn {
    /// @brief Call to_node function suitable for the given T type.
    /// @tparam BasicNodeType A basic_node template instance type.
    /// @tparam T A target value type assigned to the basic_node object.
    /// @param n A basic_node object.
    /// @param val A target object assigned to the basic_node object.
    /// @return decltype(to_node(n, std::forward<T>(val))) void by default. User can set it to some other type.
    template <typename BasicNodeType, typename T>
    auto operator()(BasicNodeType& n, T&& val) const
        noexcept(noexcept(to_node(n, std::forward<T>(val)))) -> decltype(to_node(n, std::forward<T>(val))) {
        return to_node(n, std::forward<T>(val));
    }
};

FK_YAML_DETAIL_NAMESPACE_END

FK_YAML_NAMESPACE_BEGIN

#ifndef FK_YAML_HAS_CXX_17
// anonymous namespace to hold `to_node` functor.
// see http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/n4381.html for why it's needed.
namespace // NOLINT(cert-dcl59-cpp,fuchsia-header-anon-namespaces,google-build-namespaces)
{
#endif

/// @brief A global object to represent ADL friendly to_node functor.
// NOLINTNEXTLINE(misc-definitions-in-headers)
FK_YAML_INLINE_VAR constexpr const auto& to_node = detail::static_const<detail::to_node_fn>::value;

#ifndef FK_YAML_HAS_CXX_17
} // namespace
#endif

FK_YAML_NAMESPACE_END

#endif /* FK_YAML_DETAIL_CONVERSIONS_TO_NODE_HPP */


FK_YAML_NAMESPACE_BEGIN

/// @brief An ADL friendly converter between basic_node objects and native data objects.
/// @tparam ValueType A default target data type.
/// @sa https://fktn-k.github.io/fkYAML/api/node_value_converter/
template <typename ValueType, typename>
class node_value_converter {
public:
    /// @brief Convert a YAML node value into compatible native data.
    /// @tparam BasicNodeType A basic_node template instance type.
    /// @tparam TargetType A native data type for conversion.
    /// @param n A basic_node object.
    /// @param val A native data object.
    /// @sa https://fktn-k.github.io/fkYAML/api/node_value_converter/from_node/
    template <typename BasicNodeType, typename TargetType = ValueType>
    static auto from_node(BasicNodeType&& n, TargetType& val) noexcept(
        noexcept(::fkyaml::from_node(std::forward<BasicNodeType>(n), val)))
        -> decltype(::fkyaml::from_node(std::forward<BasicNodeType>(n), val), void()) {
        ::fkyaml::from_node(std::forward<BasicNodeType>(n), val);
    }

    /// @brief Convert compatible native data into a YAML node.
    /// @tparam BasicNodeType A basic_node template instance type.
    /// @tparam TargetType A native data type for conversion.
    /// @param n A basic_node object.
    /// @param val A native data object.
    /// @sa https://fktn-k.github.io/fkYAML/api/node_value_converter/to_node/
    template <typename BasicNodeType, typename TargetType = ValueType>
    static auto to_node(BasicNodeType& n, TargetType&& val) noexcept(noexcept(::fkyaml::to_node(
        n, std::forward<TargetType>(val)))) -> decltype(::fkyaml::to_node(n, std::forward<TargetType>(val))) {
        ::fkyaml::to_node(n, std::forward<TargetType>(val));
    }
};

FK_YAML_NAMESPACE_END

#endif /* FK_YAML_NODE_VALUE_CONVERTER_HPP */

// #include <fkYAML/ordered_map.hpp>
//  _______   __ __   __  _____   __  __  __
// |   __| |_/  |  \_/  |/  _  \ /  \/  \|  |     fkYAML: A C++ header-only YAML library
// |   __|  _  < \_   _/|  ___  |    _   |  |___  version 0.4.2
// |__|  |_| \__|  |_|  |_|   |_|___||___|______| https://github.com/fktn-k/fkYAML
//
// SPDX-FileCopyrightText: 2023-2025 Kensuke Fukutani <fktn.dev@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef FK_YAML_ORDERED_MAP_HPP
#define FK_YAML_ORDERED_MAP_HPP

#include <functional>
#include <initializer_list>
#include <memory>
#include <utility>
#include <vector>

// #include <fkYAML/detail/macros/define_macros.hpp>

// #include <fkYAML/detail/meta/type_traits.hpp>

// #include <fkYAML/exception.hpp>


FK_YAML_NAMESPACE_BEGIN

/// @brief A minimal map-like container which preserves insertion order.
/// @tparam Key A type for keys.
/// @tparam Value A type for values.
/// @tparam IgnoredCompare A placeholder for key comparison. This will be ignored.
/// @tparam Allocator A class for allocators.
/// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
template <
    typename Key, typename Value, typename IgnoredCompare = std::less<Key>,
    typename Allocator = std::allocator<std::pair<const Key, Value>>>
class ordered_map : public std::vector<std::pair<const Key, Value>, Allocator> {
public:
    /// @brief A type for keys.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
    using key_type = Key;

    /// @brief A type for values.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
    using mapped_type = Value;

    /// @brief A type for internal key-value containers.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
    using Container = std::vector<std::pair<const Key, Value>, Allocator>;

    /// @brief A type for key-value pairs.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
    using value_type = typename Container::value_type;

    /// @brief A type for non-const iterators.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
    using iterator = typename Container::iterator;

    /// @brief A type for const iterators.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
    using const_iterator = typename Container::const_iterator;

    /// @brief A type for size parameters used in this class.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
    using size_type = typename Container::size_type;

    /// @brief A type for comparison between keys.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/
    using key_compare = std::equal_to<Key>;

public:
    /// @brief Construct a new ordered_map object.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/constructor/
    ordered_map() noexcept(noexcept(Container()))
        : Container() {
    }

    /// @brief Construct a new ordered_map object with an initializer list.
    /// @param init An initializer list to construct the inner container object.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/constructor/
    ordered_map(std::initializer_list<value_type> init)
        : Container {init} {
    }

public:
    /// @brief A subscript operator for ordered_map objects.
    /// @tparam KeyType A type for the input key.
    /// @param key A key to the target value.
    /// @return mapped_type& Reference to a mapped_type object associated with the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/operator[]/
    template <
        typename KeyType,
        detail::enable_if_t<detail::is_usable_as_key_type<key_compare, key_type, KeyType>::value, int> = 0>
    mapped_type& operator[](KeyType&& key) noexcept {
        return emplace(std::forward<KeyType>(key), mapped_type()).first->second;
    }

public:
    /// @brief Emplace a new key-value pair if the new key does not exist.
    /// @tparam KeyType A type for the input key.
    /// @param key A key to be emplaced to this ordered_map object.
    /// @param value A value to be emplaced to this ordered_map object.
    /// @return std::pair<iterator, bool> A result of emplacement of the new key-value pair.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/emplace/
    template <
        typename KeyType,
        detail::enable_if_t<detail::is_usable_as_key_type<key_compare, key_type, KeyType>::value, int> = 0>
    std::pair<iterator, bool> emplace(KeyType&& key, const mapped_type& value) noexcept {
        for (auto itr = this->begin(); itr != this->end(); ++itr) {
            if (m_compare(itr->first, key)) {
                return {itr, false};
            }
        }
        this->emplace_back(std::forward<KeyType>(key), value);
        return {std::prev(this->end()), true};
    }

    /// @brief Find a value associated to the given key. Throws an exception if the search fails.
    /// @tparam KeyType A type for the input key.
    /// @param key A key to find a value with.
    /// @return mapped_type& The value associated to the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/at/
    template <
        typename KeyType,
        detail::enable_if_t<detail::is_usable_as_key_type<key_compare, key_type, KeyType>::value, int> = 0>
    mapped_type& at(KeyType&& key) { // NOLINT(cppcoreguidelines-missing-std-forward)
        for (auto itr = this->begin(); itr != this->end(); ++itr) {
            if (m_compare(itr->first, key)) {
                return itr->second;
            }
        }
        throw fkyaml::exception("key not found.");
    }

    /// @brief Find a value associated to the given key. Throws an exception if the search fails.
    /// @tparam KeyType A type for the input key.
    /// @param key A key to find a value with.
    /// @return const mapped_type& The value associated to the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/at/
    template <
        typename KeyType,
        detail::enable_if_t<detail::is_usable_as_key_type<key_compare, key_type, KeyType>::value, int> = 0>
    const mapped_type& at(KeyType&& key) const { // NOLINT(cppcoreguidelines-missing-std-forward)
        for (auto itr = this->begin(); itr != this->end(); ++itr) {
            if (m_compare(itr->first, key)) {
                return itr->second;
            }
        }
        throw fkyaml::exception("key not found.");
    }

    /// @brief Find a value with the given key.
    /// @tparam KeyType A type for the input key.
    /// @param key A key to find a value with.
    /// @return iterator The iterator for the found value, or the result of end().
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/find/
    template <
        typename KeyType,
        detail::enable_if_t<detail::is_usable_as_key_type<key_compare, key_type, KeyType>::value, int> = 0>
    iterator find(KeyType&& key) noexcept { // NOLINT(cppcoreguidelines-missing-std-forward)
        for (auto itr = this->begin(); itr != this->end(); ++itr) {
            if (m_compare(itr->first, key)) {
                return itr;
            }
        }
        return this->end();
    }

    /// @brief Find a value with the given key.
    /// @tparam KeyType A type for the input key.
    /// @param key A key to find a value with.
    /// @return const_iterator The constant iterator for the found value, or the result of end().
    /// @sa https://fktn-k.github.io/fkYAML/api/ordered_map/find/
    template <
        typename KeyType,
        detail::enable_if_t<detail::is_usable_as_key_type<key_compare, key_type, KeyType>::value, int> = 0>
    const_iterator find(KeyType&& key) const noexcept { // NOLINT(cppcoreguidelines-missing-std-forward)
        for (auto itr = this->begin(); itr != this->end(); ++itr) {
            if (m_compare(itr->first, key)) {
                return itr;
            }
        }
        return this->end();
    }

private:
    /// The object for comparing keys.
    key_compare m_compare {};
};

FK_YAML_NAMESPACE_END

#endif /* FK_YAML_ORDERED_MAP_HPP */


FK_YAML_NAMESPACE_BEGIN

/// @brief A class to store value of YAML nodes.
/// @sa https://fktn-k.github.io/fkYAML/api/basic_node/
template <
    template <typename, typename...> class SequenceType, template <typename, typename, typename...> class MappingType,
    typename BooleanType, typename IntegerType, typename FloatNumberType, typename StringType,
    template <typename, typename = void> class ConverterType>
class basic_node {
public:
    /// @brief A type for sequence basic_node values.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/sequence_type/
    using sequence_type = SequenceType<basic_node, std::allocator<basic_node>>;

    /// @brief A type for mapping basic_node values.
    /// @note std::unordered_map is not supported since it does not allow incomplete types.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/mapping_type/
    using mapping_type = MappingType<basic_node, basic_node>;

    /// @brief A type for boolean basic_node values.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/boolean_type/
    using boolean_type = BooleanType;

    /// @brief A type for integer basic_node values.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/integer_type/
    using integer_type = IntegerType;

    /// @brief A type for float number basic_node values.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/float_number_type/
    using float_number_type = FloatNumberType;

    /// @brief A type for string basic_node values.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/string_type/
    using string_type = StringType;

    /// @brief A type of elements in a basic_node container.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/#container-types
    using value_type = basic_node;

    /// @brief A type of reference to a basic_node element.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/#container-types
    using reference = value_type&;

    /// @brief A type of constant reference to a basic_node element.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/#container-types
    using const_reference = const value_type&;

    /// @brief A type of a pointer to a basic_node element.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/#container-types
    using pointer = value_type*;

    /// @brief A type of a constant pointer to a basic_node element.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/#container-types
    using const_pointer = const value_type*;

    /// @brief A type to represent basic_node container sizes.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/#container-types
    using size_type = std::size_t;

    /// @brief A type to represent differences between basic_node iterators.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/#container-types
    using difference_type = std::ptrdiff_t;

    /// @brief A type for iterators of basic_node containers.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/iterator/
    using iterator = fkyaml::detail::iterator<basic_node>;

    /// @brief A type for constant iterators of basic_node containers.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/iterator/
    using const_iterator = fkyaml::detail::iterator<const basic_node>;

    /// @brief A type for reverse iterators of basic_node containers.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/reverse_iterator/
    using reverse_iterator = fkyaml::detail::reverse_iterator<iterator>;

    /// @brief A type for constant reverse iterators of basic_node containers.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/reverse_iterator/
    using const_reverse_iterator = fkyaml::detail::reverse_iterator<const_iterator>;

    /// @brief A helper alias to determine converter type for the given target native data type.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/value_converter_type/
    template <typename T, typename SFINAE>
    using value_converter_type = ConverterType<T, SFINAE>;

    /// @brief Definition of node value types.
    /// @deprecated Use fkyaml::node_type enum class. (since 0.3.12)
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/node_t/
    using node_t = detail::node_t;

    /// @brief Definition of YAML version types.
    /// @deprecated Use fkyaml::yaml_version_type enum class. (since 0.3.12)
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/yaml_version_t/
    using yaml_version_t = detail::yaml_version_t;

    /// @brief A type for mapping range objects for the map_items() function.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/map_range/
    using map_range = fkyaml::detail::map_range_proxy<basic_node>;

    /// @brief A type for constant mapping range objects for the map_items() function.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/map_range/
    using const_map_range = fkyaml::detail::map_range_proxy<const basic_node>;

private:
    template <typename BasicNodeType>
    friend struct fkyaml::detail::external_node_constructor;

    template <typename BasicNodeType>
    friend class fkyaml::detail::basic_deserializer;

    template <typename BasicNodeType>
    friend class fkyaml::detail::basic_serializer;

    /// @brief A type for YAML docs deserializers.
    using deserializer_type = detail::basic_deserializer<basic_node>;
    /// @brief A type for YAML docs serializers.
    using serializer_type = detail::basic_serializer<basic_node>;
    /// @brief A helper type alias for std::initializer_list.
    using initializer_list_t = std::initializer_list<detail::node_ref_storage<basic_node>>;

    /// @brief The actual storage for a YAML node value of the @ref basic_node class.
    /// @details This union combines the different storage types for the YAML value types defined in @ref node_t.
    /// @note Container types are stored as pointers so that the size of this union will not exceed 64 bits by
    /// default.
    union node_value {
        /// @brief Constructs a new basic_node Value object for null types.
        node_value() = default;

        /// @brief Constructs a new basic_node value object with a node type. The default value for the specified
        /// type will be assigned.
        /// @param[in] type A node type.
        explicit node_value(detail::node_attr_t value_type_bit) {
            switch (value_type_bit) {
            case detail::node_attr_bits::seq_bit:
                p_seq = detail::create_object<sequence_type>();
                break;
            case detail::node_attr_bits::map_bit:
                p_map = detail::create_object<mapping_type>();
                break;
            case detail::node_attr_bits::null_bit:
                p_map = nullptr;
                break;
            case detail::node_attr_bits::bool_bit:
                boolean = static_cast<boolean_type>(false);
                break;
            case detail::node_attr_bits::int_bit:
                integer = static_cast<integer_type>(0);
                break;
            case detail::node_attr_bits::float_bit:
                float_val = static_cast<float_number_type>(0.0);
                break;
            case detail::node_attr_bits::string_bit:
                p_str = detail::create_object<string_type>();
                break;
            default:                   // LCOV_EXCL_LINE
                detail::unreachable(); // LCOV_EXCL_LINE
            }
        }

        /// @brief Destroys the existing Node value. This process is recursive if the specified node type is for
        /// containers.
        /// @param[in] type A Node type to determine the value to be destroyed.
        void destroy(detail::node_attr_t value_type_bit) {
            switch (value_type_bit) {
            case detail::node_attr_bits::seq_bit:
                p_seq->clear();
                detail::destroy_object<sequence_type>(p_seq);
                p_seq = nullptr;
                break;
            case detail::node_attr_bits::map_bit:
                p_map->clear();
                detail::destroy_object<mapping_type>(p_map);
                p_map = nullptr;
                break;
            case detail::node_attr_bits::string_bit:
                detail::destroy_object<string_type>(p_str);
                p_str = nullptr;
                break;
            default:
                break;
            }
        }

        /// A pointer to the value of sequence type.
        sequence_type* p_seq;
        /// A pointer to the value of mapping type. This pointer is also used when node type is null.
        mapping_type* p_map {nullptr};
        /// A value of boolean type.
        boolean_type boolean;
        /// A value of integer type.
        integer_type integer;
        /// A value of float number type.
        float_number_type float_val;
        /// A pointer to the value of string type.
        string_type* p_str;
    };

public:
    /// @brief Constructs a new basic_node object of null type.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/constructor/
    basic_node() = default;

    /// @brief Constructs a new basic_node object with a specified type.
    /// @param[in] type A YAML node type.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/constructor/
    FK_YAML_DEPRECATED("Since 0.3.12; Use explicit basic_node(const node_type)")
    explicit basic_node(const node_t type)
        : basic_node(detail::convert_to_node_type(type)) {
    }

    explicit basic_node(const node_type type)
        : m_attrs(detail::node_attr_bits::from_node_type(type)),
          m_value(m_attrs & detail::node_attr_mask::value) {
    }

    /// @brief Copy constructor of the basic_node class.
    /// @param[in] rhs A basic_node object to be copied with.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/constructor/
    basic_node(const basic_node& rhs)
        : m_attrs(rhs.m_attrs),
          mp_meta(rhs.mp_meta),
          m_prop(rhs.m_prop) {
        if FK_YAML_LIKELY (!has_anchor_name()) {
            switch (m_attrs & detail::node_attr_mask::value) {
            case detail::node_attr_bits::seq_bit:
                m_value.p_seq = detail::create_object<sequence_type>(*(rhs.m_value.p_seq));
                break;
            case detail::node_attr_bits::map_bit:
                m_value.p_map = detail::create_object<mapping_type>(*(rhs.m_value.p_map));
                break;
            case detail::node_attr_bits::null_bit:
                m_value.p_map = nullptr;
                break;
            case detail::node_attr_bits::bool_bit:
                m_value.boolean = rhs.m_value.boolean;
                break;
            case detail::node_attr_bits::int_bit:
                m_value.integer = rhs.m_value.integer;
                break;
            case detail::node_attr_bits::float_bit:
                m_value.float_val = rhs.m_value.float_val;
                break;
            case detail::node_attr_bits::string_bit:
                m_value.p_str = detail::create_object<string_type>(*(rhs.m_value.p_str));
                break;
            default:                   // LCOV_EXCL_LINE
                detail::unreachable(); // LCOV_EXCL_LINE
            }
        }
    }

    /// @brief Move constructor of the basic_node class.
    /// @param[in] rhs A basic_node object to be moved from.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/constructor/
    basic_node(basic_node&& rhs) noexcept
        : m_attrs(rhs.m_attrs),
          mp_meta(std::move(rhs.mp_meta)),
          m_prop(std::move(rhs.m_prop)) {
        if FK_YAML_LIKELY (!has_anchor_name()) {
            switch (m_attrs & detail::node_attr_mask::value) {
            case detail::node_attr_bits::seq_bit:
                FK_YAML_ASSERT(rhs.m_value.p_seq != nullptr);
                m_value.p_seq = rhs.m_value.p_seq;
                rhs.m_value.p_seq = nullptr;
                break;
            case detail::node_attr_bits::map_bit:
                FK_YAML_ASSERT(rhs.m_value.p_map != nullptr);
                m_value.p_map = rhs.m_value.p_map;
                rhs.m_value.p_map = nullptr;
                break;
            case detail::node_attr_bits::null_bit:
                FK_YAML_ASSERT(rhs.m_value.p_map == nullptr);
                m_value.p_map = rhs.m_value.p_map;
                break;
            case detail::node_attr_bits::bool_bit:
                m_value.boolean = rhs.m_value.boolean;
                rhs.m_value.boolean = static_cast<boolean_type>(false);
                break;
            case detail::node_attr_bits::int_bit:
                m_value.integer = rhs.m_value.integer;
                rhs.m_value.integer = static_cast<integer_type>(0);
                break;
            case detail::node_attr_bits::float_bit:
                m_value.float_val = rhs.m_value.float_val;
                rhs.m_value.float_val = static_cast<float_number_type>(0.0);
                break;
            case detail::node_attr_bits::string_bit:
                FK_YAML_ASSERT(rhs.m_value.p_str != nullptr);
                m_value.p_str = rhs.m_value.p_str;
                rhs.m_value.p_str = nullptr;
                break;
            default:                   // LCOV_EXCL_LINE
                detail::unreachable(); // LCOV_EXCL_LINE
            }
        }

        rhs.m_attrs = detail::node_attr_bits::default_bits;
        rhs.m_value.p_map = nullptr;
    }

    /// @brief Construct a new basic_node object from a value of compatible types.
    /// @tparam CompatibleType Type of native data which is compatible with node values.
    /// @tparam U Type of compatible native data without cv-qualifiers and reference.
    /// @param[in] val The value of a compatible type.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/constructor/
    template <
        typename CompatibleType, typename U = detail::remove_cvref_t<CompatibleType>,
        detail::enable_if_t<
            detail::conjunction<
                detail::negation<detail::is_basic_node<U>>,
                detail::disjunction<detail::is_node_compatible_type<basic_node, U>>>::value,
            int> = 0>
    basic_node(CompatibleType&& val) noexcept(
        noexcept(ConverterType<U, void>::to_node(std::declval<basic_node&>(), std::declval<CompatibleType>()))) {
        ConverterType<U, void>::to_node(*this, std::forward<CompatibleType>(val));
    }

    /// @brief Construct a new basic node object with a node_ref_storage object.
    /// @tparam NodeRefStorageType Type of basic_node with reference.
    /// @param[in] node_ref_storage A node_ref_storage template class object.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/constructor/
    template <
        typename NodeRefStorageType,
        detail::enable_if_t<detail::is_node_ref_storage<NodeRefStorageType>::value, int> = 0>
    basic_node(const NodeRefStorageType& node_ref_storage) noexcept
        : basic_node(node_ref_storage.release()) {
    }

    /// @brief Construct a new basic node object with std::initializer_list.
    /// @param[in] init A initializer list of basic_node objects.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/constructor/
    basic_node(initializer_list_t init) {
        bool is_mapping =
            std::all_of(init.begin(), init.end(), [](const detail::node_ref_storage<basic_node>& node_ref) {
                // Do not use is_sequence_impl() since node_ref may be an anchor or alias.
                return node_ref->is_sequence() && node_ref->size() == 2;
            });

        if (is_mapping) {
            m_attrs = detail::node_attr_bits::map_bit;
            m_value.p_map = detail::create_object<mapping_type>();

            auto& map = *m_value.p_map;
            for (auto& elem_ref : init) {
                auto elem = elem_ref.release();
                auto& seq = *elem.m_value.p_seq;
                map.emplace(std::move(seq[0]), std::move(seq[1]));
            }
        }
        else {
            m_attrs = detail::node_attr_bits::seq_bit;
            m_value.p_seq = detail::create_object<sequence_type>();

            auto& seq = *m_value.p_seq;
            seq.reserve(std::distance(init.begin(), init.end()));
            for (auto& elem_ref : init) {
                seq.emplace_back(std::move(elem_ref.release()));
            }
        }
    }

    /// @brief Destroy the basic_node object and its value storage.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/destructor/
    ~basic_node() noexcept // NOLINT(bugprone-exception-escape)
    {
        if (m_attrs & detail::node_attr_mask::anchoring) {
            if (m_attrs & detail::node_attr_bits::anchor_bit) {
                auto itr = mp_meta->anchor_table.equal_range(m_prop.anchor).first;
                std::advance(itr, detail::node_attr_bits::get_anchor_offset(m_attrs));
                itr->second.m_value.destroy(itr->second.m_attrs & detail::node_attr_mask::value);
                itr->second.m_attrs = detail::node_attr_bits::default_bits;
                itr->second.mp_meta.reset();
            }
        }
        else if ((m_attrs & detail::node_attr_bits::null_bit) == 0) {
            m_value.destroy(m_attrs & detail::node_attr_mask::value);
        }

        m_attrs = detail::node_attr_bits::default_bits;
        mp_meta.reset();
    }

public:
    /// @brief Deserialize the first YAML document in the input into a basic_node object.
    /// @tparam InputType Type of a compatible input.
    /// @param[in] input An input source in the YAML format.
    /// @return The resulting basic_node object deserialized from the input source.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/deserialize/
    template <typename InputType>
    static basic_node deserialize(InputType&& input) {
        return deserializer_type().deserialize(detail::input_adapter(std::forward<InputType>(input)));
    }

    /// @brief Deserialize the first YAML document in the input ranged by the iterators into a basic_node object.
    /// @note
    /// Iterators must satisfy the LegacyInputIterator requirements.
    /// See https://en.cppreference.com/w/cpp/named_req/InputIterator.
    /// @tparam ItrType Type of a compatible iterator
    /// @param[in] begin An iterator to the first element of an input sequence.
    /// @param[in] end An iterator to the past-the-last element of an input sequence.
    /// @return The resulting basic_node object deserialized from the pair of iterators.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/deserialize/
    template <typename ItrType>
    static basic_node deserialize(ItrType begin, ItrType end) {
        return deserializer_type().deserialize(
            detail::input_adapter(std::forward<ItrType>(begin), std::forward<ItrType>(end)));
    }

    /// @brief Deserialize all YAML documents in the input into basic_node objects.
    /// @tparam InputType Type of a compatible input.
    /// @param[in] input An input source in the YAML format.
    /// @return The resulting basic_node objects deserialized from the input.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/deserialize_docs/
    template <typename InputType>
    static std::vector<basic_node> deserialize_docs(InputType&& input) {
        return deserializer_type().deserialize_docs(detail::input_adapter(std::forward<InputType>(input)));
    }

    /// @brief Deserialize all YAML documents in the input ranged by the iterators into basic_node objects.
    /// @tparam ItrType Type of a compatible iterator.
    /// @param[in] begin An iterator to the first element of an input sequence.
    /// @param[in] end An iterator to the past-the-last element of an input sequence.
    /// @return The resulting basic_node objects deserialized from the pair of iterators.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/deserialize_docs/
    template <typename ItrType>
    static std::vector<basic_node> deserialize_docs(ItrType&& begin, ItrType&& end) {
        return deserializer_type().deserialize_docs(
            detail::input_adapter(std::forward<ItrType>(begin), std::forward<ItrType>(end)));
    }

    /// @brief Serialize a basic_node object into a string.
    /// @param[in] node A basic_node object to be serialized.
    /// @return The resulting string object from the serialization of the given node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/serialize/
    static std::string serialize(const basic_node& node) {
        return serializer_type().serialize(node);
    }

    /// @brief Serialize basic_node objects into a string.
    /// @param docs basic_node objects to be serialized.
    /// @return The resulting string object from the serialization of the given nodes.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/serialize_docs/
    static std::string serialize_docs(const std::vector<basic_node>& docs) {
        return serializer_type().serialize_docs(docs);
    }

    /// @brief A factory method for sequence basic_node objects without sequence_type objects.
    /// @return A YAML sequence node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/sequence/
    static basic_node sequence() {
        basic_node node;
        node.m_attrs = detail::node_attr_bits::seq_bit;
        node.m_value.p_seq = detail::create_object<sequence_type>();
        return node;
    } // LCOV_EXCL_LINE

    /// @brief A factory method for sequence basic_node objects with lvalue sequence_type objects.
    /// @param[in] seq A lvalue sequence node value.
    /// @return A YAML sequence node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/sequence/
    static basic_node sequence(const sequence_type& seq) {
        basic_node node;
        node.m_attrs = detail::node_attr_bits::seq_bit;
        node.m_value.p_seq = detail::create_object<sequence_type>(seq);
        return node;
    } // LCOV_EXCL_LINE

    /// @brief A factory method for sequence basic_node objects with rvalue sequence_type objects.
    /// @param[in] seq A rvalue sequence node value.
    /// @return A YAML sequence node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/sequence/
    static basic_node sequence(sequence_type&& seq) {
        basic_node node;
        node.m_attrs = detail::node_attr_bits::seq_bit;
        node.m_value.p_seq = detail::create_object<sequence_type>(std::move(seq));
        return node;
    } // LCOV_EXCL_LINE

    /// @brief A factory method for mapping basic_node objects without mapping_type objects.
    /// @return A YAML mapping node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/mapping/
    static basic_node mapping() {
        basic_node node;
        node.m_attrs = detail::node_attr_bits::map_bit;
        node.m_value.p_map = detail::create_object<mapping_type>();
        return node;
    } // LCOV_EXCL_LINE

    /// @brief A factory method for mapping basic_node objects with lvalue mapping_type objects.
    /// @param[in] map A lvalue mapping node value.
    /// @return A YAML mapping node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/mapping/
    static basic_node mapping(const mapping_type& map) {
        basic_node node;
        node.m_attrs = detail::node_attr_bits::map_bit;
        node.m_value.p_map = detail::create_object<mapping_type>(map);
        return node;
    } // LCOV_EXCL_LINE

    /// @brief A factory method for mapping basic_node objects with rvalue mapping_type objects.
    /// @param[in] map A rvalue mapping node value.
    /// @return A YAML mapping node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/mapping/
    static basic_node mapping(mapping_type&& map) {
        basic_node node;
        node.m_attrs = detail::node_attr_bits::map_bit;
        node.m_value.p_map = detail::create_object<mapping_type>(std::move(map));
        return node;
    } // LCOV_EXCL_LINE

    /// @brief A factory method for alias basic_node objects referencing the given anchor basic_node object.
    /// @note The given anchor basic_node must have a non-empty anchor name.
    /// @param[in] anchor_node A basic_node object with an anchor name.
    /// @return An alias YAML node created from the given anchor node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/alias_of/
    static basic_node alias_of(const basic_node& anchor_node) {
        constexpr detail::node_attr_t anchor_bit = detail::node_attr_bits::anchor_bit;

        if FK_YAML_UNLIKELY (!anchor_node.has_anchor_name() || !(anchor_node.m_attrs & anchor_bit)) {
            throw fkyaml::exception("Cannot create an alias without anchor name.");
        }

        basic_node node = anchor_node;
        node.m_attrs &= ~detail::node_attr_mask::anchoring;
        node.m_attrs |= detail::node_attr_bits::alias_bit;
        return node;
    } // LCOV_EXCL_LINE

public:
    /// @brief A copy assignment operator of the basic_node class.
    /// @param[in] rhs A lvalue basic_node object to be copied with.
    /// @return Reference to this basic_node object.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator=/
    basic_node& operator=(const basic_node& rhs) noexcept {
        basic_node(rhs).swap(*this);
        return *this;
    }

    /// @brief A move assignment operator of the basic_node class.
    /// @param[in] rhs A rvalue basic_node object to be moved from.
    /// @return Reference to this basic_node object.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator=/
    basic_node& operator=(basic_node&& rhs) noexcept {
        basic_node(std::move(rhs)).swap(*this);
        return *this;
    }

    /// @brief A subscript operator of the basic_node class with a key of a compatible type with basic_node.
    /// @tparam KeyType A key type compatible with basic_node
    /// @param key A key to the target value in a sequence/mapping node.
    /// @return The value associated with the given key, or a default basic_node object associated with the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator[]/
    template <
        typename KeyType, detail::enable_if_t<
                              detail::conjunction<
                                  detail::negation<detail::is_basic_node<KeyType>>,
                                  detail::is_node_compatible_type<basic_node, KeyType>>::value,
                              int> = 0>
    basic_node& operator[](KeyType&& key) {
        basic_node& act_node = resolve_reference();

        if FK_YAML_UNLIKELY (act_node.is_scalar_impl()) {
            throw fkyaml::type_error("operator[] is unavailable for a scalar node.", get_type());
        }

        basic_node key_node = std::forward<KeyType>(key);

        if (act_node.is_sequence_impl()) {
            // Do not use is_integer_impl() since n may be an anchor or alias.
            if FK_YAML_UNLIKELY (!key_node.is_integer()) {
                throw fkyaml::type_error(
                    "An argument of operator[] for sequence nodes must be an integer.", get_type());
            }
            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            return act_node.m_value.p_seq->operator[](key_node.get_value<int>());
        }

        FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
        return act_node.m_value.p_map->operator[](std::move(key_node));
    }

    /// @brief A subscript operator of the basic_node class with a key of a compatible type with basic_node.
    /// @tparam KeyType A key type compatible with basic_node
    /// @param key A key to the target value in a sequence/mapping node.
    /// @return The value associated with the given key, or a default basic_node object associated with the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator[]/
    template <
        typename KeyType, detail::enable_if_t<
                              detail::conjunction<
                                  detail::negation<detail::is_basic_node<KeyType>>,
                                  detail::is_node_compatible_type<basic_node, KeyType>>::value,
                              int> = 0>
    const basic_node& operator[](KeyType&& key) const {
        const basic_node& act_node = resolve_reference();

        if FK_YAML_UNLIKELY (act_node.is_scalar_impl()) {
            throw fkyaml::type_error("operator[] is unavailable for a scalar node.", get_type());
        }

        basic_node key_node = std::forward<KeyType>(key);

        if (act_node.is_sequence_impl()) {
            if FK_YAML_UNLIKELY (!key_node.is_integer_impl()) {
                throw fkyaml::type_error(
                    "An argument of operator[] for sequence nodes must be an integer.", get_type());
            }
            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            return act_node.m_value.p_seq->operator[](key_node.get_value<int>());
        }

        FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
        return act_node.m_value.p_map->operator[](std::move(key_node));
    }

    /// @brief A subscript operator of the basic_node class with a basic_node key object.
    /// @tparam KeyType A key type which is a kind of the basic_node template class.
    /// @param key A key to the target value in a sequence/mapping node.
    /// @return The value associated with the given key, or a default basic_node object associated with the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator[]/
    template <typename KeyType, detail::enable_if_t<detail::is_basic_node<KeyType>::value, int> = 0>
    basic_node& operator[](KeyType&& key) {
        if FK_YAML_UNLIKELY (is_scalar()) {
            throw fkyaml::type_error("operator[] is unavailable for a scalar node.", get_type());
        }

        const node_value& node_value = resolve_reference().m_value;

        if (is_sequence()) {
            if FK_YAML_UNLIKELY (!key.is_integer()) {
                throw fkyaml::type_error(
                    "An argument of operator[] for sequence nodes must be an integer.", get_type());
            }
            FK_YAML_ASSERT(node_value.p_seq != nullptr);
            return node_value.p_seq->operator[](std::forward<KeyType>(key).template get_value<int>());
        }

        FK_YAML_ASSERT(node_value.p_map != nullptr);
        return node_value.p_map->operator[](std::forward<KeyType>(key));
    }

    /// @brief A subscript operator of the basic_node class with a basic_node key object.
    /// @tparam KeyType A key type which is a kind of the basic_node template class.
    /// @param key A key to the target value in a sequence/mapping node.
    /// @return The value associated with the given key, or a default basic_node object associated with the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator[]/
    template <typename KeyType, detail::enable_if_t<detail::is_basic_node<KeyType>::value, int> = 0>
    const basic_node& operator[](KeyType&& key) const {
        if FK_YAML_UNLIKELY (is_scalar()) {
            throw fkyaml::type_error("operator[] is unavailable for a scalar node.", get_type());
        }

        const node_value& node_value = resolve_reference().m_value;

        if (is_sequence()) {
            if FK_YAML_UNLIKELY (!key.is_integer()) {
                throw fkyaml::type_error(
                    "An argument of operator[] for sequence nodes must be an integer.", get_type());
            }
            FK_YAML_ASSERT(node_value.p_seq != nullptr);
            return node_value.p_seq->operator[](key.template get_value<int>());
        }

        FK_YAML_ASSERT(node_value.p_map != nullptr);
        return node_value.p_map->operator[](std::forward<KeyType>(key));
    }

    /// @brief An equal-to operator of the basic_node class.
    /// @param rhs A basic_node object to be compared with this basic_node object.
    /// @return true if both types and values are equal, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator_eq/
    bool operator==(const basic_node& rhs) const noexcept {
        const basic_node& lhs = resolve_reference();
        const basic_node& act_rhs = rhs.resolve_reference();

        const detail::node_attr_t lhs_val_bit = lhs.m_attrs & detail::node_attr_mask::value;
        if (lhs_val_bit != (act_rhs.m_attrs & detail::node_attr_mask::value)) {
            return false;
        }

        bool ret = false;
        switch (lhs_val_bit) {
        case detail::node_attr_bits::seq_bit:
            ret = (*(lhs.m_value.p_seq) == *(act_rhs.m_value.p_seq));
            break;
        case detail::node_attr_bits::map_bit:
            ret = (*(lhs.m_value.p_map) == *(act_rhs.m_value.p_map));
            break;
        case detail::node_attr_bits::null_bit:
            // Always true for comparisons between null nodes.
            ret = true;
            break;
        case detail::node_attr_bits::bool_bit:
            ret = (lhs.m_value.boolean == act_rhs.m_value.boolean);
            break;
        case detail::node_attr_bits::int_bit:
            ret = (lhs.m_value.integer == act_rhs.m_value.integer);
            break;
        case detail::node_attr_bits::float_bit:
            ret =
                (std::abs(lhs.m_value.float_val - act_rhs.m_value.float_val) <
                 std::numeric_limits<float_number_type>::epsilon());
            break;
        case detail::node_attr_bits::string_bit:
            ret = (*(lhs.m_value.p_str) == *(act_rhs.m_value.p_str));
            break;
        default:                   // LCOV_EXCL_LINE
            detail::unreachable(); // LCOV_EXCL_LINE
        }

        return ret;
    }

    /// @brief A not-equal-to operator of the basic_node class.
    /// @param rhs A basic_node object to be compared with this basic_node object.
    /// @return true if either types or values are different, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator_ne/
    bool operator!=(const basic_node& rhs) const noexcept {
        return !operator==(rhs);
    }

    /// @brief A less-than operator of the basic_node class.
    /// @param rhs A basic_node object to be compared with this basic_node object.
    /// @return true this basic_node object is less than `rhs`.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator_lt/
    bool operator<(const basic_node& rhs) const noexcept {
        if (operator==(rhs)) {
            return false;
        }

        const basic_node& lhs = resolve_reference();
        const basic_node& act_rhs = rhs.resolve_reference();

        const detail::node_attr_t lhs_val_bit = lhs.m_attrs & detail::node_attr_mask::value;
        const detail::node_attr_t rhs_val_bit = act_rhs.m_attrs & detail::node_attr_mask::value;

        if (lhs_val_bit < rhs_val_bit) {
            return true;
        }

        if (lhs_val_bit != rhs_val_bit) {
            return false;
        }

        bool ret = false;
        switch (lhs_val_bit) {
        case detail::node_attr_bits::seq_bit:
            ret = (*(lhs.m_value.p_seq) < *(act_rhs.m_value.p_seq));
            break;
        case detail::node_attr_bits::map_bit:
            ret = (*(lhs.m_value.p_map) < *(act_rhs.m_value.p_map));
            break;
        case detail::node_attr_bits::null_bit: // LCOV_EXCL_LINE
            // Will not come here since null nodes are always the same.
            detail::unreachable(); // LCOV_EXCL_LINE
        case detail::node_attr_bits::bool_bit:
            // false < true
            ret = (!lhs.m_value.boolean && act_rhs.m_value.boolean);
            break;
        case detail::node_attr_bits::int_bit:
            ret = (lhs.m_value.integer < act_rhs.m_value.integer);
            break;
        case detail::node_attr_bits::float_bit:
            ret = (lhs.m_value.float_val < act_rhs.m_value.float_val);
            break;
        case detail::node_attr_bits::string_bit:
            ret = (*(lhs.m_value.p_str) < *(act_rhs.m_value.p_str));
            break;
        default:                   // LCOV_EXCL_LINE
            detail::unreachable(); // LCOV_EXCL_LINE
        }

        return ret;
    }

    /// @brief A less-than-or-equal-to operator of the basic_node class.
    /// @param rhs A basic_node object to be compared with this basic_node object.
    /// @return true this basic_node object is less than or equal to `rhs`.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator_le/
    bool operator<=(const basic_node& rhs) const noexcept {
        return !rhs.operator<(*this);
    }

    /// @brief A greater-than operator of the basic_node class.
    /// @param rhs A basic_node object to be compared with this basic_node object.
    /// @return true this basic_node object is greater than `rhs`.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator_gt/
    bool operator>(const basic_node& rhs) const noexcept {
        return !operator<=(rhs);
    }

    /// @brief A greater-than-or-equal-to operator of the basic_node class.
    /// @param rhs A basic_node object to be compared with this basic_node object.
    /// @return true this basic_node object is greater than or equal to `rhs`.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/operator_ge/
    bool operator>=(const basic_node& rhs) const noexcept {
        return !operator<(rhs);
    }

public:
    /// @brief Returns the type of the current basic_node value.
    /// @return The type of the YAML node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_type/
    node_type get_type() const noexcept {
        return detail::node_attr_bits::to_node_type(resolve_reference().m_attrs);
    }

    /// @brief Returns the type of the current basic_node value.
    /// @deprecated Use get_type() function. (since 0.3.12)
    /// @return The type of the YAML node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/type/
    FK_YAML_DEPRECATED("Since 0.3.12; Use get_type()")
    node_t type() const noexcept {
        node_type tmp_type = get_type();
        return detail::convert_from_node_type(tmp_type);
    }

    /// @brief Tests whether the current basic_node value is of sequence type.
    /// @return true if the type is sequence, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_sequence/
    bool is_sequence() const noexcept {
        return resolve_reference().is_sequence_impl();
    }

    /// @brief Tests whether the current basic_node value is of mapping type.
    /// @return true if the type is mapping, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_mapping/
    bool is_mapping() const noexcept {
        return resolve_reference().is_mapping_impl();
    }

    /// @brief Tests whether the current basic_node value is of null type.
    /// @return true if the type is null, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_null/
    bool is_null() const noexcept {
        return resolve_reference().is_null_impl();
    }

    /// @brief Tests whether the current basic_node value is of boolean type.
    /// @return true if the type is boolean, false otherwise
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_boolean/
    bool is_boolean() const noexcept {
        return resolve_reference().is_boolean_impl();
    }

    /// @brief Tests whether the current basic_node value is of integer type.
    /// @return true if the type is integer, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_integer/
    bool is_integer() const noexcept {
        return resolve_reference().is_integer_impl();
    }

    /// @brief Tests whether the current basic_node value is of float number type.
    /// @return true if the type is floating point number, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_float_number/
    bool is_float_number() const noexcept {
        return resolve_reference().is_float_number_impl();
    }

    /// @brief Tests whether the current basic_node value is of string type.
    /// @return true if the type is string, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_string/
    bool is_string() const noexcept {
        return resolve_reference().is_string_impl();
    }

    /// @brief Tests whether the current basic_node value is of scalar types.
    /// @return true if the type is scalar, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_scalar/
    bool is_scalar() const noexcept {
        return resolve_reference().is_scalar_impl();
    }

    /// @brief Tests whether the current basic_node is an anchor node.
    /// @return true if the current basic_node is an anchor node, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_anchor/
    bool is_anchor() const noexcept {
        return m_attrs & detail::node_attr_bits::anchor_bit;
    }

    /// @brief Tests whether the current basic_node is an alias node.
    /// @return true if the current basic_node is an alias node, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/is_alias/
    bool is_alias() const noexcept {
        return m_attrs & detail::node_attr_bits::alias_bit;
    }

    /// @brief Tests whether the current basic_node value (sequence, mapping, string) is empty.
    /// @return true if the node value is empty, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/empty/
    bool empty() const {
        const basic_node& act_node = resolve_reference();
        switch (act_node.m_attrs & detail::node_attr_mask::value) {
        case detail::node_attr_bits::seq_bit: {
            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            return act_node.m_value.p_seq->empty();
        }
        case detail::node_attr_bits::map_bit: {
            FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
            return act_node.m_value.p_map->empty();
        }
        case detail::node_attr_bits::string_bit: {
            FK_YAML_ASSERT(act_node.m_value.p_str != nullptr);
            return act_node.m_value.p_str->empty();
        }
        default:
            throw fkyaml::type_error("The target node is not of a container type.", get_type());
        }
    }

    /// @brief Returns the size of the current basic_node value (sequence, mapping, string).
    /// @return The size of a node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/size/
    std::size_t size() const {
        const basic_node& act_node = resolve_reference();
        switch (act_node.m_attrs & detail::node_attr_mask::value) {
        case detail::node_attr_bits::seq_bit:
            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            return act_node.m_value.p_seq->size();
        case detail::node_attr_bits::map_bit:
            FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
            return act_node.m_value.p_map->size();
        case detail::node_attr_bits::string_bit:
            FK_YAML_ASSERT(act_node.m_value.p_str != nullptr);
            return act_node.m_value.p_str->size();
        default:
            throw fkyaml::type_error("The target node is not of a container type.", get_type());
        }
    }

    /// @brief Check whether this basic_node object has a given key in its inner mapping node value.
    /// @tparam KeyType A key type compatible with basic_node.
    /// @param key A key to the target value in the mapping node value.
    /// @return true if the target node is a mapping and has the given key, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/contains/
    template <
        typename KeyType, detail::enable_if_t<
                              detail::disjunction<
                                  detail::is_basic_node<KeyType>,
                                  detail::is_node_compatible_type<basic_node, detail::remove_cvref_t<KeyType>>>::value,
                              int> = 0>
    bool contains(KeyType&& key) const {
        const basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.m_attrs & detail::node_attr_bits::map_bit) {
            FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
            const auto& map = *act_node.m_value.p_map;
            return map.find(std::forward<KeyType>(key)) != map.end();
        }

        return false;
    }

    /// @brief Get a basic_node object with a key of a compatible type.
    /// @tparam KeyType A key type compatible with basic_node
    /// @param key A key to the target basic_node object in a sequence/mapping node.
    /// @return Reference to the basic_node object associated with the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/at/
    template <
        typename KeyType, detail::enable_if_t<
                              detail::conjunction<
                                  detail::negation<detail::is_basic_node<KeyType>>,
                                  detail::is_node_compatible_type<basic_node, KeyType>>::value,
                              int> = 0>
    basic_node& at(KeyType&& key) {
        basic_node& act_node = resolve_reference();

        if FK_YAML_UNLIKELY (act_node.is_scalar_impl()) {
            throw fkyaml::type_error("at() is unavailable for a scalar node.", get_type());
        }

        basic_node node_key = std::forward<KeyType>(key);

        if (act_node.is_sequence_impl()) {
            if FK_YAML_UNLIKELY (!node_key.is_integer_impl()) {
                throw fkyaml::type_error("An argument of at() for sequence nodes must be an integer.", get_type());
            }

            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            sequence_type& seq = *act_node.m_value.p_seq;
            int index = std::move(node_key).template get_value<int>();
            int size = static_cast<int>(seq.size());
            if FK_YAML_UNLIKELY (index >= size) {
                throw fkyaml::out_of_range(index);
            }
            return seq[index];
        }

        FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
        mapping_type& map = *act_node.m_value.p_map;
        const bool is_found = map.find(node_key) != map.end();
        if FK_YAML_UNLIKELY (!is_found) {
            throw fkyaml::out_of_range(serialize(node_key).c_str());
        }
        return map[std::move(node_key)];
    }

    /// @brief Get a basic_node object with a key of a compatible type.
    /// @tparam KeyType A key type compatible with basic_node
    /// @param key A key to the target basic_node object in a sequence/mapping node.
    /// @return Constant reference to the basic_node object associated with the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/at/
    template <
        typename KeyType, detail::enable_if_t<
                              detail::conjunction<
                                  detail::negation<detail::is_basic_node<KeyType>>,
                                  detail::is_node_compatible_type<basic_node, KeyType>>::value,
                              int> = 0>
    const basic_node& at(KeyType&& key) const {
        const basic_node& act_node = resolve_reference();

        if FK_YAML_UNLIKELY (act_node.is_scalar_impl()) {
            throw fkyaml::type_error("at() is unavailable for a scalar node.", get_type());
        }

        basic_node node_key = std::forward<KeyType>(key);

        if (act_node.is_sequence_impl()) {
            if FK_YAML_UNLIKELY (!node_key.is_integer()) {
                throw fkyaml::type_error("An argument of at() for sequence nodes must be an integer.", get_type());
            }

            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            const sequence_type& seq = *act_node.m_value.p_seq;
            int index = std::move(node_key).template get_value<int>();
            int size = static_cast<int>(seq.size());
            if FK_YAML_UNLIKELY (index >= size) {
                throw fkyaml::out_of_range(index);
            }
            return seq[index];
        }

        FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
        const mapping_type& map = *act_node.m_value.p_map;
        const bool is_found = map.find(node_key) != map.end();
        if FK_YAML_UNLIKELY (!is_found) {
            throw fkyaml::out_of_range(serialize(node_key).c_str());
        }
        return map.at(std::move(node_key));
    }

    /// @brief Get a basic_node object with a basic_node key object.
    /// @tparam KeyType A key type which is a kind of the basic_node template class.
    /// @param key A key to the target basic_node object in a sequence/mapping node.
    /// @return Reference to the basic_node object associated with the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/at/
    template <typename KeyType, detail::enable_if_t<detail::is_basic_node<KeyType>::value, int> = 0>
    basic_node& at(KeyType&& key) {
        basic_node& act_node = resolve_reference();
        if FK_YAML_UNLIKELY (act_node.is_scalar_impl()) {
            throw fkyaml::type_error("at() is unavailable for a scalar node.", get_type());
        }

        if (act_node.is_sequence_impl()) {
            if FK_YAML_UNLIKELY (!key.is_integer()) {
                throw fkyaml::type_error("An argument of at() for sequence nodes must be an integer.", get_type());
            }

            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            sequence_type& seq = *act_node.m_value.p_seq;
            int index = std::forward<KeyType>(key).template get_value<int>();
            int size = static_cast<int>(seq.size());
            if FK_YAML_UNLIKELY (index >= size) {
                throw fkyaml::out_of_range(index);
            }
            return seq[index];
        }

        FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
        mapping_type& map = *act_node.m_value.p_map;
        bool is_found = map.find(key) != map.end();
        if FK_YAML_UNLIKELY (!is_found) {
            throw fkyaml::out_of_range(serialize(key).c_str());
        }
        return map[std::forward<KeyType>(key)];
    }

    /// @brief Get a basic_node object with a basic_node key object.
    /// @tparam KeyType A key type which is a kind of the basic_node template class.
    /// @param key A key to the target basic_node object in a sequence/mapping node.
    /// @return Constant reference to the basic_node object associated with the given key.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/at/
    template <typename KeyType, detail::enable_if_t<detail::is_basic_node<KeyType>::value, int> = 0>
    const basic_node& at(KeyType&& key) const {
        const basic_node& act_node = resolve_reference();
        if FK_YAML_UNLIKELY (act_node.is_scalar_impl()) {
            throw fkyaml::type_error("at() is unavailable for a scalar node.", get_type());
        }

        if (act_node.is_sequence_impl()) {
            if FK_YAML_UNLIKELY (!key.is_integer()) {
                throw fkyaml::type_error("An argument of at() for sequence nodes must be an integer.", get_type());
            }

            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            const sequence_type& seq = *act_node.m_value.p_seq;
            int index = std::forward<KeyType>(key).template get_value<int>();
            int size = static_cast<int>(seq.size());
            if FK_YAML_UNLIKELY (index >= size) {
                throw fkyaml::out_of_range(index);
            }
            return seq[index];
        }

        FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
        const mapping_type& map = *act_node.m_value.p_map;
        bool is_found = map.find(key) != map.end();
        if FK_YAML_UNLIKELY (!is_found) {
            throw fkyaml::out_of_range(serialize(key).c_str());
        }
        return map.at(std::forward<KeyType>(key));
    }

    /// @brief Get the YAML version for this basic_node object.
    /// @return The YAML version if already set, `yaml_version_type::VERSION_1_2` otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_yaml_version_type/
    yaml_version_type get_yaml_version_type() const noexcept {
        return mp_meta->is_version_specified ? mp_meta->version : yaml_version_type::VERSION_1_2;
    }

    /// @brief Set the YAML version for this basic_node object.
    /// @param[in] version The target YAML version.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/set_yaml_version_type/
    void set_yaml_version_type(const yaml_version_type version) noexcept {
        mp_meta->version = version;
        mp_meta->is_version_specified = true;
    }

    /// @brief Get the YAML version for this basic_node object.
    /// @deprecated Use get_yaml_version_type() function. (since 0.3.12)
    /// @return The YAML version if already set, `yaml_version_t::VER_1_2` otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_yaml_version/
    FK_YAML_DEPRECATED("Since 0.3.12; Use get_yaml_version_type()")
    yaml_version_t get_yaml_version() const noexcept {
        yaml_version_type tmp_type = get_yaml_version_type();
        return detail::convert_from_yaml_version_type(tmp_type);
    }

    /// @brief Set the YAML version for this basic_node object.
    /// @deprecated Use set_yaml_version_type(yaml_version_type) function. (since 0.3.12)
    /// @param[in] version The target YAML version.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/set_yaml_version/
    FK_YAML_DEPRECATED("Since 0.3.12; Use set_yaml_version_type(const yaml_version_type)")
    void set_yaml_version(const yaml_version_t version) noexcept {
        set_yaml_version_type(detail::convert_to_yaml_version_type(version));
    }

    /// @brief Check whether this basic_node object has already had any anchor name.
    /// @return true if ths basic_node has an anchor name, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/has_anchor_name/
    bool has_anchor_name() const noexcept {
        return (m_attrs & detail::node_attr_mask::anchoring) && !m_prop.anchor.empty();
    }

    /// @brief Get the anchor name associated with this basic_node object.
    /// @note Some anchor name must be set before calling this method. Call has_anchor_name() to see if this basic_node
    /// object has any anchor name.
    /// @return The anchor name associated with the node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_anchor_name/
    const std::string& get_anchor_name() const {
        if FK_YAML_UNLIKELY (!has_anchor_name()) {
            throw fkyaml::exception("No anchor name has been set.");
        }
        return m_prop.anchor;
    }

    /// @brief Add an anchor name to this basic_node object.
    /// @note If this basic_node object has already had any anchor name, the new anchor name will overwrite the old one.
    /// @param[in] anchor_name An anchor name. This should not be empty.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/add_anchor_name/
    void add_anchor_name(const std::string& anchor_name) {
        if (is_anchor()) {
            m_attrs &= ~detail::node_attr_mask::anchoring;
            auto itr = mp_meta->anchor_table.equal_range(m_prop.anchor).first;
            std::advance(itr, detail::node_attr_bits::get_anchor_offset(m_attrs));
            mp_meta.reset();
            itr->second.swap(*this);
            mp_meta->anchor_table.erase(itr);
        }

        auto p_meta = mp_meta;

        basic_node node;
        node.swap(*this);
        p_meta->anchor_table.emplace(anchor_name, std::move(node));

        m_attrs &= ~detail::node_attr_mask::anchoring;
        m_attrs |= detail::node_attr_bits::anchor_bit;
        mp_meta = p_meta;
        const auto offset = static_cast<uint32_t>(mp_meta->anchor_table.count(anchor_name) - 1);
        detail::node_attr_bits::set_anchor_offset(offset, m_attrs);
        m_prop.anchor = anchor_name;
    }

    /// @brief Add an anchor name to this basic_node object.
    /// @note If this basic_node object has already had any anchor name, the new anchor name will overwrite the old one.
    /// @param[in] anchor_name An anchor name. This should not be empty.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/add_anchor_name/
    void add_anchor_name(std::string&& anchor_name) {
        if (is_anchor()) {
            m_attrs &= ~detail::node_attr_mask::anchoring;
            auto itr = mp_meta->anchor_table.equal_range(m_prop.anchor).first;
            std::advance(itr, detail::node_attr_bits::get_anchor_offset(m_attrs));
            mp_meta.reset();
            itr->second.swap(*this);
            mp_meta->anchor_table.erase(itr);
        }

        auto p_meta = mp_meta;

        basic_node node;
        node.swap(*this);
        p_meta->anchor_table.emplace(anchor_name, std::move(node));

        m_attrs &= ~detail::node_attr_mask::anchoring;
        m_attrs |= detail::node_attr_bits::anchor_bit;
        mp_meta = p_meta;
        auto offset = static_cast<uint32_t>(mp_meta->anchor_table.count(anchor_name) - 1);
        detail::node_attr_bits::set_anchor_offset(offset, m_attrs);
        m_prop.anchor = std::move(anchor_name);
    }

    /// @brief Check whether this basic_node object has already had any tag name.
    /// @return true if ths basic_node has a tag name, false otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/has_tag_name/
    bool has_tag_name() const noexcept {
        return !m_prop.tag.empty();
    }

    /// @brief Get the tag name associated with this basic_node object.
    /// @note Some tag name must be set before calling this method. Call has_tag_name() to see if this basic_node
    /// object has any tag name.
    /// @return The tag name associated with the node. It may be empty.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_tag_name/
    const std::string& get_tag_name() const {
        if FK_YAML_UNLIKELY (!has_tag_name()) {
            throw fkyaml::exception("No tag name has been set.");
        }
        return m_prop.tag;
    }

    /// @brief Add a tag name to this basic_node object.
    /// @note If this basic_node object has already had any tag name, the new tag name will overwrite the old one.
    /// @param[in] tag_name A tag name to get associated with this basic_node object.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/add_tag_name/
    void add_tag_name(const std::string& tag_name) {
        m_prop.tag = tag_name;
    }

    /// @brief Add a tag name to this basic_node object.
    /// @note If this basic_node object has already had any tag name, the new tag name will overwrite the old one.
    /// @param[in] tag_name A tag name to get associated with this basic_node object.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/add_tag_name/
    void add_tag_name(std::string&& tag_name) {
        m_prop.tag = std::move(tag_name);
    }

    /// @brief Get the node value object converted into a given type.
    /// @note This function requires T objects to be default constructible. Also, T cannot be either a reference,
    /// pointer or C-style array type.
    /// @tparam T A compatible value type which may be cv-qualified.
    /// @tparam ValueType A compatible value type (T without cv-qualifiers by default).
    /// @return A value converted from this basic_node object.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_value/
    template <
        typename T, typename ValueType = detail::remove_cv_t<T>,
        detail::enable_if_t<
            detail::conjunction<std::is_default_constructible<ValueType>, detail::negation<std::is_pointer<T>>>::value,
            int> = 0>
    T get_value() const noexcept(
        noexcept(std::declval<const basic_node&>().template get_value_impl<ValueType>(std::declval<ValueType&>()))) {
        // emit a compile error if T is either a reference, pointer or C-style array type.
        static_assert(
            !std::is_reference<T>::value,
            "get_value() cannot be called with reference types. "
            "You might want to call one of as_seq(), as_map(), as_bool(), as_int(), as_float() or as_str().");
        static_assert(
            !std::is_array<T>::value,
            "get_value() cannot be called with C-style array types. You might want to call get_value_inplace().");

        auto ret = ValueType();
        resolve_reference().get_value_impl(ret);
        return ret;
    }

    /// @brief Get the node value object converted into a given type. The conversion result is filled into `value_ref`.
    /// @tparam T A compatible value type.
    /// @param value_ref A storage into which the conversion result is filled.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_value_inplace/
    template <typename T>
    void get_value_inplace(T& value_ref) const
        noexcept(noexcept(std::declval<const basic_node&>().template get_value_impl<T>(std::declval<T&>()))) {
        resolve_reference().get_value_impl(value_ref);
    }

    /// @brief Get the node value object converted to a given type. If the conversion fails, this function returns a
    /// given default value instead.
    /// @note This function requires T to be default constructible. Also, T cannot be either a reference, pointer or
    /// C-style array type.
    /// @tparam T A compatible value type which may be cv-qualified.
    /// @tparam U A default value type from which T must be constructible.
    /// @param default_value The default value returned if conversion fails.
    /// @return A value converted from this basic_node object if conversion succeeded, the given default value
    /// otherwise.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_value_or/
    template <
        typename T, typename U,
        detail::enable_if_t<
            detail::conjunction<
                std::is_constructible<T, U>, std::is_default_constructible<T>,
                detail::negation<std::is_pointer<T>>>::value,
            int> = 0>
    T get_value_or(U&& default_value) const noexcept {
        static_assert(
            !std::is_reference<T>::value,
            "get_value_or() cannot be called with reference types. "
            "You might want to call one of as_seq(), as_map(), as_bool(), as_int(), as_float() or as_str().");
        static_assert(
            !std::is_array<T>::value,
            "get_value_or() cannot be called with C-style array types. You might want to call get_value_inplace().");

        // TODO:
        // Ideally, there should be no exception thrown in this kind of function. However, achieving that would require
        // a lot of refactoring and/or some API changes, especially `from_node` interface definition. So, try-catch is
        // used instead for now.
        try {
            return get_value<T>();
        }
        catch (const std::exception& /*unused*/) {
            // Any exception derived from std::exception is interpreted as a conversion failure in some way
            // since user-defined from_node function may throw a different object from a fkyaml::type_error.
            // and std::exception is usually the base class of user-defined exception types.
            return std::forward<U>(default_value);
        }
    }

    /// @brief Explicit reference access to the internally stored YAML node value.
    /// @tparam ReferenceType Reference type to the target YAML node value.
    /// @return Reference to the internally stored YAML node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_value_ref/
    template <typename ReferenceType, detail::enable_if_t<std::is_reference<ReferenceType>::value, int> = 0>
    FK_YAML_DEPRECATED("Since 0.4.3; Use one of as_seq(), as_map(), as_bool(), as_int(), as_float() or as_str()")
    ReferenceType get_value_ref() {
        return get_value_ref_impl(static_cast<detail::add_pointer_t<ReferenceType>>(nullptr));
    }

    /// @brief Explicit reference access to the internally stored YAML node value.
    /// @tparam ReferenceType Constant reference type to the target YAML node value.
    /// @return Constant reference to the internally stored YAML node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/get_value_ref/
    template <
        typename ReferenceType,
        detail::enable_if_t<
            detail::conjunction<
                std::is_reference<ReferenceType>, std::is_const<detail::remove_reference_t<ReferenceType>>>::value,
            int> = 0>
    FK_YAML_DEPRECATED("Since 0.4.3; Use one of as_seq(), as_map(), as_bool(), as_int(), as_float() or as_str()")
    ReferenceType get_value_ref() const {
        return get_value_ref_impl(static_cast<detail::add_pointer_t<ReferenceType>>(nullptr));
    }

    /// @brief Returns reference to the sequence node value.
    /// @throw fkyaml::type_error The node value is not a sequence.
    /// @return Reference to the sequence node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_seq/
    sequence_type& as_seq() {
        basic_node& act_node = resolve_reference(); // NOLINT(misc-const-correctness)
        if FK_YAML_LIKELY (act_node.is_sequence_impl()) {
            return *act_node.m_value.p_seq;
        }
        throw fkyaml::type_error("The node value is not a sequence.", get_type());
    }

    /// @brief Returns constant reference to the sequence node value.
    /// @throw fkyaml::type_error The node value is not a sequence.
    /// @return Constant reference to the sequence node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_seq/
    const sequence_type& as_seq() const {
        const basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_sequence_impl()) {
            return *act_node.m_value.p_seq;
        }
        throw fkyaml::type_error("The node value is not a sequence.", get_type());
    }

    /// @brief Returns reference to the mapping node value.
    /// @throw fkyaml::type_error The node value is not a mapping.
    /// @return Reference to the mapping node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_map/
    mapping_type& as_map() {
        basic_node& act_node = resolve_reference(); // NOLINT(misc-const-correctness)
        if FK_YAML_LIKELY (act_node.is_mapping_impl()) {
            return *act_node.m_value.p_map;
        }
        throw fkyaml::type_error("The node value is not a mapping.", get_type());
    }

    /// @brief Returns constant reference to the mapping node value.
    /// @throw fkyaml::type_error The node value is not a mapping.
    /// @return Constant reference to the mapping node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_map/
    const mapping_type& as_map() const {
        const basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_mapping_impl()) {
            return *act_node.m_value.p_map;
        }
        throw fkyaml::type_error("The node value is not a mapping.", get_type());
    }

    /// @brief Returns reference to the boolean node value.
    /// @throw fkyaml::type_error The node value is not a boolean.
    /// @return Reference to the boolean node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_bool/
    boolean_type& as_bool() {
        basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_boolean_impl()) {
            return act_node.m_value.boolean;
        }
        throw fkyaml::type_error("The node value is not a boolean.", get_type());
    }

    /// @brief Returns reference to the boolean node value.
    /// @throw fkyaml::type_error The node value is not a boolean.
    /// @return Constant reference to the boolean node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_bool/
    const boolean_type& as_bool() const {
        const basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_boolean_impl()) {
            return act_node.m_value.boolean;
        }
        throw fkyaml::type_error("The node value is not a boolean.", get_type());
    }

    /// @brief Returns reference to the integer node value.
    /// @throw fkyaml::type_error The node value is not an integer.
    /// @return Reference to the integer node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_int/
    integer_type& as_int() {
        basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_integer_impl()) {
            return act_node.m_value.integer;
        }
        throw fkyaml::type_error("The node value is not an integer.", get_type());
    }

    /// @brief Returns reference to the integer node value.
    /// @throw fkyaml::type_error The node value is not an integer.
    /// @return Constant reference to the integer node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_int/
    const integer_type& as_int() const {
        const basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_integer_impl()) {
            return act_node.m_value.integer;
        }
        throw fkyaml::type_error("The node value is not an integer.", get_type());
    }

    /// @brief Returns reference to the float node value.
    /// @throw fkyaml::type_error The node value is not a float.
    /// @return Reference to the float node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_float/
    float_number_type& as_float() {
        basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_float_number_impl()) {
            return act_node.m_value.float_val;
        }
        throw fkyaml::type_error("The node value is not a float.", get_type());
    }

    /// @brief Returns reference to the float node value.
    /// @throw fkyaml::type_error The node value is not a float.
    /// @return Constant reference to the float node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_float/
    const float_number_type& as_float() const {
        const basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_float_number_impl()) {
            return act_node.m_value.float_val;
        }
        throw fkyaml::type_error("The node value is not a float.", get_type());
    }

    /// @brief Returns reference to the string node value.
    /// @throw fkyaml::type_error The node value is not a string.
    /// @return Reference to the string node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_str/
    string_type& as_str() {
        basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_string_impl()) {
            return *act_node.m_value.p_str;
        }
        throw fkyaml::type_error("The node value is not a string.", get_type());
    }

    /// @brief Returns reference to the string node value.
    /// @throw fkyaml::type_error The node value is not a string.
    /// @return Constant reference to the string node value.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/as_str/
    const string_type& as_str() const {
        const basic_node& act_node = resolve_reference();
        if FK_YAML_LIKELY (act_node.is_string_impl()) {
            return *act_node.m_value.p_str;
        }
        throw fkyaml::type_error("The node value is not a string.", get_type());
    }

    /// @brief Swaps the internally stored data with the specified basic_node object.
    /// @param[in] rhs A basic_node object to be swapped with.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/swap/
    void swap(basic_node& rhs) noexcept {
        using std::swap;
        swap(m_attrs, rhs.m_attrs);
        swap(mp_meta, rhs.mp_meta);

        node_value tmp {};
        std::memcpy(&tmp, &m_value, sizeof(node_value));
        std::memcpy(&m_value, &rhs.m_value, sizeof(node_value));
        std::memcpy(&rhs.m_value, &tmp, sizeof(node_value));

        swap(m_prop.tag, rhs.m_prop.tag);
        swap(m_prop.anchor, rhs.m_prop.anchor);
    }

    /// @brief Returns an iterator to the first element of a container node (sequence or mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return An iterator to the first element of a container node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/begin/
    iterator begin() {
        basic_node& act_node = resolve_reference();
        switch (act_node.m_attrs & detail::node_attr_mask::value) {
        case detail::node_attr_bits::seq_bit:
            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            return {act_node.m_value.p_seq->begin()};
        case detail::node_attr_bits::map_bit:
            FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
            return {act_node.m_value.p_map->begin()};
        default:
            throw fkyaml::type_error("The target node is neither of sequence nor mapping types.", get_type());
        }
    }

    /// @brief Returns a const iterator to the first element of a container node (sequence or mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return A const iterator to the first element of a container node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/begin/
    const_iterator begin() const {
        const basic_node& act_node = resolve_reference();
        switch (act_node.m_attrs & detail::node_attr_mask::value) {
        case detail::node_attr_bits::seq_bit:
            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            return {act_node.m_value.p_seq->begin()};
        case detail::node_attr_bits::map_bit:
            FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
            return {act_node.m_value.p_map->begin()};
        default:
            throw fkyaml::type_error("The target node is neither of sequence nor mapping types.", get_type());
        }
    }

    /// @brief Returns a const iterator to the first element of a container node (sequence or mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return A const iterator to the first element of a container node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/begin/
    const_iterator cbegin() const {
        return begin();
    }

    /// @brief Returns an iterator to the past-the-last element of a container node (sequence or mapping).
    /// @throw `type_error` if the basic_node value is not of container types.
    /// @return An iterator to the past-the-last element of a container node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/end/
    iterator end() {
        basic_node& act_node = resolve_reference();
        switch (act_node.m_attrs & detail::node_attr_mask::value) {
        case detail::node_attr_bits::seq_bit:
            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            return {act_node.m_value.p_seq->end()};
        case detail::node_attr_bits::map_bit:
            FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
            return {act_node.m_value.p_map->end()};
        default:
            throw fkyaml::type_error("The target node is neither of sequence nor mapping types.", get_type());
        }
    }

    /// @brief Returns a const iterator to the past-the-last element of a container node (sequence or mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return A const iterator to the past-the-last element of a container node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/end/
    const_iterator end() const {
        const basic_node& act_node = resolve_reference();
        switch (act_node.m_attrs & detail::node_attr_mask::value) {
        case detail::node_attr_bits::seq_bit:
            FK_YAML_ASSERT(act_node.m_value.p_seq != nullptr);
            return {act_node.m_value.p_seq->end()};
        case detail::node_attr_bits::map_bit:
            FK_YAML_ASSERT(act_node.m_value.p_map != nullptr);
            return {act_node.m_value.p_map->end()};
        default:
            throw fkyaml::type_error("The target node is neither of sequence nor mapping types.", get_type());
        }
    }

    /// @brief Returns a const iterator to the past-the-last element of a container node (sequence or mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return A const iterator to the past-the-last element of a container node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/end/
    const_iterator cend() const {
        return end();
    }

    /// @brief Returns an iterator to the reverse-beginning (i.e., last) element of a container node (sequence or
    /// mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return An iterator to the reverse-beginning element of a container node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/rbegin/
    reverse_iterator rbegin() {
        return {end()};
    }

    /// @brief Returns a const iterator to the reverse-beginning (i.e., last) element of a container node (sequence or
    /// mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return A const iterator to the reverse-beginning element of a container node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/rbegin/
    const_reverse_iterator rbegin() const {
        return {end()};
    }

    /// @brief Returns a const iterator to the reverse-beginning (i.e., last) element of a container node (sequence or
    /// mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return A const iterator to the reverse-beginning element of a container node.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/rbegin/
    const_reverse_iterator crbegin() const {
        return rbegin();
    }

    /// @brief Returns an iterator to the reverse-end (i.e., one before the first) element of a container node (sequence
    /// or mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return An iterator to the reverse-end element.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/rend/
    reverse_iterator rend() {
        return {begin()};
    }

    /// @brief Returns a const iterator to the reverse-end (i.e., one before the first) element of a container node
    /// (sequence or mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return A const iterator to the reverse-end element.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/rend/
    const_reverse_iterator rend() const {
        return {begin()};
    }

    /// @brief Returns a const iterator to the reverse-end (i.e., one before the first) element of a container node
    /// (sequence or mapping).
    /// @throw `type_error` if this basic_node is neither a sequence nor mapping node.
    /// @return A const iterator to the reverse-end element.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/rend/
    const_reverse_iterator crend() const {
        return rend();
    }

    /// @brief Returns a range of mapping entries.
    /// @throw `type_error` if this basic_node is not a mapping.
    /// @return A range of mapping entries.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/map_items/
    map_range map_items() {
        if FK_YAML_UNLIKELY (!is_mapping()) {
            throw type_error("map_items() cannot be called on a non-mapping node.", get_type());
        }
        return {*this};
    }

    /// @brief Returns a const range of mapping entries.
    /// @throw `type_error` if this basic_node is not a mapping.
    /// @return A const range of mapping entries.
    /// @sa https://fktn-k.github.io/fkYAML/api/basic_node/map_items/
    const_map_range map_items() const {
        if FK_YAML_UNLIKELY (!is_mapping()) {
            throw type_error("map_items() cannot be called on a non-mapping node.", get_type());
        }
        return {*this};
    }

private:
    /// @brief Resolves anchor/alias reference and returns reference to an actual value node.
    /// @return Reference to an actual value node.
    basic_node& resolve_reference() {
        if FK_YAML_UNLIKELY (has_anchor_name()) {
            auto itr = mp_meta->anchor_table.equal_range(m_prop.anchor).first;
            std::advance(itr, detail::node_attr_bits::get_anchor_offset(m_attrs));
            return itr->second;
        }
        return *this;
    }

    /// @brief Resolves anchor/alias reference and returns const reference to an actual value node.
    /// @return Const reference to an actual value node.
    const basic_node& resolve_reference() const {
        if FK_YAML_UNLIKELY (has_anchor_name()) {
            auto itr = mp_meta->anchor_table.equal_range(m_prop.anchor).first;
            std::advance(itr, detail::node_attr_bits::get_anchor_offset(m_attrs));
            return itr->second;
        }
        return *this;
    }

    bool is_sequence_impl() const noexcept {
        return m_attrs & detail::node_attr_bits::seq_bit;
    }

    bool is_mapping_impl() const noexcept {
        return m_attrs & detail::node_attr_bits::map_bit;
    }

    bool is_null_impl() const noexcept {
        return m_attrs & detail::node_attr_bits::null_bit;
    }

    bool is_boolean_impl() const noexcept {
        return m_attrs & detail::node_attr_bits::bool_bit;
    }

    bool is_integer_impl() const noexcept {
        return m_attrs & detail::node_attr_bits::int_bit;
    }

    bool is_float_number_impl() const noexcept {
        return m_attrs & detail::node_attr_bits::float_bit;
    }

    bool is_string_impl() const noexcept {
        return m_attrs & detail::node_attr_bits::string_bit;
    }

    bool is_scalar_impl() const noexcept {
        return m_attrs & detail::node_attr_bits::scalar_bits;
    }

    template <
        typename ValueType, detail::enable_if_t<detail::negation<detail::is_basic_node<ValueType>>::value, int> = 0>
    void get_value_impl(ValueType& v) const
        noexcept(noexcept(ConverterType<ValueType, void>::from_node(std::declval<const basic_node&>(), v))) {
        ConverterType<ValueType, void>::from_node(*this, v);
    }

    template <typename ValueType, detail::enable_if_t<detail::is_basic_node<ValueType>::value, int> = 0>
    void get_value_impl(ValueType& v) const {
        v = *this;
    }

    /// @brief Returns reference to the sequence node value.
    /// @throw fkyaml::exception The node value is not a sequence.
    /// @return Reference to the sequence node value.
    sequence_type& get_value_ref_impl(sequence_type* /*unused*/) {
        return as_seq();
    }

    /// @brief Returns constant reference to the sequence node value.
    /// @throw fkyaml::exception The node value is not a sequence.
    /// @return Constant reference to the sequence node value.
    const sequence_type& get_value_ref_impl(const sequence_type* /*unused*/) const {
        return as_seq();
    }

    /// @brief Returns reference to the mapping node value.
    /// @throw fkyaml::exception The node value is not a mapping.
    /// @return Reference to the mapping node value.
    mapping_type& get_value_ref_impl(mapping_type* /*unused*/) {
        return as_map();
    }

    /// @brief Returns constant reference to the mapping node value.
    /// @throw fkyaml::exception The node value is not a mapping.
    /// @return Constant reference to the mapping node value.
    const mapping_type& get_value_ref_impl(const mapping_type* /*unused*/) const {
        return as_map();
    }

    /// @brief Returns reference to the boolean node value.
    /// @throw fkyaml::exception The node value is not a boolean.
    /// @return Reference to the boolean node value.
    boolean_type& get_value_ref_impl(boolean_type* /*unused*/) {
        return as_bool();
    }

    /// @brief Returns reference to the boolean node value.
    /// @throw fkyaml::exception The node value is not a boolean.
    /// @return Constant reference to the boolean node value.
    const boolean_type& get_value_ref_impl(const boolean_type* /*unused*/) const {
        return as_bool();
    }

    /// @brief Returns reference to the integer node value.
    /// @throw fkyaml::exception The node value is not an integer.
    /// @return Reference to the integer node value.
    integer_type& get_value_ref_impl(integer_type* /*unused*/) {
        return as_int();
    }

    /// @brief Returns reference to the integer node value.
    /// @throw fkyaml::exception The node value is not an integer.
    /// @return Constant reference to the integer node value.
    const integer_type& get_value_ref_impl(const integer_type* /*unused*/) const {
        return as_int();
    }

    /// @brief Returns reference to the floating point number node value.
    /// @throw fkyaml::exception The node value is not a floating point number.
    /// @return Reference to the floating point number node value.
    float_number_type& get_value_ref_impl(float_number_type* /*unused*/) {
        return as_float();
    }

    /// @brief Returns reference to the floating point number node value.
    /// @throw fkyaml::exception The node value is not a floating point number.
    /// @return Constant reference to the floating point number node value.
    const float_number_type& get_value_ref_impl(const float_number_type* /*unused*/) const {
        return as_float();
    }

    /// @brief Returns reference to the string node value.
    /// @throw fkyaml::exception The node value is not a string.
    /// @return Reference to the string node value.
    string_type& get_value_ref_impl(string_type* /*unused*/) {
        return as_str();
    }

    /// @brief Returns reference to the string node value.
    /// @throw fkyaml::exception The node value is not a string.
    /// @return Constant reference to the string node value.
    const string_type& get_value_ref_impl(const string_type* /*unused*/) const {
        return as_str();
    }

    /// The current node attributes.
    detail::node_attr_t m_attrs {detail::node_attr_bits::default_bits};
    /// The shared set of YAML directives applied to this node.
    mutable std::shared_ptr<detail::document_metainfo<basic_node>> mp_meta {
        // NOLINTNEXTLINE(bugprone-unhandled-exception-at-new)
        std::shared_ptr<detail::document_metainfo<basic_node>>(new detail::document_metainfo<basic_node>())};
    /// The current node value.
    node_value m_value {};
    /// The property set of this node.
    detail::node_property m_prop {};
};

/// @brief Swap function for basic_node objects.
/// @param[in] lhs A left-side-hand basic_node object to be swapped with.
/// @param[in] rhs A right-side-hand basic_node object to be swapped with.
/// @sa https://fktn-k.github.io/fkYAML/api/swap/
template <
    template <typename, typename...> class SequenceType, template <typename, typename, typename...> class MappingType,
    typename BooleanType, typename IntegerType, typename FloatNumberType, typename StringType,
    template <typename, typename = void> class ConverterType>
inline void swap(
    basic_node<SequenceType, MappingType, BooleanType, IntegerType, FloatNumberType, StringType, ConverterType>& lhs,
    basic_node<SequenceType, MappingType, BooleanType, IntegerType, FloatNumberType, StringType, ConverterType>&
        rhs) noexcept(noexcept(lhs.swap(rhs))) {
    lhs.swap(rhs);
}

/// @brief Insertion operator for basic_node template class. A wrapper for the serialization feature.
/// @param[in] os An output stream object.
/// @param[in] n A basic_node object.
/// @return Reference to the output stream object `os`.
/// @sa https://fktn-k.github.io/fkYAML/api/basic_node/insertion_operator/
template <
    template <typename, typename...> class SequenceType, template <typename, typename, typename...> class MappingType,
    typename BooleanType, typename IntegerType, typename FloatNumberType, typename StringType,
    template <typename, typename = void> class ConverterType>
inline std::ostream& operator<<(
    std::ostream& os,
    const basic_node<SequenceType, MappingType, BooleanType, IntegerType, FloatNumberType, StringType, ConverterType>&
        n) {
    os << basic_node<SequenceType, MappingType, BooleanType, IntegerType, FloatNumberType, StringType, ConverterType>::
            serialize(n);
    return os;
}

/// @brief Extraction operator for basic_node template class. A wrapper for the deserialization feature with input
/// streams.
/// @param[in] is An input stream object.
/// @param[in] n A basic_node object.
/// @return Reference to the input stream object `is`.
/// @sa https://fktn-k.github.io/fkYAML/api/basic_node/extraction_operator/
template <
    template <typename, typename...> class SequenceType, template <typename, typename, typename...> class MappingType,
    typename BooleanType, typename IntegerType, typename FloatNumberType, typename StringType,
    template <typename, typename = void> class ConverterType>
inline std::istream& operator>>(
    std::istream& is,
    basic_node<SequenceType, MappingType, BooleanType, IntegerType, FloatNumberType, StringType, ConverterType>& n) {
    n = basic_node<SequenceType, MappingType, BooleanType, IntegerType, FloatNumberType, StringType, ConverterType>::
        deserialize(is);
    return is;
}

/// @brief namespace for user-defined literals for the fkYAML library.
inline namespace literals {
/// @brief namespace for user-defined literals for YAML node objects.
inline namespace yaml_literals {

// Whitespace before the literal operator identifier is deprecated in C++23 or better but required in C++11.
// Ignore the warning as a workaround. https://github.com/fktn-k/fkYAML/pull/417
#if defined(__clang__)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
#endif

#if defined(__GNUC__) && (__GNUC__ > 6)
#define FK_YAML_QUOTE_OPERATOR operator""_yaml
#else
#define FK_YAML_QUOTE_OPERATOR operator"" _yaml
#endif

/// @brief The user-defined string literal which deserializes a `char` array into a `node` object.
/// @param s An input `char` array.
/// @param n The size of `s`.
/// @return The resulting `node` object deserialized from `s`.
/// @sa https://fktn-k.github.io/fkYAML/api/operator_literal_yaml/
inline fkyaml::node FK_YAML_QUOTE_OPERATOR(const char* s, std::size_t n) {
    return fkyaml::node::deserialize(s, s + n);
}

/// @brief The user-defined string literal which deserializes a `char16_t` array into a `node` object.
/// @param s An input `char16_t` array.
/// @param n The size of `s`.
/// @return The resulting `node` object deserialized from `s`.
/// @sa https://fktn-k.github.io/fkYAML/api/operator_literal_yaml/
inline fkyaml::node FK_YAML_QUOTE_OPERATOR(const char16_t* s, std::size_t n) {
    return fkyaml::node::deserialize(s, s + n);
}

/// @brief The user-defined string literal which deserializes a `char32_t` array into a `node` object.
/// @param s An input `char32_t` array.
/// @param n The size of `s`.
/// @return The resulting `node` object deserialized from `s`.
/// @sa https://fktn-k.github.io/fkYAML/api/operator_literal_yaml/
inline fkyaml::node FK_YAML_QUOTE_OPERATOR(const char32_t* s, std::size_t n) {
    return fkyaml::node::deserialize(s, s + n);
}

#if FK_YAML_HAS_CHAR8_T
/// @brief The user-defined string literal which deserializes a `char8_t` array into a `node` object.
/// @param s An input `char8_t` array.
/// @param n The size of `s`.
/// @return The resulting `node` object deserialized from `s`.
inline fkyaml::node FK_YAML_QUOTE_OPERATOR(const char8_t* s, std::size_t n) {
    return fkyaml::node::deserialize((const char8_t*)s, (const char8_t*)s + n);
}

#if defined(__clang__)
#pragma clang diagnostic pop
#endif

#endif

} // namespace yaml_literals
} // namespace literals

FK_YAML_NAMESPACE_END

namespace std {

template <
    template <typename, typename...> class SequenceType, template <typename, typename, typename...> class MappingType,
    typename BooleanType, typename IntegerType, typename FloatNumberType, typename StringType,
    template <typename, typename = void> class ConverterType>
// NOLINTNEXTLINE(cert-dcl58-cpp)
struct hash<fkyaml::basic_node<
    SequenceType, MappingType, BooleanType, IntegerType, FloatNumberType, StringType, ConverterType>> {
    using node_t = fkyaml::basic_node<
        SequenceType, MappingType, BooleanType, IntegerType, FloatNumberType, StringType, ConverterType>;

    std::size_t operator()(const node_t& n) const {
        using boolean_type = typename node_t::boolean_type;
        using integer_type = typename node_t::integer_type;
        using float_number_type = typename node_t::float_number_type;
        using string_type = typename node_t::string_type;

        const auto type = n.get_type();

        std::size_t seed = 0;
        hash_combine(seed, std::hash<uint8_t>()(static_cast<uint8_t>(type)));

        switch (type) {
        case fkyaml::node_type::SEQUENCE:
            hash_combine(seed, n.size());
            for (const auto& elem : n) {
                hash_combine(seed, operator()(elem));
            }
            return seed;

        case fkyaml::node_type::MAPPING:
            hash_combine(seed, n.size());
            for (auto itr = n.begin(), end_itr = n.end(); itr != end_itr; ++itr) {
                hash_combine(seed, operator()(itr.key()));
                hash_combine(seed, operator()(itr.value()));
            }
            return seed;

        case fkyaml::node_type::NULL_OBJECT:
            hash_combine(seed, 0);
            return seed;
        case fkyaml::node_type::BOOLEAN:
            hash_combine(seed, std::hash<boolean_type>()(n.template get_value<boolean_type>()));
            return seed;
        case fkyaml::node_type::INTEGER:
            hash_combine(seed, std::hash<integer_type>()(n.template get_value<integer_type>()));
            return seed;
        case fkyaml::node_type::FLOAT:
            hash_combine(seed, std::hash<float_number_type>()(n.template get_value<float_number_type>()));
            return seed;
        case fkyaml::node_type::STRING:
            hash_combine(seed, std::hash<string_type>()(n.template get_value<string_type>()));
            return seed;
        default:                           // LCOV_EXCL_LINE
            fkyaml::detail::unreachable(); // LCOV_EXCL_LINE
        }
    }

private:
    // taken from boost::hash_combine
    FK_YAML_NO_SANITIZE("unsigned-shift-base", "unsigned-integer-overflow")
    static void hash_combine(std::size_t& seed, std::size_t v) {
        seed ^= v + 0x9e3779b9 + (seed << 6u) + (seed >> 2u);
    }
};

} // namespace std

#endif /* FK_YAML_NODE_HPP */
