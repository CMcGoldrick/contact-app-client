module ContactViews
  def contacts_show_view(contact)
    puts
    puts "#{contact.first_name} - Id: #{contact.id}"
    puts
    puts contact.email
    puts contact.bio
    puts contact.phone_number
    puts "------------------"
  end

  def contacts_index_view(contacts)
    contacts.each do |contact|
      puts "========================="
      contacts_show_view(contact)
    end
  end
end