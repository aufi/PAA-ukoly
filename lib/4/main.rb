# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'algorithms'
require 'priority_queue'
require 'thread'
require 'pp'

require File.expand_path(File.join(File.dirname(__FILE__), 'batoh'))
require File.expand_path(File.join(File.dirname(__FILE__), '2/paaq.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), '2/paaqh.rb'))

puts "PAA 4.uloha srovnani"
puts "[#veci;dp;bb;bb_cena;heur;heur_cena]"

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
  #pp data.to_s
  return data
end

def bb(d)
  q = Paaq.new
  q.push(d)
  max_price = 0
  max_sol = nil
  #pp states(data[0], 0)
  while (!q.empty?)
    p = q.pop().expand
    next if p.nil?
    $cnt += 1
    p.each { |i| 
      if !i.over?&&(i.price+i.bb_price > max_price)  # b&b
        if (i.price.to_i >= max_price)
          max_price = i.price.to_i
          max_sol = i
        end
        q.push(i) 
      end
    }
  end
  return max_price
  #puts r.price.to_s+";"+r.weight.to_s
end

def heur(d)
  q = Paaqh.new
  q.push(d, 1)
  max_price = 0
  max_sol = nil
  #pp states(data[0], 0)
  while (!q.empty?)
    p = q.pop().expand
    next if p.nil?
    $cnt += 1
    p.each { |i| 
      if !i.over?
        if (i.price.to_i >= max_price)
          max_price = i.price.to_i
          max_sol = i
        end
        q.push(i, i.score)
      else
        #hladovy algoritmus, naplneno - mam nejaky vysledek
        return max_price
      end
    }
  end
  return max_price  #kdyby nahodou neslo naplnit
  #puts r.price.to_s+";"+r.weight.to_s
end
  
def dp(batoh, i, limit)
  $cnt += 1
  if (i < 0)
    #pp batoh
    return batoh
  end 
  return $v[i.to_s+"_"+limit.to_s] if !$v[i.to_s+"_"+limit.to_s].nil? #vratit ulozeny vysledek
  res = dp(Marshal.load(Marshal.dump(batoh)), i-1, limit) #nepridat
  #pp batoh, limit if i == 9
  if batoh.w[i] <= limit  #kdyz se vejde
    resp = Marshal.load(Marshal.dump(batoh))
    resp.state[i] = 1
    res1 = dp(resp, i-1, limit - batoh.w[i].to_i)  #pridat
    res = res1 if (res1.price >= res.price)
  end
  $v[i.to_s+"_"+limit.to_s] = res   #ulozit vysledek do pameti
  return res  
end

#---------------pro vsechny vahy------------------------------------------------
vahy = ['k1', 'k3', 'k5', 'k7', 'k9', 'k11', 'k13', 'm1', 'm3', 'm5', 'm7', 'm9', 'p25', 'p50', 'p100', 'p150', 'p200', 'p400', 'w25', 'w50', 'w100', 'w150', 'w200', 'w400']
vahy.each { |fi|  

  data = load("../test/batoh4/"+fi.to_s)

  print fi.to_s
  
  #DP pro vsechny instance------------------------------------------------------
  $cnt = 0
  tstart = Process.times.utime
  data.each { |row|  
    batoh = row
    #pp row
    $v = Hash.new
    #puts "inst.."
    r = dp(batoh, batoh.state.length-1, batoh.cap.to_i)
    r.state[r.state.length-1] = 1 if (r.weight + r.w[r.state.length-1].to_i) <= r.cap.to_i 
  }
  ut = Process.times.utime - tstart
  print ";"+($cnt/data.length).to_s #ut.to_s
  #konec DP
  
  #BB pro vsechny instance------------------------------------------------------
  $cnt = 0
  #data.each { |batoh|  
    mc = bb(data[0])#.to_s
  #}
  print ";"+$cnt.to_s+";"+mc.to_s
  #konec BB
  
  #heuristika pro vsechny instance----------------------------------------------
  $cnt = 0
  #data.each { |batoh|  
    mc = heur(data[0])#(batoh)#.to_s
  #}
  print ";"+$cnt.to_s+";"+mc.to_s
  #konec HEUR  
  
  puts ";"

  #puts r.price.to_s+";"+r.weight.to_s+";"+ut.round(4).to_s
  #puts r.weight.to_s

} #konec iteratoru pro mereni vice inst.

puts "konec"






