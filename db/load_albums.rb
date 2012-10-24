require 'csv'
  h=Hash.new 
  array=album_array=[]
  csv = CSV.open('/home/omri/millionsong/art_fact.csv','rb')
  csv.each do |row|
    unless array.include? row[0]
    array.push(row[0])
    album_array.push({:artist_id=>row[0].to_s,:album=>row[10].to_s,:year=>row[11].to_s,:release7digital=>row[12].to_s})  
    end
 end   
  i=0
  while album_array[i]	
		artist_temp=Artist.find_by_artist_id(album_array[i][:artist_id])
		unless artist_temp.nil?
		artist_temp.albums.push(Album.new({:album=>album_array[i][:album],:year=>album_array[i][:year],:release7digital=>album_array[i][:release7digital]})) 
		artist_temp.save
		p i
		end
	i+=1
	end
   
