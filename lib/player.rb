class Player
    attr_accessor :name, :life_points
    
#initialisation classe, PV et blaze    
  def initialize(name)
    @name = name
    @life_points = 10
  end


  def show_state
    puts "#{@name} a #{@life_points} rondins"
  end


  def gets_damage(damage_received)
      @life_points -= damage_received #inflige dégâts, j'ai préféré la formule -=
      puts "#{@name} pert #{damage_received} bûches de 32! #{@life_points} restant\n"
    if @life_points <= 0 #vérif dommages
      puts "#{@name} perd face à un cul de chouette, c'est fini. Patron une autre tournée!"
    end
  end


  def attacks(player)
    puts "#{@name} attaque #{player.name}..." #lancement attac
    damage_received = compute_damage #calcul dommage
    puts "il fait une chouette de #{damage_received}!" #affiche le résultat
    player.gets_damage(damage_received)
  end

  def compute_damage #méthode aléatoire, bon ok c'était donné dans le cours
    return rand(1..6)
  end

end


class HumanPlayer < Player #héritation de player
  attr_accessor :weapon_level #pas besoin de rajouter les autres, déjà héritage

def initialize(name)
  @weapon_level = 1

  super
  @life_points = 100
end


def show_state
    puts "Tu as #{@life_points} pv et une arme de niveau #{@weapon_level}"
    puts 
end


def compute_damage
    rand(1..6) * @weapon_level
end


def search_weapon
    weapon_level = rand(1..6) #lancé de dès pour arme
    puts "tu as trouvé arme niveau#{weapon_level}\n"
  if weapon_level > @weapon_level
    @weapon_level = weapon_level
    puts "youhou, meilleur arrme tu la garde"
  else
    puts "plus merdique ça dégage"
  end
    puts "Aller appuie sur une touche pour continuer"
    gets.chomp


def search_health_pack
  health = rand (1..6)
  case health
  when 1
    puts "rien trouvé"
  when 2..5
    puts "potion 50pv"
    @health + 50 > 100? @health = 100 : @health + 50
    puts "#{name}, tu as trouvé...ce qui donne 50 pv en rabe"
  else
    puts "super potion trouvé, plus 80"
    @health + 80 > 100 ? @health = 100 : @health = @health + 80
    puts "tu as maintenant plus 80 bûches"
  end
    puts "appuie sur une touche pour continuer"
    gets.chomp
    puts ""
  end
end
  
end



