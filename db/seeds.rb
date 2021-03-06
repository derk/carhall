# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Accounts::Account.where(mobile: '13112345678').destroy_all
me = FactoryGirl.create :user, mobile: '13112345678'

test_users = [%w(张敬伟 18600037683), %w(李永亮 15910967893), %w(李阳 15901013540), %w(李行 18053932727), %w(胡潇 15810535015), %w(白云 13911307656), %w(张永良 18910873748)]
test_users.each do |u, m|
  FactoryGirl.create :user, username: u, mobile: m rescue nil
end

test_users = %w(何总 杨俊 李小新 陈仙萍 张颜峰)
test_users.each do |u|
  FactoryGirl.create :user, username: u rescue nil
end

Accounts::User.all.each do |u|
  10.times do
    u.make_friend_with! Accounts::User.all.sample
  end
end

Accounts::Account.where(mobile: '13212345678').destroy_all
dealer = FactoryGirl.create :dealer, mobile: '13212345678'

Accounts::Account.where(mobile: '13312345678').destroy_all
provider = FactoryGirl.create :provider, mobile: '13312345678'

3.times do 
  u = FactoryGirl.create :user
  me.make_friend_with! u
end

100.times do
  FactoryGirl.create :post, user: me.user_friends.sample
end

1000.times do
  FactoryGirl.create :comment, source: Posts::Post.all.sample, 
    user: Accounts::User.all.sample, at_user: Accounts::User.all.sample
end

25.times do
  u = FactoryGirl.create :user
  u.make_friend_with! dealer
  u.make_friend_with! provider
end

mending = FactoryGirl.create :mending, dealer: dealer
5.times do
  mending_order = FactoryGirl.create :mending_order,
    user: dealer.inverse_friends.sample, source: mending
  FactoryGirl.create :review, order: mending_order
end

5.times do
  cleaning = FactoryGirl.create :cleaning, dealer: dealer
  5.times do
    cleaning_order = FactoryGirl.create :cleaning_order, 
      user: dealer.inverse_friends.sample, source: cleaning
    FactoryGirl.create :review, order: cleaning_order
  end

  activity = FactoryGirl.create :activity, dealer: dealer

  bulk_purchasing = FactoryGirl.create :bulk_purchasing, dealer: dealer
  5.times do
    bulk_purchasing_order = FactoryGirl.create :bulk_purchasing_order, 
      user: dealer.inverse_friends.sample, source: bulk_purchasing
    FactoryGirl.create :review, order: bulk_purchasing_order
  end
end

3.times do
  FactoryGirl.create :programme, provider: provider
  FactoryGirl.create :host, provider: provider, programmes: Bcst::Programme.all.sample(3)
end

10.times do
  FactoryGirl.create :programme_list, provider: provider
end

25.times do
  FactoryGirl.create :exposure, provider: provider
  FactoryGirl.create :traffic_report, provider: provider
  FactoryGirl.create :programme_comment, source: Bcst::Programme.all.sample
end


