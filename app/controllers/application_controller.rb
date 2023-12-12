class ApplicationController < ActionController::Base
  require 'open-uri'
  http_basic_authenticate_with name: "appdev", password: "fullstack"
end
