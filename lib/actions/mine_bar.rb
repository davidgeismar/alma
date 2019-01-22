module Actions
  class MineBar
    @@original_duration = rand(0.1..0.3)
    @@current_duration = @@original_duration
    def initialize(robot, manager)
      @robot = robot
      @manager = manager
    end

    def perform
      puts("bot number #{@robot.id} is mining bar")
      sleep(@@current_duration)
      new_bar = Bar.new
      @robot.bars.push(new_bar)
      @manager.bars.push(new_bar)
    end

    def self.original_duration
      @@original_duration
    end

    def self.current_duration
      @@current_duration
    end
    # an upgrade of mining duration of 10% of current mining_duration unless we are already at 50% of original mining_duration
    def self.upgrade_duration
      unless (@@current_duration - 0.1*@@current_duration) < (@@original_duration / 2)
        @@current_duration = @@current_duration - 0.1* @@current_duration
      else
        Manager.change_upgrade_step(:foo)
      end
    end
  end
end
