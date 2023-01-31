require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new('Josiane', 34)
player2 = Player.new('José', 35)

puts "\n__\nVoici l'état de chaque joueur :"
player1.show_state
player2.show_state

puts "\n__\nPassons à la phase d'attaque :"
while player1.life_points.positive? && player2.life_points.positive?
  player1.attacks(player2)
  player2.life_points.positive? ? player2.attacks(player1) : break
end
