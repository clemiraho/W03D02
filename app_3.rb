require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

puts "-------------------------------------------------"
puts "|        Prêt à jouer au cul de chouette !      |"
puts "|  Le but du jeu est d'être le ..... gagnant !  |"
puts "-------------------------------------------------"

print "Quel est ton nom ?"
print "=>"
player_name = gets.chomp
puts "Bonjour #{player_name} !"

my_game = Game.new(gets.chomp)

while my_game.is_still_ongoing? do
  my_game.new_players_in_sight
  my_game.show_players
  my_game.menu
  my_game.menu_choice(gets.chomp)
  break if my_game.players_left < 1 
  my_game.enemies_attack
end
my_game.end
