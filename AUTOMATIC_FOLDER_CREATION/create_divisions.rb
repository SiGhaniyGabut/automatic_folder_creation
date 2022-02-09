# Gunakan file ini hanya untuk membuat folder pertama kali pada masing-masing bagian
# Jika ada bagian yang membutuhkan, harap masukkan nama bagian tsb pada Array ini
# Jangan langsung mencoba untuk membuat foldernya di Explorer
# Contoh: 20-SECURITY

# Aturan penamaan folder sebagai berikut:
# 1. Semua nama folder harus dibuat UPPERCASE
# 2. Jika lebih dari 1 kata, sambung dengan underscore
# 3. Urutkan folder seperti dibawah ini:
divisions = %w(
    1-KETUA
    2-WAKIL_KETUA_1
    3-WAKIL_KETUA_2
    4-WAKIL_KETUA_3
    5-LPPM
    6-KAPRODI_D3_AKUNTANSI
    7-KAPRODI_D3_KEUANGAN_PERBANKAN
    8-KAPRODI_S1_AKUNTANSI
    9-KAPRODI_S1_MANAJEMEN
    10-KAPRODI_S2_MANAJEMEN
    11-AKADEMIK
    12-KEUANGAN
    13-BTU
    14-PMB
    15-SPMI
    16-PERPUSTAKAAN
    17-SDM
    18-KOPERASI
    19-IT
).freeze

structures = ["PUBLIC", "INTERNAL"]

# Ganti ROOT folder jika Drive atau folder diubah
Dir.chdir("D:/STIEBI")

# Struktur folder yang dibuat akan terlihat seperti ini:
# 1-KETUA
# |--- PUBLIC
# |--- INTERNAL
# 2-WAKIL_KETUA_1
# |--- PUBLIC
# |--- INTERNAL
# Dst...
divisions.each do |folder|
    Dir.mkdir(folder) unless Dir.exist?(folder)
    structures.each do |struct|
        Dir.mkdir("#{folder}/#{struct}") unless Dir.exist?("#{folder}/#{struct}")
    end
end