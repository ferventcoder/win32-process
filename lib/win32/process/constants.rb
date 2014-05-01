require 'ffi'

module Process::Constants
  include FFI::Library

  private

  # Priority constants

  ABOVE_NORMAL_PRIORITY_CLASS = 0x0008000
  BELOW_NORMAL_PRIORITY_CLASS = 0x0004000
  HIGH_PRIORITY_CLASS         = 0x0000080
  IDLE_PRIORITY_CLASS         = 0x0000040
  NORMAL_PRIORITY_CLASS       = 0x0000020
  REALTIME_PRIORITY_CLASS     = 0x0000010

  # Error constants

  INVALID_HANDLE_VALUE = FFI::Pointer.new(-1).address
  ERROR_ACCESS_DENIED  = 0x00000005

  # Process Access Rights

  PROCESS_TERMINATE         = 0x00000001
  PROCESS_SET_INFORMATION   = 0x00000200
  PROCESS_QUERY_INFORMATION = 0x00000400
  PROCESS_ALL_ACCESS        = 0x001F0FFF
  PROCESS_VM_READ           = 0x00000010

  # Process wait time for Process.kill

  INFINITE = 0xFFFFFFFF

  # Process creation flags

  CREATE_BREAKAWAY_FROM_JOB        = 0x01000000
  CREATE_DEFAULT_ERROR_MODE        = 0x04000000
  CREATE_NEW_CONSOLE               = 0x00000010
  CREATE_NEW_PROCESS_GROUP         = 0x00000200
  CREATE_NO_WINDOW                 = 0x08000000
  CREATE_PROTECTED_PROCESS         = 0x00040000
  CREATE_PRESERVE_CODE_AUTHZ_LEVEL = 0x02000000
  CREATE_SEPARATE_WOW_VDM          = 0x00000800
  CREATE_SHARED_WOW_VDM            = 0x00001000
  CREATE_SUSPENDED                 = 0x00000004
  CREATE_UNICODE_ENVIRONMENT       = 0x00000400
  DEBUG_ONLY_THIS_PROCESS          = 0x00000002
  DEBUG_PROCESS                    = 0x00000001
  DETACHED_PROCESS                 = 0x00000008
  INHERIT_PARENT_AFFINITY          = 0x00010000

  STARTF_USESHOWWINDOW    = 0x00000001
  STARTF_USESIZE          = 0x00000002
  STARTF_USEPOSITION      = 0x00000004
  STARTF_USECOUNTCHARS    = 0x00000008
  STARTF_USEFILLATTRIBUTE = 0x00000010
  STARTF_RUNFULLSCREEN    = 0x00000020
  STARTF_FORCEONFEEDBACK  = 0x00000040
  STARTF_FORCEOFFFEEDBACK = 0x00000080
  STARTF_USESTDHANDLES    = 0x00000100
  STARTF_USEHOTKEY        = 0x00000200
  STARTF_TITLEISLINKNAME  = 0x00000800
  STARTF_TITLEISAPPID     = 0x00001000
  STARTF_PREVENTPINNING   = 0x00002000

  LOGON_WITH_PROFILE        = 0x00000001
  LOGON_NETCREDENTIALS_ONLY = 0x00000002

  SHUTDOWN_NORETRY = 0x00000001

  # Security

  TokenUser   = 1
  TOKEN_QUERY = 0x00000008

  # Define these for Windows. They are not actually used but are defined
  # for interface compatibility.

  PRIO_PROCESS = 0
  PRIO_PGRP    = 1
  PRIO_USER    = 2

  # Define these for Windows

  RLIMIT_CPU    = 0 # PerProcessUserTimeLimit
  RLIMIT_FSIZE  = 1 # Hard coded at 4TB - 64K (assumes NTFS)
  RLIMIT_AS     = 5 # ProcessMemoryLimit
  RLIMIT_RSS    = 5 # ProcessMemoryLimit
  RLIMIT_VMEM   = 5 # ProcessMemoryLimit

  # Job constants

  JOB_OBJECT_SET_ATTRIBUTES       = 0x00000002
  JOB_OBJECT_QUERY                = 0x00000004
  JOB_OBJECT_LIMIT_PROCESS_TIME   = 0x00000002
  JOB_OBJECT_LIMIT_PROCESS_MEMORY = 0x00000100
  JobObjectExtendedLimitInformation = 9

  # Console Events

  CTRL_C_EVENT     = 0
  CTRL_BREAK_EVENT = 1

  # Miscellaneous

  HANDLE_FLAG_INHERIT     = 0x00000001
  SEM_FAILCRITICALERRORS  = 0x00000001
  SEM_NOGPFAULTERRORBOX   = 0x00000002

  # GetExitCodeProcess

  STILL_ACTIVE = 259

  # Hide

  SECTION_MAP_WRITE   = 0x0002
  SECTION_MAP_READ    = 0x0004
  FILE_MAP_WRITE   = 0x0002
  FILE_MAP_READ    = 0x0004

  STATUS_ACCESS_DENIED = 0xC0000022
  READ_CONTROL = 0x00020000
  WRITE_DAC = 0x00040000

  SE_KERNEL_OBJECT = 6
  DACL_SECURITY_INFORMATION  = 4

  ERROR_SUCCESS = 0
end
