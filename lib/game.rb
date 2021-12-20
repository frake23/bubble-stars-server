module Game
  def init(variants)
    of = variants.length / 2
    opponents = [variants.delete(variants.sample), variants.delete(variants.sample)]
    {
      round: 1,
      of: of,
      all: variants,
      winners: [],
      opponents: opponents,
      completed: false
    }
  end

  def process(data, selected)
    return data.merge({ completed: true }) if data[:of] == 1

    data[:winners] << selected
    round = data[:round] + 1
    if round > data[:of]
      data[:round] = 1
      data[:of] = data[:of] / 2
      data[:all] = data[:winners]
      data[:winners] = []
    else
      data[:round] = round
    end
    data[:opponents] = [data[:all].delete(data[:all].sample), data[:all].delete(data[:all].sample)]
    data
  end

  module_function :init, :process
end
