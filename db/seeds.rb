#require 'readline'
require 'csv'
#include Etl_methods
#song1_csv = CSV.open('/home/omri/millionsong/csvfiles/E/song1.csv','r')
#song2_csv = CSV.open('/home/omri/millionsong/csvfiles/E/song2.csv','r')
#song3_csv = CSV.open('/home/omri/millionsong/csvfiles/E/song3.csv','r')
#song4_csv = CSV.open('/home/omri/millionsong/csvfiles/E/song4.csv','r')
#term_csv=CSV.open('/home/omri/millionsong/DWH/Terms dim/A.csv','r')
#art_csv = CSV.open('/home/omri/millionsong/csvfiles/D/artist.csv','r')
#p "loading artists"
#Etl_methods.load_artists art_csv    
#p 'completed loading artists succsesfully'
#p '-----------------------------------------'

#p "loading songs it may take a while"
#Etl_methods.load_songs song1_csv 
#p '25%'
#Etl_methods.load_songs song2_csv
#p '50%'
#Etl_methods.load_songs song3_csv
#p '75%'
#Etl_methods.load_songs song4_csv
#p '100%'
#p 'completed loading songs succsesfully'
#p '-----------------------------------------'
#p 'loading terms it will take at least two hours'
#Etl_methods.load_terms term_csv
#p 'finished loading terms'
#p ''
#p 'loading process completed succsesfully'

s=CSV.open('/home/omri/millionsong/csvfiles/sn.csv','wb')     
artists=Artist.all
for a in artists
	s << [a.artist_id,a.artist_name]
end	

# csv = CSV.open('/home/omri/millionsong/Aditional_files/similarity.csv','rb')
#  s=CSV.open('/home/omri/millionsong/csvfiles/sn.csv','wb')     
#  csv.each do |row|
#  	target=Artist.where(:artist_id=>row[0]).first
#  	similar=Artist.where(:artist_id=>row[1]).first
#  	unless target.nil? || similar.nil?
#  		s << [target.artist_name.to_s,similar.artist_name.to_s] 
#  	end
#  end	