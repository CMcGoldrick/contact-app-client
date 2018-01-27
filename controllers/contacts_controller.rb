module ContactsController
  def contacts_index_action
    response = Unirest.get("http://localhost:3000/contacts")
    contact_hashs = response.body
    contacts = []

    contact_hashs.each do |contact_hash|
      contacts << Contact.new(contact_hash)
    end

    contacts_index_view(contacts)      
  end

  def contact_show_action
    print "Enter contact id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
    contact_hash = response.body
    contact = Contact.new(contact_hash)

    products_show_view(contact)
  end

  def contact_create_action
     client_params = {}

     print "First Name: "
     client_params[:first_name] = gets.chomp

     print "Middle_Name:"
     client_params[:middle_name] = gets.chomp

     print "Last_name: "
     client_params[:last_name] = gets.chomp

     print "Email: "
     client_params[:email] = gets.chomp

     print "Phone_Number: "
     client_params[:phone_number] = gets.chomp

     print "BIO: "
     client_params[:bio] = gets.chomp

     response = Unirest.post(
                             "http://localhost:3000/contacts",
                             parameters: client_params
                             )
    contact_data = response.body

    if response.code == 200
      product_data = response.body
      puts JSON.pretty_generate(contact_data)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end
    end
  end

  def contact_update_action
    print "Enter a contact id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
    contact = response.body

    # puts "Enter new information for contact ##{input_id}"
    client_params = {}

    print "First Name (#{contact["first_name"]}): "
    client_params[:first_name] = gets.chomp

    print "Middle Name (#{contact["middle_name"]}): "
    client_params[:middle_name] = gets.chomp

    print "Last Name (#{contact["last_name"]}): "
    client_params[:last_name] = gets.chomp

    print "Email (#{contact["email"]}): "
    client_params[:email] = gets.chomp

    print "Bio (#{contact["bio"]}): "
    client_params[:bio] = gets.chomp

    print "Phone Number (#{contact["phone_number"]}): "
    client_params[:phone_number] = gets.chomp

    client_params.delete_if {|key, value| value.empty? }

    response = Unirest.patch(
                            "http://localhost:3000/contacts/#{input_id}",
                            parameters: client_params
                            )

    if response.code == 200
      contact_data = response.body
      puts JSON.pretty_generate(contact_data)
    else 
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end
    end
  end

  def contact_destroy_action
    print "Enter a contact id that you want to delete: "
    input_id = gets.chomp

    response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
    data = response.body
    puts data["message"]  
  end
end