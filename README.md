# Puffer_pages is lightweight rails 3.1 CMS

Interface of pages based on [puffer](https://github.com/puffer/puffer)

## Keyfeatures

* Full rails integration. Puffer_pages is part of rails and you can different features related to pages in rails application directly
* Flexibility. Puffer designed to be as flexible as possible, so you can create your own functionality easily.
* Layouts. You can use rails layouts for pages and you can use pages as action layouts!

## Installation

You can instal puffer as a gem:
<pre>gem install puffer_pages</pre>
Or in Gemfile:
<pre>gem "puffer_pages"</pre>

Did you install [puffer](https://github.com/puffer/puffer) properly?

Next step is:
<pre>rake puffer_pages_engine:install:migrations</pre>
This will install puffer_pages config file in your initializers, some css/js, controllers and migrations
<pre>rake db:migrate</pre>

To start working with admin interface, you need to add some routes like:
<pre>
namespace :admin do
  resources :pages
  resources :layouts
  resources :snippets
end
</pre>

## Introduction

The first thing, you should do - setup routes if you want pages path different from /(*path).
Just put in your routes.rb:
<pre>puffer_page "pages/(*path)" => 'whatever#show'</pre>
Default pages route you can see with rake routes.

Puffer_pages is radiant-like cms, so it has layouts, snippets and pages.
Puffer_pages use liquid as template language.

## Pages
Pages - tree-based structure of site.
Every page has one or more page parts.

## PageParts
Page_parts are the same as content_for block content in rails. You can insert current page page_patrs at layout.
Also, page_parts are inheritable. It means, that if root has page_part named `sidebar`, all its children will have the same page_part until this page_part will be redefined.
Every page part must have main page part, named by default `body`. You can configure main page part name in config/initializers/puffer_pages.rb

## Layouts
Layout is page canvas, so you can draw page parts on it.
You can use layouts from database or rails applcation layouts for pages.

### Rails application layouts
For application layout page_part body will be inserted instead of SUDDENLY! <%= yield %>
For yield with no parans specified puffer will use page part with default page_part name.

So, main page part is action view and other are partials. So easy.

## [Liquid](http://github.com/tobi/liquid/)

### Variables
This variables accessible from every page:

* self - current page reference.
<pre>{{ self.name }}</pre>
* root - root page reference.
<pre>{{ root.name }}</pre>
Both `self` and `root` are instances of page drop. View [this](https://github.com/puffer/puffer_pages/blob/master/lib/puffer_pages/liquid/page_drop.rb) to find list of possible page drop methods

### include
`include` is standart liquid tag with pudder data model 'file_system'

#### for page_parts
Use include tag for current page page_parts inclusion:
<pre>{% include 'page_part_name' %}</pre>

#### for snippets
To include snippet use this path form:
<pre>{% include 'snippets/snippet_name' %}</pre>

Usage example:
<pre>
  {% include 'sidebar' %} # this will render 'sidebar' page_part
  {% assign navigation = 'snippets/navigation' %}
  {% include navigation %} # this will render 'navigation' snippet
</pre>

### stylesheets, javascripts
<pre>{% stylesheets path [, path, path ...] %}</pre>
Both tags syntax is equal
Tags renders rail`s stylesheet_link_tag or javascript_include_tag.

Usage example:
<pre>
  {% assign ctrl = 'controls' %}
  {% javascripts 'prototype', ctrl %}
</pre>

