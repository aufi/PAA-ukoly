# fronta
# sadsd
# projití a vybráni stavu s nejmenší rozdílem aktuální/chtěný
#

#require 'priority_queue' - v mainu

class Paaqh
  @elems
  
  def initialize
    @elems = Containers::PriorityQueue.new
  end
  
  def size
    @elems.size
  end
  
  def empty?
    @elems.empty?
  end
  
  def push(it, prio)
    if $v[it.get_key].nil?
      @elems.push(it, prio) 
      $v[it.get_key] = it
    end
  end
  
  def pop()
    @elems.pop()
  end
  
end