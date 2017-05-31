class PrivateController < ApplicationController

  before_action :authenticate_usuario!
  before_action :set_paper_trail_whodunnit

  def user_for_paper_trail
    usuario_signed_in? ? current_usuario.id : 'Public user'
  end

end
