require "ffi"

module Termbox
  module Interface
    INPUT_MODE_ESC = 1
    INPUT_MODE_ALT = 2

    def self.included(klass)
      klass.extend(FFI::Library)
      klass.extend(ClassMethods)
    end

    class Cell < FFI::Struct
      layout :ch, :ulong,
             :fg, :uint16,
             :bg, :uint16
     end

    class Event < FFI::Struct
      layout :type, :uint8,
             :mod,  :uint8,
             :key,  :uint16,
             :ch,   :uint32,
             :w,    :int32,
             :h,    :int32
     end

    module ClassMethods
      def initialize_library(path = nil)
        ffi_lib(path)
        attach_function :tb_init,        [], :int
        attach_function :tb_shutdown,    [], :void
        attach_function :tb_width,       [], :uint
        attach_function :tb_height,      [], :uint
        attach_function :tb_clear,       [], :void
        attach_function :tb_present,     [], :void
        attach_function :tb_set_cursor,  [:int, :int], :void
        attach_function :tb_put_cell,    [:uint, :uint, :pointer], :void  #pointer follows TbCell
        attach_function :tb_change_cell, [:uint, :uint, :ulong, :uint16, :uint16], :void
        attach_function :tb_blit,        [:uint, :uint, :uint, :uint, :pointer], :void # pointer follows TbCell

        # with 0 returns current input mode
        attach_function :tb_select_input_mode, [:int], :int
        attach_function :tb_peek_event, [:pointer, :int], :int
        attach_function :tb_poll_event, [:pointer], :int
      end
    end
  end
end
