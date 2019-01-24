require_relative("manifest")


stopwatch = StopWatch.new(ARGV[0].to_i)
# strategy = ProductionStrategy.new(stopwatch)
manager = Manager.new
ProductionChain.new(stopwatch, manager).start
