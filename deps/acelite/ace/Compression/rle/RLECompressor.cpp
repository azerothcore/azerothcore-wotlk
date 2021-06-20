#include "RLECompressor.h"
#include "ace/OS_NS_string.h"

#if defined (__BORLANDC__) && (__BORLANDC__ >= 0x660) && (__BORLANDC__ <= 0x680)
#  pragma option push -w-8072
#endif

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_RLECompressor::ACE_RLECompressor(void)
    : ACE_Compressor(ACE_COMPRESSORID_RLE)
{
}

ACE_RLECompressor::~ACE_RLECompressor(void)
{
}

// Compress using Run Length Encoding (RLE)
ACE_UINT64
ACE_RLECompressor::compress( const void *in_ptr,
                             ACE_UINT64 in_len,
                             void *out_ptr,
                             ACE_UINT64 max_out_len )
{
    const ACE_Byte *in_p    = static_cast<const ACE_Byte *>(in_ptr);
    ACE_Byte *out_p         = static_cast<ACE_Byte *>(out_ptr);

    ACE_UINT64 src_len      = in_len;  // Save for stats
    ACE_UINT64 out_index    = 0;
    ACE_UINT64 out_base     = 0;
    size_t     run_count    = 0;
    bool       run_code     = false;

    if (in_p && out_p && in_len) {

        while (in_len-- > 0) {

            ACE_Byte cur_byte = *in_p++;

            switch (out_index ? run_count : 128U) {  // BootStrap to 128

            case 128:

                if ((out_base = out_index++) >= max_out_len) {
                    return ACE_UINT64(-1);      // Output Exhausted
                }
                run_code  = false;
                run_count = 0; // Switch off compressing

                // Fall Through

            default:

                // Fix problem where input exhaused but maybe compressing
                if (in_len ? cur_byte == *in_p : run_code) {

                    if (run_code) {             // In Compression?
                        out_p[out_base] = ACE_Byte(run_count++ | 0x80);
                        continue;               // Stay in Compression
                    } else if (run_count) {     // Xfering to Compression
                        if ((out_base = out_index++) >= max_out_len) {
                            return ACE_UINT64(-1); // Output Exhausted
                        }
                        run_count = 0;
                    }
                    run_code  = true;           // We Are Now Compressing

                } else if (run_code) {          // Are we in Compression?
                    // Finalise the Compression Run Length
                    out_p[out_base] = ACE_Byte(run_count | 0x80);
                    // Reset for Uncmpressed
                    if (in_len && (out_base = out_index++) >= max_out_len) {
                        return ACE_UINT64(-1);  // Output Exhausted
                    }
                    run_code    = false;
                    run_count   = 0;
                    continue;   // Now restart Uncompressed
                }

                break;
            }

            out_p[out_base] = ACE_Byte(run_count++ | (run_code ? 0x80 : 0));

            if (out_index >= max_out_len) {
                return ACE_UINT64(-1);          // Output Exhausted
            }
            out_p[out_index++] = cur_byte;
        }
        this->update_stats(src_len, out_index);
    }

    return out_index;  // return as our output length
}

// Decompress using Run Length Encoding (RLE)
ACE_UINT64
ACE_RLECompressor::decompress( const void *in_ptr,
                               ACE_UINT64 in_len,
                               void *out_ptr,
                               ACE_UINT64 max_out_len )
{
    ACE_UINT64  out_len     = 0;

    const ACE_Byte *in_p    = static_cast<const ACE_Byte *>(in_ptr);
    ACE_Byte *out_p         = static_cast<ACE_Byte *>(out_ptr);

    if (in_p && out_p) while(in_len-- > 0) {

        ACE_Byte    cur_byte    = *in_p++;
        ACE_UINT32  cpy_len     = ACE_UINT32((cur_byte & ACE_CHAR_MAX) + 1);

        if (cpy_len > max_out_len) {
            return ACE_UINT64(-1); // Output Exhausted
        } else if ((cur_byte & 0x80) != 0) {  // compressed
            if (in_len-- > 0) {
                ACE_OS::memset(out_p, *in_p++, cpy_len);
            } else {
                return ACE_UINT64(-1); // Output Exhausted
            }
        } else if (in_len >= cpy_len) {
            ACE_OS::memcpy(out_p, in_p, cpy_len);
            in_p    += cpy_len;
            in_len  -= cpy_len;
        } else {
            return ACE_UINT64(-1); // Output Exhausted
        }

        out_p       += cpy_len;
        max_out_len -= cpy_len;
        out_len     += cpy_len;
    }

    return out_len;
}

ACE_SINGLETON_TEMPLATE_INSTANTIATE(ACE_Singleton, ACE_RLECompressor, ACE_SYNCH_MUTEX);

// Close versioned namespace, if enabled by the user.
ACE_END_VERSIONED_NAMESPACE_DECL

#if defined (__BORLANDC__) && (__BORLANDC__ >= 0x660) && (__BORLANDC__ <= 0x680)
# pragma option pop
#endif
