---
to: ./resources/views/<%= (name) %>/grids/<%= (name) %>_grid.edge
fields: fields 
force: true
---

<h1>
    <%= h.changeCase.header(name) %> Table
</h1>

@each(<%= (name) %> in <%= h.inflection.pluralize(name) %>)
<div>
    <% JSON.parse(fields).forEach(feild => { %><li>{{ <%= (name) %>.<%= feild.name %> }} |
    </li>
    <% }) %>   
    <a href="/<%= h.inflection.pluralize(name) %>/{{ <%= (name) %>.id }}/edit">Edit</a> 
</div>
@endeach
