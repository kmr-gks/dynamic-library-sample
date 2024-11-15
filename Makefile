# Compiler
#FC = ifort
FC = mpiifort
#FC = gfortran

# Compiler flags
CFLAGS = -O2
LDFLAGS = -shared
LIBFLAGS = -fPIC

# Targets
all: libb_dlib.so main_program

# Static library from c_slib.f90
libc_slib.a: c_slib.o
	ar rcs libc_slib.a c_slib.o

c_slib.o: c_slib.f90
	$(FC) $(CFLAGS) $(LIBFLAGS) -c c_slib.f90 -o c_slib.o

# Dynamic library from b_dlib.f90, which uses c_module
libb_dlib.so: b_dlib.o libc_slib.a
	$(FC) $(LDFLAGS) -o libb_dlib.so b_dlib.o libc_slib.a

b_dlib.o: b_dlib.f90 c_slib.o
	$(FC) $(CFLAGS) $(LIBFLAGS) -c b_dlib.f90 -o b_dlib.o

# Executable main_program, which uses libb_dlib.so
main_program: main_program.o
	$(FC) -o main_program main_program.o -L. -lb_dlib

main_program.o: main_program.f90
	$(FC) $(CFLAGS) -c main_program.f90 -o main_program.o

# Clean up object files, libraries, and executables
clean:
	rm -f *.o *.mod *.a *.so main_program
