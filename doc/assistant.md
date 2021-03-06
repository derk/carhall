Assistant Api
=====

#### GET /assistant/version(.:format)  

获取更新信息

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
version | true |  | 当前版本号

-----

#### POST /assistant/login(.:format)  

使用手机号和密码登录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
data[mobile] | true | Integer | 手机号
data[password] | true | String | 密码

-----

#### GET /assistant/current_user(.:format)  

显示当前登录用户详情

-----

#### GET /assistant/vip_card_orders(.:format)  

显示当前登录商户的所有会员卡订单

-----

#### GET /assistant/vip_card_orders/:id(.:format)  

显示指定会员卡订单详情

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### POST /assistant/vip_card_orders/search(.:format)  

通过手机号或车牌号搜索车主会员卡订单

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
query | true | String | 手机号或车牌号

-----

#### POST /assistant/vip_card_orders/:id/use(.:format)  

设置会员卡订单使用次数

> 例如：
> ```
> POST /assistant/vip_card_orders/1/use
> data[1]   1
> data[2]   2
> ```


Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  
data | true | Hash | key为会员卡订单服务项目ID，value为使用次数

-----

#### GET /assistant/operating_records(.:format)  

显示当前登录商户的所有工作记录

-----

#### GET /assistant/operating_records/:id(.:format)  

显示指定工作记录详情

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### POST /assistant/operating_records(.:format)  

新建一条工作记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
data[user_brand] | false | String | 车型
data[user_plate_num] | true | String | 车牌号
data[project] | true | String | 施工项目
data[operator] | false | String | 施工人员
data[inspector] | false | String | 质检员
data[adviser] | true | String | 服务顾问

-----

#### PUT /assistant/operating_records/:id(.:format)  

编辑一条工作记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  
data[user_brand] | false | String | 车型
data[user_plate_num] | true | String | 车牌号
data[project] | true | String | 施工项目
data[operator] | false | String | 施工人员
data[inspector] | false | String | 质检员
data[adviser] | true | String | 服务顾问

-----

#### GET /assistant/sales_cases(.:format)  

显示当前登录商户的所有销售跟踪记录

-----

#### GET /assistant/sales_cases/:id(.:format)  

显示指定销售跟踪记录详情

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### POST /assistant/sales_cases(.:format)  

新建一条销售跟踪记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
data[user_id] | true | Integer | 客户ID
data[description] | true | String | 客户问题描述
data[solution] | true | String | 推荐方案
data[adviser] | true | String | 服务顾问
data[state_id] | false | Integer | 状态ID：1.跟踪 2.解决 3.取消

-----

#### PUT /assistant/sales_cases/:id(.:format)  

编辑一条销售跟踪记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  
data[user_id] | true | Integer | 客户ID
data[description] | true | String | 客户问题描述
data[solution] | true | String | 推荐方案
data[adviser] | true | String | 服务顾问
data[state_id] | false | Integer | 状态ID：1.跟踪 2.解决 3.取消

-----

#### POST /assistant/sales_cases/search(.:format)  

通过手机号或车牌号搜索销售跟踪记录

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
query | true | String | 手机号或车牌号

-----

#### GET /assistant/consumption_records(.:format)  

显示当前登录商户的该用户的所有消费记录

-----

#### GET /assistant/consumption_records(.:format)  

显示当前登录商户的该用户的所有消费记录

-----

#### GET /assistant/mending_orders(.:format)  

显示当前登录商户的所有保养专修订单

返回数据中user内车型等数据的是车主信息，user外的是订单信息，以订单数据为准


-----

#### GET /assistant/mending_orders/:id(.:format)  

显示指定保养专修订单详情

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### PUT /assistant/mending_orders/:id(.:format)  

编辑一条保养专修订单

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  
data[dealer_state_id] | true | Integer | 状态ID：1.跟踪 2.解决

-----

#### GET /assistant/vehicle_insurance_orders(.:format)  

显示当前登录商户的所有车险续保订单

返回数据中user内车型等数据的是车主信息，user外的是订单信息，以订单数据为准


-----

#### GET /assistant/vehicle_insurance_orders/:id(.:format)  

显示指定车险续保订单详情

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### PUT /assistant/vehicle_insurance_orders/:id(.:format)  

编辑一条车险续保订单

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  
data[dealer_state_id] | true | Integer | 状态ID：1.跟踪 2.解决

-----

#### GET /assistant/secondhand_appraise_orders(.:format)  

显示当前登录商户的所有二手评估订单

返回数据中user内车型等数据的是车主信息，user外的是订单信息，以订单数据为准


-----

#### GET /assistant/secondhand_appraise_orders/:id(.:format)  

显示指定二手评估订单详情

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### PUT /assistant/secondhand_appraise_orders/:id(.:format)  

编辑一条二手评估订单

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  
data[dealer_state_id] | true | Integer | 状态ID：1.跟踪 2.解决

-----

#### GET /assistant/test_driving_orders(.:format)  

显示当前登录商户的所有试驾订单

-----

#### GET /assistant/test_driving_orders/:id(.:format)  

显示指定试驾订单详情

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  

-----

#### PUT /assistant/test_driving_orders/:id(.:format)  

编辑一条试驾订单

Parameters:

Name | Required | Type | Desc.
---- | -------- | ---- | -----
id | true |  |  
data[dealer_state_id] | true | Integer | 状态ID：1.跟踪 2.解决

-----
