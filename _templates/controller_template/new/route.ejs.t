---
sh: "echo //<%= h.inflection.pluralize(name) %> route >> ./start/routes.js && echo Route.resource('<%= h.inflection.pluralize(name) %>','<%= h.inflection.capitalize(name) %>Controller') >> ./start/routes.js"
---