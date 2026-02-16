//Syscall stubs for newlib
#include <stdint.h>
#include <sys/types.h>
//typedef long intptr_t;

intptr_t * _sbrk_r(intptr_t incr)
{
    return (void*)-1;
}

void _write_r(intptr_t fd, const void *buf, size_t count)
{
    // Implement write to USB CDC here if needed
}

void _close_r()
{
    // Implement close if needed
}

void _read_r()
{
    // Implement fstat if needed
}

void _lseek_r()
{
    // Implement lseek if needed
}

void _exit(int status)
{
    while (1);
}