class Robot
  attr_accessor :foos,
                :bars,
                :id,
                :funds,
                :foobars,
                :stopwatch
  # each robot has
  #  - stopwatch to know when production chain stops
  #  - the manager object to update regularly informations about the production chain
  #  - foos to hold the foos
  #  - bars to hold the bars
  #  - foobars to hold the foobars
  #  - funds to know how much income it made
  #  - the master bot is the one performing the upgrades

  # master robot should always at least have 12 euros to perform the upgrades

  def initialize(stopwatch=nil, manager)
    @stopwatch = stopwatch
    @manager = manager
    @foos = []
    @bars = []
    @foobars = []
    @funds = 0
    @id = @manager.generate_bot_id
  end

  # when should the robot mine Foo & Bar
  # when his repo is empty or when the global repo is empty
  
  def get_to_work!
    while @stopwatch.running
      ::Actions::MineFoo.new(self, @manager) if @manager.foos.empty? #should it be the manager checking foos or every individual bots
      ::Actions::MineBar.new(self, @manager) if @manager.bars.empty? # same
      puts("elapsed time : #{@stopwatch.elapsed}")
      ActionDecisionCenter.new(@manager, self).choose_action
    end
    puts("production chain was stopped")
    puts("it gas produced :\n
          TOTAL PROFIT => #{@manager.available_funds}\n
          TOTAL PRODUCED => #{@manager.total_produced}\n
          TOTAL EXPENSES => #{@manager.total_expenses}\n
          TOTAL REVENUE => #{@manager.total_revenue}\n
          TOTAL EXPENSES => #{@manager.total_expenses}\n
      ")
  end

end
