require 'rarff'
require 'internet_scrabble_club/db'
include InternetScrabbleClub

def collect_scrabble_states(games)
  states = []

  games.select(&:winner?).each do |game|
    first_player_final_score = game.first_player_final_score
    second_player_final_score = game.second_player_final_score
    final_score_difference = first_player_final_score - second_player_final_score

    next if first_player_final_score < 0 || second_player_final_score < 0

    first_player_current_score = second_player_current_score = 0

    first_player_rating = game.first_player.rating
    second_player_rating = game.second_player.rating

    first_player_average_score = 0
    second_player_average_score = 0

    game.plays.sort_by(&:index).each_slice(2) do |first_player_play, second_player_play|
      if first_player_play.is_a?(Models::Plays::Move)
        first_player_current_score += first_player_play.score
        first_player_average_score = (first_player_current_score.to_f / ((first_player_play.index + 2) / 2))

        if first_player_play.index <= 10
          states << [
            first_player_current_score, second_player_current_score,
            first_player_rating, second_player_rating,
            first_player_average_score, second_player_average_score,
            # first_player_final_score, second_player_final_score
            final_score_difference
          ]
        end
      end

      if second_player_play.is_a?(Models::Plays::Move)
        second_player_current_score += second_player_play.score
        second_player_average_score = (second_player_current_score.to_f / ((second_player_play.index + 1) / 2))

        if first_player_play.index <= 10
          states << [
            first_player_current_score, second_player_current_score,
            first_player_rating, second_player_rating,
            first_player_average_score, second_player_average_score,
            # first_player_final_score, second_player_final_score
            final_score_difference
          ]
        end
      end
    end
  end

  states
end

def build_arff_relation(states)
  Rarff::Relation.new('scrabble-game-states').tap do |arff_relation|
    arff_relation.instances = states

    # TODO: Incorporate move count  / index ...
    arff_relation.attributes[0].name = 'first_player_current_score'
    arff_relation.attributes[1].name = 'second_player_current_score'
    arff_relation.attributes[2].name = 'first_player_rating'
    arff_relation.attributes[3].name = 'second_player_rating'
    arff_relation.attributes[4].name = 'first_player_average_score'
    arff_relation.attributes[5].name = 'second_player_average_score'
    # arff_relation.attributes[6].name = 'first_player_final_score'
    # arff_relation.attributes[7].name = 'second_player_final_score'
    arff_relation.attributes[6].name = 'final_score_difference'
  end
end

def write_to_file(arff_relation, filename)
  File.write(filename, arff_relation.to_arff)
end

task :export_to_arff do
  states = collect_scrabble_states(Models::Game.all)
  arff_relation = build_arff_relation(states)
  write_to_file(arff_relation, ENV.fetch('OUTPUT_FILE'))
end
