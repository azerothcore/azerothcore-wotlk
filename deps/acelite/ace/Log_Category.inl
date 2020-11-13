// -*- C++ -*-
ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE unsigned int
ACE_Log_Category::id() const
{
  return id_;
}

ACE_INLINE const char*
ACE_Log_Category::name () const
{
  return name_;
}

ACE_INLINE unsigned int
ACE_Log_Category_TSS::id() const
{
  return category_->id_;
}

ACE_INLINE const char*
ACE_Log_Category_TSS::name () const
{
  return category_->name_;
}

ACE_INLINE ACE_Log_Msg*
ACE_Log_Category_TSS::logger ()
{
  return logger_;
}

/// Get the current ACE_Log_Priority mask.
ACE_INLINE u_long
ACE_Log_Category_TSS::priority_mask () const
{
  return priority_mask_;
}

/// Set the ACE_Log_Priority mask, returns original mask.
ACE_INLINE u_long
ACE_Log_Category_TSS::priority_mask (u_long n_mask)
{
  u_long o_mask = this->priority_mask_;
  this->priority_mask_ = n_mask;
  return o_mask;
}
/// Return true if the requested priority is enabled.
ACE_INLINE int
ACE_Log_Category_TSS::log_priority_enabled (ACE_Log_Priority log_priority)
{
  return ACE_BIT_ENABLED (this->priority_mask_ |
                          category_->priority_mask(),
                          log_priority);
}

ACE_INLINE void
ACE_Log_Category_TSS::set (const char *file,
                           int line,
                           int op_status,
                           int errnum)
{
  logger_->set(file, line, op_status, errnum, logger_->restart (), logger_->msg_ostream (), logger_->msg_callback ());
}

/// These values are only actually set if the requested priority is
/// enabled.
ACE_INLINE
void ACE_Log_Category_TSS::conditional_set (const char *file,
                                            int line,
                                            int op_status,
                                            int errnum)
{
  logger_->conditional_set(file, line, op_status, errnum);
}

#if !defined (ACE_LACKS_VA_FUNCTIONS)
ACE_INLINE ssize_t
ACE_Log_Category_TSS::log (ACE_Log_Priority priority, const ACE_TCHAR *format_str, ...)
{
  // Start of variable args section.
  va_list argp;

  va_start (argp, format_str);

  ssize_t const result = this->log (format_str,
                                    priority,
                                    argp);
  va_end (argp);

  return result;
}

#if defined (ACE_HAS_WCHAR)
ACE_INLINE ssize_t
ACE_Log_Category_TSS::log (ACE_Log_Priority priority, const ACE_ANTI_TCHAR *format_str, ...)
{
  // Start of variable args section.
  va_list argp;

  va_start (argp, format_str);

  ssize_t const result = this->log (ACE_TEXT_ANTI_TO_TCHAR (format_str),
                                    priority,
                                    argp);
  va_end (argp);

  return result;
}
#endif /* ACE_HAS_WCHAR */
#else /* ACE_LACKS_VA_FUNCTIONS */

ACE_INLINE ssize_t
ACE_Log_Category_TSS::log (const ACE_Log_Formatter &formatter)
{
  if (this->log_priority_enabled (formatter.priority ()))
    return logger_->log (formatter);

  return 0;
}

#endif /* ACE_LACKS_VA_FUNCTIONS */

/**
 * An alternative logging mechanism that makes it possible to
 * integrate variable argument lists from other logging mechanisms
 * into the ACE mechanism.
 */

ACE_INLINE ssize_t
ACE_Log_Category_TSS::log (const ACE_TCHAR *format,
                           ACE_Log_Priority priority,
                           va_list argp)
{
  if (this->log_priority_enabled (priority) == 0)
    return 0;
  return logger_->log(format, priority, argp, this);
}

ACE_INLINE ssize_t
ACE_Log_Category_TSS::log (ACE_Log_Record &log_record,
                           int suppress_stderr)
{
  return logger_->log(log_record, suppress_stderr);
}

ACE_INLINE int
ACE_Log_Category_TSS::log_hexdump (ACE_Log_Priority priority,
                                   const char *buffer,
                                   size_t size,
                                   const ACE_TCHAR *text)
{
  if (this->log_priority_enabled (priority) == 0)
    return 0;
  return logger_->log_hexdump(priority, buffer, size, text, this);
}

/// Get the current ACE_Log_Priority mask.
ACE_INLINE u_long
ACE_Log_Category::priority_mask () const
{
  return priority_mask_;
}

/// Set the ACE_Log_Priority mask, returns original mask.
ACE_INLINE u_long
ACE_Log_Category::priority_mask (u_long n_mask)
{
  u_long o_mask = this->priority_mask_;
  this->priority_mask_ = n_mask;
  return o_mask;
}

ACE_END_VERSIONED_NAMESPACE_DECL
