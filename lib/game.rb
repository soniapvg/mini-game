# Game
class Game
  attr_accessor :human_player, :enemies, :remaining_players, :enemies_in_sight

  def initialize(human_player_name)
    @human_player = HumanPlayer.new(human_player_name, 32)
    @remaining_players = 10
    @enemies_in_sight = []
  end

  def kill_player(player)
    @enemies_in_sight -= [player]
  end

  def new_players_in_sight
    return if @enemies_in_sight.length >= @remaining_players

    case rand(1..6)
    when 1
      if @enemies_in_sight.empty?
        @enemies_in_sight << Player.new("ennemie #{rand(1..100)}", rand(31..39))
        puts "\n▲ 1 nouvel ennemie en vue\n"
      else
        puts "\n▲ aucun nouvel ennemie ajouté\n"
      end
    when 2..4
      @enemies_in_sight << Player.new("ennemie #{rand(1..100)}", rand(31..39))
      puts "\n▲ 1 nouvel ennemie en vue\n"
    when 5, 6
      @enemies_in_sight << Player.new("ennemie #{rand(1..100)}", rand(31..39))
      @enemies_in_sight << Player.new("ennemie #{rand(1..100)}", rand(31..39))
      puts "\n▲ 2 nouveaux ennemies en vue\n"
    end
  end

  def still_ongoing?
    @human_player.life_points.positive? && !@enemies_in_sight.empty?
  end

  def show_players
    @human_player.show_state
    puts "\n▲ Ennemies restants : #{@enemies_in_sight.length}"
  end

  def fetch_choice
    puts "\nQuelle action voulez-vous effectuer ?"
    puts "[a] -> chercher une meilleure arme"
    puts "[s] -> chercher à se soigner"
    enemies_in_sight.each_with_index do |enemy, index|
      puts "[#{index}] -> attaquer #{enemy.name} (#{enemy.life_points} point#{enemy.life_points > 1 ? 's' : ''} de vie)"
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
    when 0...@enemies_in_sight.length
      target = enemies_in_sight[player_input]
      @human_player.attacks(target)
      kill_player(target) unless target.life_points.positive?
    end
  end

  def enemies_attack
    enemies_in_sight.each do |enemy|
      enemy.attacks(@human_player) if @human_player.life_points.positive?
    end
  end

  def end
    puts @human_player.life_points.positive? ? "\n\nBRAVO ! VOUS AVEZ GAGNÉ !\n" : "\n\nLoser ! Vous avez perdu !"
  end
end
