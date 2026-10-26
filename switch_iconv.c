#include <stddef.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

typedef void* iconv_t;

iconv_t iconv_open(const char *tocode, const char *fromcode)
{
    (void)tocode; (void)fromcode;
    return (iconv_t)1;
}

int iconv_close(iconv_t cd)
{
    (void)cd;
    return 0;
}

size_t iconv(iconv_t cd, char **inbuf, size_t *inbytesleft, char **outbuf, size_t *outbytesleft)
{
    (void)cd;
    if (!inbuf || !*inbuf) return 0;
    
    size_t transferred = 0;
    while (*inbytesleft > 0 && *outbytesleft > 0) {
        **outbuf = **inbuf;
        (*inbuf)++;
        (*outbuf)++;
        (*inbytesleft)--;
        (*outbytesleft)--;
        transferred++;
    }
    if (*inbytesleft > 0) {
        errno = E2BIG;
        return (size_t)-1;
    }
    return transferred;
}
