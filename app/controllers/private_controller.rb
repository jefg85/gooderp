class PrivateController < ApplicationController

  before_action :authenticate_usuario!

end
