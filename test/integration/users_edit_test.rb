require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:joe)
  end

  test "unsuccessful edit" do    
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "",
                                    email: "food@invalid",
                                    password: "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: "",
                                    password_confirmation: "" }

    assert_not flash.empty?
    assert_redirected_to @users
    @user.reload
    assert_equal @user.name,  name
    assert_equal @user.email, email
  end

  test "friendly forwarding when accessing edit page" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
  end

end
