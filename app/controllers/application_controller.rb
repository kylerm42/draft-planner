require "application_responder"

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::Serialization
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Concerns::ImplicitResource
  include Pundit

  self.responder = ApplicationResponder
  respond_to :json
end
