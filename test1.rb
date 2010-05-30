#use test_file1.txt to mess with story
story = File::read('test_file1.txt')

placeholders = story.scan(/\(\([-:\s\w]+\)\)/)

placeholders.collect{|p| p.gsub(/\({2}/, '' ).gsub(/\){2}/, '' ).split(':')}#TODO: can be made smaller... look into anchors


