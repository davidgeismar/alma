module Actions
  class MineFoo
    @@original_duration = MINE_FOO_DURATION
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

    # creating new foo and pushing it to both the personnal robot and the global manager
    def perform
      puts("bot number #{@robot.id} is mining foo")
      sleep(@@current_duration)
      new_foo = Foo.new
      @robot.foos.push(new_foo)
      @manager.foos.push(new_foo)
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
