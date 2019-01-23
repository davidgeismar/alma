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

  # the problem here is that I choose my course of action based on every individual bot and not on the global stock
  # The strategy here is
  # mining foo si plus de foo
  # mining bar si plus de bar
  # assembling as long as we dont have at least 5 foobars (because you could sell as much as 5 foobars each time)
  # tant que le robot n'a pas au minimum 12 euros : vendre (car un upgrade coute 12)
  # si le robot a plus de 12 euros upgrade ou nouveau bot en fonction de la fonction d'optimisation
  def choose_action
    puts("in choose action")
    puts("robot #{@robot.id} has #{@robot.foobars.size} in stock")
    ::Actions::MineFoo.new(@robot, @manager).perform if @robot.foos.empty? #should it be the manager checking foos or every individual bots
    ::Actions::MineBar.new(@robot, @manager).perform if @robot.bars.empty? # same
    if @robot.foobars.size < 5 #assemble
      current_foo = @robot.foos.shift
      current_bar = @robot.bars.shift
      shift_from_manager_pool(current_foo, current_bar)
      action = ::Actions::Assemble.new(current_foo, current_bar, @robot, @manager)
    elsif 12 >  @robot.available_funds
      action = ::Actions::Sell.new(@robot, @manager)
    elsif @robot.available_funds >= 12
      action = compare_production_improvement_ratio
    end
    action.perform
  end

  def shift_from_manager_pool(current_foo, current_bar)
    @manager.foos.reject! { |foo| foo.id == current_foo.id}
    @manager.bars.reject! { |bar| bar.id == current_bar.id}
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
    #returns  potential new total production duration
    new_production_duration = compute_new_production_duration(@manager.current_upgrade_step)
    #computes the time we gained (diff between the current production time and potential new production time)
    duration_gains = Foobar.average_current_production_duration - new_production_duration
    # this gives us the value gained in terms of foobar ie : how much foobar does this duration gain represents
    individual_production_gains =  duration_gains/Foobar.average_current_production_duration
    # if we multiply by the total bot count we have the gain in foobars
    global_production_gains = @manager.bot_count*individual_production_gains
    return global_production_gains
  end

  # need to add the limit of 50%
  # computes the new production duration if we decide to buy upgrade all bots
  def compute_new_production_duration(step)
    if step == :foo
      new_foo_mining_duration = Actions::MineFoo.current_duration - 0.1*Actions::MineFoo.current_duration
      return  Actions::Assemble.ratio_success * new_foo_mining_duration + Actions::MineBar.current_duration + Actions::Assemble.ratio_success * Actions::Assemble.current_duration
    elsif step == :bar
      new_bar_mining_duration = Actions::MineBar.current_duration - 0.1*Actions::MineBar.current_duration
      return  Actions::Assemble.ratio_success * Actions::MineFoo.current_duration + new_bar_mining_duration+ Actions::Assemble.ratio_success * Actions::Assemble.current_duration
    else
      new_foobar_assemble_duration = Actions::Assemble.current_duration - 0.1*Actions::Assemble.current_duration
      return Actions::Assemble.ratio_success * Actions::MineFoo.current_duration + Actions::MineBar.current_duration + Actions::Assemble.ratio_success * new_foobar_assemble_duration
    end
  end

end
