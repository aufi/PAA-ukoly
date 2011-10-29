#ruby knihovny
require 'rubygems'
require 'algorithms'
require 'thread'
require 'pp'


#moje
require 'bucket'
require 'problem'
require 'paaq'
require 'paaqh'

puts "PAA 2.uloha kyble"

def load(filename)
  data = Array.new
  f = File.new(filename, "r")
  while (line = f.gets())
    nums = line.split(" ")
    buckets = Array.new
    p = Array.new
    for i in (0..nums.at(1).to_i-1)
      cap = nums.at(2+i).to_i
      state = nums.at(7+i).to_i
      fs = nums.at(12+i).to_i
      buckets.push(Bucket.new(cap, state, fs, i))
    end
    data.push(Problem.new(buckets, 0, nums.at(0)))
  end
  #data.push(Problem.new([Bucket.new(14,0,12,0),Bucket.new(10,0,6,1),Bucket.new(6,1,4,2),Bucket.new(2,0,1,3),Bucket.new(8,0,8,4)]))
  #data.push(Problem.new([Bucket.new(14,0,14,0),Bucket.new(10,0,4,1),Bucket.new(6,1,5,2),Bucket.new(2,0,0,3),Bucket.new(8,0,4,4)]))
  return data
  #pp data
end

data = load("../test/2kyble")

data.each{ |i|

  puts "Ukol: "+i.id
  
  $v = Hash.new   #hashtabulka vsech objevenych uzlu

  
  #q = Paaq.new    #obalena ruby fronta na BFS
  q = Paaqh.new  #upravena fronta pro heuristiku

  #q.push(i)   #vlozeni pocatecniho uzlu
  q.push(i, i.get_price)   #vlozeni pocatecniho uzlu

  while (!q.empty?)
    #puts "krok z fronty o delce "+q.size.to_s
    p = q.pop().step                           
    p.each { |i| 
      #q.push(i) 
      q.push(i, i.get_price) 
    }
  end

  #exit
  
  #$v.each { |key,val| puts key }
  #pp $v
}

puts "konec"