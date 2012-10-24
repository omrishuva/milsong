require 'csv'
	indexes=[]
	csv = CSV.open('/home/omri/millionsong/DWH/Terms dim/A.csv','r')
	i=0
	csv.each do |row|
		unless indexes.include? row[0]
			indexes.push(row[0])	
			p i
			i+=1
		end

	end