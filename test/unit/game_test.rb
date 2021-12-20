require 'minitest/autorun'
require './lib/game'

# Test of game module
class TestGame < Minitest::Unit::TestCase
  def setup
    @variants = [1, 2, 3, 4, 5, 6, 7, 8]
    @data = Game.init @variants.clone
  end

  def test_init
    { round: 1, of: 4, winners: [], completed: false }.to_a.each { |el| assert_includes(@data.to_a, el) }
    assert @data[:opponents].length == 2
    assert @data[:all].length == 6
    assert_equal @variants.sort, @data[:all].concat(@data[:opponents]).sort
  end

  def test_2_of_4
    # 2 of 4
    winner = @data[:opponents].sample
    all = @data[:all].clone
    @data = Game.process @data, winner
    {
      round: 2, of: 4, winners: [winner], completed: false
    }.to_a.each { |el| assert_includes(@data.to_a, el) }
    assert @data[:all].length == 4
    assert_equal all.sort, @data[:all].concat(@data[:opponents]).sort
  end

  def test_3_of_4
    # 2 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 3 of 4
    winner = @data[:opponents].sample
    all = @data[:all].clone
    @data = Game.process @data, winner
    {
      round: 3, of: 4, winners: @data[:winners].push(winner), completed: false
    }.to_a.each { |el| assert_includes(@data.to_a, el) }
    assert @data[:all].length == 2
    assert_equal all.sort, @data[:all].concat(@data[:opponents]).sort
  end

  def test_4_of_4
    # 2 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 3 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 4 of 4
    winner = @data[:opponents].sample
    all = @data[:all].clone
    @data = Game.process @data, winner
    {
      round: 4, of: 4, winners: @data[:winners].push(winner), completed: false
    }.to_a.each { |el| assert_includes(@data.to_a, el) }
    assert @data[:all].empty?
    assert_equal all.sort, @data[:all].concat(@data[:opponents]).sort
  end

  def test_1_of_2
    # 2 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 3 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 4 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 1 of 2
    winner = @data[:opponents].sample
    all = @data[:winners].clone.push(winner)
    @data = Game.process @data, winner
    {
      round: 1, of: 2, winners: [], completed: false
    }.to_a.each { |el| assert_includes(@data.to_a, el) }
    assert @data[:all].length == 2
    assert_equal all.sort, @data[:all].concat(@data[:opponents]).sort
  end

  def test_2_of_2
    # 2 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 3 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 4 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 1 of 2
    @data = Game.process @data, @data[:opponents].sample
    # 2 of 2
    winner = @data[:opponents].sample
    all = @data[:all].clone
    @data = Game.process @data, winner
    {
      round: 2, of: 2, winners: [winner], completed: false
    }.to_a.each { |el| assert_includes(@data.to_a, el) }
    assert @data[:all].length == 0
    assert_equal all.sort, @data[:all].concat(@data[:opponents]).sort
  end

  def test_1_of_1
    # 2 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 3 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 4 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 1 of 2
    @data = Game.process @data, @data[:opponents].sample
    # 2 of 2
    @data = Game.process @data, @data[:opponents].sample
    # 1 of 1
    winner = @data[:opponents].sample
    all = @data[:winners].clone.push(winner)
    @data = Game.process @data, winner
    {
      round: 1, of: 1, winners: [], completed: false
    }.to_a.each { |el| assert_includes(@data.to_a, el) }
    assert @data[:all].empty?
    assert_equal all.sort, @data[:opponents].sort
  end

  def test_completed
    # 2 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 3 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 4 of 4
    @data = Game.process @data, @data[:opponents].sample
    # 1 of 2
    @data = Game.process @data, @data[:opponents].sample
    # 2 of 2
    @data = Game.process @data, @data[:opponents].sample
    # 1 of 1
    @data = Game.process @data, @data[:opponents].sample
    # completed
    winner = @data[:opponents].sample
    @data = Game.process @data, winner
    assert @data[:completed]
  end
end
