/*****************************************************************************/
/* huffman.h                              Copyright (c) Ladislav Zezula 2003 */
/*---------------------------------------------------------------------------*/
/* Adaptive Huffmann coding (FGK variant) for MPQ archives                  */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* xx.xx.xx  1.00  Lad  The first version of huffman.h                       */
/* 03.05.03  2.00  Lad  Added compression                                    */
/* 08.12.03  2.01  Dan  High-memory handling (> 0x80000000)                  */
/*****************************************************************************/

#ifndef __HUFFMAN_H__
#define __HUFFMAN_H__

//-----------------------------------------------------------------------------
// Defines

#define DATA_TYPE_SPARSE        0x00
#define DATA_TYPE_BINARY        0x01
#define DATA_TYPE_TEXT          0x02
#define DATA_TYPE_GENERAL       0x03
#define DATA_TYPE_ADPCM_4       0x04
#define DATA_TYPE_ADPCM_6       0x05
#define DATA_TYPE_STEREO_3      0x06
#define DATA_TYPE_STEREO_4      0x07
#define DATA_TYPE_STEREO_5      0x08

#define LINK_ITEM_COUNT         128        // Maximum number of quick-link items
#define BYTE_ITEM_COUNT         258        // Number of items-by-byte
#define HUFF_ITEM_COUNT         515        // Number of items in the item pool

//-----------------------------------------------------------------------------
// Structures and classes

// Input stream for Huffmann decompression
class TInputStream
{
    public:

    TInputStream(void * pvInBuffer, size_t cbInBuffer);
    bool Get1Bit(unsigned int & BitValue);
    bool Get8Bits(unsigned int & ByteValue);
    bool Peek7Bits(unsigned int & Value);
    void SkipBits(unsigned int BitCount);

    unsigned char * pbInBufferEnd;      // End position in the input buffer
    unsigned char * pbInBuffer;         // Current position in the input buffer
    unsigned int BitBuffer;             // Input bit buffer
    unsigned int BitCount;              // Number of bits remaining in 'BitBuffer'
};


// Output stream for Huffmann compression
class TOutputStream
{
    public:

    TOutputStream(void * pvOutBuffer, size_t cbOutLength);
    void PutBits(unsigned int dwValue, unsigned int nBitCount);
    void Flush();

    unsigned char * pbOutBufferEnd;     // End position in the output buffer
    unsigned char * pbOutBuffer;        // Current position in the output buffer
    unsigned int BitBuffer;             // Bit buffer
    unsigned int BitCount;              // Number of bits in the bit buffer
};

// The list head sentinel - an actual THTreeItem embedded in THuffmannTree.
// Its pNext serves as "pFirst" (highest weight) and pPrev as "pLast" (lowest weight).
#define LIST_HEAD()  (&ListHead)

enum TInsertPoint
{
    InsertAfter = 1,
    InsertBefore = 2
};

// Huffmann tree item
struct THTreeItem
{
    THTreeItem()    { pPrev = pNext = NULL; DecompressedValue = 0; Weight = 0; pParent = pChildLo = NULL; }
//  ~THTreeItem()   { RemoveItem(); }

    void         RemoveItem();
//  void         RemoveEntry();

    THTreeItem  * pNext;                // Pointer to lower-weight tree item
    THTreeItem  * pPrev;                // Pointer to higher-weight item
    unsigned int  DecompressedValue;    // Decompressed byte value (also index in the array)
    unsigned int  Weight;               // Weight
    THTreeItem  * pParent;              // Pointer to parent item (NULL if none)
    THTreeItem  * pChildLo;             // Pointer to the lower-weight child ("left child")
};


// Structure used for quick navigating in the huffmann tree.
// Allows skipping up to 7 bits in the compressed stream, thus
// decompressing a bit faster. Sometimes it can even get the decompressed
// byte directly.
struct TQuickLink
{
    unsigned int ValidValue;            // If greater than THuffmannTree::MinValidValue, the entry is valid
    unsigned int ValidBits;             // Number of bits that are valid for this item link
    union
    {
        THTreeItem  * pItem;            // Pointer to the item within the Huffmann tree
        unsigned int DecompressedValue; // Value for direct decompression
    };
};


// Adaptive Huffmann tree (FGK variant). The tree is initialized with
// pre-computed weight tables and rebalanced after every symbol to
// maintain the sibling property
class THuffmannTree
{
    public:

    THuffmannTree(bool bCompression);
    ~THuffmannTree();

    void  LinkTwoItems(THTreeItem * pItem1, THTreeItem * pItem2);
    void  InsertItem(THTreeItem * item, TInsertPoint InsertPoint, THTreeItem * item2);

    THTreeItem * FindHigherOrEqualItem(THTreeItem * pItem, unsigned int Weight);
    THTreeItem * CreateNewItem(unsigned int DecompressedValue, unsigned int Weight, TInsertPoint InsertPoint);

    unsigned int FixupItemPosByWeight(THTreeItem * pItem, unsigned int MaxWeight);
    bool  BuildTree(unsigned int DataType);

    void  IncWeightsAndRebalance(THTreeItem * pItem);
    bool  InsertNewBranchAndRebalance(unsigned int Value1, unsigned int Value2);

    void  EncodeOneByte(TOutputStream * os, THTreeItem * pItem);
    unsigned int DecodeOneByte(TInputStream * is);

    unsigned int Compress(TOutputStream * os, void * pvInBuffer, int cbInBuffer, int DataType);
    unsigned int Decompress(void * pvOutBuffer, unsigned int cbOutLength, TInputStream * is);

    THTreeItem   ItemBuffer[HUFF_ITEM_COUNT];   // Buffer for tree items. No memory allocation is needed
    unsigned int ItemsUsed;                     // Number of tree items used from ItemBuffer

    // Sentinel node for the linear item list (doubly-linked, circular).
    // ListHead.pNext = highest weight item, ListHead.pPrev = lowest weight item
    THTreeItem   ListHead;

    THTreeItem * ItemsByByte[BYTE_ITEM_COUNT];  // Array of item pointers, one for each possible byte value
    TQuickLink   QuickLinks[LINK_ITEM_COUNT];   // Array of quick-link items

    unsigned int MinValidValue;                 // A minimum value of TQDecompress::ValidValue to be considered valid
    bool bIsSparseData;                         // True if sparse data
};

#endif // __HUFFMAN_H__
