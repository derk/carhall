require 'spec_helper'

describe "Tips" do
  include_context "shared context"
  let(:dealer) { create :dealer }
  let(:attach_attrs) {{ dealer: dealer }}

  shared_examples "tips resources" do  
    include_examples "resources#index"
    include_examples "resources#show"
  end

  describe Api::Tips::MendingsController do
    let(:resource_name) { :mending }
    include_examples "tips resources"
  end

  describe Api::Tips::CleaningsController do
    let(:resource_name) { :cleaning }
    include_examples "tips resources"
  end

  describe Api::Tips::ActivitiesController do
    let(:resource_name) { :activity }
    include_examples "tips resources"
  end

  describe Api::Tips::BulkPurchasingsController do
    let(:resource_name) { :bulk_purchasing }
    include_examples "tips resources"
  end

  describe "Orders" do
    shared_examples "orders#use" do
      describe "PUT use" do
        let(:put_name) { :use }
        let(:default_args) {{ id: id }}
        include_examples "resources#put"
      end
    end

    shared_examples "orders#finish" do
      describe "PUT finish" do
        let(:put_name) { :finish }
        let(:default_args) {{ id: id }}
        include_examples "resources#put"
      end
    end

    shared_examples "orders#cancel" do
      describe "DELETE cancel" do
        let(:delete_name) { :cancel }
        let(:default_args) {{ id: id }}
        include_examples "resources#delete"
      end
    end

    shared_examples "orders resources" do
      let(:parent) { create parent_name, dealer: dealer }
      let(:resource_name) { :"#{parent_name}_order" }
      let(:attach_attrs) {{ user: user, source: parent }}
      let(:attach_args) {{ :"#{parent_name}_id" => parent.id }}

      include_examples "resources#index"
      include_examples "resources#show"
    end

    describe Api::Tips::OrdersController do
      describe "mending_orders" do
        let(:parent_name) { :mending }
        include_examples "orders resources"
        include_examples "orders#finish"
        include_examples "orders#cancel"
      end

      describe "cleaning_orders" do
        let(:parent_name) { :cleaning }
        include_examples "orders resources"
        include_examples "orders#use"
        include_examples "orders#cancel"
      end

      describe "bulk_purchasing_orders" do
        let(:parent_name) { :bulk_purchasing }
        include_examples "orders resources"
        include_examples "orders#finish"
        include_examples "orders#cancel"
      end
    end

    describe Api::OrdersController do
      let(:attach_args) {{ dealer_id: dealer.id }}
      before do
        create :mending_order, dealer: dealer, source: create(:mending, dealer: dealer)
        create :cleaning_order, dealer: dealer, source: create(:cleaning, dealer: dealer)
        create :bulk_purchasing_order, dealer: dealer, source: create(:bulk_purchasing, dealer: dealer)
      end

      include_examples "resources#index base"
    end
  end
end
