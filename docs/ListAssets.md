{% assign image_files = site.static_files | where: "image", true %}
{% for myimage in image_files %}
    # Images
  {{ myimage.path }}
  
  ----

  <img src="{{ myimage.path }}" />
{% endfor %}

Other Assets
---

{% assign files = site.static_files %}
{% for myfile in files %}
  [{{ myfile.path }}]({{ myfile.path }})  
{% endfor %}
