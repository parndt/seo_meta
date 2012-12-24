Rails.application.routes.draw do
  #
  match ':route', :to => 'home#home'
end
