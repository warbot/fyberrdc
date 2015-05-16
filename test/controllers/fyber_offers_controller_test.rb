require 'test_helper'

class FyberOffersControllerTest < ActionController::TestCase
  setup do
    @fyber_offer = fyber_offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fyber_offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fyber_offer" do
    assert_difference('FyberOffer.count') do
      post :create, fyber_offer: {  }
    end

    assert_redirected_to fyber_offer_path(assigns(:fyber_offer))
  end

  test "should show fyber_offer" do
    get :show, id: @fyber_offer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fyber_offer
    assert_response :success
  end

  test "should update fyber_offer" do
    patch :update, id: @fyber_offer, fyber_offer: {  }
    assert_redirected_to fyber_offer_path(assigns(:fyber_offer))
  end

  test "should destroy fyber_offer" do
    assert_difference('FyberOffer.count', -1) do
      delete :destroy, id: @fyber_offer
    end

    assert_redirected_to fyber_offers_path
  end
end
