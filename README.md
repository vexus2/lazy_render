# LazyRender

![lazy_render](https://raw.githubusercontent.com/vexus2/lazy_render/master/spec/assets/images/lazy-render.png)

## What is this?
It delays loading of partial or actions in views.

## Installation

LazyRender works with Rails 4.0 onwards. You can add it to your Gemfile with:

```
gem 'lazy_render'
```


## Usage

### 1. Route to LazyRender

add to `routes.rb`
```
  lazy_render_for 'lazy_render/load', to: 'lazy_render'
```

### 2. Configuring Javascript

add to `application.js`

```
//= require jquery
//= require lazy_render
```

### 3. Configuring Controller

add to include helper into application_controller

```
class ApplicationController < ActionController::Base
  helper LazyRender::LazyloadHelper
end
```

create a controller to run lazy render

controllers/lazy_render_controller.rb
```
class LazyRenderController < LazyRender::LazyloadController
  def load
    super
  end
end
```

and add some action to `LazyRenderController`

```
def sample_action(locals)
  @data[:sample_text] = 'Hello LazyRender!'
  @data[:pass_value] = locals[:value]
end
```


### 4. Configuring View

create view file under `views/lazy_render/`

views/lazy_render/sample_action.html.erb
```
<h2>This is sample view.</h2>
<p><%= data[:sample_text] %></p>
<h3><%= data[:pass_value] %></3>
```


### 5. Call lazy_render from View

Call lazy_render from your any views

```
<%= lazy_render :sample_text, locals: { value: 'Sample Text' } %>
```

```
<h2>This is sample view.</h2>
<p>Hello LazyRender!</p>
<h3>Sample Text</3>
```

### lazy_render options
- *locals* : The parameters to passed to action
- *cache* : Time to hold a View to the local storage. Default: 0
- *callback* : To specify the Javascript method that you want to execute after displaying partial.
- *parallel* : I carry it out in parallel without compiling a request in lazy_render

## Contributing

1. Fork it ( https://github.com/vexus2/lazy_render/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Authors
[vexus2](https://github.com/vexus2)


## Thanks to
be inspired by [akiyan](https://github.com/akiyan)
