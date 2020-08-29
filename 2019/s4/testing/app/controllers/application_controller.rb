class ApplicationController < ActionController::Base
    def render_error(code, message)
        render json: { code: code, message: message }, status: code
    end
end
