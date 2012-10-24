class Artist
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap
  include Utiles
  include Etl_methods
  #attributes#################################################################################################
  key :coordinates,Array
  key :geo_tags, Array   
  key :artist_7digitalid, String
  key :artist_mbid, String
  key :artist_pmid, String
  key :artist_id, String
  key :artist_name, String
  key :artist_fam, Float
  key :artist_hot,Float 
  key :load, String
  #associations#############################################################################################
  many :terms
  many :songs 
  ##########################################################################################################
  attr_accessible :artist_name,:artist_7digitalid,:artist_mbid,:artist_pmid,:artist_id,:artist_fam,:artist_hot,:coordinates,:state_province,:country,:city
  #dynamic scopes########################################################################################### 
  scope :by_fam_range,  lambda {|low, high| where(:artist_hot.gte => low, :artist_hot.lte => high)}
  scope :by_hot_range,  lambda {|low, high| where(:artist_hot.gte => low, :artist_hot.lte => high)}
  scope :by_name,  lambda { |name| where(:artist_name => name)}
  scope :term_by_name,  lambda { |name| where(:artist_name => name).fields(:terms).sort("terms.term_freq.desc") }
  scope :by_loc,  lambda { |loc| where(:geo_tags => loc).sort(:artist_fam.desc) }
  scope :by_term,  lambda {|term| where("terms.term"=>term).sort(:artist_fam.desc).limit(200)}                                   
  #scope :by_term_fam,  lambda {|term,lim| where("terms.term"=>term).sort(:artist_fam.desc).limit(lim)}
  #scope :by_term_hot,  lambda {|term,lim| where("terms.term"=>term).sort(:artist_hot.desc,:artist_fam.desc).limit(lim)}

  #static scopes############################################################################################
  scope :term_freq,  where("terms.term_freq" => 1)
  
  #class methods############################################################################################ 	   
def self.pl(user_artist)
  final_artist=temp_artist=artist=art_id=[]
  terms=Artist.all_terms(user_artist)   #all term by the chosen artist
  artist=Artist.by_term(terms[0]).all #finds all the artists related by the terms
  term2=Artist.all_terms(artists[0].artists_name) #get all the terms by the related artists
  common=Utiles.common_term(terms,term2)
  art_id.push({:id=>a.artist_id,:name=>a.artist_name,:common_term=>common})
  i=1
  j=0
  while terms[i] 
    p terms[i]
    while artist[i]
        unless art_id.include? artists[i].artist_id  
            term2=Artist.all_terms(a.artist_name) #get all the terms by the related artists
            common=Utiles.common_term(terms,term2) #finds how many terms the chsosen and the matching artist has in common
            #if common>art_id[j]
            #  art_id[i]=({:id=>a.artist_id,:name=>a.artist_name,:common_term=>common})
            #else
            #  until j==0
            #    if common
        end
    end  
  end  
  final_artist=Utiles.bubble_sort_common_terms art_id   #sort the matching artist desc by the common terms
  final_artist
end  


          
    
      
    
  #art=temp_art.uniq
  #for a in art
   #  list.push(a.artist_name)  
  #end  
#list 
def self.get_geo_tags
  arr_geo=[]
  art=Artist.where(:geo_tags.ne=>[]).fields(:artist_id,:geo_tags).all
  for a in art
    for geo in a.geo_tags
       arr_geo.push(geo) 
    end  
  end 
    arr_geo=arr_geo.uniq.sort
    Etl_methods.write_to_csv arr_geo
end  

def self.list_of_uniq_terms
  terms_arr=[]
  art=Artist.fields(:terms).all
  p "1"
  i=0
  while art[i] 
     for t in art[i].terms
        unless terms_arr.include? t.term
          terms_arr.push(t.term)
          terms_arr.sort          
        end
     end
  i+=1
  end
terms_arr.sort
end  

#return the average hottness of the best match artists for the term
def self.term_hottness (user_term)
	a=self.best_match_by_term user_term
	sum=0
	for artist in a
		sum+=artist.artist_hot
	end	
	 sum/a.count unless sum ==0
end	
 #return the average familiarity of the best match artists for the term
def self.term_fam (user_term)
	a=self.best_match_by_term user_term
	sum=0
	for artist in a
		sum+=artist.artist_fam unless artist.artist_fam ==0
	end	
	sum/a.count
end	
 	
  #return best match artists for terms ##return array of artist objects sorted by artist familiarity 
  def self.best_match_by_term (user_term)
  	term_temp=result=temp_result=[]
  	fam=[]
  	already_found=[]
  	a=(self.by_term(user_term)).all
  	for artist in a
  		term_temp=self.freq_terms_artist(artist.artist_name)	
  		if term_temp.include? user_term
  			if artist.artist_fam.class==Float
  			   temp_result.push(artist)
  			 end
  		
  		end	
  	end
  	result=Utiles.bubble_sort temp_result
  end	
  	
  	 #return best match artists for terms ##return array of artist objects sorted by artist familiarity 
  def self.albums_best_match_by_term (user_term)
  	term_temp=result=[]
  	already_found=[]
  	a=(self.by_term(user_term)).all
  	for artist in a
  		for artist_albums in artist.albums
  			term_temp=self.freq_terms_artist(artist.artist_name)	
  			if term_temp.include? user_term
  			   result.push({:album=>artist_albums.album,:year=>artist_albums.year})  		
  			end	
  		end
  	end
  	result
  end	
 
 def self.all_terms (user_art)
  art=Artist.by_name(user_art).first
  terms=[]
    for t in art.terms
        unless terms.include? t.term 
          #p t.term.to_s + "    " + t.term_freq.to_s
          terms.push(t.term)
        end
    end
  terms
 end
  #return the most frequent terms of an artist ## return array of terms(string)
  def self.freq_terms_artist(artist_name)
  	terms=[]
  	a=Artist.by_name(artist_name).first
  	for term in a.terms
  		if term.term_freq>=0.8
  		   terms.push(term.term)
  		end	
  	end	
  	terms=terms.uniq
    terms
  end	

end
  #instance methods#########################################################################################

#a=Artist.where("$and"=> [{"terms.term"=>"downtempo"},{"terms.term_freq"=>{"$gte"=>1}}]).all


#def self.load_geo_tags
# geo_tags=[]
#  artist=Artist.all
#  for a in artist
#    a.geo_tags.push(a.neighborhood) unless a.neighborhood.nil?
#    a.geo_tags.push(a.city) unless a.city.nil?
#    a.geo_tags.push(a.state_province) unless a.state_province.nil?
#    a.geo_tags.push(a.country) unless a.country.nil?
#    a.save
#    p a.geo_tags
#  end


 #include Geocoder::Model::MongoMapper
#reverse_geocoded_by :coordinates 
#after_validation :reverse_geocode 
#before_save :fetch_location 
#after_save :message




  #def message
   # p self.artist_name.to_s +  "  saved"
  #end 
  #def fetch_location (loc) 
  # unless self.address.nil?   
  #    loc=[]
  #    loc=self.address.split "," 
  #    if loc.count >=4
  #      country=loc[loc.count-1].delete "0-9"
  #      country=country.strip.downcase
  #      state=loc[loc.count-2].delete "0-9"
  #      state_province=state.strip.downcase
  #      city=loc[loc.count-3].delete "0-9"
  #      city=city.strip.downcase
  #      else
  #       country=loc[loc.count-1].delete "0-9"
  #       country=country.strip.downcase
  #       city=loc[loc.count-2].delete "0-9"
  #       self.city=city.strip.downcase
   #   end
   # end
  #end   