module Actions
  class Assemble
    @@original_duration = 2
    @@success_probability = 0.8
    @@current_duration = @@original_duration
    # ratio success to calculate the average production duration
    @@ratio_success = 1/@@success_probability

    def initialize(foo, bar, robot, manager)
      @foo = foo
      @bar = bar
      @robot = robot
      @manager = manager
    end

    def self.ratio_success
      return @@ratio_success
    end
    def self.current_duration
      return @@current_duration
    end
    def self.success_probability
      @@success_probability
    end

    def self.original_duration
      @@original_duration
    end

    def perform
      sleep(@@current_duration)
      puts("bot number #{@robot.id} is assembling")
      current_foo = @manager.foos.shift
      current_bar = @manager.bars.shift
      status = operation_status
      @manager.foos = @manager.foos.reject { |foo| foo.id == current_foo.id }
      if status == :success
        # bar peut etre reutilise mais pas le foo
        @manager.total_produced += 1
        puts("this production chain has produced #{@manager.total_produced} foobars")
        @manager.bars =  @manager.bars.reject { |bar| bar.id == current_bar.id }
        @manager.foobars.push(Foobar.new(current_foo, current_bar))
      end
    end
    # upgrade of 10% of current assemble duration unless we are already at 50% of original assemble_duration
    def self.upgrade_duration
      unless (@@current_duration - 0.1*@@current_duration) < (@@original_duration / 2)
        @@current_duration = @@current_duration - 0.1* @@current_duration
      else
        Manager.change_upgrade_step(:bar)
      end
    end

    private
      # returns if the assemble phase is a success or not
    def operation_status
      arr = []
      10.times {arr << :failure}
      arr.each_with_index do |element, index|
        break if index ==  @@success_probability*10
        arr[index] = :success
      end
      return arr.sample
    end
  end
end