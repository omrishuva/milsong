
require 'csv'
def get_terms_data 
	h=Hash.new 
	array=[]
	indexes_arr=[]
	csv = CSV.open('/home/omri/millionsong/art_term.csv','r')
	csv.each do |row|
		h={:id=>row[0],:term=>row[1],:freq=>row[2],:weight=>row[3]}
		array.push(h)
	end		
	array
end

	
def load_term_freq term_data
	final_term_data=terms=freqs=weights=[]
	h={}
	terms.push(term_data[0][:term])
	#p terms
	freqs.push(term_data[0][:freq])
	freqs.push(term_data[0][:weight])
	#p freqs
	i=1
	while term_data[i]
		id1=term_data[i-1][:id]
		#p id1
		id2=term_data[i][:id]
		#p id2
		if id2==id1
			#p "equal"
			terms.push(term_data[i][:term])
			#p terms
			freqs.push(term_data[i][:freq])
			weights.push(term_data[i][:weight])
			#p freqs
			else
				#p "not equal"
				h={:artist_id=>id1,:terms=>terms,:freqs=>freqs,:weights=>weights}
				final_term_data.push(h)
				#p final_term_data
				terms=terms.drop(terms.count)
				#p "terms after drop" 
				#p terms
				terms.push(term_data[i][:term])
				#p "terms after push" 
				#p terms
				freqs=freqs.drop(freqs.count)
				freqs.push(term_data[i][:freq])
				weights=weights.drop(term.count)
				weights.push(term_data[i][:weight])
				#p "freqs after push" 
				#p freqs
		end
	
	i+=1
	
end 
	final_term_data		 
end

def remove_duplicates_from (array_before_duplicates)
  final_array=Array.new
  indexes=Array.new
  i=1 
  while array_before_duplicates[i]
        j=i-1
     	until j==0
       	  if array_before_duplicates[i][:artist_id]==array_before_duplicates[j][:artist_id] 
       		 unless indexes.include? i
       		   indexes.push(i) 
       	  	 end
       	  	break
       	  else
       	   j-=1
       	  end 
     	end 
   	   i+=1
   end
	  p "loading uniq data"
	  i=0
	  while indexes[i]
  		  unless indexes.include?(i)
			  final_array.push(array_before_duplicates[i])		
  		  end	
  	    i+=1
	  end
final_array
end

array=final_array=[]
array=get_terms_data
array_before_duplicates=load_term_freq array
final_array=remove_duplicates_from array_before_duplicates
i=0
while final_array[i]	
	j=0
	artist_temp=Artist.find_by_artist_id(final_array[i][:artist_id])
	while final_array[i][:terms][j]
		artist_temp.terms.push(Term.new({:term=>final_array[i][:terms][j],:term_freq=>final_array[i][:freqs][j],final_array[i]:weights[j]})) 
		artist_temp.save
		j+=1
		p i
	end
   i+=1
end	





require 'csv'
def get_terms_data 
	p "getting terms data"
	h=Hash.new 
	array=indexes_arr=[]
	csv = CSV.open('/home/omri/millionsong/csvfiles/subset/term.csv','r')
	csv.each do |row|
		h={:id=>row[0],:term=>row[1],:freq=>row[2],:weight=>row[3]}
		array.push(h)
	end		
	array
end

	
def load_term_freq term_data
	p "loading term"
	final_term_data=terms=freqs=weights=already_updated=[]
	i=1
	while term_data[i]
		id1=term_data[i][:id]
		id2=term_data[i-1][:id]
		if id2==id1
			terms.push(term_data[i-1][:term])
			freqs.push(term_data[i-1][:freq])
			weights.push(term_data[i-1][:weight])
			
		else
			artist_temp=(Artist.find_by_artist_id(id1))
			unless already_updated.include? id1
				already_updated.push(id1)
				j=0
				while terms [j]
					artist_temp.terms.push(Term.new(:term=>terms[j],:term_freq=>freqs[j],:term_weight=>weights[j]))
					artist_temp.save
					j+=1
				end	
				p i
				terms=terms.drop(terms.count)
				freqs=freqs.drop(freqs.count)
				weights=weights.drop(weights.count)
			
			end
		end
	i+=1
	end 		 
end

#def remove_duplicates_from (array_before_duplicates)
#  p "removing duplicates "
#  final_array=Array.new
#  indexes=Array.new
#  i=1 
#  while array_before_duplicates[i]
#        j=i-1
#     	until j==0
#       	  if array_before_duplicates[i][:artist_id]==array_before_duplicates[j][:artist_id] 
#       		 unless indexes.include? i
#       		   indexes.push(i) 
#       	  	 end
#       	  	break
#       	  else
#       	   j-=1
#       	  end 
#     	end 
#   	   i+=1
#   end
#	  p "loading uniq data"
#	  i=0
#	  while indexes[i]
# 		  unless indexes.include?(i)
#			  final_array.push(array_before_duplicates[i])		
#  		  	  p i	
#  		  end	
#  	    i+=1
#	  end
#final_array
#end

array=final_array=[]
array=get_terms_data
load_term_freq array
	 	

#i=0
#p "loading to database"
#while final_array[i]	
#	p "0"
#	unless already_updated.include? final_array[i][:artist_id] 
#		j=0
#		p "1"
#		artist_temp=(Artist.find_by_artist_id(final_array[i][:artist_id]))
#		p "2"
#		already_updated.push(final_array[i][:artist_id])
#		p "3"
#		p final_array[i]
#		p i
#		p j
#		
#		while final_array[i][:terms][j]
#		p "4"	
#			artist_temp.terms.push(Term.new(:term=>final_array[i][:terms][j],:term_freq=>final_array[i][:freqs][j],:term_weight=>final_array[i][:weights][j])) 
#		p "5"	
#			artist_temp.save	
#			j+=1
#			p j
#		end
 #   end
#   i+=1
#end	




