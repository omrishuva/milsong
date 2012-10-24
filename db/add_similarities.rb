require 'csv'
 csv = CSV.open('/home/omri/millionsong/Aditional_files/similarity.csv','rb')
  
  csv.each do |row|
  	target=Artist.where(:artist_id=>row[0]).first
  	similar=Artist.where(:artist_id=>row[1]).first
  	unless target.nil? || similar.nil?
  		p target.artist_name.to_s + "=> " +similar.artist_name.to_s
  	end
  end	