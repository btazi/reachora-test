require "pry"
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

    Animal.verses(animals)
  end
end

class Animal
  def initialize(args)
    args.each do |k, v|
      send("#{k}=", v)
    end
  end

  attr_accessor :name, :expression, :additional_lines, :dead, :previous_animals

  def previous_lines
    lines = []
    first_animal_index = 0
    second_animal_index = 1

    list = previous_animals
    while second_animal_index < previous_animals.count
      first_animal = list[first_animal_index].name
      second_animal = list[second_animal_index].name
      spider_special = first_animal == "spider" ? " that wriggled and jiggled and tickled inside her" : nil

      lines.push "She swallowed the #{second_animal} to catch the #{first_animal}#{spider_special}."

      first_animal_index += 1
      second_animal_index += 1
    end
    lines.reverse.join("\n")
  end

  def end_line
    if dead
      "She's dead, of course!"
    else
      "I don't know why she swallowed the fly. Perhaps she'll die."
    end
  end

  def verse
    text = ""
    text += "I know an old lady who swallowed a #{name}.\n"
    text += expression + "\n" if expression
    if previous_animals.class == Array && previous_animals.length > 0
      text += previous_lines + "\n" if previous_animals
    end
    text += end_line + "\n"
    text
  end

  def self.verses(animals)
    verses = animals.each_with_index.map { |animal, index|
      additional_lines = {additional_lines: index}
      previous_animals = animals[0..index].map { |a| Animal.new(a) } unless index == 0 || index + 1 == animals.count
      previous_animals = {previous_animals: previous_animals}
      attributes = animal.merge(additional_lines).merge(previous_animals)
      Animal.new(attributes).verse
    }
    verses.join("\n")
  end
end

puts FoodChain.song
