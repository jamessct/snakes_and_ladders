class Game

attr_reader :players, :target

  def initialize(player_1_name, player_2_name, target, adjuster=nil)
    @players = [
      {name:player_1_name, position: 0},
      {name:player_2_name, position: 0}
    ]
    @current_player_index = 0
    @target = target
    @adjuster = adjuster
  end

  def move_player(player_index, distance)
    player = @players[ player_index ]
    player [:position] += distance
  end

  def current_player ()
    return @players[ @current_player_index ]
  end

  def change_current_player ()
    @current_player_index = (@current_player_index + 1) % @players.length
   #  if (@current_player_index == 0)
   #   @current_player_index = 1 
   # else
   #   @current_player_index = 0
   # end
  end

  def move_current_player(distance)
    move_player( @current_player_index, distance )
  end

  def play_turn(distance)
    info = {
      player_name: current_player[:name],
      roll: distance
    }
    move_current_player( distance )
    if @adjuster
      adjustment = @adjuster.adjustment( current_player()[:position])
      move_current_player(adjustment) if adjustment
      info[:adjustment] = adjustment
    end
    info[:end_position] = current_player[:position]
    change_current_player()
    info
  end

  def winner()
    for player in @players
      return player if player[:position] >= @target
    end
    return false
  end
end