module Process::Constants
  # Priority constants
  ABOVE_NORMAL_PRIORITY_CLASS = 0x0008000
  BELOW_NORMAL_PRIORITY_CLASS = 0x0004000
  HIGH_PRIORITY_CLASS         = 0x0000080
  IDLE_PRIORITY_CLASS         = 0x0000040
  NORMAL_PRIORITY_CLASS       = 0x0000020
  REALTIME_PRIORITY_CLASS     = 0x0000010

  # Error constants
  INVALID_HANDLE_VALUE = 0xffffffff

  # Process Access Rights
  PROCESS_QUERY_INFORMATION = 0x00000400

  # Define these for Windows
  PRIO_PROCESS = 0
  PRIO_PGRP    = 1
  PRIO_USER    = 2
end
