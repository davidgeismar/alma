module Actions
  class BuyNewBot
    def initialize(robot, manager)
      @robot = robot
      @manager = manager
    end

    def perform
      puts("bot number #{@robot.id} is buying a new bot")
      @robot.available_funds -= 4 # it costs 4 euros to buy a new bot
      @manager.available_funds -= 4
      @manager.total_expenses += 4
      puts(@manager.available_funds)
      Thread.new { Robot.new(@robot.stopwatch, @manager).get_to_work! }
    end
  end
end
