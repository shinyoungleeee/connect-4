require_relative './grid'
require_relative './player'

puts "Let's play Connect 4!"
puts "\n"

grid = Grid.new

puts "This game requires two players."
print "Enter Player 1's name: "
player_1_name = gets.chomp
player_1 = Player.new(player_1_name, 'X')
print "Enter Player 2's name: "
player_2_name = gets.chomp
while player_2_name == player_1_name
  print "Please enter a different name than Player 1: "
  player_2_name = gets.chomp
end
player_2 = Player.new(player_2_name, 'O')
puts "\n"
puts "Thanks!"
puts "\n"

puts "Let's get started."
puts "Here is the grid we'll be working with:"
puts grid.show
puts "\n"
puts "#{player_1.name}, your piece is #{player_1.piece} and it is your turn!"
print "Pick a single column letter (A-G): "
this_turn = gets.chomp
until grid.drop(this_turn, player_1.piece)
  this_turn = gets.chomp
end
puts "\n"
puts "Thanks! Here's the new grid:"
puts grid.show
puts "\n"

puts "#{player_2.name}, your piece is #{player_2.piece} and it is now your turn!"
print "Pick a single column letter (A-G): "
this_turn = gets.chomp
until grid.drop(this_turn, player_2.piece)
  this_turn = gets.chomp
end
puts "\n"
puts "Thanks! Here's the new grid:"
puts grid.show
puts "\n"

puts "Now you know how to play. Go for it!"
puts "\n"

while true
  print "#{player_1.name} (A-G): "
  this_turn = gets.chomp
  until grid.drop(this_turn, player_1.piece)
    this_turn = gets.chomp
  end
  puts "\n"
  puts grid.show
  puts "\n"

  if grid.check(player_1.piece)
    puts "#{player_1.name} wins!"
    break
  end

  print "#{player_2.name} (A-G): "
  this_turn = gets.chomp
  until grid.drop(this_turn, player_2.piece)
    this_turn = gets.chomp
  end
  puts "\n"
  puts grid.show
  puts "\n"

  if grid.check(player_2.piece)
    puts "#{player_2.name} wins!"
    break
  end

  if grid.game_over
    puts "Game Over!"
    break
  end
end
