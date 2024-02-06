class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

    def update
        user_params = params.require(:user).permit(:name, :image, :description, :follow_notification_enabled, :thank_notification_enabled, :comment_notification_enabled, tag_names: [])

        if current_user.update(
            name: user_params[:name], 
            image: user_params[:image], 
            description: user_params[:description],
            follow_notification_enabled: user_params[:follow_notification_enabled], 
            thank_notification_enabled: user_params[:thank_notification_enabled],
            comment_notification_enabled: user_params[:comment_notification_enabled],
            tags: Tag.where(name: user_params[:tag_names])
            )
            render json: current_user
        else
            render json: {status: "faild"}
        end
    end

    private

    def sign_up_params
        # サインアップ時に登録できるカラムを指定
        params.permit(:email, :password, :name, :password_confirmation, :role)
    end

    def account_update_params
        params.require(:user).permit(:name, :image)
    end

end
