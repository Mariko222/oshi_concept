require 'csv'

csv_1 = CSV.read('db/fixtures/csv_data/users.csv', headers: true)
csv_1.each do |user|
  User.seed do |s|
    s.id = user[0]
    s.email = user[1]
    s.crypted_password = user[2]
    s.salt = user[3]
    s.name = user[4]
    s.created_at = user[5]
    s.updated_at = user[6]
    s.mypage_name = user[7]
    s.twitter_id = user[8]
    s.reset_password_token = user[9]
    s.reset_password_token_expires_at = user[10]
    s.reset_password_email_sent_at = user[11]
    s.access_count_to_reset_password_page = user[12]
    s.uuid = user[13]
    s.role = user[14].to_i
  end
end

csv_2 = CSV.read('db/fixtures/csv_data/mygenres.csv', headers: true)
csv_2.each do |mygenre|
  Mygenre.seed do |s|
    s.id = mygenre[0]
    s.user_id = mygenre[1]
    s.genre_id = mygenre[2]
    s.created_at = mygenre[3]
    s.updated_at = mygenre[4]
  end
end

csv_3 = CSV.read('db/fixtures/csv_data/posts.csv', headers: true)
csv_3.each do |post|
  Post.seed do |s|
    s.id = post[0]
    s.category = post[1]
    s.type = post[2]
    s.url = post[3]
    s.mygenre_id = post[4]
    s.created_at = post[5]
    s.updated_at = post[6]
    s.title = post[7]
    s.image = post[8]
  end
end

csv_4 = CSV.read('db/fixtures/csv_data/mygenre_favorite_characters.csv', headers: true)
csv_4.each do |mygenre_favorite_character|
  MygenreFavoriteCharacter.seed do |s|
    s.id = mygenre_favorite_character[0]
    s.mygenre_id = mygenre_favorite_character[1]
    s.character_id = mygenre_favorite_character[2]
    s.created_at = mygenre_favorite_character[3]
    s.updated_at = mygenre_favorite_character[4]
  end
end

csv_5 = CSV.read('db/fixtures/csv_data/authentications.csv', headers: true)
csv_5.each do |authentication|
  Authentication.seed do |s|
    s.id = authentication[0]
    s.user_id = authentication[1]
    s.provider = authentication[2]
    s.uid = authentication[3]
    s.created_at = authentication[4]
    s.updated_at = authentication[5]
    s.access_token = authentication[6]
    s.access_token_secret = authentication[7]
  end
end

csv_6 = CSV.read('db/fixtures/csv_data/active_storage_blobs.csv', headers: true)
csv_6.each do |active_storage_blob|
  ActiveStorageBlobs.seed do |s|
    s.id = active_storage_blob[0]
    s.key = active_storage_blob[1]
    s.filename = active_storage_blob[2]
    s.content_type = active_storage_blob[3]
    s.metadata = active_storage_blob[4]
    s.service_name = active_storage_blob[5]
    s.byte_size = active_storage_blob[6]
    s.checksum = active_storage_blob[7]
    s.created_at = active_storage_blob[8]
  end
end

csv_7 = CSV.read('db/fixtures/csv_data/active_storage_attachments.csv', headers: true)
csv_7.each do |active_storage_attachment|
  ActiveStorageAttachments.seed do |s|
    s.id = active_storage_attachment[0]
    s.name = active_storage_attachment[1]
    s.record_type = active_storage_attachment[2]
    s.record_id = active_storage_attachment[3]
    s.blob_id = active_storage_attachment[4]
    s.created_at = active_storage_attachment[5]
  end
end
