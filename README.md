# DINA Ruby Gem

The [DINA Consortium][1] develops an open-source web-based information management system for natural history data that consists of several connected software components. At the core of the system is support for assembling, managing and sharing data associated with natural history collections and their curation ("collection management"). Target collections include zoological, botanical, geological and paleontological collections, living collections, biodiversity inventories, observation records, and molecular data.

This Ruby 3.1 gem abstracts the Keycloak configuration and JSON:API models for the DINA collection management system. It depends on the [json_api_client][5] where more documentation is available on how to create, update, query, and delete objects.

### Disclaimer

The DINA APIs for each of its components are under rapid development and so too is this gem. The intent of the latter is to be as closely aligned with the most recent versions of the former. As such, this gem makes use of the DINA APIs via their single, frontend gateway.

[![Gem Version][8]][9]
[![Continuous Integration Status][6]][7]

### Requirements & Dependencies

- ruby >= 3.1
- bundled dependencies: [json_api_client][5] (\~> 1.20), [keycloak][10] (\~> 3.2.1),

### Install

```bash
$ gem install dina
$ irb
> require 'dina'
```
### Configuration

All variables are **required**.

```ruby
Dina::Authentication.config({
   authorization_url: "http://localhost/auth",
   endpoint_url: "http://localhost/api",
   realm: "dina",
   client_id: "dina",
   user: "username",
   password: "password",
   server_name: "server",
   token_store_file: "config/token.json"
 })
```
Note the absence of trailing slashes in both config URLs.

The `authorization_url`, `realm`, `client_id`, `user`, and `password` are all used in the Keycloak authentication handshake. The `endpoint_url` is the single DINA API gateway. All of these are to be obtained from a DINA administrator and then kept secure. The `server_name` is a key used to reference the authentication token responses, stored and refreshed in your local `token_store_file` that you must make writable.

#### Create and Save a `Person`

```ruby
person = Dina::Person.new
person.givenNames = "Peter"
person.familyNames = "Pipetter"
person.email = "email@email.com"
person.save
=> true
```

Alternatively, use the `create` method:

```ruby
data = {
  givenNames: "Peter",
  familyNames: "pipetter",
  email: "email@email.com"
}
person = Dina::Person.create(data)
```

Note that a new object like `person` above sets and uses a default v4 UUID, which can be accessed as `person.id`.

#### Add an Identifier to a `Person`

```ruby
identifier = Dina::Identifier.new
identifier.namespace = "WIKIDATA"
identifier.value = "http://www.wikidata.org/entity/Q163373"
identifier.save
=> true

person.identifiers = [ identifier ]
person.save
=> true
```

Note that joined objects (like `identifier` above) must be saved before they can be attached as a related object (like `person` above).

#### Query for a `Person` by Email Address

```ruby
person = Dina::Person.find_by_email("email@email.com").first
person.attributes
=>
{"type"=>"person",                                                  
"id"=>"bf42616e-846c-4dbd-8372-bef44cdfa3e8",                      
"displayName"=>"Pipetter, Peter",                                  
"email"=>"email@email.com",                                        
"createdBy"=>"username",                                             
"createdOn"=>2022-11-25 17:23:09.262958 UTC,                       
"givenNames"=>"Peter",                                             
"familyNames"=>"Pipetter",                          
"aliases"=>nil,                                     
"webpage"=>nil,                                     
"remarks"=>nil,                                     
"identifiers"=>[]}
```

Note that unlike typical ActiveRecord methods, *find* or *find_by_\** methods return an array.

#### Delete a `Person`

```ruby
person = Dina::Person.find("bf42616e-846c-4dbd-8372-bef44cdfa3e8").first
person.destroy
=> true
```

#### Upload an Image `File` and its `ObjectStore` Metadata

```ruby
file = Dina::File.new
file.group = "DAOM"
file.file_path = "/my-directory/my-file.jpg"
file.save
=> true

metadata = Dina::ObjectStore.new
metadata.group = "DAOM"
metadata.dcType = "IMAGE"
metadata.fileExtension = ".jpg"
metadata.fileIdentifier = file.id
metadata.save
=> true
```

### Support

Bug reports can be filed at [https://github.com/dshorthouse/dina/issues][3].

### Copyright
Copyright © 2022 Government of Canada

Authors: [David P. Shorthouse][4]

### License

`dina` is released under the [MIT license][2].

[1]: https://dina-project.net/
[2]: http://www.opensource.org/licenses/MIT
[3]: https://github.com/dshorthouse/dina/issues
[4]: https://github.com/dshorthouse
[5]: https://github.com/JsonApiClient/json_api_client
[6]: https://github.com/dshorthouse/dina/actions/workflows/ruby.yml/badge.svg
[7]: https://github.com/dshorthouse/dina/actions
[8]: https://badgen.net/rubygems/v/dina/latest?cache=300
[9]: https://rubygems.org/gems/dina
[10]: https://github.com/imagov/keycloak
