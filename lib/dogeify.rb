require_relative "dogeify/version"
require "engtagger"

class Dogeify
  ADJECTIVES = %w(so such very much many).freeze

  def initialize
    @tagger = EngTagger.new
  end

  def process(str)
    # string should be lowercase
    str = str.downcase

    # extract nouns, prefix adjectives 
    tagged_str = @tagger.add_tags(str)
    phrases = @tagger.get_nouns(tagged_str).keys
    phrases = phrases.map.with_index do |phrase, idx|
      "#{adjective(idx)} #{phrase}."
    end

    # end input with 'wow.'
    phrases << 'wow.'


    # join sentences together
    phrases.join(" ")

  end

  private

  def adjective(i)
    ADJECTIVES[i % ADJECTIVES.length]
  end
end
