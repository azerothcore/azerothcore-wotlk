/**
 * @file MQX_Filesystem.h
 *
 * @author Frederick Hornsey <hornseyf@objectcomputing.com>
 */

#ifndef MQX_FILESYSTEM_HEADER
#define MQX_FILESYSTEM_HEADER

#include "ace/config-all.h"

#ifdef ACE_MQX

#include <mqx.h>
#include <fio.h>

#if !defined (FOPEN_MAX)
# define FOPEN_MAX 20
#endif

#if !defined (ACE_MQX_DLIB_FULL)
# undef read
# undef write
#endif

struct stat;
typedef struct stat ACE_stat;

#define ACE_MQX_ABS_PATH_SIZE (IOCFG_FS_MAX_DEVLEN + FS_FILENAME_SIZE - 1)

/**
 * Since MQX has an unusual filesystem API, this class is provided to try to
 * normalize it by managing the current working directory on a global context
 * instead of a device by device context provided by MQX. It also tries to make
 * these functions act more like their UNIX counterparts to some extent.
 *
 * This class is also the interface between the DLib IO functions and MQX file
 * IO. It does this by implementing the classic UNIX IO functions below.
 *
 * WARNING: This is already being done in the ACE_TMAIN macro, but
 * complete_initialization() should be called before using DLib or ACE file IO
 * functions, but after MQX has been initialized. Either way, standard streams
 * will not work properly, or some other behavior depending on the what
 * functions are called in what order.
 */
class MQX_Filesystem {
public:
  /// Get the singleton instance of the class
  inline static MQX_Filesystem &inst() {
    return instance_;
  }

  /**
   * Initialize the Standard Streams and the Current Filesystem
   *
   * This must be done after MQX has been initialized. See warning in class
   * documenting comment.
   */
  void complete_initialization ();

  /**
   * Attempt to reset the cwd state by asking MQX for the first valid filesystem
   * and "cd-ing" into the root of it.
   */
  bool reset_state ();

  /**
   * @name Unix-like File Functions
   *
   * Classic UNIX-like Operations Implemented for for DLib
   */
  ///@{
  /**
   * Open a file and return the file descriptor.
   *
   * Returns the file descriptor if successful, -1 otherwise.
   *
   * Known Limitations:
   *  - Mode is being converted from DLib Unix-like mode to MQX cstdlib mode.
   *    This is not perfected yet and is limited by the common denominator of
   *    what is supported by both systems.
   */
  int open (const char *path, int mode);
  int close (int fd);
  size_t read (int fd, unsigned char *buffer, size_t size);
  size_t write (int fd, const unsigned char *buffer, size_t size);
  long lseek (int fd, long offset, int whence);
  ///@}

  /**
   * @name Unix-like Filesystem Functions
   */
  ///@{
  /**
   * Put the current directory path in buf of size.
   *
   * Returns NULL if an error occurred, otherwise buf.
   */
  char *getcwd (char *buf, size_t size);

  /**
   * Create a directory at path.
   *
   * Returns -1 if an error occurred, otherwise 0.
   */
  int mkdir (const char *path);

  /**
   * Change to the directory at path.
   *
   * Returns -1 if an error occurred, otherwise 0.
   */
  int chdir (const char *path);

  /**
   * Remove the empty directory at path.
   *
   * Returns -1 if an error occurred, otherwise 0.
   */
  int rmdir (const char *path);

  /**
   * Unlink the file at path.
   *
   * Returns -1 if an error occurred, otherwise 0.
   */
  int unlink (const char *path);

  /**
   * Rename or move the file or rename the directory from newpath to oldpath.
   *
   * Returns -1 if an error occurred, otherwise 0.
   *
   * As standard rename does, this sets errno to EXDEV if you try to move a
   * file across filesystems. It also overwrites regular files that occupy the
   * new path.
   *
   * Known Limitations:
   *   - Can only rename directories, will refuse to move them. This is MFS's
   *     IO_IOCTL_RENAME_FILE refusing to do this. This could be implemented by
   *     the function, but would involve either manually copying the file tree
   *     or refusing to move nonempty directories.
   */
  int rename (const char *oldpath, const char *newpath);

  /**
   * Get status of file given by path.
   *
   * Returns -1 if an error occurred, otherwise 0.
   *
   * Known Limitations:
   *   - st_mtime is currently not implemented and is set to 0.
   *   - st_mode is limited to
   *     - S_IFDIR: file is a directory
   *     - S_IFREG: file is a regular file
   */
  int stat (const char * path, ACE_stat *statbuf);

  /**
   * Get status of file given by file descriptor.
   *
   * Returns -1 if an error occurred, otherwise 0.
   *
   * Known Limitations:
   *   - st_mtime is currently not implemented and returns 0
   *   - In MFS there seems to be no direct way to get st_msize from a MQX file
   *     alone. The only way to get a file size using the documented API seems
   *     to be IO_IOCTL_FIND_FIRST_FILE, which requires the path. For now this
   *     will be set to 0.
   *   - st_mode is limited to
   *     - S_IFDIR: file is a directory
   *     - S_IFREG: file is a regular file
   *     - S_IFCHR: file is a special character device file, (e.g. ACE_STDOUT)
   */
  int fstat (int fd, ACE_stat *statbuf);
  ///@}

private:
  /// The singleton instance of the class
  static MQX_Filesystem instance_;

  MQX_Filesystem();

  /**
   * @name Current Filesystem for resolving relative paths.
   */
  ///@{
  MQX_FILE_PTR current_fs_;
  char current_fs_name_[IOCFG_FS_MAX_DEVLEN];
  unsigned current_fs_name_len_;
  ///@}

  /**
   * @name Manage open files using file descriptors.
   */
  ///@{
  struct File {
    /// DLib File Descriptor. Invalid if -1.
    int fd;
    /// MQX File
    MQX_FILE_PTR mqx_file;
    /// Mark this as special character device file (Standard Streams)
    bool chardev_file;
  };
  File files_[FOPEN_MAX];

  /**
   * Last file descriptor created.
   */
  int last_fd_;

  /**
   * Max VALUE for File Descriptors.
   *
   * NOTE: Max open file count is FOPEN_MAX, defined by DLib. This creates a
   * limit on the number of unique file descriptor values.
   */
  int max_fd_;

  /**
   * Get a File struct for the file descriptor.
   *
   * Returns NULL and sets EBADF if no such file exists
   */
  File *get_file (int fd);

  /**
   * Get a File struct pointer to use for a new file.
   *
   * Returns NULL and sets ENFILE if exceeded max number of open files.
   */
  File *get_new_file ();
  ///@}

  /**
   * Check to see if the current filesystem is valid, if not reset it.
   *
   * Returns true if reseting failed, otherwise false. Failure would probably
   * mean no filesystems are mounted.
   */
  bool check_state ();

  /**
   * Set the supplied pointer as the filesystem of the current working
   * directory.
   */
  void update_fs (MQX_FILE_PTR fs);

  /**
   * Resolve the filesystem of the supplied path and return it.
   *
   * This will be the filesystem of the current working directory if the path
   * is relative. Sets the fs_name_len to the length of the device name in the
   * path. This would be 0 if the path is relative.
   */
  MQX_FILE_PTR resolve_fs (const char *path, int *fs_name_len);
};

#endif // ACE_MQX
#endif // MQX_FILESYSTEM_HEADER
