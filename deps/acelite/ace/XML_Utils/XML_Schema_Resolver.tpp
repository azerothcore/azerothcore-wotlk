#ifndef XML_SCHEMA_RESOLVER_TPP
#define XML_SCHEMA_RESOLVER_TPP

#include "XML_Schema_Resolver.h"
#include "XercesString.h"

#include <xercesc/framework/LocalFileInputSource.hpp>
#include <xercesc/framework/Wrapper4InputSource.hpp>

using xercesc::Wrapper4InputSource;
using xercesc::LocalFileInputSource;


namespace XML
{
  template<typename Resolver>
  XML_Schema_Resolver<Resolver>::XML_Schema_Resolver (void)
    : resolver_ ()
  {
  }

  template<typename Resolver>
  XML_Schema_Resolver<Resolver>::XML_Schema_Resolver (Resolver &res)
    : resolver_ (res)
  {
  }

  template<typename Resolver>
  Resolver &
  XML_Schema_Resolver<Resolver>::get_resolver (void)
  {
    return resolver_;
  }

  /// This function is called by the Xerces infrastructure to
  /// actually resolve the location of a schema.
  template<typename Resolver>
  InputSource *
  XML_Schema_Resolver<Resolver>::resolveEntity (const XMLCh *const publicId,
                                                  const XMLCh *const systemId)
  {
    XStr path = resolver_ (publicId, systemId);
    if (path.begin () == 0)
      return 0;

    // Ownership of these objects is given to other people.
    return /*new Wrapper4InputSource*/ (new LocalFileInputSource (path.begin ()));
  }
}

#endif /*XML_SCHEMA_RESOLVER_TPP*/
