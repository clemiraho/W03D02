require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Karadoc de Vannes")
player2 = Player.new("Provençal le Gaulois")

while player1.life_points > 0 && player2.life_points > 0
  puts "Voici le nombre de velutes qu'ils leurs restent :\n"
	player1.show_state
	player2.show_state
	puts

	puts "Passons au lancement des cartes :\n "
	player1.attacks(player2)
		if player2.life_points <= 0
			break
		end
	player2.attacks(player1)
		if player1.life_points <= 0
			break
		end
	puts
end

