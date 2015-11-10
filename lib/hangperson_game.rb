class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses= ''
  end

  def guess(s)
    raise ArgumentError, "Please enter a valid letter" if s == nil or s.empty? or s.match(/\W/)
    s.downcase!
    if @word.include? s
      if @guesses.include? s
        return false
      else
        @guesses << s
      end
    else
      if @wrong_guesses.include? s
        return false
      else
        @wrong_guesses << s
      end
    end
  end
  
  def word_with_guesses
    result = ''
    @word.each_char { |c|
      if @guesses.include? c
        result << c
      else
        result << '-'
      end      
    }
    return result
  end
  
  def check_win_or_lose
    if not self.word_with_guesses.include? '-' and not self.word_with_guesses.empty?
      return :win
    elsif @wrong_guesses.size < 7
      return :play
    else
      return :lose      
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
