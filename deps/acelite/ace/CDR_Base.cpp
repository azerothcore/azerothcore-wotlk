#include "ace/CDR_Base.h"

#if !defined (__ACE_INLINE__)
# include "ace/CDR_Base.inl"
#endif /* ! __ACE_INLINE__ */

#include "ace/Message_Block.h"
#include "ace/OS_Memory.h"
#include "ace/OS_NS_string.h"

#ifdef ACE_LACKS_IOSTREAM_TOTALLY
#include "ace/OS_NS_stdio.h"
#else
#include "ace/streams.h"
#endif

#include <cmath>
#include <cstring>
#include <limits>
#include <algorithm>

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

#if defined (NONNATIVE_LONGDOUBLE)
static const ACE_INT16 max_eleven_bit = 0x3ff;
static const ACE_INT16 max_fifteen_bit = 0x3fff;
#endif /* NONNATIVE_LONGDOUBLE */

//
// See comments in CDR_Base.inl about optimization cases for swap_XX_array.
//

void
ACE_CDR::swap_2_array (char const * orig, char* target, size_t n)
{
  // ACE_ASSERT(n > 0); The caller checks that n > 0

  // We pretend that AMD64/GNU G++ systems have a Pentium CPU to
  // take advantage of the inline assembly implementation.

  // Later, we try to read in 32 or 64 bit chunks,
  // so make sure we don't do that for unaligned addresses.
#if ACE_SIZEOF_LONG == 8 && \
    !((defined(__amd64__) || defined (__x86_64__)) && defined(__GNUG__))
  char const * const o8 = ACE_ptr_align_binary (orig, 8);
  while (orig < o8 && n > 0)
    {
      ACE_CDR::swap_2 (orig, target);
      orig += 2;
      target += 2;
      --n;
    }
#else
  char const * const o4 = ACE_ptr_align_binary (orig, 4);
  // this is an _if_, not a _while_. The mistmatch can only be by 2.
  if (orig != o4)
    {
      ACE_CDR::swap_2 (orig, target);
      orig += 2;
      target += 2;
      --n;
    }
#endif
  if (n == 0)
    return;

  //
  // Loop unrolling. Here be dragons.
  //

  // (n & (~3)) is the greatest multiple of 4 not bigger than n.
  // In the while loop ahead, orig will move over the array by 8 byte
  // increments (4 elements of 2 bytes).
  // end marks our barrier for not falling outside.
  char const * const end = orig + 2 * (n & (~3));

  // See if we're aligned for writting in 64 or 32 bit chunks...
#if ACE_SIZEOF_LONG == 8 && \
    !((defined(__amd64__) || defined (__x86_64__)) && defined(__GNUG__))
  if (target == ACE_ptr_align_binary (target, 8))
#else
  if (target == ACE_ptr_align_binary (target, 4))
#endif
    {
      while (orig < end)
        {
#if defined (ACE_HAS_INTEL_ASSEMBLY)
          unsigned int a =
            * reinterpret_cast<const unsigned int*> (orig);
          unsigned int b =
            * reinterpret_cast<const unsigned int*> (orig + 4);
          asm ( "bswap %1"      : "=r" (a) : "0" (a) );
          asm ( "bswap %1"      : "=r" (b) : "0" (b) );
          asm ( "rol $16, %1"   : "=r" (a) : "0" (a) );
          asm ( "rol $16, %1"   : "=r" (b) : "0" (b) );
          * reinterpret_cast<unsigned int*> (target) = a;
          * reinterpret_cast<unsigned int*> (target + 4) = b;
#elif defined(ACE_HAS_PENTIUM) \
      && (defined(_MSC_VER) || defined(__BORLANDC__)) \
      && !defined(ACE_LACKS_INLINE_ASSEMBLY)
          __asm mov ecx, orig;
          __asm mov edx, target;
          __asm mov eax, [ecx];
          __asm mov ebx, 4[ecx];
          __asm bswap eax;
          __asm bswap ebx;
          __asm rol eax, 16;
          __asm rol ebx, 16;
          __asm mov [edx], eax;
          __asm mov 4[edx], ebx;
#elif ACE_SIZEOF_LONG == 8
          // 64 bit architecture.
          ACE_REGISTER unsigned long a =
            * reinterpret_cast<const unsigned long*> (orig);

          ACE_REGISTER unsigned long a1 = (a & 0x00ff00ff00ff00ffUL) << 8;
          ACE_REGISTER unsigned long a2 = (a & 0xff00ff00ff00ff00UL) >> 8;

          a = (a1 | a2);

          * reinterpret_cast<unsigned long*> (target) = a;
#else
          ACE_REGISTER ACE_UINT32 a =
            * reinterpret_cast<const ACE_UINT32*> (orig);
          ACE_REGISTER ACE_UINT32 b =
            * reinterpret_cast<const ACE_UINT32*> (orig + 4);

          ACE_REGISTER ACE_UINT32 a1 = (a & 0x00ff00ffU) << 8;
          ACE_REGISTER ACE_UINT32 b1 = (b & 0x00ff00ffU) << 8;
          ACE_REGISTER ACE_UINT32 a2 = (a & 0xff00ff00U) >> 8;
          ACE_REGISTER ACE_UINT32 b2 = (b & 0xff00ff00U) >> 8;

          a = (a1 | a2);
          b = (b1 | b2);

          * reinterpret_cast<ACE_UINT32*> (target) = a;
          * reinterpret_cast<ACE_UINT32*> (target + 4) = b;
#endif
          orig += 8;
          target += 8;
        }
    }
  else
    {
      // We're out of luck. We have to write in 2 byte chunks.
      while (orig < end)
        {
#if defined (ACE_HAS_INTEL_ASSEMBLY)
          unsigned int a =
            * reinterpret_cast<const unsigned int*> (orig);
          unsigned int b =
            * reinterpret_cast<const unsigned int*> (orig + 4);
          asm ( "bswap %1" : "=r" (a) : "0" (a) );
          asm ( "bswap %1" : "=r" (b) : "0" (b) );
          // We're little endian.
          * reinterpret_cast<unsigned short*> (target + 2)
              = (unsigned short) (a & 0xffff);
          * reinterpret_cast<unsigned short*> (target + 6)
              = (unsigned short) (b & 0xffff);
          asm ( "shrl $16, %1" : "=r" (a) : "0" (a) );
          asm ( "shrl $16, %1" : "=r" (b) : "0" (b) );
          * reinterpret_cast<unsigned short*> (target + 0)
              = (unsigned short) (a & 0xffff);
          * reinterpret_cast<unsigned short*> (target + 4)
              = (unsigned short) (b & 0xffff);
#elif defined (ACE_HAS_PENTIUM) \
      && (defined (_MSC_VER) || defined (__BORLANDC__)) \
      && !defined (ACE_LACKS_INLINE_ASSEMBLY)
          __asm mov ecx, orig;
          __asm mov edx, target;
          __asm mov eax, [ecx];
          __asm mov ebx, 4[ecx];
          __asm bswap eax;
          __asm bswap ebx;
          // We're little endian.
          __asm mov 2[edx], ax;
          __asm mov 6[edx], bx;
          __asm shr eax, 16;
          __asm shr ebx, 16;
          __asm mov 0[edx], ax;
          __asm mov 4[edx], bx;
#elif ACE_SIZEOF_LONG == 8
          // 64 bit architecture.
          ACE_REGISTER unsigned long a =
            * reinterpret_cast<const unsigned long*> (orig);

          ACE_REGISTER unsigned long a1 = (a & 0x00ff00ff00ff00ffUL) << 8;
          ACE_REGISTER unsigned long a2 = (a & 0xff00ff00ff00ff00UL) >> 8;

          a = (a1 | a2);

          ACE_UINT16 b1 = static_cast<ACE_UINT16> (a >> 48);
          ACE_UINT16 b2 = static_cast<ACE_UINT16> ((a >> 32) & 0xffff);
          ACE_UINT16 b3 = static_cast<ACE_UINT16> ((a >> 16) & 0xffff);
          ACE_UINT16 b4 = static_cast<ACE_UINT16> (a & 0xffff);

#if defined(ACE_LITTLE_ENDIAN)
          * reinterpret_cast<ACE_UINT16*> (target) = b4;
          * reinterpret_cast<ACE_UINT16*> (target + 2) = b3;
          * reinterpret_cast<ACE_UINT16*> (target + 4) = b2;
          * reinterpret_cast<ACE_UINT16*> (target + 6) = b1;
#else
          * reinterpret_cast<ACE_UINT16*> (target) = b1;
          * reinterpret_cast<ACE_UINT16*> (target + 2) = b2;
          * reinterpret_cast<ACE_UINT16*> (target + 4) = b3;
          * reinterpret_cast<ACE_UINT16*> (target + 6) = b4;
#endif
#else
          ACE_REGISTER ACE_UINT32 a =
            * reinterpret_cast<const ACE_UINT32*> (orig);
          ACE_REGISTER ACE_UINT32 b =
            * reinterpret_cast<const ACE_UINT32*> (orig + 4);

          ACE_REGISTER ACE_UINT32 a1 = (a & 0x00ff00ff) << 8;
          ACE_REGISTER ACE_UINT32 b1 = (b & 0x00ff00ff) << 8;
          ACE_REGISTER ACE_UINT32 a2 = (a & 0xff00ff00) >> 8;
          ACE_REGISTER ACE_UINT32 b2 = (b & 0xff00ff00) >> 8;

          a = (a1 | a2);
          b = (b1 | b2);

          ACE_UINT32 c1 = static_cast<ACE_UINT16> (a >> 16);
          ACE_UINT32 c2 = static_cast<ACE_UINT16> (a & 0xffff);
          ACE_UINT32 c3 = static_cast<ACE_UINT16> (b >> 16);
          ACE_UINT32 c4 = static_cast<ACE_UINT16> (b & 0xffff);

#if defined(ACE_LITTLE_ENDIAN)
          * reinterpret_cast<ACE_UINT16*> (target) = c2;
          * reinterpret_cast<ACE_UINT16*> (target + 2) = c1;
          * reinterpret_cast<ACE_UINT16*> (target + 4) = c4;
          * reinterpret_cast<ACE_UINT16*> (target + 6) = c3;
#else
          * reinterpret_cast<ACE_UINT16*> (target) = c1;
          * reinterpret_cast<ACE_UINT16*> (target + 2) = c2;
          * reinterpret_cast<ACE_UINT16*> (target + 4) = c3;
          * reinterpret_cast<ACE_UINT16*> (target + 6) = c4;
#endif
#endif

          orig += 8;
          target += 8;
        }
    }

  // (n & 3) == (n % 4).
  switch (n&3) {
  case 3:
    ACE_CDR::swap_2 (orig, target);
    orig += 2;
    target += 2;
  case 2:
    ACE_CDR::swap_2 (orig, target);
    orig += 2;
    target += 2;
  case 1:
    ACE_CDR::swap_2 (orig, target);
  }
}

void
ACE_CDR::swap_4_array (char const * orig, char* target, size_t n)
{
  // ACE_ASSERT (n > 0); The caller checks that n > 0

#if ACE_SIZEOF_LONG == 8
  // Later, we read from *orig in 64 bit chunks,
  // so make sure we don't generate unaligned readings.
  char const * const o8 = ACE_ptr_align_binary (orig, 8);
  // The mismatch can only be by 4.
  if (orig != o8)
    {
      ACE_CDR::swap_4 (orig, target);
      orig += 4;
      target += 4;
      --n;
    }
#endif  /* ACE_SIZEOF_LONG == 8 */

  if (n == 0)
    return;

  //
  // Loop unrolling. Here be dragons.
  //

  // (n & (~3)) is the greatest multiple of 4 not bigger than n.
  // In the while loop, orig will move over the array by 16 byte
  // increments (4 elements of 4 bytes).
  // ends marks our barrier for not falling outside.
  char const * const end = orig + 4 * (n & (~3));

#if ACE_SIZEOF_LONG == 8
  // 64 bits architecture.
  // See if we can write in 8 byte chunks.
  if (target == ACE_ptr_align_binary (target, 8))
    {
      while (orig < end)
        {
          ACE_REGISTER unsigned long a =
            * reinterpret_cast<const long*> (orig);
          ACE_REGISTER unsigned long b =
            * reinterpret_cast<const long*> (orig + 8);

#if defined(ACE_HAS_INTEL_ASSEMBLY)
          asm ("bswapq %1" : "=r" (a) : "0" (a));
          asm ("bswapq %1" : "=r" (b) : "0" (b));
          asm ("rol $32, %1" : "=r" (a) : "0" (a));
          asm ("rol $32, %1" : "=r" (b) : "0" (b));
#else
          ACE_REGISTER unsigned long a84 = (a & 0x000000ff000000ffL) << 24;
          ACE_REGISTER unsigned long b84 = (b & 0x000000ff000000ffL) << 24;
          ACE_REGISTER unsigned long a73 = (a & 0x0000ff000000ff00L) << 8;
          ACE_REGISTER unsigned long b73 = (b & 0x0000ff000000ff00L) << 8;
          ACE_REGISTER unsigned long a62 = (a & 0x00ff000000ff0000L) >> 8;
          ACE_REGISTER unsigned long b62 = (b & 0x00ff000000ff0000L) >> 8;
          ACE_REGISTER unsigned long a51 = (a & 0xff000000ff000000L) >> 24;
          ACE_REGISTER unsigned long b51 = (b & 0xff000000ff000000L) >> 24;

          a = (a84 | a73 | a62 | a51);
          b = (b84 | b73 | b62 | b51);
#endif

          * reinterpret_cast<long*> (target) = a;
          * reinterpret_cast<long*> (target + 8) = b;

          orig += 16;
          target += 16;
        }
    }
  else
    {
      // We are out of luck, we have to write in 4 byte chunks.
      while (orig < end)
        {
          ACE_REGISTER unsigned long a =
            * reinterpret_cast<const long*> (orig);
          ACE_REGISTER unsigned long b =
            * reinterpret_cast<const long*> (orig + 8);

#if defined(ACE_HAS_INTEL_ASSEMBLY)
          asm ("bswapq %1" : "=r" (a) : "0" (a));
          asm ("bswapq %1" : "=r" (b) : "0" (b));
          asm ("rol $32, %1" : "=r" (a) : "0" (a));
          asm ("rol $32, %1" : "=r" (b) : "0" (b));
#else
          ACE_REGISTER unsigned long a84 = (a & 0x000000ff000000ffL) << 24;
          ACE_REGISTER unsigned long b84 = (b & 0x000000ff000000ffL) << 24;
          ACE_REGISTER unsigned long a73 = (a & 0x0000ff000000ff00L) << 8;
          ACE_REGISTER unsigned long b73 = (b & 0x0000ff000000ff00L) << 8;
          ACE_REGISTER unsigned long a62 = (a & 0x00ff000000ff0000L) >> 8;
          ACE_REGISTER unsigned long b62 = (b & 0x00ff000000ff0000L) >> 8;
          ACE_REGISTER unsigned long a51 = (a & 0xff000000ff000000L) >> 24;
          ACE_REGISTER unsigned long b51 = (b & 0xff000000ff000000L) >> 24;

          a = (a84 | a73 | a62 | a51);
          b = (b84 | b73 | b62 | b51);
#endif

          ACE_UINT32 c1 = static_cast<ACE_UINT32> (a >> 32);
          ACE_UINT32 c2 = static_cast<ACE_UINT32> (a & 0xffffffff);
          ACE_UINT32 c3 = static_cast<ACE_UINT32> (b >> 32);
          ACE_UINT32 c4 = static_cast<ACE_UINT32> (b & 0xffffffff);

#if defined (ACE_LITTLE_ENDIAN)
          * reinterpret_cast<ACE_UINT32*> (target + 0) = c2;
          * reinterpret_cast<ACE_UINT32*> (target + 4) = c1;
          * reinterpret_cast<ACE_UINT32*> (target + 8) = c4;
          * reinterpret_cast<ACE_UINT32*> (target + 12) = c3;
#else
          * reinterpret_cast<ACE_UINT32*> (target + 0) = c1;
          * reinterpret_cast<ACE_UINT32*> (target + 4) = c2;
          * reinterpret_cast<ACE_UINT32*> (target + 8) = c3;
          * reinterpret_cast<ACE_UINT32*> (target + 12) = c4;
#endif
          orig += 16;
          target += 16;
        }
    }

#else  /* ACE_SIZEOF_LONG != 8 */

  while (orig < end)
    {
#if defined (ACE_HAS_PENTIUM) && defined (__GNUG__)
      ACE_REGISTER unsigned int a =
        *reinterpret_cast<const unsigned int*> (orig);
      ACE_REGISTER unsigned int b =
        *reinterpret_cast<const unsigned int*> (orig + 4);
      ACE_REGISTER unsigned int c =
        *reinterpret_cast<const unsigned int*> (orig + 8);
      ACE_REGISTER unsigned int d =
        *reinterpret_cast<const unsigned int*> (orig + 12);

      asm ("bswap %1" : "=r" (a) : "0" (a));
      asm ("bswap %1" : "=r" (b) : "0" (b));
      asm ("bswap %1" : "=r" (c) : "0" (c));
      asm ("bswap %1" : "=r" (d) : "0" (d));

      *reinterpret_cast<unsigned int*> (target) = a;
      *reinterpret_cast<unsigned int*> (target + 4) = b;
      *reinterpret_cast<unsigned int*> (target + 8) = c;
      *reinterpret_cast<unsigned int*> (target + 12) = d;
#elif defined (ACE_HAS_PENTIUM) \
      && (defined (_MSC_VER) || defined (__BORLANDC__)) \
      && !defined (ACE_LACKS_INLINE_ASSEMBLY)
      __asm mov eax, orig
      __asm mov esi, target
      __asm mov edx, [eax]
      __asm mov ecx, 4[eax]
      __asm mov ebx, 8[eax]
      __asm mov eax, 12[eax]
      __asm bswap edx
      __asm bswap ecx
      __asm bswap ebx
      __asm bswap eax
      __asm mov [esi], edx
      __asm mov 4[esi], ecx
      __asm mov 8[esi], ebx
      __asm mov 12[esi], eax
#else
      ACE_REGISTER ACE_UINT32 a =
        * reinterpret_cast<const ACE_UINT32*> (orig);
      ACE_REGISTER ACE_UINT32 b =
        * reinterpret_cast<const ACE_UINT32*> (orig + 4);
      ACE_REGISTER ACE_UINT32 c =
        * reinterpret_cast<const ACE_UINT32*> (orig + 8);
      ACE_REGISTER ACE_UINT32 d =
        * reinterpret_cast<const ACE_UINT32*> (orig + 12);

      // Expect the optimizer reordering this A LOT.
      // We leave it this way for clarity.
      a = (a << 24) | ((a & 0xff00) << 8) | ((a & 0xff0000) >> 8) | (a >> 24);
      b = (b << 24) | ((b & 0xff00) << 8) | ((b & 0xff0000) >> 8) | (b >> 24);
      c = (c << 24) | ((c & 0xff00) << 8) | ((c & 0xff0000) >> 8) | (c >> 24);
      d = (d << 24) | ((d & 0xff00) << 8) | ((d & 0xff0000) >> 8) | (d >> 24);

      * reinterpret_cast<ACE_UINT32*> (target) = a;
      * reinterpret_cast<ACE_UINT32*> (target + 4) = b;
      * reinterpret_cast<ACE_UINT32*> (target + 8) = c;
      * reinterpret_cast<ACE_UINT32*> (target + 12) = d;
#endif

      orig += 16;
      target += 16;
    }

#endif /* ACE_SIZEOF_LONG == 8 */

  // (n & 3) == (n % 4).
  switch (n & 3) {
  case 3:
    ACE_CDR::swap_4 (orig, target);
    orig += 4;
    target += 4;
  case 2:
    ACE_CDR::swap_4 (orig, target);
    orig += 4;
    target += 4;
  case 1:
    ACE_CDR::swap_4 (orig, target);
  }
}

//
// We don't benefit from unrolling in swap_8_array and swap_16_array
// (swap_8 and swap_16 are big enough).
//
void
ACE_CDR::swap_8_array (char const * orig, char* target, size_t n)
{
  // ACE_ASSERT(n > 0); The caller checks that n > 0

  char const * const end = orig + 8*n;
  while (orig < end)
    {
      swap_8 (orig, target);
      orig += 8;
      target += 8;
    }
}

void
ACE_CDR::swap_16_array (char const * orig, char* target, size_t n)
{
  // ACE_ASSERT(n > 0); The caller checks that n > 0

  char const * const end = orig + 16*n;
  while (orig < end)
    {
      swap_16 (orig, target);
      orig += 16;
      target += 16;
    }
}

void
ACE_CDR::mb_align (ACE_Message_Block *mb)
{
#if !defined (ACE_CDR_IGNORE_ALIGNMENT)
  char * const start = ACE_ptr_align_binary (mb->base (),
                                             ACE_CDR::MAX_ALIGNMENT);
#else
  char * const start = mb->base ();
#endif /* ACE_CDR_IGNORE_ALIGNMENT */
  mb->rd_ptr (start);
  mb->wr_ptr (start);
}

int
ACE_CDR::grow (ACE_Message_Block *mb, size_t minsize)
{
  size_t newsize =
    ACE_CDR::first_size (minsize + ACE_CDR::MAX_ALIGNMENT);

  if (newsize <= mb->size ())
    return 0;

  ACE_Data_Block *db =
    mb->data_block ()->clone_nocopy (0, newsize);

  if (db == 0)
    return -1;

  // Do the equivalent of ACE_CDR::mb_align() here to avoid having
  // to allocate an ACE_Message_Block on the stack thereby avoiding
  // the manipulation of the data blocks reference count
  size_t mb_len = mb->length ();
  char *start = ACE_ptr_align_binary (db->base (),
                                      ACE_CDR::MAX_ALIGNMENT);

  ACE_OS::memcpy (start, mb->rd_ptr (), mb_len);
  mb->data_block (db);

  // Setting the data block on the mb resets the read and write
  // pointers back to the beginning.  We must set the rd_ptr to the
  // aligned start and adjust the write pointer to the end
  mb->rd_ptr (start);
  mb->wr_ptr (start + mb_len);

  // Remove the DONT_DELETE flags from mb
  mb->clr_self_flags (ACE_Message_Block::DONT_DELETE);

  return 0;
}

size_t
ACE_CDR::total_length (const ACE_Message_Block* begin,
                       const ACE_Message_Block* end)
{
  size_t l = 0;
  // Compute the total size.
  for (const ACE_Message_Block *i = begin;
       i != end;
       i = i->cont ())
    l += i->length ();
  return l;
}

int
ACE_CDR::consolidate (ACE_Message_Block *dst,
                      const ACE_Message_Block *src)
{
  if (src == 0)
    return 0;

  size_t const newsize =
    ACE_CDR::first_size (ACE_CDR::total_length (src, 0)
                         + ACE_CDR::MAX_ALIGNMENT);

  if (dst->size (newsize) == -1)
    return -1;

#if !defined (ACE_CDR_IGNORE_ALIGNMENT)
  // We must copy the contents of src into the new buffer, but
  // respecting the alignment.
  ptrdiff_t srcalign =
    ptrdiff_t(src->rd_ptr ()) % ACE_CDR::MAX_ALIGNMENT;
  ptrdiff_t dstalign =
    ptrdiff_t(dst->rd_ptr ()) % ACE_CDR::MAX_ALIGNMENT;
  ptrdiff_t offset = srcalign - dstalign;
  if (offset < 0)
    offset += ACE_CDR::MAX_ALIGNMENT;
  dst->rd_ptr (static_cast<size_t> (offset));
  dst->wr_ptr (dst->rd_ptr ());
#endif /* ACE_CDR_IGNORE_ALIGNMENT */

  for (const ACE_Message_Block* i = src;
       i != 0;
       i = i->cont ())
    {
      // If the destination and source are the same, do not
      // attempt to copy the data.  Just update the write pointer.
      if (dst->wr_ptr () != i->rd_ptr ())
        dst->copy (i->rd_ptr (), i->length ());
      else
        dst->wr_ptr (i->length ());
    }
  return 0;
}

#if defined (NONNATIVE_LONGLONG)
bool
ACE_CDR::LongLong::operator== (const ACE_CDR::LongLong &rhs) const
{
  return this->h == rhs.h && this->l == rhs.l;
}

bool
ACE_CDR::LongLong::operator!= (const ACE_CDR::LongLong &rhs) const
{
  return this->l != rhs.l || this->h != rhs.h;
}

#endif /* NONNATIVE_LONGLONG */

#if defined (NONNATIVE_LONGDOUBLE)
ACE_CDR::LongDouble&
ACE_CDR::LongDouble::assign (const ACE_CDR::LongDouble::NativeImpl& rhs)
{
  ACE_OS::memset (this->ld, 0, sizeof (this->ld));

  if (sizeof (rhs) == 8)
    {
#if defined (ACE_LITTLE_ENDIAN)
      static const size_t byte_zero = 1;
      static const size_t byte_one = 0;
      char rhs_ptr[16];
      ACE_CDR::swap_8 (reinterpret_cast<const char*> (&rhs), rhs_ptr);
#else
      static const size_t byte_zero = 0;
      static const size_t byte_one = 1;
      const char* rhs_ptr = reinterpret_cast<const char*> (&rhs);
#endif
      ACE_INT16 sign  = static_cast<ACE_INT16> (
                          static_cast<signed char> (rhs_ptr[0])) & 0x8000;
      ACE_INT16 exponent = ((rhs_ptr[0] & 0x7f) << 4) |
                           ((rhs_ptr[1] >> 4) & 0xf);
      const char* exp_ptr = reinterpret_cast<const char*> (&exponent);

      // Infinity and NaN have an exponent of 0x7ff in 64-bit IEEE
      if (exponent == 0x7ff)
        {
          exponent = 0x7fff;
        }
      else if (exponent) // exponent 0 stays 0 in 128-bit
        {
          exponent = (exponent - max_eleven_bit) + max_fifteen_bit;
        }
      exponent |= sign;

      // Store the sign bit and exponent
      this->ld[0] = exp_ptr[byte_zero];
      this->ld[1] = exp_ptr[byte_one];

      // Store the mantissa.  In an 8 byte double, it is split by
      // 4 bits (because of the 12 bits for sign and exponent), so
      // we have to shift and or the rhs to get the right bytes.
      size_t li = 2;
      bool direction = true;
      for (size_t ri = 1; ri < sizeof (rhs);)
        {
          if (direction)
            {
              this->ld[li] |= ((rhs_ptr[ri] << 4) & 0xf0);
              direction = false;
              ++ri;
            }
          else
            {
              this->ld[li] |= ((rhs_ptr[ri] >> 4) & 0xf);
              direction = true;
              ++li;
            }
        }
#if defined (ACE_LITTLE_ENDIAN)
      ACE_OS::memcpy (rhs_ptr, this->ld, sizeof (this->ld));
      ACE_CDR::swap_16 (rhs_ptr, this->ld);
#endif
    }
  else
    {
      ACE_OS::memcpy(this->ld,
                     reinterpret_cast<const char*> (&rhs), sizeof (rhs));
    }
  return *this;
}

ACE_CDR::LongDouble&
ACE_CDR::LongDouble::assign (const ACE_CDR::LongDouble& rhs)
{
  if (this != &rhs)
    *this = rhs;
  return *this;
}

bool
ACE_CDR::LongDouble::operator== (const ACE_CDR::LongDouble &rhs) const
{
  return ACE_OS::memcmp (this->ld, rhs.ld, 16) == 0;
}

bool
ACE_CDR::LongDouble::operator!= (const ACE_CDR::LongDouble &rhs) const
{
  return ACE_OS::memcmp (this->ld, rhs.ld, 16) != 0;
}

ACE_CDR::LongDouble::operator ACE_CDR::LongDouble::NativeImpl () const
{
  ACE_CDR::LongDouble::NativeImpl ret = 0.0;
  char* lhs_ptr = reinterpret_cast<char*> (&ret);

  if (sizeof (ret) == 8)
    {
#if defined (ACE_LITTLE_ENDIAN)
      static const size_t byte_zero = 1;
      static const size_t byte_one = 0;
      char copy[16];
      ACE_CDR::swap_16 (this->ld, copy);
#else
      static const size_t byte_zero = 0;
      static const size_t byte_one = 1;
      const char* copy = this->ld;
#endif
      ACE_INT16 exponent = 0;
      char* exp_ptr = reinterpret_cast<char*> (&exponent);
      exp_ptr[byte_zero] = copy[0];
      exp_ptr[byte_one] = copy[1];

      ACE_INT16 sign = (exponent & 0x8000);
      exponent &= 0x7fff;

      // Infinity and NaN have an exponent of 0x7fff in 128-bit IEEE
      if (exponent == 0x7fff)
        {
          exponent = 0x7ff;
        }
      else if (exponent) // exponent 0 stays 0 in 64-bit
        {
          exponent = (exponent - max_fifteen_bit) + max_eleven_bit;
        }
      exponent = (exponent << 4) | sign;

      // Store the sign and exponent
      lhs_ptr[0] = exp_ptr[byte_zero];
      lhs_ptr[1] = exp_ptr[byte_one];

      // Store the mantissa.  In an 8 byte double, it is split by
      // 4 bits (because of the 12 bits for sign and exponent), so
      // we have to shift and or the rhs to get the right bytes.
      size_t li = 1;
      bool direction = true;
      for (size_t ri = 2; li < sizeof (ret);) {
        if (direction)
          {
            lhs_ptr[li] |= ((copy[ri] >> 4) & 0xf);
            direction = false;
            ++li;
          }
        else
          {
            lhs_ptr[li] |= ((copy[ri] & 0xf) << 4);
            direction = true;
            ++ri;
          }
      }

#if defined (ACE_LITTLE_ENDIAN)
      ACE_CDR::swap_8 (lhs_ptr, lhs_ptr);
#endif
    }
  else
    {
      ACE_OS::memcpy(lhs_ptr, this->ld, sizeof (ret));
    }

  // This bit of code is unnecessary.  However, this code is
  // necessary to work around a bug in the gcc 4.1.1 optimizer.
  ACE_CDR::LongDouble tmp;
  tmp.assign (ret);

  return ret;
}
#endif /* NONNATIVE_LONGDOUBLE */


// ACE_CDR::Fixed

ACE_CDR::Fixed ACE_CDR::Fixed::from_integer (ACE_CDR::LongLong val)
{
  Fixed f;
  f.value_[15] = (val < 0) ? NEGATIVE : POSITIVE;
  f.digits_ = 0;
  f.scale_ = 0;
  bool high = true;
  int idx = 15;
  while (true)
    {
      const int mod = static_cast<int> (val % 10);
      const unsigned int digit = (mod < 0) ? -mod : mod;
      if (high)
        f.value_[idx--] |= digit << 4;
      else
        f.value_[idx] = digit;
      high = !high;
      ++f.digits_;
      if (val >= 10 || val <= -10)
        val /= 10;
      else
        break;
    }

  ACE_OS::memset (f.value_, 0, idx + !high);
  return f;
}

ACE_CDR::Fixed ACE_CDR::Fixed::from_integer (ACE_CDR::ULongLong val)
{
  Fixed f;
  f.value_[15] = POSITIVE;
  f.digits_ = 0;
  f.scale_ = 0;
  bool high = true;
  int idx = 15;
  while (true)
    {
      const unsigned int digit = val % 10;
      if (high)
        f.value_[idx--] |= digit << 4;
      else
        f.value_[idx] = digit;
      high = !high;
      ++f.digits_;
      if (val >= 10)
        val /= 10;
      else
        break;
    }

  ACE_OS::memset (f.value_, 0, idx + !high);
  return f;
}

ACE_CDR::Fixed ACE_CDR::Fixed::from_floating (LongDouble val)
{
#ifdef ACE_OPENVMS
  typedef double BigFloat;
#elif defined NONNATIVE_LONGDOUBLE
  typedef LongDouble::NativeImpl BigFloat;
#else
  typedef LongDouble BigFloat;
#endif

  Fixed f;
  f.digits_ = 0;
  bool negative = false;
  if (val < 0)
    {
      val *= -1;
      negative = true;
    }

  // How many digits are to the left of the decimal point?
  const size_t digits_left =
    static_cast<size_t> (1 + ((val > 0) ? std::log10 (val) : 0));
  if (digits_left > MAX_DIGITS)
    return f;

  f.digits_ = MAX_DIGITS;
  f.scale_ = 0;
  BigFloat int_part;
  BigFloat frac_part = std::modf (val, &int_part);

  // Insert the integer part from least to most significant
  int idx = (static_cast<int> (digits_left) + 1) / 2 - 1;
  bool high = digits_left % 2;
  if (idx >= 0)
    f.value_[idx] = 0;
  for (size_t i = 0; i < digits_left; ++i, high = !high)
    {
      const Octet digit = static_cast<Octet> (std::fmod (int_part, 10));
      if (high)
        f.value_[idx--] |= digit << 4;
      else
        f.value_[idx] = digit;
      int_part /= 10;
    }

  // Insert the fractional part from most to least significant
  idx = static_cast<int> (digits_left / 2);
  high = digits_left % 2 == 0;
  for (size_t i = digits_left; i < MAX_DIGITS; ++i, high = !high)
    {
      frac_part *= 10;
      const Octet digit = static_cast<Octet> (frac_part);
      frac_part -= digit;
      if (high)
        f.value_[idx] = digit << 4;
      else
        f.value_[idx++] |= digit;
    }

  if (frac_part >= 0.5)
    ++f; // scale set after here so that ++ applies to the fractional part

  f.scale_ = static_cast<Octet> (MAX_DIGITS - digits_left);
  f.normalize ();
  f.value_[15] |= negative ? NEGATIVE : POSITIVE;
  return f;
}

void ACE_CDR::Fixed::normalize (UShort min_scale)
{
  if (this->value_[15] & 0xf0 || !this->scale_)
    return;

  size_t bytes = 0; // number of bytes to shift down
  while (2 * (bytes + 1) < this->scale_
         && this->scale_ - 2 * (bytes + 1) >= min_scale
         && !this->value_[14 - bytes])
    ++bytes;

  const bool extra_nibble = 2 * (bytes + 1) <= this->scale_
                            && this->scale_ - 2 * (bytes + 1) >= min_scale
                            && !(this->value_[14 - bytes] & 0xf);
  const size_t nibbles = 1 /*[15].high*/ + bytes * 2 + extra_nibble;
  this->digits_ -= static_cast<Octet> (nibbles);
  this->scale_ -= static_cast<Octet> (nibbles);

  if (extra_nibble)
    {
      const bool sign = this->sign ();
      std::memmove (this->value_ + bytes + 1, this->value_, 15 - bytes);
      std::memset (this->value_, 0, bytes + 1);
      this->value_[15] |= sign ? NEGATIVE : POSITIVE;
    }
  else
    {
      this->value_[15] = (this->value_[14 - bytes] & 0xf) << 4
                         | (this->value_[15] & 0xf);
      for (size_t i = 14; i > bytes; --i)
        this->value_[i] = (this->value_[i - bytes - 1] & 0xf) << 4
                          | (this->value_[i - bytes] >> 4);
      this->value_[bytes] = this->value_[0] >> 4;
      std::memset (this->value_, 0, bytes);
    }
}

ACE_CDR::Fixed ACE_CDR::Fixed::from_string (const char *str)
{
  const bool negative = str && *str == '-';
  if (negative || (str && *str == '+'))
    ++str;

  const size_t span = ACE_OS::strspn (str, ".0123456789");

  Fixed f;
  f.value_[15] = negative ? NEGATIVE : POSITIVE;
  f.digits_ = 0;
  f.scale_ = 0;

  int idx = 15;
  bool high = true;
  for (size_t iter = span; iter && f.digits_ < MAX_DIGITS; --iter, high = !high)
    {
      if (str[iter - 1] == '.')
        {
          f.scale_ = static_cast<Octet> (span - iter);
          if (--iter == 0)
            break; // skip '.'
        }

      const unsigned int digit = str[iter - 1] - '0';
      if (high)
        f.value_[idx--] |= digit << 4;
      else
        f.value_[idx] = digit;
      ++f.digits_;
    }

  if (!f.scale_ && str[span - f.digits_ - 1] == '.')
    f.scale_ = f.digits_;

  if (idx >= 0)
    ACE_OS::memset (f.value_, 0, idx + !high);
  return f;
}

ACE_CDR::Fixed ACE_CDR::Fixed::from_octets (const Octet *array, int len,
  unsigned int scale)
{
  Fixed f;
  ACE_OS::memcpy (f.value_ + 16 - len, array, len);
  ACE_OS::memset (f.value_, 0, 16 - len);
  f.scale_ = scale;

  f.digits_ = len * 2 - 1;
  if (len > 1 && (array[0] >> 4) == 0)
    --f.digits_;

  return f;
}

ACE_CDR::Fixed::operator ACE_CDR::LongLong () const
{
  LongLong val (0);

  for (int i = this->digits_ - 1; i >= this->scale_; --i)
    val = 10 * val + this->digit (i);

  if (this->sign ())
    val *= -1;

  return val;
}

ACE_CDR::Fixed::operator ACE_CDR::LongDouble () const
{
  LongDouble val = ACE_CDR_LONG_DOUBLE_INITIALIZER;

  for (int i = this->digits_ - 1; i >= this->scale_; --i)
    ACE_CDR_LONG_DOUBLE_ASSIGNMENT (val, 10 * val + this->digit (i));

  for (int i = this->scale_ - 1; i >= 0; --i)
    val += this->digit (i) * std::pow (10.0l, i - this->scale_);

  if (this->sign ())
    val *= -1;

  return val;
}

ACE_CDR::Fixed ACE_CDR::Fixed::round (UShort scale) const
{
  Fixed f = *this;
  if (scale < f.scale_)
    {
      for (UShort i = 0; i < f.scale_ - scale; ++i)
        f.digit (i, 0);
      f.normalize (scale);
      const bool negative = f.sign ();
      if (negative)
        f.value_[15] = (f.value_[15] & 0xf0) | POSITIVE;
      if (this->digit (this->scale_ - scale - 1) >= 5)
        {
          f.scale_ = 0;
          ++f;
          f.scale_ =  static_cast<Octet> (scale);
        }
      if (negative && !!f)
        f.value_[15] = (f.value_[15] & 0xf0) | NEGATIVE;
    }
  return f;
}

ACE_CDR::Fixed ACE_CDR::Fixed::truncate (UShort scale) const
{
  Fixed f = *this;
  if (scale < f.scale_)
    {
      for (UShort i = 0; i < f.scale_ - scale; ++i)
        f.digit (i, 0);
      f.normalize (scale);
      if (f.sign ())
        {
          f.value_[15] = (f.value_[15] & 0xf0) | POSITIVE;
          if (!!f)
            f.value_[15] = (f.value_[15] & 0xf0) | NEGATIVE;
        }
    }
  return f;
}

namespace {
  struct BufferAppender
  {
    BufferAppender (char *buffer, size_t buffer_size)
      : buffer_ (buffer), buffer_size_ (buffer_size), idx_ (0) {}

    bool operator+= (char ch)
    {
      if (this->idx_ == this->buffer_size_ - 1)
        return false;
      this->buffer_[this->idx_++] = ch;
      return true;
    }

    char *const buffer_;
    const size_t buffer_size_;
    size_t idx_;
  };
}

bool ACE_CDR::Fixed::to_string (char *buffer, size_t buffer_size) const
{
  if (!buffer || buffer_size < 2)
    return false;

  const bool negative = this->sign ();
  if (negative)
    *buffer = '-';
  BufferAppender ba (buffer + negative, buffer_size - negative);

  for (int i = 15 - this->digits_ / 2; i < 16; ++i)
    {
      const Octet high = this->value_[i] >> 4, low = this->value_[i] & 0xf;

      if ((15 - i) * 2 != this->digits_)
        {
          if (this->scale_ == 1 + 2 * (15 - i))
            {
              if (!ba.idx_ && !(ba += '0'))
                return false;

              if (!(ba += '.'))
                return false;
            }

          if ((ba.idx_ || high) && !(ba += '0' + high))
            return false;
        }

      if (this->scale_ && this->scale_ == 2 * (15 - i))
        {
          if (!ba.idx_ && !(ba += '0'))
            return false;

          if (!(ba += '.'))
            return false;
        }

      if (i < 15 && (ba.idx_ || low) && !(ba += '0' + low))
        return false;
    }

  if (!ba.idx_ && !(ba += '0'))
    return false;

  buffer[ba.idx_ + negative] = 0;
  return true;
}

const ACE_CDR::Octet *ACE_CDR::Fixed::to_octets (int &n) const
{
  n = (this->digits_ + 2) / 2;
  return 16 - n + reinterpret_cast<const Octet *> (this->value_);
}

ACE_CDR::Fixed::ConstIterator ACE_CDR::Fixed::pre_add (const ACE_CDR::Fixed &f)
{
  ConstIterator rhs_iter = f.begin ();
  if (f.scale_ > this->scale_)
    {
      const int scale_diff = f.scale_ - this->scale_;
      rhs_iter += scale_diff - this->lshift (scale_diff);
    }

  if (f.digits_ - f.scale_ > this->digits_ - this->scale_)
    {
      this->digits_ += f.digits_ - f.scale_ - this->digits_ + this->scale_;
      if (this->digits_ > MAX_DIGITS)
        {
          for (size_t i = 0; i < static_cast<size_t> (this->digits_ - MAX_DIGITS); ++i)
            this->digit (static_cast<int> (i), 0);
          this->normalize (this->scale_ - MAX_DIGITS - this->digits_);
          this->digits_ = MAX_DIGITS;
        }
    }
  return rhs_iter;
}

ACE_CDR::Fixed &ACE_CDR::Fixed::operator+= (const Fixed &rhs)
{
  if (!this->sign () && rhs.sign ())
    return *this -= -rhs;

  if (this->sign () && !rhs.sign ())
    {
      Fixed negated = -*this;
      negated -= rhs;
      return *this = -negated;
    }

  ConstIterator rhs_iter = this->pre_add (rhs);

  Iterator lhs_iter = this->begin ();
  if (this->scale_ > rhs.scale_)
    lhs_iter += this->scale_ - rhs.scale_;

  bool carry = false;
  for (; rhs_iter != rhs.end (); ++lhs_iter, ++rhs_iter)
    {
      const Octet digit = *lhs_iter + *rhs_iter + carry;
      carry = digit > 9;
      *lhs_iter = digit - (carry ? 10 : 0);
    }

  if (carry)
    {
      if (this->digits_ < MAX_DIGITS)
        {
          *lhs_iter = 1;
          ++this->digits_;
        }
      else if (this->scale_)
        {
          this->digit (0, 0);
          this->normalize (this->scale_ - 1);
          this->digit (MAX_DIGITS - 1, 1);
        }
    }

  return *this;
}

int ACE_CDR::Fixed::lshift (int digits)
{
  int bytes = 0;
  for (; bytes < digits / 2; ++bytes)
    if (this->value_[bytes])
      break;

  int shifted = 0;
  if ((digits % 2) && !(this->value_[bytes] & 0xf0))
    {
      for (int i = 0; i < 15 - bytes; ++i)
        this->value_[i] = (this->value_[i + bytes] & 0xf) << 4
                          | (this->value_[i + bytes + 1] >> 4);
      std::memset (this->value_ + 15 - bytes, 0, bytes);
      this->value_[15] &= 0xf;
      shifted = 2 * bytes + 1;
    }
  else if (bytes)
    {
      std::memmove (this->value_, this->value_ + bytes, 16 - bytes);
      this->value_[15] &= 0xf;
      std::memset (this->value_ + 16 - bytes, 0, bytes - 1);
      this->value_[15 - bytes] &= 0xf0;
      shifted = 2 * bytes;
    }

  this->digits_ += shifted;
  if (this->digits_ > MAX_DIGITS)
    this->digits_ = MAX_DIGITS;

  this->scale_ += shifted;
  if (this->scale_ > MAX_DIGITS)
    this->scale_ = MAX_DIGITS;

  return shifted;
}

ACE_CDR::Fixed &ACE_CDR::Fixed::operator-= (const Fixed &rhs)
{
  if (!this->sign () && rhs.sign ())
    return *this += -rhs;

  if (this->sign () && !rhs.sign ())
    {
      Fixed negated = -*this;
      negated += rhs;
      return *this = -negated;
    }

  const Fixed before = *this;
  ConstIterator rhs_iter = this->pre_add (rhs);

  Iterator lhs_iter = this->begin ();
  if (this->scale_ > rhs.scale_)
    lhs_iter += this->scale_ - rhs.scale_;

  bool borrow = false;
  for (; rhs_iter != rhs.end (); ++lhs_iter, ++rhs_iter)
    if (*rhs_iter + borrow <= *lhs_iter)
      {
        *lhs_iter -= *rhs_iter + borrow;
        borrow = false;
      }
    else
      {
        *lhs_iter += 10 - *rhs_iter - borrow;
        borrow = true;
      }

  while (borrow && lhs_iter != this->end ())
    if (*lhs_iter)
      {
        --*lhs_iter;
        borrow = false;
      }
    else
      *lhs_iter = 9;

  if (borrow)
    return *this = -(rhs - before);

  this->ltrim ();
  return *this;
}

ACE_CDR::Fixed &ACE_CDR::Fixed::operator*= (const Fixed &rhs)
{
  if (!this->sign () && rhs.sign ())
    this->value_[15] = (this->value_[15] & 0xf0) | NEGATIVE;
  else if (this->sign () && rhs.sign ())
    this->value_[15] = (this->value_[15] & 0xf0) | POSITIVE;

  this->ltrim ();
  Fixed right = rhs;
  right.ltrim ();

  Octet temp[MAX_DIGITS * 2];
  int carry = 0;

  for (int col = 0; col < this->digits_ + right.digits_; ++col)
    {
      for (int row = (std::max) (0, col - this->digits_ + 1);
           row < (std::min) (col + 1, int (right.digits_)); ++row)
        carry += this->digit (col - row) * right.digit (row);
      temp[col] = carry % 10;
      carry /= 10;
    }

  this->digits_ += right.digits_;
  this->scale_ += right.scale_;
  int digit_offset = 0;

  if (this->digits_ > MAX_DIGITS)
    {
      digit_offset = this->digits_ - MAX_DIGITS;
      this->digits_ = MAX_DIGITS;
      if (this->scale_ > digit_offset)
        this->scale_ -= digit_offset;
    }

  for (int i = 0; i < this->digits_; ++i)
    this->digit (i, temp[i + digit_offset]);

  this->ltrim ();
  return *this;
}

ACE_CDR::Fixed &ACE_CDR::Fixed::operator/= (const Fixed &rhs)
{
  if (!rhs)
    return *this;

  if (rhs.scale_ && rhs.scale_ <= this->scale_)
    this->scale_ -= rhs.scale_;
  else if (rhs.scale_)
    {
      const Octet shifted = this->lshift (rhs.scale_ - this->scale_);
      this->scale_ -= shifted;
    }

  Fixed rhs_no_scale = rhs;
  rhs_no_scale.scale_ = 0;
  rhs_no_scale.value_[15] = (rhs_no_scale.value_[15] & 0xf0) | POSITIVE;
  rhs_no_scale.ltrim ();

  this->ltrim ();

  if (!this->sign () && rhs.sign ())
    this->value_[15] = (this->value_[15] & 0xf0) | NEGATIVE;
  else if (this->sign () && rhs.sign ())
    this->value_[15] = (this->value_[15] & 0xf0) | POSITIVE;

  static const Fixed one = from_integer (LongLong (1)),
    two = from_integer (LongLong (2)),
    three = from_integer (LongLong (3)),
    five = from_integer (LongLong (5));

  if (rhs_no_scale == one)
    return *this;

  // Most sig digit of rhs must be >= 5
  switch (rhs_no_scale.digit (rhs_no_scale.digits_ - 1))
    {
    case 1:
      return *this = (*this * five) / (rhs_no_scale * five);
    case 2:
      return *this = (*this * three) / (rhs_no_scale * three);
    case 3:
    case 4:
      return *this = (*this * two) / (rhs_no_scale * two);
    default:
      break;
    }

  const bool neg = this->sign ();
  if (neg)
    this->value_[15] = (this->value_[15] & 0xf0) | POSITIVE;

  Fixed r, q = this->div_helper2 (rhs_no_scale, r);

  if (!r)
    return *this = neg ? -q : q;;

  const int shift = q.lshift (MAX_DIGITS);
  if (shift)
    {
      const Octet scale = r.lshift (shift);
      r.scale_ = 0;
      Fixed r2;
      r = r.div_helper2 (rhs_no_scale, r2);
      r.scale_ = scale;
      q += r;
    }

  *this = neg ? -q : q;
  this->normalize ();
  return *this;
}

ACE_CDR::Fixed ACE_CDR::Fixed::div_helper2 (const Fixed &rhs, Fixed &r) const
{
  if (this->digits_ < rhs.digits_)
    r = *this;
  else if (this->digits_ == rhs.digits_)
    if (*this < rhs)
      r = *this;
    else
      {
        r = *this - rhs;
        return from_integer (LongLong (1));
      }
  else if (this->digits_ == rhs.digits_ + 1)
    return this->div_helper1 (rhs, r);
  else
    {
      const int dig = this->digits_ - rhs.digits_ - 1;
      Fixed top = *this, bot = *this; // split with bot having dig digits
      for (int i = 0; i < dig; ++i)
        top.digit (i, 0);
      for (int i = dig; i < this->digits_; ++i)
        bot.digit (i, 0);
      bot.digits_ = dig;
      top.scale_ += dig;
      top.normalize (this->scale_);

      Fixed rtop;
      const Fixed qtop = top.div_helper1 (rhs, rtop);
      const Fixed qbot = rtop.join (dig, bot).div_helper2 (rhs, r);
      return qtop.join (dig, qbot);
    }

  return from_integer ();
}

ACE_CDR::Fixed ACE_CDR::Fixed::div_helper1 (const Fixed &rhs, Fixed &r) const
{
  static const Fixed ten = from_integer (LongLong (10));
  if (*this >= rhs * ten)
    return ten + (*this - rhs * ten).div_helper1 (rhs, r);

  int q = (this->digit (this->digits_ - 1) * 10 +
           this->digit (this->digits_ - 2)) / rhs.digit (rhs.digits_ - 1);
  if (q > 9)
    q = 9;
  Fixed t = from_integer (LongLong (q)) * rhs;
  for (int i = 0; i < 2 && t > *this; ++i)
    {
      --q;
      t -= rhs;
    }

  r = *this - t;
  return from_integer (LongLong (q));
}

ACE_CDR::Fixed ACE_CDR::Fixed::join (int digits, const Fixed &bot) const
{
  Fixed res = bot;
  res.digits_ = this->digits_ + digits;
  for (int i = digits; i < MAX_DIGITS && i - digits < this->digits_; ++i)
    res.digit (i, this->digit (i - digits));
  return res;
}

ACE_CDR::Fixed &ACE_CDR::Fixed::operator++ ()
{
  if (this->sign ())
    {
      this->value_[15] = (this->value_[15] & 0xf0) | POSITIVE;
      if (!!--*this) // decrement and check if result is nonzero
        this->value_[15] = (this->value_[15] & 0xf0) | NEGATIVE;
    }
  else
    {
      Iterator iter = this->begin ();
      iter += this->scale_;
      for (; iter != this->end (); ++iter)
        {
          if (*iter < 9)
            {
              ++*iter;
              return *this;
            }
          *iter = 0;
        }
      if (this->digits_ < MAX_DIGITS)
        {
          ++this->digits_;
          *iter = 1;
        }
    }
  return *this;
}

ACE_CDR::Fixed &ACE_CDR::Fixed::operator-- ()
{
  if (this->sign ())
    {
      this->value_[15] = (this->value_[15] & 0xf0) | POSITIVE;
      ++*this;
      this->value_[15] = (this->value_[15] & 0xf0) | NEGATIVE;
    }
  else
    {
      Fixed before = *this;
      Iterator iter = this->begin ();
      iter += this->scale_;
      for (; iter != this->end (); ++iter)
        {
          if (*iter)
            {
              --*iter;
              return *this;
            }
          *iter = 9;
        }
      *this = before - from_integer (ULongLong (1));
    }
  return *this;
}

bool ACE_CDR::Fixed::operator! () const
{
  static const Octet ZERO[] = {0, 0, 0, 0, 0, 0, 0, 0,
                               0, 0, 0, 0, 0, 0, 0, POSITIVE};
  return 0 == ACE_OS::memcmp (this->value_, ZERO, sizeof ZERO);
}

ACE_OSTREAM_TYPE &operator<< (ACE_OSTREAM_TYPE &lhs, const ACE_CDR::Fixed &rhs)
{
  char digits[ACE_CDR::Fixed::MAX_STRING_SIZE];
  rhs.to_string (digits, sizeof digits);

#ifdef ACE_LACKS_IOSTREAM_TOTALLY
  ACE_OS::fputs (digits, &lhs);
#else
  lhs << digits;
#endif
  return lhs;
}

#ifndef ACE_LACKS_IOSTREAM_TOTALLY
std::istream &operator>> (std::istream &lhs, ACE_CDR::Fixed &rhs)
{
  double num;
  lhs >> num;
  ACE_CDR::LongDouble ld;
  ACE_CDR_LONG_DOUBLE_ASSIGNMENT (ld, num);
  rhs = ACE_CDR::Fixed::from_floating (ld);
  return lhs;
}
#endif

bool ACE_CDR::Fixed::less (const ACE_CDR::Fixed &rhs) const
{
  const Fixed &lhs = *this;
  if (lhs.sign () != rhs.sign ())
    return lhs.sign ();

  // signs of lhs and rhs are the same so lhs < rhs reduces to:
  // if positive, |lhs| < |rhs|
  // if negative, |rhs| < |lhs|
  // 'a' will refer to the value left of < and 'b' to the value to the right
  const ACE_CDR::Fixed &a = lhs.sign () ? rhs : lhs,
    &b = lhs.sign () ? lhs : rhs;

  if (a.scale_ == b.scale_)
    return ACE_OS::memcmp (a.value_, b.value_, sizeof a.value_) < 0;

  const int a_int_dig = a.digits_ - a.scale_, b_int_dig = b.digits_ - b.scale_;

  if (a_int_dig > b_int_dig)
    {
      for (int i = 1; i <= a_int_dig - b_int_dig; ++i)
        if (a.digit (a.digits_ - i))
          return false;
    }
  else if (a_int_dig < b_int_dig)
    {
      for (int i = 1; i <= b_int_dig - a_int_dig; ++i)
        if (b.digit (b.digits_ - i))
          return true;
    }

  const int common_frac = (std::min) (a.scale_, b.scale_),
    common_dig = (std::min) (a_int_dig, b_int_dig) + common_frac,
    a_off = a.scale_ - common_frac, // a's offset (more scale than b)
    b_off = b.scale_ - common_frac; // b's offset (more scale than a)

  for (int i = 1; i <= common_dig; ++i)
    if (a.digit (a_off + common_dig - i) < b.digit (b_off + common_dig - i))
      return true;

  for (int i = 1; i <= a_off; ++i)
    if (a.digit (a_off - i))
      return false;

  for (int i = 1; i <= b_off; ++i)
    if (b.digit (b_off - i))
      return true;

  return false;
}

bool ACE_CDR::Fixed::equal (const ACE_CDR::Fixed &rhs) const
{
  const Fixed &lhs = *this;
  if (lhs.sign () != rhs.sign ())
    return false;

  if (lhs.scale_ == rhs.scale_)
    return 0 == ACE_OS::memcmp (lhs.value_, rhs.value_, sizeof lhs.value_);

  const ACE_CDR::Fixed &more = (lhs.scale_ > rhs.scale_) ? lhs : rhs,
    &fewer = (lhs.scale_ > rhs.scale_) ? rhs : lhs;

  const ACE_CDR::Octet scale_diff = more.scale_ - fewer.scale_;

  ACE_CDR::Fixed::ConstIterator more_iter = more.begin (),
    more_end = more.end ();

  for (ACE_CDR::Octet i = 0; i < scale_diff; ++i)
    if (more_iter == more_end || *more_iter++)
      return false; // digits in more that are missing in fewer must be 0

  ACE_CDR::Fixed::ConstIterator fewer_iter = fewer.begin (),
    fewer_end = fewer.end ();

  while (more_iter != more_end && fewer_iter != fewer_end)
    if (*more_iter++ != *fewer_iter++)
      return false; // digits in common must match

  while (more_iter != more_end)
    if (*more_iter++)
      return false; // extra (more significant) digits in more must be 0

  while (fewer_iter != fewer_end)
    if (*fewer_iter++)
      return false; // extra (more significant) digits in fewer must be 0

  return true;
}

ACE_END_VERSIONED_NAMESPACE_DECL
