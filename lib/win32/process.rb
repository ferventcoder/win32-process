require File.join(File.expand_path(File.dirname(__FILE__)), 'process', 'functions')
require File.join(File.expand_path(File.dirname(__FILE__)), 'process', 'constants')

module Process
  include Process::Constants
  extend Process::Functions

  WIN32_PROCESS_VERSION = '0.7.0'

  def job?
    pbool = FFI::MemoryPointer.new(:int)
    IsProcessInJob(GetCurrentProcess(), nil, pbool)
    pbool.read_int == 1 ? true : false
  end

  def get_affinity(int = Process.pid)
    pmask = FFI::MemoryPointer.new(:ulong)
    smask = FFI::MemoryPointer.new(:ulong)

    if int == Process.pid
      unless GetProcessAffinityMask(GetCurrentProcess(), pmask, smask)
        raise SystemCallError, FFI.errno, "GetProcessAffinityMask"
      end
    else
      begin
        handle = OpenProcess(PROCESS_QUERY_INFORMATION, 0 , int)

        if handle == INVALID_HANDLE_VALUE
          raise SystemCallError, FFI.errno, "OpeProcess"
        end

        unless GetProcessAffinityMask(handle, pmask, smask)
          raise SystemCallError, FFI.errno, "GetProcessAffinityMask"
        end
      ensure
        CloseHandle(handle)
      end
    end

    [pmask.read_ulong, smask.read_ulong]
  end

  remove_method :getpriority

  def getpriority(kind, int)
    raise TypeError, kind unless kind.is_a?(Fixnum) # Match spec
    raise TypeError, int unless int.is_a?(Fixnum)   # Match spec
    int = Process.pid if int == 0                   # Match spec

    handle = OpenProcess(PROCESS_QUERY_INFORMATION, false, int)

    if handle == INVALID_HANDLE_VALUE
      raise SystemCallError, FFI.errno, "OpenProcess"
    end

    begin
      priority = GetPriorityClass(handle)

      if priority == 0
        raise SystemCallError, FFI.errno, "GetPriorityClass"
      end
    ensure
      CloseHandle(handle)
    end

    priority
  end

  remove_method :setpriority

  def setpriority(kind, int, int_priority)
    raise TypeError unless kind.is_a?(Integer)          # Match spec
    raise TypeError unless int.is_a?(Integer)           # Match spec
    raise TypeError unless int_priority.is_a?(Integer)  # Match spec
    int = Process.pid if int == 0                       # Match spec

    handle = OpenProcess(PROCESS_SET_INFORMATION, false , int)

    if handle == INVALID_HANDLE_VALUE
      raise SystemCallError, FFI.errno, "OpenProcess"
    end

    begin
      unless SetPriorityClass(handle, int_priority)
        raise SystemCallError, FFI.errno, "SetPriorityClass"
      end
    ensure
      CloseHandle(handle)
    end

    return 0 # Match the spec
  end

  remove_method :uid

  def uid(sid = false)
    token = FFI::MemoryPointer.new(:ulong)

    raise TypeError unless sid.is_a?(TrueClass) || sid.is_a?(FalseClass)

    unless OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, token)
      raise SystemCallError, FFI.errno, "OpenProcessToken"
    end

    token   = token.read_ulong
    rlength = FFI::MemoryPointer.new(:ulong)
    tuser   = 0.chr * 512

    bool = GetTokenInformation(
      token,
      TokenUser,
      tuser,
      tuser.size,
      rlength
    )

    unless bool
      raise SystemCallError, FFI.errno, "GetTokenInformation"
    end

    string_sid = tuser[8, (rlength.read_ulong - 8)]

    if sid
      string_sid
    else
      psid = FFI::MemoryPointer.new(:ulong)

      unless ConvertSidToStringSidA(string_sid, psid)
        raise SystemCallError, FFI.errno, "ConvertSidToStringSid"
      end

      buf = 0.chr * 80
      strcpy(buf, psid.read_ulong)
      buf.strip.split('-').last.to_i
    end
  end

  private

  def get_volume_type
    buf = FFI::MemoryPointer.new(:char, 32)
    bool = GetVolumeInformationA(nil, nil, 0, nil, nil, nil, buf, buf.size)
    bool ? buf.read_string : nil
  end

  # TODO: Ruby 1.9.3 is giving me redefinition warnings. Why?
  module_function :getpriority
  module_function :setpriority
  module_function :get_affinity
  module_function :job?
  module_function :uid
end
