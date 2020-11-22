// Name_Space.cpp
#include "ace/Name_Space.h"
#include "ace/OS_NS_string.h"
#include "ace/OS_NS_stdlib.h"



ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_Name_Binding::ACE_Name_Binding (void)
  : name_ (),
    value_ (),
    type_ (ACE_OS::strdup (""))
{
  ACE_TRACE ("ACE_Name_Binding::ACE_Name_Binding");
}


ACE_Name_Binding::~ACE_Name_Binding (void)
{
  ACE_TRACE ("ACE_Name_Binding::~ACE_Name_Binding");
#if defined (ACE_HAS_ALLOC_HOOKS)
  ACE_Allocator::instance()->free ((void *) this->type_);
#else
  ACE_OS::free ((void *) this->type_);
#endif /* ACE_HAS_ALLOC_HOOKS */
}

ACE_Name_Binding::ACE_Name_Binding (const ACE_NS_WString &name,
                                    const ACE_NS_WString &value,
                                    const char *type)
  : name_ (name),
    value_ (value),
    type_ (type == 0 ? ACE_OS::strdup ("") : ACE_OS::strdup (type))
{
  ACE_TRACE ("ACE_Name_Binding::ACE_Name_Binding");
}

ACE_Name_Binding::ACE_Name_Binding (const ACE_Name_Binding &s)
  : name_ (s.name_),
    value_ (s.value_),
    type_ (ACE_OS::strdup (s.type_))
{
  ACE_TRACE ("ACE_Name_Binding::ACE_Name_Binding");
}

const ACE_Name_Binding&
ACE_Name_Binding::operator = (const ACE_Name_Binding &s)
{
  ACE_TRACE ("ACE_Name_Binding::operator =");

  if (this != &s)
    {
#if defined (ACE_HAS_ALLOC_HOOKS)
      ACE_Allocator::instance()->free ((void *) this->type_);
#else
      ACE_OS::free ((void *) this->type_);
#endif /* ACE_HAS_ALLOC_HOOKS */
      this->name_ = s.name_;
      this->value_ = s.value_;
      this->type_ = ACE_OS::strdup (s.type_);
    }

  return *this;
}

bool
ACE_Name_Binding::operator == (const ACE_Name_Binding &s) const
{
  ACE_TRACE ("ACE_Name_Binding::operator ==");
  return this->name_ == s.name_
    && this->value_ == s.value_
    && ACE_OS::strcmp (this->type_, s.type_) == 0;
}

ACE_Name_Space::~ACE_Name_Space (void)
{
  ACE_TRACE ("ACE_Name_Space::~ACE_Name_Space");
}

ACE_END_VERSIONED_NAMESPACE_DECL
