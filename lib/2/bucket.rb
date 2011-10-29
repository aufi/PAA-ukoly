class Bucket
  
  attr_accessor :capacity, :state, :finalstate, :index
    
  def fill()
    @state = @capacity
    #puts "filled"
  end
  
  def empty()
    @state = 0
    #puts "emptied"
  end
  
  def move(dest)
    #puts "from:"
    #pp self
    #puts "to:"
    #pp dest
    space = dest.capacity.to_i-dest.state.to_i
    if (space >= @state)
      dest.state += @state
      @state = 0
    else
      dest.state = dest.capacity
      @state = @state - space
    end
    #puts "moved "+space.to_s+": "+@index.to_s+"->"+dest.index.to_s
  end
  
  def complete?
    if (@state.to_i == @finalstate.to_i)
      return true 
    else
      return false
    end
  end
  
  def initialize(cap, state, fs, index = 0)
    @capacity = cap
    @state = state
    @finalstate = fs
    @index = index
  end
  
end