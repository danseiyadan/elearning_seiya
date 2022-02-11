class ApplicationController < ActionController::Base
  include SessionsHelper
  # これを使うことでsessionhelperの内容が全部のcontrollerで使えるはず。
end
