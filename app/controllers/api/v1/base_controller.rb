class Api::V1::BaseController < ApplicationController
  before_action :doorkeeper_authorize!

  protected

  def current_author
    @current_author ||= Author.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
