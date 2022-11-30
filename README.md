# DINA Ruby Gem

The [DINA Consortium][1] develops an open-source web-based information management system for natural history data that consists of several connected software components. At the core of the system is support for assembling, managing and sharing data associated with natural history collections and their curation ("collection management"). Target collections include zoological, botanical, geological and paleontological collections, living collections, biodiversity inventories, observation records, and molecular data.

This Ruby 3.1 gem abstracts the Keycloak configuration and JSON:API models for the DINA collection management system. It depends on the [json_api_client][5] where more documentation is available on how to create, update, query, and delete objects.

### Disclaimer

The DINA APIs for each of its components are under rapid development and so too is this gem. The intent of the latter is to be as closely aligned with the most recent versions of the former. As such, this gem makes use of the DINA APIs via its frontend reverse proxy.

[![Gem Version][8]][9]
[![Continuous Integration Status][6]][7]

### Install

```
  $ gem install dina
```
### Configuration

```
Dina::Authentication.config({
   authorization_url: "http://localhost/auth",
   endpoint_url: "http://localhost/api/",
   server_name: "server",
   realm: "dina",
   client_id: "dina",
   user: "username",
   password: "password",
   token_store_file: "config/token.json"
 })
```

#### Create and Save a `Person`

```
  person = Dina::Person.new
  person.givenNames = "Peter"
  person.familyNames = "Pipetter"
  person.email = "email@email.com"
  person.save
```

#### Query for a `Person` by Email Address

```
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

#### Destroy a `Person`

```
  person = Dina::Person.find("bf42616e-846c-4dbd-8372-bef44cdfa3e8").first
  person.destroy
```

#### Upload an Image `File` and its `ObjectStore` Metadata

```
  file = Dina::File.new
  file.group = "daom"
  file.file_path = "/my-directory/my-file.jpg"
  file.save

  metadata = Dina::ObjectStore.new
  metadata.group = "daom"
  metadata.dcType = "IMAGE"
  metadata.fileExtension = ".jpg"
  metadata.fileIdentifier = file.id
  metadata.save
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
