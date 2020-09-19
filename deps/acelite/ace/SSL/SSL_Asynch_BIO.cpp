// -*- C++ -*-
#include "SSL_Asynch_BIO.h"

#if OPENSSL_VERSION_NUMBER > 0x0090581fL && ((defined (ACE_WIN32) && !defined (ACE_HAS_WINCE)) || (defined (ACE_HAS_AIO_CALLS)))

#include "SSL_Asynch_Stream.h"
#include "ace/OS_NS_string.h"
#include "ace/Truncate.h"

#if (defined (ACE_HAS_VERSIONED_NAMESPACE) && ACE_HAS_VERSIONED_NAMESPACE == 1)
# define ACE_ASYNCH_BIO_WRITE_NAME ACE_PREPROC_CONCATENATE(ACE_VERSIONED_NAMESPACE_NAME, _ACE_Asynch_BIO_write)
# define ACE_ASYNCH_BIO_READ_NAME  ACE_PREPROC_CONCATENATE(ACE_VERSIONED_NAMESPACE_NAME, _ACE_Asynch_BIO_read)
# define ACE_ASYNCH_BIO_PUTS_NAME  ACE_PREPROC_CONCATENATE(ACE_VERSIONED_NAMESPACE_NAME, _ACE_Asynch_BIO_puts)
# define ACE_ASYNCH_BIO_CTRL_NAME  ACE_PREPROC_CONCATENATE(ACE_VERSIONED_NAMESPACE_NAME, _ACE_Asynch_BIO_ctrl)
# define ACE_ASYNCH_BIO_NEW_NAME   ACE_PREPROC_CONCATENATE(ACE_VERSIONED_NAMESPACE_NAME, _ACE_Asynch_BIO_new)
# define ACE_ASYNCH_BIO_FREE_NAME  ACE_PREPROC_CONCATENATE(ACE_VERSIONED_NAMESPACE_NAME, _ACE_Asynch_BIO_free)
#else
# define ACE_ASYNCH_BIO_WRITE_NAME ACE_Asynch_BIO_write
# define ACE_ASYNCH_BIO_READ_NAME  ACE_Asynch_BIO_read
# define ACE_ASYNCH_BIO_PUTS_NAME  ACE_Asynch_BIO_puts
# define ACE_ASYNCH_BIO_CTRL_NAME  ACE_Asynch_BIO_ctrl
# define ACE_ASYNCH_BIO_NEW_NAME   ACE_Asynch_BIO_new
# define ACE_ASYNCH_BIO_FREE_NAME  ACE_Asynch_BIO_free
#endif  /* ACE_HAS_VERSIONED_NAMESPACE == 1 */

/**
 * @name OpenSSL BIO Helper Methods for use with ACE's Asynchronous
 *       SSL I/O support.
 */
//@{
extern "C"
{
  int  ACE_ASYNCH_BIO_WRITE_NAME (BIO *pBIO, const char *buf, int len);
  int  ACE_ASYNCH_BIO_READ_NAME  (BIO *pBIO, char *buf, int len);
  int  ACE_ASYNCH_BIO_PUTS_NAME  (BIO *pBIO, const char *str);
  long ACE_ASYNCH_BIO_CTRL_NAME  (BIO *pBIO, int cmd, long arg1, void *arg2);
  int  ACE_ASYNCH_BIO_NEW_NAME   (BIO *pBIO);
  int  ACE_ASYNCH_BIO_FREE_NAME  (BIO *pBIO);
}
//@}

#define BIO_TYPE_ACE  ( 21 | BIO_TYPE_SOURCE_SINK )

#if OPENSSL_VERSION_NUMBER < 0x10100000L
static BIO_METHOD methods_ACE =
  {
    BIO_TYPE_ACE, // BIO_TYPE_PROXY_SERVER,
    "ACE_Asynch_BIO",
    ACE_ASYNCH_BIO_WRITE_NAME,
    ACE_ASYNCH_BIO_READ_NAME,
    ACE_ASYNCH_BIO_PUTS_NAME,
    0, /* ACE_ASYNCH_BIO_GETS_NAME, */
    ACE_ASYNCH_BIO_CTRL_NAME,
    ACE_ASYNCH_BIO_NEW_NAME,
    ACE_ASYNCH_BIO_FREE_NAME,
    0
  };
# define BIO_set_init(b, val) b->init = val
# define BIO_set_data(b, val) b->ptr = val
# define BIO_set_num(b, val) b->num = val
# if !defined (BIO_set_flags)
#  define BIO_set_flags(b, val) b->flags = val
# endif /* !BIO_set_flags */
# define BIO_set_shutdown(b, val) b->shutdown = val
# define BIO_get_init(b) b->init
# define BIO_get_data(b) b->ptr
# define BIO_get_shutdown(b) b->shutdown
#else
static BIO_METHOD* methods_ACE;
# define BIO_set_num(b, val)
#endif /* OPENSSL_VERSION_NUMBER < 0x10100000L */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

BIO *
ACE_SSL_make_BIO (void * ssl_asynch_stream)
{
#if OPENSSL_VERSION_NUMBER < 0x10100000L
  BIO * const pBIO = BIO_new (&methods_ACE);
#else
  if (!methods_ACE)
  {
    methods_ACE = BIO_meth_new(BIO_TYPE_ACE, "ACE_Asynch_BIO");
    if (methods_ACE)
    {
      BIO_meth_set_write(methods_ACE, ACE_ASYNCH_BIO_WRITE_NAME);
      BIO_meth_set_read(methods_ACE, ACE_ASYNCH_BIO_READ_NAME);
      BIO_meth_set_puts(methods_ACE, ACE_ASYNCH_BIO_PUTS_NAME);
      BIO_meth_set_ctrl(methods_ACE, ACE_ASYNCH_BIO_CTRL_NAME);
      BIO_meth_set_create(methods_ACE, ACE_ASYNCH_BIO_NEW_NAME);
      BIO_meth_set_destroy(methods_ACE, ACE_ASYNCH_BIO_FREE_NAME);
    }
  }
  BIO * const pBIO = BIO_new (methods_ACE);
#endif

  if (pBIO)
    BIO_ctrl (pBIO,
              BIO_C_SET_FILE_PTR,
              0,
              ssl_asynch_stream);

  return pBIO;
}

/**
 * @struct @c ACE_SSL_Asynch_Stream_Accessor
 *
 * @brief Privileged @c ACE_SSL_Asynch_Stream accessor.
 *
 * This structure is a @c friend to the @c ACE_SSL_Asynch_Stream
 * class so that it can gain access to the protected
 * ssl_bio_{read,write}() methods in that class.  It is full declared
 * in this implementation file to hide its interface from users to
 * prevent potential abuse of the friend relationship between it and
 * the @c ACE_SSL_Asynch_Stream class.
 */
struct ACE_SSL_Asynch_Stream_Accessor
{
  static int read (ACE_SSL_Asynch_Stream * stream,
               char * buf,
               size_t len,
               int & errval)
  {
    return stream->ssl_bio_read (buf, len, errval);
  }

  static int write (ACE_SSL_Asynch_Stream * stream,
                    const char * buf,
                    size_t len,
                    int & errval)
  {
    return stream->ssl_bio_write (buf, len, errval);
  }
};

ACE_END_VERSIONED_NAMESPACE_DECL

int
ACE_ASYNCH_BIO_NEW_NAME (BIO * pBIO)
{
  BIO_set_init(pBIO, 0); // not initialized
  BIO_set_num(pBIO, 0); // still zero ( we can use it )
  BIO_set_data(pBIO, 0); // will be pointer to ACE_SSL_Asynch_Stream
  BIO_set_flags(pBIO, 0);

  return 1;
}

int
ACE_ASYNCH_BIO_FREE_NAME (BIO * pBIO)
{
  if (pBIO && BIO_get_shutdown(pBIO))
    {
      BIO_set_data(pBIO, 0);
      BIO_set_init(pBIO, 0);
      BIO_set_num(pBIO, 0);
      BIO_set_flags(pBIO, 0);

      return 1;
    }

  return 0;
}

int
ACE_ASYNCH_BIO_READ_NAME (BIO * pBIO, char * buf, int len)
{
  BIO_clear_retry_flags (pBIO);

  ACE_SSL_Asynch_Stream * const p_stream =
    static_cast<ACE_SSL_Asynch_Stream *> (BIO_get_data(pBIO));

  if (BIO_get_init(pBIO) == 0 || p_stream == 0 || buf == 0 || len <= 0)
    return -1;

  BIO_clear_retry_flags (pBIO);

  int errval = 0;

  int retval =
    ACE_SSL_Asynch_Stream_Accessor::read (p_stream,
                                          buf,
                                          len,
                                          errval);

  if (retval >= 0)
    return retval;

  if (errval == EINPROGRESS)
    BIO_set_retry_read (pBIO);

  return -1;
}

int
ACE_ASYNCH_BIO_WRITE_NAME (BIO * pBIO, const char * buf, int len)
{
  BIO_clear_retry_flags (pBIO);

  ACE_SSL_Asynch_Stream * p_stream =
    static_cast<ACE_SSL_Asynch_Stream *> (BIO_get_data(pBIO));

  if (BIO_get_init(pBIO) == 0 || p_stream == 0 || buf == 0 || len <= 0)
    return -1;

  BIO_clear_retry_flags (pBIO);

  int errval = 0;

  int retval =
    ACE_SSL_Asynch_Stream_Accessor::write (p_stream,
                                           buf,
                                           len,
                                           errval);

  if (retval >= 0)
    return retval;

  if (errval == EINPROGRESS)
    BIO_set_retry_write (pBIO);

  return -1;
}

long
ACE_ASYNCH_BIO_CTRL_NAME (BIO * pBIO, int cmd, long num, void *ptr)
{
  long ret = 1;

  switch (cmd)
    {
    case BIO_C_SET_FILE_PTR:
      BIO_set_shutdown(pBIO, static_cast<int> (num));
      BIO_set_data(pBIO, ptr);
      BIO_set_init(pBIO, 1);
      break;

    case BIO_CTRL_INFO:
      ret = 0;
      break;

    case BIO_CTRL_GET_CLOSE:
      ret = BIO_get_shutdown(pBIO);
      break;

    case BIO_CTRL_SET_CLOSE:
      BIO_set_shutdown(pBIO, static_cast<int> (num));
      break;

    case BIO_CTRL_PENDING:
    case BIO_CTRL_WPENDING:
      ret = 0;
      break;

    case BIO_CTRL_DUP:
    case BIO_CTRL_FLUSH:
      ret = 1;
      break;

    default:
      ret = 0;
      break;
  }

  return ret;
}

int
ACE_ASYNCH_BIO_PUTS_NAME (BIO *pBIO, const char *str)
{
  size_t const n = ACE_OS::strlen (str);

  return ACE_ASYNCH_BIO_WRITE_NAME (pBIO,
                                    str,
                                    ACE_Utils::truncate_cast<int> (n));
}

#endif  /* OPENSSL_VERSION_NUMBER > 0x0090581fL && (ACE_WIN32 || ACE_HAS_AIO_CALLS) */
