require "pry"

f = File.open "scores.txt", "w"
accepted_words = File.open("/Users/Spoonflower/Desktop/scrabblewords.txt").to_a

def letter_points
  {
    "a" => 1, "b" => 3, "c" => 3, "d" => 2,
    "e" => 1, "f" => 4, "g" => 2, "h" => 4,
    "i" => 1, "j" => 8, "k" => 5, "l" => 1,
    "m" => 3, "n" => 1, "o" => 1, "p" => 3,
    "q" => 10, "r" => 1, "s" => 1, "t" => 1,
    "u" => 1, "v" => 4, "w" => 4, "x" => 8,
    "y" => 4, "z" => 10
  }
end

def calculate_word_score word
  score = 0
  word.split("").each do |l|
    score += letter_points[l]
  end
  return score
end

def update_total totals, current_player, score
   totals[current_player -1] += score
end

def update_maxes maxes, current_player, score
  if score > maxes[current_player - 1]
    maxes[current_player - 1] = score
  end
  maxes
end

# def check_word word, accepted_words
#   check = false
#   if word is in accepted_words
#     return true
#   else
#     print "That is not a Scrabble word, please pick another word"
#     input = gets.chomp
#   end
# end

puts "Welcome to Scrabble Calculator :to quit press q"
print "How many players? "
players = gets.chomp.to_i

totals = []
maxes = []
players.times do
  totals.push 0
  maxes.push 0
end

input = nil
current_player = 1

until input == "q"
  print "Player #{current_player}, enter your word? "
  input = gets.chomp
  score = calculate_word_score(input)
  update_total(totals, current_player, score)
  update_maxes(maxes, current_player, score)
  current_player += 1
  if current_player > players
    current_player = 1
  end
end

puts "Final scores:"
i = 0
totals.each do |total|
  puts "Player #{i + 1}: total #{total}, max #{maxes[i]} "
  f.puts "Player #{i + 1}: #{total}, max #{maxes[i]}"
  i += 1
end

f.close
