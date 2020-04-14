# frozen_string_literal: true

module ControllerHelpers
  def sign_in(user = build_user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  private

  def build_user
    instance_double(:user)
  end
end
