class Bar
  # uid
  attr_accessor  :id
  @@identifier = 0
  def initialize
    @id =  @@identifier
    @@identifier+= 1
  end
end
