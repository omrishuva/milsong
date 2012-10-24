require 'csv'
  h=Hash.new 
  array=[]
  csv = CSV.open('/home/omri/millionsong/art_fact.csv','rb')
  csv.each do |row|
    unless array.include? row[0]
    array.push(row[0])
    Artist.create({:artist_id=>row[0].to_s,:artist_7digitalid=>row[1].to_s,:artist_mbid=>row[2].to_s,:artist_pmid=>row[3].to_s,:artist_name=>row[4].to_s.downcase,:hotness=>row[5].to_f,:artist_fam=>row[6].to_f,:coordinates=>[row[7],row[8]]})  
    end
 end   
  