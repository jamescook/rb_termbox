require "ffi"

module Termbox
  extend FFI::Library

  ffi_lib File.join(File.expand_path("~/"), "work", "termbox_src", "termbox.dylib")

  COLORS = {
    :black   => 0x00,
    :red     => 0x01,
    :green   => 0x02,
    :yellow  => 0x03,
    :blue    => 0x04,
    :magenta => 0x05,
    :cyan    => 0x06,
    :white   => 0x07
  }

  attach_function :tb_init,      [], :int
  attach_function :tb_shutdown,  [], :void
  attach_function :tb_width,     [], :uint
  attach_function :tb_height,    [], :uint
  attach_function :tb_clear,     [], :void
  attach_function :tb_present,   [], :void
  attach_function :tb_set_cursor, [:int, :int], :void

  class Cell < FFI::Struct
    layout :ch, :ulong,
           :fg, :uint16,
           :bg, :uint16
   end
  
  #SO_IMPORT void tb_put_cell(unsigned int x, unsigned int y, const struct tb_cell *cell);
  attach_function :tb_put_cell, [:uint, :uint, :pointer], :void  #pointer follows TbCell

  #SO_IMPORT void tb_change_cell(unsigned int x, unsigned int y, uint32_t ch, uint16_t fg, uint16_t bg);
  attach_function :tb_change_cell, [:uint, :uint, :ulong, :uint16, :uint16], :void

  #SO_IMPORT void tb_blit(unsigned int x, unsigned int y, unsigned int w, unsigned int h, const struct tb_cell *cells);
  attach_function :tb_blit, [:uint, :uint, :uint, :uint, :pointer], :void # pointer follows TbCell

  #SO_IMPORT int tb_select_input_mode(int mode);
  # with 0 returns current input mode
  attach_function :tb_select_input_mode, [:int], :int

  #SO_IMPORT int tb_peek_event(struct tb_event *event, unsigned int timeout);
  class Event < FFI::Struct
    layout :type, :uint8,
           :mod,  :uint8,
           :key,  :uint16,
           :ch,   :ulong,
           :w,    :int32,
           :h,    :int32
   end
  attach_function :tb_peek_event, [:pointer, :int], :int

  #SO_IMPORT int tb_poll_event(struct tb_event *event);
  attach_function :tb_poll_event, [:pointer], :int
end
