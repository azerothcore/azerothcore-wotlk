// -*- C++ -*-
#if defined (ACE_HAS_INTRINSIC_BYTESWAP)
// Take advantage of MSVC++ byte swapping compiler intrinsics (found
// in <stdlib.h>).
# pragma intrinsic (_byteswap_ushort, _byteswap_ulong, _byteswap_uint64)
#endif  /* ACE_HAS_INTRINSIC_BYTESWAP */

#if defined (ACE_HAS_BSWAP_16) || defined (ACE_HAS_BSWAP_32) || defined (ACE_HAS_BSWAP_64)
# include "ace/os_include/os_byteswap.h"
#endif

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

//
// The ACE_CDR::swap_X and ACE_CDR::swap_X_array routines are broken
// in 5 cases for optimization:
//
// * MSVC++ 7.1 or better
//   => Compiler intrinsics
//
// * AMD64 CPU + gnu g++
//   => gcc amd64 inline assembly.
//
// * x86 Pentium CPU + gnu g++
//   (ACE_HAS_PENTIUM && __GNUG__)
//   => gcc x86 inline assembly.
//
// * x86 Pentium CPU and (_MSC_VER) or BORLAND C++)
//   (ACE_HAS_PENTIUM && ( _MSC_VER || __BORLANDC__ )
//   => MSC x86 inline assembly.
//
// * 64 bit architecture
//   (ACE_SIZEOF_LONG == 8)
//   => shift/masks using 64bit words.
//
// * default
//   (none of the above)
//   => shift/masks using 32bit words.
//
// Some things you could find useful to know if you intend to mess
// with this optimizations for swaps:
//
//      * MSVC++ don't assume register values are conserved between
//        statements. So you can clobber any register you want,
//        whenever you want (well not *anyone* really, see manual).
//        The MSVC++ optimizer will try to pick different registers
//        for the C++ statements sorrounding your asm block, and if
//        it's not possible will use the stack.
//
//      * If you clobber registers with asm statements in gcc, you
//        better do it in an asm-only function, or save/restore them
//        before/after in the stack. If not, sorrounding C statements
//        could end using the same registers and big-badda-bum (been
//        there, done that...). The big-badda-bum could happen *even
//        if you specify the clobbered register in your asm's*.
//        Even better, use gcc asm syntax for detecting the register
//        asigned to a certain variable so you don't have to clobber any
//        register directly.
//

ACE_INLINE void
ACE_CDR::swap_2 (const char *orig, char* target)
{
#if defined (ACE_HAS_INTRINSIC_BYTESWAP)
  // Take advantage of MSVC++ compiler intrinsic byte swapping
  // function.
  *reinterpret_cast<unsigned short *> (target) =
    _byteswap_ushort (*reinterpret_cast<unsigned short const *> (orig));
#elif defined (ACE_HAS_BSWAP16)
  *reinterpret_cast<uint16_t *> (target) =
    bswap16 (*reinterpret_cast<uint16_t const *> (orig));
#elif defined (ACE_HAS_BSWAP_16)
  *reinterpret_cast<uint16_t *> (target) =
    bswap_16 (*reinterpret_cast<uint16_t const *> (orig));
#elif defined(ACE_HAS_INTEL_ASSEMBLY)
  unsigned short a =
    *reinterpret_cast<const unsigned short*> (orig);
  asm( "rolw $8, %0" : "=r" (a) : "0" (a) );
  *reinterpret_cast<unsigned short*> (target) = a;
#elif defined (ACE_HAS_PENTIUM) \
       && (defined(_MSC_VER) || defined(__BORLANDC__)) \
       && !defined(ACE_LACKS_INLINE_ASSEMBLY)
  __asm mov ebx, orig;
  __asm mov ecx, target;
  __asm mov ax, [ebx];
  __asm rol ax, 8;
  __asm mov [ecx], ax;
#else
  ACE_REGISTER ACE_UINT16 usrc = * reinterpret_cast<const ACE_UINT16*> (orig);
  ACE_REGISTER ACE_UINT16* udst = reinterpret_cast<ACE_UINT16*> (target);
  *udst = (usrc << 8) | (usrc >> 8);
#endif /* ACE_HAS_PENTIUM */
}

ACE_INLINE void
ACE_CDR::swap_4 (const char* orig, char* target)
{
#if defined (ACE_HAS_INTRINSIC_BYTESWAP)
  // Take advantage of MSVC++ compiler intrinsic byte swapping
  // function.
  *reinterpret_cast<unsigned long *> (target) =
    _byteswap_ulong (*reinterpret_cast<unsigned long const *> (orig));
#elif defined (ACE_HAS_BSWAP32)
  *reinterpret_cast<uint32_t *> (target) =
    bswap32 (*reinterpret_cast<uint32_t const *> (orig));
#elif defined (ACE_HAS_BSWAP_32)
  *reinterpret_cast<uint32_t *> (target) =
    bswap_32 (*reinterpret_cast<uint32_t const *> (orig));
#elif defined(ACE_HAS_INTEL_ASSEMBLY)
  // We have ACE_HAS_PENTIUM, so we know the sizeof's.
  ACE_REGISTER unsigned int j =
    *reinterpret_cast<const unsigned int*> (orig);
  asm ("bswap %1" : "=r" (j) : "0" (j));
  *reinterpret_cast<unsigned int*> (target) = j;
#elif defined(ACE_HAS_PENTIUM) \
      && (defined(_MSC_VER) || defined(__BORLANDC__)) \
      && !defined(ACE_LACKS_INLINE_ASSEMBLY)
  __asm mov ebx, orig;
  __asm mov ecx, target;
  __asm mov eax, [ebx];
  __asm bswap eax;
  __asm mov [ecx], eax;
#else
  ACE_REGISTER ACE_UINT32 x = * reinterpret_cast<const ACE_UINT32*> (orig);
  x = (x << 24) | ((x & 0xff00) << 8) | ((x & 0xff0000) >> 8) | (x >> 24);
  * reinterpret_cast<ACE_UINT32*> (target) = x;
#endif /* ACE_HAS_INTRINSIC_BYTESWAP */
}

ACE_INLINE void
ACE_CDR::swap_8 (const char* orig, char* target)
{
#if defined (ACE_HAS_INTRINSIC_BYTESWAP)
  // Take advantage of MSVC++ compiler intrinsic byte swapping
  // function.
  *reinterpret_cast<unsigned __int64 *> (target) =
    _byteswap_uint64 (*reinterpret_cast<unsigned __int64 const *> (orig));
#elif defined (ACE_HAS_BSWAP64)
  *reinterpret_cast<uint64_t *> (target) =
    bswap64 (*reinterpret_cast<uint64_t const *> (orig));
#elif defined (ACE_HAS_BSWAP_64)
  *reinterpret_cast<uint64_t *> (target) =
    bswap_64 (*reinterpret_cast<uint64_t const *> (orig));
#elif (defined (__amd64__) || defined (__x86_64__)) && defined(__GNUG__) \
    && !defined(ACE_LACKS_INLINE_ASSEMBLY)
  ACE_REGISTER unsigned long x =
    * reinterpret_cast<const unsigned long*> (orig);
  asm ("bswapq %1" : "=r" (x) : "0" (x));
  *reinterpret_cast<unsigned long*> (target) = x;
#elif defined(ACE_HAS_PENTIUM) && defined(__GNUG__) \
    && !defined(ACE_LACKS_INLINE_ASSEMBLY)
  ACE_REGISTER unsigned int i =
    *reinterpret_cast<const unsigned int*> (orig);
  ACE_REGISTER unsigned int j =
    *reinterpret_cast<const unsigned int*> (orig + 4);
  asm ("bswap %1" : "=r" (i) : "0" (i));
  asm ("bswap %1" : "=r" (j) : "0" (j));
  *reinterpret_cast<unsigned int*> (target + 4) = i;
  *reinterpret_cast<unsigned int*> (target) = j;
#elif defined(ACE_HAS_PENTIUM) \
      && (defined(_MSC_VER) || defined(__BORLANDC__)) \
      && !defined(ACE_LACKS_INLINE_ASSEMBLY)
  __asm mov ecx, orig;
  __asm mov edx, target;
  __asm mov eax, [ecx];
  __asm mov ebx, 4[ecx];
  __asm bswap eax;
  __asm bswap ebx;
  __asm mov 4[edx], eax;
  __asm mov [edx], ebx;
#elif ACE_SIZEOF_LONG == 8
  // 64 bit architecture.
  ACE_REGISTER unsigned long x =
    * reinterpret_cast<const unsigned long*> (orig);
  ACE_REGISTER unsigned long x84 = (x & 0x000000ff000000ffUL) << 24;
  ACE_REGISTER unsigned long x73 = (x & 0x0000ff000000ff00UL) << 8;
  ACE_REGISTER unsigned long x62 = (x & 0x00ff000000ff0000UL) >> 8;
  ACE_REGISTER unsigned long x51 = (x & 0xff000000ff000000UL) >> 24;
  x = (x84 | x73 | x62 | x51);
  x = (x << 32) | (x >> 32);
  *reinterpret_cast<unsigned long*> (target) = x;
#else
  ACE_REGISTER ACE_UINT32 x =
    * reinterpret_cast<const ACE_UINT32*> (orig);
  ACE_REGISTER ACE_UINT32 y =
    * reinterpret_cast<const ACE_UINT32*> (orig + 4);
  x = (x << 24) | ((x & 0xff00) << 8) | ((x & 0xff0000) >> 8) | (x >> 24);
  y = (y << 24) | ((y & 0xff00) << 8) | ((y & 0xff0000) >> 8) | (y >> 24);
  * reinterpret_cast<ACE_UINT32*> (target) = y;
  * reinterpret_cast<ACE_UINT32*> (target + 4) = x;
#endif /* ACE_HAS_INTRINSIC_BYTESWAP */
}

ACE_INLINE void
ACE_CDR::swap_16 (const char* orig, char* target)
{
  swap_8 (orig + 8, target);
  swap_8 (orig, target + 8);
}

ACE_INLINE size_t
ACE_CDR::first_size (size_t minsize)
{
  if (minsize == 0)
    return ACE_CDR::DEFAULT_BUFSIZE;

  size_t newsize = ACE_CDR::DEFAULT_BUFSIZE;
  while (newsize < minsize)
    {
      if (newsize < ACE_CDR::EXP_GROWTH_MAX)
        {
          // We grow exponentially at the beginning, this is fast and
          // reduces the number of allocations.

          // Quickly multiply by two using a bit shift.  This is
          // guaranteed to work since the variable is an unsigned
          // integer.
          newsize <<= 1;
        }
      else
        {
          // but continuing with exponential growth can result in over
          // allocations and easily yield an allocation failure.
          // So we grow linearly when the buffer is too big.
          newsize += ACE_CDR::LINEAR_GROWTH_CHUNK;
        }
    }
  return newsize;
}

ACE_INLINE size_t
ACE_CDR::next_size (size_t minsize)
{
  size_t newsize = ACE_CDR::first_size (minsize);

  if (newsize == minsize)
    {
      // If necessary increment the size
      if (newsize < ACE_CDR::EXP_GROWTH_MAX)
        // Quickly multiply by two using a bit shift.  This is
        // guaranteed to work since the variable is an unsigned
        // integer.
        newsize <<= 1;
      else
        newsize += ACE_CDR::LINEAR_GROWTH_CHUNK;
    }

  return newsize;
}

ACE_INLINE ACE_CDR::UShort
ACE_CDR::Fixed::fixed_digits () const
{
  return this->digits_;
}

ACE_INLINE ACE_CDR::UShort
ACE_CDR::Fixed::fixed_scale () const
{
  return this->scale_;
}

ACE_INLINE bool
ACE_CDR::Fixed::sign () const
{
  return (this->value_[15] & 0xf) == NEGATIVE;
}

ACE_INLINE ACE_CDR::Octet
ACE_CDR::Fixed::digit (int n) const
{
  const Octet x = this->value_[15 - (n + 1) / 2];
  return (n % 2) ? x & 0xf : (x >> 4);
}

ACE_INLINE void
ACE_CDR::Fixed::digit (int n, int val)
{
  const int idx = 15 - (n + 1) / 2;
  this->value_[idx] = (n % 2) ? (this->value_[idx] & 0xf0) | val
                              : ((val << 4) | (this->value_[idx] & 0xf));
}

ACE_INLINE
ACE_CDR::Fixed::Proxy::Proxy (bool high_nibble, Octet &element)
  : high_nibble_ (high_nibble), element_ (element) {}

ACE_INLINE ACE_CDR::Fixed::Proxy &
ACE_CDR::Fixed::Proxy::operator= (Octet val)
{
  this->element_ = this->high_nibble_
    ? (val << 4) | (this->element_ & 0xf)
    : ((this->element_ & 0xf0) | val);
  return *this;
}

ACE_INLINE ACE_CDR::Fixed::Proxy &
ACE_CDR::Fixed::Proxy::operator+= (int rhs)
{
  const Octet val = static_cast<Octet> (*this + rhs);
  return *this = val;
}

ACE_INLINE ACE_CDR::Fixed::Proxy &
ACE_CDR::Fixed::Proxy::operator-= (int rhs)
{
  const Octet val = static_cast<Octet> (*this - rhs);
  return *this = val;
}

ACE_INLINE ACE_CDR::Fixed::Proxy &
ACE_CDR::Fixed::Proxy::operator++ ()
{
  const Octet val = static_cast<Octet> (*this) + 1;
  return *this = val;
}

ACE_INLINE ACE_CDR::Fixed::Proxy &
ACE_CDR::Fixed::Proxy::operator-- ()
{
  const Octet val = static_cast<Octet>(*this) - 1;
  return *this = val;
}

ACE_INLINE
ACE_CDR::Fixed::Proxy::operator ACE_CDR::Octet () const
{
  return this->high_nibble_ ? this->element_ >> 4 : (this->element_ & 0xf);
}

ACE_INLINE
ACE_CDR::Fixed::IteratorBase::IteratorBase (int digit)
  : digit_ (digit) {}

ACE_INLINE bool
ACE_CDR::Fixed::IteratorBase::high_nibble () const
{
  return this->digit_ % 2 == 0;
}

ACE_INLINE ACE_CDR::Octet &
ACE_CDR::Fixed::IteratorBase::storage (Fixed *outer) const
{
  return outer->value_[15 - (this->digit_ + 1) / 2];
}

ACE_INLINE ACE_CDR::Octet
ACE_CDR::Fixed::IteratorBase::storage (const Fixed *outer) const
{
  return outer->value_[15 - (this->digit_ + 1) / 2];
}

ACE_INLINE bool
ACE_CDR::Fixed::IteratorBase::compare (const IteratorBase &rhs) const
{
  return this->digit_ == rhs.digit_;
}

ACE_INLINE
ACE_CDR::Fixed::Iterator::Iterator (Fixed *outer, int digit)
  : IteratorBase (digit), outer_ (outer) {}

ACE_INLINE ACE_CDR::Fixed::Proxy
ACE_CDR::Fixed::Iterator::operator* ()
{
  return Proxy (this->high_nibble (), this->storage (this->outer_));
}

ACE_INLINE ACE_CDR::Fixed::Iterator &
ACE_CDR::Fixed::Iterator::operator+= (std::ptrdiff_t n)
{
  this->digit_ += static_cast<int> (n);
  return *this;
}

ACE_INLINE ACE_CDR::Fixed::Iterator &
ACE_CDR::Fixed::Iterator::operator++ ()
{
  ++this->digit_;
  return *this;
}

ACE_INLINE ACE_CDR::Fixed::Iterator
ACE_CDR::Fixed::Iterator::operator++ (int)
{
  const Iterator cpy (*this);
  ++this->digit_;
  return cpy;
}

ACE_INLINE ACE_CDR::Fixed::Iterator &
ACE_CDR::Fixed::Iterator::operator-- ()
{
  --this->digit_;
  return *this;
}

ACE_INLINE ACE_CDR::Fixed::Iterator
ACE_CDR::Fixed::Iterator::operator-- (int)
{
  const Iterator cpy (*this);
  --this->digit_;
  return cpy;
}

ACE_INLINE bool
ACE_CDR::Fixed::Iterator::operator== (const Iterator &rhs) const
{
  return this->compare (rhs);
}

ACE_INLINE bool
ACE_CDR::Fixed::Iterator::operator!= (const Iterator &rhs) const
{
  return !(*this == rhs);
}

ACE_INLINE
ACE_CDR::Fixed::ConstIterator::ConstIterator (const Fixed *outer, int digit)
  : IteratorBase (digit), outer_ (outer) {}

ACE_INLINE ACE_CDR::Octet
ACE_CDR::Fixed::ConstIterator::operator* ()
{
  const Octet storage = this->storage (this->outer_);
  return this->high_nibble () ? storage >> 4 : (storage & 0xf);
}

ACE_INLINE ACE_CDR::Fixed::ConstIterator &
ACE_CDR::Fixed::ConstIterator::operator+= (std::ptrdiff_t n)
{
  this->digit_ += static_cast<int> (n);
  return *this;
}

ACE_INLINE ACE_CDR::Fixed::ConstIterator &
ACE_CDR::Fixed::ConstIterator::operator++ ()
{
  ++this->digit_;
  return *this;
}

ACE_INLINE ACE_CDR::Fixed::ConstIterator
ACE_CDR::Fixed::ConstIterator::operator++ (int)
{
  const ConstIterator cpy (*this);
  ++this->digit_;
  return cpy;
}

ACE_INLINE ACE_CDR::Fixed::ConstIterator &
ACE_CDR::Fixed::ConstIterator::operator-- ()
{
  --this->digit_;
  return *this;
}

ACE_INLINE ACE_CDR::Fixed::ConstIterator
ACE_CDR::Fixed::ConstIterator::operator-- (int)
{
  const ConstIterator cpy (*this);
  --this->digit_;
  return cpy;
}

ACE_INLINE bool
ACE_CDR::Fixed::ConstIterator::operator== (const ConstIterator &rhs) const
{
  return this->compare (rhs);
}

ACE_INLINE bool
ACE_CDR::Fixed::ConstIterator::operator!= (const ConstIterator &rhs) const
{
  return !(*this == rhs);
}

ACE_INLINE ACE_CDR::Fixed::Iterator
ACE_CDR::Fixed::begin ()
{
  return Iterator (this);
}

ACE_INLINE ACE_CDR::Fixed::ConstIterator
ACE_CDR::Fixed::begin () const
{
  return ConstIterator (this);
}

ACE_INLINE ACE_CDR::Fixed::ConstIterator
ACE_CDR::Fixed::cbegin () const
{
  return ConstIterator (this);
}

ACE_INLINE ACE_CDR::Fixed::Iterator
ACE_CDR::Fixed::end ()
{
  return Iterator (this, this->digits_);
}

ACE_INLINE ACE_CDR::Fixed::ConstIterator
ACE_CDR::Fixed::end () const
{
  return ConstIterator (this, this->digits_);
}

ACE_INLINE ACE_CDR::Fixed::ConstIterator
ACE_CDR::Fixed::cend () const
{
  return ConstIterator (this, this->digits_);
}

ACE_INLINE ACE_CDR::Fixed
ACE_CDR::Fixed::operator++ (int)
{
  const Fixed cpy (*this);
  ++*this;
  return cpy;
}

ACE_INLINE ACE_CDR::Fixed
ACE_CDR::Fixed::operator-- (int)
{
  const Fixed cpy (*this);
  --*this;
  return cpy;
}

ACE_INLINE ACE_CDR::Fixed
ACE_CDR::Fixed::operator+ () const
{
  return *this;
}

ACE_INLINE ACE_CDR::Fixed
ACE_CDR::Fixed::operator- () const
{
  Fixed f = *this;
  f.value_[15] = (f.value_[15] & 0xf0) | (f.sign () ? POSITIVE : NEGATIVE);
  return f;
}

ACE_INLINE void
ACE_CDR::Fixed::ltrim ()
{
  for (int i = this->digits_ - 1; i >= this->scale_ && i > 0; --i)
    if (this->digit (i) == 0)
      --this->digits_;
    else
      break;
}

ACE_INLINE ACE_CDR::Fixed
operator+ (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  ACE_CDR::Fixed f = lhs;
  f += rhs;
  return f;
}

ACE_INLINE ACE_CDR::Fixed
operator- (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  ACE_CDR::Fixed f = lhs;
  f -= rhs;
  return f;
}

ACE_INLINE ACE_CDR::Fixed
operator* (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  ACE_CDR::Fixed f = lhs;
  f *= rhs;
  return f;
}

ACE_INLINE ACE_CDR::Fixed
operator/ (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  ACE_CDR::Fixed f = lhs;
  f /= rhs;
  return f;
}

ACE_INLINE bool
operator< (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  return lhs.less (rhs);
}

ACE_INLINE bool
operator> (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  return rhs < lhs;
}

ACE_INLINE bool
operator>= (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  return !(lhs < rhs);
}

ACE_INLINE bool
operator<= (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  return !(rhs < lhs);
}

ACE_INLINE bool
operator== (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  return lhs.equal (rhs);
}

ACE_INLINE bool
operator!= (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs)
{
  return !(lhs == rhs);
}


ACE_END_VERSIONED_NAMESPACE_DECL

// ****************************************************************
