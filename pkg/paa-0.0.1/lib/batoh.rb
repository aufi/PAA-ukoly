# To change this template, choose Tools | Templates
# and open the template in the editor.

class Batoh

  attr_accessor :w, :p, :cap, :state, :depth

  def price
    ps = 0
    for i in 0..@state.size do
      ps += @p[i] if @state[i] == 1
    end
    return ps
  end
  
  def bb_price
    ps = 0
    for i in @depth..(@state.size-1) do
      ps += @p[i]
    end
    return ps
  end
  
  def score(prev)
    if self.over?
      return 0
    else
      ps = 0
      for i in 0..@state.size do
        ps += @p[i].to_i if @state[i] == 1  #fix i ta vec
      end
      return ps
    end
  end
  
  def weight
    ws = 0
    for i in 0..@state.size do
      ws += @w[i].to_i if @state[i].eql?(1)
    end
    return ws
  end
  
  def over?
    if (self.weight > @cap)
      return true
    else
      return false
    end
  end
  
  def initialize(w, p, cap, state, depth = 0)
    @w = w
    @p = p
    @cap = cap
    @state = state
    @depth = depth
  end
  
  def expand
    puts @depth.to_s+" resim: ("+self.bb_price.to_s+") "+@state.to_s
    res = Array.new
    if (@depth < @state.size.to_i)
      b0 = Marshal.load(Marshal.dump(self))
      b0.state[b0.depth] = 0
      b0.depth = @depth + 1
      b1 = Marshal.load(Marshal.dump(self))
      b1.state[b1.depth] = 1
      b1.depth = @depth + 1
      res.push(b0)
      res.push(b1)
      return res
      #if (a.weight > b.weight)
      #  return a
      #else
      #  return b
      #end
      #else
      #  pp batoh.state
      #  return batoh
    end  
  end
  
end
