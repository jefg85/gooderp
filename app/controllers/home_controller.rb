class HomeController < PrivateController
  def index
  end

  private

  def autorizacion!
    true
  end
end
