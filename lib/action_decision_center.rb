# keeps track of the global data of production chain at any duration
class ActionDecisionCenter

  def initialize(manager, robot)
    @manager = manager
    @robot = robot
  end

  # sets the correct phase to upgrade
  def self.change_upgrade_step(step)
    @manager.current_upgrade_step = step
  end

  def choose_action
    puts("in choose action")
    if @manager.foobars.size < 5
      action = ::Actions::Assemble.new(@manager.foos.shift, @manager.bars.shift, @robot, @manager)
    elsif 12 >  @manager.available_funds
      action = ::Actions::Sell.new(@manager.foobars.shift, @robot, @manager)
    elsif @manager.available_funds >= 12
      action = compare_production_improvement_ratio
    end
    action.perform
  end
  # check if buying a bot or buying an improvement is more interesting
  def compare_production_improvement_ratio
    upgrade_production_gains = simulate_upgrade_production_gains
    if upgrade_production_gains > 3*@manager.buy_bot_production_gains_ratio
    # if upgrade_production_gains > 0.001
      return ::Actions::UpgradeRobots.new(@robot, @manager, @manager.current_upgrade_step)
    else
      return ::Actions::BuyNewBot.new(@robot, @manager)
    end
  end

  # simulates the gains obtained by an upgrade on all bots on the current more interesting step
  def simulate_upgrade_production_gains
    new_production_duration = compute_new_production_duration(@manager.current_upgrade_step) #assemble duration
    duration_gains = Foobar.average_current_production_duration - new_production_duration
    individual_production_gains =  duration_gains/Foobar.average_current_production_duration
    global_production_gains = @manager.bot_count*individual_production_gains
    return global_production_gains
  end

  # need to add the limit of 50%
  def compute_new_production_duration(step)
    if step == :foo
      new_foo_mining_duration = Actions::MineFoo.current_duration - 0.1*Actions::MineFoo.current_duration
      return  Actions::Assemble.ratio_success * new_foo_mining_duration + Actions::MineBar.current_duration + Actions::Assemble.ratio_success * Actions::Assemble.current_duration
    elsif step == :bar
      new_bar_mining_duration = Actions::MineBar.current_duration - 0.1*Actions::MineBar.current_duration
      return  Actions::Assemble.ratio_success * Actions::MineFoo.current_duration + Actions::MineBar.new_bar_duration + Actions::Assemble.ratio_success * Actions::Assemble.current_duration
    else
      new_foobar_assemble_duration = Actions::Assemble.current_duration - 0.1*Actions::Assemble.current_duration
      return Actions::Assemble.ratio_success * Actions::MineFoo.current_duration + Actions::MineBar.current_duration + Actions::Assemble.ratio_success * new_foobar_assemble_duration
    end
  end

end
