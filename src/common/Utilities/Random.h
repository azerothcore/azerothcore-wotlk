
#ifndef Random_h__
#define Random_h__

#include "Define.h"
#include <limits>
#include <random>

/* Return a random number in the range min..max. */
int32 irand(int32 min, int32 max);

/* Return a random number in the range min..max (inclusive). */
uint32 urand(uint32 min, uint32 max);

/* Return a random millisecond value between min and max seconds. Functionally equivalent to urand(min*IN_MILLISECONDS, max*IN_MILLISECONDS). */
uint32 urandms(uint32 min, uint32 max);

/* Return a random number in the range 0 .. UINT32_MAX. */
uint32 rand32();

/* Return a random number in the range min..max */
float frand(float min, float max);

/* Return a random double from 0.0 to 1.0 (exclusive). */
double rand_norm();

/* Return a random double from 0.0 to 100.0 (exclusive). */
double rand_chance();

/* Return true if a random roll fits in the specified chance (range 0-100). */
inline bool roll_chance_f(float chance)
{
    return chance > rand_chance();
}

/* Return true if a random roll fits in the specified chance (range 0-100). */
inline bool roll_chance_i(int chance)
{
    return chance > irand(0, 99);
}

/*
* SFMT wrapper satisfying UniformRandomNumberGenerator concept for use in <random> algorithms
*/
class SFMTEngine
{
public:
    typedef uint32 result_type;

    static ACORE_CONSTEXPR result_type min() { return std::numeric_limits<result_type>::min(); }
    static ACORE_CONSTEXPR result_type max() { return std::numeric_limits<result_type>::max(); }
    result_type operator()() const { return rand32(); }

    static SFMTEngine& Instance();
};

// Ugly, horrible, i don't even..., hack for VS2013 to work around missing discrete_distribution(iterator, iterator) constructor
namespace ACORE
{
#if COMPILER == COMPILER_MICROSOFT && _MSC_VER <= 1800
    template<typename T>
    struct discrete_distribution_param : public std::discrete_distribution<T>::param_type
    {
        typedef typename std::discrete_distribution<T>::param_type base;

        template<typename InIt>
        discrete_distribution_param(InIt begin, InIt end) : base(_Noinit())
        {
            this->_Pvec.assign(begin, end);
            this->_Init();
        }
    };
#else
    template<typename T>
    using discrete_distribution_param = typename std::discrete_distribution<T>::param_type;
#endif
}

#endif // Random_h__
