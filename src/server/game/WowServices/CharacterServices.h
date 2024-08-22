/****************************************************************************
*
*   CharacterServices.h
*
***/
#ifndef  _CHARACTERSERVICES_H
#define  _CHARACTERSERVICES_H

enum CHARACTER_FLAGS {
  CHARACTER_NONE             = NULL,
  CHARACTER_UNK1             = 0x1,
  CHARACTER_UNK2             = 0x2,
  CHARACTER_LOCKED_FOR_TRANSFER   = 0x4,
  CHARACTER_UNK4             = 0x8,
  CHARACTER_UNK5             = 0x10,
  CHARACTER_UNK6             = 0x20,
  CHARACTER_UNK7             = 0x40,
  CHARACTER_UNK8             = 0x80,
  CHARACTER_UNK9             = 0x100,
  CHARACTER_UNK10            = 0x200,
  CHARACTER_HIDE_HELM        = 0x400,
  CHARACTER_HIDE_CLOAK       = 0x800,
  CHARACTER_UNK13            = 0x1000,
  CHARACTER_GHOST            = 0x2000,
  CHARACTER_RENAME           = 0x4000,
  CHARACTER_UNK16            = 0x8000,
  CHARACTER_UNK17            = 0x10000,
  CHARACTER_UNK18            = 0x20000,
  CHARACTER_UNK19            = 0x40000,
  CHARACTER_UNK20            = 0x80000,
  CHARACTER_UNK21            = 0x100000,
  CHARACTER_UNK22            = 0x200000,
  CHARACTER_UNK23            = 0x400000,
  CHARACTER_UNK24            = 0x800000,
  CHARACTER_LOCKED_BY_BILLING  = 0x1000000,
  CHARACTER_DECLINED         = 0x2000000,
  CHARACTER_UNK27            = 0x4000000,
  CHARACTER_UNK28            = 0x8000000,
  CHARACTER_UNK29            = 0x10000000,
  CHARACTER_UNK30            = 0x20000000,
  CHARACTER_UNK31            = 0x40000000,
  CHARACTER_UNK32            = 0x80000000
};

enum CHAR_CUSTOMIZE_FLAGS {
  CHAR_CUSTOMIZE_NONE           = NULL,
  CHAR_CUSTOMIZE_CUSTOMIZE      = 0x1,
  CHAR_CUSTOMIZE_FLAG_FACTION   = 0x10000,
  CHAR_CUSTOMIZE_FLAG_RACE      = 0x100000
};

#endif// _CHARACTERSERVICES_H