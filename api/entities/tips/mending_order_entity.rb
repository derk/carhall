module Tips
  class MendingOrderEntity < Grape::Entity
    expose :id, :title, :state, :cost, :created_at, :order_type, 
      :arrive_at, :brand, :series, :plate_num, :mending_type,
      :dealer_state, :dealer_state_id
    expose :user, using: Statistic::UserInfoEntity
  end
end
