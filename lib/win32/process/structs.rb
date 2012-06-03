require 'ffi'

module Process::Structs
  extend FFI::Library

  class LARGE_INTEGER < FFI::Union
    layout(
      :LowPart, :ulong,
      :HighPart, :long,
      :QuadPart, :long_long
    )
  end

  class IO_COUNTERS < FFI::Struct
    layout(
      :ReadOperationCount, :ulong_long,
      :WriteOperationCount, :ulong_long,
      :OtherOperationCount, :ulong_long,
      :ReadTransferCount, :ulong_long,
      :WriteTransferCount, :ulong_long,
      :OtherTransferCount, :ulong_long,
    )
  end

  class JOBJECT_BASIC_LIMIT_INFORMATION < FFI::Struct
    layout(
      :PerProcessUserTimeLimit, LARGE_INTEGER,
      :PerJobUserTimeLimit, LARGE_INTEGER,
      :LimitFlags, :ulong,
      :MinimumWorkingSetSize, :size_t,
      :MaximumWorkingSetSize, :size_t,
      :ActiveProcessLimit, :ulong,
      :Affinity, :pointer,
      :PriorityClass, :ulong,
      :SchedulingClass, :ulong
    )
  end

  class JOBJECT_EXTENDED_LIMIT_INFORMATION < FFI::Struct
    layout(
      :BasicLimitInformation, JOBJECT_BASIC_LIMIT_INFORMATION,
      :IoInfo, IO_COUNTERS,
      :ProcessMemoryLimit, :size_t,
      :JobMemoryLimit, :size_t,
      :PeakProcessMemoryUsed, :size_t,
      :PeakJobMemoryUsed, :size_t
    )
  end
end
