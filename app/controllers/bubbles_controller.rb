class BubblesController < ApplicationController
  before_action :set_user, only: %i[create update destroy]
  before_action :set_bubble, only: %i[show update destroy]

  # GET /bubbles/1/stats
  def stats
    bubble = Bubble
             .where(id: params[:bubble_id])
             .select('title, description, games_count, id')
             .first
    bubble_response = bubble
                      .as_json
                      .merge({
                               bubble_variants: bubble.bubble_variants
                                 .order(won_times: :desc)
                                 .map do |variant|
                                   variant
                                     .as_json
                                     .slice('name', 'won_times')
                                     .merge({ image: variant.cdn_image })
                                     .merge({ winrate: (variant.won_times * 100.0 / bubble.games_count).round(2) })
                                 end
                             })

    render json: bubble_response
  end

  # GET /bubbles/1
  def single
    bubble = Bubble.where(id: params[:bubble_id]).select('title, description').first
    return head(404) unless bubble

    render json: bubble
  end

  # GET /bubbles
  def index
    bubbles = if params[:user_id]
                Bubble
                  .where(user_id: params[:user_id])
              else
                Bubble
              end
              .joins(:user)
              .select('
                bubbles.title,
                bubbles.description,
                bubbles.id,
                bubbles.variants_count,
                users.id as user_id,
                users.username')
              .all
              .map do |bubble|
                bubble
                  .as_json
                  .merge({
                           images: BubbleVariant
                                     .where(bubble_id: bubble.id)
                                     .order(:won_times)
                                     .limit(2)
                                     .map(&:cdn_image)
                         })
              end
    render json: bubbles
    # render json: bubbles
  end

  # GET /bubbles/1
  def show
    render json: @bubble
  end

  def create
    bubble = @user.bubbles.new(
      title: params[:title],
      description: params[:description],
      variants_count: params[:variants_count]
    )
    variants =
      params
      .keys
      .filter { |v| v.include?('image') || v.include?('name') }
      .group_by { |v| v.split('-')[1] }
      .values
      .map { |v| { name: params[v.find { |i| i.include? 'name' }], image: params[v.find { |i| i.include? 'image' }] } }
      .map do |obj|
        variant = BubbleVariant.new(name: obj[:name])
        variant.image.attach obj[:image] unless ['', 'undefined'].include? obj[:image]
        variant.bubble = bubble
        variant
      end
    errors = nil
    errors = bubble.errors if bubble.invalid?
    if variants.any?(&:invalid?)
      errors =
        variants
        .each_with_index
        .map do |v, i|
          v.invalid? ?
            v.errors.map { |err|  { "bubble_variants.#{i}.#{err.attribute}": v.errors.messages_for(err.attribute) } } :
            nil
        end
        .reject(&:nil?)
        .flatten
        .reduce({}) {|i, h| h.merge i}
        .merge(errors || {})
    end
    return render json: { errors: errors } if errors

    bubble.save
    variants.each(&:save)
    render json: { success: true }
  end

  # PATCH/PUT /bubbles/1
  def update
  end

  # DELETE /bubbles/1
  def destroy
    @bubble.destroy
  end

  private
  def set_bubble
    @bubble = Bubble.find(params[:id])
  end
end
