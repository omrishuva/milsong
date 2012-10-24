require 'csv'
include Etl_methods  
  term=indexes=geo_tags=[]
  count_updates=count_nil=0
  art_csv = CSV.open('/home/omri/millionsong/csvfiles/B/art_fact.csv','r')
   art_csv.each do |row|
    unless indexes.include? row[0]
        indexes.push(row[0])
            geo_tags=Etl_methods.get_geo_tags row[9].to_s
            p geo_tags    
        a=Artist.where(:artist_id=>row[0]).first
        if a.nil?
            Artist.create({:artist_id=>row[0].to_s,:artist_7digitalid=>row[1].to_s,:artist_mbid=>row[2].to_s,:artist_pmid=>row[3].to_s,:artist_name=>row[4].to_s.downcase,:hotness=>row[5].to_f,:artist_fam=>row[6].to_f,:coordinates=>[row[7],row[8]]})  
            p row[4]
            a=Artist.where(:artist_id=>row[0]).first
            a.geo_tags=geo_tags   
            a.save   
            p "saved"
            count_updates+=1
        else
            p "already exist"
        end
    
    end
p count_nil
 end   
  