// -*- C++ -*-

//=============================================================================
/**
 *  @file   CDR_Base.h
 *
 * ACE Common Data Representation (CDR) basic types.
 *
 * The current implementation assumes that the host has 1-byte,
 * 2-byte and 4-byte integral types, and that it has single
 * precision and double precision IEEE floats.
 * Those assumptions are pretty good these days, with Crays being
 * the only known exception.
 *
 *  @author TAO version by
 *  @author Aniruddha Gokhale <gokhale@cs.wustl.edu>
 *  @author Carlos O'Ryan<coryan@cs.wustl.edu>
 *  @author ACE version by
 *  @author Jeff Parsons <parsons@cs.wustl.edu>
 *  @author Istvan Buki <istvan.buki@euronet.be>
 */
//=============================================================================


#ifndef ACE_CDR_BASE_H
#define ACE_CDR_BASE_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/Basic_Types.h"
#include "ace/Default_Constants.h"
#include "ace/Global_Macros.h"
#include "ace/iosfwd.h"

#include <iterator>

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

// Stuff used by the ACE CDR classes. Watch these values... they're also used
// in the ACE_CDR Byte_Order enum below.
#if defined ACE_LITTLE_ENDIAN
#  define ACE_CDR_BYTE_ORDER 1
// little endian encapsulation byte order has value = 1
#else  /* ! ACE_LITTLE_ENDIAN */
#  define ACE_CDR_BYTE_ORDER 0
// big endian encapsulation byte order has value = 0
#endif /* ! ACE_LITTLE_ENDIAN */

class ACE_Message_Block;

/**
 * @class ACE_CDR
 *
 * @brief Keep constants and some routines common to both Output and
 * Input CDR streams.
 */
class ACE_Export ACE_CDR
{
public:
  // = Constants defined by the CDR protocol.
  // By defining as many of these constants as possible as enums we
  // ensure they get inlined and avoid pointless static memory
  // allocations.

  enum
  {
    // Note that some of these get reused as part of the standard
    // binary format: unsigned is the same size as its signed cousin,
    // float is LONG_SIZE, and double is LONGLONG_SIZE.

    OCTET_SIZE = 1,
    SHORT_SIZE = 2,
    LONG_SIZE = 4,
    LONGLONG_SIZE = 8,
    LONGDOUBLE_SIZE = 16,

    OCTET_ALIGN = 1,
    SHORT_ALIGN = 2,
    LONG_ALIGN = 4,
    LONGLONG_ALIGN = 8,
    /// @note the CORBA LongDouble alignment requirements do not
    /// match its size...
    LONGDOUBLE_ALIGN = 8,

    /// Maximal CDR 1.1 alignment: "quad precision" FP (i.e. "CDR::Long
    /// double", size as above).
    MAX_ALIGNMENT = 8,

    /// The default buffer size.
    /**
     * @todo We want to add options to control this
     *   default value, so this constant should be read as the default
     *   default value ;-)
     */
    DEFAULT_BUFSIZE = ACE_DEFAULT_CDR_BUFSIZE,

    /// The buffer size grows exponentially until it reaches this size;
    /// afterwards it grows linearly using the next constant
    EXP_GROWTH_MAX = ACE_DEFAULT_CDR_EXP_GROWTH_MAX,

    /// Once exponential growth is ruled out the buffer size increases
    /// in chunks of this size, note that this constants have the same
    /// value right now, but it does not need to be so.
    LINEAR_GROWTH_CHUNK = ACE_DEFAULT_CDR_LINEAR_GROWTH_CHUNK
  };

  /**
   * @enum Byte_Order
   *
   * Defines values for the byte_order argument to ACE_OutputCDR and
   * ACE_InputCDR.
   */
  enum Byte_Order
  {
    /// Use big-endian order (also known as network byte order).
    BYTE_ORDER_BIG_ENDIAN = 0,
    /// Use little-endian order.
    BYTE_ORDER_LITTLE_ENDIAN = 1,
    /// Use whichever byte order is native to this machine.
    BYTE_ORDER_NATIVE = ACE_CDR_BYTE_ORDER
  };

  /**
   * Do byte swapping for each basic IDL type size.  There exist only
   * routines to put byte, halfword (2 bytes), word (4 bytes),
   * doubleword (8 bytes) and quadword (16 byte); because those are
   * the IDL basic type sizes.
   */
  static void swap_2 (char const *orig, char *target);
  static void swap_4 (char const *orig, char *target);
  static void swap_8 (char const *orig, char *target);
  static void swap_16 (char const *orig, char *target);
  static void swap_2_array (char const *orig,
                            char *target,
                            size_t length);
  static void swap_4_array (char const *orig,
                            char *target,
                            size_t length);
  static void swap_8_array (char const *orig,
                            char *target,
                            size_t length);
  static void swap_16_array (char const *orig,
                             char *target,
                             size_t length);

  /// Align the message block to ACE_CDR::MAX_ALIGNMENT,
  /// set by the CORBA spec at 8 bytes.
  static void mb_align (ACE_Message_Block *mb);

  /**
   * Compute the size of the smallest buffer that can contain at least
   * @a minsize bytes.
   * To understand how a "best fit" is computed look at the
   * algorithm in the code.
   * Basically the buffers grow exponentially, up to a certain point,
   * then the buffer size grows linearly.
   * The advantage of this algorithm is that is rapidly grows to a
   * large value, but does not explode at the end.
   */
  static size_t first_size (size_t minsize);

  /// Compute not the smallest, but the second smallest buffer that
  /// will fir @a minsize bytes.
  static size_t next_size (size_t minsize);

  /**
   * Increase the capacity of mb to contain at least @a minsize bytes.
   * If @a minsize is zero the size is increased by an amount at least
   * large enough to contain any of the basic IDL types.
   * @retval -1 Failure
   * @retval 0 Success.
   */
  static int grow (ACE_Message_Block *mb, size_t minsize);

  /**
   * Copy a message block chain into a single message block,
   * preserving the alignment of the first message block of the
   * original stream, not the following message blocks.
   * @retval -1 Failure
   * @retval 0 Success.
   */
  static int consolidate (ACE_Message_Block *dst,
                          const ACE_Message_Block *src);

  static size_t total_length (const ACE_Message_Block *begin,
                              const ACE_Message_Block *end);

  /**
   * @name Basic OMG IDL Types
   *
   * These types are for use in the CDR classes.  The cleanest way to
   * avoid complaints from all compilers is to define them all.
   */
  //@{
  typedef bool Boolean;
  typedef unsigned char Octet;
  typedef char Char;
  typedef ACE_WCHAR_T WChar;
  typedef ACE_INT16 Short;
  typedef ACE_UINT16 UShort;
  typedef ACE_INT32 Long;
  typedef ACE_UINT32 ULong;
  typedef ACE_UINT64 ULongLong;

#   if (defined (_MSC_VER)) || (defined (__BORLANDC__))
      typedef __int64 LongLong;
#   elif ACE_SIZEOF_LONG == 8
      typedef long LongLong;
#   elif defined(__TANDEM)
      typedef long long LongLong;
#   elif ACE_SIZEOF_LONG_LONG == 8
#     if defined (sun) && !defined (ACE_LACKS_U_LONGLONG_T)
              // sun #defines   u_longlong_t, maybe other platforms do also.
              // Use it, at least with g++, so that its -pedantic doesn't
              // complain about no ANSI C++ long long.
              typedef   longlong_t LongLong;
#     else
              typedef   long long LongLong;
#     endif /* sun */
#   else  /* no native 64 bit integer type */
#     define NONNATIVE_LONGLONG
      struct ACE_Export LongLong
        {
#     if defined (ACE_BIG_ENDIAN)
          ACE_CDR::Long h;
          ACE_CDR::Long l;
#     else
          ACE_CDR::Long l;
          ACE_CDR::Long h;
#     endif /* ! ACE_BIG_ENDIAN */

          /**
           * @name Overloaded Relation Operators.
           *
           * The canonical comparison operators.
           */
          //@{
          bool operator== (const LongLong &rhs) const;
          bool operator!= (const LongLong &rhs) const;
          //@}
        };
#   endif /* no native 64 bit integer type */

#   if defined (NONNATIVE_LONGLONG)
#     define ACE_CDR_LONGLONG_INITIALIZER {0,0}
#   else
#     define ACE_CDR_LONGLONG_INITIALIZER 0
#   endif /* NONNATIVE_LONGLONG */

#   if ACE_SIZEOF_FLOAT == 4
      typedef float Float;
#   else  /* ACE_SIZEOF_FLOAT != 4 */
      struct Float
      {
#       if ACE_SIZEOF_INT == 4
          // Use unsigned int to get word alignment.
          unsigned int f;
#       else  /* ACE_SIZEOF_INT != 4 */
          // Applications will probably have trouble with this.
          char f[4];
#       endif /* ACE_SIZEOF_INT != 4 */
      };
#   endif /* ACE_SIZEOF_FLOAT != 4 */

#   if ACE_SIZEOF_DOUBLE == 8
      typedef double Double;
#   else  /* ACE_SIZEOF_DOUBLE != 8 */
      struct Double
      {
#       if ACE_SIZEOF_LONG == 8
          // Use u long to get word alignment.
          unsigned long f;
#       else  /* ACE_SIZEOF_INT != 8 */
          // Applications will probably have trouble with this.
          char f[8];
#       endif /* ACE_SIZEOF_INT != 8 */
      };
#   endif /* ACE_SIZEOF_DOUBLE != 8 */

    // 94-9-32 Appendix A defines a 128 bit floating point "long
    // double" data type, with greatly extended precision and four
    // more bits of exponent (compared to "double").  This is an IDL
    // extension, not yet standard.

#    if   ACE_SIZEOF_LONG_DOUBLE == 16
       typedef long double      LongDouble;
#      define   ACE_CDR_LONG_DOUBLE_INITIALIZER 0
#      define   ACE_CDR_LONG_DOUBLE_ASSIGNMENT(LHS, RHS) LHS = RHS
#    else
#      define NONNATIVE_LONGDOUBLE
#      define   ACE_CDR_LONG_DOUBLE_INITIALIZER {{0}}
#      define   ACE_CDR_LONG_DOUBLE_ASSIGNMENT(LHS, RHS) LHS.assign (RHS)
       struct ACE_Export LongDouble
       {
       // VxWorks' compiler (gcc 2.96) gets confused by the operator long
       // double, so we avoid using long double as the NativeImpl.
       // Linux's x86 long double format (12 or 16 bytes) is incompatible
       // with Windows, Solaris, AIX, MacOS X and HP-UX (and probably others)
       // long double format (8 or 16 bytes).  If you need 32-bit Linux to
       // inter-operate with 64-bit Linux you will want to define this
       // macro to 0 so that "long double" is used.  Otherwise, do not define
       // this macro.
#      if defined (ACE_CDR_IMPLEMENT_WITH_NATIVE_DOUBLE) && \
          (ACE_CDR_IMPLEMENT_WITH_NATIVE_DOUBLE == 1)
         typedef double NativeImpl;
#      else
         typedef long double NativeImpl;
#      endif /* ACE_CDR_IMPLEMENT_WITH_NATIVE_DOUBLE==1 */

         char ld[16];

         LongDouble& assign (const NativeImpl& rhs);
         LongDouble& assign (const LongDouble& rhs);

         bool operator== (const LongDouble &rhs) const;
         bool operator!= (const LongDouble &rhs) const;

         LongDouble& operator*= (const NativeImpl rhs) {
           return this->assign (static_cast<NativeImpl> (*this) * rhs);
         }
         LongDouble& operator/= (const NativeImpl rhs) {
           return this->assign (static_cast<NativeImpl> (*this) / rhs);
         }
         LongDouble& operator+= (const NativeImpl rhs) {
           return this->assign (static_cast<NativeImpl> (*this) + rhs);
         }
         LongDouble& operator-= (const NativeImpl rhs) {
           return this->assign (static_cast<NativeImpl> (*this) - rhs);
         }
         LongDouble& operator++ () {
           return this->assign (static_cast<NativeImpl> (*this) + 1);
         }
         LongDouble& operator-- () {
           return this->assign (static_cast<NativeImpl> (*this) - 1);
         }
         LongDouble operator++ (int) {
           LongDouble ldv = *this;
           this->assign (static_cast<NativeImpl> (*this) + 1);
           return ldv;
         }
         LongDouble operator-- (int) {
           LongDouble ldv = *this;
           this->assign (static_cast<NativeImpl> (*this) - 1);
           return ldv;
         }

         operator NativeImpl () const;
       };
#    endif /* ACE_SIZEOF_LONG_DOUBLE != 16 */

#define ACE_HAS_CDR_FIXED
       /// Fixed-point data type: up to 31 decimal digits and a sign bit
       ///
       /// See OMG 2011-11-01 CORBA Interfaces v3.2 sections 7.10, 7.11.3.4
       /// See OMG 2011-11-02 CORBA Interoperability v3.2 section 9.3.2.8
       /// See OMG 2012-07-02 IDL-to-C++ Mapping v1.3 section 5.13
       /// This class doesn't exactly match the IDL-to-C++ mapping because
       /// it is meant for use inside a union in the IDL compiler and therefore
       /// has no constructors.  Standards-based middlware libraries such as
       /// ORBs and DDSs can wrap this class in a class of their own to provide
       /// the exact interface described by the mapping specification.
       class ACE_Export Fixed
       {
       public:
         enum
         {
           MAX_DIGITS = 31,
           MAX_STRING_SIZE = 4 + MAX_DIGITS, // includes -, 0, ., terminator
           POSITIVE = 0xc,
           NEGATIVE = 0xd
         };

         static Fixed from_integer (LongLong val = 0);
         static Fixed from_integer (ULongLong val);
         static Fixed from_floating (LongDouble val);
         static Fixed from_string (const char *str);
         static Fixed from_octets (const Octet *array, int len,
                                   unsigned int scale = 0);

         operator LongLong () const;
         operator LongDouble () const;

         Fixed round (UShort scale) const;
         Fixed truncate (UShort scale) const;

         bool to_string (char *buffer, size_t buffer_size) const;
         const Octet *to_octets (int &n) const;

         Fixed &operator+= (const Fixed &rhs);
         Fixed &operator-= (const Fixed &rhs);
         Fixed &operator*= (const Fixed &rhs);
         Fixed &operator/= (const Fixed &rhs);

         Fixed &operator++ ();
         Fixed operator++ (int);
         Fixed &operator-- ();
         Fixed operator-- (int);

         Fixed operator+ () const;
         Fixed operator- () const;
         bool operator! () const;

         UShort fixed_digits () const;
         UShort fixed_scale () const;

         bool sign () const;
         Octet digit (int n) const;
         void digit (int n, int value);

         bool less (const Fixed &rhs) const;
         bool equal (const Fixed &rhs) const;

         class Proxy
         {
           bool high_nibble_;
           Octet &element_;
         public:
           Proxy (bool high_nibble, Octet &element);
           Proxy &operator= (Octet val);
           Proxy &operator+= (int rhs);
           Proxy &operator-= (int rhs);
           Proxy &operator++ ();
           Proxy &operator-- ();
           operator Octet () const;
         };

         class IteratorBase
         {
         protected:
           explicit IteratorBase (int digit);
           bool high_nibble () const;
           Octet &storage (Fixed *outer) const;
           Octet storage (const Fixed *outer) const;
           bool compare (const IteratorBase &rhs) const;
           int digit_;
         };

         class Iterator
           : public std::iterator<std::bidirectional_iterator_tag, Proxy>
           , private IteratorBase
         {
         public:
           explicit Iterator (Fixed *outer, int digit = 0);
           Proxy operator* ();
           Iterator &operator+= (std::ptrdiff_t n);
           Iterator &operator++ ();
           Iterator operator++ (int);
           Iterator &operator-- ();
           Iterator operator-- (int);
           bool operator== (const Iterator &rhs) const;
           bool operator!= (const Iterator &rhs) const;
         private:
           Fixed *outer_;
         };

         class ConstIterator
           : public std::iterator<std::bidirectional_iterator_tag, Octet>
           , private IteratorBase
         {
         public:
           explicit ConstIterator (const Fixed *outer, int digit = 0);
           Octet operator* ();
           ConstIterator &operator+= (std::ptrdiff_t n);
           ConstIterator &operator++ ();
           ConstIterator operator++ (int);
           ConstIterator &operator-- ();
           ConstIterator operator-- (int);
           bool operator== (const ConstIterator &rhs) const;
           bool operator!= (const ConstIterator &rhs) const;
         private:
           const Fixed *outer_;
         };

         Iterator begin ();
         ConstIterator begin () const;
         ConstIterator cbegin () const;
         Iterator end ();
         ConstIterator end () const;
         ConstIterator cend () const;

       private:
         /// CDR wire format for Fixed: marshaled as an octet array with
         /// index 0 as the most significant octet and index n the least
         /// significant.  Each octet contains two decimal digits except for
         /// the last octet (least sig) which has one decimal digit in
         /// the high nibble and the sign indicator in the low nibble.
         Octet value_[16];

         /// digits_ is not marshaled, the receiver needs to know it
         /// from the type information (for example, IDL).  The value of
         /// digits_ determines how many octets of value_ are masharled.
         Octet digits_;

         /// scale_ is not marshaled, the receiver needs to know it
         /// from the type information (for example, IDL).
         Octet scale_;

         /// remove trailing zeros, shift down and reduce digits and scale
         void normalize (UShort min_scale = 0);

         /// Add up to 'digits' of additional scale by shifting left without
         /// removing significant digits.  Returns number of digits shifted.
         int lshift (int digits);

         /// Prepare to add (or subtract) f by changing the digits and scale
         /// of *this, returnins an iterator to the least significant
         /// digit of f that will influence the sum (or difference).
         ConstIterator pre_add (const Fixed &f);

         Fixed div_helper2 (const Fixed &rhs, Fixed &r) const;
         Fixed div_helper1 (const Fixed &rhs, Fixed &r) const;
         Fixed join (int digits, const Fixed &bottom) const;
         void ltrim ();
       };

  //@}

#if !defined (ACE_CDR_GIOP_MAJOR_VERSION)
#   define ACE_CDR_GIOP_MAJOR_VERSION 1
#endif /*ACE_CDR_GIOP_MAJOR_VERSION */

#if !defined (ACE_CDR_GIOP_MINOR_VERSION)
#   define ACE_CDR_GIOP_MINOR_VERSION 2
#endif /* ACE_CDR_GIOP_MINOR_VERSION */
};

ACE_Export
ACE_OSTREAM_TYPE &operator<< (ACE_OSTREAM_TYPE &lhs, const ACE_CDR::Fixed &rhs);

#ifndef ACE_LACKS_IOSTREAM_TOTALLY
ACE_Export
std::istream &operator>> (std::istream &lhs, ACE_CDR::Fixed &rhs);
#endif

ACE_Export
bool operator< (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_Export
bool operator> (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_Export
bool operator>= (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_Export
bool operator<= (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_Export
bool operator== (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_Export
bool operator!= (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_Export
ACE_CDR::Fixed operator+ (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_Export
ACE_CDR::Fixed operator- (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_Export
ACE_CDR::Fixed operator* (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_Export
ACE_CDR::Fixed operator/ (const ACE_CDR::Fixed &lhs, const ACE_CDR::Fixed &rhs);

ACE_END_VERSIONED_NAMESPACE_DECL

#if defined (__ACE_INLINE__)
# include "ace/CDR_Base.inl"
#endif  /* __ACE_INLINE__ */


#include /**/ "ace/post.h"

#endif /* ACE_CDR_BASE_H */
