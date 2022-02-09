require "date"

class CreateFolderAutomation
    MONTHS = [nil, 
        "1-Januari", 
        "2-Februari", 
        "3-Maret", 
        "4-April", 
        "5-Mei", 
        "6-Juni", 
        "7-Juli", 
        "8-Agustus", 
        "9-September", 
        "10-Oktober", 
        "11-November", 
        "12-Desember"
    ]

    DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    def create_folder(division)
        # Uncomment fungsi ini untuk menjalankan program secara manual
        # berdasarkan waktu yang ditentukan.
        # time = Time.new(2019, 1, 1, 0, 0, 0, "+07:00")
        
        time = Time.now # Comment fungsi ini jika gunakan waktu manual
        divisions_folder = "D:/STIEBI/#{division}"

        Dir.chdir(divisions_folder)
        Dir.each_child(Dir.getwd) do |structure|
            Dir.chdir("#{divisions_folder}/#{structure}")

            yearly_folder = "#{time.year}"
            monthly_folder = "#{time.year}/#{MONTHS[time.month]}"

            Dir.mkdir(yearly_folder) unless Dir.exist?(yearly_folder)
            Dir.mkdir(monthly_folder) unless Dir.exist?(monthly_folder)

            get_days_in_month(time.month, time.year).times do |day|
                # Jumlah perulangan dimasukkan dalam variabel day.
                # Namun, karena perulangan dimulai dari 0, maka harus ditambah 1
                daily_folder = "#{monthly_folder}/#{day + 1}"
                Dir.mkdir(daily_folder) unless Dir.exist?(daily_folder)
            end
        end
    end

    def get_days_in_month(month, year)
        if month == 2 && Date.gregorian_leap?(year) # Bulan Februari di tahun Kabisat
            return 29
        end
        return DAYS_IN_MONTH[month]
    end

private :get_days_in_month

end