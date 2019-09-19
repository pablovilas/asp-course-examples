class ApplicationController < ActionController::Base
    set_current_tenant_through_filter
    before_action :set_organization

    def set_organization
        if user_signed_in?
            current_organization = Organization.find current_user.organization_id
            set_current_tenant(current_organization)
        end
    end
end
