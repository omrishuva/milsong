module Utiles

def self.bubble_sort(list)
  return list if list.size <= 1 # already sorted
  swapped = false
  while !swapped
    swapped = false
    0.upto(list.size-2) do |i|
      if list[i].artist_fam > list[i+1].artist_fam
        list[i], list[i+1] = list[i+1], list[i] # swap values
        swapped = true
      end
    end
  end

  list
end

def self.common_term(t1,t2)
  count=0
  for t in t2
   count+=1  if t1.include? t
  end 
count
end

def self.bubble_sort_common_terms(list)
  return list if list.size <= 1 # already sorted
  swapped = false
  while !swapped
    swapped = false
    0.upto(list.size-2) do |i|
      if list[i][:common_term] < list[i+1][:common_term]
        list[i], list[i+1] = list[i+1], list[i] # swap values
        swapped = true
      end
    end
  end

  list
end

end

#def  insertionsort(num)
#for j in 1..(num.length - 1)
#        key = num[j][:common_term]
#        i = j - 1
#       while i >= 0 and num[i][:common_term] > key
#                num[i+1] = num[i]
#                i = i - 1
#        end
#        num[i+1][:common_term] = key
#end     
#puts num
#end

#numbers = [23,34,46,87,12,1,66]

#insertionsort(numbers)
