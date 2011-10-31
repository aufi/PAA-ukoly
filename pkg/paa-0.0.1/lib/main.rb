# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'pp'
require 'thread'

require File.expand_path(File.join(File.dirname(__FILE__), 'batoh'))
require File.expand_path(File.join(File.dirname(__FILE__), '2/paaq.rb'))

puts "PAA 3.uloha batoh"

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
    data.push(Batoh.new(w, p, nums.at(2).to_i, Array.new(cnt, 0)))  #inverzni pro DP
  end
  #pp data.to_s
  return data
end


data = load("../test/data")
#data = load("../test/batoh/10")


#pp states(data[0])

q = Paaq.new

q.push(data[0])

$v = Array.new

max_price = 0
max_sol = data[0]

tstart = Process.times.utime

batoh = data[0]

def bin_round(x, d = 1)
  b = x.to_s(2)
  d.downto(1) { |i|
    b[b.length-i] = "0"
  }
  return b.to_i(2)
end

puts bin_round(23, 2)

def states(batoh, i)
  #puts i.to_s+" resim: "+batoh.state.to_s
  if (i > 0)
    b0 = Marshal.load(Marshal.dump(batoh))
    b0.state[i] = 0
    b0.depth = i
    b1 = Marshal.load(Marshal.dump(batoh))
    b1.state[i] = 1
    b1.depth = i
    b1.cap -= b1.w[i].to_i
    a = states(b0, i-1)
    b = states(b1, i-1)
    if (a.score(i) < b.score(i))  # cena s/bez i-te veci
      return b
    else
      return a
    end
  else
    #pp batoh.state
    return batoh
  end  
end

for i in 10..0#batoh.state.size.to_i-1
  #puts batoh.weight
  batoh.cap.to_i.downto(0) { |weight| 
    puts weight
    if batoh.w[i] < weight  #je tam misto
      puts "jo" #
      #batoh = Marshal.load(Marshal.dump(batoh))
      batoh.state[i] = 1
      #batoh.cap -= batoh.w[i]
      $v[i] = Marshal.load(Marshal.dump(batoh))
    end 
  }
    
  #$v[i] = states(batoh, i)
  #w = batoh.w[i]
  #tmp = Array.new
  #for j in i..batoh.state.size.to_i-1
  #  tmp[j] = w
  #end
  #$v[batoh.p[i].to_i] = tmp
end

#pp $v


#max_price = states(batoh, batoh.state.size-1).price

#pp states(data[0], 0)

#while (!q.empty?)
#  p = q.pop().expand
#  next if p.nil?
#  p.each { |i| 
#    if !i.over?&&(i.price+i.bb_price > max_price)  # b&b
#      if (i.price.to_i >= max_price)
#        max_price = i.price.to_i
#        max_sol = i
#      end
#      q.push(i) 
#    end
#  }
#end

ut = Process.times.utime - tstart

#puts "nejvyssi cena: "+max_price.to_s
pp $v
puts "cas: "+ut.to_s

puts 10.to_s(2)

puts "konec"






