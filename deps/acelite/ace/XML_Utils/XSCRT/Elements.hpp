// file      : XSCRT/Elements.hpp
// author    : Boris Kolpackov <boris@dre.vanderbilt.edu>
#ifndef XSCRT_ELEMENTS_HPP
#define XSCRT_ELEMENTS_HPP

#include <map>
#include <string>
#include <sstream>
#include "ace/ace_wchar.h"
// #include <iostream> //@@ tmp

#include <ace/XML_Utils/XSCRT/Parser.hpp>
#include "ace/Refcounted_Auto_Ptr.h"

namespace XSCRT
{
  struct IdentityProvider
  {
    virtual bool
    before (IdentityProvider const&) const = 0;

    virtual ~IdentityProvider (void)
    {

    }
  };

  class Type
  {
  public:
    virtual ~Type (void)
    {
    }

  protected:
    Type (void)
        : container_ (0)
    {
    }

    template <typename C>
    Type (XML::Element<C> const&)
        : container_ (0)
    {
    }

    template <typename C>
    Type (XML::Attribute<C> const&)
        : container_ (0)
    {
    }

    Type (Type const&)
        : container_ (0)
    {
    }

    Type&
    operator= (Type const&)
    {
      //@@ I don't need this.
      //if (map_.get ()) map_->clear (); // Flush the map.
      return *this;
    }

  public:
    Type const*
    container () const
    {
      return container_ ? container_ : this;
    }

    Type*
    container ()
    {
      return container_ ? container_ : this;
    }


    Type const*
    root () const
    {
      Type const* r = container ();

      //@@ VC6 can't handle this inside the loop.
      //
      Type const* c = r->container ();

      for (; c != r; c = c->container ()) r = c;

      return r;
    }

    Type*
    root ()
    {
      Type* r = container ();

      for (Type* c = r->container (); c != r; c = c->container ()) r = c;

      return r;
    }

    //@@
    //protected:

  public:
    virtual void
    container (Type* c)
    {
      if (container_ == c) return;

      // Revoke registrations from our old container.
      //
      if (container_ != 0 && map_.get ())
      {
        for (Map_::iterator i (map_->begin ()); i != map_->end (); ++i)
        {
          //std::wcerr << "revoking " << i->second
          //           << " to " << container_ << std::endl;

          container_->unregister_id (*(i->first));
        }
      }

      // Copy registrations to our new container.
      //
      if (c != 0 && map_.get ())
      {
        for (Map_::iterator i (map_->begin ()); i != map_->end (); ++i)
        {
          //std::wcerr << "copying " << i->second
          //           << " to " << c << std::endl;

          c->register_id (*(i->first), i->second);
        }
      }

      container_  = c;
    }

    //@@
    //protected:

  public:
    void
    register_id (IdentityProvider const& id, Type* t)
    {
      if (map_.get () == 0)
      {
#if defined (ACE_HAS_CPP11)
        map_ = std::unique_ptr<Map_> (new Map_);
#else
        map_ = std::auto_ptr<Map_> (new Map_);
#endif /* ACE_HAS_CPP11 */
      }

      if (!map_->insert (std::pair<IdentityProvider const*, Type*> (&id, t)).second)
      {
        throw 1;
      }

      if (container () != this) container ()->register_id (id, t);
    }

    void
    unregister_id (IdentityProvider const& id)
    {
      if (map_.get ())
      {
        Map_::iterator it (map_->find (&id));

        if (it != map_->end ())
        {
          map_->erase (it);

          if (container () != this) container ()->unregister_id (id);

          return;
        }
      }

      throw 1;
    }

    Type*
    lookup_id (IdentityProvider const& id) const
    {
      if (map_.get ())
      {
        Map_::const_iterator it (map_->find (&id));

        if (it != map_->end ())
        {
          return it->second;
        }
      }

      return 0;
    }

    /// Get and set methods for the idref_map_ data member
    Type* get_idref (const char* name)
    {
      std::basic_string<ACE_TCHAR> name_string (ACE_TEXT_CHAR_TO_TCHAR(name));
      std::map<std::basic_string<ACE_TCHAR>, XSCRT::Type*>::iterator i = this->idref_map_.find(name_string);
      if (i != idref_map_.end())
      {
        return i->second;
      }
      else
      {
        return 0;
      }
    }

    Type* get_idref (const std::basic_string<ACE_TCHAR>& name)
    {
      std::map<std::basic_string<ACE_TCHAR>, XSCRT::Type*>::iterator i = this->idref_map_.find(name);
      if (i != idref_map_.end())
      {
        return i->second;
      }
      else
      {
        return 0;
      }
    }

    Type* get_idref (const wchar_t *name)
    {
      std::basic_string<ACE_TCHAR> name_string (ACE_TEXT_WCHAR_TO_TCHAR(name));
      std::map<std::basic_string<ACE_TCHAR>, XSCRT::Type*>::iterator i = this->idref_map_.find(name_string);
      if (i != idref_map_.end())
      {
        return i->second;
      }
      else
      {
        return 0;
      }
    }

    void set_idref (const std::basic_string<ACE_TCHAR>& name, Type* new_idref)
    {
      this->idref_map_.insert(std::pair<std::basic_string<ACE_TCHAR>,Type*>(name, new_idref));
    }

  private:

    // Data member to handle unbounded IDREF attributes and elements
    std::map<std::basic_string<ACE_TCHAR>, XSCRT::Type*> idref_map_;

    Type* container_;

    struct IdentityComparator
    {
      bool operator () (IdentityProvider const* x,
                        IdentityProvider const* y) const
      {
        return x->before (*y);
      }
    };

    typedef
    std::map<IdentityProvider const*, Type*, IdentityComparator>
    Map_;

#if defined (ACE_HAS_CPP11)
    std::unique_ptr<Map_> map_;
#else
    std::auto_ptr<Map_> map_;
#endif /* ACE_HAS_CPP11 */
  };

  // Fundamental types template.
  //
  //
  template <typename X>
  class FundamentalType : public Type
  {
  public:
    // Trait for marshaling a FundamentalType X
    typedef X CDR_Type__;

    FundamentalType ()
    {
    }

    template<typename C>
    FundamentalType (XML::Element<C> const& e)
    {
      std::basic_stringstream<C> s;
      s << e.value ();
      s >> x_;
    }

    template<typename C>
    FundamentalType (XML::Attribute<C> const& a)
    {
      std::basic_stringstream<C> s;
      s << a.value ();
      s >> x_;
    }

    FundamentalType (X const& x)
        : x_ (x)
    {
    }

    FundamentalType&
    operator= (X const& x)
    {
      x_ = x;
      return *this;
    }

  public:
    operator X const& () const
    {
      return x_;
    }

    operator X& ()
    {
      return x_;
    }

  protected:
    X x_;
  };

  // Specialization for `signed char'
  //
  //
  template<>
  template<typename C>
  inline
  FundamentalType<signed char>::
  FundamentalType (XML::Element<C> const& e)
  {
    std::basic_stringstream<C> s;
    s << e.value ();

    short t;
    s >> t;

    x_ = static_cast<signed char> (t);
  }

  template<>
  template<typename C>
  inline
  FundamentalType<signed char>::
  FundamentalType (XML::Attribute<C> const& a)
  {
    std::basic_stringstream<C> s;
    s << a.value ();

    short t;
    s >> t;

    x_ = static_cast<signed char> (t);
  }

  // Specialization for `unsigned char'
  //
  //
  template<>
  template<typename C>
  inline
  FundamentalType<unsigned char>::
  FundamentalType (XML::Element<C> const& e)
  {
    std::basic_stringstream<C> s;
    s << e.value ();

    unsigned short t;
    s >> t;

    x_ = static_cast<unsigned char> (t);
  }

  template<>
  template<typename C>
  inline
  FundamentalType<unsigned char>::
  FundamentalType (XML::Attribute<C> const& a)
  {
    std::basic_stringstream<C> s;
    s << a.value ();

    unsigned short t;
    s >> t;

    x_ = static_cast<unsigned char> (t);
  }

  // Specialization for bool.
  //
  //

  template<>
  template<>
  inline
  FundamentalType<bool>::
  FundamentalType (XML::Element<char> const& e)
  {
    x_ = (e.value () == "true") || (e.value () == "1");
  }

  template<>
  template<>
  inline
  FundamentalType<bool>::
  FundamentalType (XML::Element<wchar_t> const& e)
  {
    x_ = (e.value () == L"true") || (e.value () == L"1");
  }

  template<>
  template<>
  inline
  FundamentalType<bool>::
  FundamentalType (XML::Attribute<char> const& a)
  {
    x_ = (a.value () == "true") || (a.value () == "1");
  }

  template<>
  template<>
  inline
  FundamentalType<bool>::
  FundamentalType (XML::Attribute<wchar_t> const& a)
  {
    x_ = (a.value () == L"true") || (a.value () == L"1");
  }

}

#endif  // XSCRT_ELEMENTS_HPP
