Widget.all.each do |w|
  w.editor = w.creator
  w.save
end