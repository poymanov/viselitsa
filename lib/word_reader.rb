# encoding: utf-8

module WordReader
  def self.read_from_file(file_name)
    # Если файла не существует, сразу выходим из метода
    return nil unless File.exist?(file_name)

    file = File.new(file_name, "r:UTF-8")
    lines = file.readlines
    file.close

    word = lines.sample.chomp
    word = UnicodeUtils.downcase(word)
  end
end
