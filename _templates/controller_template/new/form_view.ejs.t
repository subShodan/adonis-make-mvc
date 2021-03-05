---
to: ./resources/views/<%= (name) %>/forms/<%= (name) %>_form.edge
fields: fields 
force: true
---

    
    @if(<%= (name) %>)
    <form action="/<%= h.inflection.pluralize(name) %>" method="PUT" >
    {{ csrfField() }}

    <% JSON.parse(fields).forEach(feild => { %>
        <div>
         <label><%= h.changeCase.header(name) %> <%= feild.name %> </label><br>
         <input name="<%= feild.name %>" value="{{<%= (name) %>.<%= feild.name %> }}">
        </div>
       <% }) %>   
    
    @else
    <form action="/<%= h.inflection.pluralize(name) %>" method="POST" >
    {{ csrfField() }}

    <% JSON.parse(fields).forEach(feild => { %>
        <div>
         <label><%= h.changeCase.header(name) %> <%= feild.name %> </label><br>
         <input name="<%= feild.name %>" value="Enter new <%= (name) %> <%= feild.name %>">
        </div>
    <% }) %>   
    
   @endif
  <input type="submit" value="Submit">
</form> 
  
  