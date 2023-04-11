class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def new
        @user = User.new
    end

    def edit
        
    end

    def show
        
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def update
        
        if @user.update(user_params)
            flash[:notice] = "Your account information was successfully updated"
            redirect_to @user
        else
            render "edit"
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome to the Alpha Blog, #{@user.username.capitalize}! You have successfully signed up."
            session[:user_id]= @user.id 
            redirect_to articles_path
        else
            render 'new'
        end
    end
    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "The profile and all associated articles were successfully deleted."
        redirect_to articles_path
    end

    private 
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You can only edit your own profile."
            redirect_to @user
        end
    end

end