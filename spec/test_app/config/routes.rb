Rails.application.routes.draw do

  root 'top#index'

  mount LazyRender::Engine => "/lazy_render"
end
