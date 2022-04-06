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

struct pixel {
   unsigned int y_channel;
   unsigned int upperLeftY;
   unsigned int upperLeftX;
   unsigned int blockUpperLeft;
   unsigned int desiredY;
   unsigned int desiredX;
   unsigned int block_ind;
   unsigned int pixel_in_bounding_box;
   unsigned int desired_pixel_in_bounding_box;
   unsigned int desired_pixel;
};

struct pixel update_pixel(struct pixel p, volatile int *IMAGE_READER_ptr)
{
   int values[4];
   memcpy(values, (const void *)IMAGE_READER_ptr, sizeof(int) * 4);

   p.y_channel = values[0];

   p.upperLeftY = values[1] & 0xFF;
   p.upperLeftX = (values[1] >> 8) & 0xFF;
   p.blockUpperLeft = (values[1] >> 16) & 0xFF;

   p.desiredY = values[2] & 0xFF;
   p.desiredX = (values[2] >> 8) & 0xFF;
   p.block_ind = (values[2] >> 16) & 0xFF;
   p.pixel_in_bounding_box = (values[2] >> 24) & 0x1;
   p.desired_pixel_in_bounding_box = (values[2] >> 25) & 0x1;

   p.desired_pixel = values[3];

   return p;
}

/*
 * Print internal values for debugging purposes
 */
void debug_pixel(struct pixel p)
{
   printf("Values for pixel %u (%u, %u):\n", p.desired_pixel, p.desiredX, p.desiredY);
   printf("\tBlock upper left %u (%u, %u)\n", p.blockUpperLeft, p.upperLeftX, p.upperLeftY);
   printf("\tBlock index %u\n", p.block_ind);
   printf("\tdpibb %u, pibb %u\n", p.desired_pixel_in_bounding_box, p.pixel_in_bounding_box);
   printf("\tY channel %x\n", p.y_channel);
}

/*
 * Print pixel
 */
void printp(struct pixel p)
{
   printf("Pixel %u (%u, %u) has a y channel of %u\n", p.desired_pixel, p.desiredX, p.desiredY, p.y_channel);
}

/*
 * Test the functionality of the image reader component
 */
void test(volatile int *IMAGE_READER_ptr)
{
   int i, starting_pixel, desired_pixel, out_of_bounds_pixel;
   struct pixel p;

   printf("Testing the functionality of the image reader component\n");

   printf("Read the first 64 bits of second row\n");
   starting_pixel = 0;
   for (i = starting_pixel; i < starting_pixel + 64; ++i) {
      *IMAGE_READER_ptr = i; // write the desired pixel to component
      p = update_pixel(p, IMAGE_READER_ptr);
      printp(p);
   }

   printf("\nRead the last 64 bits of second last row");
   starting_pixel = 224*223 - 64;
   for (i = starting_pixel; i < starting_pixel + 64; ++i) {
      *IMAGE_READER_ptr = i; // write the desired pixel to component
      p = update_pixel(p, IMAGE_READER_ptr);
      printp(p);
   }

   printf("\nTest the pausing and resuming the updating of pixel values");
   desired_pixel = 8;
   out_of_bounds_pixel = 224*224;
   *IMAGE_READER_ptr = desired_pixel; // write the desired pixel to component
   p = update_pixel(p, IMAGE_READER_ptr);
   printf("Reading from pixel %d\n", desired_pixel);
   for (i = 0; i < 4; ++i) {
      p = update_pixel(p, IMAGE_READER_ptr);
      printp(p);
   }
   printf("Sleeping for 1 second\n");
   sleep(1);
   printf("Reading from pixel %d (should have same value as before)\n", desired_pixel);
   for (i = 0; i < 4; ++i) {
      p = update_pixel(p, IMAGE_READER_ptr);
      printp(p);
   }
   printf("Writing out of bounds pixel to resume updating pixel values\n");
   *IMAGE_READER_ptr = out_of_bounds_pixel;
   p = update_pixel(p, IMAGE_READER_ptr);
   printf("Sleeping for 1 second\n");
   sleep(1);
   *IMAGE_READER_ptr = desired_pixel; // write the desired pixel to component
   p = update_pixel(p, IMAGE_READER_ptr);
   printf("Reading from pixel %d (might have different value than before\n", desired_pixel);
   for (i = 0; i < 4; ++i) {
      p = update_pixel(p, IMAGE_READER_ptr);
      printp(p);
   }
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

   test(IMAGE_READER_ptr);

   printf("\nWriting out of bounds pixel to resume updating pixel values\n");
   *IMAGE_READER_ptr = 224*224;

   unmap_physical (LW_virtual, LW_BRIDGE_SPAN);   // release the physical-memory mapping
   close_physical (fd);   // close /dev/mem
   return 0;
}
