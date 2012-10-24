require 'csv'
  h=Hash.new 
  array=array_hot=[]
  csv = CSV.open('/home/omri/millionsong/art_fact.csv','rb')
  csv.each do |row|
    unless array.include? row[0]
    array.push(row[0])
    array_hot.push({:artist_id=>row[0].to_s,:artist_hot=>row[5].to_f,})  
    end
 end   
  i=0
  while array_hot[i]
  	 artist_temp=Artist.where(:artist_id=>array_hot[i][:artist_id]).first
  	 unless artist_temp.nil?
  	 	p artist_temp.artist_hot
  	 	artist_temp.artist_hot=array_hot[i][:artist_hot]
  	 	artist_temp.save
  	 end
  i+=1
  end	