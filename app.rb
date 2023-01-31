require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/human_player'

#############
# v1
#############

def perform_app_v1
  puts "\n\n~~~~~~~~~~~\nMINI JEU V1\n~~~~~~~~~~~"

  # Creating 2 players
  player1 = Player.new('Josiane', 34)
  player2 = Player.new('José', 35)

  # Showing players' initial state
  puts "\n\n• Voici l'état de chaque joueur :\n"
  player1.show_state
  player2.show_state

  # Making the players fight
  puts "\n\n• Passons à la phase d'attaque :\n"
  i = 0
  while player1.life_points.positive? && player2.life_points.positive?
    i += 1
    puts "––> tour #{i}"
    player1.attacks(player2)
    player2.life_points.positive? ? player2.attacks(player1) : break
  end

  # Showing players' final state
  puts "\n\n• Voici l'état de chaque joueur :\n"
  player1.show_state
  player2.show_state
end

#############
# v2
#############

def perform_app_v2
  puts "\n\n~~~~~~~~~~~\nMINI JEU V2\n~~~~~~~~~~~"

  # Creating player and enemies
  puts "\nQuel est votre prénom ?"
  print '> '
  name = gets.chomp
  player1 = HumanPlayer.new(name, 36)
  enemies = [Player.new('Josiane', 34), Player.new('José', 35)]

  # Making the player fights with enemies
  puts "\n\nAU COMBAT !\n"
  i = 0

  while player1.life_points.positive? && (enemies[0].life_points.positive? || enemies[1].life_points.positive?)
    i += 1
    puts "\n––> tour #{i} <––"

    # player1's turn
    player1.show_state
    case request_action(enemies)
    when 'a'; player1.search_weapon
    when 's'; player1.search_health_pack
    when '0'; player1.attacks(enemies[0])
    when '1'; player1.attacks(enemies[1])
    else; break
    end
    puts "\n"

    # enemies' turn
    if (enemies[0].life_points.positive? || enemies[1].life_points.positive?)
      puts "\nRiposte des opposants :"
      enemies.each do |enemy|
        enemy.attacks(player1) if enemy.life_points.positive?
      end
    end

  end

  # Showing results
  puts player1.life_points.positive? ? "\n\nBRAVO ! VOUS AVEZ GAGNÉ !\n" : "\n\nLoser ! Vous avez perdu !"
end

def request_action(enemies)
  puts "\nQuelle action voulez-vous effectuer ?"
  puts "[a] -> chercher une meilleure arme"
  puts "[s] -> chercher à se soigner"
  puts "[0] -> attaquer #{enemies[0].name} (#{enemies[0].life_points} point(s) de vie)"
  puts "[1] -> attaquer #{enemies[1].name} (#{enemies[1].life_points} point(s) de vie)"
  print '> '
  gets.chomp
end

#############
# v3
#############

def perform_app_v3
  puts "\n\n~~~~~~~~~~~\nMINI JEU V3\n~~~~~~~~~~~"

  # Launching game
  puts "\nQuel est votre prénom ?"
  print '> '
  name = gets.chomp
  my_game = Game.new(name)

  # Making the player fights with enemies
  puts "\n\nAU COMBAT !\n"
  i = 0
  while my_game.still_ongoing?
    i += 1
    puts "\n––> tour #{i} <––"

    my_game.show_players
    choice = my_game.get_choice
    puts "\n"
    my_game.run_action(choice)

    puts "\nRiposte des opposants :"
    my_game.enemies_attack
  end

  # Ending
  my_game.end
end

#############
# CLI menu
#############

puts "\nBienvenue !"
puts "\nQuelle version voulez-vous jouer ?"
print "\n[1] ou [2] ou [3] > "
choice = gets.chomp

case choice
when '1'
  perform_app_v1
when '2'
  perform_app_v2
when '3'
  perform_app_v3
end
