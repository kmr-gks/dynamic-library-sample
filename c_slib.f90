module c_module
  implicit none
  integer :: shared_variable = 42

contains

  subroutine c_subroutine()
    print *, "This is c_subroutine from c_module."
    print *, "shared_variable in c_module:", shared_variable
  end subroutine c_subroutine

end module c_module
