class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        if @user.save
            sign_in @user
            redirect_to root_path
        else
            redirect_to sign_up_path
        end
    end

    def new
        render :profile
    end

    def upload_avatar
        user = User.find(current_user.id)
        user.update(user_avatar)
        redirect_to "/#{current_user.username}"
    end

    private
    def user_params
        params.require(:user).permit(:name, :username, :email, :password)
    end

    def user_avatar
        params.require(:user_avatar).permit({avatar: []})
    end
end
