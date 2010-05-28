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

  attr_reader: categories
  
  # print the contents of the file until encountering a placeholder.
  # parse each placeholder and continue with a new category.
  #
  # then ask the user to enter the 
 
  # If no file is provided, requests a filepath.
  # parses all placeholders
  def initialize(filepath)
    until filepath.exist? #TODO: Do  I need any other checks?
      print "Provide an existing (relative) filepath: " # is this a relative filepath?
      filepath = gets
    end
    story = File::read(filepath) #FIXME: Do I want to be putting the whole file into story? What if it's long?

    
    parse(story)
      
  end

  # Use regex to extract a list of colon-separated categories in ((...)), where ... is the list of categories
  # For all new categories, ask the user for the answer and save the mapping
  # return the answer to the first category.
  def parse(story)
    @categories ||= {}
    #/\(\([-:\s\w]+\)\)/ #match two ((, followed by anything except line breaks, and ending with ))
    #TODO: the scan(pattern){|match,...| block} => str, seems good
    @categories = story.scan(/\(\([-:\s\w]+\)\)/) { |placeholder| placeholder.gsub(/\({2}\){2}/,'').split(':')}


    # For each placeholder, /\(\([-:\s\w]+\)\)/
    #  split by colon and for each colon-separated category:
    #  Map the category to a name
      
  end
  
  # Ask the user for a word to replace a category
  # A category is a word 
  def buffer_word(placeholder)
