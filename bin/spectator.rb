#!/usr/bin/env ruby

require 'pp'

require 'celluloid'
require 'internet_scrabble_club/client'

Celluloid.logger.level = Logger::INFO

class Spectator
  include Celluloid
  include InternetScrabbleClub::Entities

  def initialize(nickname, password)
    @client = InternetScrabbleClub::Client.new
    @client.authenticate(nickname, password)
    @client.on_message { |message| handle_message(message) }
  end

  def handle_message(message)
    puts message.inspect
    # case message.command
    # when /(UN)?SEEK/
    #   10.times { |i| @client.send_message('EXAMINE', 'HISTORY', message.nickname, i) }
    # when /EXAMINE/
    #   game_attributes = construct_game_from_message(message)
    #   persist_game(game_attributes)
    # end
  end

  # private

  # def persist_game(game_attributes)
  #   game = Game.create!(game_attributes)
  #   report_game_created(game)
  # end

  # def report_game_created(game)
  #   puts "(#{game.id}), at #{game.date}, by #{game.players.map(&:nickname).join(' & ')}, #{game.plays.count} plays in total."
  # end

  # def construct_game_from_message(message)
  #   players = collect_from_setup(message) do |setup|
  #     nickname, rating = setup.values_at(:nickname, :rating)
  #     player = Player.new(nickname: nickname, rating: rating)
  #   end

  #   initial_racks = collect_from_setup(message) { |setup| setup.fetch(:initial_rack) }
  #   final_scores = collect_from_setup(message) { |setup| setup.fetch(:final_score) }

  #   create_play_object = ->(play_attributes) {
  #     case play_attributes.delete(:type)
  #     when 'MOVE' then Plays::Move.new(play_attributes)
  #     when 'CHANGE' then Plays::Change.new(play_attributes)
  #     when 'PAS' then Plays::Pass.new(play_attributes)
  #     end
  #   }

  #   first_player_plays = message.first_player.plays.map do |play|
  #     create_play_object.call(play.to_h.merge(player: players[0]))
  #   end

  #   second_player_plays = message.second_player.plays.map do |play|
  #     create_play_object.call(play.to_h.merge(player: players[1]))
  #   end

  #   plays = first_player_plays.zip(second_player_plays)
  #     .flatten(1).compact.each_with_index.map { |play, index| play.index = index; play }

  #   { date: message.date,
  #     dictionary_code: message.dictionary_code,
  #     initial_racks: initial_racks,
  #     final_scores: final_scores,
  #     plays: plays,
  #     players: players
  #   }
  # end

  # def collect_from_setup(message)
  #   [:first, :second].collect { |prefix| yield(message.send(:"#{prefix}_player").setup) }
  # end
end


if ARGV.length < 2
  fail "Please provide nickname and password: bin/spectator <nickname> <password>"
end

Spectator.new(ARGV[0], ARGV[1])

sleep
