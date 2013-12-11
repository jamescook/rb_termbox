load File.join(File.expand_path("."), "/lib/termbox.rb")

class AllColors
  def self.run
    Termbox.termbox_library_path "termbox"
    Termbox.initialize_library
    start = Termbox.tb_init
    if start
      Termbox.tb_select_input_mode 1 # TB_INPUT_ESC
      ev = Termbox::Event.new
      Termbox.tb_clear
      draw_colors
      Termbox.tb_present

      while Termbox.tb_poll_event(ev) >= 0 do
        case ev[:type]
          when 1 #TB_EVENT_KEY
            if ev[:key] == 0x1B # ESC
              Termbox.tb_shutdown
              exit
            end
          end
      end
    end
  end

  def self.draw_colors
    (0..255).to_a.each do |i|
      Termbox.tb_change_cell(i,0, 0x20, 0x00, i);
    end
  end
end

if __FILE__ == $0
  AllColors.run
end

