class Api::V1::HabitsController < Api::V1::BaseController
    acts_as_token_authentication_handler_for User#, except: [ :index, :show ]
    before_action :set_habit, only: [ :show, :update, :destroy ]
    
    def index
        @habits = policy_scope(Habit)
    end

    def show
        @image = url_for(@habit.image)
    end

    def update
        if @habit.update(habit_params)
            render :show
        else
            render_error
        end
    end

    def create
        @habit = Habit.new(habit_params)
        @habit.user = current_user
        authorize @habit
        if @habit.save
            @habit.update!(url: url_for(@habit.image))
            render :show
        else
            render_error
        end
    end

    def destroy
        @habit.destroy
        head :no_content
        # No need to create a `destroy.json.jbuilder` view
    end

    private

    def set_habit
        @habit = Habit.find(params[:id])
        authorize @habit  # For Pundit
    end

    def habit_params
        params.permit(:title, :description, :cue, :craving, :response, :reward, :image)
    end

    def render_error
        render json: { errors: @habit.errors.full_messages },
            status: :unprocessable_entity
    end

  end