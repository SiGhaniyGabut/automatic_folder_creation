require 'rubygems'
require 'net/ldap'

class StiebiLDAP
    def initialize(username, password, host)
        @username = username
        @password = password
        @host = host
    end

    attr_accessor :username, :password, :host

    def search_by(object, value)
        ldap.search(base: treebase, filter: filter(object, value))
    end

    def get_ous
        organizational_units = []
        ldap.search(base: treebase, filter: filter('OU', '*')).each { |entries| entries.name.each { |name| organizational_units << name } }
        return organizational_units
    end

    private

    def treebase
        case mac_address
        when '00:15:5d:01:ad:b3' # WSL on My Computer
            'DC=STIEBI,DC=LOCAL'
        when '78-E7-D1-C7-A8-B4' # DATACENTER Mac Address
            @host.split('.').map(&:upcase).join(',DC=').prepend('DC=')
        end
    end

    def username_base_on_mac
        case mac_address
        when '00:15:5d:01:ad:b3' # WSL on My Computer
            "#{@username}@stiebi.local"
        when '78-E7-D1-C7-A8-B4' # DATACENTER Mac Address
            "#{@username}@#{@host}"
        end
    end

    def ldap
        Net::LDAP.new(
            host: @host,
            port: 389,
            auth: {
                username: username_base_on_mac,
                password: @password,
                method: :simple
            }
        )
    end

    def filter(object, value)
        Net::LDAP::Filter.eq(object, value)
    end

    def mac_address
        platform = RUBY_PLATFORM.downcase
        output = `#{(platform =~ /x64-mingw32/) ? 'ipconfig /all' : 'ifconfig'}`
        case platform
          when /x86_64-linux/
            $1 if output =~ /eth0.*?(([A-F0-9]{2}:){5}[A-F0-9]{2})/im
          when /x64-mingw32/
            $1 if output =~ /Physical Address.*?(([A-F0-9]{2}-){5}[A-F0-9]{2})/im
          else nil
        end
    end
end