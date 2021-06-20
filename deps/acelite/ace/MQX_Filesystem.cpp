#include "MQX_Filesystem.h"

#ifdef ACE_MQX

#include "ace/OS_NS_unistd.h"
#include "ace/OS_NS_sys_stat.h"

#include <mqx.h>
#include <fio.h>
#include <mfs.h>

#include <string.h>

#ifndef FOPEN_MAX
#  error "FOPEN_MAX, the max number of open files, must be defined"
#endif
#if FOPEN_MAX < 3
#  error "FOPEN_MAX is less than 3, no room for standard streams, let alone other files descriptors"
#endif

#define MQX_FILE_ERROR static_cast<size_t>(-1)

MQX_Filesystem MQX_Filesystem::instance_;

MQX_Filesystem::MQX_Filesystem ()
  : current_fs_ (0)
  , current_fs_name_len_ (0)
  , max_fd_ (255)
  , last_fd_ (-1)
{
  current_fs_name_[0] = '\0';

  // Initialize files_
  for (unsigned i = 0; i < FOPEN_MAX; i++)
    {
      files_[i].fd = -1;
      files_[i].mqx_file = 0;
    }
}

void MQX_Filesystem::complete_initialization ()
{
  // Set the Standard Streams
  files_[0] = {ACE_STDIN, (MQX_FILE_PTR) _io_get_handle (IO_STDIN), true};
  files_[1] = {ACE_STDOUT, (MQX_FILE_PTR) _io_get_handle (IO_STDOUT), true};
  files_[2] = {ACE_STDERR, (MQX_FILE_PTR) _io_get_handle (IO_STDERR), true};

  /*
   * Try to set the current filesystem. Ignore the error return because if
   * we're missing a filesystem now, it's okay because a filesystem might be
   * added later.
   */
  reset_state ();
}

bool
MQX_Filesystem::check_state ()
{
  if (!_io_is_fs_valid (current_fs_))
    {
      if (reset_state ())
        {
          errno = ENODEV;
          return true;
        }
    }
  return false;
}

bool
MQX_Filesystem::reset_state ()
{
  update_fs (_io_get_first_valid_fs ());
  if (current_fs_ != 0)
    chdir ("\\");
  return current_fs_ == 0;
}

void
MQX_Filesystem::update_fs (MQX_FILE_PTR fs)
{
  current_fs_ = fs;
  bool invalid = false;
  if (fs == 0)
    invalid = true;
  else if (_io_get_fs_name (fs, current_fs_name_, IOCFG_FS_MAX_DEVLEN) != MQX_OK)
    invalid = true;
  else
    current_fs_name_len_ = strlen (current_fs_name_);

  if (invalid)
    {
      current_fs_ = 0;
      current_fs_name_[0] = '\0';
      current_fs_name_len_ = 0;
    }
}

int
MQX_Filesystem::open (const char *path, int mode)
{
  if (check_state ()) return -1;

  // Convert open mode to fopen mode
  bool r = ACE_BIT_DISABLED (mode, O_RDONLY);
  bool w = ACE_BIT_ENABLED (mode, O_WRONLY);
  bool rw = ACE_BIT_ENABLED (mode, O_RDWR);
  bool a = ACE_BIT_ENABLED (mode, O_CREAT | O_APPEND);
  bool t = ACE_BIT_ENABLED (mode, O_CREAT | O_TRUNC);
  if (!(r || (w && (a || t)) || rw))
    {
      errno = EINVAL;
      return -1;
    }
  char cstdlib_mode[4] = {0}; // r/w/a, t/b, +?, null terminator
  cstdlib_mode[0] = r ? 'r' : a ? 'a' : 'w';
  cstdlib_mode[1] = 'b';
  cstdlib_mode[2] = rw ? '+' : '\0';

  /// Get Absolute Path
  char cwd[FS_FILENAME_SIZE];
  int mqx_error = _io_ioctl (current_fs_, IO_IOCTL_GET_CURRENT_DIR, (uint32_t*) cwd);
  if (mqx_error != MQX_OK)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return -1;
    }
  char abspath[ACE_MQX_ABS_PATH_SIZE];
  mqx_error = _io_rel2abs (abspath, cwd, path, ACE_MQX_ABS_PATH_SIZE, current_fs_name_);
  if (mqx_error != MQX_OK)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return -1;
    }

  // Set up a new File Entry
  File *file = get_new_file ();
  if (file == 0) return -1;

  // Call into MQX
  file->mqx_file = _io_fopen (abspath, cstdlib_mode);
  if (file->mqx_file == 0)
    {
      file->fd = -1; // Free File in Our Array
      errno = ACE_OS::mqx_error_to_errno (_task_get_error());
      if (_task_get_error() == FS_FILE_NOT_FOUND)
        _task_set_error(MQX_OK);
    }

  return file->fd;
}

int
MQX_Filesystem::close (int fd)
{
  File *file = get_file (fd);
  if (file == 0) return -1;
  int mqx_error = _io_fclose (file->mqx_file);
  if (mqx_error != MQX_OK)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return -1;
    }
  return 0;
}

size_t
MQX_Filesystem::read (int fd, unsigned char *buffer, size_t size)
{
  File *file = get_file (fd);
  if (file == 0) return MQX_FILE_ERROR;
  int result = _io_read (file->mqx_file, buffer, size);
  if (result == IO_ERROR)
    {
      errno = EIO;
      return MQX_FILE_ERROR;
    }
  return result;
}

size_t
MQX_Filesystem::write (int fd, const unsigned char *buffer, size_t size)
{
  File *file = get_file (fd);
  if (file == 0) return MQX_FILE_ERROR;
  int result = _io_write (file->mqx_file, const_cast<unsigned char *> (buffer), size);
  if (result == IO_ERROR)
    {
      errno = EIO;
      return MQX_FILE_ERROR;
    }
  return result;
}

long
MQX_Filesystem::lseek (int fd, long offset, int whence)
{
  switch (whence)
    {
    case SEEK_SET:
      whence = IO_SEEK_SET;
      break;
    case SEEK_CUR:
      whence = IO_SEEK_CUR;
      break;
    case SEEK_END:
      whence = IO_SEEK_END;
      break;
    default:
      errno = EINVAL;
      return -1;
    }
  File *file = get_file (fd);
  if (file == 0) return -1;
  return _io_fseek (file->mqx_file, offset, whence) == MQX_OK ? 0 : -1;
}

char*
MQX_Filesystem::getcwd (char *buf, size_t size)
{
  if (check_state ()) return 0;
  if (buf == 0)
    {
      errno = EINVAL;
      return 0;
    }

  char curdirtmp[FS_FILENAME_SIZE];
  int mqx_error = _io_ioctl (current_fs_, IO_IOCTL_GET_CURRENT_DIR, (uint32_t*) curdirtmp);
  if (mqx_error != MFS_NO_ERROR)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return 0;
    }
  if ((current_fs_name_len_ + strlen (curdirtmp) + 1) > size)
    {
      errno = ERANGE;
      return 0;
    }
  strcpy (buf, current_fs_name_);
  strcat (buf, curdirtmp);
  return buf;
}

MQX_FILE_PTR
MQX_Filesystem::resolve_fs (const char *path, int *fs_name_len)
{
  if (check_state ()) return 0;

  if (fs_name_len == 0 || path == 0 || path[0] == '\0')
    {
      errno = EINVAL;
      return 0;
    }
  MQX_FILE_PTR fs;
  char fs_name[IOCFG_FS_MAX_DEVLEN];
  bool fs_in_path;
  *fs_name_len = _io_get_dev_for_path (
    fs_name, &fs_in_path, IOCFG_FS_MAX_DEVLEN, path, current_fs_name_);
  if (fs_in_path)
    {
      fs = _io_get_fs_by_name (fs_name);
    }
  else if (*fs_name_len)
    {
      fs = current_fs_;
      *fs_name_len = 0;
    }
  else
    {
      errno = EINVAL;
      fs = 0;
    }
  return fs;
}

int
MQX_Filesystem::mkdir (const char *path)
{
  int fs_name_len;
  MQX_FILE_PTR fs = resolve_fs (path, &fs_name_len);
  if (fs == 0) return -1;
  int mqx_error = _io_ioctl (
    fs, IO_IOCTL_CREATE_SUBDIR, (uint32_t*) (path + fs_name_len));
  if (mqx_error != MQX_OK)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return -1;
    }
  return 0;
}

int
MQX_Filesystem::chdir (const char *path)
{
  int fs_name_len;
  MQX_FILE_PTR fs = resolve_fs (path, &fs_name_len);
  if (fs == 0) return -1;
  if (fs != current_fs_) update_fs(fs);
  int mqx_error = _io_ioctl (fs, IO_IOCTL_CHANGE_CURRENT_DIR,
    (uint32_t*) (path + fs_name_len));
  if (mqx_error != MQX_OK)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return -1;
    }
  return 0;
}

int
MQX_Filesystem::rmdir (const char *path)
{
  int fs_name_len;
  MQX_FILE_PTR fs = resolve_fs (path, &fs_name_len);
  if (fs == 0) return -1;
  int mqx_error = _io_ioctl (fs, IO_IOCTL_REMOVE_SUBDIR,
    (uint32_t*) (path + fs_name_len));
  if (mqx_error != MQX_OK)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return -1;
    }
  return 0;
}

int
MQX_Filesystem::unlink (const char *path)
{
  int fs_name_len;
  MQX_FILE_PTR fs = resolve_fs (path, &fs_name_len);
  if (fs == 0) return -1;
  int mqx_error = _io_ioctl (fs, IO_IOCTL_DELETE_FILE,
    (uint32_t*) (path + fs_name_len));
  if (mqx_error != MQX_OK)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return -1;
    }
  return 0;
}

int
MQX_Filesystem::rename (const char *oldpath, const char *newpath)
{
  // TODO: Handle Moving Directories?
  int old_fs_name_len;
  MQX_FILE_PTR fs = resolve_fs (oldpath, &old_fs_name_len);
  int new_fs_name_len;
  MQX_FILE_PTR other_fs = resolve_fs (newpath, &new_fs_name_len);
  if (fs == 0 || other_fs == 0) return -1;
  if (fs != other_fs)
    {
      errno = EXDEV;
      return -1;
    }

  ACE_stat file_status;
  if (this->stat (newpath, &file_status) == 0)
    {
      // New path already exists...
      if (file_status.st_mode & S_IFREG)
        {
          // It's a file, we can delete it.
          if (this->unlink (newpath))
            {
              return -1;
            }
        }
      else if (file_status.st_mode & S_IFDIR)
        {
          // It's a directory, we can't delete that.
          errno = EEXIST;
          return -1;
        }
      else
        {
          // Unknown type, error
          errno = EINVAL;
          return -1;
        }
    }

  MFS_RENAME_PARAM mfs_rename;
  char oldtmp[FS_FILENAME_SIZE];
  strcpy (oldtmp, oldpath + old_fs_name_len);
  mfs_rename.OLD_PATHNAME = oldtmp;
  char newtmp[FS_FILENAME_SIZE];
  strcpy (newtmp, newpath + new_fs_name_len);
  mfs_rename.NEW_PATHNAME = newtmp;

  int mqx_error = _io_ioctl (fs, IO_IOCTL_RENAME_FILE, (uint32_t*) &mfs_rename);
  if (mqx_error != MQX_OK)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return -1;
    }
  return 0;
}

MQX_Filesystem::File *
MQX_Filesystem::get_file (int fd)
{
  for (int i = 0; i < FOPEN_MAX; i++)
    {
      if (files_[i].fd == fd) return &files_[i];
    }
  errno = EBADF;
  return 0;
}

MQX_Filesystem::File *
MQX_Filesystem::get_new_file ()
{
  // Get Unused File Struct
  File *file = get_file (-1);
  if (file != 0)
    {
    file->mqx_file = 0;
    // Get Unused File Descriptor
    for (int fd = last_fd_ + 1; fd != last_fd_; fd++)
      {
        if (get_file (fd) == 0)
          {
            file->fd = fd;
            last_fd_ = fd;
            return file;
          }
        if (fd == max_fd_) fd = 0;
      }
    }
  errno = ENFILE;
  return 0;
}

static inline int
mfs_file_attrs_to_stat_mode (int attributes)
{
  int mode = (attributes & MFS_ATTR_DIR_NAME) ?  S_IFDIR : S_IFREG;
  return mode;
}

int
MQX_Filesystem::stat (const char * path, ACE_stat *statbuf)
{
  if (statbuf == 0)
    {
      errno = EINVAL;
      return -1;
    }

  int fs_name_len;
  MQX_FILE_PTR fs = resolve_fs (path, &fs_name_len);
  if (fs == 0) return -1;

  statbuf->st_size = 0;
  statbuf->st_mtime = 0;
  statbuf->st_mode = 0;
  statbuf->st_nlink = 0;

  MFS_SEARCH_PARAM search;
  search.ATTRIBUTE = MFS_SEARCH_ANY;
  char tmppath[ACE_MQX_ABS_PATH_SIZE];
  strcpy (&tmppath[0], path);
  search.WILDCARD = &tmppath[fs_name_len];
  MFS_SEARCH_DATA search_results;
  search.SEARCH_DATA_PTR = &search_results;
  int mqx_error = _io_ioctl (fs, IO_IOCTL_FIND_FIRST_FILE, (uint32_t *) &search);
  if (mqx_error == MFS_NO_ERROR)
    {
      statbuf->st_size = search_results.FILE_SIZE;
      statbuf->st_mode = mfs_file_attrs_to_stat_mode (search_results.ATTRIBUTE);
      statbuf->st_nlink = 1;
      // TODO: statbuf->st_mtime
      return 0;
    }
  errno = ACE_OS::mqx_error_to_errno (mqx_error);
  return -1;
}

int
MQX_Filesystem::fstat (int fd, ACE_stat *statbuf)
{
  if (statbuf == 0)
    {
      errno = EINVAL;
      return -1;
    }

  File *file = get_file (fd);
  if (file == 0) return -1;

  statbuf->st_size = 0;
  statbuf->st_mtime = 0;
  statbuf->st_mode = 0;
  statbuf->st_nlink = 0;

  if (file->chardev_file)
    {
      statbuf->st_mode &= S_IFCHR;
      return 0;
    }

  int attributes = 0;
  int mqx_error = _io_ioctl (file->mqx_file, IO_IOCTL_GET_FILE_ATTR, (uint32_t *) &attributes);
  if (mqx_error != MQX_OK)
    {
      errno = ACE_OS::mqx_error_to_errno (mqx_error);
      return -1;
    }
  statbuf->st_mode = mfs_file_attrs_to_stat_mode (attributes);
  statbuf->st_nlink = 1;

  // TODO: statbuf->st_mtime

  return 0;
}

/* The following are the function definitions that DLib will use to access MQX
 * IO through MQX_Filesystem.
 */

extern "C" {

int __open (const char *filename, int mode)
{
  return MQX_Filesystem::inst ().open (filename, mode);
}

size_t __read (int handle, unsigned char *buffer, size_t size)
{
  return MQX_Filesystem::inst ().read (handle, buffer, size);
}

size_t __write (int handle, const unsigned char *buffer, size_t size)
{
  return MQX_Filesystem::inst ().write (handle, buffer, size);
}

long __lseek (int handle, long offset, int whence)
{
  return MQX_Filesystem::inst ().lseek (handle, offset, whence);
}

int __close (int handle)
{
  return MQX_Filesystem::inst ().close (handle);
}

} // extern "C"

#endif // ACE_MQX
