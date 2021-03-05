---
to: app/Controllers/Http/<%= h.changeCase.header(name) %>Controller.js
fields: fields 
force: true
---
'use strict'

let feilds_array = <%- JSON.stringify(fields) %>

const <%= h.changeCase.header(name) %> = use("App/Models/<%= h.changeCase.header(name) %>")
/** @typedef {import('@adonisjs/framework/src/Request')} Request */
/** @typedef {import('@adonisjs/framework/src/Response')} Response */
/** @typedef {import('@adonisjs/framework/src/View')} View */

/**
 * Resourceful controller for interacting with <%= h.inflection.pluralize(name) %>
 */
class <%= h.changeCase.header(name) %>Controller {
  /**
   * Show a list of all <%= h.inflection.pluralize(name) %>.
   * GET <%= h.inflection.pluralize(name) %>
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async index ({ request, response, view }) {

    //todo : get data from db
    let <%= h.inflection.pluralize(name) %> = await <%= h.changeCase.header(name) %>.all(); 
    return view.render('<%= name %>/grids/<%= name %>_grid',{<%= h.inflection.pluralize(name) %>:<%= h.inflection.pluralize(name) %>.toJSON()})
  }

  /**
   * Render a form to be used for creating a new <%= name %>.
   * GET <%= h.inflection.pluralize(name) %>/create
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async create ({ request, response, view }) {
    return view.render('<%= name %>/forms/<%= name %>_form')
  }

  /**
   * Create/save a new <%= name %>.
   * POST <%= h.inflection.pluralize(name) %>
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   */
  async store ({ request, response }) {
    const <%= name %>= new <%= h.changeCase.header(name) %>()
    const data =  request.only([<% JSON.parse(fields).forEach(function(feild){ %>
        "<%-  feild.name -%>",<% }); %>
    ])
    
    //todo :  handle data before save
    
    <% JSON.parse(fields).forEach(function(feild){ %>
    <%= name %>.<%-  feild.name %> = data.<%-  feild.name -%>
    <% }); %>

    await <%= name %>.save()
    
    response.redirect('/<%= h.inflection.pluralize(name) %>')
  
  }

  /**
   * Display a single <%= name %>.
   * GET <%= h.inflection.pluralize(name) %>/:id
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async show ({ params, request, response, view }) {
  }

  /**
   * Render a form to update an existing <%= name %>.
   * GET <%= h.inflection.pluralize(name) %>/:id/edit
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async edit ({ params, request, response, view }) {
    const <%= name %> =  await <%= h.changeCase.header(name) %>.findOrFail(params.id)
    return view.render('<%= name %>/forms/<%= name %>_form',{<%= name %>:<%= name %>.toJSON()})
  }

  /**
   * Update <%= name %> details.
   * PUT or PATCH <%= h.inflection.pluralize(name) %>/:id
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   */
  async update ({ params, request, response }) {
    
  }

  /**
   * Delete a <%= name %> with id.
   * DELETE <%= h.inflection.pluralize(name) %>/:id
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   */
  async destroy ({ params, request, response }) {
  }
}

module.exports = <%= h.changeCase.header(name) %>Controller


