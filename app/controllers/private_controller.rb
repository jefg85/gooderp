class PrivateController < ApplicationController

  before_action :authenticate_usuario!
  before_action :autorizacion!

end
