class Weixin::Tips::OrdersController < Weixin::ApplicationController
  load_resource :mending, class: Tips::Mending
  load_resource :cleaning, class: Tips::Cleaning
  load_resource :bulk_purchasing, class: Tips::BulkPurchasing
  load_resource :vip_card, class: Tips::VipCard

  before_filter :authenticate_weixin_account!, except: [:index]
  before_filter :set_weixin_current_user, except: [:index]
  before_filter :get_parent

  def index
    @orders = @parent
  end

  def show
    @order = @parent.find(params[:id])
  end

  def new
    @order = @parent.new
  end

  def create_confirmation
    @order = @parent.new(params.require(:order).permit!)
  end

  def create
    @order = @parent.create(params.require(:order).permit!)
  end

  def use_confirmation
    @count = params[:count].to_i
    @order = @parent.find(params[:id])
  end

  def use
    @count = params[:count].to_i
    @order = @parent.find(params[:id])
    @order.use @count
    @order.save
  end

private

  def get_parent
    @source = @mending || @cleaning || @bulk_purchasing || @vip_card
    @dealer = params[:dealer_id]
    if @source
      @parent = @source.orders
      @parent = @parent.with_user(@user) if @user
    else
      @user ||= authenticate_weixin_account!
      @parent = case params[:type]
        when "mending"
          @user.mending_orders
        when "bulk_purchasing"
          @user.bulk_purchasing_orders
        when "vip_card"
          @user.vip_card_orders
        when "vehicle_insurance"
          @user.vehicle_insurance_orders
        else
          raise ActionController::RoutingError, "Unknown order type: #{params[:type]}"
        end
      @parent = @parent.with_dealer(params[:dealer_id])
    end
  end
  
end