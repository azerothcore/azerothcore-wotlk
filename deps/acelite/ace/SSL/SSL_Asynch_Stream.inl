// -*- C++ -*-
ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE SSL *
ACE_SSL_Asynch_Stream::ssl (void) const
{
  return this->ssl_;
}

ACE_END_VERSIONED_NAMESPACE_DECL
