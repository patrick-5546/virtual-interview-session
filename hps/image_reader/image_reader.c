#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

#define IMAGE_READER_BASE      0x00000000
#define LW_BRIDGE_BASE         0xFF200000
#define LW_BRIDGE_SPAN         0x00005000

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

int main(void)
{
   volatile int * IMAGE_READER_ptr;   // virtual address pointer to red LEDs

   int fd = -1;               // used to open /dev/mem for access to physical addresses
   void *LW_virtual;          // used to map physical addresses for the light-weight bridge

   // Create virtual memory access to the FPGA light-weight bridge
   if ((fd = open_physical (fd)) == -1)
      return (-1);
   if ((LW_virtual = map_physical (fd, LW_BRIDGE_BASE, LW_BRIDGE_SPAN)) == NULL)
      return (-1);

   // Set virtual address pointer to I/O port
   IMAGE_READER_ptr = (unsigned int *) (LW_virtual + IMAGE_READER_BASE);

   int i;
   int *num, *x, *y, *val;
   int pixel[4];
   num = pixel + 3;
   x = pixel + 2;
   y = pixel + 1;
   val = pixel;

   // first 64 bits of second row
   for (i = 0; i < 64; ++i) {
      *IMAGE_READER_ptr = i + 224; // write the desired pixel to component
      memcpy(pixel, (const void *)IMAGE_READER_ptr, sizeof(int) * 4);
      printf("Y channel of pixel %d (%d, %d): %x\n", *num, *x, *y, *val);
   }

   // last 64 bits of second last row
   for (i = 0; i < 64; ++i) {
      *IMAGE_READER_ptr = i + 224*223 - 64; // write the desired pixel to component
      memcpy(pixel, (const void *)IMAGE_READER_ptr, sizeof(int) * 4);
      printf("Y channel of pixel %d (%d, %d): %x\n", *num, *x, *y, *val);
   }

   int j;
   *IMAGE_READER_ptr = 225; // write the desired pixel to component
   for (j = 0; j < 4; ++j) {
      memcpy(pixel, (const void *)IMAGE_READER_ptr, sizeof(int) * 4);
      printf("Y channel of pixel %d (%d, %d): %x\n", *num, *x, *y, *val);
   }
   *IMAGE_READER_ptr = 224*224; // write out of bounds pixel to resume the registering of pixels
   sleep(1);
   *IMAGE_READER_ptr = 225; // write the desired pixel to component
   for (j = 0; j < 4; ++j) {
      memcpy(pixel, (const void *)IMAGE_READER_ptr, sizeof(int) * 4);
      printf("Y channel of pixel %d (%d, %d): %x\n", *num, *x, *y, *val);
   }

   unmap_physical (LW_virtual, LW_BRIDGE_SPAN);   // release the physical-memory mapping
   close_physical (fd);   // close /dev/mem
   return 0;
}
