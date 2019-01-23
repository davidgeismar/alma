module Actions
  class BuyNewBot
    @@cost = BUY_NEW_ROBOT_COST
    def initialize(robot, manager)
      @robot = robot
      @manager = manager
    end

    def perform
      puts("bot number #{@robot.id} is buying a new bot")
      updating_expenses_data
      # launching new bot
      Thread.new { Robot.new(@robot.stopwatch, @manager).get_to_work! }
    end

    def updating_expenses_data
      @robot.available_funds -= @@cost # it costs 4 euros to buy a new bot
      @manager.available_funds -= @@cost
      @manager.total_expenses += @@cost
      puts(@manager.available_funds)
    end
  end
end
