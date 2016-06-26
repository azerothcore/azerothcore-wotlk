// file      : XMLSchema/TypeInfo.hpp
// author    : Boris Kolpackov <boris@dre.vanderbilt.edu>
#ifndef XMLSCHEMA_TYPE_INFO_HPP
#define XMLSCHEMA_TYPE_INFO_HPP

#include <ace/XML_Utils/XSCRT/ExtendedTypeInfo.hpp>

namespace XMLSchema
{
  template <typename C>
  struct TypeInfoInitializer
  {
    TypeInfoInitializer (XSCRT::ExtendedTypeInfoMap&);
  };
}

#include <ace/XML_Utils/XMLSchema/TypeInfo.ipp>
#include <ace/XML_Utils/XMLSchema/TypeInfo.tpp>

#endif  // XMLSCHEMA_TYPE_INFO_HPP
