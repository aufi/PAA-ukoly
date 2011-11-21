# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'pp'
require 'thread'

require File.expand_path(File.join(File.dirname(__FILE__), 'batoh'))
require File.expand_path(File.join(File.dirname(__FILE__), '2/paaq.rb'))

puts "PAA 3.uloha batoh"

def bin_round(x, d = 1)
  b = x.to_s(2)
  d.downto(1) { |i|
    b[b.length-i] = "1"
  }
  return b.to_i(2)
end

#puts bin_round(23, 2)
$roundbits = 1  #1,2;   3 uz bylo moc

def load(filename)
  data = Array.new
  f = File.new(filename, "r")
  while (line = f.gets())
    nums = line.split(" ")
    w = Array.new
    p = Array.new
    cnt = 0
    for i in (0..nums.at(1).to_i-1)
      #w.push(bin_round(nums.at(3+2*i).to_i, $roundbits)) #pro aprox alg.
      w.push(nums.at(3+2*i).to_i)
      p.push(nums.at(4+2*i).to_i)
      cnt += 1
    end
    data.push(Batoh.new(w, p, nums.at(2).to_i, Array.new(cnt, 0)))  #inverzni pro DP
  end
  #pp data.to_s
  return data
end

def dp(batoh, i, limit)
  
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

vahy = [4, 10, 15, 20, 25, 27, 30, 40]
vahy.each { |fi|  

  data = load("../test/batoh/"+fi.to_s)
  #puts "# veci "+fi.to_s
  
  #data = load("../test/data")
  #data = load("../test/batoh/40")


  #q = Paaq.new

  #q.push(data[0])

  

  #max_price = 0
  #max_sol = data[0]

  tstart = Process.times.utime

  data.each { |row|  
    batoh = row
    pp row

    $v = Hash.new

    #puts data[0].p[data[0].state.length-1]

    r = dp(data[0], data[0].state.length-1, data[0].cap.to_i)
    r.state[r.state.length-1] = 1 if (r.weight + r.w[r.state.length-1].to_i) <= r.cap.to_i
    #puts r.weight.to_s
    #puts r.price.to_s

    #pp r

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

    puts r.price.to_s+";"+r.weight.to_s
    
  }
  
  ut = Process.times.utime - tstart

  #puts "nejvyssi cena: "+max_price.to_s
  #
  #puts "hashtabulka:"
  #pp $v
  
  puts fi.to_s+" "+ut.round(4).to_s

  #puts r.price.to_s+";"+r.weight.to_s+";"+ut.round(4).to_s
  #puts r.weight.to_s

} #konec iteratoru pro mereni vice inst.

puts "konec"






