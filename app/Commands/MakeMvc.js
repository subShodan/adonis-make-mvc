'use strict'
const util = require('util')
const exec = util.promisify(require('child_process').exec)
const fs = require('fs');
var inflection = require( 'inflection' );


const { Command } = require('@adonisjs/ace');
const ace = require('@adonisjs/ace');
const { dir } = require('console');

class MakeMvc extends Command {
  static get signature() {
    return `make:mvc { name: Name of the Model}`
  }

  static get description() {
    return 'Tell something helpful about this command'
  }


  stepAfterFileGenration(route_name) {
    console.log("Hymen finished");
    console.log("Please add this line to your app/start/routes.js")
    console.log("######################################")
    console.log(`Route.resource('${inflection.pluralize(route_name)}','${inflection.capitalize(route_name)}Controller')`)
    
    
  }

  getCreatedFiles(name, dirs) {
    let listFiles = []
    let dirList = dirs
    dirList.forEach(dir => {
      let files = fs.readdirSync(dir)

      files.forEach(file => {
        if (file.toLowerCase().includes(name)) {
          listFiles.push({ name: file, path: dir + '/' + file })
        }
      })

    })


    return listFiles;
  }


  async handle(args, options) {
    let fields_array = [];


    //Create Migration and Models

    const name_is_correct = await this.ask('The name of the table is ' + args.name + '[Y/N]')
    if (name_is_correct == 'y') {
      this.info('Awesome! Now enter the feilds one at a time. Enter "end" to move on the next step.')
      let end = false;
      while (!end) {
        let field_name = null
        while (!field_name) {
          console.log("field_name cannot be empty")
          field_name = await this.ask('Enter name')
        }
        end = field_name == ' ' ? true : false;
        if (end) continue
        let field_type = await this.choice('Field type', ["bigInteger",
          "string",
          "binary",
          "boolean",
          "date",
          "datetime",
          "decimal",
          "enu",
          "float",
          "increments",
          "integer",
          "json",
          "text",
          "time",
          "timestamp",
          "timestamps",
          "uuid"], "string"
        )



        let additionalOptions = await this.multiple('Additional Properties', [
          "after",
          "alter",
          "collate",
          "comment",
          "defaultTo",
          "first",
          "index",
          "inTable",
          "notNullable",
          "nullable",
          "primary",
          "references",
          "unique",
          "unsigned"
        ])
        fields_array.push({ name: field_name, type: field_type, addOptions: additionalOptions })

      }


      let dirs = ['./database/migrations', './app/Models', './app/Controllers/Http']
      let files = this.getCreatedFiles(args.name, dirs);
      for (const file of files) {
        await this.removeFile(file.path)
      }

      await this.removeDir(`./resources/views/${args.name}`)


      let hygen_fields = JSON.stringify(JSON.stringify(fields_array))
      console.log(hygen_fields)



      exec(`hygen controller_template new --name ${args.name} --fields ${hygen_fields}`, (error, stdout, stderr) => {
        console.log(`stdout: ${stdout}`);

        console.error(`stderr: ${stderr}`);

        if (error) {
          console.error(`exec error: ${error}`);
          return;
        }
        this.stepAfterFileGenration(args.name)
      })


    }


    else if (name_is_correct == 'n') {
      this.info('Enter table name')
      args.name = await this.ask('The name of the table is ')
      let end = false;
      while (!end) {
        let field_name = await this.ask('Enter name')
        end = field_name == ' ' ? true : false;
        if (end) continue
        let field_type = await this
          .choice('Field type', [
            'String', 'DateTime', 'Password'
          ])

        fields_array.push({ name: field_name, type: field_type })

      }

      await ace.call('make:migration', { name: args.name })

    }
    else {
      this.error("Invalid option");
      this.handle(args, options);
    }



  }
}

module.exports = MakeMvc
