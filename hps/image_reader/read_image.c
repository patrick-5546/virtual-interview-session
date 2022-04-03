#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "address_map_arm.h"

// Open /dev/mem, if not already done, to give access to physical addresses
int open_physical (int fd)
{
   if (fd == -1)
      if ((fd = open( "/dev/mem", (O_RDWR | O_SYNC))) == -1)
      {
         printf ("ERROR: could not open \"/dev/mem\"...\n");
         return (-1);
      }
   return fd;
}

// Close /dev/mem to give access to physical addresses
void close_physical (int fd)
{
   close (fd);
}

/*
 * Establish a virtual address mapping for the physical addresses starting at base, and
 * extending by span bytes.
 */
void* map_physical(int fd, unsigned int base, unsigned int span)
{
   void *virtual_base;

   // Get a mapping from physical addresses to virtual addresses
   virtual_base = mmap (NULL, span, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, base);
   if (virtual_base == MAP_FAILED)
   {
      printf ("ERROR: mmap() failed...\n");
      close (fd);
      return (NULL);
   }
   return virtual_base;
}

/*
 * Close the previously-opened virtual address mapping
 */
int unmap_physical(void * virtual_base, unsigned int span)
{
   if (munmap (virtual_base, span) != 0)
   {
      printf ("ERROR: munmap() failed...\n");
      return (-1);
   }
   return 0;
}

// to compile for the python wrapper, run:
// cc -fPIC -shared -o test.so read_image.c
int * read_image(void)
{
   int * img = (int *)malloc(sizeof(int) * 50176);  // Allocate space to store image

   volatile int * IMAGE_READER_ptr;   // virtual address pointer to image_reader qsys component
   int fd = -1;               // used to open /dev/mem for access to physical addresses
   void *LW_virtual;          // used to map physical addresses for the light-weight bridge

   // Create virtual memory access to the FPGA light-weight bridge
   if ((fd = open_physical (fd)) == -1)
      return img;
   if ((LW_virtual = map_physical (fd, LW_BRIDGE_BASE, LW_BRIDGE_SPAN)) == NULL)
      return img;

   // Set virtual address pointer to I/O port
   IMAGE_READER_ptr = (unsigned int *) (LW_virtual + IMAGE_READER_BASE);

   // save an arbitrary value
   *IMAGE_READER_ptr = 21;
   int i;
   for (i = 0; i < 50176; i += 2)
      memcpy(img + i, (const void *)IMAGE_READER_ptr, 8);

   // int strip_num, block_num, addr;
   // for (strip_num = 0; strip_num < 28; ++strip_num) {
   //    for (block_num = 0; block_num < 28; ++block_num) {
   //       *IMAGE_READER_ptr = (strip_num << 16) & block_num;

   //       for (addr = 0; addr < 1; ++addr)
   //          memcpy(img_ptr + strip*224 + block_num, (const void *)(IMAGE_READER_ptr + addr), 1024);
   //    }
   // }

   unmap_physical (LW_virtual, LW_BRIDGE_SPAN);   // release the physical-memory mapping
   close_physical (fd);   // close /dev/mem

   return img;
}

int main() {
   int * img = read_image();
   printf("saved_value is now %x\n", img[1]);
   printf("y_channel is now %x\n", img[0]);

   return 0;
}
