require_relative("manifest")


stopwatch = StopWatch.new(130)
# strategy = ProductionStrategy.new(stopwatch)
manager = Manager.new
ProductionChain.new(stopwatch, manager).start
