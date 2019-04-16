require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def Home
puts "-------------------------------------------------"
puts "|        Prêt à jouer au cul de chouette !      |"
puts "|  Le but du jeu est d'être le ..... gagnant !  |"
puts "-------------------------------------------------"
end

def init_player
    print "Quel est ton nom, Manant ? "
    player_name = gets.chomp
    print "=>"
    puts 
    puts "prends place #{player_name} !"
    puts
    player_human = HumanPlayer.new(player_name)
    return player_human
  end
  
  
  human = init_player #créa ennemis
  
  enemie1 = Player.new("Karadoc de Vannes")
  enemie2 = Player.new("Provençal le Gaulois")
  enemies = [enemie1,enemie2]
  
  while human.life_points>0 && (enemie1.life_points > 0 || enemie2.life_points >0)
    
    human.show_state #statute human
  
    # quelle action
    
    puts "Tu commence par quoi ?"
    puts "a - Tricher mieux avec arme?"
    puts "s - Utiliser le Graal pour se soigner?"
    puts "attaquer un joueur :"
    if enemie1.life_points > 0
      print "0 - "
      enemie1.show_state
    end
    if enemie2.life_points > 0
      print "1 - "
      enemie2.show_state
    end
    
    puts "Votre choix ?"
    action = gets.chomp
    print "=>"
  
    #choix action
    if action == "a"
      human.search_weapon
    end
    if action == "s" #problème de retour vers player.rb / revoir méthode ruby.docs
      human.search_health_pack
    end
    if action == "0 --" && enemie1.life_points > 0
      human.attacks(enemie1)
    end
    if action == "1 --" && enemie2.life_points > 0
      human.attacks (enemie2)
    end
  
    puts "attention au cul de chouette ok?"
    puts 
    
    # attaque ennemis
    if enemie2.life_points > 0 && enemie1.life_points > 0
       puts "Attaque des autres glands !"
    end
    enemies.each do | enemie |
      if enemie.life_points > 0
        enemie.attacks(human)
      end
    end
  
  end
  
  

  puts "    Terminé, fini!    "
  if human.life_points > 0
    puts "BRAVO ! TU AS GAGNE.....le droit de payer ton coup !"
  else 
    puts "Loser ! Tu as perdu ! Tu fais la prochaine quête avec le roi"
  end
  