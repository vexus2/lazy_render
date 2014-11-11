LazyRender::Engine.routes.draw do
  match 'load', to: 'lazyload#load', via: 'post'
end
