# File ini memungkinkan pembuatan Organizational Unit secara otomatis

# Ruby menghasilkan string yang di-encode menggunakan UTF-8
# Sedangkan Powershell menggunakan string yang di-encode menggunakan UTF-16LE\
# Sehingga kita perlu merubah encoding Ruby sebelum konversi ke base64
require 'base64'

divisions = %w(
    KETUA
    WAKIL_KETUA_1
    WAKIL_KETUA_2
    WAKIL_KETUA_3
    LPPM
    KAPRODI_D3_AKUNTANSI
    KAPRODI_D3_MANAJEMEN
    KAPRODI_S1_AKUNTANSI
    KAPRODI_S1_MANAJEMEN
    KAPRODI_S2_MANAJEMEN
    AKADEMIK
    KEUANGAN
    BTU
    PMB
    SPMI
    PERPUSTAKAAN
    SDM
    KOPERASI
    IT
).freeze

def create_ou_for(ou_name, ou_path)
    ou_name.each do |name|
        powershell_command = %{
            New-ADOrganizationalUnit -Name "#{name}" -Path "#{ou_path}"
        }
        system("powershell.exe Echo 'Creating OU for #{name}'")
        system("powershell.exe -encodedcommand #{Base64.strict_encode64(powershell_command.encode('UTF-16LE'))}")
    end
    system("powershell.exe Echo 'OUs created'")
end

create_ou_for(divisions, "OU=STIEBI,DC=STIEBI,DC=LOCAL")