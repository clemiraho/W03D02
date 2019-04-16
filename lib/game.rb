require_relative 'player'
class Game
  attr_accessor :human_player, :ennemies_in_sight, :players_left

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @ennemies_in_sight = []
    @players_left = 10
  end

  def kill_player(dead_player)
    ennemies_in_sight.delete_if { |ennemi| ennemi == dead_player }  #on utilise @var car on ne travail plus avec l'objet direct mais l'objet contenu dans la var d'instance
    players_left -= 1
  end

  def is_still_ongoing?
    human_player.life_points > 0 && players_left > 1
  end

  def show_players
    puts "========= Le joueur #{human_player.name} a #{human_player.life_points} pv ========="
    puts "======== Il y a #{ennemies_in_sight.length} ennemis en vue ======="
  end

  def menu
    puts "\n\nQuelle action veux-tu effectuer ?"
    puts "a - Chercher une meilleure arme"
    puts "s - Se soigner"
    puts "\n\nAttaquer un joueur en vu:"
    ennemies_in_sight.each_with_index { |ennemi, i| puts "#{i} -" + ennemi.show_state }
    print ">"
  end

  def menu_choice(choice)
    case choice
    when "a"
      human_player.search_weapon
    when "s"
      human_player.search_health_pack
    when /[0-9]/
      begin
        human_player.attacks(ennemies_in_sight[choice.to_i])
        kill_player(ennemies_in_sight[choice.to_i]) if ennemies_in_sight[choice.to_i].life_points <= 0  #rescue d'une NoMethodeError au cas où un joueur meurt et qu'on tape quand même une commande
      rescue NoMethodError                                                           #pour attaquer un joueur mort.
        puts "Cette touche n'a pas de choix tampis tu passe ton tour ! \n\n"
      end
    else
      puts "Cette touche n'a pas de choix tampis tu passe ton tour ! \n\n"
    end
  end

  def enemies_attack
    puts "Les autres joueurs attaquent !"
    ennemies_in_sight.each { |ennemi| ennemi.attacks(human_player) if human_player.life_points > 0 }
  end

  def new_players_in_sight
    dice = rand(1..6)
    case dice
    when 1
      puts "Aucun ennemi en vue\n\n"
    when 2..4
      if ennemies_in_sight.count < (players_left - 1)
         ennemies_in_sight << Player.new("player#{rand(1..100)}")
         puts "Un nouvel ennemi en vue !\n\n"
      else
         puts "Tous les ennemis sont déjà en vue\n\n"
      end
    when 5, 6
      if ennemies_in_sight.count < (players_left - 2)
         2.times do
           ennemies_in_sight << Player.new("player#{rand(1..100)}")
         end
         puts "Deux nouveaux ennemis en vue !\n\n"
      else
         puts "Tous les ennemis sont déjà en vue\n\n"
      end
    end
  end

  def end
    puts "Le jeu est fini !"
    ennemies_in_sight.all? {|ennemi| ennemi.life_points <= 0} ? (puts "Bravo ! Tu as gagné !") : (puts "Loser ! Tu as perdu !")
  end
end