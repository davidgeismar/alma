module Actions
  class Sell
    @@duration = SELL_DURATION
    def initialize(robot, manager)
      @robot = robot
      @manager = manager
    end

    def perform
      puts("bot number #{@robot.id} is selling")
      sleep(@@duration)
      # number of foobars we can sell
      sells = rand(1..5)
      retrieving_foobars_from_stock(sells)
      updating_sells_data(sells)
    end

    private

    def retrieving_foobars_from_stock(sells)
      picked_foobar_ids = @robot.foobars.first(sells).map(&:id) #pick the n first foobars from the robot's foobars
      @robot.foobars.shift(sells) #getting the n first foobars out
      @manager.foobars.reject{|foobar| picked_foobar_ids.include?(foobar.id)}
    end

    def updating_sells_data(sells)
      @robot.available_funds += sells
      @manager.available_funds += sells
      @manager.total_revenue += sells
      puts("total profit is #{@manager.available_funds}")
      puts("bot number #{@robot.id} made  #{sells} and now has #{@robot.available_funds} euros as available_funds")
    end
  end
end
