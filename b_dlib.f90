module b_module
  use c_module
  implicit none

contains

  subroutine b_subroutine()
    print *, "This is b_subroutine from b_module."
    call c_subroutine()
    print *, "shared_variable in b_module:", shared_variable
  end subroutine b_subroutine

end module b_module
