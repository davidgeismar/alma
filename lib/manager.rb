# keeps track of the global data of production chain at any duration
class Manager
  attr_accessor :available_funds,
                :total_produced,
                :total_revenue,
                :total_expenses,
                :current_upgrade_step,
                :foos,
                :bars,
                :foobars
  @@bot_count = 0
  @@buy_bot_production_gains_ratio = 1/::Foobar.average_current_production_duration


  def initialize
    @bars = []
    @foos = []
    @foobars = []
    @total_produced = 0
    @available_funds = 0
    @total_revenue = 0
    @total_expenses = 0
    @current_upgrade_step = :foobar
  end

  # sets the correct phase to upgrade
  def self.change_upgrade_step(step)
    @current_upgrade_step = step
  end

  def buy_bot_production_gains_ratio
    return @@buy_bot_production_gains_ratio
  end
  def bot_count
    return @@bot_count
  end
  # for testing purposes
  def set_bot_count(bot_count)
    @@bot_count = bot_count
  end

  def generate_bot_id
    @@bot_count += 1
    return @@bot_count
  end
end
