require './banks'

module NgBankParser
  class Router
    #The holder for our supported file extensions
    @file_extension_array = []
    @filename = "okay.xls"
    @bank_name = "gtb"

    #this calls the required methods needed to get the bank name and extension
    #and uses it to pick which of the bank parsers to use
    def self.router_delegator
      iterate_me($Banks, @bank_name)
      parser_picker(@filename)
    end


    private
    
    #this takes our bank parser along with the bank name supplied from the payload so as to compare
    #and see if the file extension is available for that bank
    #it's result is to fill up the @file_extension_array with the supported bank extensions
    def self.iterate_me(bank_stash, bank_name)
      value = bank_stash.index {|x| x[:key] == bank_name}
      temporary_iterate_holder = bank_stash[value]
     @file_extension_array += temporary_iterate_holder[:parsers].map {|e| e[:extensions]}
    end

    #this uses the extension in the file of the uploaded payload to check support in @file_extension_array
    #and goes on to pick the parser to use for the operation
    def self.parser_picker(filename)
      extension_name = File.extname(filename).delete('.')
        if @file_extension_array.reduce(:concat).include?(extension_name)
           "Hello"
         else
           "Bye"
         end 
    end

    puts router_delegator

  end
end