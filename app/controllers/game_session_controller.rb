require 'game'

class GameSessionController < ApplicationController
  before_action :get_from_cache
  after_action :write_in_cache

  def process_game
    @game_data = if @game_data
                   params[:bubble_variant_id] ? Game.process(@game_data, params[:bubble_variant_id]) : @game_data
                 else
                   Game.init Bubble.find_by_id(params[:bubble_id]).bubble_variants.pluck(:id)
                 end

    return render json: {
      completed: false,
      bubble_variants: @game_data[:opponents].map do |id|
        bubble_variant = BubbleVariant.find_by_id(id)
        { id: id, image: bubble_variant.cdn_image, name: bubble_variant.name }
      end,
      round: @game_data[:round],
      of: @game_data[:of]
    } unless @game_data[:completed]

    Bubble.find_by_id(params[:bubble_id]).increment!(:games_count)
    BubbleVariant.find_by_id(params[:bubble_variant_id]).increment!(:won_times)
    render json: { completed: true }
  end

  private
  def get_from_cache
    @game_data = Rails.cache.read cache_key
  end

  def write_in_cache
    Rails.cache.write cache_key, @game_data, expires_in: 1.hour
    clear_cache if @game_data[:completed]
  end

  def clear_cache
    Rails.cache.delete cache_key
  end

  def cache_key
    "game-session/#{params[:bubble_id]}/#{session.id}"
  end
end
