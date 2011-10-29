# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'pp'
require 'thread'

require File.expand_path(File.join(File.dirname(__FILE__), 'batoh'))
require File.expand_path(File.join(File.dirname(__FILE__), '2/paaq.rb'))

puts "PAA 3.uloha batoh"

slist = []

def load(filename)
  data = Array.new
  f = File.new(filename, "r")
  while (line = f.gets())
    nums = line.split(" ")
    w = Array.new
    p = Array.new
    cnt = 0
    for i in (0..nums.at(1).to_i-1)
      w.push(nums.at(3+2*i).to_i)
      p.push(nums.at(4+2*i).to_i)
      cnt += 1
    end
    data.push(Batoh.new(w, p, nums.at(2).to_i, Array.new(cnt, 0)))
  end
  pp data.to_s
  return data
end


def states(batoh, i)
  puts i.to_s+" resim: "+batoh.state.to_s
  #pp batoh
  if (i < batoh.state.size().to_i)
    b0 = Marshal.load(Marshal.dump(batoh))
    b0.state[i] = 0
    b1 = Marshal.load(Marshal.dump(batoh))
    b1.state[i] = 1
    a = states(b0, i+1)
    b = states(b1, i+1)
    if (a.weight > b.weight)
      return a
    else
      return b
    end
  else
    pp batoh.state
    return batoh
  end  
end

data = load("../test/data")

#pp states(data[0], 0)

q = Paaq.new

q.push(data[0])

cnt = data[0].state.size()

puts cnt.to_s

for i in 0..cnt
  
end


puts "konec"






