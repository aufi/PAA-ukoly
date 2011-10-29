# To change this template, choose Tools | Templates
# and open the template in the editor.

class Batoh

  attr_accessor :w, :p, :cap, :state

  def price
    ps = 0
    for i in 0..@state.size do
      ps += @p[i] if @state[i] == 1
    end
    return ps
  end
  
  def weight
    ws = 0
    for i in 0..@state.size do
      ws += @w[i] if @state[i].eql?(1)
    end
    if self.over?
      return 0
    else  
      return ws
    end
  end
  
  def over?
    if (self.weight > @cap)
      true
    else
      false
    end
  end
  
  def initialize(w, p, cap, state)
    @w = w
    @p = p
    @cap = cap
    @state = state
  end
end
