
class StopWatch
  attr_accessor :start, :running, :duration, :elapsed
  # duration in seconds
  def initialize(duration=60)
    @start = Time.now
    @duration = duration
    @running = true
    @elapsed = 0
  end

  def start
    while @elapsed < @duration
      @elapsed = Time.now - @start
    end
    @running = false
  end
end
