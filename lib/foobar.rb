class Foobar
  attr_accessor :foo, :bar, :id
  # ratio success to calculate the average production duration
  @@average_original_production_duration = ::Actions::Assemble.ratio_success * ::Actions::MineFoo.original_duration + ::Actions::MineBar.original_duration + ::Actions::Assemble.ratio_success * ::Actions::Assemble.original_duration
  @@average_current_production_duration = ::Actions::Assemble.ratio_success * ::Actions::MineFoo.current_duration + ::Actions::MineBar.current_duration + ::Actions::Assemble.ratio_success * ::Actions::Assemble.original_duration
  def initialize(foo, bar)
    @foo = foo
    @bar = bar
    @id = "#{foo.id}#{bar.id}"
  end


  def self.average_original_production_duration
    return @@average_original_production_duration
  end

  def self.average_current_production_duration
    @@average_current_production_duration
  end

end
