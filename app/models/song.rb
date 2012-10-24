class Song
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap
#attributes#####################################
key :song_id,String #1
key :track_id,String #2
key :track_7digitalid,String #3
key :audio_md5,String #4
key :title,String #5
key :album,String #6
key :release_7digitalid, String #7
key :year, String #8
key :duration, Float #9
key :samp_rt, Float #10
key :tempo, Float #11
key :danceability, Float #12
key :energy, Float #13
key :loudness, Float #14
key :song_hot, Float #15
key :end_fade_in, Float #16   #index of the song's segment
key :song_key,Integer  #17 
key :key_c,Float  #18
key :mode, Integer  #19 #minor=0 major=1
key :mode_conf, Float #20  #precentage
key :start_fade_out,Float #21
key :time_sig, Integer  #22
key :time_sig_c, Float  #23
key :bars_c_avg, Float #24
key :bars_c_max, Float #25
key :bars_c_min, Float #26
key :bars_c_stddev, Float #27
key :bars_c_count, Float #28
key :bars_c_sum, Float #29
key :bars_start_avg, Float #30
key :bars_start_max, Float #31
key :bars_start_min, Float #32
key :bars_start_stddev, Float #33
key :bars_start_count,Integer #34
key :bars_start_sum,Float #35
key :beats_c_avg, Float #36
key :beats_c_max, Float #37
key :beats_c_min, Float #38
key :beats_c_stddev, Float #39
key :beats_c_count, Float #40
key :beats_c_sum, Float #41
key :beats_start_avg, Float #42
key :beats_start_max, Float #43
key :beats_start_min, Float #44
key :beats_start_stddev, Float #45
key :beats_start_count, Integer #46
key :beats_start_sum, Float #47
key :sec_c_avg, Float  #48
key :sec_c_max, Float  #49
key :sec_c_min, Float  #50
key :sec_c_stddev, Float #51
key :sec_c_count, Integer #52
key :sec_c_sum, Float #53
key :sec_start_avg, Float #54
key :sec_start_max, Float #55
key :sec_start_min, Float #56
key :sec_start_stddev, Float #57
key :sec_start_count, Integer #58
key :sec_start_sum, Float #59
key :seg_c_avg, Float #60
key :seg_c_max, Float #61
key :seg_c_min, Float #62
key :seg_c_stddev, Float #63
key :seg_c_count, Integer #64
key :seg_c_sum, Float #65
key :seg_loud_max_avg, Float #66
key :seg_loud_max_max, Float #67
key :seg_loud_max_min, Float #68
key :seg_loud_max_stddev, Float #69
key :seg_loud_max_count, Integer #70
key :seg_loud_max_sum, Float #71
key :seg_loud_max_time_avg, Float #72
key :seg_loud_max_time_max, Float #73
key :seg_loud_max_time_min, Float #74
key :seg_loud_max_time_stddev, Float #75
key :seg_loud_max_time_count, Integer #76
key :seg_loud_max_time_sum, Float #77
key :seg_loud_start_avg, Float #78
key :seg_loud_start_max, Float #79
key :seg_loud_start_min, Float #80
key :seg_loud_start_stddev, Float #81
key :seg_loud_start_count, Integer #82
key :seg_loud_start_sum, Float  #83
key :seg_pitch_avg, Array # 84,90,96,102,108,114,120,126,132,138,144,150
key :seg_pitch_max, Array # 85,91,97,103,109,115,121, 127, 133,139,145,151
key :seg_pitch_min, Array # 86, 92,98,104,110,116,122,128,134 140,146,152 
key :seg_pitch_stddev, Array # 87,93,99,105,111,117,123,129,135,141,147,153
key :seg_pitch_count, Array # 88,94,100,105,112,118,124,130,136,142,148,154
key :seg_pitch_sum, Array #89,95,101,107,113,119,125,131,137,143,149,155
key :seg_start_avg, Float #156
key :seg_start_max, Float #157
key :seg_start_min, Float #158
key :seg_start_stddev, Float #159
key :seg_start_count, Integer #160
key :seg_start_sum, Float #161, 167 
key :seg_timbre_avg, Array #162 168 174 180 186 192 198 204 210 216 222,228
key :seg_timbre_max,Array #163 169 175 181 187 193 199 205 211 217 223 229
key :seg_timbre_min,Array #164 170 176 182 188 194 200 206 212 218 224  230
key :seg_timbre_stddev,Array #165 171 177 183 189 195 201 207 213 219 225 231
key :seg_timbre_count,Array #166 172 178 184 190 196 207 208 214 220 226 232
key :seg_timbre_sum,Array #167 173 179 185 191 197 208 209 215 221 227 233
key :tatms_c_avg, Float #234
key :tatms_c_max, Float #235
key :tatms_c_min, Float #236
key :tatms_c_stddev, Float #237
key :tatms_c_count, Float #238
key :tatms_c_sum, Float #239
key :tatms_start_avg, Float #240
key :tatms_start_max, Float #241
key :tatms_start_min, Float #242
key :tatms_start_stddev, Float #243
key :tatms_start_count,Integer #244
key :tatms_start_sum, Float #245
#Relationship
belongs_to :artist

end
