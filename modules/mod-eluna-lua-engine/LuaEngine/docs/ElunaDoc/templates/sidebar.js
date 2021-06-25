document.write(`
{%- for method in current_class.methods %}
  <a id="{{ current_class.name + ':' + method.name }}" class="fn" href="{{ root(current_class.name + '/' + method.name + '.html') }}">{{ method.name }}</a>
{%- endfor %}
`);