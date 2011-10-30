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


data = load("../test/data")

#pp states(data[0])

q = Paaq.new

q.push(data[0])

cnt = data[0].state.size()

puts cnt.to_s

max_price = 0
max_sol = data[0]

while (!q.empty?)
  #puts "krok z fronty o delce "+q.size.to_s
  p = q.pop().expand
  next if p.nil?  #fix
  p.each { |i| 
    if !i.over? 
      if (i.price.to_i >= max_price)
        max_price = i.price.to_i
        max_sol = i
      end
      q.push(i) 
    end
  }
end

puts "nejvyssi cena: "+max_price.to_s
pp max_sol

puts "konec"






