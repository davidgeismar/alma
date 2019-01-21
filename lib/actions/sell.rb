module Actions
  class Sell
    @@duration = 1
    def initialize(foobar, robot, manager)
      @foobar = foobar
      @robot = robot
      @manager = manager
    end

    def perform
      puts("bot number #{@robot.id} is selling")
      sleep(@@duration)
      sells = rand(1..5)
      @robot.funds += sells
      @manager.available_funds += sells
      puts("total profit is #{@manager.available_funds}")
      puts("bot number #{@robot.id} made #{@robot.funds} euros")
      while sells >= 0
        sells = sells - 1
        @manager.foobars.delete_at(sells)
      end
    end
  end
end
