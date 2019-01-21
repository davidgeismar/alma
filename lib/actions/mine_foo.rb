module Actions
  class MineFoo
    @@original_duration = 1
    @@current_duration = @@original_duration
    def initialize(robot, manager)
      @robot = robot
      @manager = manager
    end
    def self.current_duration
      @@current_duration
    end

    def self.original_duration
      @@original_duration
    end

    def perform
      puts("bot number #{@robot.id} is mining foo")
      sleep(@@duration)
      @manager.foos.push(Foo.new)
    end

    def self.upgrade_duration
      unless (@@current_duration - 0.1*@@current_duration) < (@@original_duration / 2)
        @@current_duration = @@current_duration - 0.1* @@current_duration
      else
        Manager.change_upgrade_step(:stop)
      end
    end
  end
end
