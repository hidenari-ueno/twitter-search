Rails.application.routes.draw do
  get "/tweets/search" => 'tweets#search'
end
