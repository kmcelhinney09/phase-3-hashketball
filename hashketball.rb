require 'pry'
# Write your code below game_hash
def game_hash
  {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black", "White"],
      players: [
        {
          player_name: "Alan Anderson",
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        {
          player_name: "Reggie Evans",
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        {
          player_name: "Brook Lopez",
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        {
          player_name: "Mason Plumlee",
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 11,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        {
          player_name: "Jason Terry",
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      ]
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: [
        {
          player_name: "Jeff Adrien",
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        },
        {
          player_name: "Bismack Biyombo",
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 22,
          blocks: 15,
          slam_dunks: 10
        },
        {
          player_name: "DeSagna Diop",
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        {
          player_name: "Ben Gordon",
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        {
          player_name: "Kemba Walker",
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 7,
          blocks: 5,
          slam_dunks: 12
        }
      ]
    }
  }
end

def players
  all_players_data = []
  game_hash.each do |side,team|
    team[:players].each {|player| all_players_data << player}
  end
  all_players_data
end

def player_names
  players.map {|player| player[:player_name]}
end

def home_players
  game_hash[:home][:players]
end

def away_players
  game_hash[:away][:players]
end

def num_points_scored (player_looking_for)
  player_stats(player_looking_for)[:points]
end

def shoe_size(player_looking_for)
  player_stats(player_looking_for)[:shoe]
end

def team_colors(team_looking_for)
  game_hash.each do |side, team|
    if team[:team_name] == team_looking_for
      return team[:colors]
    end
  end
end

def team_names
  team_names_array = []
  game_hash.each {|side, team| team_names_array << team[:team_name]}
  team_names_array
end

def player_numbers (team_looking_for)
  player_numbers_array = []
  game_hash.each do |side, team|
    if team_looking_for == team[:team_name]
      if side == :home
        home_players.each {|player| player_numbers_array << player[:number]}
      else
        away_players.each {|player| player_numbers_array << player[:number]}
      end
    end
  end
  player_numbers_array
end

def player_stats (player_looking_for)
  players.each do |player|
    if player[:player_name] == player_looking_for
      return player
    end
  end
end

def big_shoe_rebounds
  biggest_shoe = 0
  player_name = ""
  player_names.each do |player|
    shoe = shoe_size(player)
    if shoe > biggest_shoe
      biggest_shoe = shoe
      player_name = player
    end
  end
  player_stats(player_name)[:rebounds]
end

def most_points
  most_points = 0
  player_name = ""
  player_names.each do |player|
    player_points = num_points_scored(player)
    if player_points > most_points
      most_points = player_points
      player_name = player
    end
  end
  player_name
end

def winning_team
  scores = {}
  home_name = game_hash[:home][:team_name]
  away_name = game_hash[:away][:team_name]
  home_score = home_players.map {|player| player[:points]}.sum
  away_score = away_players.map {|player| player[:points]}.sum
  scores[home_name] = home_score
  scores[away_name] = away_score
  scores.max_by {|k,v| v}[0]
end

def player_with_longest_name
  length_array = {}
  player_names.each do |player|
    name = player
    size = player.length
    length_array[name] = size
  end
  length_array.max_by {|k,v| v}[0]
  
end

def long_name_steals_a_ton?
  steals = {}
  players.each do |player|
    name = player[:player_name]
    num_of_steals = player[:steals]
    steals[name] = num_of_steals
  end
  most_steals = steals.max_by {|k,v| v}[0]
  most_steals == player_with_longest_name
end