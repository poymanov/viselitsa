# encoding: utf-8
#
# Популярная детская игра
# https://ru.wikipedia.org/wiki/Виселица_(игра)
#
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative "lib/game"
require_relative "lib/result_printer"
require_relative "lib/word_reader"

puts "Игра виселица. Версия 3. (c) goodprogrammer.ru\n\n"
sleep 1

printer = ResultPrinter.new

words_file_name = File.dirname(__FILE__) + "/data/words.txt"

game = Game.new(WordReader.read_from_file(words_file_name))

while game.status == 0
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
