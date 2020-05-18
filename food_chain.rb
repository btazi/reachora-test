class FoodChain
  def self.song
    animals = [\
      {name: "fly", expression: nil, dead: false},\
      {name: "spider", expression: "It wriggled and jiggled and tickled inside her.", dead: false},\
      {name: "bird", expression: "How absurd to swallow a bird!", dead: false},\
      {name: "cat", expression: "Imagine that, to swallow a cat!", dead: false},\
      {name: "dog", expression: "What a hog, to swallow a dog!", dead: false},\
      {name: "goat", expression: "Just opened her throat and swallowed a goat!", dead: false},\
      {name: "cow", expression: "I don't know how she swallowed a cow!", dead: false},\
      {name: "horse", expression: nil, dead: true}\
    ]

    verses = animals.each_with_index.map { |animal, index|
      additional_lines = {additional_lines: index}
      Animal.new(animal.merge(additional_lines)).verse
    }

    verses
  end
end

class Animal
  def initialize(args)
    args.each do |k, v|
      send("#{k}=", v)
    end
  end

  attr_accessor :name, :expression, :additional_lines, :dead

  def end_line
    if @dead
      "She's dead, of course!"
    else
      "I don't know why she swallowed the #{@name}. Perhaps she'll die."
    end
  end

  def verse
    puts "I know an old lady who swallowed a #{@name}."
    puts @expression if @expression
    puts end_line
    puts "\n"
  end
end

FoodChain.song
