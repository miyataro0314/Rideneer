class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def top; end

  def side_menu; end

  def privacy_policy; end
end
