require_relative "STIEBI_LDAP"

# obj = StiebiLDAP.new('administrator', 'StieBI2021!', '192.168.100.2')
obj = StiebiLDAP.new("administrator", ENV['LDAP_PASSWD'], "stiebi.local")
obj.search_by('cn', 'Abdul*').each do |data|
    puts data.inspect
end

obj.username = "ghaniy"

puts obj.get_ous