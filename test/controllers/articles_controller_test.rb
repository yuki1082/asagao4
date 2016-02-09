require "test_helper"

class ArticlesControllerTest < ActionController::TestCase
  def setup
    login_as("taro")
  end

  test "index" do
    logout
    5.times {FactoryGirl.create(:article)}
    get :index
    assert_response :success
    assert_equal 5, assigns(:articles).count
  end

  test "show" do
    logout
    article = FactoryGirl.create(:article, expired_at: nil)
    get :show, id: article.id
    assert_response :success
  end

  test "new before_login" do
    logout
    get :new
    assert_response :forbidden

  end

  test "create" do
    post :create, article: FactoryGirl.attributes_for(:article)
    article = Article.order(:id).last
    assert_redirected_to article
  end

  test "update" do
    article = FactoryGirl.create(:article)
    patch :update, id: article.id, article: FactoryGirl.attributes_for(:article)
    assert_redirected_to article
  end

  test "fail to create " do
    attrs = FactoryGirl.attributes_for(:article, title: "")
    post :create, article: attrs
    assert_response :success
    assert_template "new"
  end

  test "fail to update" do
    attrs = FactoryGirl.attributes_for(:article, body: "")
    article = FactoryGirl.create(:article)
    put :update, id: article.id, article: attrs
    assert_response :success
    assert_template "edit"
  end

  test "destroy" do
    article = FactoryGirl.create(:article)
    delete :destroy, id: article.id
    assert_redirected_to :articles
    assert_raises(ActiveRecord::RecordNotFound){
      Article.find(article.id)
    }
  end

end
