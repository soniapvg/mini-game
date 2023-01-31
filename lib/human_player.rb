# Human player
class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name_init, color_code)
    super(name_init, color_code)
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "\nVous avez :"
    puts "♥ \e[4m#{@life_points}\e[24m point#{@life_points > 1 ? 's' : ''} de vie"
    puts "► une arme de niveau \e[4m#{@weapon_level}\e[24m"

    # super
    # puts "-> une arme de niveau \e[4m#{@weapon_level}\e[24m"
  end

  def compute_damage
    super * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
    if new_weapon_level > @weapon_level
      @weapon_level = new_weapon_level
      puts 'Youhou ! elle est meilleure que ton arme actuelle : tu la prends.'
    else
      puts "Dommage... elle n'est pas mieux que ton arme actuelle."
    end
  end

  def search_health_pack
    case rand(1..6)
    when 1
      puts "Tu n'as rien trouvé..."
    when 2..5
      (@life_points + 50) > 100 ? @life_points = 100 : @life_points += 50
      puts 'Bravo, tu as trouvé un pack de +50 points de vie !'
    when 6
      (@life_points + 80) > 100 ? @life_points = 100 : @life_points += 80
      puts 'Waow, tu as trouvé un pack de +80 points de vie !'
    end
  end
end
