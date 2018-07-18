class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        @user.update(role: 2)
        if @user.save
            UserJob.perform_later(@user)
            sign_in @user
            redirect_to root_path
        else
            flash.now[:notice] = "Sign up failed!"
            redirect_to sign_up_path
        end
    end

    def new
        @page_owner = User.find_by(username: params[:username])
        render :profile
    end

    def edit
    end

    def upload_avatar
        user = User.find(current_user.id)
        user.update(user_avatar)
        redirect_to "/#{current_user.username}"
    end

    def destroy
        User.find_by(username: params[:username]).delete
        redirect_to "/users"
    end

    private
    def user_params
        params.require(:user).permit(:name, :username, :email, :password)
    end

    def user_avatar
        params.require(:user_avatar).permit(:avatar)
    end
end
