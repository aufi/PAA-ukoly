# To change this template, choose Tools | Templates
# and open the template in the editor.

puts "PAA 1.uloha batoh"

slist = []

def states(hloubka, stav)
  if (hloubka.to_i >= 1)
    states(hloubka.to_i-1, stav.to_s+"1")
    states(hloubka.to_i-1, stav.to_s+"0")
  else
    #slist.push(stav)
    puts stav
    
    for i in (0..stav.length)
      if (state.at(i)==1)
        
      else
        
      end
    end
  end  
end

def load(filename)
  data = Array.new
  f = File.new(filename, "r")
  while (line = f.gets())
    nums = line.split(" ")
    w = Array.new
    p = Array.new
    for i in (0..nums.at(1).to_i-1)
      w.push(nums.at(3+2*i).to_i)
      p.push(nums.at(4+2*i).to_i)
    end
    data.push([w,p, nums.at(2).to_i])
  end
  puts data.to_s
end

def brutef(w,p,m)
  slist.each { |state| 
    for i in (0..i.to_s.length)
      if (state.at(i)==1)
        
      else
        
      end
    end
    
  }
  
end

#load("../test/data")

states(10, "")