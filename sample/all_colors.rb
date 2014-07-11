require 'termbox'

Termbox.run do
  (0..255).each do |i|
    Termbox.tb_change_cell(i,0, 0x20, 0x00, i);
  end
end
