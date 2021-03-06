#require 'grape-swagger'

class AssistantAPI < Grape::API
  version 'v1', using: :param
  format :json
  helpers GrapeHelper

  error_formatter :json, ErrorFormatter
  formatter :json, DataFormatter

  rescue_from :all do |exception|
    status_code = ActionDispatch::ExceptionWrapper.new(env, exception).status_code
    error = "#{status_code} #{exception.class.name.demodulize.titleize}: #{exception.message}"
    Rack::Response.new({
      error: error,
      success: false
    }.to_json, status_code, "content-type" => "application/json")
  end

  desc "获取更新信息"
  params do
    requires :version, desc: '当前版本号'
  end 
  get :version do
    if params[:version].to_i < 100
      { update: false }
    else
      { download_url: "http://115.28.13.212/assistant.apk", update: true }
    end
  end

  mount Accounts::LoginAPI
  mount Accounts::CurrentUserAPI => '/current_user'
  mount Tips::VipCardOrderAPI => '/vip_card_orders'
  mount Statistic::OperatingRecordAPI => '/operating_records'
  mount Statistic::SalesCaseAPI => '/sales_cases'
  mount Statistic::ConsumptionRecordAPI => '/consumption_records'
  mount Statistic::ConsumptionRecordAPI => '/users/:user_id/consumption_records'
  mount Tips::MendingOrderAPI => '/mending_orders'
  mount Tips::VehicleInsuranceOrderAPI => '/vehicle_insurance_orders'
  mount Tips::SecondhandAppraiseOrderAPI => '/secondhand_appraise_orders'
  mount Tips::TestDrivingOrderAPI => '/test_driving_orders'
 # add_swagger_documentation mount_path: "/assistant_doc"
end
