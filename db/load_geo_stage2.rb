 require 'csv'
 indexes=[]
 artist_geo=[]
 temp_locs=[]
 loca=[]
 locs_array=[]
 i=0
 loca=[]
 csv = CSV.open('/home/omri/millionsong/csv files/B/art_fact.csv','r')
 csv.drop(1).each do |row|
      unless indexes.include? row[0]
          loc=row[9].to_s
          loc=loc.downcase
          loca=loc.split ("\\,")
          indexes.push(row[0])
          if loca.count==1
            for locs in loca
                locs_array=locs.split("-") 
                for l in locs_array
                  temp_locs.push(l)    
                end  
            end
          end               
          artist_geo[i]=({:artist_id=>row[0],:artist_name=>row[4],:coordinates=>[row[7],[[8]],:artist_loc=>temp_locs})
          temp_locs=[]  
          i+=1               
      end
end      
def art_geo (coor,loc,i)
 final_locs=loca=locs_array=loca=[]
          loc=loc.downcase
          loca=loc.split ("\\,")
          if loca.count==1
            for locs in loca
                locs_array=locs.split("-") 
                for l in locs_array
                  final_locs.push(l)    
                end  
            end               
          final_locs                 
      end
 
end  