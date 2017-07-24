# encoding: utf-8

class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters
  attr_accessor :status

  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  # Метод, который возвращает массив букв загаданного слова
  def get_letters(word)
    abort "Загадано пустое слово, нечего отгадывать. Закрываемся" if word == nil || word == ""

    word.encode('UTF-8').split("")
  end

  # Метод, который отвечает на вопрос, является ли буква подходящей
  def good?(letter)
    @letters.include?(letter) ||
      (letter == 'Е' && @letters.include?('Ё')) ||
      (letter == 'Ё' && @letters.include?('Е')) ||
      (letter == 'И' && @letters.include?('Й')) ||
      (letter == 'Й' && @letters.include?('И'))
  end

  # Метод добавляет букву к массиву (хороших или плохих букв)
  def add_letter_to(letters, letter)
    # Обратите внимание, что переменная - это только ярлык,
    # не смотря на то, что letters после работы метода исчезнет,
    # объект, который мы поменяли, останется
    letters << letter

    case letter
    when 'И' then letters << 'Й'
    when 'Й' then letters << 'И'
    when 'Е' then letters << 'Ё'
    when 'Ё' then letters << 'Е'
    end
  end

  # Основной метод игры "сделать следующий шаг". В качестве параметра принимает
  # букву, которую ввел пользователь. Основная логика взята из метода
  # check_user_input (см. первую версию программы).
  def next_step(letter)
    return if @status == -1 || @status == 1
    return if @good_letters.include?(letter) || @bad_letters.include?(letter)

    if good?(letter)
      add_letter_to(@good_letters, letter)
      @status = 1 if @good_letters.uniq.sort == @letters.uniq.sort
    else
      add_letter_to(@bad_letters, letter)
      @errors += 1
      @status = -1 if @errors >= 7
    end
  end

  # Метод, спрашивающий юзера букву и возвращающий ее как результат. В идеале
  # этот метод лучше вынести в другой класс, потому что он относится не только
  # к состоянию игры, но и к вводу данных.
  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    until letter
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    next_step(UnicodeUtils.downcase(letter))
  end
end
