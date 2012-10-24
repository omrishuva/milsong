 require 'csv'
 p "open csv file"
 csv = CSV.open('/home/omri/millionsong/csvfiles/B/song3.csv','r')
 i=0
p "start block"
 csv.drop(1).each do |row|
      artist=(Artist.find_by_artist_id(row[0]))
     seg_pitch_avg=seg_pitch_max=seg_pitch_min=seg_pitch_stddev=seg_pitch_count=seg_pitch_sum=[]
     seg_timbre_avg=seg_timbre_max=seg_timbre_min=seg_timbre_stddev=seg_timbre_count=seg_timbre_sum=[]
     seg_pitch_avg=[row[84],row[90],row[96],row[102],row[108],row[114],row[120],row[126],row[132],row[138],row[144],row[150]]
     seg_pitch_max=[row[85],row[91],row[97],row[103],row[109],row[115],row[121],row[127],row[133],row[139],row[145],row[151]]
     seg_pitch_min=[row[86],row[92],row[98],row[104],row[110],row[116],row[122],row[128],row[134],row[140],row[146],row[152]]
     seg_pitch_stddev=[row[87],row[93],row[99],row[105],row[111],row[117],row[123],row[129],row[135],row[141],row[147],row[153]]
     seg_pitch_count=[row[88],row[94],row[100],row[105],row[112],row[118],row[124],row[130],row[136],row[142],row[148],row[154]]
     seg_pitch_sum=[row[89],row[95],row[101],row[107],row[113],row[119],row[125],row[131],row[137],row[143],row[149],row[155]]
     seg_timbre_avg= [row[162],row[168],row[174],row[180],row[186],row[192],row[198],row[204],row[210],row[216],row[222],row[228]]
     seg_timbre_max=[row[163],row[169],row[175],row[181],row[187],row[193],row[199],row[205],row[211],row[217],row[223],row[229]]
     seg_timbre_min=[row[164],row[170],row[176],row[182],row[188],row[194],row[200],row[206],row[212],row[218],row[224],row[230]]
     seg_timbre_stddev=[row[165],row[171],row[177],row[183],row[189],row[195],row[201],row[207],row[213],row[219],row[225],row[231]]
     seg_timbre_count=[row[166],row[172],row[178],row[184],row[190],row[196],row[207],row[208],row[214],row[220],row[226],row[232]]
     seg_timbre_sum=[row[167],row[173],row[179],row[185],row[191],row[197],row[208],row[209],row[215],row[221],row[227],row[233]]

 Song.create({:artist_id=>artist._id,:song_id=>row[1],:track_id=>row[2],:track_7digitalid=>row[3],:audio_md5=>row[4],:title=>row[5],:album=>row[6],
 :release_7digitalid=>row[7],:year=>row[8],:duration=>row[9],:samp_rt=>row[10],:tempo=>row[11],:danceability=>row[12],
 :energy=>row[13],:loudness=>row[14],:song_hot=>row[15],:end_fade_in=>row[16],:song_key=>row[17],:key_c=>row[18],
 :mode=>row[19],:mode_conf=>row[20],:start_fade_out=>row[21],:time_sig=>row[22],:time_sig_c=>row[23],:bars_c_avg=>row[24],
 :bars_c_max=>row[25],:bars_c_min=>row[26],:bars_c_stddev=>row[27],:bars_c_count=>row[28] ,:bars_c_sum=>row[29],
 :bars_start_avg=>row[30],:bars_start_max=>row[31],:bars_start_min=>row[32],:bars_start_stddev=>row[33],:bars_start_count=>row[34],
 :bars_start_sum=>row[35],:beats_c_avg=>row[36],:beats_c_max=>row[37],:beats_c_min=>row[38] ,:beats_c_stddev=>row[39],:beats_c_count=>row[40],
 :beats_c_sum=>row[41],:beats_start_avg=>row[42],:beats_start_max=>row[43],:beats_start_min=>row[44],:beats_start_stddev=>row[45],:beats_start_count=>row[46],
 :beats_start_sum=>row[47],:sec_c_avg=>row[48] ,:sec_c_max=>row[49],:sec_c_min=>row[50],:sec_c_stddev=>row[51],
 :sec_c_count=>row[52],:sec_c_sum=>row[53],:sec_start_avg=>row[54],:sec_start_max=>row[55],:sec_start_min=>row[56],
 :sec_start_stddev=>row[57],:sec_start_count=>row[58] ,:sec_start_sum=>row[59],:seg_c_avg=>row[60],:seg_c_max=>row[61],
 :seg_c_min=>row[62],:seg_c_stddev=>row[63],:seg_c_count=>row[64],:seg_c_sum=>row[65],:seg_loud_max_avg=>row[66],:seg_loud_max_max=>row[67],
 :seg_loud_max_min=>row[68],:seg_loud_max_stddev=>row[69],:seg_loud_max_count=>row[70],:seg_loud_max_sum=>row[71],
 :seg_loud_max_time_avg=>row[72],:seg_loud_max_time_max=>row[73],:seg_loud_max_time_min=>row[74],:seg_loud_max_time_stddev=>row[75],
 :seg_loud_max_time_count=>row[76],:seg_loud_max_time_sum=>row[77],:seg_loud_start_avg=>row[78],:seg_loud_start_max=>row[79],
 :seg_loud_start_min=>row[80],:seg_loud_start_stddev=>row[81],:seg_loud_start_count=>row[82],:seg_loud_start_sum=>row[83],
 :seg_pitch_avg=>seg_pitch_avg,:seg_pitch_max=>seg_pitch_max,:seg_pitch_min=>seg_pitch_min,:seg_pitch_stddev=>seg_pitch_stddev,:seg_pitch_count=>seg_pitch_count,:seg_pitch_sum=>seg_pitch_sum,
 :seg_start_avg=>row[156],:seg_start_max=>row[157],:seg_start_min=>row[158],:seg_start_stddev=>row[159],:seg_start_count=>row[160],:seg_start_sum=>row[161],
 :seg_timbre_avg=>seg_timbre_avg,:seg_timbre_max=>seg_timbre_max,:seg_timbre_min=>seg_timbre_min,:seg_timbre_stddev=>seg_timbre_stddev,:seg_timbre_count=>seg_timbre_count,:seg_timbre_sum =>seg_timbre_sum,
 :tatms_c_avg=>row[234],:tatms_c_max=>row[235],:tatms_c_min=>row[236],:tatms_c_stddev=>row[237],:tatms_c_count=>row[238],
 :tatms_c_sum=>row[239],:tatms_start_avg=>row[240],:tatms_start_max=>row[241],:tatms_start_min=>row[242],:tatms_start_stddev=>row[243],
 :tatms_start_count=>row[244],:tatms_start_sum=>row[245]})
 i+=1
 p row[5].to_s 
 p i.to_s
 end  