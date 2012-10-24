require 'csv'
def has_full_location?(long,lat)
	long_count=long.to_s.count "0-9"
	lat_count=lat.to_s.count "0-9"
	if (long_count<2)&&(lat_count<2)
		false
	else
		true	
	end
end	

def fix_in_hash(long=nil,lat=nil, neighborhood=nil, city = nil, state = nil, country = nil) 
	geotemp=Hash.new
	if has_full_location? long, lat 
	    geotemp={:long=>long, :lat=>lat,:neighborhood=>neighborhood, :city => city,:state => state,:country=> country}
	else
		geotemp={:long=>nil, :lat=>nil,:neighborhood=>neighborhood, :city => city,:state => state,:country=> country}
	end
end

def from_csv_to_array (long,lat,loca,count)
       # treating differnt cases exeptions and non valid names
        case count
              when 1  
 	             case loca[0]
                    when "Great Britain / UK"  
                       city=neighborhood=state=nil
                       country="England"
                    when "South Hadley Massachusetts USA"
                    neighborhood=nil
                    city="South Hadley"
                    state="Massachusetts"
                    country="USA"
                    when "Washington"
     	  			   neighborhood=city=nil
     	  			   state="Washington"
     	  			   country="USA"
   					when "Vernet les Bains"
     				   neighborhood=state=nil
     				   city="Vernet les Bains"
     				   country="France"
   				 else
     				neighborhood=city=state=nil
     				country=loca[0]
 				 end
 				when 2
   					if loca[1]=="Canada" || loca[1]== "USA" 
     					neighborhood=city=nil
     					state=loca[0]
     					country=loca[1]
   					else
     					neighborhood=nil
     					city=loca[0]
     					country=loca[1]
   					end
 				when 3
 					if loca[1]=="London" && loca[2]=="England" 		 		 		 	
 						state=nil
 						neighborhood=loca[0]
 						city=loca[1]
 						country=loca[2]
  					else
 						neighborhood=nil
 						city=loca[0]
 						state=loca[1]
 						country=loca[2]
 					end
 				when 4
 						neighborhood=loca[0]
 						city=loca[1]
 						state=loca[2]
 						country=loca[3]
 		end
    fix_in_hash(long,lat,neighborhood,city,state,country)
    end


 
 #remove duplicates from geo(full location)
def remove_duplicates_full (temp_geo)
  geo_full_final=Array.new
  indexes=Array.new
  i=1 
  while temp_geo[i]
        j=i-1
     	until j==0
       	  if temp_geo[i][:long]==temp_geo[j][:long] && temp_geo[i][:lat]==temp_geo[j][:lat]
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
			  geo_full_final.push(temp_geo[i])		
  		  end	
  	    i+=1
	  end
geo_full_final
end


def remove_duplicates_non_full (geo_non_full)
	indexes=Array.new
 	geo_non_full_final=Array.new	
	i=1
	while geo_non_full[i]
  		  j=i-1 
     	  until j==0
       		  if geo_non_full[i][:neighborhood]==geo_non_full[j][:neighborhood]&& geo_non_full[i][:city]==geo_non_full[j][:city]&& geo_non_full[i][:state]==geo_non_full[j][:state]&& geo_non_full[i][:country]==geo_non_full[j][:country]	
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
   i=0
   p "loading uniq data"
   while indexes[i]
  	    unless indexes.include?(i)
			geo_non_full_final.push(geo_non_full[i])		
  		end	
  	  i+=1
    end
 geo_non_full_final
 end



def add_to_database (geo_full, geo_non_full)
 i=0
   p geo_full.count.to_s
   while geo_full[i]
      Geo.create(:long=>geo_full[i][:long],:lat=>geo_full[i][:lat],:neighborhood=>geo_full[i][:neighborhood],:city=>geo_full[i][:city],:state=>geo_full[i][:state],:country=>geo_full[i][:country],:continent=>geo_full[i][:continent])
      i+=1
   end
   p Geo.count.to_s
   p geo_non_full.count.to_s
 i=0
   while geo_non_full[i]
 	 j=0
	exist=false
	  while geo_full[j] 
	   	  if geo_non_full[i][:neighborhood]==geo_full[j][:neighborhood]&& geo_non_full[i][:city]==geo_full[j][:city]&& geo_non_full[i][:state]==geo_full[j][:state]&& geo_non_full[i][:country]==geo_full[j][:country]	
		 	     exist==true		
        end
			    j+=1
	  end    
        if exist==false
		      Geo.create(:long=>geo_non_full[i][:long],:lat=>geo_non_full[i][:lat],:neighborhood=>geo_non_full[i][:neighborhood],:city=>geo_non_full[i][:city],:state=>geo_non_full[i][:state],:country=>geo_non_full[i][:country],:continent=>geo_non_full[i][:continent])
        end	
    i+=1
   end
   p Geo.count.to_s 
   end	
   
	
	  
      geo_full=Array.new
	  geo_non_full=Array.new
	  geo_full_final=Array.new
	  geotemp=Hash.new
	  csv = CSV.open('/home/omri/millionsong/script/metadata-csv.csv','r')
	  csv.drop(1).each do |row|
  	  long=row[11]
      lat=row[9]
         unless row[10].nil?     
           loc=row[10].to_s
           loca = loc.split("\\") 
           count=loca.count  	 
	       if has_full_location? long,lat 
	  	   	  geotemp=from_csv_to_array long,lat,loca,count
	  	   	  geo_full.push(geotemp) 	   
	  	   else
	  	   	  geotemp=from_csv_to_array long,lat,loca,count
	  	   	  geo_non_full.push(geotemp)
	  	   end
	    end
	  end
	  p "one third of the way"
	  p "removing duplicates from full location"
	  geo_full_final= remove_duplicates_full geo_full
	  p "removing duplicates from non full location"
	  geo_non_full_final= remove_duplicates_non_full geo_non_full 
	  p "adding to database" 
	  add_to_database geo_full_final,geo_non_full_final
	
