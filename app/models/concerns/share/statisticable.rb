module Share::Statisticable 
  extend ActiveSupport::Concern

  class << self
    include StatisticsHelper
  end
  
  def stars
    Share::Statisticable.mean_stars reviews
  end

  def last_stars
    review = if reviews.loaded?
      reviews.last
    elsif recent_reviews.loaded?
      recent_reviews.last
    else
      reviews.last
    end
    review.stars if review
  end

  def recent_stars
    if reviews.loaded?
      target_reviews = Share::Statisticable.recent reviews
    else
      target_reviews = recent_reviews
    end
    Share::Statisticable.mean_stars target_reviews
  end

  def recent_orders_count
    recent_orders.length
  end

  def total_cost
    Share::Statisticable.total_cost orders
  end

  def recent_total_cost
    Share::Statisticable.total_cost recent_orders
  end

  def recent_ordered_users_count
    Share::Statisticable.ordered_users_count recent_orders
  end

  def goal_attainment
    Share::Statisticable.goal_attainment orders
  end

  def last_ordered_at
    order = if orders.loaded?
      orders.last
    elsif recent_orders.loaded?
      recent_orders.last
    else
      orders.last
    end
    order.created_at if order
  end

  included do
    scope :cheapie, -> { order('vip_price ASC') }
    scope :favorite, -> { all.sort{|s|s.stars} }
    scope :hot, -> { order('orders_count DESC') }

  end

end
