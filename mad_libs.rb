#####
#
# Mad Libs Game
# ask the user for a series of words; fill in proper places in the story using the user's answers.
# by Eugene Wolfson
# Just needs ruby to run
#
#####
# Version 1: Asks the user to map category right away, and then printing the whole story..
# Version 2: Prints the story interactively: printing up to placeholders with new categories, and only then asking the user for input. Version 2 should use StringScanner instead of keeping story ina  string
# Reads a story, replacing placeholders with user-provided words.
# If no file is provided, requests a filepath first.
class MadLibs

  # attr_reader: categories
  
  # print the contents of the file until encountering a placeholder.
  # parse each placeholder and continue with a new category.
  #
  # then ask the user to enter the 
  
  # If no file is provided, requests a filepath.
  # parses all placeholders
  def initialize(filepath)
    #  until Pathname.new(filepath).exist? #TODO: Do  I need any other checks?
    #    print "Provide an existing (relative) filepath: " # is this a relative filepath?
    #    filepath = gets
    #  end
    story = File::read(filepath) #FIXME: Do I want to be putting the whole file into story? What if it's long?
    print parse(story)
  #  p story.gsub(/\(\([-:\s\w]+\)\)/).collect{ |placeholder| replace_placeholder(placeholder)}
    
  end

  # Use regex to extract a list of colon-separated categories in ((...)), where ... is the list of categories
  # For all new categories, ask the user for the answer and save the mapping
  # return the answer to the first category.
  def parse(story)
    
    #/\(\([-:\s\w]+\)\)/ #match two ((, followed by anything except line breaks, and ending with ))
    #TODO: the scan(pattern){|match,...| block} => str, seems good
    # @categories = story.scan(/\(\([-:\s\w]+\)\)/) { |placeholder| placeholder.gsub(/\(\(\)\)/,'').split(':')}
    

    @mappings ||= {}
    
    placeholders = story.scan(/\(\([-:\s\w]+\)\)/).collect do |placeholder|
      extract_categories(placeholder).each do |category|
        puts placeholder + ": '"+ category + "'"
        set_mapping(category)
      end
    end
    #    placeholders.collect{ |placeholder| placeholder.collect{|category| set_mapping(category)}}
    parsed_story = story.gsub(/\(\([-:\s\w]+\)\)/){|placeholder| replace_placeholder(placeholder)}
    return parsed_story
    #      end
    #    end
  end
  
  
  # For each placeholder, /\(\([-:\s\w]+\)\)/
  #  split by colon and for each colon-separated category:
  #  Map the category to a name
  
  
  # Ask the user for a word to replace a category
  # A category is a word 
  def set_mapping(category)
  #  p "mappings: '#{@mappings}' ============"
    @mappings.fetch(category) do |category|
      print "#{category}: "
      @mappings[category] = gets.chomp
    end
  end

  # Given a placeholder, replace it with the mapping from its first value.
  def replace_placeholder(placeholder)
    @mappings[extract_categories(placeholder).first]
  end

  # For a given placeholder, strips bounding parentheses and returns a colon-delimited array of categories
  def extract_categories(placeholder)
    placeholder.gsub(/\({2}/, '' ).gsub(/\){2}/, '' ).split(':')
  end

end
