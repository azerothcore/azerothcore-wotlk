#include "ace/OS_NS_stdio.h"
#include "ace/OS_NS_Thread.h"

#if !defined (ACE_HAS_INLINED_OSCALLS)
# include "ace/OS_NS_stdio.inl"
#endif /* ACE_HAS_INLINED_OSCALLS */

#if !defined (ACE_LACKS_STDINT_H)
# include <stdint.h>
#endif

#include "ace/Malloc_Base.h"

#include <cctype>
#include <clocale>
#include <cmath>

#ifndef ACE_LACKS_WCHAR_H
# include <cwchar>
#endif

# if defined (ACE_WIN32)

ACE_BEGIN_VERSIONED_NAMESPACE_DECL
ACE_TEXT_OSVERSIONINFO ACE_OS::win32_versioninfo_;
HINSTANCE ACE_OS::win32_resource_module_;
ACE_END_VERSIONED_NAMESPACE_DECL

#   if defined (ACE_HAS_DLL) && (ACE_HAS_DLL == 1) && !defined (ACE_HAS_WINCE)
// This function is called by the OS when the ACE DLL is loaded. We
// use it to determine the default module containing ACE's resources.
extern "C" BOOL WINAPI DllMain(HINSTANCE instance, DWORD reason, LPVOID)
{
  if (reason == DLL_PROCESS_ATTACH)
    {
#     if defined (ACE_DISABLES_THREAD_LIBRARY_CALLS) && (ACE_DISABLES_THREAD_LIBRARY_CALLS == 1)
      ::DisableThreadLibraryCalls (instance);
#     endif /* ACE_DISABLES_THREAD_LIBRARY_CALLS */
      ACE_OS::set_win32_resource_module(instance);
    }
  else if (reason == DLL_THREAD_DETACH)
    {
      ACE_OS::cleanup_tss (0);
    }
  return TRUE;
}
#   endif /* ACE_HAS_DLL && ACE_HAS_DLL == 1 */
# endif /* ACE_WIN32 */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

namespace ACE_OS
{

void
ace_flock_t::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_OS_TRACE ("ACE_OS::ace_flock_t::dump");

# if 0
  ACELIB_DEBUG ((LM_DEBUG, ACE_BEGIN_DUMP, this));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("handle_ = %u"), this->handle_));
#   if defined (ACE_WIN32)
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nInternal = %d"),
              this->overlapped_.Internal));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nInternalHigh = %d"),
              this->overlapped_.InternalHigh));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nOffsetHigh = %d"),
              this->overlapped_.OffsetHigh));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nhEvent = %d"),
              this->overlapped_.hEvent));
#   else
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nl_whence = %d"),
              this->lock_.l_whence));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nl_start = %d"), this->lock_.l_start));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nl_len = %d"), this->lock_.l_len));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nl_type = %d"), this->lock_.l_type));
#   endif /* ACE_WIN32 */
  ACELIB_DEBUG ((LM_DEBUG, ACE_END_DUMP));
# endif /* 0 */
#endif /* ACE_HAS_DUMP */
}

} /* namespace ACE_OS */

/*****************************************************************************/


#if defined (ACE_WIN32) && !defined (ACE_HAS_WINCE)
namespace
{
  /// Translate fopen's mode char to open's mode.  This helper function
  /// is here to avoid maintaining several pieces of identical code.
  void
  fopen_mode_to_open_mode_converter (ACE_TCHAR x, int & hmode)
  {
    switch (x)
      {
      case ACE_TEXT ('r'):
        if (ACE_BIT_DISABLED (hmode, _O_RDWR))
          {
            ACE_CLR_BITS (hmode, _O_WRONLY);
            ACE_SET_BITS (hmode, _O_RDONLY);
          }
        break;
      case ACE_TEXT ('w'):
        if (ACE_BIT_DISABLED (hmode, _O_RDWR))
          {
            ACE_CLR_BITS (hmode, _O_RDONLY);
            ACE_SET_BITS (hmode, _O_WRONLY);
          }
        ACE_SET_BITS (hmode, _O_CREAT | _O_TRUNC);
        break;
      case ACE_TEXT ('a'):
        if (ACE_BIT_DISABLED (hmode, _O_RDWR))
          {
            ACE_CLR_BITS (hmode, _O_RDONLY);
            ACE_SET_BITS (hmode, _O_WRONLY);
          }
        ACE_SET_BITS (hmode, _O_CREAT | _O_APPEND);
        break;
      case ACE_TEXT ('+'):
        ACE_CLR_BITS (hmode, _O_RDONLY | _O_WRONLY);
        ACE_SET_BITS (hmode, _O_RDWR);
        break;
      case ACE_TEXT ('t'):
        ACE_CLR_BITS (hmode, _O_BINARY);
        ACE_SET_BITS (hmode, _O_TEXT);
        break;
      case ACE_TEXT ('b'):
        ACE_CLR_BITS (hmode, _O_TEXT);
        ACE_SET_BITS (hmode, _O_BINARY);
        break;
      }
  }
}  // Close anonymous namespace

FILE *
ACE_OS::fopen (const char *filename,
               const ACE_TCHAR *mode)
{
  ACE_OS_TRACE ("ACE_OS::fopen");
#if defined (ACE_LACKS_FOPEN)
  ACE_UNUSED_ARG (filename);
  ACE_UNUSED_ARG (mode);
  ACE_NOTSUP_RETURN (0);
#else
  int hmode = _O_TEXT;

  // Let the chips fall where they may if the user passes in a NULL
  // mode string.  Convert to an empty mode string to prevent a
  // crash.
  ACE_TCHAR const empty_mode[] = ACE_TEXT ("");
  if (!mode)
    mode = empty_mode;

  for (ACE_TCHAR const* mode_ptr = mode; *mode_ptr != 0; ++mode_ptr)
    fopen_mode_to_open_mode_converter (*mode_ptr, hmode);

  ACE_HANDLE const handle = ACE_OS::open (filename, hmode);
  if (handle != ACE_INVALID_HANDLE)
    {
      hmode &= _O_TEXT | _O_RDONLY | _O_APPEND;

      int const fd = ::_open_osfhandle (intptr_t (handle), hmode);

      if (fd != -1)
        {
#   if defined (ACE_HAS_NONCONST_FDOPEN) && !defined (ACE_USES_WCHAR)
          FILE * const fp = ::_fdopen (fd, const_cast<ACE_TCHAR *> (mode));
#   elif defined (ACE_HAS_NONCONST_FDOPEN) && defined (ACE_USES_WCHAR)
          FILE * const fp = ::_wfdopen (fd, const_cast<ACE_TCHAR *> (mode));
#   elif defined (ACE_USES_WCHAR)
          FILE * const fp = ::_wfdopen (fd, mode);
#   else
          FILE * const fp = ::fdopen (fd, mode);
#   endif /* defined(ACE_HAS_NONCONST_FDOPEN) && !defined (ACE_USES_WCHAR)) */
          if (fp != 0)
          {
            return fp;
          }
          ::_close (fd);
        }

      ACE_OS::close (handle);
    }
  return 0;
#endif
}

#if defined (ACE_HAS_WCHAR)
FILE *
ACE_OS::fopen (const char *filename,
               const ACE_ANTI_TCHAR *mode)
{
  return ACE_OS::fopen (filename, ACE_TEXT_ANTI_TO_TCHAR (mode));
}

FILE *
ACE_OS::fopen (const wchar_t *filename,
               const ACE_ANTI_TCHAR *mode)
{
  return ACE_OS::fopen (filename, ACE_TEXT_ANTI_TO_TCHAR (mode));
}

FILE *
ACE_OS::fopen (const wchar_t *filename,
               const ACE_TCHAR *mode)
{
  ACE_OS_TRACE ("ACE_OS::fopen");
#if defined (ACE_LACKS_FOPEN)
  ACE_UNUSED_ARG (filename);
  ACE_UNUSED_ARG (mode);
  ACE_NOTSUP_RETURN (0);
#else
  int hmode = _O_TEXT;

  for (const ACE_TCHAR *mode_ptr = mode; *mode_ptr != 0; mode_ptr++)
    fopen_mode_to_open_mode_converter (*mode_ptr, hmode);

  ACE_HANDLE handle = ACE_OS::open (filename, hmode);
  if (handle != ACE_INVALID_HANDLE)
    {
      hmode &= _O_TEXT | _O_RDONLY | _O_APPEND;

      int const fd = ::_open_osfhandle (intptr_t (handle), hmode);

      if (fd != -1)
        {
#   if defined (ACE_HAS_NONCONST_FDOPEN) && !defined (ACE_USES_WCHAR)
          FILE *fp = ::_fdopen (fd, const_cast<char *> (mode));
#   elif defined (ACE_HAS_NONCONST_FDOPEN) && defined (ACE_USES_WCHAR)
          FILE *fp = ::_wfdopen (fd, const_cast<wchar_t *> (mode));
#   elif defined (ACE_USES_WCHAR)
          FILE *fp = ::_wfdopen (fd, mode);
#   else
          FILE *fp = ::fdopen (fd, mode);
#   endif /* defined(ACE_HAS_NONCONST_FDOPEN) && !defined (ACE_USES_WCHAR)) */
          if (fp != 0)
          {
            return fp;
          }
          ::_close (fd);
        }

      ACE_OS::close (handle);
    }
  return 0;
#endif
}
#endif /* ACE_HAS_WCHAR */

#endif /* ACE_WIN32 */

#ifndef ACE_STDIO_USE_STDLIB_FOR_VARARGS
// The following *printf functions aren't inline because
// they use varargs.
int
ACE_OS::fprintf (FILE *fp, const char *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::fprintf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (fp);
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vfprintf (fp, format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}
#endif /* ACE_STDIO_USE_STDLIB_FOR_VARARGS */

#if defined (ACE_HAS_WCHAR)
int
ACE_OS::fprintf (FILE *fp, const wchar_t *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::fprintf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (fp);
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vfprintf (fp, format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}
#endif /* ACE_HAS_WCHAR */

int
ACE_OS::asprintf (char **bufp, const char *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::asprintf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (bufp);
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vasprintf (bufp, format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}

#if defined (ACE_HAS_WCHAR)
int
ACE_OS::asprintf (wchar_t **bufp, const wchar_t *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::asprintf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (bufp);
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vasprintf (bufp, format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}
#endif /* ACE_HAS_WCHAR */

#if !defined ACE_FACE_DEV || !defined ACE_STDIO_USE_STDLIB_FOR_VARARGS
int
ACE_OS::printf (const char *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::printf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vprintf (format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}
#endif /* !ACE_FACE_DEV || !ACE_STDIO_USE_STDLIB_FOR_VARARGS */

#if defined (ACE_HAS_WCHAR)
int
ACE_OS::printf (const wchar_t *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::printf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vprintf (format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}
#endif /* ACE_HAS_WCHAR */

#if !defined ACE_STDIO_USE_STDLIB_FOR_VARARGS || defined ACE_LACKS_SNPRINTF
int
ACE_OS::snprintf (char *buf, size_t maxlen, const char *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::snprintf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (buf);
  ACE_UNUSED_ARG (maxlen);
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vsnprintf (buf, maxlen, format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}
#endif /* ACE_STDIO_USE_STDLIB_FOR_VARARGS */

#if defined (ACE_HAS_WCHAR)
int
ACE_OS::snprintf (wchar_t *buf, size_t maxlen, const wchar_t *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::snprintf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (buf);
  ACE_UNUSED_ARG (maxlen);
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vsnprintf (buf, maxlen, format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}
#endif /* ACE_HAS_WCHAR */

int
ACE_OS::sprintf (char *buf, const char *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::sprintf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (buf);
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vsprintf (buf, format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}

#if defined (ACE_HAS_WCHAR)
int
ACE_OS::sprintf (wchar_t *buf, const wchar_t *format, ...)
{
  // ACE_OS_TRACE ("ACE_OS::sprintf");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (buf);
  ACE_UNUSED_ARG (format);
  ACE_NOTSUP_RETURN (-1);
#else
  va_list ap;
  va_start (ap, format);
  int const result = ACE_OS::vsprintf (buf, format, ap);
  va_end (ap);
  return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}
#endif /* ACE_HAS_WCHAR */

#if !defined (ACE_HAS_VASPRINTF) && !defined (ACE_LACKS_VA_COPY)
int
ACE_OS::vasprintf_emulation(char **bufp, const char *format, va_list argptr)
{
  va_list ap;
  va_copy (ap, argptr);
  int size = ACE_OS::vsnprintf (0, 0, format, ap);
  va_end (ap);

  if (size != -1)
    {
      char *buf = reinterpret_cast<char*>(ACE_OS::malloc(size + 1));
      if (!buf)
        return -1;

      va_list aq;
      va_copy (aq, argptr);
      size = ACE_OS::vsnprintf(buf, size + 1, format, aq);
      va_end (aq);

      if (size != -1)
        *bufp = buf;
    }

  return size;
}
#endif

#if !defined (ACE_HAS_VASWPRINTF) && !defined (ACE_LACKS_VA_COPY)
#if defined (ACE_HAS_WCHAR)
int
ACE_OS::vaswprintf_emulation(wchar_t **bufp, const wchar_t *format, va_list argptr)
{
  va_list ap;
  va_copy (ap, argptr);
  int size = ACE_OS::vsnprintf(0, 0, format, ap);
  va_end (ap);

  if (size != -1)
    {
      wchar_t *buf = reinterpret_cast<wchar_t*>
        (ACE_OS::malloc((size + 1) * sizeof(wchar_t)));
      if (!buf)
        return -1;

      va_list aq;
      va_copy (aq, argptr);
      size = ACE_OS::vsnprintf(buf, size + 1, format, aq);
      va_end (aq);

      if (size != -1)
        *bufp = buf;
    }

  return size;
}
#endif /* ACE_HAS_WCHAR */
#endif /* !ACE_HAS_VASPRINTF */

#if defined (ACE_HAS_VSNPRINTF_EMULATION)

#ifdef ACE_LACKS_WCHAR_H
  typedef int wint_t;
#elif !defined ACE_LACKS_WCHAR_STD_NAMESPACE
  using std::wint_t;
# ifndef ACE_LACKS_WCSRTOMBS
  using std::wcsrtombs;
# endif
#endif

namespace { // helpers for vsnprintf_emulation
  enum Flag { SNPRINTF_NONE, SNPRINTF_GROUP, SNPRINTF_LEFT,
    SNPRINTF_SIGN = 4, SNPRINTF_SPACE = 8, SNPRINTF_ALT = 0x10,
    SNPRINTF_ZERO = 0x20, SNPRINTF_CHAR = 0x40, SNPRINTF_SHORT = 0x80,
    SNPRINTF_LONG = 0x100, SNPRINTF_LONGLONG = 0x200, SNPRINTF_INTMAX = 0x400,
    SNPRINTF_SIZET = 0x800, SNPRINTF_PTRDIFF = 0x1000,
    SNPRINTF_LONGDOUBLE = 0x2000, SNPRINTF_UCASE = 0x4000,
    SNPRINTF_UNSIGNED = 0x8000, SNPRINTF_NEGATIVE = 0x10000,
    SNPRINTF_EXPONENT = 0x20000, SNPRINTF_FLEXPONENT = 0x40000,
    SNPRINTF_HEXPONENT = 0x80000,
    SNPRINTF_LARGE_INT = (SNPRINTF_LONG|SNPRINTF_LONGLONG|SNPRINTF_INTMAX|
                          SNPRINTF_SIZET|SNPRINTF_PTRDIFF)
  };

  struct Snprintf_Flags
  {
    Snprintf_Flags ()
      : val_ (SNPRINTF_NONE)
    {}

    explicit Snprintf_Flags (const char *&fmt)
      : val_ (SNPRINTF_NONE)
    {
      this->parse_flags (fmt);
      if (this->has (SNPRINTF_LEFT))
        this->remove (SNPRINTF_ZERO);
      if (this->has (SNPRINTF_SIGN))
        this->remove (SNPRINTF_SPACE);
    }

    void parse_flags (const char *&fmt)
    {
      for (; true; ++fmt)
        {
          switch (*fmt)
            {
            // ' used as a flag is a POSIX extension to ISO std C
            case '\'': this->add (SNPRINTF_GROUP); break;
            case '-': this->add (SNPRINTF_LEFT); break;
            case '+': this->add (SNPRINTF_SIGN); break;
            case ' ': this->add (SNPRINTF_SPACE); break;
            case '#': this->add (SNPRINTF_ALT); break;
            case '0': this->add (SNPRINTF_ZERO); break;
            default: return;
            }
        }
    }

    void parse_length (const char *&fmt)
    {
      if (fmt[0] == 'h' && fmt[1] == 'h')
        this->add (SNPRINTF_CHAR), fmt += 2;
      else if (fmt[0] == 'h')
        this->add (SNPRINTF_SHORT), ++fmt;
      else if (fmt[0] == 'l' && fmt[1] == 'l')
        this->add (SNPRINTF_LONGLONG), fmt += 2;
      else if (fmt[0] == 'l')
        this->add (SNPRINTF_LONG), ++fmt;
      else if (fmt[0] == 'j')
        this->add (SNPRINTF_INTMAX), ++fmt;
      else if (fmt[0] == 'z')
        this->add (SNPRINTF_SIZET), ++fmt;
      else if (fmt[0] == 't')
        this->add (SNPRINTF_PTRDIFF), ++fmt;
      else if (fmt[0] == 'L')
        this->add (SNPRINTF_LONGDOUBLE), ++fmt;
    }

    void width (int &w)
    {
      if (w < 0)
        {
          this->add (SNPRINTF_LEFT);
          w = -w;
        }
    }

    template <typename T>
    void value (T &v)
    {
      if (v < 0)
        {
          this->add (SNPRINTF_NEGATIVE);
          v = -v;
        }
    }

    void conv_spec (char &c)
    {
      if (std::isupper (c))
        {
          if (c == 'C' || c == 'S') // C,S specs are POSIX extensions
            this->add (SNPRINTF_LONG);
          else
            this->add (SNPRINTF_UCASE);
          c = std::tolower (c);
        }

      switch (c)
        {
        case 'o': case 'u': case 'x': this->add (SNPRINTF_UNSIGNED); break;
        case 'p': this->add (SNPRINTF_ALT); break;
        case 'e': this->add (SNPRINTF_EXPONENT); break;
        case 'g': this->add (SNPRINTF_FLEXPONENT); break;
        case 'a': this->add (SNPRINTF_HEXPONENT); break;
        default: break;
        }
    }

    void add (Flag f) { this->val_ |= f; }
    void remove (Flag f) { this->val_ &= ~f; }
    bool has (Flag f) const { return (this->val_ & f) == f; }
    bool has_some (Flag f) const { return this->val_ & f; }
    int val_;
  };

  struct Snprintf_Digit_Grouping
  {
    Snprintf_Digit_Grouping (Snprintf_Flags flags, const char *grouping,
                             char thousands)
      : grouping_ (flags.has (SNPRINTF_GROUP) ? grouping : 0)
      , separator_ (flags.has (SNPRINTF_GROUP) ? *grouping : CHAR_MAX)
      , next_sep_ (this->separator_)
      , thousands_ (thousands)
    {
      if (!this->separator_)
        {
          this->grouping_ = 0;
          this->separator_ = this->next_sep_ = CHAR_MAX;
        }
    }

    int separators_needed (int digits) const
    {
      if (!this->grouping_)
        return 0;
      const char *grouping = this->grouping_;
      int group = *grouping;
      int separators = 0;
      while (group > 0 && group < CHAR_MAX && digits > group)
        {
          digits -= group;
          ++separators;
          if (grouping[1])
            group = *++grouping;
        }
      return separators;
    }

    bool next (char *&buf)
    {
      const bool separate = this->next_sep_ == 0;
      if (separate)
        {
          *--buf = this->thousands_;
          if (this->grouping_[1])
            this->separator_ = *++this->grouping_;
          this->next_sep_ = this->separator_;
        }
      if (this->next_sep_ > 0 && this->next_sep_ < CHAR_MAX)
        --this->next_sep_;
      return separate;
    }

    const char *grouping_;
    int separator_, next_sep_;
    const char thousands_;
  };

  struct Snprintf_Buffer
  {
    Snprintf_Buffer (char *buf, size_t max)
      : buf_ (buf)
      , avail_ (max - 1) // last byte is not available for writes, must be null
      , written_ (0)
    {}

    void out (const char *s, size_t n)
    {
      if (n == 0)
        return;
      const size_t m = n > this->avail_ ? this->avail_ : n;
      ACE_OS::memcpy (this->buf_, s, m);
      this->buf_ += m;
      this->avail_ -= m;
      this->written_ += n;
    }

    void fill (char c, size_t n)
    {
      if (n == 0)
        return;
      const size_t m = n > this->avail_ ? this->avail_ : n;
      ACE_OS::memset (this->buf_, c, m);
      this->buf_ += m;
      this->avail_ -= m;
      this->written_ += n;
    }

    void pad (const char *s, size_t n, Snprintf_Flags flags, int width)
    {
      const int used = static_cast<int> (n);
      if (!flags.has (SNPRINTF_LEFT) && width > used)
        this->fill (' ', width - used);
      this->out (s, n);
      if (flags.has (SNPRINTF_LEFT) && width > used)
        this->fill (' ', width - used);
    }

    void conv_int (ACE_UINT64 val, Snprintf_Flags flags,
                   int width, int precision, int base = 10)
    {
      if (val == 0 && precision == 0)
        {
          if (flags.has (SNPRINTF_SPACE) && !flags.has (SNPRINTF_UNSIGNED))
            this->fill (' ', 1);
          if (flags.has (SNPRINTF_ALT) && base == 8)
            this->fill ('0', 1);
          return;
        }

      if (precision >= 0)
        flags.remove (SNPRINTF_ZERO);
      if (precision == -1)
        precision = 1;

#ifdef ACE_LACKS_LOCALECONV
      static const char thousands_sep = 0;
      static const char grouping[] = "";
#else
# ifdef localeconv
#  undef localeconv
# endif
      const std::lconv *const conv = std::localeconv ();
      const char thousands_sep =
        conv && *conv->thousands_sep ? *conv->thousands_sep : ',';
      const char *grouping = conv ? conv->grouping : "";
#endif

      if (base != 10)
        flags.remove (SNPRINTF_GROUP);
      Snprintf_Digit_Grouping dg (flags, grouping, thousands_sep);

      char buf[100];
      char *it = buf + sizeof buf;
      const char a = flags.has (SNPRINTF_UCASE) ? 'A' : 'a';
      int sep_chars = 0;

      for (ACE_UINT64 v = val; v; v /= base)
        {
          if (dg.next (it))
            ++sep_chars;
          *--it = static_cast<char> (v % base < 10 ?
                                     '0' + v % base : a + v % base - 10);
        }

      const int digits = static_cast<int> (buf + sizeof buf - it - sep_chars);

      if (base == 8 && flags.has (SNPRINTF_ALT) && precision <= digits)
        precision = digits + 1;

      if (flags.has (SNPRINTF_NEGATIVE))
        *--it = '-';
      else if (flags.has (SNPRINTF_SPACE) && !flags.has (SNPRINTF_UNSIGNED))
        *--it = ' ';
      else if (flags.has (SNPRINTF_SIGN) && !flags.has (SNPRINTF_UNSIGNED))
        *--it = '+';

      const bool has_sign = it < buf + sizeof buf - digits - sep_chars;
      bool has_0x = false;
      if (val != 0 && base == 16 && flags.has (SNPRINTF_ALT))
        {
          *--it = flags.has (SNPRINTF_UCASE) ? 'X' : 'x';
          *--it = '0';
          has_0x = true;
        }

      int padding = 0;
      if (flags.has (SNPRINTF_ZERO) || precision > digits)
        {
          if (precision > digits)
            padding = precision - digits;

          const int prefix = has_sign ? 1 : (has_0x ? 2 : 0);
          if (flags.has (SNPRINTF_ZERO) && width > digits + sep_chars + prefix)
            padding = width - digits - prefix - sep_chars;

          if (!flags.has (SNPRINTF_LEFT) && digits + padding + prefix < width)
            {
              this->fill (' ', width - digits - padding - prefix - sep_chars);
              width = -1;
            }

          this->out (it, prefix);
          it += prefix;
          this->fill ('0', padding);
          padding += prefix;
        }

      this->pad (it, buf + sizeof buf - it, flags, width - padding);
    }

    void conv_float (long double val, Snprintf_Flags flags,
                     int width, int precision)
    {
      char buf[LDBL_MAX_10_EXP + 2];
      char *it = buf;

      // Find the sign bit manually, signbit() is only available with C99/C++11
      const void *const ptr = &val;
      const char *const pval = static_cast<const char *> (ptr);
#if ACE_BYTE_ORDER == ACE_LITTLE_ENDIAN
# if defined LDBL_MANT_DIG && LDBL_MANT_DIG == 64
#  define SIGN_OFFSET 9
# else
#  define SIGN_OFFSET (ACE_SIZEOF_LONG_DOUBLE - 1)
# endif
#else
# define SIGN_OFFSET 0
#endif
      if (pval[SIGN_OFFSET] & 0x80)
        val = -val, *it++ = '-';
      else if (flags.has (SNPRINTF_SIGN))
        *it++ = '+';
      else if (flags.has (SNPRINTF_SPACE))
        *it++ = ' ';
      const bool has_sign = it > buf;

      if (!(val >= -(std::numeric_limits<long double>::max)()
            && val <= (std::numeric_limits<long double>::max)()))
        {
          if (val != val)
            ACE_OS::strcpy (it, flags.has (SNPRINTF_UCASE) ? "NAN" : "nan");
          else
            ACE_OS::strcpy (it, flags.has (SNPRINTF_UCASE) ? "INF" : "inf");
          this->conv_str (buf, flags, width, -1);
          return;
        }

#ifdef ACE_LACKS_LOCALECONV
      static const char radix = '.', thousands_sep = 0;
      static const char grouping[] = "";
#else
      const std::lconv *const conv = std::localeconv ();
      const char radix = conv ? *conv->decimal_point : '.';
      const char thousands_sep =
        conv && *conv->thousands_sep ? *conv->thousands_sep : ',';
      const char *grouping = conv ? conv->grouping : "";
#endif

      const long double log = val > 0 ? std::log10 (val) : 0;
      int dig_left = static_cast<int> (1 + ((val >= 1) ? log : 0));

#if defined __HP_aCC && __HP_aCC < 40000
      int exp = static_cast<int> (log);
#else
      int exp = static_cast<int> (std::floor (log));
#endif
      if (flags.has (SNPRINTF_FLEXPONENT))
        {
          const int p = precision > 0 ? precision : (precision < 0 ? 6 : 1);
          precision = p - 1;
          if (exp < p && exp >= -4)
            precision -= exp;
          else
            flags.add (SNPRINTF_EXPONENT);
        }

      if (flags.has (SNPRINTF_EXPONENT))
        {
          dig_left = 1;
          val /= std::pow (10.L, exp);
        }

      if (flags.has (SNPRINTF_HEXPONENT))
        {
          *it++ = '0';
          *it++ = flags.has (SNPRINTF_UCASE) ? 'X' : 'x';
          long double mant = std::frexp (val, &exp);
          if (mant != 0)
            exp -= 4;
          const char a = flags.has (SNPRINTF_UCASE) ? 'A' : 'a';
          *it++ = hex_digit (mant, a);
          if (precision >= 0 || flags.has (SNPRINTF_ALT) || mant > 0)
            *it++ = radix;
          for (int i = 0; i < precision || precision == -1; ++i)
            {
              if ((precision == -1 && mant == 0) || it == buf + sizeof buf - 8)
                break;
              *it++ = hex_digit (mant, a);
            }
          flags.add (SNPRINTF_EXPONENT);
          *it++ = flags.has (SNPRINTF_UCASE) ? 'P' : 'p';
        }
      else
        {
#if (defined __MINGW32__ && defined __x86_64__) \
    || (defined ACE_VXWORKS && !defined __RTP__)
          // Avoid std::modf(long double, long double*) on MinGW-W64 64-bit:
          // see https://sourceforge.net/p/mingw-w64/bugs/478
          double int_part;
          double frac_part = std::modf (static_cast<double> (val), &int_part);
#else
          long double int_part;
          long double frac_part = std::modf (val, &int_part);
#endif

          Snprintf_Digit_Grouping dg (flags, grouping, thousands_sep);
          dig_left += dg.separators_needed (dig_left);

          for (char *dec = it + dig_left; dec > it; int_part /= 10)
            {
              dg.next (dec);
              *--dec = '0' + static_cast<int> (std::fmod (int_part, 10));
            }

          it += dig_left;
          const char *const frac_start = it;

          if (precision == -1)
            precision = 6;
          if (precision > 0 || flags.has (SNPRINTF_ALT))
            *it++ = radix;

          for (int i = 0; i < precision && it < buf + sizeof buf; ++i)
            {
              frac_part *= 10;
              const int digit = static_cast<int> (frac_part);
              *it++ = '0' + digit;
              frac_part -= digit;
            }

          if (flags.has (SNPRINTF_FLEXPONENT) && !flags.has (SNPRINTF_ALT))
            {
              for (char *f = it - 1; f >= frac_start; --f)
                {
                  if (*f == '0' || *f == radix)
                    {
                      --it;
                    }
                  else
                    {
                      break;
                    }
                }
            }
        }

      if (flags.has (SNPRINTF_EXPONENT))
        {
          if (!flags.has (SNPRINTF_HEXPONENT))
            *it++ = flags.has (SNPRINTF_UCASE) ? 'E' : 'e';
          Snprintf_Buffer sb (it, buf + sizeof buf - it);
          Snprintf_Flags exp_flags;
          exp_flags.add (SNPRINTF_SIGN);
          exp_flags.value (exp);
          const int exp_prec = flags.has (SNPRINTF_HEXPONENT) ? 1 : 2;
          sb.conv_int (exp, exp_flags, -1, exp_prec);
          it = sb.buf_;
        }

      int used = static_cast<int> (it - buf);
      const char *const end = it;
      it = buf;
      if (flags.has (SNPRINTF_ZERO) && used < width)
        {
          if (has_sign)
            this->fill (*it++, 1);
          if (flags.has (SNPRINTF_HEXPONENT))
            this->out (it, 2), it += 2;
          if (width > used)
            this->fill ('0', width - used);
          width = -1;
        }

      this->pad (it, end - it, flags, width);
    }

    static char hex_digit (long double &mant, char a)
    {
      mant *= 16;
      int m = static_cast<int> (mant);
      mant -= m;
      return m < 10 ? '0' + m : a + m - 10;
    }

    void conv_char (unsigned char c, Snprintf_Flags flags, int width)
    {
      this->pad (reinterpret_cast<char *> (&c), 1, flags, width);
    }

    void conv_str (const char *str, Snprintf_Flags flags,
                   int width, int precision)
    {
      const size_t len = ACE_OS::strlen (str),
        n = (precision >= 0 && precision < int (len)) ? precision : len;
      this->pad (str, n, flags, width);
    }

    void conv_str (const wchar_t *str, Snprintf_Flags flags,
                   int width, int precision)
    {
#ifdef ACE_LACKS_WCSRTOMBS
      ACE_UNUSED_ARG (str);
      this->conv_str ("(error: no wide string conversion)",
                      flags, width, precision);
#else
      std::mbstate_t mbstate = std::mbstate_t ();
      const size_t n = 1 + wcsrtombs (0, &str, 0, &mbstate);
      char *buf = static_cast<char *> (ACE_Allocator::instance ()->malloc (n));
      if (buf)
        {
          wcsrtombs (buf, &str, n, &mbstate);
          this->conv_str (buf, flags, width, precision);
        }
      ACE_Allocator::instance ()->free (buf);
#endif
    }

    char *buf_;
    size_t avail_, written_;
  };

#ifdef EOVERFLOW
# define ACE_SNPRINTF_EOVERFLOW EOVERFLOW
#else
# define ACE_SNPRINTF_EOVERFLOW EINVAL
#endif

  int snprintf_read_int (const char *&fmt)
  {
    char *end = 0;
    const unsigned long i = ACE_OS::strtoul (fmt, &end, 10);
    fmt = end;
    if (i > INT_MAX)
      {
        errno = ACE_SNPRINTF_EOVERFLOW;
        return -1;
      }
    return static_cast<int> (i);
  }

  int snprintf_positional (const char *&fmt)
  {
    const char *f = fmt;
    const int i = snprintf_read_int (f);
    if (i > 0 && *f == '$')
      {
        fmt = f + 1;
        return i;
      }
    return 0;
  }

  struct Snprintf_Positional_Args
  {
    Snprintf_Positional_Args ()
      : pos_arg_ (this->pos_storage_)
      , scanned_ (false)
    {}

    ~Snprintf_Positional_Args ()
    {
      if (this->pos_arg_ != this->pos_storage_)
        ACE_Allocator::instance ()->free (this->pos_arg_);
    }

    struct Positional_Arg
    {
      Positional_Arg ()
        : type_ (PA_UNUSED)
      {}

      enum {
        PA_UNUSED,
        PA_INT, PA_LONG, PA_LONGLONG, PA_INTMAX, PA_PTRDIFF, PA_SSIZE,
        PA_UINT, PA_ULONG, PA_ULONGLONG, PA_UINTMAX, PA_UPTRDIFF, PA_SIZE,
        PA_WINT, PA_DOUBLE, PA_LONGDOUBLE,
        PA_PCHAR, PA_PWCHAR, PA_PVOID,
        PA_PINT, PA_PINTMAX, PA_PLONG, PA_PLONGLONG, PA_PPTRDIFF, PA_PSHORT,
        PA_PSCHAR, PA_PSSIZE
      } type_;

      union
      {
        int i;
        ACE_UINT64 ui64;
        ACE_INT64 i64;
        long double f;
        void *p;
      };
    };

    static void conv_storage_needed (const char *fmt, int &storage_needed)
    {
      while (const char *f = ACE_OS::strpbrk (fmt, "*%"))
        {
          if (!*f || *f == '%')
            break;
          const int p = snprintf_positional (++f);
          if (p > storage_needed)
            storage_needed = p;
          fmt = f;
        }
    }

    void scan (int n, const char *fmt, va_list ap)
    {
      int storage_needed = n;
      const char *f = fmt;
      conv_storage_needed (f, storage_needed);
      while (const char *const pct = ACE_OS::strchr (f, '%'))
        if (pct[1] == '%')
          f = pct + 2;
        else
          {
            const int p = snprintf_positional (++f);
            if (p > storage_needed)
              storage_needed = p;
            conv_storage_needed (f, storage_needed);
          }

      if (size_t (storage_needed) >
          sizeof this->pos_storage_ / sizeof (Positional_Arg))
        this->pos_arg_ = static_cast<Positional_Arg *> (
          ACE_Allocator::instance ()->calloc (
            sizeof (Positional_Arg) * storage_needed));

      f = fmt;
      while (true)
        {
          static const char digits[] = "0123456789";
          f += ACE_OS::strspn (f, "-+ #0'");
          if (*f == '*')
            (*this)[snprintf_positional (++f)].type_ = Positional_Arg::PA_INT;
          else
            f += ACE_OS::strspn (f, digits);

          if (f[0] == '.' && f[1] == '*')
            {
              f += 2;
              (*this)[snprintf_positional (f)].type_ = Positional_Arg::PA_INT;
            }
          else if (*f == '.')
            {
              ++f;
              f += ACE_OS::strspn (f, digits);
            }

          Snprintf_Flags flags;
          flags.parse_length (f);

          switch (*f)
            {
            case 'd': case 'i':
              if (flags.has (SNPRINTF_LONG))
                (*this)[n].type_ = Positional_Arg::PA_LONG;
              else if (flags.has (SNPRINTF_LONGLONG))
                (*this)[n].type_ = Positional_Arg::PA_LONGLONG;
              else if (flags.has (SNPRINTF_INTMAX))
                (*this)[n].type_ = Positional_Arg::PA_INTMAX;
              else if (flags.has (SNPRINTF_SIZET))
                (*this)[n].type_ = Positional_Arg::PA_SSIZE;
              else if (flags.has (SNPRINTF_PTRDIFF))
                (*this)[n].type_ = Positional_Arg::PA_PTRDIFF;
              else
                (*this)[n].type_ = Positional_Arg::PA_INT;
              break;
            case 'o': case 'u': case 'x': case 'X':
              if (flags.has (SNPRINTF_LONG))
                (*this)[n].type_ = Positional_Arg::PA_ULONG;
              else if (flags.has (SNPRINTF_LONGLONG))
                (*this)[n].type_ = Positional_Arg::PA_ULONGLONG;
              else if (flags.has (SNPRINTF_INTMAX))
                (*this)[n].type_ = Positional_Arg::PA_UINTMAX;
              else if (flags.has (SNPRINTF_SIZET))
                (*this)[n].type_ = Positional_Arg::PA_SIZE;
              else if (flags.has (SNPRINTF_PTRDIFF))
                (*this)[n].type_ = Positional_Arg::PA_UPTRDIFF;
              else
                (*this)[n].type_ = Positional_Arg::PA_UINT;
              break;
            case 'f': case 'F': case 'e': case 'E': case 'g': case 'G':
            case 'a': case 'A':
              (*this)[n].type_ = flags.has (SNPRINTF_LONGDOUBLE) ?
                Positional_Arg::PA_LONGDOUBLE : Positional_Arg::PA_DOUBLE;
              break;
            case 'c':
              (*this)[n].type_ = flags.has (SNPRINTF_LONG) ?
                Positional_Arg::PA_WINT : Positional_Arg::PA_INT;
              break;
            case 'C':
              (*this)[n].type_ = Positional_Arg::PA_WINT;
              break;
            case 's':
              (*this)[n].type_ = flags.has (SNPRINTF_LONG) ?
                Positional_Arg::PA_PWCHAR : Positional_Arg::PA_PCHAR;
              break;
            case 'S':
              (*this)[n].type_ = Positional_Arg::PA_PWCHAR;
              break;
            case 'p':
              (*this)[n].type_ = Positional_Arg::PA_PVOID;
              break;
            case 'n':
              if (flags.has (SNPRINTF_LONG))
                (*this)[n].type_ = Positional_Arg::PA_PLONG;
              else if (flags.has (SNPRINTF_LONGLONG))
                (*this)[n].type_ = Positional_Arg::PA_PLONGLONG;
              else if (flags.has (SNPRINTF_INTMAX))
                (*this)[n].type_ = Positional_Arg::PA_PINTMAX;
              else if (flags.has (SNPRINTF_SIZET))
                (*this)[n].type_ = Positional_Arg::PA_PSSIZE;
              else if (flags.has (SNPRINTF_PTRDIFF))
                (*this)[n].type_ = Positional_Arg::PA_PPTRDIFF;
              else if (flags.has (SNPRINTF_SHORT))
                (*this)[n].type_ = Positional_Arg::PA_PSHORT;
              else if (flags.has (SNPRINTF_CHAR))
                (*this)[n].type_ = Positional_Arg::PA_PSCHAR;
              else
                (*this)[n].type_ = Positional_Arg::PA_PINT;
              break;
            default:
              break;
            }

          // Find the next conversion and set n to the positional arg number
          do
            f = ACE_OS::strchr (f + 1, '%');
          while (f && f[1] == '%' && ++f);

          if (!f)
            break;
          n = snprintf_positional (++f);
        }

      for (int i = 1; i <= storage_needed; ++i)
        switch ((*this)[i].type_)
          {
          case Positional_Arg::PA_INT:
            (*this)[i].i = va_arg (ap, int);
            break;
          case Positional_Arg::PA_LONG:
            (*this)[i].i64 = va_arg (ap, long);
            break;
          case Positional_Arg::PA_LONGLONG:
            (*this)[i].i64 = va_arg (ap, long long);
            break;
#ifndef ACE_LACKS_STDINT_H
          case Positional_Arg::PA_INTMAX:
            (*this)[i].i64 = va_arg (ap, intmax_t);
            break;
#endif
          case Positional_Arg::PA_PTRDIFF:
            (*this)[i].i64 = va_arg (ap, ptrdiff_t);
            break;
          case Positional_Arg::PA_SSIZE:
            (*this)[i].i64 = va_arg (ap, ssize_t);
            break;
          case Positional_Arg::PA_UINT:
            (*this)[i].ui64 = va_arg (ap, unsigned int);
            break;
          case Positional_Arg::PA_ULONG:
            (*this)[i].ui64 = va_arg (ap, unsigned long);
            break;
          case Positional_Arg::PA_ULONGLONG:
            (*this)[i].ui64 = va_arg (ap, unsigned long long);
            break;
#ifndef ACE_LACKS_STDINT_H
          case Positional_Arg::PA_UINTMAX:
            (*this)[i].ui64 = va_arg (ap, uintmax_t);
            break;
#endif
          case Positional_Arg::PA_UPTRDIFF:
            (*this)[i].ui64 = static_cast<uintptr_t> (va_arg (ap, ptrdiff_t));
            break;
          case Positional_Arg::PA_SIZE:
            (*this)[i].ui64 = va_arg (ap, size_t);
            break;
#ifdef __MINGW32__
#define ACE_WINT_T_VA_ARG int
#else
#define ACE_WINT_T_VA_ARG wint_t
#endif
          case Positional_Arg::PA_WINT:
            (*this)[i].ui64 = va_arg (ap, ACE_WINT_T_VA_ARG);
            break;
          case Positional_Arg::PA_DOUBLE:
            (*this)[i].f = va_arg (ap, double);
            break;
          case Positional_Arg::PA_LONGDOUBLE:
            (*this)[i].f = va_arg (ap, long double);
            break;
          case Positional_Arg::PA_PCHAR:
            (*this)[i].p = va_arg (ap, char *);
            break;
          case Positional_Arg::PA_PWCHAR:
            (*this)[i].p = va_arg (ap, wchar_t *);
            break;
          case Positional_Arg::PA_PVOID:
            (*this)[i].p = va_arg (ap, void *);
            break;
          case Positional_Arg::PA_PINT:
            (*this)[i].p = va_arg (ap, int *);
            break;
#ifndef ACE_LACKS_STDINT_H
          case Positional_Arg::PA_PINTMAX:
            (*this)[i].p = va_arg (ap, intmax_t *);
            break;
#endif
          case Positional_Arg::PA_PLONG:
            (*this)[i].p = va_arg (ap, long *);
            break;
          case Positional_Arg::PA_PLONGLONG:
            (*this)[i].p = va_arg (ap, long long *);
            break;
          case Positional_Arg::PA_PPTRDIFF:
            (*this)[i].p = va_arg (ap, ptrdiff_t *);
            break;
          case Positional_Arg::PA_PSHORT:
            (*this)[i].p = va_arg (ap, short *);
            break;
          case Positional_Arg::PA_PSCHAR:
            (*this)[i].p = va_arg (ap, signed char *);
            break;
          case Positional_Arg::PA_PSSIZE:
            (*this)[i].p = va_arg (ap, ssize_t *);
            break;
          default:
            break;
          }
      this->scanned_ = true;
    }

    Positional_Arg &operator[] (int idx)
    {
      return this->pos_arg_[idx - 1];
    }

    Positional_Arg pos_storage_[10], *pos_arg_;
    bool scanned_;

  private:
    Snprintf_Positional_Args (const Snprintf_Positional_Args&);
    Snprintf_Positional_Args& operator= (const Snprintf_Positional_Args&);
  };
}

int
ACE_OS::vsnprintf_emulation (char *buf, size_t max, const char *fmt, va_list ap)
{
  if (max > INT_MAX)
    {
      errno = ACE_SNPRINTF_EOVERFLOW;
      return -1;
    }

  Snprintf_Buffer sb (buf, max);
  Snprintf_Positional_Args pos_arg;

  while (const char *const pct = ACE_OS::strchr (fmt, '%'))
    {
      // Output up to next % in format string
      const bool escaped = pct[1] == '%';
      const size_t non_conv = pct - fmt + escaped;
      sb.out (fmt, non_conv);
      fmt += 1 + non_conv;
      if (escaped)
        continue;

      // Check if positional args are used (%1$d)
      const int posn = snprintf_positional (fmt);
      if (posn && !pos_arg.scanned_)
        pos_arg.scan (posn, fmt, ap); // POSIX extension

      // Parse flags (+- #'0)
      Snprintf_Flags flags (fmt);

      // Parse field width (integer, *, or *n$)
      static const int WIDTH_PREC_UNSPEC = -1;
      int width = WIDTH_PREC_UNSPEC;
      if (*fmt == '*')
        {
          ++fmt;
          const int width_p = snprintf_positional (fmt);
          width = width_p ? pos_arg[width_p].i : va_arg (ap, int);
          flags.width (width);
        }
      else if (*fmt >= '1' && *fmt <= '9')
        {
          width = snprintf_read_int (fmt);
          if (width == -1)
            return -1;
        }

      // Parse precision (.integer, .*, or .*n$)
      int precision = WIDTH_PREC_UNSPEC;
      if (fmt[0] == '.' && fmt[1] == '*')
        {
          fmt += 2;
          const int prec_p = snprintf_positional (fmt);
          precision = prec_p ? pos_arg[prec_p].i : va_arg (ap, int);
          if (precision < 0)
            precision = WIDTH_PREC_UNSPEC;
        }
      else if (*fmt == '.')
        {
          precision = snprintf_read_int (++fmt);
          if (precision == -1)
            return -1;
        }

      flags.parse_length (fmt);

      // would be nice to have a helper function for this, but va_list
      // can't portably be passed to another function (even by pointer)
#ifdef ACE_LACKS_STDINT_H
# define GET_UNSIGNED_INTMAX
#else
# define GET_UNSIGNED_INTMAX                                    \
      else if (flags.has (SNPRINTF_INTMAX))                     \
        val = va_arg (ap, uintmax_t);
#endif
#define GET_UNSIGNED_VA                                         \
      if (posn)                                                 \
        val = pos_arg[posn].ui64;                               \
      else if (flags.has (SNPRINTF_LONGLONG))                   \
        val = va_arg (ap, unsigned long long);                  \
      else if (flags.has (SNPRINTF_LONG))                       \
        val = va_arg (ap, unsigned long);                       \
      GET_UNSIGNED_INTMAX                                       \
      else if (flags.has (SNPRINTF_SIZET))                      \
        val = va_arg (ap, size_t);                              \
      else if (flags.has (SNPRINTF_PTRDIFF))                    \
        val = static_cast<uintptr_t> (va_arg (ap, ptrdiff_t));  \
      else                                                      \
        val = va_arg (ap, unsigned int);                        \
      if (flags.has (SNPRINTF_SHORT))                           \
        val = static_cast<unsigned short> (val);                \
      else if (flags.has (SNPRINTF_CHAR))                       \
        val = static_cast<unsigned char> (val)

#define GET_ARG(MEMBER, TYPE) \
      (posn ? static_cast<TYPE> (pos_arg[posn].MEMBER) : va_arg (ap, TYPE))

      ACE_UINT64 val;
      ACE_INT64 sval;
      long double fval;
      wchar_t tmp_wstr[2] = {};

      // Parse conversion specifier (diouxXfFeEgGaAcCsSpn) and convert arg
      char spec = *fmt++;
      flags.conv_spec (spec);
      switch (spec)
        {
        case 'd': case 'i':
          if (posn)
            sval = flags.has_some (SNPRINTF_LARGE_INT)
              ? pos_arg[posn].i64 : pos_arg[posn].i;
          else if (flags.has (SNPRINTF_LONGLONG))
            sval = va_arg (ap, long long);
          else if (flags.has (SNPRINTF_LONG))
            sval = va_arg (ap, long);
#ifndef ACE_LACKS_STDINT_H
          else if (flags.has (SNPRINTF_INTMAX))
            sval = va_arg (ap, intmax_t);
#endif
          else if (flags.has (SNPRINTF_SIZET))
            sval = va_arg (ap, ssize_t);
          else if (flags.has (SNPRINTF_PTRDIFF))
            sval = va_arg (ap, ptrdiff_t);
          else
            sval = va_arg (ap, int);

          if (flags.has (SNPRINTF_SHORT))
            sval = static_cast<short> (sval);
          else if (flags.has (SNPRINTF_CHAR))
            sval = static_cast<signed char> (sval);

          flags.value (sval);
          sb.conv_int (sval, flags, width, precision);
          break;

        case 'o':
          GET_UNSIGNED_VA;
          sb.conv_int (val, flags, width, precision, 8);
          break;

        case 'u':
          GET_UNSIGNED_VA;
          sb.conv_int (val, flags, width, precision);
          break;

        case 'x':
          GET_UNSIGNED_VA;
          sb.conv_int (val, flags, width, precision, 16);
          break;

        case 'f':
          fval = posn ? pos_arg[posn].f :
            (flags.has (SNPRINTF_LONGDOUBLE) ? va_arg (ap, long double)
             : va_arg (ap, double));
          sb.conv_float (fval, flags, width, precision);
          break;

        case 'e':
          fval = posn ? pos_arg[posn].f :
            (flags.has (SNPRINTF_LONGDOUBLE) ? va_arg (ap, long double)
             : va_arg (ap, double));
          sb.conv_float (fval, flags, width, precision);
          break;

        case 'g':
          fval = posn ? pos_arg[posn].f :
            (flags.has (SNPRINTF_LONGDOUBLE) ? va_arg (ap, long double)
             : va_arg (ap, double));
          sb.conv_float (fval, flags, width, precision);
          break;

        case 'a':
          fval = posn ? pos_arg[posn].f :
            (flags.has (SNPRINTF_LONGDOUBLE) ? va_arg (ap, long double)
             : va_arg (ap, double));
          sb.conv_float (fval, flags, width, precision);
          break;

        case 'c':
          if (flags.has (SNPRINTF_LONG))
            {
              *tmp_wstr = static_cast<wchar_t> (
                posn ? pos_arg[posn].ui64 : va_arg (ap, ACE_WINT_T_VA_ARG));
              sb.conv_str (tmp_wstr, flags, width, precision);
            }
          else
            sb.conv_char (static_cast<unsigned char> (GET_ARG (i, int)),
                          flags, width);
          break;

        case 's':
          if (flags.has (SNPRINTF_LONG))
            sb.conv_str (GET_ARG (p, const wchar_t *), flags, width, precision);
          else
            sb.conv_str (GET_ARG (p, const char *), flags, width, precision);
          break;

        case 'p':
          val = reinterpret_cast<ACE_UINT64> (GET_ARG (p, void *));
          sb.conv_int (val, flags, width, precision, 16);
          break;

        case 'n':
          if (flags.has (SNPRINTF_LONGLONG))
            *GET_ARG (p, long long *) = sb.written_;
          else if (flags.has (SNPRINTF_LONG))
            *GET_ARG (p, long *) = static_cast<long> (sb.written_);
#ifndef ACE_LACKS_STDINT_H
          else if (flags.has (SNPRINTF_INTMAX))
            *GET_ARG (p, intmax_t *) = sb.written_;
#endif
          else if (flags.has (SNPRINTF_SIZET))
            *GET_ARG (p, ssize_t *) = sb.written_;
          else if (flags.has (SNPRINTF_PTRDIFF))
            *GET_ARG (p, ptrdiff_t *) = sb.written_;
          else if (flags.has (SNPRINTF_SHORT))
            *GET_ARG (p, short *) = static_cast<short> (sb.written_);
          else if (flags.has (SNPRINTF_CHAR))
            *GET_ARG (p, signed char *) =
              static_cast<signed char> (sb.written_);
          else
            *GET_ARG (p, int *) = static_cast<int> (sb.written_);
          break;

        default:
          break;
        }
    }

  // Output remaining part of format string
  sb.out (fmt, ACE_OS::strlen (fmt));
  *sb.buf_ = 0;
  return static_cast<int> (sb.written_);
}
#endif // ACE_HAS_VSNPRINTF_EMULATION

ACE_END_VERSIONED_NAMESPACE_DECL
