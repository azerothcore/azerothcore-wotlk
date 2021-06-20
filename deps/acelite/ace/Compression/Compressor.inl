// -*- C++ -*-
ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE ACE_CompressorId
ACE_Compressor::get_compressor_id(void) const
{
    return this->compressor_id_;
}

ACE_INLINE ACE_UINT32
ACE_Compressor::get_compression_level(void) const
{
    return this->compression_level_;
}

ACE_END_VERSIONED_NAMESPACE_DECL
