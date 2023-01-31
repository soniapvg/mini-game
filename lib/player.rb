# Player
class Player
  attr_accessor :name, :life_points

  def initialize(name_init, color_code)
    @name = "\e[#{color_code}m#{name_init}\e[0m"
    @life_points = 10
  end

  def show_state
    puts "#{@name} a :"
    puts "♥ \e[4m#{@life_points}\e[24m point#{@life_points > 1 ? 's' : ''} de vie"
  end

  def gets_damage(points)
    @life_points -= points
  end

  def show_dead?
    puts "★ le joueur #{@name} a été tué !" if @life_points <= 0
  end

  def attacks(attacked_player)
    damage = compute_damage
    attacked_player.gets_damage(damage)
    print "le joueur #{@name} attaque le joueur #{attacked_player.name}"
    puts " et lui inflige \e[4m#{damage}\e[24m point#{damage > 1 ? 's' : ''} de dommages."
    attacked_player.show_dead?
  end

  def compute_damage
    rand(1..6)
  end
end
