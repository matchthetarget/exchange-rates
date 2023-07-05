Rails.application.routes.draw do
  # get("/", { :controller => "misc", :action => "homepage" })
  
  get("/", { :controller => "currencies", :action => "list_pairs" })
  get("/:from_currency", { :controller => "currencies", :action => "first_currency" })
  get("/:from_currency/:to_currency", { :controller => "currencies", :action => "convert" })
  
  # get("/covid", { :controller => "pandemic", :action => "index" })
  # get("/covid/:state", { :controller => "pandemic", :action => "details" })
end
