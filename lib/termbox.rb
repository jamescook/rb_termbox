require "bundler/setup"
require "ffi"

lib = File.expand_path('../../', __FILE__)
$:.unshift lib unless $:.include?(lib)

module Termbox
  extend FFI::Library

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

  def termbox_library_path path=nil
    if path
      @library_path = path
    end

    @library_path || "libtermbox"
  end

  def initialize_library path=nil
    ffi_lib path || termbox_library_path
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
    attach_function :tb_peek_event, [:pointer, :int], :int, {:blocking => true}
    attach_function :tb_poll_event, [:pointer], :int, {:blocking => true}
  end

  module_function :initialize_library, :termbox_library_path

  require_relative  "termbox/keys"
  require_relative  "termbox/colors"
end
