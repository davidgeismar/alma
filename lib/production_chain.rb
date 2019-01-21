class ProductionChain
  def initialize(stopwatch, manager)
    @stopwatch = stopwatch
    @manager = manager
  end

  def start
    Thread.new { Robot.new(@stopwatch, @manager).get_to_work! } # this is the master bot, it knows our strategy
    Thread.new { Robot.new(@stopwatch, @manager).get_to_work! }
    Thread.new { @stopwatch.start}
    Thread.list.each { |t| t.join if t != Thread.main}
  end
end
