# Game
class Game
  attr_accessor :human_player, :enemies

  def initialize(human_player_name)
    @human_player = HumanPlayer.new(human_player_name, 32)
    @enemies = [
      Player.new('Josiane', 33),
      Player.new('José', 34),
      Player.new('Joséphine', 35)
    ]
  end

  def kill_player(player)
    @enemies -= [player]
  end

  def still_ongoing?
    @human_player.life_points.positive? && !@enemies.empty?
  end

  def show_players
    @human_player.show_state
    puts "\n☹ Ennemies restants : #{@enemies.length}"
  end

  def get_choice
    puts "\nQuelle action voulez-vous effectuer ?"
    puts "[a] -> chercher une meilleure arme"
    puts "[s] -> chercher à se soigner"
    enemies.each_with_index do |enemy, index|
      puts "[#{index}] -> attaquer #{enemy.name} (#{enemy.life_points} point(s) de vie)"
    end
    puts "[q] -> quitter le jeu"
    print '> '
    gets.chomp
  end

  def run_action(player_input)
    player_input = player_input.to_i unless %w(a s q).include? player_input
    case player_input
    when 'q'
      exit
    when 'a'
      @human_player.search_weapon
    when 's'
      @human_player.search_health_pack
    when 0...@enemies.length
      target = enemies[player_input]
      @human_player.attacks(target)
      kill_player(target) unless target.life_points.positive?
    end
  end

  def enemies_attack
    enemies.each { |enemy| enemy.attacks(@human_player) }
  end

  def end
    puts @human_player.life_points.positive? ? "\n\nBRAVO ! VOUS AVEZ GAGNÉ !\n" : "\n\nLoser ! Vous avez perdu !"
  end
end
