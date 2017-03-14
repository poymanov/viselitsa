# encoding: utf-8

class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  # Метод, который возвращает массив букв загаданного слова
  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end

    return slovo.encode('UTF-8').split("")
  end

  def status
    return @status
  end

  # Основной метод игры "сделать следующий шаг". В качестве параметра принимает
  # букву, которую ввел пользователь. Основная логика взята из метода
  # check_user_input (см. первую версию программы).
  def next_step(bukva)
    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    if @letters.include?(bukva)
      @good_letters << bukva

      if @good_letters.uniq.sort == @letters.uniq.sort
        @status = 1
      end
    else
      @bad_letters << bukva
      @errors += 1

      if @errors >= 7
        @status = -1
      end
    end
  end

  # Метод, спрашивающий юзера букву и возвращающий ее как результат. В идеале
  # этот метод лучше вынести в другой класс, потому что он относится не только
  # к состоянию игры, но и к вводу данных.
  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp
      letter = UnicodeUtils.downcase(letter)
    end

    next_step(letter)
  end
end
