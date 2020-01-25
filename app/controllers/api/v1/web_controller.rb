class Api::V1::WebController < ActionController::API
    before_action :set_user, only: [ :habit_menu ]


    def habit_menu
        @habits = Habit.where(user: @user)
    end

    private 

    def set_user
        @user = User.find(params[:id])  
    end

end 