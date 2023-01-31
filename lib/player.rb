# Player
class Player
  attr_accessor :name, :life_points, :color

  def initialize(name_init, color_code)
    @name = name_init
    @life_points = 10
    @color = color_code
  end

  def color_name(name)
    @name = "\e[#{@color}m#{name}\e[0m"
  end

  def show_state
    puts "#{color_name(@name)} a \e[4m#{@life_points}\e[24m point#{@life_points > 1 ? 's' : ''} de vie."
  end

  def gets_damage(points)
    @life_points -= points
  end

  def show_dead?
    puts "le joueur #{color_name(@name)} a été tué !" if @life_points <= 0
  end

  def attacks(attacked_player)
    damage = compute_damage
    gets_damage(damage)
    print "le joueur #{color_name(@name)} attaque le joueur #{attacked_player.name}"
    puts " et lui inflige \e[4m#{damage}\e[24m point#{damage > 1 ? 's' : ''} de dommages."
    attacked_player.show_dead?
  end

  def compute_damage
    rand(1..6)
  end
end
