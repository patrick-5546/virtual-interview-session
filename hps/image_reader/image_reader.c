#include <stdio.h>
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

   int pixel_num, pixel_val;
   for (pixel_num = 0; pixel_num < 64; ++pixel_num) {
      *IMAGE_READER_ptr = pixel_num; // write the desired pixel to component
      printf("Reading pixel %d\n", *(IMAGE_READER_ptr+3));  // read from nonzero address to see what was written
      pixel_val = *IMAGE_READER_ptr;
      printf("\tPixel value:\t%d\n", pixel_val);
      printf("\tPixel number:\t%d\n", (pixel_val >> 0) & 0xFF);
      printf("\tX coordinate:\t%d\n", (pixel_val >> 16) & 0xFF);
      printf("\tY coordinate:\t%d\n", (pixel_val >>  8) & 0xFF);
      printf("\tY channel:\t%x\n", (pixel_val >>  24) & 0xFF);
      if ((pixel_val & 0xFF) == 0xA9) {
         printf("\n\nhere\n\n");
      }

      // printf("Reading pixel %x\n", *(IMAGE_READER_ptr+3));  // read from nonzero address to see what was written
      // printf("\timg, desiredX, desiredY, saved_value %x\n", *(IMAGE_READER_ptr+0));
      // printf("\t1,200,30,4 %x\n", *(IMAGE_READER_ptr+1));
      // printf("\tsaved_value %x\n", *(IMAGE_READER_ptr+2));
   }

   // printf("saved_value is now %x\n", *(IMAGE_READER_ptr+65));
   // printf("y_channel is now %x\n", *(IMAGE_READER_ptr));
   // printf("y_channel is now %x\n", *(IMAGE_READER_ptr+1));
   // printf("y_channel is now %x\n", *(IMAGE_READER_ptr));

   unmap_physical (LW_virtual, LW_BRIDGE_SPAN);   // release the physical-memory mapping
   close_physical (fd);   // close /dev/mem
   return 0;
}
