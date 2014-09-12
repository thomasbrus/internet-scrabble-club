require_relative '../../../models'

module InternetScrabbleClub
  class Client
    module EntityExtractors
      module Examine

        class History
          def initialize(parsed_response)
            @parsed_response = parsed_response
          end

          def dictionary
            @dictionary ||= InternetScrabbleClub::Models::Dictionary.first_or_new(
              { code: @parsed_response.fetch(:dictionary_code) },
              { code: @parsed_response.fetch(:dictionary_code) }
            )
          end

          def plays
            @plays ||= zipped_parsed_plays.each_with_index.map do |parsed_play, index|
              case parsed_play.fetch(:type)
              when "CHANGE"
                InternetScrabbleClub::Models::Plays::Change.first_or_new(
                  { game_id: self.game.id, index: index },
                  { game: self.game, index: index,
                    rack: parsed_play.fetch(:rack),
                    swap_count: parsed_play.fetch(:swap_count)
                  }
                )
              when "MOVE"
                InternetScrabbleClub::Models::Plays::Move.first_or_new(
                  { game_id: self.game.id, index: index },
                  { game: self.game,
                    index: index,
                    direction: parsed_play.fetch(:position).fetch(:direction),
                    column: parsed_play.fetch(:position).fetch(:column),
                    row: parsed_play.fetch(:position).fetch(:row),
                    word: parsed_play.fetch(:word),
                    score: parsed_play.fetch(:score),
                    rack: parsed_play.fetch(:rack)
                  }
                )
              when "PAS"
                InternetScrabbleClub::Models::Plays::Pass.first_or_new(
                  { game_id: self.game.id, index: index },
                  { game: self.game, index: index,
                    suggestion: parsed_play.fetch(:suggestion)
                  }
                )
              else
                fail "Could not extract play from #{current_parsed_play}"
              end
            end
          end

          def first_player
            @first_player ||= InternetScrabbleClub::Models::Player.first_or_new(
              { nickname: parsed_info_for(:first_player).fetch(:nickname) },
              { nickname: parsed_info_for(:first_player).fetch(:nickname) }
            ).tap do |player|
              player.rating = parsed_info_for(:first_player).fetch(:rating)
            end
          end

          def second_player
            @second_player ||= InternetScrabbleClub::Models::Player.first_or_new(
              { nickname: parsed_info_for(:second_player).fetch(:nickname) },
              { nickname: parsed_info_for(:second_player).fetch(:nickname) }
            ).tap do |player|
              player.rating = parsed_info_for(:second_player).fetch(:rating)
            end
          end

          def game
            @game ||= InternetScrabbleClub::Models::Game.first_or_new(
              { date: @parsed_response.fetch(:date),
                first_player_id: self.first_player.id,
                second_player_id: self.second_player.id
              },
              { date: @parsed_response.fetch(:date),
                first_player_final_score: parsed_info_for(:first_player).fetch(:final_score),
                second_player_final_score: parsed_info_for(:second_player).fetch(:final_score),
                first_player_initial_rack: parsed_info_for(:first_player).fetch(:initial_rack),
                second_player_initial_rack: parsed_info_for(:second_player).fetch(:initial_rack),
                dictionary: self.dictionary,
                first_player: self.first_player,
                second_player: self.second_player
              }
            )
          end

          private def parsed_info_for(player)
            @parsed_response.fetch(player).fetch(:info)
          end

          private def parsed_plays_for(player)
            @parsed_response.fetch(player).fetch(:plays)
          end

          private def zipped_parsed_plays
            parsed_plays_for(:first_player).zip(parsed_plays_for(:second_player)).flatten.compact
          end
        end

      end
    end
  end
end
