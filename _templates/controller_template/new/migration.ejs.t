---
to: ./database/migrations/<%= Date.now() %>_<%=name %>_schema.js
fields: fields 
force: true
---

'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class <%= h.changeCase.header(name) %>Schema extends Schema {
  up () {
    this.create('<%= h.inflection.pluralize(name) %>', (table) => {
      table.increments()
      <% JSON.parse(fields).forEach(feild => { %>
      table.<%=feild.type%>("<%=feild.name%>") 
    <% }) %> 
      table.timestamps()
    })
  }

  down () {
    this.drop('<%= h.inflection.pluralize(name) %>')
  }
}

module.exports = <%= h.changeCase.header(name) %>Schema
