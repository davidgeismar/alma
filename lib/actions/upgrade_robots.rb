module Actions
  class UpgradeRobots
    def initialize(robot, manager, step)
      @robot = robot
      @manager = manager
      @step = step
    end

    def perform
      puts("bot number #{@robot.id} is upgrading all bots")
      @manager.available_funds -= 12
      @manager.total_expenses += 12
      if @step == :foo
        Actions::MineFoo.upgrade_duration
      elsif @step == :bar
        Actions::MineBar.upgrade_duration
      elsif @step == :foobar
        Actions::Assemble.upgrade_duration
      end
    end
  end
end
