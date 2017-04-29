# Forked and adapted from [Translate Everything to English Using R by andreas](https://www.kaggle.com/anguyen/coupon-purchase-prediction/translate-everything-to-english-using-r/)

system("ls ../input")
system("echo \n\n")
system("head ../input/*")

#################################################################################
# This script translates Japanese text to English in the data files
# and keeps the English translation in separate columns
#################################################################################

# Create master translation table from Japanese to English
coupon_list_train = read.csv("../input/coupon_list_train.csv", as.is=T) # Source file the English list is keyed by
trans = data.frame(
  jp=unique(c(coupon_list_train$GENRE_NAME, coupon_list_train$CAPSULE_TEXT,
              coupon_list_train$large_area_name, coupon_list_train$ken_name,
              coupon_list_train$small_area_name)),
  en=c("Food","Hair salon","Spa","Relaxation","Beauty","Nail and eye salon","Delivery service","Lesson","Gift card","Other coupon","Leisure","Hotel and Japanese hotel","Health and medical","Other","Hotel","Japanese hotel","Vacation rental","Lodge","Resort inn","Guest house","Japanse guest house","Public hotel","Beauty","Event","Web service","Class","Correspondence course","Kanto","Kansai","East Sea","Hokkaido","Kyushu-Okinawa","Northeast","Shikoku","Chugoku","Hokushinetsu","Saitama Prefecture","Chiba Prefecture","Tokyo","Kyoto","Aichi Prefecture","Kanagawa Prefecture","Fukuoka Prefecture","Tochigi Prefecture","Osaka prefecture","Miyagi Prefecture","Fukushima Prefecture","Oita Prefecture","Kochi Prefecture","Hiroshima Prefecture","Niigata Prefecture","Okayama Prefecture","Ehime Prefecture","Kagawa Prefecture","Tokushima Prefecture","Hyogo Prefecture","Gifu Prefecture","Miyazaki Prefecture","Nagasaki Prefecture","Ishikawa Prefecture","Yamagata Prefecture","Shizuoka Prefecture","Aomori Prefecture","Okinawa","Akita","Nagano Prefecture","Iwate Prefecture","Kumamoto Prefecture","Yamaguchi Prefecture","Saga Prefecture","Nara Prefecture","Mie","Gunma Prefecture","Wakayama Prefecture","Yamanashi Prefecture","Tottori Prefecture","Kagoshima prefecture","Fukui Prefecture","Shiga Prefecture","Toyama Prefecture","Shimane Prefecture","Ibaraki Prefecture","Saitama","Chiba","Shinjuku, Takadanobaba Nakano - Kichijoji","Kyoto","Ebisu, Meguro Shinagawa","Ginza Shinbashi, Tokyo, Ueno","Aichi","Kawasaki, Shonan-Hakone other","Fukuoka","Tochigi","Minami other","Shibuya, Aoyama, Jiyugaoka","Ikebukuro Kagurazaka-Akabane","Akasaka, Roppongi, Azabu","Yokohama","Miyagi","Fukushima","Much","Kochi","Tachikawa Machida, Hachioji other","Hiroshima","Niigata","Okayama","Ehime","Kagawa","Northern","Tokushima","Hyogo","Gifu","Miyazaki","Nagasaki","Ishikawa","Yamagata","Shizuoka","Aomori","Okinawa","Akita","Nagano","Iwate","Kumamoto","Yamaguchi","Saga","Nara","Triple","Gunma","Wakayama","Yamanashi","Tottori","Kagoshima","Fukui","Shiga","Toyama","Shimane","Ibaraki"),
  stringsAsFactors = F)

# Append data with translated columns...

# COUPON_LIST_TRAIN.CSV
coupon_list_train = read.csv("../input/coupon_list_train.csv", as.is=T) # Read data file to translate
names(trans)=c("jp","en_capsule") # Rename column
coupon_list_train=merge(coupon_list_train,trans,by.x="CAPSULE_TEXT",by.y="jp",all.x=T) # Join translation onto original data
names(trans)=c("jp","en_genre"); coupon_list_train=merge(coupon_list_train,trans,by.x="GENRE_NAME",by.y="jp",all.x=T)
names(trans)=c("jp","en_small_area"); coupon_list_train=merge(coupon_list_train,trans,by.x="small_area_name",by.y="jp",all.x=T)
names(trans)=c("jp","en_ken"); coupon_list_train=merge(coupon_list_train,trans,by.x="ken_name",by.y="jp",all.x=T)
names(trans)=c("jp","en_large_area"); coupon_list_train=merge(coupon_list_train,trans,by.x="large_area_name",by.y="jp",all.x=T)
write.csv(coupon_list_train, "coupon_list_train_en.csv", row.names = F)

# COUPON_LIST_TRAIN.CSV
coupon_area_train = read.csv("../input/coupon_area_train.csv", as.is=T)
names(trans)=c("jp","en_small_area"); coupon_area_train=merge(coupon_area_train,trans,by.x="SMALL_AREA_NAME",by.y="jp",all.x=T)
names(trans)=c("jp","en_pref"); coupon_area_train=merge(coupon_area_train,trans,by.x="PREF_NAME",by.y="jp",all.x=T)
write.csv(coupon_area_train, "coupon_area_train_en.csv", row.names = F)

# USER_LIST
user_list = read.csv("../input/user_list.csv", as.is=T)
names(trans)=c("jp","en_pref"); user_list=merge(user_list,trans,by.x="PREF_NAME",by.y="jp",all.x=T)
write.csv(user_list, "user_list_en.csv", row.names = F)

# DETAIL_TRAIN
coupon_detail_train = read.csv("../input/coupon_detail_train.csv", as.is=T) # Read data file to translate
names(trans)=c("jp","en_SMALL_AREA_NAME") # Rename column
coupon_detail_train=merge(coupon_detail_train,trans,by.x="SMALL_AREA_NAME",by.y="jp",all.x=T) # Join translation onto original data
write.csv(coupon_detail_train, "coupon_detail_train_en.csv", row.names = F)

#PREFECTURE LOCATIONS
pref_locations <- read.csv("../input/prefecture_locations.csv", as.is=T)
names(trans)=c("jp","en_PREF_NAME")
pref_locations=merge(pref_locations,trans,by.x="PREF_NAME",by.y="jp",all.x=T) # Join translation onto original data
write.csv(pref_location, "pref_locations_en.csv", row.names = F)
# You get the idea... can use this to translate any of the other files, too