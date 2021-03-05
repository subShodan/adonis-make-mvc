---
to: app/Models/<%= h.changeCase.header(name) %>.js
fields: fields 
force: true
---
'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class <%= h.changeCase.header(name) %> extends Model {
}

module.exports = <%= h.changeCase.header(name)%>
