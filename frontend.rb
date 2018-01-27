require 'unirest'

require_relative 'controllers/contacts_controller'
require_relative 'views/contact_views'
require_relative 'models/contact'

class Frontend
  include ContactsController
  include ContactViews

  def run  
    system "clear"

    puts "Welcome to my Contacts App"
    puts "make a selection"
    puts "    [1] See all contacts"
    puts "          [1.1] Search contacts by name"
    puts "          [1.2] Search contacts by price"
    puts "    [2] See one contact"
    puts "    [3] Create a new contact"
    puts "    [4] Update a contact"
    puts "    [5] Destroy a contact"

    input_option = gets.chomp

    if input_option == "1"
      contacts_index_action

    elsif input_option == "1.1"
    print "Enter a name to search by: "
    input_name = gets.chomp

    response = Unirest.get("http://localhost:3000/contacts?search=#{input_name}")
    contacts = response.body
    puts JSON.pretty_generate(contacts)

    # elsif input_option = "1.2"

    elsif input_option == "2"
      contact_show_action

    elsif input_option == "3"
      contact_create_action

    elsif input_option == "4"
      contact_update_action

    elsif input_option == "5"
      contact_destroy_action
    end
  end
end