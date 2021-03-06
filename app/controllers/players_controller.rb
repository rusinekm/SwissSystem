class PlayersController < ApplicationController

  def index
    @players = Player.where(tournament_id: params[:tournament_id]).order(victory_points_sum: :desc, battle_points_sum: :desc)
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      if request.xhr?
        render partial: 'tournaments/players_table', locals: { tournament: @player.tournament}
      else
        redirect_to tournament_path(@player.tournament_id)
      end
    else
      render partial: '_player_form', locals: {player: @player}
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :surname, :tournament_id)
  end
end