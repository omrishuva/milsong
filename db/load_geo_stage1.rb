require 'csv'
def has_coordinates(long,lat)
  long_count=long.to_s.count "0-9"
  lat_count=lat.to_s.count "0-9"
  if (long_count<2)&&(lat_count<2) 
    false
  else
    true  
  end
end 


def fix_in_hash(neighborhood=nil, city = nil, state = nil, country = nil,artist_id=nil) 
    geotemp=Hash.new
    geotemp={:artist_id=>artist_id,:neighborhood=>neighborhood, :city => city,:state => state,:country=> country}
end

def from_csv_to_array (loca,count,artist_id)
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
    fix_in_hash(neighborhood,city,state,country,artist_id)
    end
           
          geo=Array.new
        geotemp=Hash.new
        csv = CSV.open('/home/omri/millionsong/script/metadata-csv.csv','r')
        csv.drop(1).each do |row| ########################
            long=row[11]
            lat=row[9]
            loc=row[10].to_s
            loca = loc.split("\\") 
            artist_id=row[8]
            #unless has_coordinates long,lat  
            count=loca.count     
          unless loca.empty?
                 geotemp=from_csv_to_array loca,count,artist_id
                 #p geotemp
                 geo.push(geotemp) 
            end 
        end ######################################################
        i=0
        count=0
        indexes_array=[]
        while geo[i]
        unless indexes_array.include?(geo[i][:artist_id]) 
             indexes_array.push(geo[i][:artist_id])
             artist_temp=Artist.where(:artist_id=>geo[i][:artist_id]).first   
                  if has_coordinates(artist_temp.coordinates[1],artist_temp.coordinates[0])
                     
                     if artist_temp.neighborhood.nil?          
                          unless geo[i][:neighborhood].nil?
                          artist_temp.neighborhood=geo[i][:neighborhood].downcase
                        end
                     end
               if artist_temp.city.nil? 
                          unless geo[i][:city].nil?
                          artist_temp.city=geo[i][:city].downcase
                        end
                     end                
                     if artist_temp.state_province.nil? 
                          unless geo[i][:state_province].nil?
                          artist_temp.state_province=geo[i][:state_province].downcase
                        end
                      end
                     if artist_temp.country.nil? 
                          unless geo[i][:country].nil?
                          artist_temp.country=geo[i][:country].downcase
                        end
                     end

                else
                  unless geo[i][:neighborhood].nil?
                    artist_temp.neighborhood=geo[i][:neighborhood].downcase
                  end
                    unless geo[i][:city].nil? 
                artist_temp.city=geo[i][:city].downcase               
                    end
                  unless geo[i][:state_province].nil?                  
                         artist_temp.state_province=geo[i][:state_province].downcase
                    end
                    unless geo[i][:country].nil?
                     artist_temp.country=geo[i][:country].downcase
                      end  
                   end
                count+=1
                p artist_temp.artist_name.to_s+"--"+ artist_temp.neighborhood.to_s + "-"+artist_temp.city.to_s+"-"+artist_temp.state_province.to_s+"- "+artist_temp.country.to_s
                artist_temp.save
                p count.to_s
          end
        i+=1
        end    

       
         
  