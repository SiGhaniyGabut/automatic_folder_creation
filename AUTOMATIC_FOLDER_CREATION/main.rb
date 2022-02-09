require_relative "create_folder_automation"

divisions = Dir.children("D:/STIEBI")

divisions.each do |division|
    CreateFolderAutomation.new.create_folder(division)
end