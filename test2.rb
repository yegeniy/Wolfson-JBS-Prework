require 'mad_libs'
puts "Story Preview:"
p File.read('test_file1.txt')
story = MadLibs.new('test_file1.txt')
