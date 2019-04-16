require_relative 'player'
class Game
  attr_accessor :human_player, :ennemies_in_sight, :players_left

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @ennemies_in_sight = []
    @players_left = 10
  end

  def kill_player(dead_player)
    ennemies_in_sight.delete_if { |ennemi| ennemi == dead_player }  
    players_left -= 1
  end

  def is_still_ongoing?
    human_player.life_points > 0 && players_left > 1
  end

  def show_players
    puts "Le joueur #{human_player.name} a #{human_player.life_points} bûches"
    puts "Il y a #{ennemies_in_sight.length} glands encore"
  end

  def menu
    puts "Quest-ce-que toi tu fais?"
    puts "a - Un meilleur quignon de pain à envoyé sur le voisin"
    puts "s - Encore une fois le Graal pour soigner"

    
    puts "Attaquer un gland:"
    ennemies_in_sight.each_with_index { |ennemi, i| puts "#{i} -" + ennemi.show_state }
    print "=>"
  end

  def menu_choice(choice)                      #le problème se situ dans ces environs, mais là j'ai les yeux qui se croisent
                                               #tant pis, I'll try again next time
    case choice
    when "a"
      human_player.search_weapon
    when "s"
      human_player.search_health_pack
    when /[0-9]/
      begin
        human_player.attacks(ennemies_in_sight[choice.to_i])
        kill_player(ennemies_in_sight[choice.to_i]) if ennemies_in_sight[choice.to_i].life_points <= 0                                                         
        puts "Hey ça passe son tour !"
      end
    else
      puts "Hey ça passe son tour !"
    end
  end

  def enemies_attack
    puts "Les autres glands arrivent !"
    ennemies_in_sight.each { |ennemi| ennemi.attacks(human_player) if human_player.life_points > 0 }
  end

  def new_players_in_sight
    dice = rand(1..6)
    case dice
    when 1
      puts "Rien à voir on dégage"
    when 2..4
      if ennemies_in_sight.count < (players_left - 1)
         ennemies_in_sight << Player.new("player#{rand(1..100)}")
         puts "Un autre gland arrive !"
      else
         puts "Ils sont déjà tous là"
      end
    when 5, 6
      if ennemies_in_sight.count < (players_left - 2)
         2.times do
           ennemies_in_sight << Player.new("player#{rand(1..100)}")
         end
         puts "Deux glandus nouveaux !"
      else
         puts "Ils sont déjà tous là"
      end
    end
  end

  def end
    puts "Le jeu est ............... fini !"
    ennemies_in_sight.all? {|ennemi| ennemi.life_points <= 0} ? (puts "Bravo ! Tu as gagné ! Maintenant on va jouer à saute Sloubi") : (puts "Loser ! Tu as perdu !")
  end
end