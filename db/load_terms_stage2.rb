require 'csv' 
    count=0
    i=0
    art_indexes=song_indexes=[]
    csv=CSV.open('/home/omri/millionsong/csvfiles/subset/term.csv','r')
    csv.each do |row|
        i+=1
        artist=(Artist.find_by_artist_id(row[0]))
        unless art_indexes.include? row[0]  
            art_indexes.push(row[0]) 
            song_indexes.push(row[1])
            artist.terms.push(Term.new({:term=>row[2],:term_freq=>row[3],:term_weight=>row[4]}))
            artist.save 
            count+=1
            p count.to_s + i.to_s
        else
            if song_indexes.include? row[1]
                artist.terms.push(Term.new({:term=>row[2],:term_freq=>row[3],:term_weight=>row[4]}))
                artist.save      
                count+=1
                p count.to_s + i.to_s
            end   
        end         
    end     

    