#####
#
# Mad Libs Game
# Ask the user for a series of words to replace categories; fill in proper places in the story using the user's answers.
# by Eugene Wolfson
# Just needs ruby to run
# You can run test 3 in irb by typing: require 'test3'
#
#####
# TODO: Handle more than two adjacents parentheses.(Include error messages or something)
# Does not handle placeholders with extra parenthesis. ex: "carried ((food (plural))), and" will not prompt "food (plural)" as a category
#
#
#####
# Version 1: Asks the user to map category right away, and then printing the whole story..
# Version 2: Prints the story interactively: printing up to placeholders with new categories, and only then asking the user for input. Version 2 should use StringScanner instead of keeping story ina  string
# Reads a story, replacing placeholders with user-provided words.
# If no file is provided, requests a filepath first.
class MadLibs


  # Constants:
  #  PLACEHOLDER_REGEX is a Regex that finds placeholders of the form ((...)) #FIXME: Incorporate finding inner parentheses
  PLACEHOLDER_REGEX = /\(\([-:'\s\w]+\)\)/ #Regex that finds placeholders of the form ((...)) #FIXME: Incorporate finding inner parentheses


  # attr_reader: categories
  
  # Read a mad libs story from a file, and ask the user for a series of words to replace categories; 
  # fill in proper places in the story using the user's answers.
  # Then Print the parsed story
  def initialize(filepath)
    puts "Give an appropriate response to each category. Note that parenthesis "
    story = File::read(filepath) #FIXME: Do I want to be putting the whole file into story? What if it's long?
    print parse(story)
  end



  # Use regex to extract a list of colon-separated categories in ((...)), where ... is the list of categories
  # For all new categories, ask the user for the answer and save the mapping
  # return the answer to the first category.
  #  
  # Specifically: 
  #  For each placeholder, /\(\([-:'\s\w]+\)\)/,
  #  split by colon and for each colon-separated category:
  #  Map the category to a name
  # Then, swap placeholders for the first name associated with the placeholder
  def parse(story)
    @mappings ||= {}

    placeholders = story.scan(PLACEHOLDER_REGEX).collect do |placeholder|
      extract_categories(placeholder).each do |category|
        # puts placeholder + ": '"+ category + "'" #Debugging
        set_mapping(category)
      end
    end

    return parsed_story = story.gsub(PLACEHOLDER_REGEX){|placeholder| replace_placeholder(placeholder)}
  end
  
  
  
  # Ask the user for a word to replace a category 
  def set_mapping(category)
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
